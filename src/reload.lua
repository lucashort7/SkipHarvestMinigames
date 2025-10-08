---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- this file will be reloaded if it changes during gameplay,
-- 	so only assign to values or define things here.

function SetBlankAnimation(source, funcName)
	hw.DebugPrint('[' .. funcName .. '] triggered', 4)
	-- printMsg('---- [source]: \n' .. dumpTable(source))
	if source ~= nil then
		return rom.game.SetAnimation({Name = "Blank", DestinationId = source.ObjectId})
	end
end
