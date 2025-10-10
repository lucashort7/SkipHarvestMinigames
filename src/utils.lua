---Logs a message at the specified log level with colour coding.
---@param t any The message to log.
---@param level number|nil The log level. 0 = Off, 1 = Errors, 2 = Warnings, 3 = Info, 4 = Debug. nil omits the level display.
function mod.LogMessage(t, level)
    local logLevels = { [1] = "[ERROR] ", [2] = "[WARNING] ", [3] = "[INFO] ", [4] = "[DEBUG] " }
    local logColours = { [1] = "\27[31m", [2] = "\27[33m", [3] = "\27[95m", [4] = "\27[34m" } -- Red, Yellow, Green, Blue
    local resetColour = "\27[0m"

    local logLevelText = logLevels[level] or ""
    local logLevelColour = logColours[level] or resetColour
    local logColour
    if level <= 2 then logColour = logColours[level] else logColour = resetColour end

    print(string.format("%s%s%s%s", logLevelColour, logLevelText, tostring(t), resetColour))
end

---Prints a message to the console at the specified log level
---@param t any The message to print.
---@param level number|nil The verbosity level required to print the message. 0 = Off/Always printed, 1 = Errors, 2 = Warnings, 3 = Info, 4 = Debug
function mod.DebugPrint(t, level)
    level = level or 0
    if config.logLevel >= level then
        mod.LogMessage(t, level)
    end
end

function mod.dumpTable(tbl, indent)
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
            result = result .. formatting .. "\n" .. mod.dumpTable(v, indent + 1)
        else
            result = result .. formatting .. tostring(v) .. "\n"
        end
    end
    return result
end

function mod.containsString(array, targetString)
    for _, value in ipairs(array) do
        if value == targetString then
            return true -- String found
        end
    end
    return false -- String not found
end

function mod.dumpToFile(fileName, linesToWrite)
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
