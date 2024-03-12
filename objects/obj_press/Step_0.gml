if instance_exists(ID)
{
	if ID.press >= 8
		instance_destroy();
	y = ID.y - 75;
}
else
	instance_destroy()
