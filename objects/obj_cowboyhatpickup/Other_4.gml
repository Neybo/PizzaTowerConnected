try
{
	if check_hat(hat)
		instance_destroy();
}
catch (e)
{
	e = 0
	if check_hat(HATS.cowboy2)
		instance_destroy();
}