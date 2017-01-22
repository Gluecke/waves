local targetLocationService = require("scripts.targetLocationService")

local M = {}

function calculateDistance (locationData) 
    --calculates distance to target location
    local absLatitude = math.abs(locationData.latitude)
    local absLongitude = math.abs(locationData.longitude)

    local absTargetLatitude = math.abs(locationData.targetLatitude)
    local absTargetLongitude = math.abs(locationData.targetLongitude)

    locationData.latitudeDelta = absLatitude - absTargetLatitude
    locationData.longitudeDelta = absLongitude - absTargetLongitude

    locationData.distance = (math.sqrt(math.pow(math.abs(locationData.longitudeDelta), 2) + math.pow(math.abs(locationData.latitudeDelta), 2))) * 100000
    if locationData.maxDistance == nil then
        locationData.maxDistance = locationData.distance * 2
    end
end

function locationHandler ( event, locationData)

    print("location handler...")

    -- Check for error (user may have turned off location services)
    if ( event.errorCode ) then
        native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
        print( "Location error: " .. tostring( event.errorMessage ) )
    else
        if locationData ~= nil and locationData.isPopulated ~= nil then
            locationData.latitude = event.latitude
            local latitudeText = string.format( '%.5f', event.latitude )
            locationData.latitudeText.text = string.format("latitude : %s" , latitudeText)

            locationData.longitude = event.longitude
            local longitudeText = string.format( '%.5f', event.longitude )
            locationData.longitudeText.text = string.format("longitude : %s" , longitudeText)

            if locationData.longitudeDelta == nil then
                print("calculating targetLocationData...")
                targetLocationService.calculateTargetLocationData(locationData)
            end

            calculateDistance(locationData)

            local distanceText = string.format( '%.5f', locationData.distance )
            locationData.distanceText.text = string.format("distance : %s" ,  distanceText)

            local targetLatitudeText = string.format( '%.5f', locationData.targetLatitude)
            locationData.targetLatitudeText.text = string.format("target latitude : %s", targetLatitudeText)

            local targetLatitudeText = string.format( '%.5f', locationData.targetLongitude)
            locationData.targetLongitudeText.text = string.format("target longitude : %s", targetLatitudeText)

            locationData.hasCoordinates = true

            if locationData.longitudeDelta < 0 then
                locationData.shield.y = locationData.yLocationDisplay * .75
            else
                locationData.shield.y = locationData.yLocationDisplay * .25
            end
        end
    end
end

M.locationHandler = locationHandler
return M