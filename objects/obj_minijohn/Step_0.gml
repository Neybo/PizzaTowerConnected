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
	case states.chase: scr_enemy_chase (); break;
	case states.rage: scr_enemy_rage (); break;
	
	case states.punch:
        if sprite_index == spr_minijohn_punchstart
        {
            image_speed = 0.35
            hsp = Approach(hsp, 0, 1)
            if floor(image_index) == image_number - 1
            {
                punchspd = 8
                hsp = punchspd * image_xscale
                sprite_index = spr_minijohn_punch
                image_index = 0
                image_speed = 0.25
                with instance_create(x, y, obj_forkhitbox)
                {
                    sprite_index = spr_bighitbox
                    mask_index = spr_bighitbox
                    ID = other.id
                }
            }
        }
        else if sprite_index == spr_minijohn_punch
        {
            image_speed = 0.25
            punchspd = Approach(punchspd, 0, 0.25)
            hsp = punchspd * image_xscale
            with instance_place(x + hsp, y, obj_destructibles)
                instance_destroy()
            if floor(image_index) == image_number - 1
            {
                state = states.chase
                ragecooldown = 100
                sprite_index = spr_minijohn_charge
            }
        }
        break
}

if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x, y, obj_enemybird)
		ID = other.id
}

if states.chase && ragecooldown <= 0 && FINAL_GAMEPLAY
{
	var player = instance_nearest(x, y, obj_player);
	if instance_exists(player)
	{
		if player.x > x - 400 && player.x < x + 400
		&& player.y <= y + 60 && player.y >= y - 60
		{
			if x != player.x
				image_xscale = -sign(x - player.x);
			
			if elite
			{
				sprite_index = spr_minijohn_rage1;
				image_index = 0;
				vsp = -8;
				flash = true;
				alarm[4] = 5;
				ragecooldown = 100;
				state = states.rage;
			
				create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
			
				with instance_create(x, y, obj_forkhitbox)
				{
					sprite_index = spr_bighitbox
					mask_index = spr_bighitbox
					ID = other.id
				}
			}
			else
	        {
	            sprite_index = spr_minijohn_punchstart
	            image_index = 0
	            ragecooldown = 100
	            state = states.punch
	        }
		}
	}
}
if ragecooldown > 0
	ragecooldown--;

if state != states.stun
	birdcreated = false

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}

if state != states.chase
	momentum = 0

//Chase
if state == states.walk or state == states.idle
{
	//Identify the player
	var targetplayer = obj_player

	movespeed = 4
	if OLD_GAMEPLAY
	{
		movespeed = 7
		momentum = -image_xscale * (movespeed + 4)
	}
	if x != targetplayer.x
		image_xscale = -sign(x - targetplayer.x)
	state = states.chase
}

if !hitboxcreate && state == states.chase && OLD_GAMEPLAY
{
	hitboxcreate = true
	with instance_create(x, y, obj_minijohn_hitbox)
	{
		sprite_index = other.sprite_index
		ID = other.id
	}
}

if state != states.grabbed
	depth = 0

if state != states.stun 
	thrown = false

if !boundbox
{
	with instance_create(x,y,obj_baddiecollisionbox)
	{
		sprite_index = other.sprite_index
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}
