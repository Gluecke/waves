TimeService = {}

function getTimeLeft()
	local countDown = {}

 --    local secondsLeft = inSecondsLeft.secondsLeft - 1
 --    minutes = math.floor( secondsLeft / 60 )
 --    seconds = secondsLeft % 60
	-- countDown.secondsLeft = secondsLeft


	-- countDown.timeLeft = string.format( "%02d:%02d", minutes, seconds )

	 print("Test function called")

	return countDown
end

TimeService.getTimeLeft = getTimeLeft
return TimeService