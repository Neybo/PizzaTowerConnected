function optionr_new_section(_exitfunc = -4)
{
	return {
		categories: [],
		exitfunc: _exitfunc
	}
}

function optionr_new_category(section, category_name){
	var cate = {
		name: category_name,
		options: [],
		save_data: []
	}
	array_push(section.categories, cate)
	return cate
}


function optionr_new_option(category, op_name, op_updatefunc, op_drawfunc, save_data_info){
	var option = {
		name: op_name,
		updatefunc: op_updatefunc,
		drawfunc: op_drawfunc
	}
	array_push(category.options, option)
	array_push(category.save_data, save_data_info)
	return option
}

// r for reals, s for strings
function optionr_new_save_data_info(_category, _name, global_name, _write_type = "r"){
	return {
		category: _category,
		name: _name,
		write_type: _write_type,
		global_var_name: global_name
	}
}


function optionr_handle_update(section)
{
	var categories = section.categories
	
	var select = key_jump or keyboard_check_pressed(vk_enter);
	var opt_num = 0

	for (var cat_id = 0; cat_id < array_length(categories); cat_id++)
	{
		var option_amount = array_length(categories[cat_id].options)
		for (var opt_id = 0; opt_id < option_amount; opt_id++)
		{
			if opt_num == optionselected
			{
				categories[cat_id].options[opt_id].updatefunc(select)	
				cat_num_on = cat_id
			}
			opt_num++
		}
	}
}

function optionr_handle_draw(section)
{
	var categories = section.categories
	
	draw_set_font(global.font_small);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1)
	
	img += 1;
	if img >= (60 * 60) * 10
		img = 0;
	
	var opt_num = 0
	var prev_cat_name = ""
	
	var xbase = 72 + camx;
	var ybase = 32 + camy;
	
	var cursory = 86 + (16 * optionselected)
					+ (64 * cat_num_on)
				
	draw_sprite(spr_cursor, img * .3, 32, cursory + camy);
	camy = lerp(camy, min(-cursory + camera_get_view_height(view_camera[0]) / 2, 0), 0.1);
	
	for (var cat_id = 0; cat_id < array_length(categories); cat_id++)
	{
		var option_amount = array_length(categories[cat_id].options)
		if prev_cat_name != categories[cat_id].name
		{
			if prev_cat_name != ""
				ybase += 16
				
			draw_set_color(c_white)
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_transformed(xbase - 20, ybase, categories[cat_id].name, 2, 2, 0)
			
			ybase += 48
			prev_cat_name = categories[cat_id].name
		}
		
		for (var opt_id = 0; opt_id < option_amount; opt_id++)
		{
			draw_set_alpha(1);
			if opt_num == optionselected
				categories[cat_id].options[opt_id].drawfunc()
				
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			draw_text_colour(xbase, ybase, lang_string(categories[cat_id].options[opt_id].name), c_white, 
			c_white, c_white, c_white, (optionselected == opt_num ? 1 : 0.5));
			
			ybase += 16
			opt_num++
		}
	}
	
	if optionselected != texture_blur_shit_index
	{
		if instance_exists(blur_op1)
		{
			instance_destroy(blur_op1)
			instance_destroy(blur_op2)
			instance_destroy(mach_op1)
			instance_destroy(mach_op2)
		}
	}
}

function optionr_handle_exit(section)
{
	if section.exitfunc != -4
		section.exitfunc()
		
	var categories = section.categories
	
	scr_soundeffect(sfx_dresserback)
	menuto = menustates.main
	
	ini_open("saveData.ini")
	
	for (var cat_id = 0; cat_id < array_length(categories); cat_id++)
	{
		var option_amount = array_length(categories[cat_id].save_data)
		for (var opt_id = 0; opt_id < option_amount; opt_id++)
		{
			var sv_data = categories[cat_id].save_data[opt_id]
			
			if sv_data.write_type == "s"
				ini_write_string(sv_data.category, sv_data.name,
				variable_global_get(sv_data.global_var_name))
			else
				ini_write_real(sv_data.category, sv_data.name,
				variable_global_get(sv_data.global_var_name))
		}
	}
	
	ini_close()
}

function optionr_get_amount_of_options(section)
{
	var categories = section.categories
	var amount = 0
	
	for (var cat_id = 0; cat_id < array_length(categories); cat_id++)
	{
		var option_amount = array_length(categories[cat_id].save_data)
		for (var opt_id = 0; opt_id < option_amount; opt_id++)
		{
			amount++
		}
	}
	
	return amount
}

// controls

function optionrc_create(list_of_controls, list_of_names, blacklisted_keys)
{
	//scr_resetinput()
	return
	{
		controls: list_of_controls,
		names: list_of_names,
		blacklist: blacklisted_keys
	}
}

function optionrc_update(keys)
{
	//Move up and down
	var amt_keys = array_length(keys.controls)
	
	scr_getinput(true);
	if selecting == -1 
	{
		if ((key_up2 && key_down2 != key_up2) or keyboard_check_pressed(vk_up)) 
		&& key_select > -1
		{
			key_select -= 1
			scr_soundeffect(sfx_step)
		}
		if ((key_down2 && key_up2 != key_down2)  or keyboard_check_pressed(vk_down)) 
		&& key_select < amt_keys - 1
		{
			key_select += 1
			scr_soundeffect(sfx_step)
		}
	}

	//Go back
	if (key_jump2 or keyboard_check_pressed(vk_enter)) && selecting = -1 && key_select = -1
	{
		scr_soundeffect(sfx_enemyprojectile)
	
		ini_open("saveData.ini");
		
		for (var keyid2 = 0; keyid2 < amt_keys; keyid2++)
		{
			var keyname = keys.controls[keyid2]
			ini_write_real("ControlsKeys", string_replace(keyname, "key_", ""), 
			variable_global_get(keyname))
		}

		ini_close(); 
		
		if instance_exists(obj_option)
			obj_option.visible = true
		instance_destroy()
	}
	
	for (var keyid = 0; keyid < amt_keys; keyid++)
	{
		var keyname = keys.controls[keyid]
			
		//INPUT
		if selecting = keyid
		{
			if keyboard_check_pressed(vk_anykey) 
			{
				if do_i_nuh_uh()
				{
					scr_soundeffect(sfx_denied)
					selecting = -1
					savekey = -1
					return
				}
				selecting = -1
				savekey = -1
				variable_global_set(keyname, keyboard_key)
			}
		}

		if key_select == keyid && (key_jump or keyboard_check_pressed(vk_enter)) && selecting = -1 
		{
			selecting = key_select
			savekey = variable_global_get(keyname)
			variable_global_set(keyname, -1)
		}
	}
}

function optionrc_draw(keys)
{
	// setup
	draw_set_font(global.bigfont);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_colour(c_white);

	draw_rectangle_color(0, 0, 960, 540, c_black, c_black, c_black, c_black, false)
	draw_text_colour(80, 20, "BACK", c_white, c_white, c_white, c_white, key_select == -1 ? 1 : 0.5)

	// keys
	var amt_keys = array_length(keys.controls) 
	for (var keyid = 0; keyid < amt_keys; keyid++)
	{
		var keyname = keys.controls[keyid]
		
		draw_text_colour(960/2 - 130, 20 + (45 * keyid), 
		keys.names[keyid], c_white, c_white, c_white, c_white, 
		key_select == keyid ? 1 : 0.5)	
		draw_text(960/2 + 110, 20 + (45 * keyid), scr_keyname(variable_global_get(keyname)))
	}
}