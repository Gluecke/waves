local utility = require( "scripts.utility" )
local sceneConfigData = require( "scripts.sceneConfigData" )
local M = {}

function calculateTargetLocationData (locationData)

	local currentLatitude = locationData.latitude
	local currentLongitude = locationData.longitude

	--numbers to be replaced with random seed based on time
	math.randomseed(utility.round(os.time(t), -1))

	local latitudeDeltaSeed = (math.random(sceneConfigData.lowerCoordinateDelta, sceneConfigData.upperCoordinateDelta) * 0.0001) * setPosOrNeg()
	local longitudeDeltaSeed = (math.random(sceneConfigData.lowerCoordinateDelta, sceneConfigData.upperCoordinateDelta) * 0.0001) * setPosOrNeg()

	locationData.targetLatitude = currentLatitude + latitudeDeltaSeed
	locationData.targetLongitude = currentLongitude + longitudeDeltaSeed
	print("latitudeDelta : " .. latitudeDeltaSeed)
	print("longitudeDelta : " .. longitudeDeltaSeed)
	print("target latitude : " .. locationData.targetLatitude)
	print("target longitude : " .. locationData.targetLongitude)

end

function setPosOrNeg ()
	local rand = math.random( 1, 2 )
	if rand == 1 then
		return 1
	else
		return -1
	end
end

M.calculateTargetLocationData = calculateTargetLocationData

return M