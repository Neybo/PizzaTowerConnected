if place_meeting(x, y, obj_player) && alarm[0] == -1
{
	scr_soundeffect(sfx_mine)	
	gonnajump = true;
	image_speed = 0.35
}
if gonnajump && alarm[0] == -1
	alarm[0] = 17;
if (image_index == floor(image_number) - 1)
	visible = false

if alarm[0] != -1
	y -= 4;

