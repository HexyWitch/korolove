vec2 = {}

function vec2.add(firstvec, secondvec)
	return {firstvec[1] + secondvec[1], firstvec[2] + secondvec[2]}	
end

function vec2.sub(firstvec, secondvec)
	return {firstvec[1] - secondvec[1], firstvec[2] - secondvec[2]}	
end

function vec2.mul(firstvec, secondvec)
	return {firstvec[1] * secondvec[1], firstvec[2] * secondvec[2]}	
end

function vec2.round(vec)
	local x = math.floor(vec[1] + 0.5)
	local y = math.floor(vec[2] + 0.5)
	return {x, y}
end