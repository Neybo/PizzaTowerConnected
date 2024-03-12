switch (state)
{
	case states.idle: grav = 0.5; scr_enemy_idle (); break;
	case states.charge: grav = 0.5; scr_enemy_charge (); break;
	case states.turn: grav = 0.5; scr_enemy_turn (); break;
	case states.walk: grav = 0.5; scr_enemy_walk (); break;
	case states.land: grav = 0.5; scr_enemy_land (); break;
	case states.hit: grav = 0.5; scr_enemy_hit (); break;
	case states.stun: grav = 0.5; scr_enemy_stun (); break;
	case states.pizzagoblinthrow: grav = 0.5; scr_pizzagoblin_throw (); break;
	case states.grabbed: grav = 0.5; scr_enemy_grabbed (); break;
}

//Scared
scr_scareenemy()

if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x,y, obj_enemybird)
		ID = other.id
}

if state != states.stun
	birdcreated = false

// taunt
if inv_timer > 0
{
	inv_timer--
	if place_meeting(x, y, obj_player)
	{
		var player_inst = instance_place(x, y, obj_player)
		var player_state = player_inst.state
		
		if player_inst.instakillmove or player_state == states.handstandjump
		{
			scr_hurtplayer(player_inst)
			
			var abs_hsp = abs(player_inst.hsp)
			if player_inst.x != x
				player_inst.hsp = sign(x - player_inst.x) * abs_hsp
			
			if state != states.parry
			{
				sprite_index = parryspr
				movespeed = 8
				state = states.parry
				image_index = 0
			}
		}
	}
}
else
	invincible = false

if state == states.walk
{
	grav = 0.5
	if cooldown_count > 0
	{
		cooldown_count--
		if instance_exists(taunteffect_inst) && taunteffect_inst.object_index == obj_baddietaunteffect
		{
			instance_destroy(taunteffect_inst)
			taunteffect_inst = noone
		}
	}
	else
	{
		cooldown_count = cooldown_max
		
		taunt_count = taunt_max
		taunt_storedstate = state
		taunt_storedmovespeed = movespeed
		taunt_storedhsp = hsp
		
		if global.stylethreshold < 3
		{
			if point_in_camera(x, y, view_camera[0])
			&& !fmod_is_instance_playing(snd_taunt) && REMIX_GAMEPLAY
				fmod_play_instance(snd_taunt);
		
			taunteffect_inst = instance_create(x, y, obj_baddietaunteffect)
			sprite_index = spr_coolpinea_taunt
			image_speed = 0
			image_index = choose(0, 1, 2)
			state = states.backbreaker
			hsp = 0
			vsp = 0
			grav = 0
		}
		else
		{
			breakdance = 35
			state = states.punch
			sprite_index = spr_coolpinea_ragestart
			image_index = 0
			breakdanceinst = instance_create(x, y, obj_pineabreakdancehitbox)
			breakdanceinst.ID = id
			flash = true
			
			create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
		}
	}
}

if state != states.backbreaker && instance_exists(taunteffect_inst)
	instance_destroy(taunteffect_inst)

switch state
{
	case states.backbreaker:
		image_speed = 0
		inv_timer = inv_max
		invincible = true
		killbyenemy = false
		hsp = 0
		vsp = 0
	
		if taunt_count > 0
			taunt_count--
		else
		{
			sprite_index = walkspr
			invincible = false
			killbyenemy = true
			grav = taunt_storedgrav
			state = taunt_storedstate
			hsp = taunt_storedhsp
			cooldown_count = cooldown_max
			movespeed = taunt_storedmovespeed
		}
		break;
	
	case states.parry:
		if !fmod_is_instance_playing(snd_parry) && REMIX_GAMEPLAY
		{
			fmod_play_instance(snd_parry)
			with instance_create(x, y, obj_parryeffect)
				image_xscale = other.image_xscale
		}
		
		image_speed = 0.35
		if trail_count > 0
			trail_count--
		else
		{
			with instance_create(x, y, obj_afterimage)
			{
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_xscale = other.image_xscale
			}
			trail_count = trail_max
		}
		if instance_exists(taunteffect_inst) && taunteffect_inst.object_index == obj_baddietaunteffect
		{
			instance_destroy(taunteffect_inst)
			taunteffect_inst = noone
		}
	
		inv_timer = inv_max
		invincible = true
		killbyenemy = false
	
		if movespeed > 0
			movespeed -= 0.5
		else
			movespeed = 0
		hsp = movespeed * -image_xscale
	
		if image_index >= image_number - 1
		{
			sprite_index = walkspr
			invincible = false
			killbyenemy = true
			grav = taunt_storedgrav
			state = taunt_storedstate
			hsp = taunt_storedhsp
			cooldown_count = cooldown_max
			movespeed = taunt_storedmovespeed
		}
		break;
	
	case states.punch:
		if sprite_index == spr_coolpinea_ragestart
		{
			hsp = 0
			inv_timer = 0
			invincible = false
			killbyenemy = true
			
			if floor(image_index) >= image_number - 1
			{
				sprite_index = spr_coolpinea_rage
				breakdance_movespeed = 10
				hsp = breakdance_movespeed * image_xscale
			}
		}
		else
		{
			breakdance_movespeed = Approach(breakdance_movespeed, 0, 0.25)
			hsp = image_xscale * breakdance_movespeed
			
			if scr_solid(x + sign(hsp), y)
			{
				image_xscale *= -1
				if breakdance_movespeed < 3
					breakdance_movespeed = 5
				hsp = breakdance_movespeed * image_xscale
			}
			
			inv_timer = inv_max
			invincible = true
			killbyenemy = false
			
			if trail_count > 0
				trail_count--
			else
			{
				with instance_create(x, y, obj_afterimage)
				{
					sprite_index = other.sprite_index
					image_index = other.image_index
					image_xscale = other.image_xscale
				}
				trail_count = trail_max
			}
			if breakdance > 0
				breakdance--
			else
			{
				sprite_index = walkspr
				invincible = false
				killbyenemy = true
				state = states.walk
				breakdanceinst = noone
			}
		}
		break;
}

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}

/*
if  hitboxcreate = false && (state == states.walk) 
{
hitboxcreate = true
with instance_create(x,y,obj_forkhitbox)
{
	sprite_index = spr_coolpineahitbox
ID = other.id
}
}
*/

if state != states.grabbed
	depth = 0

if state != states.stun
	thrown = false

if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = other.sprite_index
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}