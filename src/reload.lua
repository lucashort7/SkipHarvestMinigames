---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- this file will be reloaded if it changes during gameplay,
-- 	so only assign to values or define things here.

local overrideReferenceMapping = {}

local function setupReferenceTable()
	overrideReferenceMapping = {
		FamiliarHarvestStartPresentation		= SetBlankAnimation_override,
		HarvestStartPresentation				= SetBlankAnimation_override,

		FamiliarShovelStartPresentation			= SetBlankAnimation_override,
		ShovelStartPresentation					= SetBlankAnimation_override,

		FamiliarPickaxeStartPresentation		= SetBlankAnimation_override,
		PickaxeStartPresentation				= SetBlankAnimation_override,

		FamiliarExorcismStartPresentation 		= SetBlankAnimation_override,
		ExorcismStartPresentation 				= SetBlankAnimation_override,
		ExorcismSuccessPresentation				= ExorcismSuccessPresentation_override,

		FamiliarFishingPresentation				= SetBlankAnimation_override,
		StartFishing							= StartFishing_override,
	}
end

local function wrap(callback)
	return function( ... )
		return callback( ... )
	end
end

function SetBlankAnimation_override( source, ... )
	game.waitUnmodified(0.15)
	game.SetAnimation({Name = "Blank", DestinationId = source.ObjectId})
	game.waitUnmodified(0.15)
end

function StartFishing_override( source, args )
	mod.DebugPrint('[StartFishing] triggered', 4)

	args.FishingAnimationPointId = game.SpawnObstacle({
		Name = "BlankObstacle",
		DestinationId = args.FishingPointId,
		Group = game.GetGroupName({ Id = args.FishingPointId, DrawGroup = true })
	})

	local fishingPointId = args.FishingPointId
	local fishingAnimationPointId = args.FishingAnimationPointId

	game.Destroy({ Id = fishingPointId })
	--SetAlpha({ Id = fishingPointId, Fraction = 0 })
	game.SetAlpha({ Id = args.FishingPointId, Fraction = 0.0 })
	game.BlockVfx({ DestinationId = args.FishingPointId })

	game.CurrentRun.Hero.FishingState = "Success"
end

function ExorcismSuccessPresentation_override( source, args )
	mod.DebugPrint('[ExorcismSuccessPresentation] triggered', 4)
	game.thread( game.ExorcismGhostDissipate, source )
end

function mod.WrapMagicGonads_override( referenceFunctionName )
	return modutil.mod.Path.Override( referenceFunctionName , wrap(
		function( source, args )
			local overrideFunction = overrideReferenceMapping[referenceFunctionName]
			overrideFunction( source, args )
		end)
	)
end

function mod.SkipsOrBypass( pathReference )
    return modutil.mod.Path.Wrap( pathReference,
		function( ... ) return true end
	)
end

ModUtil.LoadOnce(function()
	setupReferenceTable()
end)