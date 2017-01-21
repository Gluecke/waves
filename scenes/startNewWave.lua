local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "scripts.utility" )
local ads = require( "ads" )

local params

local sceneConfigData = require( "scripts.sceneConfigData" )


--
-- Start the composer event handlers
--
function scene:create( event )
    local sceneGroup = self.view
    print("creating startNewWave scene...")

    --
    -- setup a page background, really not that important though composer
    -- crashes out if there isn't a display object in the view.
    --

    composer.removeScene( "scenes.scene1", true )
    composer.gotoScene("scenes.scene1", { effect = "crossFade", time = 333 })

    params = event.params

end

function scene:show( event )
    local sceneGroup = self.view
    print("showing startNewWave scene...")

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
