#!/bin/bash

# Check if the log directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <log-directory>"
  exit 1
fi

log_directory="$1"

# Check if the log directory exists
if [ ! -d "$log_directory" ]; then
  echo "Error: Log directory '$log_directory' does not exist."
  exit 1
fi

# Create the archive directory if it doesn't exist
archive_directory="log_archives"
mkdir -p "$archive_directory"

# Generate the timestamp for the archive filename and log entry
timestamp=$(date +%Y%m%d_%H%M%S)
archive_filename="logs_archive_${timestamp}.tar.gz"
archive_path="$archive_directory/$archive_filename"
log_file="archive_log.txt"

# Compress the logs
echo "Compressing logs from '$log_directory'..."
tar -czvf "$archive_path" -C "$log_directory" .
if [ $? -eq 0 ]; then
  echo "Logs compressed successfully to '$archive_path'."

  # Log the archive information
  echo "$(date) - Archived logs to '$archive_path'" >> "$log_file"
  echo "Archive information logged to '$log_file'."
else
  echo "Error: Failed to compress logs."
fi

exit 0
