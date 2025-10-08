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
        
        -- -- gives tool if wanted, otherwise checks if has any
        -- if config.Harvest.GiveTool then
        --     hw.DebugPrint('[ToolHarvest] Added to Hero...', 4)
        --     GameState.WeaponsUnlocked["ToolHarvest"] = true
        -- elseif not HasAccessToTool( "ToolHarvest" ) then 
        --     hw.DebugPrint('[ToolHarvest] Missing Tool...', 4)
        --     return
        -- end

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

        hw.DebugPrint('[UseHarvestPoint] Skipped Animation Successfully', 4)
    end)

end


--------------------
-- ShovelMinigame --
--------------------
if config.Shovel.Enabled then

    modutil.mod.Path.Context.Wrap('UseShovelPoint', function()
        hw.DebugPrint('[UseShovelPoint] triggered', 4)

        -- gives tool if wanted, otherwise checks if has any
        if config.Shovel.GiveTool then
            hw.DebugPrint('[ToolShovel] Added to Hero...', 4)
            GameState.WeaponsUnlocked["ToolShovel"] = true
        elseif not HasAccessToTool( "ToolShovel" ) then 
            hw.DebugPrint('[ToolShovel] Missing Tool...', 4)
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

        hw.DebugPrint('[UseShovelPoint] Skipped Animation Successfully', 4)
    end)

end


---------------------
-- PickaxeMinigame --
---------------------
if config.Pickaxe.Enabled then

    modutil.mod.Path.Context.Wrap('UsePickaxePoint', function()
        hw.DebugPrint('[UsePickaxePoint] triggered', 4)

        -- gives tool if wanted, otherwise checks if has any
        if config.Pickaxe.GiveTool then
            hw.DebugPrint('[ToolPickaxe] Added to Hero...', 4)
            GameState.WeaponsUnlocked["ToolPickaxe"] = true
        elseif not HasAccessToTool( "ToolPickaxe" ) then 
            hw.DebugPrint('[ToolPickaxe] Missing Tool...', 4)
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

        hw.DebugPrint('[UsePickaxePoint] Skipped Animation Successfully', 4)
    end)

end

----------------------
-- ExorcismMinigame --
----------------------
if config.Exorcism.Enabled then

    modutil.mod.Path.Context.Wrap('UseExorcismPoint', function()
        hw.DebugPrint('[UseExorcismPoint] triggered', 4)
        
        -- gives tool if wanted, otherwise checks if has any
        if config.Exorcism.GiveTool then
            hw.DebugPrint('[ToolExorcismBook] Added to Hero...', 4)
            GameState.WeaponsUnlocked["ToolExorcismBook"] = true
        elseif not HasAccessToTool( "ToolExorcismBook" ) then 
            hw.DebugPrint('[ToolExorcismBook] Missing Tool...', 4)
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

        hw.DebugPrint('[UseExorcismPoint] Skipped Animation Successfully', 4)
    end)

end


---------------------
-- FishingMinigame --
---------------------
if config.Fishing.Enabled then

    modutil.mod.Path.Context.Wrap('UseFishingPoint', function()
        hw.DebugPrint('[UseFishingPoint] triggered', 4)

        -- gives tool if wanted, otherwise checks if has any
        if config.Fishing.GiveTool then
            hw.DebugPrint('[ToolFishingRod] Added to Hero...', 4)
            GameState.WeaponsUnlocked["ToolFishingRod"] = true
        elseif not HasAccessToTool( "ToolFishingRod" ) then 
            hw.DebugPrint('[ToolFishingRod] Missing Tool...', 4)
            return
        end

        modutil.mod.Path.Override('FamiliarFishingPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarFishingPresentation')
        end)
        modutil.mod.Path.Override('StartFishing', function( source, args )
            hw.DebugPrint('[StartFishing] triggered', 4) 
            CurrentRun.Hero.FishingState = "Success"
            return
        end)

        hw.DebugPrint('[UseFishingPoint] Skipped Animation Successfully', 4)
    end)

end