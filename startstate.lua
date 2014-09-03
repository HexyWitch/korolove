startstate = {}

function startstate:enter()
    self.score = 0
end

function startstate:keypressed(key, isrepeat)
    self.state:enter("playstate")
end

function startstate:keyreleased(key)
end

function startstate:update(dt)
end

function startstate:draw()
    love.graphics.draw(assets.graphics.nextpiece, 316, 44) --Box around the piece
    love.graphics.draw(assets.graphics.background, 0, 0)

    love.graphics.setColor(126, 255, 126, 255);
    love.graphics.setFont(assets.fonts.freesans26)
    love.graphics.printf("KOROLOVE", 25, 50, 250, "center")
    love.graphics.printf("PRESS ANY KEY TO START", 25, 150, 250, "center")
    love.graphics.setColor(255, 255, 255, 255)

    self:drawscore()
end

function startstate:exit()
end


function startstate:drawscore()
    love.graphics.draw(assets.graphics.scorebox, 316, 400)

    love.graphics.setFont(assets.fonts.freesans26)
    love.graphics.printf(self.score, 326, 404, 75, "right")
end