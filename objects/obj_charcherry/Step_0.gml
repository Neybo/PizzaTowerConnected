if state == states.stun
{
	image_index = 5;
	sprite_index = popoutspr;
	state = states.cherrywait;
}

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
	
	case states.cherrywait:
	{
		var targetplayer = obj_player;
		if vsp < 0
			vsp = 0;
		
		if global.panic && sprite_index != popoutspr
		&& targetplayer.x > x - 400 && targetplayer.x < x + 400
		&& y <= targetplayer.y + 60 && y >= targetplayer.y - 60
		{
			image_index = 0;
			sprite_index = popoutspr;
		}
		
		if sprite_index == popoutspr
		{
			parryable = true;
			if floor(image_index) >= 22
				state = states.walk;
			else
				scr_collide();
		}
		break;
	}
}

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // Flashes for 0.8 seconds before turning back to normal
}

if state != states.chase
	momentum = 0

if state == states.cherrywait
	depth = 101;
else
	depth = 0;

//Chase
if state == states.walk or state == states.idle
{
	//Identify the player
	var targetplayer = obj_player;
	
	movespeed = 10;
	if x != targetplayer.x
		image_xscale = -sign(x - targetplayer.x);
	momentum = -image_xscale * movespeed;
	
	state = states.chase;
}

if sprite_index == popoutspr && floor(image_index) >= image_number - 1
	sprite_index = walkspr;

