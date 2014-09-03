require "blockgrid"

endstate = {}

function endstate:enter(statedata)
    self.blockgrid = statedata.blockgrid
    self.score = statedata.score
end

function endstate:keypressed(key, isrepeat)
    if not isrepeat then 
        self.state:enter("playstate")
    end
end

function endstate:keyreleased(key)
end

function endstate:update(dt)
end

function endstate:draw()
    love.graphics.draw(assets.graphics.background, 0, 0)
    love.graphics.draw(assets.graphics.nextpiece, 316, 44) --Box around the piece
    self.blockgrid:draw()
    self:drawscore()


    love.graphics.setColor(255, 126, 126, 255);
    love.graphics.setFont(assets.fonts.freesans26)
    love.graphics.printf("GAME OVER", 25, 50, 250, "center")
    love.graphics.printf("PRESS ANY KEY TO RESTART", 25, 150, 250, "center")
    love.graphics.setColor(255, 255, 255, 255);
end

function endstate:exit()
end


function endstate:drawscore()
    love.graphics.draw(assets.graphics.scorebox, 316, 400)

    love.graphics.setFont(assets.fonts.freesans26)
    love.graphics.printf(self.score, 326, 404, 75, "right")
end