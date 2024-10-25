local mod = get_mod("Custom FOV")

return {
	name = "Custom FOV",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
	  widgets = {
		{
			setting_id      = "custom_fov",
			type            = "numeric",
			default_value   = -1,
			range           = {-1, 360},
			unit_text		= "degrees",
			decimals_number = 0
		}
	  },
	},
}