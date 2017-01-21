local utility = require( "scripts.utility" )
local sceneConfigData = require( "scripts.sceneConfigData" )
local M = {}

function calculateTargetLocationData (locationData)

	local currentLatitude = locationData.latitude
	local currentLongitude = locationData.longitude

	--numbers to be replaced with random seed based on time
	math.randomseed(utility.round(os.time(t), -1))

	local latitudeDeltaSeed = math.random(sceneConfigData.lowerCoordinateDelta, sceneConfigData.upperCoordinateDelta) * 0.0001
	local longitudeDeltaSeed = math.random(sceneConfigData.lowerCoordinateDelta, sceneConfigData.upperCoordinateDelta) * 0.0001

	locationData.targetLatitude = currentLatitude + latitudeDeltaSeed
	locationData.targetLongitude = currentLongitude + longitudeDeltaSeed
	print("latitudeDelta : " .. latitudeDeltaSeed)
	print("longitudeDelta : " .. longitudeDeltaSeed)
	print("target latitude : " .. locationData.targetLatitude)
	print("target longitude : " .. locationData.targetLongitude)

end

M.calculateTargetLocationData = calculateTargetLocationData

return M