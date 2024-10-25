return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Custom FOV` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Custom FOV", {
			mod_script       = "scripts/mods/Custom FOV/Custom FOV",
			mod_data         = "scripts/mods/Custom FOV/Custom FOV_data",
			mod_localization = "scripts/mods/Custom FOV/Custom FOV_localization",
		})
	end,
	packages = {
		"resource_packages/Custom FOV/Custom FOV",
	},
}
