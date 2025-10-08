---@meta _
-- grabbing our dependencies,
-- these funky (---@) comments are just there
--	 to help VS Code find the definitions of things

---@diagnostic disable-next-line: undefined-global
local mods = rom.mods

---@module 'SGG_Modding-ENVY-auto'
mods['SGG_Modding-ENVY'].auto()
-- ^ this gives us `public` and `import`, among others
--	and makes all globals we define private to this plugin.
---@diagnostic disable: lowercase-global

---@diagnostic disable-next-line: undefined-global
rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = PLUGIN

---@module 'SGG_Modding-Hades2GameDef-Globals'
game = rom.game

---@module 'SGG_Modding-SJSON'
sjson = mods['SGG_Modding-SJSON']
---@module 'SGG_Modding-ModUtil'
modutil = mods['SGG_Modding-ModUtil']

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]
---@module 'SGG_Modding-ReLoad'
reload = mods['SGG_Modding-ReLoad']

---@module 'hortModWizard-config'
config = chalk.auto 'config.lua'
-- ^ this updates our `.cfg` file in the config folder!
public.config = config -- so other mods can access our config

function printMsg(fmt, ...)
    local text = string.format(fmt, ...)
    local green = "\x1b[95m"
    local reset = "\x1b[0m"
    print(green .. text .. reset)
end

function dumpTable(tbl, indent)
    local result = ""
    if not tbl then return result end
    if not indent then indent = 0 end

    local keys = {}
    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end

    table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
    end)

    for _, k in ipairs(keys) do
        local v = tbl[k]
        local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
        if type(v) == "table" then
            result = result .. formatting .. "\n" .. dumpTable(v, indent + 1)
        else
            result = result .. formatting .. tostring(v) .. "\n"
        end
    end
    return result
end

function containsString(array, targetString)
    for _, value in ipairs(array) do
        if value == targetString then
            return true -- String found
        end
    end
    return false -- String not found
end

function dumpToFile(fileName, linesToWrite)
    local filePath = fileName .. '.txt'
	local full_path = rom.path.combine(rom.paths.plugins_data(), filePath)

	local file = io.open(full_path, "w")
	if file then
		file:write(linesToWrite)
		file:close()
		print("Successfully wrote to " .. full_path)
	else
		print("Error: Could not open or create file " .. full_path)
	end
end

local function on_ready()
	-- what to do when we are ready, but not re-do on reload.
	if config.enabled == false then return end
	import_as_fallback(rom.game)
	import 'ready.lua'

	printMsg('[[ -- local.mod.on_ready() -- ]]')

end

local function on_reload()
	-- what to do when we are ready, but also again on every reload.
	-- only do things that are safe to run over and over.
	if config.enabled == false then return end
	import_as_fallback(rom.game)
	import 'reload.lua'

	printMsg('[[ -- local.mod.on_reload() -- ]]')

end

-- this allows us to limit certain functions to not be reloaded.
local loader = reload.auto_single()

-- this runs only when modutil and the game's lua is ready
modutil.once_loaded.game(function()
	loader.load(on_ready, on_reload)
end)
