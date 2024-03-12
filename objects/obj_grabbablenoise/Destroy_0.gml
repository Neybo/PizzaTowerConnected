event_inherited();
if obj_player.character == "N"
{
	obj_player.hsp = -obj_sausageman_dead.hsp;
	obj_player.vsp = obj_sausageman_dead.vsp;
	obj_player.state = states.gameover;
	obj_player.sprite_index = other.spr_dead;
}