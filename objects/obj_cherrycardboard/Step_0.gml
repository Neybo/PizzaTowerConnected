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
}

//Flash
if flash == true && alarm[2] <= 0
   alarm[2] = 9; // Flashes for 0.8 seconds before turning back to normal

if state == states.walk
	state = states.idle

if state != states.grabbed
	depth = 0

if state != states.stun 
	thrown = false

if state == states.cherrywait
{
	var targetplayer = obj_player;
	if vsp < 0
		vsp = 0;
	
	if active && sprite_index != spr_cardcherry_getup
	&& targetplayer.x > x - 400 && targetplayer.x < x + 400
	&& y <= targetplayer.y + 60 && y >= targetplayer.y - 60
	{
		image_index = 0;
		sprite_index = spr_cardcherry_getup;
		
		if x != targetplayer.x
			image_xscale = sign(targetplayer.x - x);
	}
	
	if sprite_index == spr_cardcherry_getup
	{
		if image_index >= image_number - 1
		{
			sprite_index = idlespr;
			state = states.idle;
		}
		else
			scr_collide();
	}
}
else if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = other.sprite_index
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}

