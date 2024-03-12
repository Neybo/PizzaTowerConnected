switch (state)
{
	case states.idle: scr_enemy_idle (); break;
	case states.turn: scr_enemy_turn (); break;
	case states.walk: scr_enemy_walk (); break;
	case states.land: scr_enemy_land (); break;
	case states.hit: scr_enemy_hit (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
	// grabbed state here
	 case states.charge: scr_enemy_charge (); break;
}


if  state = states.stun && stunned > 100 && birdcreated = false
{
	birdcreated = true
	with instance_create(x,y, obj_enemybird)
		ID = other.id
}

scr_scareenemy()

if state != states.stun
	birdcreated = false

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}


//Identify the player
var targetplayer = obj_player

if ((targetplayer.x > x - 400) && (targetplayer.x < x + 400)) && (y <= targetplayer.y+60 && y >= targetplayer.y- 60)
if (state == states.walk or state == states.idle)
	activated = true

if !activated && (state == states.walk or state == states.idle)
	sprite_index = spr_banditochicken_sleep

//Chase
if (state == states.walk or state == states.idle) && activated == true && sprite_index != spr_banditochicken_wake && sprite_index != spr_banditochicken_scared
{
	movespeed = 0
	image_xscale = -sign(x - targetplayer.x)
	image_index = 0
	sprite_index = spr_banditochicken_wake
}

if sprite_index == spr_banditochicken_wake && floor(image_index) = image_number -1
{
	image_xscale *= -1
	sprite_index = spr_banditochicken_chase
	state = states.charge
	
	if FINAL_GAMEPLAY
		movespeed = 10
	with instance_create(x, y, obj_jumpdust)
	 image_xscale = other.image_xscale
}

if state == states.charge && bonebuffer > 0
	bonebuffer --

//Throw projectile
if bonebuffer <= 0
{
	if global.stylethreshold < 3
	{
		with instance_create(x,y,obj_banditochicken_projectile)
		{
			vsp = -9
			hsp = -image_xscale * 4
			image_xscale = other.image_xscale
		}
	}
	else
	{
		flash = true
		create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
		
		with instance_create(x, y, obj_banditochicken_dynamite)
		{
			sprite_index = spr_banditodynamite
			vsp = -9
			image_xscale = other.image_xscale
			hsp = -image_xscale * 4
		}
	}
	
	bonebuffer = 60
	if FINAL_GAMEPLAY
		bonebuffer = 100
}

if state == states.charge && movespeed < 5 && OLD_GAMEPLAY
	movespeed += 0.1

if state != states.grabbed
	depth = 0


if state != states.stun 
	thrown = false

if boundbox = false
{
	with instance_create(x,y,obj_baddiecollisionbox)
	{
		sprite_index = other.sprite_index
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}
