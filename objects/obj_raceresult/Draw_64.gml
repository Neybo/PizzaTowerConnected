if (ds_list_size(global.raceleader) <= 0)
	return;
	
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_font(global.bigfont)
draw_set_alpha(!global.__chat ? 1 : 0.35)
	
if (ds_list_size(global.raceleader) < gms_session_player_count(gms_session_current_id()))
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	draw_set_font(global.font_small)
	draw_set_color(merge_colour(c_white, c_black, 0.05))
	draw_text(800, 24, lang_str("online.race.racenotfinished"))
}
	
if (!global.__chat && draw_editorbutton(700, 400, lang_str("msg.exit")))
{
	global.__script_session = -1
	global.racing = false;
	gms_session_join(global.default_session);
	instance_activate_all()
	fmod_stop_all();
	scr_playerreset();

	with obj_player
	{
		targetDoor = "A";
		state = states.normal;
	}
	room_goto(hub_room1);
	exit;
}
	

draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_font(global.bigfont)
draw_set_alpha(!global.__chat ? 1 : 0.35)

var yStart = 120
var rank = 0

for (i = 0; i < ds_list_size(global.raceleader); i++)
{
	if !(ds_list_find_value(global.racetime, i) == "N/A" 
	&& ds_list_find_value(global.raceleader, i) != gms_self_name())
		rank++;
	if ds_list_find_value(global.raceleader, i) != gms_self_name()
		continue;
	var	afterfix = "th"
	if (rank == 1)
	{
		draw_set_color(merge_colour(c_yellow, c_orange, 0.1))
		afterfix = "st"
	}
	else if (rank == 2)
	{
		draw_set_color(merge_colour(c_ltgrey, c_white, 0.25))
		afterfix = "nd"
	}
	else if (rank == 3)
	{
		draw_set_color(make_colour_rgb(205, 127, 50))
		afterfix = "rd"
	}
	else
		draw_set_color(merge_colour(c_white, c_black, 0.05))
		
	if (ds_list_find_value(global.racetime, i) == "N/A")
	{
		draw_set_color(c_grey)
		draw_text(480, yStart - 96, lang_str_upper("online.race.didntfinish"))
	}
	else
		draw_text(480, yStart - 96, 
		string_upper(lang_str("online.race.youplaced") + " " + string(rank) + afterfix + "!"))
}
	
draw_set_font(global.font_small)	

rank = 0

for (i = 0; i < ds_list_size(global.raceleader); i++)
{
	if (ds_list_find_value(global.racetime, i) == "N/A")
	{
		continue;
	}
	rank++;
	var	afterfix = "th"
	if (rank == 1)
	{
		draw_set_color(merge_colour(c_yellow, c_orange, 0.1))
		afterfix = "st"
	}
	else if (rank == 2)
	{
		draw_set_color(merge_colour(c_ltgrey, c_white, 0.25))
		afterfix = "nd"
	}
	else if (rank == 3)
	{
		draw_set_color(make_colour_rgb(205, 127, 50))
		afterfix = "rd"
	}
	else
		draw_set_color(merge_colour(c_white, c_black, 0.05))
		
	draw_text(210, yStart, string(rank) + afterfix)
	draw_text(340, yStart, ds_list_find_value(global.raceleader, i))
	draw_text(480, yStart, "---")
	draw_text(620, yStart, ds_list_find_value(global.racetime, i))
	yStart += 26
	if (rank == 3)
		yStart += 20
}

yStart += 64;

for (i = 0; i < ds_list_size(global.raceleader); i++)
{
	if (ds_list_find_value(global.racetime, i) != "N/A")
	{
		continue;
	}
	draw_set_color(c_grey)
	draw_text(210, yStart, "N/A-th")
	draw_text(340, yStart, ds_list_find_value(global.raceleader, i))
	draw_text(480, yStart, "---")
	draw_text(620, yStart, ds_list_find_value(global.racetime, i))
	yStart += 26
}
draw_set_alpha(1);