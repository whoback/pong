WIN_HEIGHT = 720
WIN_WIDTH = 1280
V_HEIGHT = 243
V_WIDTH = 432

push = require 'push'


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(V_WIDTH, V_HEIGHT, WIN_WIDTH, WIN_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    }) 
    
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')
    love.graphics.printf(
        "Hello Pong", 
        0, 
        V_HEIGHT / 2, 
        V_HEIGHT, 
        'center')
    push:apply('end')
end