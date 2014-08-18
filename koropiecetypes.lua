piecetypes = {
	{ blocks = { {1,1}, {1,2}, {2,1}, {2,2} }, origin = {1.5, 1.5}, color = {255, 255, 200}, previewoffset = {-0.5, 0} },
	{ blocks = { {1,0}, {1,1}, {1,2}, {1,3} }, origin = {1.5, 1.5}, color = {255, 200, 255} },
	{ blocks = { {0,1}, {1,1}, {2,1}, {2,2} }, origin = {1, 1}, color = {200, 255, 255} },
	{ blocks = { {0,2}, {0,1}, {1,1}, {2,1} }, origin = {1, 1}, color = {255, 200, 200} },
	{ blocks = { {0,2}, {1,2}, {1,1}, {2,1} }, origin = {1, 1}, color = {200, 255, 200} },
	{ blocks = { {0,1}, {1,1}, {1,2}, {2,2} }, origin = {1, 1}, color = {200, 200, 255} },
	{ blocks = { {0,1}, {1,1}, {1,2}, {2,1} }, origin = {1, 1}, color = {255, 255, 255} },

	random = function()
		local randindex = math.random(1, #piecetypes)
		return piecetypes[randindex].blocks, piecetypes[randindex].origin, piecetypes[randindex].color, piecetypes[randindex].previewoffset
	end
}