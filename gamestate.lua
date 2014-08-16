function gamestate()
	local state = {}

	state.states = {}
	state.activestate = nil

	function state:add(key, state)
		self.states[key] = state
		state.state = self
	end

	function state:keypressed(key)
		if self.activestate then
			self.activestate:keypressed(key)
		end
	end

	function state:keyreleased(key)
		if self.activestate then
			self.activestate:keyreleased(key)
		end
	end

	function state:enter(name)
		--Exit currently active stave
		if self.activestate then self:exit() end

		self.activestate = self.states[name]

		if self.activestate then
			self.activestate:enter()
		end
	end

	function state:exit()
		if self.activestate then
			self.activestate:exit()
			self.activestate = nil
		end
	end

	function state:update(dt)
		if self.activestate then
			self.activestate:update(dt)
		end
	end

	function state:draw()
		if self.activestate then
			self.activestate:draw()
		end
	end

	return state
end