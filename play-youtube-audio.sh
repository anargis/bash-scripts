#!/bin/bash
#
# Streams the best audio from a YouTube video directly using mplayer.
# Pass a full YouTube URL or a video ID as the first argument.
#
# Usage:
#   chmod +x play-youtube-audio.sh
#   ./play-youtube-audio.sh <VIDEO_URL or VIDEO_ID>
#
# echo "$1" | sed -n 's/.*v=\([^&]*\).*/https:\/\/www.youtube.com\/watch?v=\1/p'
#   - echo "$1"
#         Prints the first argument passed (could be full URL or just video ID)
#   - sed -n 's/.*v=\([^&]*\).*/https:\/\/www.youtube.com\/watch?v=\1/p'
#         Extracts video ID from URL using regex and rebuilds a clean YouTube URL
#           s/.../.../p: Substitution command that matches pattern and prints result
#           \([^&]*\): Captures all characters after 'v=' up to next '&' or end
#
# yt-dlp -f bestaudio -g "<URL>"
#   - yt-dlp
#         Command-line tool to interact with YouTube (successor to youtube-dl)
#   - -f bestaudio
#         Selects the best audio-only format available
#   - -g
#         Outputs the direct URL to the audio stream instead of downloading it
#
# mplayer "$( ... )"
#   - mplayer
#         Terminal media player capable of playing media from URLs
#   - "$( ... )"
#         Runs the yt-dlp command inside subshell and passes the resulting URL to mplayer
#
# -ao alsa
#   - Audio output forced through ALSA (Advanced Linux Sound Architecture) system
#
# -af "volume=0.5"
#   - Applies an audio filter reducing volume to 50% of original (linear scale)
#     (You can adjust this to e.g., volume=-10 to reduce by 10 decibels)
#
# -cache 8192
#   - Allocates 8192 KB (8 MB) buffer cache for streaming to smooth playback
#
# -cache-min 10
#   - Starts playback after 10% of the cache is filled to reduce buffering pauses
#
# 2>/dev/null
#   - Redirects error output to /dev/null to keep the terminal output clean

mplayer "$(yt-dlp -f bestaudio -g "$(echo "$1" | sed -n 's/.*v=\([^&]*\).*/https:\/\/www.youtube.com\/watch?v=\1/p')")" -ao alsa -af "volume=0.5" -cache 8192 -cache-min 10 2>/dev/null
