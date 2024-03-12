function scr_shootandchainsaw(){
	
	// Breakdance/Shoot
	if key_shoot2
	{
		if !shotgunAnim
		{
			// mortimer
			if global.mort 
			{
				scr_soundeffect(sfx_killingblow);
				scr_soundeffect(sfx_enemyprojectile);
				with instance_create(x + xscale * 10, y, obj_shotgunbullet)
				{
					image_xscale = other.xscale;
					sprite_index = spr_mortprojectile;
				}
					
				sprite_index = spr_pmortthrow
				image_index = 0
				state = states.pistol
				mort = true
					
				with obj_camera
				{
					shake_mag = 3
					shake_mag_acc = 3 / room_speed
				}
			}
		
			// antonball
			else if scr_checkskin(checkskin.p_anton) && !global.breakdance
			{
				if !instance_exists(obj_antonball)
				{
					scr_soundeffect(sfx_enemyprojectile);
					with instance_create(x, y, obj_antonball)
					{
						hsp = 6 * other.xscale;
						if other.key_up
							vsp = -6;
						canhit = false;
						alarm[0] = 15;
					}
				}
				else
					instance_destroy(obj_antonball);
			}
		
			else if (global.breakdance || global.usebullet) 
			&& sprite_index != spr_secondjump1 && character != "V" && character != "S" 
			{
				if global.breakdance && breakdance_buffer <= 0
				{
					scr_soundeffect(sfx_breakdance);
					movespeed = 9;
					state = states.punch;
					sprite_index = spr_breakdancestart;
					with instance_create(x, y, obj_dashcloud2)
						image_xscale = other.xscale;
					breakdance = 35;
					breakdance_buffer = 35;
					image_index = 0;
					instance_create(x, y, obj_swingdinghitbox);
				}
				// bullet
				else if global.bullet > 0 && !global.breakdance
				{
					if !scr_solid_player(x + xscale * 20, y) 
					or place_meeting(x + xscale * 20, y, obj_destructibles)
					{
						global.bullet--;
						sprite_index = spr_pistolshot
						image_index = 0
						state = states.pistol
						shot = true
						
						with obj_camera
						{
							shake_mag = 3;
							shake_mag_acc = 3 / room_speed;
						}
						
						scr_soundeffect(sfx_killingblow);
						if character == "N"
						{
							with instance_create(x, y, obj_playerbomb)
							{
								kick = true
								movespeed = 15
								image_xscale = other.xscale
							}
						}
						else
						{
							with instance_create(x + xscale * 20, y, obj_shotgunbullet)
							{
								pistol = true
								if other.character == "PP"
									sprite_index = spr_pissinobullet
								else
									sprite_index = spr_peppinobullet
								image_xscale = other.xscale
							}
						}
					}
					else
					{
						image_index = 0
						state = states.bump
						hsp = -xscale * 2
						vsp = -4
					}
				}
			}
		}
		else // shotgun
		{
			if shoot_buffer <= 0
			{
				if OLD_GAMEPLAY
				{
					// shoot in old gameplay
					state = states.shotgun
					
					with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
						shotgun = true;
					if character != "N"
					{
						with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
						{
							spdh = 4;
							shotgun = true;
						}
						with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
						{
							spdh = -4;
							shotgun = true;
						}
					}
				}
				else
				{
					// shoot in new gameplay
					shoot_buffer = shoot_max;
					tauntstoredmovespeed = movespeed
					tauntstoredstate = states.shotgun // keep a note for shotgun speed conversing
					if (grounded)
						movespeed = 0;
					state = states.normal
					 with (instance_create((x + (xscale * 38)), (y + 6), obj_shotgunblast))
					 {
					        image_xscale = other.xscale
					 }
				}
			
				// detail
				sprite_index = spr_shotgunshoot;
				image_index = 0;
				scr_soundeffect(sfx_killingblow);
			
				with instance_create(x, y, obj_pistoleffect)
					image_xscale = other.xscale;
			}
		}
	}
	if key_chainsaw2 && global.ammo > 0
	{
		global.ammo -= 1;
		scr_soundeffect_ext(sfx_chainsawrev, false, 1.125)
		state = states.chainsaw
		sprite_index = spr_chainsawstart
		image_index = 0
	}
}

function scr_breakdance_handle()
{
	if sprite_index == spr_breakdancesuper && key_shoot2
		movespeed = 14
			
	if movespeed > 0 && sprite_index == spr_breakdance && grounded
		movespeed -= 0.5
			
	if movespeed > 0 && sprite_index == spr_breakdancesuper
		movespeed -= 0.25
			
	if scr_solidwall(x + xscale, y) && !place_meeting(x + xscale, y, obj_destructibles) 
	&& (sprite_index == spr_breakdancestart or sprite_index == spr_breakdance)
		movespeed = 0
			
	if animEnd && sprite_index == spr_breakdancestart
		sprite_index = spr_breakdance
			
	if key_shoot2 && move == xscale && (sprite_index == spr_breakdance 
	|| sprite_index == spr_breakdancestart)
	{
		image_index = 0
		sprite_index = spr_buttattackstart
		movespeed = 16
		vsp = -6
	
		if !instance_exists(crazyruneffectid)
		{
			with instance_create(x, y, obj_crazyrunothereffect)
			{
				playerid = other.object_index
				other.crazyruneffectid = id
			}
		}
	}
				
	if (sprite_index == spr_buttattack || sprite_index == spr_buttattackstart) 
	&& (key_attack2 || key_down2)
	{
		if !(character == "N" && noisetype == 0)
		{
			state = states.mach3
			movespeed = 18
			sprite_index = spr_mach4
			image_index = 0
		}
		else
		{
			state = states.mach3
			movespeed = 18
			sprite_index = spr_playerN_jetpackboost
		}
	}
	
	if grounded && sprite_index == spr_buttattack
		sprite_index = spr_buttattackend
		
	if animEnd && sprite_index == spr_buttattackstart
		sprite_index = spr_buttattack
		
	if sprite_index == spr_buttattackend
		movespeed -= 0.25
		
	if key_shoot2 && sprite_index == spr_breakdance && move == 0
	{
		sprite_index = spr_breakdancesuper
		movespeed = 12
	}
		
	if breakdance > 0
		breakdance--
		
	landAnim = false
	if movespeed <= 0 
	&& (sprite_index == spr_breakdancesuper or sprite_index == spr_buttattackend)
		state = states.normal
	if breakdance <= 0 && sprite_index == spr_breakdance
		state = states.normal
	if place_meeting(x + xscale, y, obj_solid) && sprite_index == spr_breakdancesuper
		xscale *= -1
		
	if sprite_index == spr_breakdancesuper
		image_speed = movespeed / 24
	else
		image_speed = 0.4
		
	if sprite_index == spr_buttattack
	or sprite_index == spr_buttattackstart
	or sprite_index == spr_buttattackend
	{
		if scr_solid(x + xscale, y)
		&& !place_meeting(x + sign(hsp), y, obj_slope)
		&& !place_meeting(x + xscale, y, obj_destructibles)
		{
			scr_soundeffect(sfx_bumpwall)
			grav = basegrav
			movespeed = 0
			state = states.bump
			hsp = 2.5 * -xscale
			vsp = -3
			mach2 = 0
			image_index = 0
			machslideAnim = true
			machhitAnim = false
			instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
		}
	}
}