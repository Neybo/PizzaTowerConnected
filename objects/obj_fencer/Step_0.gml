
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
	case states.rage: scr_enemy_rage (); break;
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

//Scared
scr_scareenemy()

//Identify the player
var targetplayer = instance_nearest(x, y, obj_player);
if ragebuffer > 0
	ragebuffer--

//Charge
if instance_exists(targetplayer) && !rematchscare
{
	if (targetplayer.x > x - 400 && targetplayer.x < x + 400) && (y <= targetplayer.y + 20 && y >= targetplayer.y - 20)
	{
		if state != states.rage && ragebuffer <= 0 && global.stylethreshold >= 3 && (state == states.walk or state == states.charge)
		{
			state = states.rage
			sprite_index = spr_fencer_rage
			if global.snickrematch
				sprite_index = spr_fencer_rage_re
			
			if x != targetplayer.x
				image_xscale = -sign(x - targetplayer.x)
			
			ragebuffer = 100
			image_index = 0
			image_speed = 0.5
			flash = 1
			alarm[4] = 5
			create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale)
		}
		else if x != targetplayer.x && grounded && state == states.walk && !charging
		{
			charging = true
			state = states.charge
			movespeed = 5
			vsp = -7
			sprite_index = spr_chargestart
		}
	}
}

if state == states.stun or state == states.walk
{
	charging = false
	movespeed = 0
}

//Charge sprite
if sprite_index = spr_chargestart && floor(image_index) = image_number -1
	sprite_index = spr_charge

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}

if !hitboxcreate && (state == states.walk or state == states.rage or state == states.charge) && !rematchscare
{
	hitboxcreate = true
	with instance_create(x, y, obj_forkhitbox)
		ID = other.id
}

if state != states.grabbed
	depth = 0

if state != states.stun
	thrown = false

if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = spr_fencer
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}