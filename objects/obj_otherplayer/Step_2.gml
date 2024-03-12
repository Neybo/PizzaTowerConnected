viewable = (room != rank_room && room != timesuproom && 
scr_gms_room(gms_other_get_real(player_id, "room")) == scr_gms_room())
if !viewable
	exit;

xscale = gms_other_get_real(player_id, "xscale")
yscale = gms_other_get_real(player_id, "yscale")

sprite_index = gms_other_get_real(player_id, "sprite_index")
image_index = gms_other_get_real(player_id, "image_index");
img_angle = gms_other_get_real(player_id, "img_angle")
image_speed = 0

spr_palette = gms_other_get_real(player_id, "spr_palette")
paletteselect = gms_other_get_real(player_id, "paletteselect")

state = gms_other_get_real(player_id, "state")

visible = true;
	
if place_meeting(x, y, obj_secretblock)
or place_meeting(x, y, obj_secretbigblock)
or place_meeting(x, y, obj_secretmetalblock)
	image_alpha = 0.5;
else
{
	depth = -6;
	image_alpha = 1
}

pvp = gms_other_get_real(player_id, "pvp");
if pvp
{
	hurted = gms_other_get_real(player_id, "pvp_hurted");
	cutscene = gms_other_get_real(player_id, "pvp_cutscene");
	if pvp_cooldown > 0
		pvp_cooldown--;
		
	pvparena = gms_other_get_real(player_id, "pvp_arena")
	if (pvparena)
	{
		pvpkills = gms_other_get_real(player_id, "pvp_kills")
		var pvptime = gms_other_get_real(player_id, "timespent_pvp")
		pvpsecs = pvptime % 60
		pvpmins = floor(pvptime / 60)
	}
}

pause = gms_other_get_real(player_id, "pause");

