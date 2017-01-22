M = {}

function blinkObject(objectToBlink, frequency) 
	transition.blink( objectToBlink, { time=frequency } )
end

M.blinkObject = blinkObject
return M