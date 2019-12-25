WIN_HEIGHT = 720
WIN_WIDTH = 1280
V_HEIGHT = 243
V_WIDTH = 432
R = 40/255
G = 45/255
B = 52/255
A = 255/255
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
    -- use virtual resolution
    push:apply('start')
    -- change bg color using RGBA colors
    love.graphics.clear(R, G, B, A)
    -- draw rect for pong ball      
    love.graphics.rectangle('fill', V_WIDTH/2, V_HEIGHT/2, 5, 5)

    -- draw paddles on both sides
    love.graphics.rectangle('fill', 5, 20, 5, 20)
    love.graphics.rectangle('fill', V_WIDTH-10,V_HEIGHT-40, 5, 20)
    love.graphics.printf(
        "Hello Pong", 
        0, 
        20, 
        V_WIDTH, 
        'center')
    push:apply('end')
end