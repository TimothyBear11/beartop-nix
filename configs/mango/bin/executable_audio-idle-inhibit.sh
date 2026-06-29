#!/bin/bash
# Audio Idle Inhibitor for Mango/Hyprland
# Prevents screen sleep when audio is playing or being recorded
# Uses PipeWire's pw-dump to monitor audio/video streams

INHIBIT_PID=""
INHIBIT_ACTIVE=0

cleanup() {
    if [ -n "$INHIBIT_PID" ]; then
        kill "$INHIBIT_PID" 2>/dev/null
    fi
    exit 0
}

trap cleanup EXIT

# Function to check if any audio/video stream is active (not idle/suspended)
check_audio_playing() {
    # Get the number of active audio/video streams
    # Includes: Stream/Output/Audio (playback), Stream/Input/Audio (recording)
    local active_streams
    active_streams=$(pw-dump 2>/dev/null | jq -r '[
        .[] | select(
            .type == "PipeWire:Interface:Node" and
            .info.state == "running" and
            (
                .info.props["media.class"] == "Stream/Output/Audio" or
                .info.props["media.class"] == "Stream/Input/Audio" or
                .info.props["media.class"] == "Stream/Input/Video"
            )
        )
    ] | length')

    if [ "$active_streams" -gt 0 ]; then
        return 0  # Audio/video is active
    else
        return 1  # No audio/video activity
    fi
}

# Alternative check using pw-cli if jq is not available
check_audio_playing_alt() {
    # Get all running nodes and check their media class
    local output
    output=$(pw-cli ls Node 2>/dev/null)

    # Check if any running node is an audio/video stream
    # Parse the output to find running streams
    echo "$output" | awk '
        /id: [0-9]+/ { id=$2 }
        /state: running/ { state=1 }
        /media.class: "Stream\/Output\/Audio"/ { if(state) exit 0 }
        /media.class: "Stream\/Input\/Audio"/ { if(state) exit 0 }
        /media.class: "Stream\/Input\/Video"/ { if(state) exit 0 }
        /^$/ { state=0 }
        END { exit 1 }
    '

    return $?
}

# Debug function - logs what streams are detected (uncomment for debugging)
# debug_streams() {
#     pw-dump 2>/dev/null | jq -r '.[] | select(.type == "PipeWire:Interface:Node" and .info.state == "running") | "\(.info.props["media.class"]): \(.info.props["node.name"])"' 2>/dev/null
# }

# Main loop
while true; do
    if check_audio_playing || check_audio_playing_alt; then
        if [ "$INHIBIT_ACTIVE" -eq 0 ]; then
            # Audio started - activate inhibit
            systemd-inhibit --what=idle --who="audio-idle-inhibit" --why="Audio/Video is active" sleep infinity &
            INHIBIT_PID=$!
            INHIBIT_ACTIVE=1
            echo "[audio-inhibit] Audio/Video detected - preventing idle (PID: $INHIBIT_PID)"
            # debug_streams
        fi
    else
        if [ "$INHIBIT_ACTIVE" -eq 1 ]; then
            # Audio stopped - release inhibit
            kill "$INHIBIT_PID" 2>/dev/null
            wait "$INHIBIT_PID" 2>/dev/null
            INHIBIT_PID=""
            INHIBIT_ACTIVE=0
            echo "[audio-inhibit] No audio/video - allowing idle"
        fi
    fi

    # Check every 2 seconds
    sleep 2
done
