switch state
{
	case states.idle: scr_enemy_idle (); break;
	case states.turn: scr_enemy_turn (); break;
	case states.walk: scr_enemy_walk (); break;
	case states.land: scr_enemy_land (); break;
	case states.hit: scr_enemy_hit (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
	// grabbed state here
	case states.rage: scr_enemy_rage (); break;
}

if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x, y, obj_enemybird)
		ID = other.id
}
if state != states.stun
	birdcreated = false

//Flash
if flash && alarm[2] <= 0
	alarm[2] = 9; // Flashes for 0.8 seconds before turning back to normal

//Scared
scr_scareenemy()

// Heat attack
var player = instance_nearest(x, y, obj_player);
if instance_exists(player) && global.stylethreshold >= 3 && object_index == obj_cheeseslime
{
	if state == states.walk
	{
		if player.x > x - 200 && player.x < x + 200
		&& player.y <= y + 60 && player.y >= y - 60
		{
			if state != states.rage && ragebuffer <= 0
			{
				state = states.rage
				sprite_index = ragespr
				
				if player.x != x
					image_xscale = -sign(x - player.x);
				
				ragebuffer = 100;
				image_index = 0;
				image_speed = 0.5;
				flash = true;
				alarm[4] = 5;
				
				create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
			}
		}
	}
	if ragebuffer > 0
		ragebuffer--;
}

if state != states.grabbed
	depth = 0

if state != states.stun 
	thrown = false

if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = spr_slimemove
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}