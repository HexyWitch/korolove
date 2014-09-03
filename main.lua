require "gamestate"
require "playstate"
require "startstate"
require "endstate"

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
	assets.graphics.nextpiece = love.graphics.newImage("assets/nextpiece.png")
	assets.graphics.scorebox = love.graphics.newImage("assets/scorebox.png")

	if love.filesystem.exists("assets/losthero.ogg") then
		assets.sounds.music = love.audio.newSource("assets/losthero.ogg", "stream")
	end
	assets.sounds.blip = love.audio.newSource("assets/blip.wav", "static")
	assets.sounds.clear = love.audio.newSource("assets/clear.wav", "static")

	local charmap=" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    assets.fonts.freesans26 = love.graphics.newImageFont("assets/freesans-26.png", charmap)

	love.keyboard.setKeyRepeat(true)

	state = gamestate()
	state:add("playstate", playstate)
	state:add("startstate", startstate)
	state:add("endstate", endstate)

	state:enter("startstate")
end

function love.draw()

	state:draw()
end

function love.update(dt)
	state:update(dt)
end

function love.keypressed(key, isrepeat)
	state:keypressed(key, isrepeat)
end

function love.keyreleased(key)
	state:keyreleased(key)
end

