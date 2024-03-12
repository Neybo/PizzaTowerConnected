/// @description Let's go to the beach!

if (hp == 10)
    maxspeed = 12
if (hp == 8)
    maxspeed = 14
if (hp == 6)
    maxspeed = 16
if (hp == 4)
    maxspeed = 18
if (hp == 2)
    maxspeed = 20
image_speed = 0.35
if ((sprite_index == chargespr || sprite_index == hurtspr) && !flashing)
{
    alarm[6] = 1
    flashing = true
}
if (!charging && !stunned)
{
    if (obj_player.x != x)
        image_xscale = sign((obj_player.x - x))
    hsp = 0
    sprite_index = normalspr
}
if (stunned && !thrown)
{
    if (hsp < 0)
        hsp += 0.1
    else if (hsp > 0)
        hsp -= 0.1
}
if charging
{
	if (!stunned)
	{
	    if (!instance_exists(obj_peppermancharge))
	        instance_create(x, y, obj_peppermancharge)
	    hsp = (image_xscale * movespeed)
	    if place_meeting(x + hsp * 5, y, obj_solid)
	        image_xscale *= -1
	    if (!chargingdown)
	    {
	        if (movespeed < maxspeed)
	            movespeed += 0.1
	        if (movespeed >= maxspeed)
	            chargingdown = true
	    }
	    else 
	    {
	        movespeed -= 0.25
	        if (movespeed <= 0)
	        {
	            alarm[1] = 100
	            chargingdown = false
	            charging = false
	        }
	    }
	    sprite_index = chargespr
	}
	
	// there was a joke here but the code is gone, sh
			
	if floor(image_index) == 0 && grounded
		instance_create(x, (y + 90), obj_cloudeffect)
}
if (charging && movespeed > 6)
    image_speed = 0.6
else
    image_speed = 0.35

if (hp <= 0 && !dead)
{
    scr_sleep(250)
    dead = true
    alarm[1] = -1
    alarm[4] = 5
    alarm[5] = 100
}
if (thrown)
{
	if place_meeting(x + hsp * 5, y, obj_solid)
	{
	    image_xscale *= -1
		hsp *= -1
	}
	if grounded
	{
	    instance_create(x, y, obj_slapstar)
	    instance_create(x, y, obj_slapstar)
	    instance_create(x, y, obj_slapstar)
	    scr_soundeffect(sfx_hitenemy)
	    obj_camera.shake_mag = 3
	    obj_camera.shake_mag_acc = 1 / 15
	    thrown = false
	    hp -= 1
	    flash = true
	    charging = false
	    stunned = true
	    movespeed = 0
	
	    if (obj_player.x != x)
	        image_xscale = sign((obj_player.x - x))
		
	    hsp = (sign((x - obj_player.x)) * 6)
	    vsp = -8
	
	    if (hp > 6)
	        sprite_index = spr_pepperman_hurt
	    if (hp <= 6 && hp > 3)
	        sprite_index = spr_peppermanmid_hurt
	    else if (hp <= 3)
	        sprite_index = spr_peppermanlow_hurt
	}
		
}
if (!thrown && !charging && !stunned)
{
	var player = instance_place(x, y, obj_player)
	if player
		with player
		{
			if state == states.mach3 or state == states.rocket 
			or (state == states.tumble && (OLD_GAMEPLAY or sprite_index == spr_tumble))
			or (state == states.freefall && freefallsmash > 10) or state == states.superslam
			or state == states.chainsawbump or state == states.punch or state == states.firemouth
			or state == states.knightpep or state == states.knightpepslopes
			or state == states.rideweenie or state == states.newweenieriding 
			or state == states.faceplant or state == states.chainsaw 
			or state == states.handstandjump or state == states.kungfu
			{
				if global.hitstun
				{
					tauntstoredstate = state
					state = states.hitlag
					hitLag = 7;
					hitX = x;
					hitY = y;
					tauntstoredvsp = vsp
					tauntstoredmovespeed = movespeed
					tauntstoredsprite = sprite_index
				}
				with other
				{	
					hitlag = 7 * (global.hitstun) - (!global.hitstun)
					charging = false
					chargingdown = false
					movespeed = 0
					image_xscale = -other.xscale
					stunned = true
					thrown = true
					hl_hsp = -image_xscale * 15
					hl_vsp = -6
					hsp = -image_xscale * 15
					vsp = -6
				}
			}
		}
}
if (flash && alarm[3] <= 0)
    alarm[3] = 9
if (hp > 6)
{
    normalspr = spr_pepperman
    hurtspr = spr_pepperman_hurt
    chargespr = spr_pepperman_charge
    stunspr = spr_pepperman_stun
}
if (hp <= 6 && hp > 3)
{
    normalspr = spr_peppermanmid
    hurtspr = spr_peppermanmid_hurt
    chargespr = spr_peppermanmid_charge
    stunspr = spr_peppermanmid_stun
}
else if (hp <= 3)
{
    normalspr = spr_peppermanlow
    hurtspr = spr_peppermanlow_hurt
    chargespr = spr_peppermanlow_charge
    stunspr = spr_peppermanlow_stun
}
hitlag--
if hitlag > 0
{
	hsp = 0
	vsp = 0
}
else if hitlag == 0
{
	hsp = hl_hsp
	vsp = hl_vsp
}

scr_collide()

if scr_solid(x, y)
{
	if x > room_width / 2
		while scr_solid(x, y)
			x--;
	else
		while scr_solid(x, y)
			x++;
}