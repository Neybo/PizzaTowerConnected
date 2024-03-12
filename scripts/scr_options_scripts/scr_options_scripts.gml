function performance_destroy(){
	if global.performancemode
	{
		surf = -4
		instance_destroy()
		return true
	}
	return false
}

function scr_pizzyphys_check(char = character)
{
	return (global.pizzyphys == 2 && char == "SP") || global.pizzyphys == 1
}