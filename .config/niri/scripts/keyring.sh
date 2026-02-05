#!/bin/bash

# 1. Kill any zombie instances to prevent "discover_other_daemon" errors
killall -q gnome-keyring-daemon
rm -rf /run/user/$(id -u)/keyring

# 2. Start the daemon and explicitly capture the output
# We use a temp file to ensure we catch the variables correctly
eval $(gnome-keyring-daemon --start --components=secrets)

# 3. Verify variables are actually set before proceeding
if [ -z "$GNOME_KEYRING_CONTROL" ]; then
    # Fallback: Manually force the path if the daemon was lazy
    export GNOME_KEYRING_CONTROL="/run/user/$(id -u)/keyring"
    export SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"
fi

# 4. Export to the session so child processes (like Niri) see them
export GNOME_KEYRING_CONTROL
export SSH_AUTH_SOCK

# 5. Upload to DBus (Critical for Settings/Noctalia)
# We pass the values directly instead of relying on environment inheritance
dbus-update-activation-environment --systemd \
    GNOME_KEYRING_CONTROL="$GNOME_KEYRING_CONTROL" \
    SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
    DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=GNOME

# 6. Restart the Online Accounts daemon (if it exists)
# We check if the service file exists before trying to restart it to avoid the error
if systemctl --user list-unit-files | grep -q goa-daemon; then
    systemctl --user restart goa-daemon
else
    # If the service unit is missing, start the process manually in background
    /usr/lib/goa-daemon --replace &
fi
