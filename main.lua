push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'



WIN_HEIGHT = 720
WIN_WIDTH = 1280
V_HEIGHT = 243
V_WIDTH = 432
PADDLE_SPEED = 200
R = 40/255
G = 45/255
B = 52/255
A = 255/255



function love.load()
    -- rseed = math.random()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(V_WIDTH, V_HEIGHT, WIN_WIDTH, WIN_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    }) 

    paddle_1 = Paddle(5, 20, 5, 20)
    paddle_2 = Paddle(V_WIDTH - 10,  V_HEIGHT - 30, 5, 20)

    game_state = 'start'

    player_1_score = 0
    player_2_score = 0
    
    
    
    ball_x = V_WIDTH / 2 - 2
    ball_y = V_HEIGHT / 2 - 2

    ball_dx = math.random(2) == 1 and -100 or 100
    ball_dy = math.random(-50, 50)
    
    
end

-- move players in relation to frame rate
--[[
0,0 ------- width,0
|              |
|              |
0,height -- width,height
-- ]]
function love.update(dt)
    paddle_1:update(dt)
    paddle_2:update(dt)
    
    if love.keyboard.isDown('w') then
        paddle_1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        paddle_1.dy = PADDLE_SPEED
    else
        paddle_1.dy = 0
    end

    if love.keyboard.isDown('up') then
        paddle_2 = -PADDLE_SPEED
    elseif love.keyboard.isDown('down')  then
        paddle_2 = PADDLE_SPEED
    else
        paddle_2 = 0
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
    paddle_1:render() --left paddle
    -- paddle_2:render() --right paddle
    
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