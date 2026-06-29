-------------------
--- KEYBINDINGS ---
-------------------
local fileManager = "dolphin"

-- 1. NOCTALIA IPC BINDINGS
local noct = "noctalia-shell ipc call"
local noctLauncher = noct .. " launcher toggle"
local noctCC = noct .. " controlCenter toggle"
local noctSettings = noct .. " settings toggle"
local noctClip = noct .. " launcher clipboard"
local noctSession = noct .. " sessionMenu toggle"


-- 2. NOCTALIA v5 (C++) IPC BINDINGS
-- Note: v5 uses the new 'noctalia msg' syntax
local noct5 = "noctalia msg toggle"
local noct5Launcher = noct5 .. " launcher"
local noct5CC = noct5 .. " controlCenter"
local noct5Settings = noct5 .. " settings"
local noct5Clip = noct5 .. " clipboard"
local noct5Session = noct5 .. " sessionMenu"
-- 3. CAELESTIA IPC BINDINGS (Now with escaped string arguments for Quickshell)
local cael = "caelestia shell"
local caelLauncher = cael .. " drawers toggle 'launcher'"
local caelCC = cael .. " drawers toggle 'cc'"
local caelSettings = cael .. " drawers toggle 'settings'"
local caelClip = cael .. " picker openClip"
local caelSession = cael .. " drawers toggle 'session'"

-- 4. DMS IPC BINDINGS
local dms = "dms ipc call"
local dmsLauncher = dms .. " launcher toggle"
local dmsCC = dms .. " control-center toggle"
local dmsSettings = dms .. " settings toggle"
local dmsClip = dms .. " clipboard toggle"
local dmsSession = dms .. " powermenu toggle"


-- Combined Universal Macro Command Pipelines
local toggleLauncher = string.format("%s ; %s ; %s ; %s", noctLauncher, noct5Launcher, caelLauncher, dmsLauncher)
local toggleCC = string.format("%s ; %s ; %s ; %s", noctCC, noct5CC, caelCC, dmsCC)
local toggleSettings = string.format("%s ; %s ; %s ; %s", noctSettings, noct5Settings, caelSettings, dmsSettings)
local toggleClip = string.format("%s ; %s ; %s ; %s", noctClip, noct5Clip, caelClip, dmsClip)
local toggleSession = string.format("%s ; %s ; %s ; %s", noctSession, noct5Session, caelSession, dmsSession)

local mainMod = "SUPER"
local shellMod = "SUPER + ALT"
local mediaMod = "CTRL + ALT"

-- Basic commands
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("pypr toggle ollama"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("kate"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("positron"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd("joplin"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("floorp"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zeditor"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))


-- Core Shell Switcher hotkeys (Invoking our global fish helper)
hl.bind(shellMod .. " + A", hl.dsp.exec_cmd("fish --login -c 'shell-switch ambxst'"))
hl.bind(shellMod .. " + C", hl.dsp.exec_cmd("fish --login -c 'shell-switch caelestia'"))
hl.bind(shellMod .. " + D", hl.dsp.exec_cmd("fish --login -c 'shell-switch dms'"))
hl.bind(shellMod .. " + N", hl.dsp.exec_cmd("fish --login -c 'shell-switch noctalia'"))
hl.bind(shellMod .. " + V", hl.dsp.exec_cmd("fish --login -c 'shell-switch noctaliav5'"))
hl.bind(shellMod .. " + W", hl.dsp.exec_cmd("pkill wayle && wayle panel start"))

hl.bind(shellMod .. " + S", hl.dsp.exec_cmd("fish /home/tbear/nix/configs/fish/functions/shell-switcher.fish"))

-- Clean, Explicit Functional Layout Overlaps
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(toggleLauncher)) -- App Launcher
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(toggleCC)) -- Control Center Panel
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(toggleSettings)) -- System Configuration Settings
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd(toggleClip)) -- Clipboard History Panel
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd(toggleSession)) -- Power/Session Menu

hl.bind(mediaMod .. " + Up", hl.dsp.exec_cmd("fish --login -c 'music-play'"))
hl.bind(mediaMod .. " + Down", hl.dsp.exec_cmd("fish --login -c 'music-pause'"))
hl.bind(mediaMod .. " + Left", hl.dsp.exec_cmd("fish --login -c 'music-prev'"))
hl.bind(mediaMod .. " + Right", hl.dsp.exec_cmd("fish --login -c 'music-next'"))
hl.bind(mediaMod .. " + H", hl.dsp.exec_cmd("fish --login -c 'play hurt'"))
hl.bind(mediaMod .. " + R", hl.dsp.exec_cmd("fish --login -c 'play relax'"))
hl.bind(mediaMod .. " + P", hl.dsp.exec_cmd("fish --login -c 'play piano'"))
hl.bind(mediaMod .. " + C", hl.dsp.exec_cmd("fish --login -c 'play chill'"))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Overlapping Hardware Media Controls (DMS inherits system wireplumber directly)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(
		"noctalia-shell ipc call volume increase ; wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ ; dms ipc call volume increase"
	),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(
		"noctalia-shell ipc call volume decrease ; wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ; dms ipc call volume decrease"
	),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(
		"noctalia-shell ipc call volume muteOutput ; wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ; dms ipc call volume muteOutput"
	),
	{ locked = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(
		"noctalia-shell ipc call brightness increase ; brightnessctl set +5% ; dms ipc call brightness increase"
	),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(
		"noctalia-shell ipc call brightness decrease ; brightnessctl set 5%- ; dms ipc call brightness decrease"
	),
	{ repeating = true, locked = true }
)
