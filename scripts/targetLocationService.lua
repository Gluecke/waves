local M = {}

local calculateTargetLocationData = function (locationData)

local currentLatitude = locationData.latitude
local currentLongitude = locationData.longitude

	--numbers to be replaced with random seed based on time
	local latitudeDeltaSeed = -0.0004
	local longitudeDeltaSeed = 0.0004

	locationData.targetLatitude = currentLatitude + latitudeDeltaSeed
	locationData.targetLongitude = currentLongitude + longitudeDeltaSeed
	print("latitudeDelta : " .. latitudeDeltaSeed)
	print("longitudeDelta : " .. longitudeDeltaSeed)
	print("target latitude : " .. locationData.targetLatitude)
	print("target longitude : " .. locationData.targetLongitude)

end

M.calculateTargetLocationData = calculateTargetLocationData

return M