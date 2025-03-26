#!/bin/bash
# apt install inotify-tools
SOURCE_DIR="/storage/office"
DST_DIR="/storage/office_back"

# inotifywait -m -r -e create --format '%w%f' "$SOURCE_DIR" | while read NEW_FILE 
# do
#     if echo "$(basename "$NEW_FILE")" | grep -qi "SAVE"; then
#         rsync -a --relative "./$NEW_FILE#$SOURCE_DIR" "$DST_DIR"
#         echo "Copy file: $NEW_FILE"
#     fi
# done 
inotifywait -m -r -e create -e modify --format '%w%f' "$SOURCE_DIR" | while read NEW_FILE
do
    echo "File exsist: $NEW_FILE"
    
    rsync -av "$NEW_FILE" "$DEST_DIR/"
    
    dir=$(dirname "$NEW_FILE")
    rmdir "$dir" 2>/dev/null
done