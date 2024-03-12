if room == rank_room
	visible = false;

var hsp = 0, vsp = 0;
if instance_exists(obj_player)
{
	mask_index = obj_player.mask_index
	if (place_meeting(x, (y + 1), obj_slope) && scr_solid(x, (y + 1)))
	    y = obj_player.y
	
	hsp = obj_player.hsp;
	vsp = obj_player.vsp - 1;
	
	if obj_player.x == obj_player.xprevious
		hsp = 0;
	if obj_player.y == obj_player.yprevious
		vsp = 0;
	
	if is_visible
	{
	    visible = obj_player.visible
	    if place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart)
	        visible = false
	}
}

x += Vspeed + hsp;
y += Hspeed + vsp - 1;

visible = false
if !visible
	surf_free()
