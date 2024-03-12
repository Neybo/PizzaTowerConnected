if !instance_exists(ID) && place_meeting(x, y, obj_player) && obj_player.state != states.mort
&& obj_player.character != "V" && !global.mort
{
	instance_destroy(obj_mort)
	with instance_create(x, y - 50, obj_mort)
		other.ID = id
}
