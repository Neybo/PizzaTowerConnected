
if (place_meeting(x, y, obj_player) or place_meeting(x, y, obj_antonball)) 
&& obj_player.state != states.gameover
&& sprite_index == spr_closed
{
	global.heattime = 60;
	global.combotime = 60;
	ds_list_add(global.saveroom, id);
	
	mimic = scr_checkskin(checkskin.n_goise) && irandom_range(0,5) == 1
	
	if content != obj_bigcollect
	{
		if (mimic)
		{
			scr_soundeffect(sfx_mimictoppin)
		}
		else
		{
			scr_soundeffect(sfx_collecttoppin)
		}
	}
	else if content == obj_bigcollect
	{
		scr_soundeffect(sfx_stompenemy)
	}
	
	if content == obj_noisebomb
	{
		with obj_player
		{
			state = states.backbreaker
			sprite_index = spr_bossintro
			image_index = 0
		}
		with instance_create(x, y - 25, content)
			sprite_index = spr_intro
	}
	
	if object_get_parent(content) == obj_pizzakinparent
	{
		with obj_tv
			happy_timer = room_speed * 5;
		
		with instance_create(x, y, obj_smallnumber)
			number = "1000";
		global.collect += 1000;
		
		instance_create(x, y, obj_localtaunteffect);
		with instance_create(x, y - 25, content)
		{
			if sc_check()
				sprite_index = spr_intro_strongcold;
			else
				sprite_index = spr_intro;
			mimic = other.mimic
		}
		
		var toppinname = "Toppin" + (5 - global.toppintotal == 1 ? "" : "s");
		var sugary = check_sugary();
		if sugary
			toppinname = "Confecti";
		
		with obj_tv
		{
			if global.toppintotal < 5
			{
				if sugary
					message = "You're only missing " + string(5 - global.toppintotal) + " confecti!";
				else
					message = "You need " + string(5 - global.toppintotal) + " More " + toppinname + "!";
			}
			else
				message = "You have all " + toppinname + "!";
			showtext = true;
			alarm[2] = 150;
		}
		global.toppintotal += 1;
	
		if content == obj_pizzakinshroom or content == obj_toppinmallow
			global.shroomfollow = true;
		if content == obj_pizzakincheese or content == obj_toppinchoco
			global.cheesefollow = true;
		if content == obj_pizzakintomato or content == obj_toppincrack
			global.tomatofollow = true;
		if content == obj_pizzakinsausage or content == obj_toppinworm
			global.sausagefollow = true;
		if content == obj_pizzakinpineapple or content == obj_toppincandy
			global.pineapplefollow = true;

	}
	
	if object_get_parent(content) == obj_baddie
	{
		scr_soundeffect(sfx_enemyprojectile)
		with instance_create(x, y - 25, content)
		{
			image_xscale = other.image_xscale
			state = states.stun
			stunned = 20
			vsp = -5
		}
		instance_create(x, y - 25, obj_genericpoofeffect);
	}
	
	image_index = 0;
	sprite_index = spr_open
}

if sprite_index == spr_open
{
	if floor(image_index) >= 3 && !createdpizza && content == obj_bigcollect
	{
		createdpizza = true
		depth = 105
		with instance_create(x, y, content)
			owner = other.id;
	}
	
	if floor(image_index) >= image_number - 1
		instance_destroy();
}

image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;
subimg += 0.35
