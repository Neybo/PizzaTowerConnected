if other.character == "N"
{
	if other.y < y && visible && grounded
	{
		scr_soundeffect(sfx_noisewoah)
		other.image_index = 0
		other.sprite_index = spr_playerN_hookshot1
		other.state = states.hookshot	
		visible = false
	}
}
else
	event_inherited();

