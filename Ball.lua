Ball = Class{}

function Ball:init(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
    
end

function Ball:reset()
    self.x = V_WIDTH / 2 - 2
    self.y = V_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + ball.dx * dt 
    self.y = self.y + ball.dy * dt
end

function Ball:render()
    
    -- draw rect for pong ball      
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)

end


