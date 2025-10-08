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


---------------------
-- HarvestMinigame --
---------------------
if config.Harvest.Enabled then
    modutil.mod.Path.Context.Wrap('UseHarvestPoint', function()

        printMsg('[UseHarvestPoint] triggered') 

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

    end)
end


--------------------
-- ShovelMinigame --
--------------------
if config.Shovel.Enabled then
    modutil.mod.Path.Context.Wrap('UseShovelPoint', function()

        printMsg('[UseShovelPoint] triggered') 

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

    end)
end


---------------------
-- PickaxeMinigame --
---------------------
if config.Pickaxe.Enabled then
    modutil.mod.Path.Context.Wrap('UsePickaxePoint', function()
        printMsg('[UseShovelPoint] triggered') 

        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', function()
            -- do nothing
        end)

        modutil.mod.Path.Override('FamiliarPickaxeStartPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarPickaxeStartPresentation')
        end)

        modutil.mod.Path.Override('PickaxeStartPresentation', function(source)
            SetBlankAnimation(source, 'PickaxeStartPresentation')
        end)

    end)
end

----------------------
-- ExorcismMinigame --
----------------------
if config.Exorcism.Enabled then
    modutil.mod.Path.Context.Wrap('UseExorcismPoint', function()
        printMsg('[UseExorcismPoint] triggered') 

        modutil.mod.Path.Override('FamiliarExorcismStartPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarExorcismStartPresentation')
        end)

        modutil.mod.Path.Override('ExorcismStartPresentation', function(source)
            SetBlankAnimation(source, 'ExorcismStartPresentation')
        end)

        modutil.mod.Path.Override('ExorcismSequence', function(source)
            return true
        end)

    end)
end


---------------------
-- FishingMinigame --
---------------------
if config.Exorcism.Enabled then
    modutil.mod.Path.Context.Wrap('UseFishingPoint', function()
        printMsg('[UseFishingPoint] triggered') 

        modutil.mod.Path.Override('FamiliarFishingPresentation', function(source)
            SetBlankAnimation(source, 'FamiliarFishingPresentation')
        end)

        modutil.mod.Path.Override('StartFishing', function( source, args )
            printMsg('[StartFishing] triggered') 
            CurrentRun.Hero.FishingState = "Success"
            return
        end)
    end)
end