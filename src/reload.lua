---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- this file will be reloaded if it changes during gameplay,
-- 	so only assign to values or define things here.


function SetBlankAnimation( source )
	waitUnmodified(0.15)
	SetAnimation({Name = "Blank", DestinationId = source.ObjectId})
	waitUnmodified(0.15)
end


function StartFishing_override( source, args )
	mod.DebugPrint('[StartFishing] triggered', 4) 

	args.FishingAnimationPointId = SpawnObstacle({ 
		Name = "BlankObstacle", 
		DestinationId = args.FishingPointId, 
		Group = GetGroupName({ Id = args.FishingPointId, DrawGroup = true }) 
	})

	local fishingPointId = args.FishingPointId
	local fishingAnimationPointId = args.FishingAnimationPointId

	Destroy({ Id = fishingPointId })
	--SetAlpha({ Id = fishingPointId, Fraction = 0 })
	SetAlpha({ Id = args.FishingPointId, Fraction = 0.0 })
	BlockVfx({ DestinationId = args.FishingPointId })
		
	CurrentRun.Hero.FishingState = "Success"
end

function ExorcismSuccessPresentation_override( source )
	mod.DebugPrint('[ExorcismSuccessPresentation] triggered', 4)
	thread( ExorcismGhostDissipate, source )
end
