local targetLocationService = require("scripts.targetLocationService")

local M = {}

local calculateDistance = function(locationData)

--calculates distance to target location
local absLatitude = math.abs(locationData.latitude)
local absLongitude = math.abs(locationData.longitude)

local absTargetLatitude = math.abs(locationData.targetLatitude)
local absTargetLongitude = math.abs(locationData.targetLongitude)

locationData.latitudeDelta = absLatitude - absTargetLatitude
locationData.longitudeDelta = absLongitude - absTargetLongitude

locationData.distance = math.sqrt(math.pow(math.abs(locationData.longitudeDelta), 2) + math.pow(math.abs(locationData.latitudeDelta), 2))

print(locationData.distance)

end

local locationHandler = function( event, locationData)

    -- Check for error (user may have turned off location services)
    if ( event.errorCode ) then
        native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
        print( "Location error: " .. tostring( event.errorMessage ) )
    else
        locationData.latitude = event.latitude
        local latitudeText = string.format( '%.5f', event.latitude )
        locationData.latitudeText.text = string.format("latitude : %s" , latitudeText)
        
        locationData.longitude = event.longitude
        local longitudeText = string.format( '%.5f', event.longitude )
        locationData.longitudeText.text = string.format("longitude : %s" , longitudeText)

        if locationData.longitudeDelta == nil then
            print("calculating targetLocationData")
            targetLocationService.calculateTargetLocationData(locationData)
        end

        calculateDistance(locationData)

        local distanceText = string.format( '%.5f', locationData.distance )
        locationData.distanceText.text = string.format("distance : %s" ,  distanceText)

        local targetLatitudeText = string.format( '%.5f', locationData.targetLatitude)
        locationData.targetLatitudeText.text = string.format("target latitude : %s", targetLatitudeText)
        
        local targetLatitudeText = string.format( '%.5f', locationData.targetLongitude)
        locationData.targetLongitudeText.text = string.format("target longitude : %s", targetLatitudeText)

    end
end

M.locationHandler = locationHandler
return M