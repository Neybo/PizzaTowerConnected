var player = instance_place(x, y, obj_player);
if player && player.state == states.climbwall
{
	with instance_create(player.x, player.y + 43, obj_debris)
	{
		sprite_index = spr_molassesgoop
		vsp = -player.vsp / 3
	}
}
