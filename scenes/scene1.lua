local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "scripts.utility" )
local sceneConfigData = require( "scripts.sceneConfigData" )
local timeService = require( "scripts.timeService" )
local locationHandler = require( "scripts.locationHandler" )
local adjustColorService = require("scripts.adjustColorService")

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


--var to be used for time before player dies
local timeToRed 


--vars related to indicator background
local indicatorBackground

local indicatorBackgroundColors = {}

local indicatorBackgroundRedShiftTimerDelay = 100
local incrementRed
local indicatorBackgroundRedShiftTimer


local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then 
    composer.removeScene( "scenes.menu", true ) composer.gotoScene( "scenes.menu", { effect = "crossFade", time = 333 } ) end
end
--
-- Start the composer event handlers
--

function scene:create( event )
    local sceneGroup = self.view

    params = event.params

     -- time before player dies
     local t = os.date( '*t' )  -- get table of current date and time
     math.randomseed(utility.round(os.time(t), -1))
     timeToRed = math.random( sceneConfigData.lowerBoundTimeToRed, sceneConfigData.upperBoundTimeToRed )

     --amount needed to incredment red rgb value to get to 1 in the timeToRed seconds
     incrementRed = (1 / (timeToRed * (1000 / indicatorBackgroundRedShiftTimerDelay)))


     local clockProperties = {}
     clockProperties.secondsLeft = timeToRed
     local initialMinutes = math.floor(  clockProperties.secondsLeft / 60 )
     local initialSeconds =  clockProperties.secondsLeft % 60

     clockProperties.clockText = display.newText(string.format( "%02d:%02d", initialMinutes, initialSeconds), 
        display.contentCenterX, 
        yDisplay * .8, 
        native.systemFont, 
        yDisplay * .09)

     sceneGroup:insert(clockProperties.clockText)
     
     local countDownTimer = timer.performWithDelay( 1000, function() timeService.updateTime(clockProperties) end, 0 )

     -- local ambientBackground = display.newRect( 0, 0, xDisplay, yDisplay * .5)
     -- ambientBackground.x = display.contentCenterX
     -- ambientBackground.y = display.contentCenterY
     -- ambientBackground:setFillColor( 255, 255, 255 )
     -- sceneGroup:insert(ambientBackground)

     indicatorBackground = display.newRect( 0, 0, xDisplay, yDisplay)
     indicatorBackground.x = display.contentCenterX
     indicatorBackground.y = display.contentCenterY

     indicatorBackgroundColors.r = sceneConfigData.r
     indicatorBackgroundColors.g = sceneConfigData.g
     indicatorBackgroundColors.b = sceneConfigData.b
     indicatorBackgroundColors.a = sceneConfigData.a

     indicatorBackground:setFillColor( indicatorBackgroundColors.r,
        indicatorBackgroundColors.g, 
        indicatorBackgroundColors.b,
        indicatorBackgroundColors.a)
     sceneGroup:insert(indicatorBackground)

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
 end

 function scene:show( event )
    local sceneGroup = self.view

    params = event.params

    if event.phase == "did" then

     indicatorBackgroundRedShiftTimer = timer.performWithDelay( indicatorBackgroundRedShiftTimerDelay, 
        function() 
           indicatorBackgroundColors.r = indicatorBackgroundColors.r + incrementRed
           adjustColorService.adjustObjectColor(indicatorBackground, indicatorBackgroundColors) 
           end,
           0 )

 end
end

function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
        timer.cancel(indicatorBackgroundRedShiftTimer)
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
function forwardToLocationHandler(event) 
    locationHandler.locationHandler(event, locationData)
end
Runtime:addEventListener( "location", forwardToLocationHandler )
return scene
