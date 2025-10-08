---@meta hortModWizard-config
local config = {
	enabled = true,
	Skip = {
		Enabled = true,
		RunDialog = true,
	},
}

local description = {
	enabled = "Set to true to enable the mod, set to false to disable it.",
	Skip = {
		RunDialog = "Enable to skip all dialogs during runs.",
	},
}

return config, description
