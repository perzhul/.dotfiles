#!/bin/bash

# Define the source directory containing the scripts.
SCRIPTS_DIR="/Users/danil/.dotfiles/bin/local/scripts"


# Destination directory for the symbolic links.
LINK_DEST="/usr/local/bin"

# Check if the SCRIPTS_DIR exists to prevent errors.
if [[ ! -d "$SCRIPTS_DIR" ]]; then
  echo "Error: The specified scripts directory does not exist: $SCRIPTS_DIR"
  exit 1
fi

# Iterate over each file in the scripts directory.
find "$SCRIPTS_DIR" -type f -print0 | while IFS= read -r -d $'\0' script; do
  # Extract the basename of the script.
  script_name=$(basename "$script")

  # Construct the full path to the intended symbolic link.
  link_path="$LINK_DEST/$script_name"

  # Check if a link or file already exists at the target location.
  if [[ -e "$link_path" ]]; then
    echo "Skipping $script_name: link or file already exists in $LINK_DEST."
  else
    # Attempt to create the symbolic link and report success or failure.
    if ln -s "$script" "$link_path"; then
      echo "Successfully linked $script_name to $LINK_DEST."
    else
      echo "Failed to link $script_name to $LINK_DEST. Check permissions or existing links."
    fi
  fi
done

# End of script.

