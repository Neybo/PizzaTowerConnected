img += imgspd
if !goingdown
	currenty = Approach(currenty, targety, 10, false)
else
{
	currenty = lerp(currenty, targety, 0.04)
	if currenty >= 410
		instance_destroy()
}