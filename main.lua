WIN_HEIGHT = 720
WIN_WIDTH = 1280
V_HEIGHT = 243
V_WIDTH = 432
PADDLE_SPEED = 200
R = 40/255
G = 45/255
B = 52/255
A = 255/255
push = require 'push'


function love.load()
    rseed = math.random()
    math.randomseed(rseed)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    game_state = 'start'

    player_1_score = 0
    player_2_score = 0
    player_1_y = 30
    player_2_y = V_HEIGHT - 40
    
    ball_x = V_WIDTH / 2 - 2
    ball_y = V_HEIGHT / 2 - 2

    ball_dx = math.random(2) == 1 and -100 or 100
    ball_dy = math.random(-50, 50)
    push:setupScreen(V_WIDTH, V_HEIGHT, WIN_WIDTH, WIN_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    }) 
    
end

-- move players in relation to frame rate
--[[
0,0 ------- width,0
|              |
|              |
0,height -- width,height
-- ]]
function love.update(dt)
    if love.keyboard.isDown('w') then
        player_1_y = math.max(0, player_1_y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player_1_y = math.min(V_HEIGHT-20, player_1_y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        player_2_y = math.max(0, player_2_y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down')  then
        player_2_y = math.min(V_HEIGHT-20, player_2_y + PADDLE_SPEED * dt) 
    end

    if game_state == 'play' then
        ball_x = ball_x + ball_dx * dt 
        ball_y = ball_y + ball_dy * dt
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
        -- pause and start game functionality 
    elseif key == 'return' or key == 'enter' then
        if game_state == 'start' then
            game_state = 'play'
        elseif game_state == 'play' then
            game_state = 'start'
        end
    end
end

function love.draw()
    -- use virtual resolution
    push:apply('start')
    -- change bg color using RGBA colors
    love.graphics.clear(R, G, B, A)
    
    -- draw rect for pong ball      
    love.graphics.rectangle('fill', ball_x, ball_y, 4, 4)

    -- draw paddles on both sides
    love.graphics.rectangle('fill', 5, player_1_y, 5, 20) --left paddle
    love.graphics.rectangle('fill', V_WIDTH-10,player_2_y, 5, 20) --right paddle
    
    love.graphics.print(player_1_score, V_WIDTH/2 - 50, V_HEIGHT / 3)
    love.graphics.print(player_2_score, V_WIDTH/2 + 50, V_HEIGHT / 3)
    love.graphics.printf(
        "Hello Pong", 
        0, 
        20, 
        V_WIDTH, 
        'center')
    push:apply('end')
end