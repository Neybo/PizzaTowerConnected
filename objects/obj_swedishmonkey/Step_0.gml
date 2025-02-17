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

//Scared
scr_scareenemy()

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}


if state != states.grabbed
	depth = 0

if state != states.stun
	thrown = false

if bombreset > 0
	bombreset = max(bombreset - 1, 0);

//Throw Bomb at
if state != states.pizzagoblinthrow && bombreset <= 0 && grounded
{
	if state == states.walk or state == states.idle
	{
		image_index = 0
		sprite_index = spr_swedishmonkey_eat

		state = states.pizzagoblinthrow
	}
}

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