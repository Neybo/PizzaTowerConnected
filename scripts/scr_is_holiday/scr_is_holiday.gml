enum holidays // have it in binary format so we can stack holidays if needed
{
	none = 1,
	halloween = 2,
	christmas = 4,
	aprilfools = 8,
}

function is_holiday(holiday){
	// this works via
	// 00000001 - halloween
	// 00000011 - christmas && halloween ("global.holiday") for an example
	// 00000001 & 00000011 = 00000001
	// (00000001 = 1) && (1 > 0 = true)
	return holiday & global.holiday
}

function init_holiday()
{
	global.holiday = holidays.none
	
	var date = date_current_datetime()
	var month = date_get_month(date)
	var day = date_get_day(date)
	
	if (month == 10 || (month == 11 && day <= 14))
	    global.holiday |= holidays.halloween
		
	if (month == 12 && day >= 10)
		global.holiday |= holidays.christmas
		
	if month == 4 && day == 1
		global.holiday |= holidays.aprilfools
	
}