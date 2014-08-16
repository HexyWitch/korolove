require "gamestate"
require "playstate"

window = {
	height = 575,
	width = 500
}

assets = {
	graphics = {},
	fonts = {},
	sounds = {}
}

function love.load()
	math.randomseed(os.time())

	assets.graphics.background = love.graphics.newImage("assets/background.png")
	assets.graphics.block = love.graphics.newImage("assets/block.png")

	state = gamestate()
	state:add("playstate", playstate)

	state:enter("playstate")
end

function love.draw()

	state:draw()
end

function love.update(dt)
	state:update(dt)
end

function love.keypressed(key, isrepeat)
	if not isrepeat then
		state:keypressed(key)
	end
end

function love.keyreleased(key)
	state:keyreleased(key)
end

