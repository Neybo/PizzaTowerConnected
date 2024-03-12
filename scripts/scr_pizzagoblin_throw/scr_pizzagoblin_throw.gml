function scr_pizzagoblin_throw()
{
	// STATIC values
	if !variable_global_exists("throw_vars")
	{
		global.throw_vars[obj_pizzagoblin] = {frame: 2, sprite: spr_pizzagoblin_throwbomb, timer: 200};
		global.throw_vars[obj_pizzagoblinnew] = {frame: 12, sprite: spr_pizzagoblin_throwbombnew, timer: 200};
		global.throw_vars[obj_canongoblin] = {frame: 5, sprite: spr_canongoblin_throwbomb, timer: 200};
		global.throw_vars[obj_noisegoblin] = {frame: 18, sprite: spr_archergoblin_shoot, timer: 200};
		global.throw_vars[obj_cheeserobot] = {frame: 6, sprite: spr_cheeserobot_attack, timer: 200};
		global.throw_vars[obj_spitcheese] = {frame: 2, sprite: spr_spitcheese_spit, timer: 100};
		global.throw_vars[obj_trash] = {frame: 2, sprite: spr_trash_throw, timer: 100};
		global.throw_vars[obj_invtrash] = {frame: 2, sprite: spr_invtrash_throw, timer: 100};
		global.throw_vars[obj_robot] = {frame: 6, sprite: spr_robot_attack, timer: 200};
		global.throw_vars[obj_kentukykenny] = {frame: 8, sprite: spr_kentukykenny_throw, timer: 200};
		global.throw_vars[obj_pizzard] = {frame: 6, sprite: spr_pizzard_shoot, timer: 100};
		global.throw_vars[obj_swedishmonkey] = {frame: 15, sprite: spr_swedishmonkey_eat, timer: 200};
		global.throw_vars[obj_rancher] = {frame: 3, sprite: spr_ranch_shoot, timer: 100};
		global.throw_vars[obj_tankOLD] = {frame: 6, sprite: spr_tank_shoot, timer: 100};
		global.throw_vars[obj_bazookabaddie] = {frame: 7, sprite: spr_tank_shoot, timer: 400};
		global.throw_vars[obj_tank] = {frame: 6, sprite: spr_tank_shoot, timer: 100};
		global.throw_vars[obj_miniufo] = {frame: 3, sprite: spr_ufolive_shoot, timer: 100};
		global.throw_vars[obj_miniufo_grounded] = {frame: 11, sprite: spr_ufogrounded_shoot, timer: 100};
		global.throw_vars[obj_thug_blue] = {frame: 9, sprite: spr_shrimp_knife, timer: 60};
		global.throw_vars[obj_thug_green] = {frame: 8, sprite: spr_shrimp_throw, timer: 60};
		global.throw_vars[obj_smokingpizzaslice] = {frame: 13, sprite: spr_pizzaslug_cough, timer: 10};
		global.throw_vars[obj_kentukybomber] = {frame: 7, sprite: spr_kentukybomber_attack, timer: 200};
		
		// sugary spire
		global.throw_vars[obj_cottonwitch] = {frame: 7, sprite: spr_cottonwitch_shoot, timer: 100};
	}
	
	// gameplay specific values
	global.throw_vars[obj_pepgoblin] = {frame: FINAL_GAMEPLAY_ONLY ? 0 : 2, sprite: spr_pepgoblin_kick, timer: 100};
	global.throw_vars[obj_pickle] = {frame: 2, sprite: spr_pickle_attack, timer: OLD_GAMEPLAY ? 120 : 200};
	
	// Stop moving
	hsp = 0

	// Change speed if I'm touching a rail
	if place_meeting(x, y + 1, obj_railh)
		hsp = -5
	else if place_meeting(x, y + 1, obj_railh2)
		hsp = 5

	// If I'm standing then return to idle
	if floor(image_index) >= image_number - 1
	{
		state = states.walk
		sprite_index = walkspr
		exit;
	}

	// Check if bomb timer expired and I'm on the right animation frame
	if bombreset <= 0
	{
		var spr = global.throw_vars[object_index].sprite;
		if global.snickrematch
		{
			if spr == spr_pizzagoblin_throwbomb
				spr = spr_pizzagoblin_throwbomb_re;
			if spr == spr_pizzard_shoot
				spr = spr_pizzard_shoot_re;
			if spr == spr_pepgoblin_kick
				spr = spr_pepgoblin_kick_re;
		}
		sprite_index = spr;
		
		if floor(image_index) == global.throw_vars[object_index].frame
		{
			// Set bomb timer and animation frame
			bombreset = global.throw_vars[object_index].timer;
			if REMIX_GAMEPLAY
				bombreset = ceil(bombreset / max((global.stylethreshold + 1) / 2, 1));
			image_index++;
			
			if point_in_camera(x, y, view_camera[0])
			{
				//fmod_stop_sound(sfx_enemyprojectile)
				scr_soundeffect(sfx_enemyprojectile)
			}
			
			// Spawn the right projectile
			switch object_index
			{
				case obj_pizzagoblin:
					with instance_create(x, y, obj_pizzagoblinbomb)
					{
						hsp = other.image_xscale * 10
						vsp = -8
					}
					break
				case obj_pizzagoblinnew:
					with instance_create(x, y, obj_pizzagoblinbombnew)
					{
						defused = true;
						movespeed = 5;
						image_xscale = other.image_xscale;
						vsp = -10;
						countdown = 80;
					}
					break
				case obj_kentukybomber:
					instance_create(x, y + 70, obj_kentukybomb);
					break;
				case obj_canongoblin:
					with instance_create(x, y, obj_canongoblinbomb)
						image_xscale = other.image_xscale
					break;
	
				case obj_noisegoblin:
					with instance_create(x + 22, y + 24, obj_noisegoblin_arrow)
						_id = other.id;
					break
		
				case obj_cheeserobot:
					with instance_create(x, y, obj_cheeseblob)
					{
						sprite_index = spr_cheeserobot_goop
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 8
						vsp = 0
						grav = 0
					}
					break
		
				case obj_spitcheese:
					with instance_create(x + image_xscale * 6, y - 6, obj_spitcheesespike)
					{
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 5
						vsp = -6
					}
					break
		
				case obj_trash:
				case obj_invtrash:
					with instance_create(x + image_xscale * 6, y - 6, obj_cheeseball)
					{
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 5
						vsp = -4
					}
					break
		
				case obj_robot:
					with instance_create(x + 8 * image_xscale, y, obj_robotknife) 
					{
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 5
						_id = other.id;
					}
					break
			
				case obj_kentukykenny:
					with instance_create(x, y, obj_kentukykenny_projectile)
						image_xscale = other.image_xscale
					break
				
				case obj_pizzard:
					
					with instance_create(x, y, obj_pizzard_bolt)
					{
						otherid = other.id
						image_xscale = other.image_xscale
					}
					break
				
				case obj_cottonwitch:
					with instance_create(x, y, obj_cottonwitch_projectile)
						image_xscale = other.image_xscale
					break
				
				case obj_swedishmonkey:
					if global.stylethreshold >= 3
						var banan = instance_create(x, y, obj_evilbanana);
					else
						banan = instance_create(x, y, obj_slipnslide);
				
					with banan
					{
						baddieID = other.id
						if other.image_xscale != 0
							image_xscale = other.image_xscale
						hsp = -image_xscale * 4
						vsp = -5
					
						if scr_solid(x, y)
							instance_destroy();
						else
						{
							with obj_evilbanana
								if baddieID == other.baddieID
									banana += 1;
							with obj_slipnslide
								if baddieID == other.baddieID
									banana += 1;
						}
					}
					break
			
				case obj_pepgoblin:
					with instance_create(x,y,obj_pepgoblin_kickhitbox)
					{
						baddieID = other.id
						image_xscale = other.image_xscale
					}
					break
		
				case obj_pickle:
					attacking = false;
					with instance_create(x,y,obj_forkhitbox)
					{
						ID = other.id
						image_xscale = other.image_xscale
						sprite_index = other.sprite_index
					}
					break
		
				case obj_tankOLD:
					with instance_create(x + image_xscale * 6, y - 6, obj_spitcheesespike)
					{
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 5
						vsp = -6
					}
					break
				case obj_bazookabaddie:
					with instance_create(x,y, obj_bazooka)
					{
						hsp = other.image_xscale * 5;
						vsp = 1;
						other.bazookaID = id;
						baddieID = other.id;
					}
					break;
				
				case obj_tank:
					with instance_create(x + image_xscale * 6, y - 6, obj_canongoblinbomb)
					{
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 5
					}
					break
			
				case obj_rancher:
					with instance_create(x + image_xscale * 6, y + 26, obj_rancher_bullet)
						image_xscale = other.image_xscale
					break
				
				case obj_smokingpizzaslice:
	                substate = choose(states.walk, states.idle, states.idle)
	                if substate == states.walk
	                    image_xscale = choose(-1, 1, -image_xscale)
					
	                substate_buffer = substate_max
	                with instance_create(x + 50 * image_xscale, y + 20, obj_smokingprojectile)
	                    image_xscale = other.image_xscale
	                break
				
				case obj_miniufo:
					instance_create(x, y, obj_warplaser)
					break
				
				case obj_miniufo_grounded:
					with instance_create(x + 8 * image_xscale, y, obj_enemybullet)
					{
						sprite_index = spr_ufogrounded_bullet
						image_xscale = other.image_xscale
					}
					break
				
				case obj_thug_blue:
					with instance_create(x + 8 * image_xscale, y, obj_robotknife)
					{
						image_xscale = other.image_xscale
						hsp = other.image_xscale * 5
					}
					break
				
				case obj_thug_green:
					with instance_create(x, y - 62, obj_junkenemy)
					{
						image_xscale = other.image_xscale
						image_index = other.trashimg
						hsp = other.image_xscale * 7
						vsp = -6
					}
					break
			}
		}
	}
	
	// Bump away from enemies and one-way walls?
	if !grounded && hsp < 0
		hsp += 0.1
	else if !grounded && hsp > 0
		hsp -= 0.1
}

