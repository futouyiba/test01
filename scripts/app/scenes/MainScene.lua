
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    
end

function MainScene:onEnter()
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
    cursor=display.newSprite("bgTile.png"):pos(display.cx,display.cy):addTo(self,-1,cursor)
    mc=display.newSprite("3.png"):pos(display.cx,display.cy):addTo(self,0,mc)   
    mc:setTouchEnabled(true)
    mc:addTouchEventListener( function(event,x,y)
        if event=="began" then 
            mc:setScale(1.1)
           cursor:setZOrder(1)
            echo(tostring(mc:getPositionX()))
            --cursor:pos(mc:getWidth()/2,mc:getHeight()/2)
        end
        if event=="moved"
            then cursor:pos(x,y)
        end

        if event=="ended" then 
            mc:setScale(1.0)
            cursor:setZOrder(-1)
            cursor:pos(display.cx,display.cy)
        end
        echo(event)
       return true
    end)
end

function MainScene:onExit()
end

return MainScene
