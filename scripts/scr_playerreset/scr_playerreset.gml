function scr_playerreset()
{
	try
	{
		global.srank = 0
		global.arank = 0
		global.brank = 0
		global.crank = 0
	
		instance_destroy(obj_fakepeppino);
		if ds_exists(global.baddietomb, ds_type_list)
			ds_list_clear(global.baddietomb);
	
		with obj_followcharacter
			if object_index != obj_petfollow instance_destroy(id, false);
		
		ds_list_clear(global.followerlist);
		with obj_petfollow
		{
			pos = 0;
			ds_list_add(global.followerlist, id);
		}
	
		instance_destroy(obj_combotitle)
	    instance_destroy(obj_comboend)
		instance_destroy(obj_wartimer)
		instance_destroy(obj_lap2visual)
	
		// modifiers
		global.failedmod = false;
		global.toppings = 0;
		global.racing = false
		global.boxhp = 20
	
		// other shit
		global.combodropped = false
		global.chancetogetonthatprank = true
		global.lap = 0
		global.lap2 = false
		global.comboscore = 0
		global.fill = 500
	    global.chunk = 5
		global.spaceblockswitch = true
		global.pizzacoin = global.pizzacoinstart
		global.bullet = clamp(3 * (global.usebullet), 0, 3);
		global.ammo = clamp(3 * (global.useammo), 0, 3);
		global.mort = false;
		global.stylethreshold = 0;
		global.heattime = 0;
		global.style = 0;
		global.gerome = false;
		global.stylelock = false;
		global.baddiespeed = 1;
		global.baddiepowerup = false;
		global.hasfarmer = [0, 0, 0]
	    global.checkpoint_room = -4
	    global.checkpoint_door = "A"
		global.noisejetpack = false
	    global.hp = 0
		global.kungfu = false
	    global.graffiticount = 0
		global.horse = false
	
		global.showgnomelist = false;
		global.failcutscene = false;
		global.pizzadelivery = false;
	
		global.raceid = 0;
		global.golfhit = 0;
		global.funmode = false;
	
		global.minutes = 2;
		global.seconds = 59;
	
		global.timeractive = false
		global.wave = 0
		global.maxwave = 0
		global.secretfound = 0
		global.hurtcounter = 0
		global.snickchallenge = false
		global.snickrematch = false
		global.giantkey = false
	
		with obj_timeattack
		{
			newalarm = -1
			stop = false
		}
	
		with obj_roomname
		{
			yi = -50;
			showtext = false;
			if (seenlist != -1)
				ds_list_clear(seenlist);
		}
		
		global.timedgate = false
		global.taseconds = 0
		global.taminutes = 0
		global.tadecimal = 0
	
		global.miniboss = false
	
		instance_destroy(obj_endlevelfade, false)
		instance_destroy(obj_pizzaball_slices, false);
		instance_destroy(obj_pizzaface, false)
		instance_destroy(obj_ghostjohn, false)
		instance_destroy(obj_pizzashield, false)
		instance_destroy(obj_toppinwarrior, false)
		instance_destroy(obj_gnome_checklist, false);
	
		instance_destroy(obj_snickexe, false)
		instance_destroy(obj_snickexf, false)
		instance_destroy(obj_snickexg, false)
		instance_destroy(obj_snickexh, false)
	
		with obj_tv
		{
			message = "";
			showtext = false;
			if OLD_GAMEPLAY
				tvsprite = spr_tvdefault;
		
			shownranks = false
			shownranka = false
			shownrankb = false
			shownrankc = false
		
			ds_list_clear(tvprompts_list);
			state = states.normal
			promptxstart = 641
			promptx = promptxstart
			prompt = ""
			promptspd = 1
			prompt_buffer = 0
			prompt_max = 150
			special_prompts = noone
			hud_posx = 0
			hud_posY = 0
			bubbleindex = 0
			bubblespr = noone
			idleanim = 180
			collect_shake = 0
		
			static_timer = 0
			happy_timer = 0
			panic_timer = 0
			panic_anim = 0
		}
	
		with obj_music
			fadeoff = 0
	
		if instance_exists(obj_timesup)
			instance_destroy(obj_timesup, false)
		global.seconds = 59
		global.minutes = 1

		with obj_camera
		{
			chargecamera = 0
			crouchcamera = 0
			alarm[4] = -1
		}
	
		if ds_exists(global.saveroom, ds_type_list)
			ds_list_clear(global.saveroom)
		if ds_exists(global.escaperoom, ds_type_list)
			ds_list_clear(global.escaperoom)
		if ds_exists(global.baddieroom, ds_type_list)
			ds_list_clear(global.baddieroom)
	
		with obj_player
		{
			state = states.comingoutdoor;
			image_index = 0;
			visible = true;
			image_blend = c_white;
			canfall = true;
		
			supercharge = 0
			supercharged = false
			pizzapepper = 0
			pizzashield = false
			c = 0
			heavy = false
			image_index = 0
			sprite_index = spr_walkfront
			alarm[0] = -1
			alarm[1] = -1
			alarm[3] = -1
			alarm[4] = -1
			alarm[5] = -1
			alarm[6] = -1
			alarm[7] = -1
			alarm[8] = -1
			alarm[9] = -1
			alarm[10] = -1
		
			grav = basegrav;
		
			gravmult = 1;
			hsp = 0;
			vsp = 0;
			global.playerhealth = 100
			xscale = 1;
			yscale = 1;



			pogospeed = 6
			pogochargeactive = false
			pogocharge = 100

			x = backtohubstartx
			y = backtohubstarty

			backupweapon = false
			shotgunAnim = false

			box = false
			steppy = false

			movespeedmax = 5
			jumpstop = false
			start_running = true

			obj_camera.ded = false

			visible = true
			global.panic = false
			turn = false
			jumpAnim = true
			dashAnim = true
			landAnim = false
			machslideAnim = false
			moveAnim = true
			stopAnim = true
			crouchslideAnim = true
			crouchAnim = true
			machhitAnim = false
			stompAnim = false

			inv_frames = false

			turning = false

			hurtbounce = 0
			hurted = false
			autodash = false
			mach2 = 0

			parry = false
			parry_inst = noone
			taunt_to_parry_max = 10
			parry_count = 0
			parry_max = 8

			input_buffer_jump = 8
			input_buffer_secondjump = 8
			input_buffer_highjump = 8

			flash = false
		
			global.key_inv = 0
			global.keyget = false
		
			global.shroomfollow = false
			global.cheesefollow = false
			global.tomatofollow = false
			global.sausagefollow = false
			global.pineapplefollow = false
			global.collect = 0
			global.treasure = false
			global.combo = 0
			global.combotime = 0
			global.toppintotal = 1
		
			in_water = false
			key_particles = false
			barrel = false
			bounce = false
			a = 0
			idle = 0
			attacking = false
			slamming = false
			superslam = 0

			machpunchAnim = false
			punch = false
			machfreefall = 0
			shoot = true
			instakillmove = false
			windingAnim = 0
			facestompAnim = false
			ladderbuffer = 0
			chainsaw = 50
			toomuchalarm1 = 0
			toomuchalarm2 = 0
			dashdust = false
			throwforce = 0
			hurtsound = false
		
			idleanim = 0
			momentum = false
			cutscene = false
			grabbing = false
			dir = xscale
		
			goingdownslope = false
			goingupslope = false
			fallinganimation = 0
			bombpeptimer = 100
			slapbuffer = 0
			slaphand = 1
		
			suplexmove = false
			suplexhavetomash = 0
		
			timeuntilhpback = 300
		
			anger = 0
			angry = false
		
			springsjump = false;
			keydoor = false;
			sprgot = -1;
			storedstate = states.normal;
		
			mort = false;
			shot = false;
			endtumble = false
			scale_xs = 1
			scale_ys = 1
		
			konami = "";
		
			if (check_online())
			{
				gms_ini_player_write("saveData", "pizzacoin", scr_getcoin())
			}
		
			with obj_music
				event_perform(ev_other, 4)
		}
	}
	catch(e)
	{
		e =0
	}
}

