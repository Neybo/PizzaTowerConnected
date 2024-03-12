switch (state)
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

if place_meeting(x + hsp, y, obj_iceblock) && state == states.charge
{
	with instance_place(x + hsp, y, obj_iceblock)
		instance_destroy()
}

var targetplayer = instance_nearest(x, y, obj_player)
if FINAL_GAMEPLAY
{
	scr_scareenemy();
	if state == states.walk && attack_cooldown <= 0
	{
		if targetplayer.x > x - 200 && targetplayer.x < x + 200
		&& targetplayer.y < y + 50 && targetplayer.y > y - 50
		{
			flame_buffer = flame_max
			state = states.charge
			
			if x != targetplayer.x
				image_xscale = sign(targetplayer.x - x)
			
			sprite_index = spr_peasanto_flameattack
			image_index = 0
			image_speed = 0.35
			
			vsp = -5
			hitboxcreate = false
		}
	}
	if state == states.charge
	{
		if !hitboxcreate
		{
			hitboxcreate = true
			with instance_create(x, y, obj_peasantohitbox)
				ID = other.id
		}
		if flame_buffer <= 0
		{
			state = states.walk
			sprite_index = walkspr
			attack_cooldown = attack_max
		}
		if hsp != 0 && floor(image_index) >= image_number - 1
			instance_create(x - image_xscale * 20, y + 43, obj_cloudeffect)
	}
	
	if flame_buffer > 0
		flame_buffer--
	if attack_cooldown > 0
		attack_cooldown--
	
	if sprite_index == idlespr && (hsp != 0 or vsp != 0)
		sprite_index = walkspr
}
else
{
	//Chargehitbox
	if !hitboxcreate && state == states.charge && grounded && targetplayer.state != states.mach3 && targetplayer.state != states.mach2
	{
		hitboxcreate = true
		with instance_create(x, y, obj_forkhitbox)
		{
			sprite_index = spr_player_mask
			ID = other.id
		}
	}

	//Charge
	if state != states.walk && state != states.idle && state != states.grabbed && state != states.hit && (state != states.stun or stunned <= 0) && !angry && !thrown && hp > 0
	{
		grav = 0.5	
		vsp = -5
		image_index = 0
		state = states.charge
		angry = true
		thrown = false
	}
	
	if state == states.charge
		movespeed = 4;
	if state == states.walk
		movespeed = 1;
	
	if state != states.stun && state != states.grabbed && state != states.idle && state != states.charge && state != states.hit
		angry = false
}

//Flash
if flash == true && alarm[2] <= 0
   alarm[2] = 9; // vsc op

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

