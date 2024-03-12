depth = 999999
draw_sprite_ext(spr_racemenubg, 0, 0, 0, 1, 1, 0, c_white, 0.95)

if (menu == racestates.creating_or_joining)
{
	if (draw_editorbutton(385, 190, "CREATE"))
	{
		if ((get_timer() / 1000000) - global.createantispam < 5)
		{
			errormsg = "PLEASE WAIT BEFORE CREATING ANOTHER RACE"
			event_user(3)
		}
		else
			menu = racestates.create_making
		global.createantispam = (get_timer() / 1000000)
	}
	if (draw_editorbutton(385, 320, "JOIN"))
	{
		menu = racestates.joining_setting
	}
}
if (menu == racestates.create_making)
{
	draw_set_align(fa_center, fa_center)
	draw_set_color(c_white)
	draw_set_font(global.bigfont)
	
	draw_text(480, 64, string_upper("Minimum players?"))
	draw_text(480, 90, string_upper(string(maxplayer)))
	
	draw_text(480, 250, string_upper("Level?"))
	draw_text(480, 300, string_upper(levelselectname[levelselect]))
	
	if (maxplayer > 2 && draw_editorbutton_minus(407,86))
		maxplayer--
	if (maxplayer < 12 && draw_editorbutton_plus(540,86))	
		maxplayer++
	
	if (levelselect > 0 && draw_editorbutton_arrowL(360,240))
		levelselect--
	if (levelselect < array_length(levelselectroom) - 1 && draw_editorbutton_arrowR(560,240))
		levelselect++
	
	if (draw_editorbutton(385,380, "CREATE"))
	{
		var session = scr_gms_session_find_empty(session_types.race)
		if session == -1
			gms_session_create(session_types.race);
		else
			gms_session_join(session) // use optimizations
		menu = racestates.create_loading
	}
	
}
if (menu == racestates.created)
{
	draw_set_align(fa_center, fa_center)
	draw_set_color(c_white)
	draw_set_font(global.bigfont)
	
	draw_text(480, 90, string_upper("Minimum players needed:\n") + 
	string(gms_session_player_count(gms_session_current_id())) + 
	"/" +  string_upper(string(maxplayer)))
	
	draw_text(480, 200, string_upper("Race ID:\n") + string(gms_session_current_id()))
	
	if (gms_session_player_count(gms_session_current_id()) >= maxplayer)
	{
		if (draw_editorbutton(385,340, "START"))
			event_user(0)
		draw_set_font(global.font_small)
		draw_set_align(fa_center, fa_center)

		var mins = floor(alarm[2] / 60 / 60)
		var secs = floor((alarm[2] / 60) % 60)
		
		var text = "It will auto-start in "
		
		if (mins > 0)
		{
			text += string(mins)
			if (mins == 1)
				text += " minute and "
			else
				text += " minutes and "
		}
		
		text += string(secs) + " " + ((secs == 1) ? "second" : "seconds") + ".\nThis is to prevent time-wasting."
		
		draw_text(480, 420, text)
	}
	else
		draw_text(480, 400, string_upper("Please wait for\nthe minimum people needed..."))
	
}
if (menu == racestates.joining_setting)
{
	draw_set_align(fa_center, fa_center)
	draw_set_color(c_white)
	draw_set_font(global.bigfont)
	
	draw_text(480, 164, string_upper("Race id?"))
	draw_text(480, 190, string_upper(string(idtojoin)))
	
	if (idtojoin > 3 && draw_editorbutton_minus(407,186))
		idtojoin--
	if (idtojoin < 1000 && draw_editorbutton_plus(540,186))	
		idtojoin++
		
	if (draw_editorbutton(385,380, "JOIN"))
	{
		gms_session_join(idtojoin)
		menu = racestates.joining_loading
	}
}
if (menu == racestates.joined)
{
	draw_set_align(fa_center, fa_center)
	draw_set_color(c_white)
	draw_set_font(global.bigfont)
	
	var players = gms_session_player_count(gms_session_current_id())
	draw_text(480, 100, string_upper("There are " +  string(players) + 
	((players == 1) ? " player" : " players") + "\nin the race lobby."))
	
	if (players >= maxplayer)
		draw_text(480, 180, string_upper("There is enough people to\nstart the race."))
	else
		draw_text(480, 180,  string_upper("There isn't enough people to\nstart the race."))
		
	draw_text(480, 260, string_upper("This race will take place on:\n" + levelselectname[levelselect]))
	
	if (players >= maxplayer)
		draw_text(480, 340, string_upper("The race will start soon,\neither manually or the auto-start."))
}
if (menu != racestates.creating_or_joining && backdelay <= 0 && draw_editorbutton(505, 460, "BACK"))
	event_user(4)
if (draw_editorbutton(715, 460, "EXIT"))
	event_user(2)
	
backdelay -= 1 / 60