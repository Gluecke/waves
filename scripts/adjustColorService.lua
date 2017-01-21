local M = {}

local boundColorToLimitOfOne = function (color)
if color > 1  then
	return 1
else
	return color
end
end

local adjustObjectColor = function (objectToChangeColor, colors)
local r, g, b, a

r = boundColorToLimitOfOne(colors.r)
g = boundColorToLimitOfOne(colors.g)
b = boundColorToLimitOfOne(colors.b)
a = boundColorToLimitOfOne(colors.a)

objectToChangeColor:setFillColor(r, g, b, a)
-- print("r: " .. r .. " g: " .. g .. " b: " .. b .. " a: " .. a)
end

M.adjustObjectColor = adjustObjectColor

return M