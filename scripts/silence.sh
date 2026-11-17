#!/bin/bash
# Add two seconds of silence to each MP3 in the current directory.

shopt -s nullglob
name_max=$(getconf NAME_MAX .) || exit 1
status=0

for file in *.mp3; do
    # Filename limits are measured in bytes, not characters.
    if (( $(LC_ALL=C printf '%s' "X$file" | wc -c) > name_max )); then
        if ! mkdir -p -- silence-output; then
            status=1
            continue
        fi
        output="silence-output/$file"
    else
        output="X$file"
    fi

    # Prefix paths with ./ so filenames starting with '-' are not options.
    if ! ffmpeg -nostdin -n -i "./$file" -af "adelay=2s:all=true" "./$output"; then
        status=1
    fi
done

exit "$status"
