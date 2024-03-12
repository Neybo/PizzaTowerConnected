if other.state == states.gameover
	exit;

if sprite_index == spr_grabbiehand_fall
{
	with obj_player
		scr_transfobump()
	
	grav = 0
	vsp = 0
	grabbing = true
	sprite_index = spr_grabbiehand_catch
	player = other.id
	
	other.image_index = 0
	other.sprite_index = other.spr_catched
	if other.state != states.titlescreen	
		other.state = states.bump
	other.x = x
	other.y = y 
	other.vsp = 0
	other.hsp = 0
	
	scr_soundeffect(sfx_machpunch)
}
