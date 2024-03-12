optionselected = 0
optionsaved_fullscreen = global.option_fullscreen
optionsaved_resolution = global.option_resolution
optionsaved_vibration = global.gamepadvibration
depth = -99

enum menustates // i make a lot of these
{
	main,
	audio,
	otherop,
	ptox
}

menu = menustates.main;
menuto = -1;

mo = random(32);
c2 = make_colour_hsv((257 / 360) * 255, (39 / 100) * 255, (23 / 100) * 255);
curf = 0;
img = 0;
img2 = 0;

if !check_shaders()
	global.panicbg = false;

surf = -1;
bgsurf = -1;
trans = 0;

state = 0;
substate = 0;
movespeed = 0;

camy = 0;
camx = 0;
holdkey = -1;
holdkeyt = 0;

music = FMOD_EMPTY;

pmach2_new = fmod_create_instance(sfx_mach2)
pmach2_old = fmod_create_instance(sfx_mach2_old)
fmod_set_loop(pmach2_new, true)
fmod_set_loop(pmach2_old, true)
fmod_resume_instance(pmach2_new)
fmod_resume_instance(pmach2_old)


smoothcamx = 0
pepsmthcamx = 480
pepslopeang = 0

font_final = global.bigfont3
font_non_final = global.bigfont2

roomname = noone;
if !instance_exists(obj_roomname)
	roomname = instance_create(0, 0, obj_roomname);

blur_op1 = -4
blur_op2 = -4
mach_op1 = -4
mach_op2 = -4
machblur_flipped = 0

cat_num_on = 0

// options making!
#region ptox options
	options_categories_ptox = optionr_new_section(function()
	{
		if global.hudstyle == 2
			global.hudtype = min(global.gameplay, 1)
		else
			global.hudtype = global.hudstyle

		if global.levelstyle == 2
			global.leveltype = min(global.gameplay, 1)
		else
			global.leveltype = global.levelstyle
		
		instance_destroy(blur_op1)
		instance_destroy(blur_op2)
		instance_destroy(mach_op1)
		instance_destroy(mach_op2)
		
		with obj_roomname
		{
			showtext = true;
			message = lang_str_upper("options.saved");
			alarm[0] = 60;
		}
	})

	var gameplay_cat = optionr_new_category(options_categories_ptox, lang_str("options.cat.gameplay"))

	#region attack
		optionr_new_option(gameplay_cat, "options.ptox.attackstyle", function(select)
		{
			var move = (key_left2 + key_right2);
			var lastattack = global.attackstyle
			global.attackstyle += move
		
			if select && move == 0
				global.attackstyle += 1
		
			if global.attackstyle > 1
				global.attackstyle = 0
			else if global.attackstyle < 0
				global.attackstyle = 1
		
		
			if lastattack != global.attackstyle
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.attackstyle.title"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.attackstyle == 0 ? 1 : 0.5);
			draw_text(640 - 30, 106, lang_str_upper("options.ptox.attackstyle.grab"));
			draw_set_alpha(global.attackstyle == 1 ? 1 : 0.5);
			draw_text(640 + 30, 106, lang_str_upper("options.ptox.attackstyle.kungfu"));
			draw_set_alpha(1);
			
			var spr = spr_player_suplexdash
			if global.attackstyle == 1
				spr = spr_player_kungfuair1
			
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(spr,
			img * .35, 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
			draw_set_colour(c_ltgray);
			draw_text(640, 310, lang_str("options.ptox.attackstyle.desc"));
			if global.attackstyle
				draw_text(640, 390, lang_str("options.ptox.attackstyle.extra"))
		}, optionr_new_save_data_info("online", "attackstyle", "attackstyle"))
	#endregion
	#region dattack
		optionr_new_option(gameplay_cat, "options.ptox.dattackstyle", function(select)
		{
			var move = (key_left2 + key_right2);
			var lastattack = global.dattackstyle
			global.dattackstyle += move
		
			if select && move == 0
				global.dattackstyle += 1
		
			if global.dattackstyle > 2
				global.dattackstyle = 0
			else if global.dattackstyle < 0
				global.dattackstyle = 2
		
		
			if lastattack != global.dattackstyle
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.dattackstyle.title"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.dattackstyle == 0 ? 1 : 0.5);
			draw_text(640 - 100, 106, lang_str_upper("options.ptox.dattackstyle.none"));
			draw_set_alpha(global.dattackstyle == 1 ? 1 : 0.5);
			draw_text(640, 106, lang_str_upper("options.ptox.dattackstyle.faceplant"));
			draw_set_alpha(global.dattackstyle == 2 ? 1 : 0.5);
			draw_text(640 + 100, 106, lang_str_upper("options.ptox.dattackstyle.shoulderbash"));
			draw_set_alpha(1);
			
			var spr = spr_player_suplexdash
			if global.dattackstyle == 1
				spr = spr_player_faceplant
			if global.dattackstyle == 2
				spr = spr_player_airattack
			
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(spr,
			img * .35, 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
			
			draw_set_colour(c_ltgray);
			draw_text(640, 310, lang_str("options.ptox.dattackstyle.desc"));
		}, optionr_new_save_data_info("online", "dattackstyle", "dattackstyle"))
	#endregion
	#region shooting
		optionr_new_option(gameplay_cat, "options.ptox.freedom", function(select)
		{
			if select
			{
				global.usebullet = !global.usebullet;
				randomize()
				scr_soundeffect(sfx_menuchoose);
				with obj_inputdisplay
				{
					event_user(0)
				}
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.freedom.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.usebullet ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 310, lang_str("options.ptox.freedom.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(global.usebullet ? spr_player_pistolidle : spr_player_idle, img * .35, 640,
			190, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "usebullet", "usebullet"))
	#endregion
	#region chainsaw
		optionr_new_option(gameplay_cat, "options.ptox.chainsawing", function(select)
		{
			if select
			{
				global.useammo = !global.useammo;
				randomize()
				scr_soundeffect(sfx_menuchoose);
				with obj_inputdisplay
				{
					event_user(0)
				}
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.chainsawing.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.useammo ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.chainsawing.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(global.useammo ? spr_player_chainsaw : spr_player_mach4, img * .4, 640, 
			200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "useammo", "useammo"))
	#endregion
	#region breakdance
		optionr_new_option(gameplay_cat, "options.ptox.breakdance", function(select)
		{
			if select
			{
				global.breakdance = !global.breakdance;
				randomize()
				scr_soundeffect(sfx_menuchoose);
				with obj_inputdisplay
				{
					event_user(0)
				}
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.breakdance.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.breakdance ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.breakdance.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(global.breakdance ? spr_player_breakdance : spr_player_idle, img * .35, 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "breakdance", "breakdance"))
	#endregion
	#region sjump
		optionr_new_option(gameplay_cat, "options.ptox.sjumpcancel", function(select)
		{
			if select
			{
				global.instantsjumpcancel = !global.instantsjumpcancel;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.sjumpcancel.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.instantsjumpcancel ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.sjumpcancel.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(!global.instantsjumpcancel ? spr_player_Sjumpcancel : 
			spr_player_mach4, img * .35, 640, 200, 2, 2, 0, make_color_rgb(255,255,255), 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "instantsjumpcancel", "instantsjumpcancel"))
	#endregion
	#region sjump type
		optionr_new_option(gameplay_cat, "options.ptox.sjumptype", function(select)
		{
			var move = (key_left2 + key_right2);
			var lasttype = global.sjumptype
			global.sjumptype += move
		
			if select && move == 0
				global.sjumptype += 1
		
			if global.sjumptype > 1
				global.sjumptype = 0
			else if global.sjumptype < 0
				global.sjumptype = 1
		
		
			if lasttype != global.sjumptype
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.sjumptype.title"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.sjumptype == 0 ? 1 : 0.5);
			draw_text(640 - 35, 106, lang_str_upper("options.ptox.sjumptype.normal"));
			draw_set_alpha(global.sjumptype == 1 ? 1 : 0.5);
			draw_text(640 + 35, 106, lang_str_upper("options.ptox.sjumptype.superside"));
			draw_set_alpha(1);
			
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.sjumptype.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(global.sjumptype ? spr_player_supersidejump 
			: spr_player_Sjumpcancel, img * .35, 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "sjumptype", "sjumptype"))
	#endregion
	#region turning
		optionr_new_option(gameplay_cat, "options.ptox.machturn", function(select)
		{
			if select
			{
				global.animmachturn = !global.animmachturn;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.machturn.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.animmachturn ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.machturn.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(global.animmachturn ? spr_player_machslideboost3 
			: spr_player_machslideboost3fall, img * .35, 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "animmachturn", "animmachturn"))
	#endregion
	#region pizzy phys
		optionr_new_option(gameplay_cat, "options.ptox.pizzyphys", function(select)
		{
			var move = (key_left2 + key_right2);
			var lastpizzy = global.pizzyphys
			global.pizzyphys += move
		
			if select && move == 0
				global.pizzyphys += 1
		
			if global.pizzyphys > 2
				global.pizzyphys = 0
			else if global.pizzyphys < 0
				global.pizzyphys = 2
		
		
			if lastpizzy != global.pizzyphys
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.pizzyphys.title"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.pizzyphys == 0 ? 1 : 0.5);
			draw_text(640 - 75, 106, lang_str_upper("options.ptox.pizzyphys.never"));
			draw_set_alpha(global.pizzyphys == 1 ? 1 : 0.5);
			draw_text(640, 106, lang_str_upper("options.ptox.pizzyphys.always"));
			draw_set_alpha(global.pizzyphys == 2 ? 1 : 0.5);
			draw_text(640 + 75, 106, lang_str_upper("options.auto"));
			draw_set_alpha(1);
			
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.pizzyphys.desc"));
		
			if global.pizzyphys == 0
			{
				pal_swap_set(spr_peppalette, 1, 0)
				draw_sprite_ext(spr_player_idle, img * 0.35, 640, 210, 2,
				2, image_angle, c_white, image_alpha);
				pal_swap_reset()
			}
			else if global.pizzyphys == 1
			{
				pal_swap_set(spr_pizzpalette, 1, 0)
				draw_sprite_ext(spr_playerSP_idle, img * 0.35, 640, 210, 
				2, 2, image_angle, c_white, image_alpha);
				pal_swap_reset()
			}
			else
			{
				pal_swap_set(spr_peppalette, 1, 0)
				draw_sprite_ext(spr_player_idle, img * 0.35, 590, 210, 
				2, 2, image_angle, c_white, image_alpha);
				pal_swap_reset()
				
				pal_swap_set(spr_pizzpalette, 1, 0)
				draw_sprite_ext(spr_playerSP_idle, img * 0.35, 690, 210, 
				2, 2, image_angle, c_white, image_alpha);
				pal_swap_reset()
			}
		}, optionr_new_save_data_info("online", "pizzyphys", "pizzyphys"))
	#endregion
	#region og phys
		optionr_new_option(gameplay_cat, "options.ptox.slopebitch", function(select)
		{
			if select
			{
				global.slopebitch = !global.slopebitch;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.slopebitch.title"));
		
			draw_set_font(global.font_small);
			draw_text(640, 106, global.slopebitch ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			var offset_xx = 0
			var offset_yy = 0
			if global.slopebitch
			{
				offset_xx = 4
				offset_yy = -20
			}
			draw_sprite(spr_title, global.slopebitch, 428 + offset_xx, 130 + offset_yy)
			draw_sprite(spr_title2, global.slopebitch, 428 + offset_xx, 130 + offset_yy)
			draw_text(640, 458, lang_string("options.ptox.slopebitch.desc"));
		}, optionr_new_save_data_info("online", "slopebitch", "slopebitch"))
	#endregion
	#region hitstun
		optionr_new_option(gameplay_cat, "options.ptox.hitstun", function(select)
		{
			if select
			{
				global.hitstun = !global.hitstun;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.hitstun.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.hitstun ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
		
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(spr_player_mach3hit, (global.hitstun) ? 3 : img * .35, 
			640 + (irandom_range(-4, 4) * global.hitstun), 
			200 + (irandom_range(-4, 4) * global.hitstun), 
			2, 2, 0, c_white, 1)
			pal_swap_reset()
			
			draw_text(640, 310, lang_str("options.ptox.hitstun.desc"));
		}, optionr_new_save_data_info("online", "hitstun", "hitstun"))
	#endregion
	#region swingding
		optionr_new_option(gameplay_cat, "options.ptox.swingding", function(select)
		{
			if select
			{
				global.swingding = !global.swingding;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.swingding.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.swingding ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(!global.swingding ? spr_player_haulingidle : spr_player_swingding,
			img * .35, 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
			
			draw_text(640, 310,lang_str("options.ptox.swingding.desc"));
		}, optionr_new_save_data_info("online", "swingding", "swingding"))
	#endregion
	#region heatmeter
		optionr_new_option(gameplay_cat, "options.ptox.heatmeter", function(select)
		{
			if select
			{
				global.heatmeter = !global.heatmeter;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.heatmeter.title"));
	
			draw_set_font(global.font_small);
			draw_text(640, 106, global.heatmeter ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 250, lang_str("options.ptox.heatmeter.desc"));
			pal_swap_set(spr_heatmeter_palette, 3 * global.heatmeter, 0)
			draw_sprite_ext(spr_heatmeter, img * .35, 640, 120, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "heatmeter", "heatmeter"))
	#endregion
	#region level styling
		optionr_new_option(gameplay_cat, "options.ptox.levelstyle", function(select)
		{
			var move = (key_left2 + key_right2);
			var lastlevel = global.levelstyle
			global.levelstyle += move
		
			if select && move == 0
				global.levelstyle += 1
		
			if global.levelstyle > 2
				global.levelstyle = 0
			else if global.levelstyle < 0
				global.levelstyle = 2
		
		
			if lastlevel != global.levelstyle
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.levelstyle.title"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.levelstyle == 0 ? 1 : 0.5);
			draw_text(640 - 75, 106, lang_str_upper("options.old"));
			draw_set_alpha(global.levelstyle == 1 ? 1 : 0.5);
			draw_text(640, 106, lang_str_upper("options.new"));
			draw_set_alpha(global.levelstyle == 2 ? 1 : 0.5);
			draw_text(640 + 75, 106, lang_str_upper("options.auto"));
			draw_set_alpha(1);
			
			var isOld = global.levelstyle == 0 || (OLD_GAMEPLAY && global.levelstyle == 2)
			
			var spr = spr_level_preview_new
			var posX = 544
			var posY = 339
			if isOld
			{
				spr = spr_level_preview_old
				posX = 576
				posY = 403
			}
			
			draw_set_colour(c_ltgray);
			draw_sprite(spr, 0, 640, 300 + 10)
			draw_text(640, 495, 
			lang_str("options.ptox.levelstyle.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(spr_player_idle, img * .35, posX,
			posY + 10, 1, 1, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "levelstyle", "levelstyle"))
	#endregion
	#region infinite speed
		optionr_new_option(gameplay_cat, "options.ptox.infspeed", function(select)
		{
			if select
			{
				global.infspeed = !global.infspeed;
				randomize()
				scr_soundeffect(sfx_menuchoose);
				scr_playerspeed()
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.infspeed"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.infspeed ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 320,	lang_str("options.ptox.infspeed.desc"));
			pal_swap_set(spr_pizzpalette, 1, 0)
			draw_sprite_ext(global.infspeed ? spr_playerSP_crazyrun : spr_playerSP_mach4_EDIT, 
			img * (global.infspeed ? 0.45 : 0.35), 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "infspeed", "infspeed"))
	#endregion
	#region og game speed
		optionr_new_option(gameplay_cat, "options.ptox.finalspeed", function(select)
		{
			if select
			{
				global.oggamespeed = !global.oggamespeed;
				randomize()
				scr_soundeffect(sfx_menuchoose);
				scr_playerspeed()
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.finalspeed.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.oggamespeed ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 320, lang_str("options.ptox.finalspeed.desc"));
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(!global.oggamespeed ? spr_player_crazyrun : spr_player_mach4, 
			img * (!global.oggamespeed ? 0.45 : 0.35), 640, 200, 2, 2, 0, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "oggamespeed", "oggamespeed"))
	#endregion
	#region classic lap
		optionr_new_option(gameplay_cat, "options.ptox.classiclap", function(select)
		{
			if select
			{
				global.classiclap = !global.classiclap;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.classiclap.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.classiclap ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 410, lang_str("options.ptox.classiclap.desc"));
			
			draw_sprite_ext((global.classiclap) ? spr_pizzaface_NEW : spr_pizzaface_hurt, img * .35, 640, 265,
			1.5, 1.5, 0, c_white, 0.95)
		}, optionr_new_save_data_info("online", "classiclap", "classiclap"))
	#endregion
	
	var other_cat = optionr_new_category(options_categories_ptox, lang_str("options.cat.other"))
	
	#region sugarcoat
		optionr_new_option(other_cat, "options.ptox.sugarcoat", function(select)
		{
			if select
			{
				global.notgonnasugarcoatit = !global.notgonnasugarcoatit;
				scr_soundeffect((global.notgonnasugarcoatit) ? sfx_sugarcoat : sfx_sugarcoated);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.sugarcoat.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.notgonnasugarcoatit ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 410, lang_str("options.ptox.sugarcoat.desc"));
			
			draw_sprite_ext((global.notgonnasugarcoatit) ? spr_sugarcoat : spr_sugarcoated, 0, 640, 265,
			0.5, 0.5, 0, c_white, 0.95)
		}, optionr_new_save_data_info("online", "notgonnasugarcoatit", "notgonnasugarcoatit"))
	#endregion
	
	var online_cat = optionr_new_category(options_categories_ptox, lang_str("options.cat.online"))
	
	#region race inv
		optionr_new_option(online_cat, "options.ptox.raceinv", function(select)
		{
			if select
			{
				global.raceinvites = !global.raceinvites;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.raceinv.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.raceinvites ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 210, lang_str("options.ptox.raceinv.desc"));
			
			draw_set_colour(merge_color(c_admin, c_eatery, 0.25));
			if (global.raceinvites)
				draw_text(640, 160, lang_str("online.raceinvprefix") + 
				" " + "Size43: " + lang_str("online.raceinv") + " JOHN GUTTER. (ID: 10)")
		}, optionr_new_save_data_info("online", "raceinvites", "raceinvites"))
	#endregion
	#region tp req
		optionr_new_option(online_cat, "options.ptox.tpreq", function(select)
		{
			if select
			{
				global.blockedtpreq = !global.blockedtpreq;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.tpreq.title"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, !global.blockedtpreq ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 210, lang_str("options.ptox.tpreq.desc"));
			
			draw_set_colour(merge_colour(c_success, c_white, 0.25));
			if (!global.blockedtpreq)
				draw_text(640, 160, "Size43 " + lang_str("online.tp.sent"))
		}, optionr_new_save_data_info("online", "blockedtpreq", "blockedtpreq"))
	#endregion
	#region own chat bubble
		optionr_new_option(online_cat, "options.ptox.ownchatbubble", function(select)
		{
			if select
			{
				global.showownmsg = !global.showownmsg;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.ownchatbubble"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.showownmsg ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 420, lang_str("options.ptox.ownchatbubble.desc"));
			
			var yplay = 300
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_idle, img * .35, 640, yplay, 2, 2, 0, c_white, 1)
			pal_swap_reset();
			
			draw_set_font(global.font_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_colour(c_owner);
			
			draw_text_transformed(640, sprite_get_bbox_top(spr_player_idle) + yplay - 120, 
			lang_string("options.ptox.ownchatbubble.you"), 2, 2, 0);
			
			if global.showownmsg
			{
				// bubble
				draw_set_halign(fa_center);
				draw_set_valign(fa_top);
				
				var message = lang_string("options.other.chatbubbles.example");
				
				_w = max(0.01, min(string_width(message), room_width / 4));
				_w = string_width_ext((message), -1, _w);
				_h = string_height_ext((message), -1, _w);
			
				draw_set_colour(c_black);
				draw_roundrect(640 - _w / 2 - 10 - 1, yplay - _h + sprite_get_bbox_top(sprite_index) - 32 - 40 * (global.shownames + 1) - 1, 
				640 + _w / 2 + 10 + 1, yplay + sprite_get_bbox_top(sprite_index) - 22 - 40 * (global.shownames + 1) + 1, 0);
				draw_roundrect(640 - _w / 2 - 10 + 4, yplay - _h + sprite_get_bbox_top(sprite_index) - 32 - 40 * (global.shownames + 1) + 4, 
				640 + _w / 2 + 10 + 4, yplay + sprite_get_bbox_top(sprite_index) - 22 - 40 * (global.shownames + 1) + 4, 0);
				draw_set_color(c_white);
				draw_roundrect(640 - _w / 2 - 10, yplay - _h + sprite_get_bbox_top(sprite_index) - 32 - 40 * (global.shownames + 1), 
				640 + _w / 2 + 10, yplay + sprite_get_bbox_top(sprite_index) - 22 - 40 * (global.shownames + 1), 0);
				draw_set_color(c_white);
				draw_text_ext(floor(640), floor(yplay - _h + sprite_get_bbox_top(sprite_index) - 24 - 40 * (global.shownames + 1)), 
				string(message), -1, _w);
				
				draw_set_halign(fa_left);
			}
		}, optionr_new_save_data_info("online", "showownmsg", "showownmsg"))
	#endregion
	#region send speed
		optionr_new_option(online_cat, "options.ptox.sendspeed", function(select)
		{
			if keyboard_check(vk_shift)
				var move = (key_left2 + key_right2);
			else
				var move = (key_left + key_right);
			
			global.onlinefps = clamp(global.onlinefps + move, 1, 60);
			if keyboard_check_pressed(ord("R"))
				global.onlinefps = 30;
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.sendspeed"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 250, 
			lang_str("options.ptox.sendspeed.desc"));
			
			var numpercent = (global.onlinefps / 60)
			var slidery = 165;
			draw_set_font(global.font_small);
			draw_set_colour(c_white);
			draw_text_transformed(640, 106, string(global.onlinefps) + " " 
			+ lang_str("options.ptox.sendspeed.packets"), 1, 1, 0);
			
			draw_set_colour(c_gray);
			draw_rectangle_colour(450, slidery, 850 - 1, slidery + 16, c_green, c_red, c_red, c_green, false);
			draw_rectangle(850, slidery, 450 + (numpercent * 400), slidery + 16, false);
			draw_set_colour(c_black);
			draw_circle(450 + (numpercent * 400), slidery + 8, 21, false);
			draw_set_colour(c_white);
			draw_circle(450 + (numpercent * 400), slidery + 8, 20, false);
		}, optionr_new_save_data_info("online", "onlinefps", "onlinefps"))
	#endregion
	#region webhook
		optionr_new_option(online_cat, "options.ptox.webhook", function(select)
		{
			if select
			{
				global.webhook = !global.webhook;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.webhook"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.webhook ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 230, lang_str("options.ptox.webhook.desc"));
			
			if global.webhook
				draw_sprite(spr_webhookoption, 0, 640, 175)
		}, optionr_new_save_data_info("online", "webhook", "webhook"))
	#endregion
	
	var visual_cat = optionr_new_category(options_categories_ptox, lang_str("options.cat.visual"))
	
	#region performance mode
		optionr_new_option(visual_cat, "options.ptox.performance", function(select)
		{
			if select
			{
				global.performancemode = !global.performancemode;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.performance"));
			
			draw_set_font(global.font_small);
			
			draw_text(640, 106, global.performancemode ? lang_str("options.on") : lang_str("options.off"));
			
			draw_set_colour(c_ltgray);
			
			if !global.performancemode
			{
				var spr = (FINAL_GAMEPLAY ? spr_cloudeffectnew : spr_cloudeffect)
				draw_sprite_ext(spr, img * .35, 600, 230, 2, 2, 0, c_white, 1)
				draw_sprite_ext(spr, img * .35, 680, 230, 2, 2, 0, c_white, 1)
				draw_sprite_ext(spr, img * .35, 600, 310, 2, 2, 0, c_white, 1)
				draw_sprite_ext(spr, img * .35, 680, 310, 2, 2, 0, c_white, 1)
			}
			
			draw_text(640, 410, lang_str("options.ptox.performance.desc"));
		}, optionr_new_save_data_info("online", "performancemode", "performancemode"))
	#endregion
	#region hud style
		optionr_new_option(visual_cat, "options.ptox.hudstyle", function(select)
		{
			var move = (key_left2 + key_right2);
			var lasthud = global.hudstyle
			global.hudstyle += move
		
			if select && move == 0
				global.hudstyle += 1
		
			if global.hudstyle > 2
				global.hudstyle = 0
			else if global.hudstyle < 0
				global.hudstyle = 2
		
		
			if lasthud != global.hudstyle
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.hudstyle"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.hudstyle == 0 ? 1 : 0.5);
			draw_text(640 - 75, 106, lang_str_upper("options.old"));
			draw_set_alpha(global.hudstyle == 1 ? 1 : 0.5);
			draw_text(640, 106, lang_str_upper("options.new"));
			draw_set_alpha(global.hudstyle == 2 ? 1 : 0.5);
			draw_text(640 + 75, 106, lang_str_upper("options.auto"));
			draw_set_alpha(1);
			
			draw_set_colour(c_ltgray);
			draw_text(640, 420, lang_str("options.ptox.hudstyle.desc"));

			pal_swap_set(spr_peppalette, 1, 0)
	
			var hudtype = global.hudstyle == 0 || (OLD_GAMEPLAY && global.hudstyle == 2)
	
			spr = spr_pepinoHUDhappy;
			var scale = 2
			if (!hudtype)
			{
				spr = spr_tv_exprcombo;
				scale = 1.5	
			}
			draw_sprite_ext(spr, img * 0.35, 660, 286 - (hudtype * 15), scale, scale, image_angle, c_white, image_alpha);
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "hudstyle", "hudstyle"))
	#endregion
	#region font style
		optionr_new_option(visual_cat, "options.ptox.fontstyle", function(select)
		{
			var move = (key_left2 + key_right2);
			var lastfont = global.fontstyle
			global.fontstyle += move
		
			if select && move == 0
				global.fontstyle += 1
		
			if global.fontstyle > 1
				global.fontstyle = 0
			else if global.fontstyle < 0
				global.fontstyle = 1
		
			if lastfont != global.fontstyle
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
				if !global.fontstyle
					global.bigfont = font_non_final
				else
					global.bigfont = font_final
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.fontstyle"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.fontstyle == 0 ? 1 : 0.5);
			draw_text(640 - 30, 106, lang_str_upper("options.old"));
			draw_set_alpha(global.fontstyle == 1 ? 1 : 0.5);
			draw_text(640 + 30, 106, lang_str_upper("options.final"));
			draw_set_alpha(1);
			
			draw_set_colour(c_ltgray);
			draw_text(640, 410, lang_str("options.ptox.fontstyle.desc"));
		}, optionr_new_save_data_info("online", "fontstyle", "fontstyle"))
	#endregion
	#region new pizzy
		optionr_new_option(visual_cat, "options.ptox.newpizzy", function(select)
		{
			var move = (key_left2 + key_right2);
			var lastpizzy = global.newpizzy
			global.newpizzy += move
		
			if select && move == 0
				global.newpizzy += 1
		
			if global.newpizzy > 2
				global.newpizzy = 0
			else if global.newpizzy < 0
				global.newpizzy = 2
		
		
			if lastpizzy != global.newpizzy
			{
				randomize()
				scr_soundeffect(sfx_menuchoose);
				with obj_player
				{
					if character == "SP"
						scr_characterspr();	
				}
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.newpizzy"));
			
			draw_set_font(global.font_small);
			
			draw_set_alpha(global.newpizzy == 0 ? 1 : 0.5);
			draw_text(640 - 75, 106, lang_str_upper("options.old"));
			draw_set_alpha(global.newpizzy == 1 ? 1 : 0.5);
			draw_text(640, 106, lang_str_upper("options.new"));
			draw_set_alpha(global.newpizzy == 2 ? 1 : 0.5);
			draw_text(640 + 75, 106, lang_str_upper("options.edited"));
			draw_set_alpha(1);
			
			draw_set_colour(c_ltgray);
			draw_text(640, 310, lang_str("options.ptox.newpizzy.desc"));
			pal_swap_set(spr_pizzpalette, 1, false);
			var sprs = [spr_playerSP_mach4_NEW, spr_playerSP_mach4_NEW2, spr_playerSP_mach4_EDIT]
			var pos_es = [[637, 195], [640, 195], [644, 193]]
			draw_sprite_ext(sprs[global.newpizzy], img * .35, pos_es[global.newpizzy][0], 
			pos_es[global.newpizzy][1], 2, 2, 0, make_color_rgb(255,255,255), 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "newpizzy", "newpizzy"))
	#endregion
	/*#region slope rot
		optionr_new_option(visual_cat, "options.ptox.sloperot", function(select)
		{
			if select
			{
				global.sloperot = !global.sloperot;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.sloperot"));
			
			draw_set_font(global.font_small);
			draw_text(640, 106, global.sloperot ? lang_str("options.on") : lang_str("options.off"));
			draw_set_colour(c_ltgray);
			draw_text(640, 390, lang_str("options.ptox.sloperot.desc"));
			
				var angle_target = 0, angle_spd = 0.6, timesforthelols = 1;
				
			if get_timer() / 1000000 % 8 < 2
				angle_target = -45
			if get_timer() / 1000000 % 8 > 4 && get_timer() / 1000000 % 8 < 6
				angle_target = 45
	
			pepslopeang = lerp(pepslopeang, angle_target, angle_spd);
			
			timesforthelols = 3 * !global.sloperot
			if timesforthelols == 0
				timesforthelols = 1
			var up_time = 70
			
			draw_sprite(spr_slopeoption, 0, 640, 345 - up_time)
			pal_swap_set(spr_peppalette, 1, 0)
			draw_sprite_ext(spr_player_idle, img * .35, 
			640 + ((pepslopeang * timesforthelols) / 1.6),
			280 - abs((pepslopeang * timesforthelols)) / 5 - up_time, 2, 2, 
			pepslopeang * global.sloperot, c_white, 1)
			pal_swap_reset()
		}, optionr_new_save_data_info("online", "sloperot", "sloperot"))
	#endregion
	*/
	#region pause blur
		optionr_new_option(visual_cat, "options.ptox.pauseblur", function(select)
		{
			if select
			{
				global.pausebg = !global.pausebg;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("Pause Blur"));
			
			draw_set_font(global.font_small);
			
			draw_text(640, 106, global.pausebg ? lang_str("options.on") : lang_str("options.off"));
			
			draw_set_colour(c_ltgray);
			draw_text(640, 410, lang_str("options.ptox.pauseblur.desc"));
		}, optionr_new_save_data_info("online", "pausebg", "pausebg"))
	#endregion
	#region texture after
		optionr_new_option(visual_cat, "options.ptox.textureafter", function(select)
		{
			if select
			{
				global.blurafterimage = !global.blurafterimage;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.textureafter"));
			
			draw_set_font(global.font_small);
			
			draw_text(640, 106, global.blurafterimage ? lang_str("options.on") : lang_str("options.off"));
			
			if !instance_exists(blur_op1)
			{
				machblur_flipped = round(irandom(1))
				
				var col1 = machblur_flipped ? make_colour_rgb(96, 208, 72) : make_colour_rgb(248, 0, 0)
				var col2 = machblur_flipped ? make_colour_rgb(248, 0, 0) : make_colour_rgb(96, 208, 72)
				
				blur_op1 = instance_create(640 - 100, 200, obj_blurafterimage_op)
			}
			if !instance_exists(blur_op2)
			{
				blur_op2 = instance_create(640 + 100, 200, obj_blurafterimage_op)
				with blur_op2
					tex = spr_paltex2
			}
			if !instance_exists(mach_op1)
			{
				mach_op1 = instance_create(640 - 100, 320, obj_mach3effect_op)
				with mach_op1
					image_blend = col1;
			}
			if !instance_exists(mach_op2)
			{
				mach_op2 = instance_create(640 + 100, 320, obj_mach3effect_op)
				with mach_op2
				{
					tex = spr_paltex2
					image_blend = col2
				}
			}
			
			draw_set_colour(c_ltgray);
			draw_text(640, 410, lang_str("options.ptox.textureafter"));
		}, optionr_new_save_data_info("online", "blurafterimage", "blurafterimage"))
	#endregion
	#region draw border
		optionr_new_option(visual_cat, "options.ptox.drawborder", function(select)
		{
			if select
			{
				global.drawborder = !global.drawborder;
				randomize()
				scr_soundeffect(sfx_menuchoose);
			}
		}, function() {
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_str_upper("options.ptox.drawborder"));
			
			draw_set_font(global.font_small);
			
			draw_text(640, 106, global.drawborder ? lang_str("options.on") : lang_str("options.off"));
			
			draw_set_colour(c_ltgray);
			draw_text(640, 410, lang_str("options.ptox.drawborder.desc"));
		}, optionr_new_save_data_info("online", "drawborder", "drawborder"))
	#endregion
	
	ptox_option_count = optionr_get_amount_of_options(options_categories_ptox) - 1
	texture_blur_shit_index = ptox_option_count - 1
#endregion