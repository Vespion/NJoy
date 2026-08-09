#!/bin/bash

# Define the path to the FIFO
FIFO="./srv.stdin"

# --- SOCKET SETUP ---
# Since we are already running as the 'minecraft' user, no chown is needed.
rm -f "$FIFO"
mkfifo "$FIFO"
chmod 0600 "$FIFO"

# Open the FIFO on file descriptor 3 for reading AND writing.
# This keeps the pipe open so EOF isn't sent to run.sh prematurely.
exec 3<> "$FIFO"

# --- SERVICE EXECUTION ---
# Determine the directory this script lives in and execute run.sh from it.
# We pipe standard input from our open FIFO (<&3).
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

"${SCRIPT_DIR}/run.sh" <&3 &
    
APP_PID=$!

# --- GRACEFUL SHUTDOWN ---
# Trap SIGTERM (sent by `docker stop`) and SIGINT.
# When Docker asks the container to stop, we echo "stop" into the FIFO.
trap 'echo stop >&3' TERM INT

# The first `wait` command pauses the script. If SIGTERM is received, the trap fires and interrupts this wait.
wait $APP_PID

# The second `wait` ensures the container does not exit until run.sh has finished cleanly.
wait $APP_PID

# --- CLEANUP ---
exec 3>&-
rm -f "$FIFO"