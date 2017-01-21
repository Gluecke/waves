local M = {}

local locationHandler = function( event, locationData)

    -- Check for error (user may have turned off location services)
    if ( event.errorCode ) then
        native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
        print( "Location error: " .. tostring( event.errorMessage ) )
    else
        local latitudeText = string.format( '%.4f', event.latitude )
        locationData.latitude.text = string.format("latitude : %s" , latitudeText)
        
        local longitudeText = string.format( '%.4f', event.longitude )
        locationData.longitude.text = string.format("longitude : %s" , longitudeText)
        
        local altitudeText = string.format( '%.3f', event.altitude )
        locationData.altitude.text = string.format("altitude : %s", altitudeText)
        
        local accuracyText = string.format( '%.3f', event.accuracy )
        locationData.accuracy.text = string.format("accuracy : %s" , accuracyText)
        
        local speedText = string.format( '%.3f', event.speed )
        locationData.speed.text = string.format("speed : %s" ,  speedText)
        
        local directionText = string.format( '%.3f', event.direction )
        locationData.direction.text = string.format("direction : %s" ,  directionText)
        
        -- Note that 'event.time' is a Unix-style timestamp, expressed in seconds since Jan. 1, 1970
        local timeText = string.format( '%.0f', event.time )
        locationData.time.text = string.format("time : %s" ,  timeText)
    end
end

M.locationHandler = locationHandler
return M