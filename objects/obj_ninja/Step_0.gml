switch state
{
	case states.idle: scr_enemy_idle (); break;
	case states.charge: scr_enemy_charge (); break;
	case states.turn: scr_enemy_turn (); break;
	case states.walk: scr_enemy_walk (); break;
	case states.land: scr_enemy_land (); break;
	case states.hit: scr_enemy_hit (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
	// grabbed state here
}

if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x, y, obj_enemybird)
		ID = other.id
}

if state != states.stun
	birdcreated = false

var player = instance_nearest(x, y, obj_player);
if FINAL_GAMEPLAY
{
	if state == states.walk
	{
		if sprite_index == spr_pizzaboy
			hsp = 0
		else
		{
			move = sign(player.x - x)
			if move != 0
				image_xscale = move
			if movespeed < 4
				movespeed += 0.25
			
			if abs(x - player.x) < 230
			{
				hsp = -move * movespeed
				if move != 0 && move != -dir
					movespeed = 2
			}
			else if abs(x - player.x) > 240
			{
				hsp = move * movespeed
				if move != 0 && move != dir
					movespeed = 2
			}
			else
			{
				hsp = 0
				movespeed = 0
			}
			
			if hsp != 0
				dir = sign(hsp)
			
			// two ninjas colliding (seemingly one transfers the momentum to another??)
			if place_meeting(x, y, obj_ninja) or place_meeting(x + hsp, y, obj_ninja)
			{
				var b = instance_place(x, y, obj_ninja), s = 2;
				if !instance_exists(b)
				{
					s = 0;
					b = instance_place(x + hsp, y, obj_ninja);
				}
				if b.id < id
					hsp = -sign(b.dir) * s;
			}
		}
	}
	else if state == states.punch
	{
		image_speed = 0.35
		hsp = 0
		if floor(image_index) >= image_number - 1
		{
			state = states.walk
			sprite_index = walkspr
		}
		if image_index > 4 && image_index < 14
		{
			if !hitboxcreate
			{
				hitboxcreate = true
				with instance_create(x, y, obj_forkhitbox)
				{
					sprite_index = spr_bighitbox
					mask_index = spr_bighitbox
					ID = other.id
				}
			}
		}
		if sprite_index == spr_ninja_punchattack
		{
			if floor(image_index) != 5 && floor(image_index) != 8 && floor(image_index) != 11
				shot = false;
			else if !shot
			{
				scr_soundeffect(sfx_killingblow)
				with instance_create(x, y + 6, obj_enemybullet)
					image_xscale = other.image_xscale
				shot = true;
			}
		}
	}
	
	// ninja jumpscare
	if sprite_index == spr_pizzaboy
	{
		if x != player.x && player.x > x - 200 && player.x < x + 200 && player.y > y - 150 && player.y < y + 20
		{
			if state == states.walk or state == states.idle
			{
				scr_soundeffect(sfx_suplexdash);
				
				instance_create(x, y, obj_balloonpop);
				image_xscale = -sign(x - player.x)
				sprite_index = spr_ninja_uppercut
				image_index = 0
				state = states.charge
				roaming = true
				vsp = -14
				hsp = image_xscale * 4
				inv_timer = 5
				alarm[4] = 5
				
				with instance_create(x, y, obj_forkhitbox)
				{
					sprite_index = spr_bighitbox
					mask_index = spr_bighitbox
					ID = other.id
				}
			}
		}
	}
	else if state == states.walk && attack_buffer <= 0
	{
		attack_buffer = attack_max + irandom_range(-attack_random, attack_random)
		state = states.punch
		hsp = 0
		hitboxcreate = false
		
		if global.stylethreshold < 3
		{
			sprite_index = spr_ninja_kickattack
			image_index = 0
		}
		else
		{
			// shoots bullets in max heat (code for the bullets is higher)
			sprite_index = spr_ninja_punchattack
			image_index = 0
		}
	}
	if inv_timer > 0
	{
		inv_timer--
		invincible = true
	}
	else
		invincible = false
}
else
{
	//Charge
	if ((player.x > x - 200 && player.x < x + 200)
	or (player.sprite_index == player.spr_taunt && state != states.pizzagoblinthrow && player.x > x - 400 && player.x < x + 400))
	&& y <= player.y + 20 && y >= player.y - 20
	{
		if (state == states.walk or state == states.idle) && attack_buffer <= 0
		{
			if sprite_index == spr_pizzaboy
				instance_create(x, y, obj_balloonpop)
			
			if x != player.x
				image_xscale = -sign(x - obj_player.x)
			roaming = true

			attack = true
			vsp = -11
			scr_soundeffect(sfx_enemyprojectile)
			image_index = 0
			state = states.charge
			
			attack_buffer = attack_max
		}
	}
	
	if !attack
	{
		sprite_index = spr_pizzaboy
		if state != states.grabbed && state != states.stun && state != states.hit && !thrown
		{
			state = states.idle
			roaming = false
		}
	}
	
	// Chargehitbox
	if !hitboxcreate && state == states.charge
	{
		hitboxcreate = true
		with instance_create(x, y, obj_forkhitbox)
		{
			sprite_index = spr_player_mask
			ID = other.id
		}
	}
	if state != states.idle
		roaming = true
}
if attack_buffer > 0
	attack_buffer--

scr_scareenemy();

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}

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

