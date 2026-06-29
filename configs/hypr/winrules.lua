-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding = 0
-- })
-- hl.window_rule({
--     name = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding = 0
-- })

hl.window_rule({
    name = "pyprland-term-border",
    match = { class = "kitty-term-scratchpad" },
    border_color = "rgb(ff4d4d)"
})

hl.window_rule({
    name = "pyprland-ollama-border",
    match = { class = "kitty-ollama-scratchpad" },
    border_color = "rgb(ff4d4d)"
})
