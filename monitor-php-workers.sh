#!/usr/bin/env bash
#
# Description:
# Monitors PHP worker load and analyzes multiple logs in real time.
# - Parses access.log to detect high-frequency dynamic endpoints (admin-ajax, WooCommerce AJAX,
#   REST API, wishlist, cart, checkout) over the last 500 requests.
# - Reads php-fpm-error.log for new max_children warnings to detect worker saturation.
# - Reads slow.log to show the latest slow PHP executions and stack traces.
# - Shows system CPU / RAM / Disk I/O with human-readable explanations.
# Ideal for continuous monitoring with `watch`, helping identify bottlenecks, overloaded pools,
# and expensive dynamic requests.
#
# Usage:
# chmod +x monitor-php-workers.sh
# ./monitor-php-workers.sh
# or for continuous monitoring:
# watch -n 60 ./monitor-php-workers.sh

###############################################
#  CONFIGURATION
###############################################

LOG_DIR="$HOME/logs"
ACCESS_LOG="$LOG_DIR/access.log"
PHP_FPM_ERROR_LOG="$LOG_DIR/php8.4-fpm-error.log"
SLOW_LOG="$LOG_DIR/slow.log"
PHP_FPM_CONF_DIR="$HOME/.php-fpm"

###############################################
#  SAFE COUNTER FUNCTION
###############################################
safe_count() {
  local pattern="$1"
  local file="$2"

  if [ ! -f "$file" ]; then
    echo 0
    return
  fi

  tail -500 "$file" | grep -c "$pattern"
}

###############################################
#  AUTO-DETECT TOTAL PHP WORKERS
###############################################
detect_workers() {
  if [ -d "$PHP_FPM_CONF_DIR" ]; then
    local total
    total=$(grep -R "pm.max_children" "$PHP_FPM_CONF_DIR" 2>/dev/null | awk '{sum+=$3} END {print sum}')

    if [ -n "$total" ]; then
      echo "$total"
      return
    fi
  fi

  # fallback – assume 10 workers if unknown
  echo 10
}

###############################################
#  RETURN STATUS LABEL BASED ON THRESHOLDS
###############################################
status_label() {
  local value="$1"
  local warn="$2"
  local crit="$3"

  if [ "$value" -ge "$crit" ]; then
    echo "[CRITICAL]"
  elif [ "$value" -ge "$warn" ]; then
    echo "[WARNING]"
  else
    echo "[OK]"
  fi
}

###############################################
#  HEADER (Time & Worker Count)
###############################################
echo "=== TIME ==="
date
echo

TOTAL_WORKERS=$(detect_workers)
WARN=$(( TOTAL_WORKERS * 4 ))
CRIT=$(( TOTAL_WORKERS * 8 ))

echo "Detected PHP Workers: $TOTAL_WORKERS"
echo "WARN threshold: $WARN | CRIT threshold: $CRIT"
echo

###############################################
#  LOAD ANALYSIS OF LAST 500 REQUESTS
###############################################
echo "=== LOAD INDICATORS (dynamic from last 500 requests) ==="

if [ -f "$ACCESS_LOG" ]; then
  tail -500 "$ACCESS_LOG" \
    | awk '{print $7}' \
    | grep -E "wp-admin/admin-ajax|wc-ajax|wp-json|cart|checkout" \
    | sed "s/\?.*//" \
    | sort \
    | uniq -c \
    | sort -nr \
    | awk -v warn="$WARN" -v crit="$CRIT" '
        {
          count = $1;
          # rebuild URL from remaining fields (in case there are spaces)
          $1 = "";
          sub(/^ +/, "", $0);
          url = $0;

          status = "[OK]";
          if (count >= crit)      status = "[CRITICAL]";
          else if (count >= warn) status = "[WARNING]";

          printf "%-45s %6d  %s\n", url, count, status;
        }
      '
else
  echo "Access log not found: $ACCESS_LOG"
fi

###############################################
#  PHP-FPM MAX_CHILDREN WARNINGS
###############################################
echo
echo "=== PHP-FPM max_children (last 10) ==="
if [ -f "$PHP_FPM_ERROR_LOG" ]; then
  tail -10 "$PHP_FPM_ERROR_LOG" | grep max_children || echo "No new max_children"
else
  echo "PHP-FPM error log not found: $PHP_FPM_ERROR_LOG"
fi

###############################################
#  TOP REST API ENDPOINTS
###############################################
echo
echo "=== TOP REST API endpoints (auto-detected) ==="

if [ -f "$ACCESS_LOG" ]; then
  tail -500 "$ACCESS_LOG" \
    | grep "/wp-json" \
    | awk '{print $7}' \
    | sed "s/\?.*//" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -20 \
    | awk -v warn="$WARN" -v crit="$CRIT" '
        {
          count = $1;
          # rebuild URL from remaining fields
          $1 = "";
          sub(/^ +/, "", $0);
          url = $0;

          status = "[OK]";
          if (count >= crit)      status = "[CRITICAL]";
          else if (count >= warn) status = "[WARNING]";

          printf "%-45s %6d  %s\n", url, count, status;
        }
      '
else
  echo "Access log not found: $ACCESS_LOG"
fi

###############################################
#  SHOW LAST 5 SLOW LOG ENTRIES
###############################################
echo
echo "=== SLOW LOG (newest 5 entries) ==="
if [ -f "$SLOW_LOG" ]; then
  tail -5 "$SLOW_LOG"
else
  echo "Slow log not found: $SLOW_LOG"
fi

###############################################
#  SYSTEM RESOURCE STATS (CPU / RAM / I/O)
###############################################
echo
echo "=== SYSTEM RESOURCE STATS (CPU / RAM / I/O) ==="

# Load averages
if command -v uptime >/dev/null 2>&1; then
  LOAD=$(uptime | awk -F'load average:' '{print $2}' | sed 's/^ //')
  echo "Load average (1 / 5 / 15 min): $LOAD"
  echo "  → Rule of thumb: keep each value below the number of CPU cores."
fi

# CPU line from top (locale may use commas for decimals)
if command -v top >/dev/null 2>&1; then
  CPU_LINE=$(COLUMNS=512 top -bn1 | grep -m1 "%Cpu")
  echo "CPU line: $CPU_LINE"
  echo

  # Normalize decimal commas to dots for parsing
  CPU_CLEAN=$(echo "$CPU_LINE" | sed 's/,/./g')

  # Tokens after normalization look like:
  # %Cpu(s):  4.1 us,  1.2 sy,  0.0 ni, 94.3 id,  0.0 wa,  0.0 hi,  0.4 si,  0.0 st
  # Numeric positions: 2(us),4(sy),6(ni),8(id),10(wa),12(hi),14(si),16(st)
  US=$(echo  "$CPU_CLEAN" | awk '{print $2}')
  SY=$(echo  "$CPU_CLEAN" | awk '{print $4}')
  NI=$(echo  "$CPU_CLEAN" | awk '{print $6}')
  IDLE=$(echo "$CPU_CLEAN" | awk '{print $8}')
  WA=$(echo   "$CPU_CLEAN" | awk '{print $10}')
  HI=$(echo   "$CPU_CLEAN" | awk '{print $12}')
  SI=$(echo   "$CPU_CLEAN" | awk '{print $14}')
  ST=$(echo   "$CPU_CLEAN" | awk '{print $16}')

  echo "CPU usage breakdown (human readable):"
  echo "  us ($US%): User space — WordPress/PHP/WooCommerce/MySQL queries (your actual app load)."
  echo "  sy ($SY%): System — Linux kernel work (networking, disk, drivers, system calls)."
  echo "  ni ($NI%): Niceness — Tasks with adjusted priority. Usually near 0%."
  echo "  id ($IDLE%): Idle — Free CPU time. HIGH is good. Low (<10%) can mean CPU bottleneck."
  echo "  wa ($WA%): I/O wait — CPU waiting for disk. High (>10%) = disk/DB/storage bottleneck."
  echo "  hi ($HI%): Hardware interrupts — NIC/storage interrupts. High = hardware/network card stress."
  echo "  si ($SI%): Software interrupts — Often network stack (soft IRQs). High = too many packets/connections."
  echo "  st ($ST%): Steal time — CPU stolen by hypervisor (other VPS). Should be ~0%. High (>5%) = noisy neighbors/oversold host."
else
  echo "CPU stats: 'top' command not available."
fi

###############################################
#  MEMORY USAGE
###############################################
if command -v free >/dev/null 2>&1; then
  echo
  MEM_LINE=$(free -m | awk '/Mem:/ {printf "%s %s %s", $2,$3,$4}')
  TOTAL_MEM=$(echo "$MEM_LINE" | awk '{print $1}')
  USED_MEM=$(echo  "$MEM_LINE" | awk '{print $2}')
  FREE_MEM=$(echo  "$MEM_LINE" | awk '{print $3}')
  PCT=$(( USED_MEM * 100 / TOTAL_MEM ))

  echo "Memory usage:"
  echo "  Used: ${USED_MEM} MB / ${TOTAL_MEM} MB (${PCT}%)"
  echo "  → If this stays consistently above ~80%, the server may start swapping and slow down."
else
  echo
  echo "Memory stats: 'free' command not available."
fi

###############################################
#  DISK I/O (vmstat)
###############################################
if command -v vmstat >/dev/null 2>&1; then
  echo
  echo "--- I/O (vmstat 1 2, last sample) ---"
  VM_LINE=$(vmstat 1 2 | tail -1)
  BI=$(echo "$VM_LINE" | awk '{print $9}')
  BO=$(echo "$VM_LINE" | awk '{print $10}')
  echo "  IO: bi=$BI bo=$BO (blocks in/out per second)"
  echo "  → bi: reads from disk, bo: writes to disk."
  echo "    Very high bi/bo together with high 'wa%' can indicate disk/DB bottlenecks."
else
  echo
  echo "Disk I/O stats: 'vmstat' not available."
fi
