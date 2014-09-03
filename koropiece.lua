require "vec2"

-- blocks is a table of integer offsets for the blocks that constitute the play piece, {0, 0} is the leftmost bottommost block
function koropiece(blocks, origin, color, previewoffset)
	local drawrect = love.graphics.rectangle

	local piece = {}

	piece.blocks = blocks
	piece.origin = origin
	piece.position = {0, 0}
	piece.color = color or {255, 255, 255}
	piece.previewoffset = previewoffset or {0, 0}

	function piece:move(x, y)
		self.position[1] = self.position[1] + x
		self.position[2] = self.position[2] + y
	end

	function piece:rotatedblocks()
		local newblocks = {}

		for _,block in ipairs(self.blocks) do
			local offsetblock = vec2.sub(block, self.origin)
			local rotated = {offsetblock[2], -offsetblock[1]} --This rotates the block offset ccw around 0,0
			rotated = vec2.round(vec2.add(rotated, self.origin))
			table.insert(newblocks, rotated)
		end

		return newblocks
	end

	function piece:lowestblock()
		local lowest = 0

		for _,block in ipairs(self.blocks) do
			if block[2] > lowest then lowest = block[2] end
		end
		return lowest
	end

	function piece:offsetblocks(blocks, offset)
		local movedblocks = {}
		local newposition = {self.position[1] + offset[1], self.position[2] + offset[2]}

		for _,block in ipairs(blocks) do
			local moved = {block[1] + newposition[1], block[2] + newposition[2]}
			table.insert(movedblocks, moved)
		end

		return movedblocks
	end

	function piece:rotate()
		self.blocks = self:rotatedblocks()
	end

	function piece:movedblocks(x, y)
		return self:offsetblocks(self.blocks, {x, y})
	end

	function piece:draw(offset, blocksize, preview)
		preview = preview or false
		if preview then offset = vec2.add(offset, vec2.mul(self.previewoffset, {blocksize, blocksize})) end

		love.graphics.setColor(unpack(self.color))
		for _,block in ipairs(self.blocks) do
			local xpos = block[1] * blocksize + offset[1]
			local ypos = block[2] * blocksize + offset[2]
			love.graphics.draw(assets.graphics.block, xpos, ypos)
		end
		love.graphics.setColor({255, 255, 255})
	end

	return piece
end