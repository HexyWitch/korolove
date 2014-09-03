require "blockgrid"
require "koropiece"
require "koropiecetypes"

playstate = {}

function playstate:enter()
	self.blockgrid = blockgrid(25, 10, 22, 25)

	self.baseupdateinterval = 0.5
	self.fastupdateinterval = 0.05
	self.updateinterval = self.baseupdateinterval
	self.updatetimer = 0

	self.score = 0

	self:firstpiece()

	if assets.sounds.music then
		assets.sounds.music:setLooping(true)
		assets.sounds.music:setVolume(0.3)
		assets.sounds.music:play()
	end
end

function playstate:keypressed(key, isrepeat)
	if key == "up" and not isrepeat then
		self:rotatepiece()
	end
	if key == "down" and not isrepeat then
		self.updateinterval = self.fastupdateinterval
		self.isfastinterval = true
	end
	if key == "left" then
		self:movepieceleft()
	end
	if key == "right" then
		self:movepieceright()
	end
end

function playstate:keyreleased(key)
	if key == "down" then
		self.updateinterval = self.baseupdateinterval
		self.isfastinterval = false
	end
end

function playstate:update(dt)
	if not self.isfastinterval then self.updateinterval = self.baseupdateinterval end

	self.updatetimer = self.updatetimer + dt
	if self.updatetimer > self.updateinterval then

		--Check if we can move the block down
		if self.blockgrid:validateblocks(self.activepiece:movedblocks(0, 1)) then
			self.activepiece:move(0, 1)
		else
			--Can't move it down, delete the piece and place blocks in the grid
			self.blockgrid:placepiece(self.activepiece)

			local cleared = self.blockgrid:clearemptyrows()
			if cleared then
				self.baseupdateinterval = self.baseupdateinterval * 0.95
				assets.sounds.clear:play()


				for i = 0, cleared - 1 do
					self.score = self.score + 100
					self.score = self.score + 50 * i
				end

			else
			    assets.sounds.blip:play()
			end

			self:newpiece()
		end

		--Check for cleared rows

		self.updatetimer = 0
	end
end

function playstate:draw()
	love.graphics.draw(assets.graphics.background, 0, 0)
	self.blockgrid:draw()
	self.blockgrid:drawpiece(self.activepiece)
	self:drawnextpiece()

	self:drawscore()
end

function playstate:exit()
	if assets.sounds.music then
		assets.sounds.music:pause()
	end
end

function playstate:rotatepiece()
	local rotated = self.activepiece:offsetblocks(self.activepiece:rotatedblocks(), {0,0})
	if self.blockgrid:validateblocks(rotated) then
		self.activepiece:rotate()
	end
end

function playstate:newpiece()
	self.activepiece = self.nextpiece
	self.nextpiece = koropiece(piecetypes.random())

	local yoffset = self.activepiece:lowestblock()
	self.activepiece.position = {4, -yoffset}

	local placed = self.activepiece:offsetblocks(self.activepiece.blocks, {0,0})

	if not self.blockgrid:validateblocks(placed) then
		self.state:enter("endstate", {blockgrid = self.blockgrid, score = self.score})
	end
end

function playstate:firstpiece()
	self.nextpiece = koropiece(piecetypes.random())
	playstate:newpiece()
end

function playstate:movepieceleft()
	if self.blockgrid:validateblocks(self.activepiece:movedblocks(-1, 0)) then
		self.activepiece:move(-1, 0)
	end
end

function playstate:movepieceright()
	if self.blockgrid:validateblocks(self.activepiece:movedblocks(1, 0)) then
		self.activepiece:move(1, 0)
	end
end

function playstate:drawnextpiece()
	love.graphics.draw(assets.graphics.nextpiece, 316, 44) --Box around the piece
	self.nextpiece:draw({326, 54}, 25, true)
end

function playstate:drawscore()
	love.graphics.draw(assets.graphics.scorebox, 316, 400)

	love.graphics.setFont(assets.fonts.freesans26)
	love.graphics.printf(self.score, 326, 404, 75, "right")
end