local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "scripts.utility" )
local ads = require( "ads" )

local params

local sceneConfigData = require( "scripts.sceneConfigData" )

local function handlePlayButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.removeScene( "scenes.scene1", true )
        composer.gotoScene("scenes.scene1", { effect = "crossFade", time = 333 })
    end
end

local function handleHelpButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene("scenes.help", { effect = "crossFade", time = 333, isModal = true })
    end
end

local function handleCreditsButtonEvent( event )

    if ( "ended" == event.phase ) then
        composer.gotoScene("scenes.gamecredits", { effect = "crossFade", time = 333 })
    end
end

local function handleSettingsButtonEvent( event )

    if ( "ended" == event.phase ) then
        composer.gotoScene("scenes.gamesettings", { effect = "crossFade", time = 333 })
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

    local xDisplay = display.contentWidth
    local yDisplay = display.contentHeight

    local background = display.newRect( 0, 0, xDisplay, yDisplay )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

backgroundColors = {}

    backgroundColors.r = sceneConfigData.r
     backgroundColors.g = sceneConfigData.g
     backgroundColors.b = sceneConfigData.b
     backgroundColors.a = sceneConfigData.a

     background:setFillColor( backgroundColors.r,
        backgroundColors.g, 
        backgroundColors.b,
        backgroundColors.a)
     sceneGroup:insert(background)

     local sun = display.newImage( "losesun.png", xDisplay * .5, yDisplay * .33 )
     sun:scale(.2, .2)
     sceneGroup:insert(sun)

    local title = display.newText("IRL Endless", 100, 32, "wavy", 45 )
    local subTitle = display.newText("Runner", 100, 32, "wavy", 45 )
    subTitle.x = xDisplay * .5
    subTitle.y = yDisplay * .78
    title.x = xDisplay * .5
    title.y = yDisplay * .7

local gradient = {
    type="gradient",
    color1={ 1, 1, 0 }, color2={ 1, 1, .9 }, direction="down"
}

    subTitle:setFillColor(gradient  )
    title:setFillColor( gradient )
    sceneGroup:insert( title )
    sceneGroup:insert( subTitle )

    -- Create the widget
    local playButton = widget.newButton({
        id = "button1",
        label = "Play",
        width = 100,
        height = 32,
        onEvent = handlePlayButtonEvent
    })
    playButton.x = xDisplay * .5
    playButton.y = yDisplay * .875
    sceneGroup:insert( playButton )

    -- Create the widget
    local settingsButton = widget.newButton({
        id = "button2",
        label = "Settings",
        width = 100,
        height = 32,
        onEvent = handleSettingsButtonEvent
    })
    settingsButton.x = xDisplay * .25
    settingsButton.y = yDisplay * .95
    sceneGroup:insert( settingsButton )

    -- Create the widget
    local creditsButton = widget.newButton({
        id = "button4",
        label = "Credits",
        width = 100,
        height = 32,
        onEvent = handleCreditsButtonEvent
    })
    creditsButton.x = xDisplay * .75
    creditsButton.y = yDisplay * .95
    sceneGroup:insert( creditsButton )

end

function scene:show( event )
    local sceneGroup = self.view

    params = event.params
    utility.print_r(event)

    if params then
        print(params.someKey)
        print(params.someOtherKey)
    end

    if event.phase == "did" then
        composer.removeScene( "scenes.game" ) 
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

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
