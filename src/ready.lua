---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global
-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.

mod = modutil.mod.Mod.Register(_PLUGIN.guid)

data = modutil.mod.Mod.Register(_PLUGIN.guid).Data


local function wrap(callback)
	return function( ... )
		return callback( ... )
	end
end


---------------------
-- HarvestMinigame --
---------------------
if config.Harvest.Enabled then

    modutil.mod.Path.Context.Wrap('UseHarvestPoint', function()
        mod.DebugPrint('[UseHarvestPoint] triggered', 4)
        
        -- ignore invulnerability animations
        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', wrap(function( source, ... )
            -- do nothing
        end))
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', wrap(function( source, ... )
            -- do nothing
        end))

        modutil.mod.Path.Override('FamiliarHarvestStartPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))
        modutil.mod.Path.Override('HarvestStartPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))

    end)
end


--------------------
-- ShovelMinigame --
--------------------
if config.Shovel.Enabled then

    modutil.mod.Path.Context.Wrap('UseShovelPoint', function()
        mod.DebugPrint('[UseShovelPoint] triggered', 4)
        
        if config.Shovel.GiveTool then
            modutil.mod.Path.Wrap('HasAccessToTool', function(base, ...) 
                return True 
            end)
        end

        -- ignore invulnerability animations
        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', wrap(function( source, ... )
            -- do nothing
        end))
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', wrap(function( source, ... )
            -- do nothing
        end))

        modutil.mod.Path.Override('FamiliarShovelStartPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))
        modutil.mod.Path.Override('ShovelStartPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))

    end)
end


---------------------
-- PickaxeMinigame --
---------------------
if config.Pickaxe.Enabled then

    modutil.mod.Path.Context.Wrap('UsePickaxePoint', function()
        mod.DebugPrint('[UsePickaxePoint] triggered', 4)

        if config.Pickaxe.GiveTool then
            modutil.mod.Path.Wrap('HasAccessToTool', function(base, ...) 
                return True 
            end)
        end

        -- ignore invulnerability animations
        modutil.mod.Path.Override('BeginFamiliarHarvestInvulnerability', wrap(function() 
            -- do nothing
        end))
        modutil.mod.Path.Override('EndFamiliarHarvestInvulnerability', wrap(function() 
            -- do nothing
        end))
        modutil.mod.Path.Override('FamiliarPickaxeStartPresentation', wrap(function( source, ... )
                SetBlankAnimation( source )
        end))
        modutil.mod.Path.Override('PickaxeStartPresentation', wrap(function( source, ... )
                SetBlankAnimation( source )
        end))

    end)
end

----------------------
-- ExorcismMinigame --
----------------------
if config.Exorcism.Enabled then

    modutil.mod.Path.Context.Wrap('UseExorcismPoint', function()
        mod.DebugPrint('[UseExorcismPoint] triggered', 4)

        if config.Exorcism.GiveTool then
            modutil.mod.Path.Wrap('HasAccessToTool', function( base, ... ) 
                return True 
            end)
        end

        modutil.mod.Path.Override('FamiliarExorcismStartPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))
        modutil.mod.Path.Override('ExorcismStartPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))

        modutil.mod.Path.Override('ExorcismSequence', wrap(function( source, ... ) 
            return true 
        end))
        modutil.mod.Path.Override('ExorcismSuccessPresentation', wrap(function( source, ...)
            ExorcismSuccessPresentation_override( source )
        end))

    end)
end


---------------------
-- FishingMinigame --
---------------------
if config.Fishing.Enabled then

    modutil.mod.Path.Context.Wrap('UseFishingPoint', function()
        mod.DebugPrint('[UseFishingPoint] triggered', 4)

        if config.Fishing.GiveTool then
            modutil.mod.Path.Wrap('HasAccessToTool', function( base, ... ) 
                return True 
            end)
        end

        modutil.mod.Path.Override('FamiliarFishingPresentation', wrap(function( source, ... )
            SetBlankAnimation( source )
        end))
        modutil.mod.Path.Override('StartFishing', wrap(function( source, args )
            StartFishing_override( source, args )
        end))
    end)
end


-- -- TODO: remove this after testing
-- ModUtil.Path.Override("InvalidateCheckpoint", function()
--     ValidateCheckpoint({ Value = true })
-- end)