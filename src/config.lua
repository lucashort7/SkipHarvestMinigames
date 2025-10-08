---@meta hortModWizard-config
local config = {
	enabled = true,
	Harvest = {
		Enabled = true
	},
	Shovel = {
		Enabled = true
	},
	Pickaxe = {
		Enabled = true
	},
	Exorcism = {
		Enabled = true
	},
	Fishing = {
		Enabled = true
	},
}

local description = {
	enabled = "Set to true to enable the mod, set to false to disable it.",
	Harvest = {
		Enabled = "Enable to skip harvest animations.",
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
}

return config, description
