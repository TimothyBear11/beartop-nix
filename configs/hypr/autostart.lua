-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    -- Critical System Services
    hl.exec_cmd("export XDG_CURRENT_DESKTOP=Hyprland && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") 
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("gnome-keyring-daemon --start --components=pkcs11,secrets,ssh")
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- Theme & Aesthetic (Marchborn Guardian Cursor)
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")

    -- Dynamic Visual Desktop Shell Handoff
    -- Reads the tracking state file updated by your 'shell-switch' script
    local file_path = os.getenv("HOME") .. "/.config/hypr/.active_shell"
    local file = io.open(file_path, "r")
    local active_shell = "noctalia" -- Default fallback string

    if file then
        active_shell = file:read("*l") -- Read the first line
        file:close()
        -- Clean up any hidden stray trailing or leading whitespaces
        active_shell = active_shell:gsub("%s+", "")
    end

    -- Boot the chosen shell matching your tracking index keys
    if active_shell == "ambxst" then
        hl.exec_cmd("ambxst")
    elseif active_shell == "caelestia" then
        hl.exec_cmd("caelestia-shell -d")
    elseif active_shell == "dms" then
        hl.exec_cmd("dms run")
    elseif active_shell == "wayle" then
        hl.exec_cmd("wayle shell & sleep 1 && wayle panel start")
    elseif active_shell == "noctalia" then
        hl.exec_cmd("noctalia-shell")
    elseif active_shell == "noctaliav5" then
        -- Added the Noctaliav5 entry
        hl.exec_cmd("noctalia") 
    else
        hl.exec_cmd("noctalia-shell")
    end
    
    -- Launch Pyprland daemon
    hl.exec_cmd("pypr")
end)
