/// @description taxi
if !instance_exists(obj_player)
	exit;

if obj_player.state == states.taxi || obj_player.state == states.policecartaxi
{
	with instance_create(obj_stopsign.x - 960 / 2 - 50, obj_stopsign.y, obj_taxidud)
	{
		playerid = obj_player
		if playerid.state == states.policecartaxi
			sprite_index = spr_policecar
	}
}