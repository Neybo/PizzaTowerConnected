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
	
	case states.mach1:
		if image_index > image_number - 1
		{
			hsp = image_xscale * startmachspeed
			sprite_index = spr_robot_mach
			image_index = 0
			state = (80 << 0)
		}
		break
	case states.mach2:
		hsp = Approach(hsp, image_xscale * machspeed, 0.5)
		if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting((x + sign(hsp)), y, obj_slope)
		{
			state = states.stun
			stunned = 100
			vsp = -4
			hsp = -image_xscale * 2
		}
		break
	case states.tackle:
		if image_index > 8
			hsp = image_xscale * tacklespeed
		if image_index > image_number - 1
		{
			state = states.walk
			sprite_index = walkspr
		}
		if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
		{
			state = states.stun
			stunned = 100
			vsp = -8
			hsp = -image_xscale * 5
		}
		break
	case states.slap:
		hsp = 0
		if image_index > image_number - 1
		{
			state = states.walk
			sprite_index = walkspr
		}
		break
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
   alarm[2] = 9; // vsc op

if state != states.grabbed
	depth = 0

if state != states.stun
	thrown = false

if bombreset > 0
	bombreset = max(bombreset - 1, 0);

//Throw Bomb at
var targetplayer = instance_nearest(x, y, obj_player)
if FINAL_GAMEPLAY
{
	invincible = state == states.mach2
	if x != targetplayer.x && state != states.pizzagoblinthrow && bombreset <= 0
	{
		if targetplayer.x > x - 400 && targetplayer.x < x + 400 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
		{
			if state == states.walk or state == states.idle
			{
				image_index = 0
				image_xscale = -sign(x - targetplayer.x)
				state = choose(states.mach1, states.tackle, states.slap)
				bombreset = 100
				
				switch state
				{
					case states.mach1:
						sprite_index = spr_robot_machstart
						break
					case states.tackle:
						sprite_index = spr_robot_tackle
						break
					case states.slap:
						sprite_index = spr_robot_slap
						break
				}

				image_index = 0
				image_speed = 0.35
				hsp = 0
			}
		}
	}
	
	if state == states.mach2 or (state == states.slap && image_index > 13)
	or (state == states.tackle && image_index > 8)
	{
		if !hitboxcreate
		{
			hitboxcreate = true
			with instance_create(x, y, obj_forkhitbox)
			{
				if other.state == states.slap
					sprite_index = spr_swordhitbox
				ID = other.id
			}
		}
	}
	else
		hitboxcreate = false
}
else
{
	if x != targetplayer.x && state != states.pizzagoblinthrow && bombreset <= 0
	{
		if targetplayer.x > x - 400 && targetplayer.x < x + 400 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
		{
			if state == states.walk or state == states.idle
			{
				image_index = 0
				image_xscale = -sign(x - targetplayer.x)
				state = states.pizzagoblinthrow
			}
		}
	}
	if state == states.walk
		sprite_index = walkspr
}

if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = other.walkspr
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}

