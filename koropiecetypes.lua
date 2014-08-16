piecetypes = {
	{ blocks = { {1,0}, {1,1}, {2,0}, {2,1} }, origin = {1.5, 0.5} },
	{ blocks = { {1,0}, {1,1}, {1,2}, {1,3} }, origin = {1.5, 1.5} },
	{ blocks = { {0,0}, {1,0}, {2,0}, {2,1} }, origin = {1, 0} },
	{ blocks = { {0,1}, {0,0}, {1,0}, {2,0} }, origin = {1, 0} },
	{ blocks = { {0,1}, {1,1}, {1,0}, {2,0} }, origin = {1, 0} },
	{ blocks = { {0,0}, {1,0}, {1,1}, {2,1} }, origin = {1, 0} },
	{ blocks = { {0,0}, {1,0}, {1,1}, {2,0} }, origin = {1, 0} },

	random = function()
		local randindex = math.random(1, #piecetypes)
		return piecetypes[randindex].blocks, piecetypes[randindex].origin
	end
}