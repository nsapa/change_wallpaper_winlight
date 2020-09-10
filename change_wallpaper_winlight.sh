#!/bin/bash
set -e

## Variables
IMAGE_DIR="/home/nico/Images/WinLight/"
WANTED_RESOL="1920x1080" #or 1080x1920
WANTED_EXT="jpg"
VALID_RESOLUTION=0
LOOP_COUNTER=0

## Code

# Create a listing of every image in ${IMAGE_DIR}
TMP_LIST=$(mktemp)
find "${IMAGE_DIR}" -type f -iname "*.${WANTED_EXT}" > ${TMP_LIST}

while [ $VALID_RESOLUTION -eq 0 ]; do
    # Increment the loop counter
    LOOP_COUNTER=$(( LOOP_COUNTER + 1 ))

    # Shuffle the listing and get one file name
    CANDIDATE_FILE=$(shuf -n 1 < ${TMP_LIST})

    # What is the resolution of the file?
    CANDIDATE_RESOL=$(convert "${CANDIDATE_FILE}" -print "Size: %wx%h\n" /dev/null |cut -f2 -d:)

    # Is it the right resolution?
    if [ ${WANTED_RESOL} == ${CANDIDATE_RESOL} ]; then
        # Exit the loop
        VALID_RESOLUTION=1;
    fi
done

# Change the wallpaper
gsettings set org.mate.background picture-filename "${CANDIDATE_FILE}"

# Log the change
logger -p info -t ${0} "After ${LOOP_COUNTER} loop, we changed the wallpaper to ${CANDIDATE_FILE}"

# Remove the temp file
rm ${TMP_LIST}
