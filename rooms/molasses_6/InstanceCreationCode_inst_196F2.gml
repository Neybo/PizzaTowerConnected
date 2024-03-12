player = noone;
trigger = function()
{
	player = instance_place(x, y - 1, obj_player);
	if player && player.state == states.freefallland
		return true;
	return false;
}
func = function()
{
	if player
		instance_create(player.x, player.y, obj_hiddenobjecttrigger);
	instance_destroy();
}
