/// @description top players
exit; // doesnt work
draw_set_halign(fa_center)
draw_set_font(global.font_small)
draw_set_color(c_red)
if (topplayeridwithkills != 0)
draw_text(480, 10, "Highest amount of damage dealt is " + string(gms_other_get_real(topplayeridwithkills, "pvp_kills")) + 
"\nand is held by (could be more) " + + gms_other_get_string(topplayeridwithkills, "name"))
else
draw_text(480, 10, "Highest amount of damage dealt is 0,\nmaybe someone could top that?")

draw_set_color(c_green)
if (topplayeridwithtime != 0)
{
var timetext = string(gms_other_get_real(topplayeridwithtime, "timespent_pvp_m")) + ":"
	if (gms_other_get_real(topplayeridwithtime, "timespent_pvp_s") < 10)
			timetext += "0"
	timetext += string(gms_other_get_real(topplayeridwithtime, "timespent_pvp_s"))
draw_text(480, 40, "Highest amount of time alive is " + timetext + 
"\nand is held by (could be more) " + + gms_other_get_string(topplayeridwithtime, "name"))
}
else
draw_text(480, 40, "Highest amount of time alive is 0:00,\nmaybe someone could top that?")



