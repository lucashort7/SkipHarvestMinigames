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

-- local _wiz_utils = require('./core/lua_utils.lua')

if config.Skip.RunDialog then
    ModUtil.Path.Wrap("PlayTextLines", function(base, source, textLines, args)
        printMsg('-- [PlayTextLines] triggered')

        if CurrentRun.Hero.IsDead then
            printMsg('--- [CurrentRun.Hero.IsDead] Not skipping textLines!')
            return base(source, textLines, args)
        end

		-- some encounters have ```textLines`` empty
		if not textLines then
			return
		end

		-- dumping for debugging
		-- dumpToFile('playTextLines_source', dumpTable(source))
		-- dumpToFile('playTextLines_textLines', dumpTable(textLines))
		-- dumpToFile('playTextLines_args', dumpTable(args))

        -- TODO: maybe this could be a var in config, 
        -- like if its a mainStory line u dont wanna skip
        if textLines.StatusAnimation == 'StatusIconWantsToTalk' then
            printMsg('--- [' .. source.Name .. '] Wants to talk... --- ')
            return base(source, textLines, args)
        else
            -- just for debugging purpose
            printMsg('--- [' .. source.Name .. '] Does not want to talk... --- ')
        end
		
		printMsg('--- [source.Name]: ' .. source.Name)
		if textLines.PrePortraitExitFunctionName then
			printMsg('--- [textLines.PrePortraitExitFunctionName]: ' .. textLines.PrePortraitExitFunctionName)
			hasChoice, _ = string.find(textLines.PrePortraitExitFunctionName, 'Choice')
			if hasChoice then
				return base(source, textLines, args)
			end
		end
		

        -- skip text lines for everyone else
        return

    end)
end


---------------------
-- HarvestMinigame --
---------------------
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


--------------------
-- ShovelMinigame --
--------------------
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


---------------------
-- PickaxeMinigame --
---------------------
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


----------------------
-- ExorcismMinigame --
----------------------
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


---------------------
-- FishingMinigame --
---------------------
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