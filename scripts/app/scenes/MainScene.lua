
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
    echo(cursor:getContentSize().width)
    texiao=CCParticleSystemQuad:create("eff_fly_yellow.plist")
    cursor:addChild(texiao)
    mc=display.newScale9Sprite("3.png"):pos(display.cx,display.cy):addTo(self,0,mc)   
    mc:setTouchEnabled(true)
    streak=CCMotionStreak:create(0.5, 1, 30, ccc3(255, 255, 255), "bgTile.png")
    self:addChild(streak)
    streak:setPosition(ccp(480, 320))
    mc:addTouchEventListener( function(event,x,y)
        if event=="began" then 
            mc:setScale(1.1)
           cursor:setZOrder(1)
            echo(tostring(mc:getPositionX()))
            --cursor:pos(mc:getWidth()/2,mc:getHeight()/2)
        end
        if event=="moved"
            then cursor:pos(x,y)
            streak:setPosition(ccp(x, y))
        end

        if event=="ended" then 
            mc:setScale(1.0)
            cursor:setZOrder(-1)
            cursor:pos(display.cx,display.cy)
            streak:setPosition(ccp(480, 320))
        end
        echo(event)
        echo(x,y)
       return true
    end)
end

function MainScene:onExit()
end

return MainScene
