---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global
-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.

mod = modutil.mod.Mod.Register(_PLUGIN.guid)

data = modutil.mod.Mod.Register(_PLUGIN.guid).Data


--[[ HarvestMinigame ]]--
if config.Harvest.Enabled then

    modutil.mod.Path.Context.Wrap('UseHarvestPoint', function()
        mod.DebugPrint('[UseHarvestPoint] triggered', 4)

        -- skips invulnerability animations
        mod.WrapMagicGonads_override('BeginFamiliarHarvestInvulnerability')
        mod.WrapMagicGonads_override('EndFamiliarHarvestInvulnerability')

        mod.WrapMagicGonads_override('FamiliarHarvestStartPresentation')
        mod.WrapMagicGonads_override('HarvestStartPresentation')

    end)
end

--[[ ShovelMinigame ]]--
if config.Shovel.Enabled then

    modutil.mod.Path.Context.Wrap('UseShovelPoint', function()
        mod.DebugPrint('[UseShovelPoint] triggered', 4)

        -- tool restriction bypass 
        if config.BypassToolRequirements.Enabled then
            mod.WrapMagicGonads_override('HasAccessToTool')
            mod.DebugPrint('[HasAccessToTool] Bypassed Tool Restriction! :)', 4)
        end

        -- skips invulnerability animations
        mod.WrapMagicGonads_override('BeginFamiliarHarvestInvulnerability')
        mod.WrapMagicGonads_override('EndFamiliarHarvestInvulnerability')

        mod.WrapMagicGonads_override('FamiliarShovelStartPresentation')
        mod.WrapMagicGonads_override('ShovelStartPresentation')

    end)
end

--[[ PickaxeMinigame ]]--
if config.Pickaxe.Enabled then

    modutil.mod.Path.Context.Wrap('UsePickaxePoint', function()
        mod.DebugPrint('[UsePickaxePoint] triggered', 4)

        -- tool restriction bypass 
        if config.BypassToolRequirements.Enabled then
            mod.WrapMagicGonads_override('HasAccessToTool')
            mod.DebugPrint('[HasAccessToTool] Bypassed Tool Restriction! :)', 4)
        end

        -- skips invulnerability animations
        mod.WrapMagicGonads_override('BeginFamiliarHarvestInvulnerability')
        mod.WrapMagicGonads_override('EndFamiliarHarvestInvulnerability')

        mod.WrapMagicGonads_override('FamiliarPickaxeStartPresentation')
        mod.WrapMagicGonads_override('PickaxeStartPresentation')

    end)
end

--[[ ExorcismMinigame ]]--
if config.Exorcism.Enabled then

    modutil.mod.Path.Context.Wrap('UseExorcismPoint', function()
        mod.DebugPrint('[UseExorcismPoint] triggered', 4)

        -- tool restriction bypass 
        if config.BypassToolRequirements.Enabled then
            mod.WrapMagicGonads_override('HasAccessToTool')
            mod.DebugPrint('[HasAccessToTool] Bypassed Tool Restriction! :)', 4)
        end

        mod.WrapMagicGonads_override('FamiliarExorcismStartPresentation')
        mod.WrapMagicGonads_override('ExorcismStartPresentation')
        mod.WrapMagicGonads_override('ExorcismSequence')
        mod.WrapMagicGonads_override('ExorcismSuccessPresentation')

    end)
end

--[[ FishingMinigame ]]--
if config.Fishing.Enabled then

    modutil.mod.Path.Context.Wrap('UseFishingPoint', function()
        mod.DebugPrint('[UseFishingPoint] triggered', 4)

        -- tool restriction bypass 
        if config.BypassToolRequirements.Enabled then
            mod.WrapMagicGonads_override('HasAccessToTool')
            mod.DebugPrint('[HasAccessToTool] Bypassed Tool Restriction! :)', 4)
        end

        mod.WrapMagicGonads_override('FamiliarFishingPresentation')
        mod.WrapMagicGonads_override('StartFishing')

    end)
end

--[[ AutoHarvestOnExit ]]--
if config.AutoHarvestOnExit.Enabled then
    modutil.mod.Path.Context.Wrap('LeaveRoom', function( ... )
        if not game.GameState.WorldUpgrades.WorldUpgradeAutoHarvestOnExit then
            game.AutoHarvestOnExit()
        end
    end)
end