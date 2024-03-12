if !variable_instance_exists(id, "killreward")
	exit;

var list = escape ? global.escaperoom : global.baddieroom;
if ds_list_find_index(list, id) == -1
{
if room != hub_outside3d
	scr_failmod(mods.pacifist);
	scr_soundeffect(sfx_killenemy);
	
	with obj_camera
	{
		shake_mag = 3;
		shake_mag_acc = 0.05;
	}
	
	if variable_instance_exists(id, "custom_death_fnc") && is_method(custom_death_fnc)
		custom_death_fnc();
	else
	{
		if OLD_GAMEPLAY
		{
			scr_sleep(50);
			repeat 3
				instance_create(x, y, obj_slapstar);
			repeat 3
				create_particle(x, y, particles.baddiegibs);
		}
		
		var screamsnd = FMOD_EMPTY;
		if killreward && random_range(1, 100) >= 96 && FINAL_GAMEPLAY // 4% chance
		{
			if check_sugary()
				screamsnd = scr_soundeffect(sfx_scream_ss);
			else if NOT_REMIX_GAMEPLAY
				screamsnd = scr_soundeffect(sfx_enemyrarescream);
			else
				screamsnd = scr_soundeffect(sfx_enemyscream);
		}
		
		if sprite_exists(spr_dead)
		{
			with instance_create(x, y, obj_sausageman_dead)
			{
				image_speed = 0;
				sprite_index = other.spr_dead;
				
				if FINAL_GAMEPLAY && other.hsp != 0
					hsp = clamp(other.hsp, -12, 12);
			
				if variable_instance_exists(other, "haspalette") && other.haspalette
				{
					haspalette = other.haspalette;
					spr_palette = other.spr_palette;
				
					paletteselect = other.paletteselect;
				}
				if variable_instance_exists(other, "sugaryenemy")
					sugary = other.sugaryenemy;
				if variable_instance_exists(other, "surf")
				{
					surf = other.surf
					patternfucking = true
				}
				
				scream = screamsnd;
			}
		}
		
		if killreward
		{
			if FINAL_GAMEPLAY
			{
				instance_create(x, y, obj_genericpoofeffect);
				instance_create(x, y, obj_parryeffect);
			}
			instance_create(x, y, obj_bangeffect);
		}
	}
	
	if killreward
	{
		if REMIX_GAMEPLAY && object_index == obj_swedishmonkey 
		&& irandom_range(1, 100) == 5 // 1% chance
			scr_soundeffect(sfx_monkey);
		
		ds_list_add(list, id);
		
		// Combos
		increase_combo()
		
		if !global.snickchallenge
		{
			var num = 10;
			if OLD_GAMEPLAY
			{
				if global.combo <= 1
					num = 10;
				else 
					num = min(power(2, global.combo - 1) * 10, 80);
				
				with instance_create(x, y, obj_smallnumber)
					number = string(num);
			}
			else
			{
				num = 10 + round(10 * (global.combo * 0.5));
				global.comboscore += num;
			}
			global.collect += num;
		}
	}
}