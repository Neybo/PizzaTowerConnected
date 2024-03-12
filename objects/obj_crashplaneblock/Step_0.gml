var player = instance_place(x, y + 1, obj_player);
if player && alarm[0] < 1
{
	instance_create(player.x, player.y, obj_crashingplane)
	alarm[0] = 30
}