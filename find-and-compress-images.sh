#!/bin/bash
#
# Description:
# Find and compress large images in a directory.
#
# Usage:
#   ./find-and-compress-images.sh <directory> <size> [jpeg_quality]
#
# Examples:
#   ./find-and-compress-images.sh /path/to/dir 50k
#   ./find-and-compress-images.sh /path/to/dir 50k 80
#
# Notes:
#   - <size> like 50k, 1M (GNU find units)
#   - Processes JPG/JPEG/PNG
#   - Excludes WP thumbnails (*-123x456.ext)

# Exit the script if anything goes wrong, use only defined variables, and don’t ignore pipeline errors.
set -euo pipefail

# If the user doesn't pass at least two arguments (<directory> and <size>), print a usage message and stop.
if [ $# -lt 2 ]; then
  echo "Usage: $0 <directory> <size> [jpeg_quality]"
  exit 1
fi

DIR="$1"
SIZE="$2"
QUALITY="${3:-}"   # optional 0–100

# If looks like a WP root, drill into uploads
if [ -d "$DIR/wp-content/uploads" ]; then
  DIR="$DIR/wp-content/uploads"
fi

if [ ! -d "$DIR" ]; then
  echo "Error: Directory not found: $DIR"
  exit 1
fi

# ---------- helpers (pure bash) ----------
human() {
  # Prefer numfmt if available; otherwise print raw bytes
  if command -v numfmt >/dev/null 2>&1; then
  # Use IEC (binary) units (KiB, MiB, GiB) rather than decimal (kB, MB, GB).
  # Add a B after the unit (e.g. 1.0MiB instead of 1.0Mi).
  # Show one decimal place (e.g. 1.5MiB).
  # The first argument passed to the function — the byte value.  
    numfmt --to=iec --suffix=B --format="%.1f" "$1"
  else
    printf "%sB" "$1"
  fi
}

is_jpeg() {
  case "$1" in
    *.jpg|*.JPG|*.jpeg|*.JPEG) return 0;;
    *) return 1;;
  esac
}

is_png() {
  case "$1" in
    *.png|*.PNG) return 0;;
    *) return 1;;
  esac
}

is_wp_thumb() {
  # match *-123x456.*
  local bn="${1##*/}"
  case "$bn" in
    *-[0-9]*x[0-9]*.*) return 0;;
    *) return 1;;
  esac
}

sum_bytes_from_list() {
  # stdin: NUL-separated paths; echo total bytes
  local total=0
  local f
  while IFS= read -r -d '' f; do
    # stat -c %s is GNU; on BSD/mac use stat -f%z (adjust if needed)
    if sz=$(stat -c '%s' "$f" 2>/dev/null); then
      total=$(( total + sz ))
    fi
  done
  echo "$total"
}

# ---------- build the file list BEFORE compression ----------
filelist="$(mktemp)"
# Collect only JPG/JPEG/PNG, larger than SIZE, excluding WP thumbs
# We avoid grep/sed by testing patterns later; first collect candidates by size.
find "$DIR" -type f -size +"$SIZE" -print0 > "$filelist"

echo "Searching for images larger than $SIZE in: $DIR"
echo "--------------------------------------------------"

# Print and simultaneously count only the wanted extensions, excluding WP thumbs
count=0
# also write the exact set to another list (the one we’ll measure before & after)
exact_list="$(mktemp)"
while IFS= read -r -d '' p; do
  # extension filter
  if ! is_jpeg "$p" && ! is_png "$p"; then
    continue
  fi
  # exclude WP thumbs
  if is_wp_thumb "$p"; then
    continue
  fi
  printf '%s\n' "$p"
  count=$((count+1))
  printf '%s\0' "$p" >> "$exact_list"
done < "$filelist"

echo "--------------------------------------------------"
echo "Total large images found: $count"

# Sum BEFORE using the exact list
bytes_before="$(sum_bytes_from_list < "$exact_list")"
echo "Total size before: $(human "$bytes_before")"

# stop here if no quality provided
if [ -z "$QUALITY" ]; then
  rm -f "$filelist" "$exact_list"
  exit 0
fi

# validate quality is 0–100 (integer)
case "$QUALITY" in
  ''|*[!0-9]*)
    echo "Error: jpeg_quality must be an integer 0–100 (got: $QUALITY)"; rm -f "$filelist" "$exact_list"; exit 1;;
esac
if [ "$QUALITY" -lt 0 ] || [ "$QUALITY" -gt 100 ]; then
  echo "Error: jpeg_quality must be 0–100"; rm -f "$filelist" "$exact_list"; exit 1
fi

read -p "Do you want to compress these images? (y/n): " CONFIRM
case "$CONFIRM" in
  y|Y) ;;
  *) echo "Compression skipped."; rm -f "$filelist" "$exact_list"; exit 0;;
esac

# tool checks
have_jpegoptim=true
have_pngquant=true
command -v jpegoptim >/dev/null 2>&1 || { echo "Warning: jpegoptim not found; JPEGs will not be compressed."; have_jpegoptim=false; }
command -v pngquant  >/dev/null 2>&1 || { echo "Warning: pngquant not found; PNGs will not be compressed.";  have_pngquant=false; }

echo "--------------------------------------------------"
echo "Compressing JPEG images with jpegoptim (max quality: $QUALITY)..."
if $have_jpegoptim; then
  # loop files from the exact set; run jpegoptim per-file (keeps it pure bash, no xargs)
  while IFS= read -r -d '' f; do
    if is_jpeg "$f"; then
      jpegoptim --max="$QUALITY" --strip-all "$f" || true
    fi
  done < "$exact_list"
fi

echo "Compressing PNG images with pngquant (quality: 65–80)..."
if $have_pngquant; then
  while IFS= read -r -d '' f; do
    if is_png "$f"; then
      pngquant --quality=65-80 --ext .png --force "$f" || true
    fi
  done < "$exact_list"
fi

# Re-sum AFTER for the SAME files
bytes_after="$(sum_bytes_from_list < "$exact_list")"

echo "--------------------------------------------------"
echo "Total size before:  $(human "$bytes_before")"
echo "Total size after*:  $(human "$bytes_after")"
# compute saved (integer math)
if [ "$bytes_before" -ge "$bytes_after" ]; then
  saved=$(( bytes_before - bytes_after ))
else
  saved=0
fi
echo "Space saved:        $(human "$saved")"

# Optional: show entire folder size like file manager (if du exists)
if command -v du >/dev/null 2>&1; then
  # -sb is GNU; on mac/BSD use: du -sk "$DIR" | awk '{print $1*1024}'
  foldersz="$(du -sb "$DIR" 2>/dev/null | { read -r b _; echo "${b:-0}"; })"
  if [ -n "$foldersz" ]; then
    echo "Folder size now:    $(human "$foldersz")"
  fi
fi

rm -f "$filelist" "$exact_list"
echo
echo "Compression complete!"
