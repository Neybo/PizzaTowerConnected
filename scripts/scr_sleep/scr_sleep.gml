function scr_sleep(ms)
{
	var time = current_time;
	
	if OLD_GAMEPLAY
		do { } until (current_time - time) >= round(ms);
	
	return current_time - time;
}
