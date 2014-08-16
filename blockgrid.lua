function blockgrid(borderwidth, xw, yw, blocksize)
	local drawrect = love.graphics.rectangle

	local blockgrid = {
		borderwidth = borderwidth,
		gridwidth = blocksize * xw,
		numxblocks = xw,
		numyblocks = yw,
		blocksize = blocksize,

		blocks = {}
	}

	function blockgrid:drawblocks()
		for y = 1, self.numyblocks do
			for x = 1, self.numxblocks do
				if self:getblock(x, y) then
					self:drawblock(x, y)
				end
			end 
		end
	end

	function blockgrid:drawpiece(piece)
		local offset = {self.borderwidth + (piece.position[1]-1) * self.blocksize, (piece.position[2]-1) * self.blocksize}
		piece:draw(offset, self.blocksize)
	end

	function blockgrid:drawblock(x, y)
		local xpos = self.borderwidth + (x-1) * self.blocksize
		local ypos = (y-1) * self.blocksize
		drawrect("fill", xpos, ypos, self.blocksize, self.blocksize)
	end

	function blockgrid:draw()
		self:drawblocks()
	end

	function blockgrid:blockindex(x, y)
		return (y-1) * self.numxblocks + x
	end

	function blockgrid:setblock(x, y, value)
		local index = self:blockindex(x, y)
		self.blocks[index] = value
	end

	function blockgrid:placepiece(piece)
		for _,block in ipairs(piece.blocks) do
			local placeblock = {block[1] + piece.position[1], block[2] + piece.position[2]}
			self:setblock(placeblock[1], placeblock[2], true)
		end
	end

	function blockgrid:getblock(x, y)
		local index = self:blockindex(x, y)
		return self.blocks[index]
	end

	function blockgrid:update(dt)
	end

	function blockgrid:inside(blockpos)
		if blockpos[1] >= 1 and blockpos[1] <= self.numxblocks and blockpos[2] <= self.numyblocks then
			return true
		end
		return false
	end

	function blockgrid:validateblocks(blocks)
		for _,block in ipairs(blocks) do
			local blockpos = {block[1], block[2]}
			drawrect("fill", block[1] + 10, block[2] + 10, 10, 10)
			if not self:inside(blockpos) or self:getblock(blockpos[1], blockpos[2]) then
				return false
			end
		end
		return true
	end

	function blockgrid:clearemptyrows()
		local sweepdown = false

		local y = self.numyblocks
		while y > 0 do
			local rowisfull = true
			for x = 1, self.numxblocks do
				if not self:getblock(x, y) then rowisfull = false end
			end

			if rowisfull then
				self:sweepdown(y)
				y = self.numyblocks --Do this row again because blocks have moved down
			else
				y = y - 1
			end
		end
	end

	--Moves all blocks down that are higher than fromY
	function blockgrid:sweepdown(fromY)
		for y = fromY, 1, -1 do
			for x = 1, self.numxblocks do
				local aboveblock = self:getblock(x, y - 1)
				self:setblock(x, y, aboveblock)
			end
		end
	end

	return blockgrid
end