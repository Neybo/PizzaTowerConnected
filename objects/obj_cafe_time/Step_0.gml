if !markfordeath
	currenty = Approach(currenty, targety, 8, false)
else
{
	currenty = Approach(currenty, 210, 8, false) 
	if currenty >= 210
		instance_destroy()
}