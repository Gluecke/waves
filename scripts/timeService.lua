local M = {}
local updateTime = function (clockProperties)
    -- decrement the number of seconds
    clockProperties.secondsLeft = clockProperties.secondsLeft - 1

    -- time is tracked in seconds.  We need to convert it to minutes and seconds
    local minutes = math.floor( clockProperties.secondsLeft / 60 )
    local seconds = clockProperties.secondsLeft % 60
    
    -- make it a string using string format.  
    local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
    clockProperties.clockText.text = timeDisplay
end

M.updateTime = updateTime

return M