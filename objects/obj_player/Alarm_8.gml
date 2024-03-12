/// @description states.normal if hurt
if state == states.hurt or state == states.backbreaker
{
	state = states.normal;
	if (fuckyouteleporter > 0)
		movespeed = fuckyouteleporter
	else
		movespeed = 0;
	fuckyouteleporter = 0 
}
