function scr_savescore(namestring)
{
	with obj_camera
		alarm[4] = -1
	
	//Level rank saves
	ini_open("saveData" + string(global.saveslot) + ".ini");
	if !(namestring == "golf" && global.funmode)
	{
		// score
		if ini_read_real("Highscore", namestring, 0) < global.collect
			ini_write_real("Highscore", namestring, global.collect);
		
		// collected treasure
		if ini_read_real("Treasure", namestring, 0) == 0
			ini_write_real("Treasure", namestring, global.treasure);
		
		// secret count
		if ini_read_real("Secret", namestring, 0) < global.secretfound
			ini_write_string("Secret", namestring, global.secretfound);
			 
		if ini_read_real("Lap", namestring, 0) < global.lap && !global.classiclap && global.lap > 1
			ini_write_string("Lap", namestring, global.lap);
		if ini_read_real("LapC", namestring, 0) < global.lap && global.classiclap && global.lap > 1
			ini_write_string("LapC", namestring, global.lap);
		
		// toppins
		if ini_read_real("Toppin", namestring + "1", 0) == 0
			ini_write_real("Toppin", namestring + "1", global.shroomfollow);
		if ini_read_real("Toppin", namestring + "2", 0) == 0
			ini_write_real("Toppin", namestring + "2", global.cheesefollow);
		if ini_read_real("Toppin", namestring + "3", 0) == 0
			ini_write_real("Toppin", namestring + "3", global.tomatofollow);
		if ini_read_real("Toppin", namestring + "4", 0) == 0
			ini_write_real("Toppin", namestring + "4", global.sausagefollow);
		if ini_read_real("Toppin", namestring + "5", 0) == 0
			ini_write_real("Toppin", namestring + "5", global.pineapplefollow);
		
		// rank
		var rankstring = ini_read_string("Ranks", namestring, "none")
		
		var previousrankcheck = rankstring != "p";
		
		var ranks_array = ["s", "a", "b", "c", "d", "eggplant"]
		
		if scr_prankvalid() && global.rank == "s"
		{
			ini_write_string("Ranks", namestring, "p")
		}
		else
		{
			for (var i = 0; i < array_length(ranks_array); i++)
			{
				if !previousrankcheck
					break; // no need
				var rankstr = ranks_array[i]
			
				if global.rank == rankstr && previousrankcheck
				{
					ini_write_string("Ranks", namestring, global.rank)
					break; // rn
				}
				previousrankcheck &= (rankstring != rankstr)
			}
		}
		// time attack score
		if global.timeattack
			scr_savetatime(namestring);
		
		// save pizzacoin
		if instance_exists(obj_gms)
			gms_ini_player_write("saveData", "pizzacoin", scr_getcoin());
		else
			ini_write_real("online", "pizzacoin", scr_getcoin());
	}
	ini_close();
}

function scr_savetatime(namestring)
{
	if ini_read_real("TAmin", namestring, -1) == -1 // no record set yet
	or ((ini_read_real("TAmin", namestring, 0) * 60) 
	+ ini_read_real("TAsec", namestring, 0) 
	+ (ini_read_real("TAdec", namestring, 0) / 100) > 
	(global.taminutes * 60) + global.taseconds + (global.tadecimal / 100))
	{
		ini_write_real("TAsec", namestring, global.taseconds);
		ini_write_real("TAmin", namestring, global.taminutes);
		ini_write_real("TAdec", namestring, global.tadecimal);
		
		var char = string(obj_player.character);
		if char == "N" && obj_player.noisetype == 1
			char += "S";
		if REMIX_GAMEPLAY
			char += "-REMIX";
		else if FINAL_GAMEPLAY_ONLY
			char += "-NEW";
				
		ini_write_string("TAchar", namestring, char);
	}
}

function scr_levelname()
{
	// returns level name
	var namestring = global.leveltosave
	
	//if global.snickrematch && !global.snickchallenge
	//	namestring += "_re";
		
	return namestring;
}

function endlevel()
{
	// give pizzacoin if online mode
	if check_online()
	{
		with obj_pizzacoinindicator
			show = 60;
		with obj_global
			alarm[0] = 30;
	}
	
	// stop the music
	if !fmod_is_instance_playing(global.jukebox)
		fmod_stop_instance_immediately(global.music)
	
	// necessary shit idk
	with obj_timeattack
		stop = true
	with obj_player
		targetDoor = "none"
	with obj_camera
		alarm[2] = -1
	
	// calculate ranks
	if global.modifier != -1
		global.rank = "a";
	else
	{
		if global.leveltosave == "golf" && global.funmode
		{
			global.rank = "yousuck";
			unlock_hat(4)
		}
		else if global.srank > 0
		{
			if global.collect >= global.srank
				global.rank = "s"
			else if global.collect > global.arank
				global.rank = "a"
			else if global.collect > global.brank
				global.rank = "b"
			else if global.collect > global.crank
				global.rank = "c"
			else if global.collect < 0
				global.rank = "yousuck";
			else 
				global.rank = "d"
		}
		else if global.collect < 0
			global.rank = "yousuck";
		else
			global.rank = "eggplant";
	}
	
	// absolutely annihilate the snicks
	instance_destroy(obj_snickexe);
	instance_destroy(obj_snickexf);
	instance_destroy(obj_snickexg);
	instance_destroy(obj_snickexh);
	instance_destroy(obj_snickexi);
	
	// save score IF you have no modifier on
	if global.modifier == -1
	{
		if global.leveltosave == "snickrematch" && global.rank == "s"
		{
			if !check_hat(HATS.snickcrown)
			{
				obj_player.hatsprite = spr_hat_snickcrown;
				unlock_hat(HATS.snickcrown);
			}
		}
		scr_savescore(global.leveltosave);
	}
}

function scr_levelnamenice() // shittiest piece of shit
{
	var newName = global.leveltosave
	
	if (newName == "kungfu")
		newName = "Kung-fu"
		
	if (newName == "desert")
		newName = "Oregano Desert"
		
	if (newName == "entrance")
		newName = "John Gutter"
		
	if (newName == "medieval")
		newName = "Pizzascape"
		
	if (newName == "ruin")
		newName = "The Ancient Cheese"
		
	if (newName == "dungeon")
		newName = "Bloodsauce Dungeon"
		
	if (newName == "beach")
		newName = "Pineapple Beach"
		
	if (newName == "war")
		newName = "WAR"
		
	if (newName == "dragonlair")
		newName = "Dragon Lair"
		
	if (newName == "chateau")
		newName = "Pizzascare"
		
	if (newName == "forest")
		newName = "Gnome Forest"
		
	if (newName == "graveyard")
		newName = "the Wasteyard"
		
	if (newName == "ufo")
		newName = "Space Pinball"
		
	if (newName == "space")
		newName = "Space"
		
	if (newName == "farm")
		newName = "Fun Farm"
		
	if (newName == "strongcold")
		newName = "Strongcold"
		
	if (newName == "oldsewer")
		newName = "the Old Sewers"
	
	if (newName == "oldmansion")
		newName = "the Old Mansion"
	
	if (newName == "oldfreezer")
		newName = "the Old Freezer"
	
	if (newName == "oldfactory")
		newName = "the Old Factory"
		
	if (newName == "golf")
		newName = "Old Golf"
	
	if (newName == "ancient")
		newName = "the Ancient Tower"
		
	if (newName == "etb")
		newName = "Early Test Build"

	if (newName == "d2factory")
		newName = "the Demo 2 Factory"
		
	if (newName == "grinch")
		newName = "Grinch"
		
	if (newName == "city")
		newName = "Pizzaland"
		
	if (newName == "cotton")
		newName = "Cottontown"
		
	//	if (newName == "cottonOLD")
	//		newName = "Cottontown (OLD)"
	
	if (newName == "entryway")
		newName = "Entryway"
	
	if (newName == "molasses")
		newName = "Molasses Swamp"
	
	if (newName == "mines")
		newName = "Sugarshack Mines"
		
	if (newName == "snickchallenge")
		newName = "Snick's Challenge"
	
	if (newName == "snickrematch")
		newName = "Snick's Rematch"
	
	if (newName == "saloon")
		newName = "Fast Food Saloon"
	
	if (newName == "secrets")
		newName = "Secrets of the World"
	
	if newName == "exit"
		newName = "Crumbling Tower of Pizza"
	
	if (newName == "medieval_re")
		newName = "Snick's Castle (PLN)"
		
	if (newName == "ruin_re")
		newName = "Ruins of The Temple (PLN)"
		
	if (newName == "dungeon_re")
		newName = "Bloodbath Dungeon (PLN)"
	
	return newName
}