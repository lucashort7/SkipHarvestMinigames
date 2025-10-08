---@meta hortModWizard-config
local config = {
	enabled = true,
	Harvest = {
		Enabled = true,
		GiveTool = false
	},
	Shovel = {
		Enabled = true,
		GiveTool = false
	},
	Pickaxe = {
		Enabled = true,
		GiveTool = false
	},
	Exorcism = {
		Enabled = true,
		GiveTool = false
	},
	Fishing = {
		Enabled = true,
		GiveTool = false
	},

	logLevel = 0
}

local description = {
	enabled = "Set to true to enable the mod, set to false to disable it.",
	Harvest = {
		Enabled = "Enable to skip harvest animations.",
		GiveTool = "Sets to true if you want the tool, but haven`t."
	},
	Shovel = {
		Enabled = "Enable to skip shovel animations.",
		GiveTool = "Sets to true if you want the tool, but haven`t."
	},
	Pickaxe = {
		Enabled = "Enable to skip pickaxe animations.",
		GiveTool = "Sets to true if you want the tool, but haven`t."
	},
	Exorcism = {
		Enabled = "Enable to skip exorcism animations.",
		GiveTool = "Sets to true if you want the tool, but haven`t."
	},
	Fishing = {
		Enabled = "Enable to skip fishing animations.",
		GiveTool = "Sets to true if you want the tool, but haven`t."
	},

	logLevel = "Log Level for prints in console."
}

return config, description
