switch state
{	
	case states.idle: scr_enemy_idle (); break;
	case states.charge: scr_enemy_charge (); break;
	case states.turn: scr_enemy_turn (); break;
	case states.walk:
		if !grounded
			sprite_index = spr_ufogrounded_fall
		if sprite_index != spr_ufogrounded_fall && sprite_index != spr_ufogrounded_land
		{
			invincible = false
			scr_enemy_walk()
		}
		else if sprite_index == spr_ufogrounded_fall
		{
			hsp = 0
			if grounded
			{
				sprite_index = spr_ufogrounded_land
				image_index = 0
			}
		}
		else
		{
			if image_index > 11
				hsp = sign(image_xscale)
			if floor(image_index) >= image_number - 1
			{
				sprite_index = spr_ufogrounded_walk
				invincible = false
			}
		}
		break;
	
	case states.land: scr_enemy_land (); break;
	case states.hit: scr_enemy_hit (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
	case states.rage: scr_enemy_rage (); break;
}
if state != states.walk
	invincible = false;

if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x, y, obj_enemybird)
		ID = other.id
}

if state != states.stun
	birdcreated = false

var targetplayer = instance_nearest(x, y, obj_player);
if bombreset > 0
	bombreset--
if x != targetplayer.x && state != states.pizzagoblinthrow && bombreset <= 0 && grounded
{
	if targetplayer.x > x - 400 && targetplayer.x < x + 400 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
	{
		if state == states.walk or state == states.idle
		{
			sprite_index = spr_ufogrounded_shoot
			image_index = 0
			image_xscale = -sign(x - targetplayer.x)
			state = states.pizzagoblinthrow
		}
	}
}

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}

if state != states.grabbed
	depth = 0

//Scared
scr_scareenemy()

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

