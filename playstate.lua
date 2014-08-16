require "blockgrid"
require "koropiece"
require "koropiecetypes"

playstate = {}

function playstate:enter()
	self.blockgrid = blockgrid(25, 10, 22, 25)

	self.updateinterval = 0.5
	self.updatetimer = 0

	self:firstpiece()
end

function playstate:keypressed(key)
	if key == "up" then
		self:rotatepiece()
	end
	if key == "down" then
		self.updateinterval = 0.05
	end
	if key == "left" then
		self:movepieceleft()
	end
	if key == "right" then
		self:movepieceright()
	end
	if key == "a" then
		local rotated = self.activepiece:offsetblocks(self.activepiece:rotatedblocks(), {0,0})
		for _,block in ipairs(rotated) do
			print(string.format("{%s, %s}", block[1], block[2]))
		end
	end
end

function playstate:keyreleased(key)
	if key == "down" then
		self.updateinterval = 0.5
	end
end

function playstate:update(dt)
	self.updatetimer = self.updatetimer + dt
	if self.updatetimer > self.updateinterval then

		--Check if we can move the block down
		if self.blockgrid:validateblocks(self.activepiece:movedblocks(0, 1)) then
			self.activepiece:move(0, 1)
		else
			--Can't move it down, delete the piece and place blocks in the grid
			self.blockgrid:placepiece(self.activepiece)
			self:newpiece()
		end

		--Check for cleared rows
		self.blockgrid:clearemptyrows()

		self.updatetimer = 0
	end
end

function playstate:draw()
	love.graphics.draw(assets.graphics.background, 0, 0)
	self.blockgrid:draw()
	self.blockgrid:drawpiece(self.activepiece)
	self:drawnextpiece()
end

function playstate:exit()

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
	self.activepiece.position = {5, 0}

	local placed = self.activepiece:offsetblocks(self.activepiece.blocks, {0,0})

	if not self.blockgrid:validateblocks(placed) then
		self.state:enter("playstate")
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
	local position = {340, 100}
	self.nextpiece:draw(position, 25)
end