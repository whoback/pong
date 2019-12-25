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
    love.window.setTitle('Pong')
    push:setupScreen(V_WIDTH, V_HEIGHT, WIN_WIDTH, WIN_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    }) 
    player_1 = Paddle(5, 20, 5, 20)
    player_2 = Paddle(55, 20, 5, 20)
    
    player_1_score = 0
    player_2_score = 0
    
    ball_x = V_WIDTH / 2 - 2
    ball_y = V_HEIGHT / 2 - 2

    
    ball = Ball(V_WIDTH / 2 - 2, V_HEIGHT/2 - 2, 4, 4)
    game_state = 'start'
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
        player_1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player_1.dy = PADDLE_SPEED
    else
        player_1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player_2 = -PADDLE_SPEED
    elseif love.keyboard.isDown('down')  then
        player_2 = PADDLE_SPEED
    else
        player_2 = 0
    end

    if game_state == 'play' then
        ball:update(dt)
    end

    player_1:update(dt)
    player_2:update(dt)
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
            ball:reset()
        end
    end
end

function love.draw()
    -- use virtual resolution
    push:apply('start')
    -- change bg color using RGBA colors
    love.graphics.clear(R, G, B, A)
    
    
    love.graphics.print(player_1_score, V_WIDTH/2 - 50, V_HEIGHT / 3)
    love.graphics.print(player_2_score, V_WIDTH/2 + 50, V_HEIGHT / 3)
    love.graphics.printf(
        "Hello Pong", 
        0, 
        20, 
        V_WIDTH, 
        'center')
    

        -- draw paddles on both sides
    player_1:render() --left paddle
    player_2:render() --right paddle
    ball:render()
    push:apply('end')
end