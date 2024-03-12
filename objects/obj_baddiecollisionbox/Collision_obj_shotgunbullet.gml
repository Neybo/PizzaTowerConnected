if !instance_exists(baddieID) or baddieID.state == states.grabbed or baddieID.invtime > 0
	exit;

if instance_exists(baddieID) && !baddieID.invincible && baddieID.instantkillable
{
	scr_soundeffect(sfx_punch);
	
	baddieID.hitvsp = -8;
    baddieID.hithsp = other.image_xscale * 15;
	scr_hitthrow(baddieID, noone, 10);
	
	instance_destroy()
	instance_destroy(baddieID)
	
	with obj_camera
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
}
else if instance_exists(baddieID)
{
	baddieID.invtime = 20
	
	scr_soundeffect(sfx_hitenemy)
	scr_soundeffect(sfx_machpunch)
	
	if baddieID.object_index == obj_pizzaballOLD
		global.golfhit += 1
	else
		baddieID.hp -= 1
	global.combotime = 60
	
	baddieID.flash = true
	
	if OLD_GAMEPLAY
	{
		instance_create(baddieID.x, baddieID.y, obj_slapstar)
		create_particle(baddieID.x, baddieID.y, particles.baddiegibs)
		
		instance_create(x, y, obj_bumpeffect)
		instance_create(baddieID.x, baddieID.y, obj_bangeffect)
		
		baddieID.state = states.stun;
		if baddieID.stunned < 100
			baddieID.stunned = 100;
		
		baddieID.vsp = -4;
		baddieID.hsp = other.image_xscale * 5;
	}
	else
	{
		baddieID.hitvsp = -8;
		baddieID.hithsp = other.image_xscale * 15;
		scr_hitthrow(baddieID, noone, 10);
	}
}

if FINAL_GAMEPLAY
	instance_destroy(other);
