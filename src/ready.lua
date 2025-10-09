---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global
-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.
mod = modutil.mod.Mod.Register(_PLUGIN.guid)

-- ModUtil.LoadOnce(function()
-- 	rom.data.reload_game_data()
-- end)

data = modutil.mod.Mod.Register(_PLUGIN.guid).Data


local function _CheckIfToolIsUnlocked( tool ) 
    if not rom.game.HasAccessToTool( tool ) then 
        hw.DebugPrint('[' .. tool .. '] Missing Tool...', 4)
        return false
    end
    hw.DebugPrint('[' .. tool .. '] Has Tool...', 4)
    return true
end

local function _UnlockTool( tool ) 
    rom.game.GameState.WeaponsUnlocked[tool] = true
    hw.DebugPrint('[' .. tool .. '] Added to Hero...', 4)
end


-- modutil.mod.Path.Wrap('LeaveRoom', function ( base, currentRun, door )
--     hw.DebugPrint('[LeaveRoom] triggered', 4)

--     GameState.WorldUpgrades.WorldUpgradeAutoHarvestOnExit = true
--     hw.DebugPrint('[WorldUpgradeAutoHarvestOnExit] ON', 4)

--     return base( currentRun, door )
-- end)

---------------------
-- HarvestMinigame --
---------------------
if config.Harvest.Enabled then

    modutil.mod.Path.Context.Wrap('UseHarvestPoint', function()
        hw.DebugPrint('[UseHarvestPoint] triggered', 4)
        
        -- ignore invulnerability animations
        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)

        modutil.mod.Path.Override('FamiliarHarvestStartPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarHarvestStartPresentation')
        end)
        modutil.mod.Path.Override('HarvestStartPresentation', function(source)
            SetBlankAnimation(source, 'HarvestStartPresentation')
        end)

        -- hw.DebugPrint('[UseHarvestPoint] Skipped Animation Successfully', 4)
    end)

end


--------------------
-- ShovelMinigame --
--------------------
if config.Shovel.Enabled then

    modutil.mod.Path.Context.Wrap('UseShovelPoint', function()
        hw.DebugPrint('[UseShovelPoint] triggered', 4)

        local HarvestTool = 'ToolShovel'

        -- ignores tool restriction
        if config.Shovel.GiveTool then
            _UnlockTool(HarvestTool)
        elseif not _CheckIfToolIsUnlocked(HarvestTool) then
            return
        end

        -- ignore invulnerability animations
        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)

        modutil.mod.Path.Override('FamiliarShovelStartPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarShovelStartPresentation')
        end)
        modutil.mod.Path.Override('ShovelStartPresentation', function(source)
            SetBlankAnimation(source, 'ShovelStartPresentation')
        end)

        -- hw.DebugPrint('[UseShovelPoint] Skipped Animation Successfully', 4)
    end)

end


---------------------
-- PickaxeMinigame --
---------------------
if config.Pickaxe.Enabled then

    modutil.mod.Path.Context.Wrap('UsePickaxePoint', function()
        hw.DebugPrint('[UsePickaxePoint] triggered', 4)

        local HarvestTool = 'ToolPickaxe'

        -- ignores tool restriction
        if config.Pickaxe.GiveTool then
            _UnlockTool(HarvestTool)
        elseif not _CheckIfToolIsUnlocked(HarvestTool) then
            return
        end

        -- ignore invulnerability animations
        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)

        modutil.mod.Path.Override('FamiliarPickaxeStartPresentation', function( source )
            SetBlankAnimation( source, 'FamiliarPickaxeStartPresentation')
        end)
        modutil.mod.Path.Override('PickaxeStartPresentation', function( source )
            SetBlankAnimation( source, 'PickaxeStartPresentation')
        end)

        -- hw.DebugPrint('[UsePickaxePoint] Skipped Animation Successfully', 4)
    end)

end

----------------------
-- ExorcismMinigame --
----------------------
if config.Exorcism.Enabled then

    modutil.mod.Path.Context.Wrap('UseExorcismPoint', function()
        hw.DebugPrint('[UseExorcismPoint] triggered', 4)

        local HarvestTool = 'ToolExorcismBook'

        -- ignores tool restriction
        if config.Exorcism.GiveTool then
            _UnlockTool(HarvestTool)
        elseif not _CheckIfToolIsUnlocked(HarvestTool) then
            return
        end

        modutil.mod.Path.Override('FamiliarExorcismStartPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarExorcismStartPresentation')
        end)
        modutil.mod.Path.Override('ExorcismStartPresentation', function(source)
            SetBlankAnimation(source, 'ExorcismStartPresentation')
        end)

        modutil.mod.Path.Override('ExorcismSequence', function(source)
            return true
        end)

        modutil.mod.Path.Override('ExorcismSuccessPresentation', function ( source, ...)
            ExorcismSuccessPresentation_override( source )
        end)

        -- hw.DebugPrint('[UseExorcismPoint] Skipped Animation Successfully', 4)
    end)

end


---------------------
-- FishingMinigame --
---------------------
if config.Fishing.Enabled then

    modutil.mod.Path.Context.Wrap('UseFishingPoint', function()
        hw.DebugPrint('[UseFishingPoint] triggered', 4)

        local HarvestTool = 'ToolFishingRod'

        -- ignores tool restriction
        if config.Fishing.GiveTool then
            _UnlockTool(HarvestTool)
        elseif not _CheckIfToolIsUnlocked(HarvestTool) then
            return
        end

        modutil.mod.Path.Override('FamiliarFishingPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarFishingPresentation')
        end)

        modutil.mod.Path.Override('StartFishing', function( source, args )
            StartFishing_override( source, args )
        end)

    end)

end
