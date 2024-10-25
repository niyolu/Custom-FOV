local mod = get_mod("Custom FOV")

local enable_updates = false

function check_fov(fov)
    if type(fov) ~= "number" or fov % 1 ~= 0 then
        mod:error("[Custom FOV] fov must be an integer")
        return false
    elseif fov > 360 then
        mod:echo("[Custom FOV] fov greater than 360 'wraps' around but changes sensitivity")
        return false
    elseif fov > 180 then
        mod:echo("[Custom FOV] fov greater 180 flips your screen")
    elseif fov < 0 then
        mod:echo("[Custom FOV] fov cant be negative, it is only allowed in the menu because VMF is trash")
        return false
    end
    if script_data.fov_override == fov then
        mod:debug("[Custom FOV] new fov equal to fov_override")
        return false
    end
    -- this breaks infinite recursion since the hook that calls set_fov has a call that causes the hook
    if Application.user_setting("render_settings", "fov") == fov then
        mod:debug("[Custom FOV] new fov equal to user_setting")
        return false
    end
    return true
end

function set_fov(fov)
    if check_fov(fov) then
        script_data.fov_override = fov
        Application.set_user_setting("render_settings", "fov", fov)
    end
end

function update_fov()
    set_fov(mod:get("custom_fov"))
end

mod.on_all_mods_loaded = function()
    custom_fov = mod:get("custom_fov")
    -- first time load, set config fov
    if custom_fov == -1 then
        mod:set("custom_fov", Application.user_setting("render_settings", "fov"))
    -- previous value needs to override startup game settings check
    else
        set_fov(custom_fov)
    end
    enable_updates = true
end

-- mod.on_game_state_changed = function(status, state)
--     mod:debug("on game state changed")
--     if enable_updates then
--         update_fov()
--     end
-- end

mod.on_setting_changed = function()
    if enable_updates then
        mod:echo("setting_changed")
        update_fov()
    end
end
