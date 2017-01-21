local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "scripts.utility" )
local myData = require( "scripts.mydata" )

local params

local xDisplay = display.contentWidth
local yDisplay = display.contentHeight

local xLocationDisplay = xDisplay * .5
local yLocationDisplay = yDisplay;
latitude = display.newText( "latitude :", xLocationDisplay, yLocationDisplay * .1, native.systemFont, 16 )
latitudeRef = latitude
longitude = display.newText( "longitude :", xLocationDisplay, yLocationDisplay * .2, native.systemFont, 16 )
altitude = display.newText( "altitude :", xLocationDisplay, yLocationDisplay * .3, native.systemFont, 16 )
accuracy = display.newText( "accuracy :", xLocationDisplay, yLocationDisplay * .4, native.systemFont, 16 )
speed = display.newText( "speed :", xLocationDisplay, yLocationDisplay * .5, native.systemFont, 16 )
direction = display.newText( "direction :", xLocationDisplay, yLocationDisplay * .6, native.systemFont, 16 )
time = display.newText( "time :", xLocationDisplay, yLocationDisplay * .7, native.systemFont, 16 )

 -- Keep track of time in seconds
 local secondsLeft = math.random( 75, 120 )
 local initialMinutes = math.floor( secondsLeft / 60 )
 local initialSeconds = secondsLeft % 60

 local clockText = display.newText(string.format( "%02d:%02d", initialMinutes, initialSeconds), display.contentCenterX, yDisplay * .1, native.systemFont, yDisplay * .09)

 local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
    composer.removeScene( "scenes.menu", false )
    composer.gotoScene( "scenes.menu", { effect = "crossFade", time = 333 } )
end
end

local function handleLevelSelect( event )

    if ( "ended" == event.phase ) then
        -- set the current level to the ID of the selected level
        myData.settings.currentLevel = event.target.id
        composer.removeScene( "scenes.game", false )
        composer.gotoScene( "scenes.game", { effect = "crossFade", time = 333 } )
    end
end
--
-- Start the composer event handlers
--
function scene:create( event )
    local sceneGroup = self.view

    params = event.params
    
    --
    -- setup a page background, really not that important though composer
    -- crashes out if there isn't a display object in the view.
    --


    local background = display.newRect( 0, 0, 570, 360)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:setFillColor( 0, 0, 0 )
    sceneGroup:insert(background)

    local doneButton = widget.newButton({
        id = "button1",
        label = "Done",
        width = 100,
        height = 32,
        onEvent = handleButtonEvent
        })
    doneButton.x = display.contentCenterX
    doneButton.y = display.contentHeight - 40
    sceneGroup:insert( doneButton )

    sceneGroup:insert(latitude)
    sceneGroup:insert(longitude)
    sceneGroup:insert(altitude)
    sceneGroup:insert(accuracy)
    sceneGroup:insert(speed)
    sceneGroup:insert(direction)
    sceneGroup:insert(time)
    sceneGroup:insert(clockText)
end

function scene:show( event )
    local sceneGroup = self.view

    params = event.params

    if event.phase == "did" then

    end
end

function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
    end

end

function scene:destroy( event )
    local sceneGroup = self.view
    
end


local locationHandler = function( event )
 
    -- Check for error (user may have turned off location services)
    if ( event.errorCode ) then
        native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
        print( "Location error: " .. tostring( event.errorMessage ) )
    else
        local latitudeText = string.format( '%.4f', event.latitude )
        latitude.text = latitude.text .. latitudeText
        
        local longitudeText = string.format( '%.4f', event.longitude )
        longitude.text = longitude.text .. longitudeText
        
        local altitudeText = string.format( '%.3f', event.altitude )
        altitude.text = altitude.text .. altitudeText
        
        local accuracyText = string.format( '%.3f', event.accuracy )
        accuracy.text = accuracy.text .. accuracyText
        
        local speedText = string.format( '%.3f', event.speed )
        speed.text = speed.text .. speedText
        
        local directionText = string.format( '%.3f', event.direction )
        direction.text = direction.text .. directionText
        
        -- Note that 'event.time' is a Unix-style timestamp, expressed in seconds since Jan. 1, 1970
        local timeText = string.format( '%.0f', event.time )
        time.text = time.text .. timeText
    end
end


local function updateTime()
    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1
    
    -- time is tracked in seconds.  We need to convert it to minutes and seconds
    local minutes = math.floor( secondsLeft / 60 )
    local seconds = secondsLeft % 60
    
    -- make it a string using string format.  
    local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
    clockText.text = timeDisplay
end

-- run them timer
local countDownTimer = timer.performWithDelay( 1000, function() updateTime() end, 0 )

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- Activate location listener
Runtime:addEventListener( "location", locationHandler )
return scene
