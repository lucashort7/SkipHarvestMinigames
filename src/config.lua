---@meta hortModWizard-config
local config = {
	enabled = true,
	AutoHarvestOnExit = {
		Enabled = false,
	},
	BypassToolRequirements = {
		Enabled = false
	},
	Harvest = {
		Enabled = true,
	},
	Shovel = {
		Enabled = true,
	},
	Pickaxe = {
		Enabled = true,
	},
	Exorcism = {
		Enabled = true,
	},
	Fishing = {
		Enabled = true,
	},
	logLevel = 0,
}

local description = {
	enabled = "Set to true to enable the mod, set to false to disable it.",
	AutoHarvestOnExit = {
		Enabled = "Auto Harvest everything on room exit, without the need to interact with each point."
	},
	BypassToolRequirements = {
		Enabled = "Bypass Tool requirements for harvesting."
	},
	Harvest = {
		Enabled = "Enable to skip harvest animations."
	},
	Shovel = {
		Enabled = "Enable to skip shovel animations.",
	},
	Pickaxe = {
		Enabled = "Enable to skip pickaxe animations.",
	},
	Exorcism = {
		Enabled = "Enable to skip exorcism animations.",
	},
	Fishing = {
		Enabled = "Enable to skip fishing animations.",
	},

	logLevel = "Log Level for prints in console."
}

return config, description
