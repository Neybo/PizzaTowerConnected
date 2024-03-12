switch state
{
	case states.idle: scr_enemy_idle (); break;
	case states.turn: scr_enemy_turn (); break;
	case states.walk: movespeed = 0; hsp = 0; scr_enemy_walk (); break;
	case states.land: scr_enemy_land (); break;
	case states.hit: scr_enemy_hit (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.charge: scr_enemy_charge (); break;
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

// Attack
var targetplayer = instance_nearest(x, y, obj_player)
if x != targetplayer.x && grounded
{
    if targetplayer.x > x - 400 && targetplayer.x < x + 400 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
    {
        if state == states.walk
        {
            state = states.charge
            movespeed = 0
            image_xscale = -sign(x - obj_player.x)
            sprite_index = spr_banana_chargestart
            image_index = 0
        }
    }
}
if sprite_index == spr_banana_chargestart && floor(image_index) >= image_number - 1
    sprite_index = spr_banana_charge

if !hitboxcreate && state == states.charge && sprite_index == spr_banana_charge
{
    hitboxcreate = true
    with instance_create(x, y, obj_forkhitbox)
    {
        ID = other.id
        image_xscale = other.image_xscale
        x = other.x
        y = other.y
        depth = -1
        sprite_index = spr_chargershitbox
        mask_index = spr_chargershitbox
    }
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
