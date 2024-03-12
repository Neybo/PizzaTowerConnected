switch (state)
{
	case states.idle: scr_enemy_idle (); break;
	case states.walk: state = states.idle; break;
	case states.bounce: scr_noisecrusher_bounce (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.stunned: scr_enemy_stun (); break;
	// grabbed state here
}

if (state == states.stun || state == states.stunned) && stunned > 40 && birdcreated = false
{
	birdcreated = true
	with instance_create(x, y, obj_enemybird)
	ID = other.id
}

if state != states.stun && state != states.stunned
	birdcreated = false

//Look at player
var target = instance_nearest(x, y, obj_player);
if instance_exists(target) && state == states.idle && target.x != x
	image_xscale = sign(target.x - x)
	
if place_meeting(x, y, target) && target.instakillmove && state == states.stun // deal damage?
{
	global.bosshealth -= 1
	stuntouchbuffer = 15
	instance_create(x, y, obj_bangeffect)
	state = states.stunned
	stunned = 15
    image_xscale = -target.xscale
    hsp = target.xscale * 20
    vsp = (target.y - 180 - y) / 50
    invtime = 5
    flash = true
	repeat 2
    {
		with instance_create(x, y, obj_slapstar)
			vsp = irandom_range(-6, -11)
    }
	scr_soundeffect(sfx_punch);
}

if state == states.idle
	attack--

//Jump
if attack <= 0 && state == states.idle
{
	sprite_index = jumpprepspr
	image_index = 0
	state = states.bounce
}

//Helmet
if global.bosshealth < 6
	helmet = true

//Sprites
if helmet = false
{
	idlespr = spr_noisecrusher_bounce
	stunfallspr = spr_noisecrusher_stun
	walkspr = spr_noisecrusher_bounce
	grabbedspr = spr_noisecrusher_stun
	jumpprepspr = spr_noisecrusher_jumpprep
	jumpspr = spr_noisecrusher_jump
	landspr = spr_noisecrusher_land
	airspr = spr_noisecrusher_air
}
else
{
	idlespr = spr_noisecrusherhelmet_bounce
	stunfallspr = spr_noisecrusherhelmet_stun
	walkspr = spr_noisecrusherhelmet_bounce
	grabbedspr = spr_noisecrusherhelmet_stun
	jumpprepspr = spr_noisecrusherhelmet_jumpprep
	jumpspr = spr_noisecrusherhelmet_jump
	landspr = spr_noisecrusherhelmet_land
	airspr = spr_noisecrusherhelmet_air
}

//Die
if global.bosshealth <= 0
{
	instance_destroy()
	instance_destroy(obj_bosshealth)
}

//Caught player
if caughtplayer = true && !grounded
{
	obj_player.state = states.bump
	obj_player.image_index = 0
	obj_player.x = x
	obj_player.y = y
}
if caughtplayer = true && grounded
{
	obj_player.state = states.boxxedpep
	if obj_player.sprite_index != spr_boxxedpep_intro
	{
		obj_player.sprite_index = spr_boxxedpep_intro
		scr_soundeffect(sfx_pephurt)
		//scr_sound(sound_touchspike)
	}
	obj_player.image_index = 0
	obj_player.hsp = 0
	obj_player.vsp = 0
	obj_player.x = x
	obj_player.y = y - 20
	caughtplayer = false
}
//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 9; // vsc op
}



if state != states.grabbed
	depth = 0

scr_collide()

if state != states.stun && state != states.stunned
	thrown = false



