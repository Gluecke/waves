local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "scripts.utility" )
local myData = require( "scripts.mydata" )
local timeService = require( "scripts.timeService" )
local locationHandler = require( "scripts.locationHandler" )

local params

local xDisplay = display.contentWidth
local yDisplay = display.contentHeight

--text for displaying location information
local locationData = {}
locationData.xLocationDisplay = xDisplay * .5
locationData.yLocationDisplay = yDisplay;
locationData.latitude = display.newText( "latitude : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .1, native.systemFont, 16 )
locationData.longitude = display.newText( "longitude : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .2, native.systemFont, 16 )
locationData.altitude = display.newText( "altitude : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .3, native.systemFont, 16 )
locationData.accuracy = display.newText( "accuracy : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .4, native.systemFont, 16 )
locationData.speed = display.newText( "speed : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .5, native.systemFont, 16 )
locationData.direction = display.newText( "direction : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .6, native.systemFont, 16 )
locationData.time = display.newText( "time : %", locationData.xLocationDisplay, locationData.yLocationDisplay * .7, native.systemFont, 16 )

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
    composer.removeScene( "scenes.menu", true )
    composer.gotoScene( "scenes.menu", { effect = "crossFade", time = 333 } )
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

    sceneGroup:insert(locationData.latitude)
    sceneGroup:insert(locationData.longitude)
    sceneGroup:insert(locationData.altitude)
    sceneGroup:insert(locationData.accuracy)
    sceneGroup:insert(locationData.speed)
    sceneGroup:insert(locationData.direction)
    sceneGroup:insert(locationData.time)

     -- Keep track of time in seconds
     local clockProperties = {}
     clockProperties.secondsLeft = math.random( 75, 120 )
     local initialMinutes = math.floor(  clockProperties.secondsLeft / 60 )
     local initialSeconds =  clockProperties.secondsLeft % 60

     clockProperties.clockText = display.newText(string.format( "%02d:%02d", initialMinutes, initialSeconds), 
        display.contentCenterX, 
        yDisplay * .8, 
        native.systemFont, 
        yDisplay * .09)

     sceneGroup:insert(clockProperties.clockText)
     
     local countDownTimer = timer.performWithDelay( 1000, function() timeService.updateTime(clockProperties) end, 0 )

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

-- run them timer


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
function forwardLocation(event) 
    locationHandler.locationHandler(event, locationData)
end
Runtime:addEventListener( "location", forwardLocation )
return scene
