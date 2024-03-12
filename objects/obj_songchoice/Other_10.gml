gamearray = ["Pizza Tower", "PT ONLINE", "PIZZA CASTLE", "Sugary Spire", "PTC"];

switch sel[0]
{
	case 0: // PIZZA TOWER
		selarray = [
			[mu_title, "Pizza Deluxe!", "POST ELVIS"],
			[mu_prelogin, "Move it, Boy " + lang_str("msg.songchoice.intro"), "Mr. Sauceman"],
			[mu_characterselect, "Move it, Boy", "Mr. Sauceman"],
			[mu_moveitboy, "Move it, Boy " + lang_str("msg.songchoice.full"), "Mr. Sauceman"],
			[mu_hub, "Mondays", "Mr. Sauceman"],
			[mu_pizzatime, "It's Pizza Time!", "Mr. Sauceman", 5],
			[mu_chase, "The Death That\nI Deservioli", "Mr. Sauceman", 5],
			[mu_noiseescape, "Distasteful Anchovi", "Frostix", 5],
			[mu_noiseescape_OLD, "Pesto Anchovi", "Frostix", 5],
			[mu_miniboss, "Pimpin' Hot Stuff", "Mr. Sauceman", 5],
			[mu_timesup, "Time's up!", "Mr. Sauceman"],
			[mu_tutorial, "Funiculi Funicula", "Dim Widdy"],
			[mu_entrance, "Unearthly Blues", "Mr. Sauceman"],
			[mu_noiseentrance, "The Noise's Jam-Packed\nRadical Anthem", "Mr. Sauceman"],
			[mu_medievalentrance, "Hot Spaghetti", "Mr. Sauceman"],
			[mu_medievalremix, "Spaghetti", "Frostix"],
			[mu_medieval, "Cold Spaghetti", "Mr. Sauceman"],
			[mu_ruin, "Theatrical Shenanigans", "Mr. Sauceman"],
			[mu_ruinremix, "Put on a show!!", "Frostix"],
			[mu_dungeon, "Dungeon Freakshow", "Frostix"],
			[mu_dungeondepth, "Meatophobia", "Mr. Sauceman"],
			[mu_desert, "Oregano Mirage", "Frostix"],
			[mu_ufo, "Oregano UFO", "Frostix"],
			[mu_graveyard, "Tombstone Arizona", "Frostix"],
			[mu_farm, "Mort's Farm", "Frostix"],
			[mu_saloon, "Yeehaw DeliveryBoy", "Frostix"],
			[mu_space, "Extraterrestrial Wahwahs", "Mr. Sauceman"],
			[mu_beach, "Tropical Crust", "Mr. Sauceman"],
			[mu_forest, "mmm yess put the tree\non my pizza", "Frostix"],
			[mu_gnomeforest, "Wudpecker", "Frostix"],
			[mu_gustavo, "gustavo", "Frostix"],
			[mu_kungfu, "Way Of The Italian", "Mr. Sauceman"],
			[mu_minigolf, "Good Eatin'", "Frostix"],
			[mu_sewer, "Tubular Trash Zone", "Mr. Sauceman"],
			[mu_sewer2, "Bite The Crust", "Mr. Sauceman"],
			[mu_warintro, "Thousand March " + lang_str("msg.songchoice.intro"), "Mr. Sauceman"],
			[mu_war, "Thousand March", "Mr. Sauceman", 5],
			[mu_warfull, "Thousand March " + lang_str("msg.songchoice.full"), "Mr. Sauceman", 5],
			[mu_industrial, "Pizza Engineer", "Mr. Sauceman"],
			[mu_factory, "Peppino's Sauce Machine", "Mr. Sauceman"],
			[mu_mansion, "Ground Bound", "Mr. Sauceman"],
			
			[mu_freezer, "Don't Preheat Your Oven", "Frostix"],
			[mu_freezer2, "Celsius Troubles", "Frostix"],
			[mu_kidsparty, "What's on the Kid's Menu", "Frostix"],
			[mu_dragonlair, "Tarragon Pizza", "Frostix"],
			[mu_chateau, "There's A Bone\nIn My Spaghetti!", "Mr. Sauceman"],
			[mu_strongcold, "Teeth Dust In\nThe Strongcold", "Frostix"],
			[mu_snickchallenge, "SNICK IS COMING", "Frostix"],
			[mu_snickchallengeend, "Leaning Nightmare", "Frostix"],
			[mu_medievalsecret, "hmmm you found a secret", "Frostix"],
			[mu_ruinsecret, "A Secret Under The Debris", "Frostix"],
			[mu_dungeonsecret, "A Hidden Pepperoni\nin the Cage", "Frostix"],
			[mu_desertsecret, "A Grain of Bread in\na Grain of Sand", "Frostix"],
			[mu_graveyardsecret, "An Undead Secret", "Frostix"],
			[mu_farmsecret, "A Secret in the Chicken", "Frostix"],
			[mu_saloonsecret, "A Secret in my Boot", "Frostix"],
			[mu_pausesecret, "da secret in da\nspace level", "Frostix"],
			[mu_forestsecret, "Everybody wanna\nbe a secret", "Frostix"],
			[mu_rankp, "Victorious Degenerate\n(P " + lang_str("msg.songchoice.rank") + ")", "Mr. Sauceman"],
			[mu_ranks, "Victorious Degenerate\n(S " + lang_str("msg.songchoice.rank") + ")", "Mr. Sauceman"],
			[mu_ranka, "Victorious Degenerate\n(A " + lang_str("msg.songchoice.rank") + ")", "Mr. Sauceman"],
			[mu_rankc, "Victorious Degenerate\n(B and C " 
			+ lang_str("msg.songchoice.rank") + ")", "Mr. Sauceman"],
			[mu_rankd, "Victorious Degenerate\n(D " + lang_str("msg.songchoice.rank") + ")", "Mr. Sauceman"],
			[mu_editor, "Choosing The Toppings", "Mr. Sauceman"],
			[mu_finalescape, "Bye Bye There!", "Mr. Sauceman", 6],
			[mu_null, "Bumbling in the dark " + lang_str("msg.songchoice.old"), "Mr. Sauceman"],
			[mu_nullfinal, "Bumbling in the dark", "Mr. Sauceman"],
			[mu_pause, "Leaning Dream", "Frostix"],
			[mu_spaceB, "Freeze-Dried Pepperonis", "Frostix"],
			[mu_space_snick, "Hallelujah Mama-mia", "Frostix"],
			[mu_fakepeppart1, "Ain't Got No Time\nTo Dance", "Mr. Sauceman"],
			[mu_fakepeppart2, "NOTIME2BOOGIEWOOGIE", "Frostix"],
			
			[mu_secretsaroundtheworld, "Secret Lockin'", "Frostix"],
			[mu_finaltherunner, "The Runner", "POST ELVIS"],
			[mu_bonerattler, "The Bone Rattler", "Mr. Sauceman"],
			[mu_space_spooky, "Spacey Pumpkins", "Mr. Sauceman"],
		]
		break;
	
	case 1:
		selarray = [
			[mu_credits, "Credits", "loypoll"],
			[mu_snickescape, "06 Minutes Til' Boom", "[c]ness"],
			[mu_collapse, "Collapse!", "Frostix"],
			[mu_snickentrance, "Freefallin'", "Frostix"],
			[mu_hub2, "Quintessence", "Frostix"],
			[mu_tunnel, "Tunnely Shimbers", "Mr. Sauceman"],
			[mu_factory_PP, "Peppino's Door Problem", "Mr. Sauceman"],
			[mu_chateau_PP, "Megalono", "Mr. Sauceman?"],
			[mu_space_PP, "Sans Dream", "Frostix?"],
			[mu_pizzatime_PP, "It's Piss Time!", "Mr. Sauceman " + lang_str("msg.songchoice.og") 
			+ ",\nThe Living Tombstone, loypoll " + lang_str("msg.songchoice.mashup"), 5],
			[mu_pizzatime_PP_streamer, "It's Piss Time!\n" + lang_str("msg.songchoice.inst"), 
			"Mr. Sauceman " + lang_str("msg.songchoice.og") + ",\nThe Living Tombstone, loypoll " 
			+ lang_str("msg.songchoice.mashup"), 5],
			[mu_chase_PP, "The Memes That I\nDeservioli", "Meh."],
			[mu_snickchallenge_PP, "Dick Challenge", "loypoll"],
			[mu_hube, "Saturdays", "loypoll"],
			[mu_hubarcade, "ARCADE", "loypoll"],
			[mu_hubrush, "A Monday to be Hated", "loypoll"],
			[mu_mall, "Mall", "loypoll"],
			[mu_fryboys, "That Other Robotnik\nRemix BGM", "Nutikka"],
			[mu_ancient, "Garlic Noodles", "Mr. Sauceman"],
			[music_onepizzaatatime, "Family Guy Cool Whip", "Remix Maniacs"],
			[mu_mfm, "Mama-Fucking-Mia", "Fallatious, Matthew Wilder, Redacted"],
			[mu_susgolf, "Good Brappin'", "loypoll"],
			[mu_mariologgedin, "Mario Has Logged In", "loypoll"],
			[mu_arenasong_OLD, "Battle Sewers", "loypoll"],
			[mu_christmas, "Grinch's Ultimatum", "PilotRedSun"],
			[mu_sanctum, "Cheesy Shenanigans", "RodMod"],
			[mu_phantom, "The Phantom Tower", "Mr. Sauceman"],
			[mu_apartment, "Spooky Apartment", "Frostix"],
			[mu_dungeon_re, "Bloodbath Dungeon", "Marcus Does Miscellaneous"],
			[mu_snickrematch, "Snick's Rematch", "Marcus Does Miscellaneous"],
			[mu_snickrematchend, "Peppino's\nLeaning Nightmare", "Marcus Does Miscellaneous"],
			[mu_dungeondepth_re, "Rational Fear of Meat", "APY19"],
			[mu_arcade1, "Insert Coin", "loypoll"],
			
			[mu_antonlevel, "Dynamite Man", "Tony Grayson"],
			[mu_antonsecret, "Red House", "Tony Grayson"],
			[mu_antonpunchball, "Punch Bowl", "Tony Grayson"],
			[(FINAL_GAMEPLAY) ? mu_antonescape_NEW : mu_antonescape, 
			"Outta My Way!\n...It's Happy Hour!","Tony Grayson", 5],
			[mu_antonsage, "Sage Advice", "Tony Grayson"],
			
			[mu_medieval_race, "Cold Spaghetti\n" + lang_str("msg.songchoice.race"), "Mr. Sauceman " 
			+ lang_str("msg.songchoice.og") + ", loypoll"],
			[mu_ruin_race, "Theatrical Shenanigans\n" + lang_str("msg.songchoice.race"), "Mr. Sauceman " 
			+ lang_str("msg.songchoice.og") + ", loypoll"],
			[mu_dungeon_race, "Dungeon Freakshow\n" + lang_str("msg.songchoice.race"), "Frostix " 
			+ lang_str("msg.songchoice.og") + ", loypoll"],
			
			[mu_entrancesecret, "A Secret in The Tower", "loypoll"],
			[mu_entrancesecret_SP, "A Secret Waffle\nin The Spire", "RodMod " 
			+ lang_str("msg.songchoice.og") + ", loypoll"],
			[mu_chateausecret, "A Secret Bone\nin my Spaghetti!", "loypoll"],
			[mu_sewersecret, "A Manhole in\nThe Sewers", "loypoll"],
			[mu_factorysecret, "A Loose Screw in\nThe Machinery", "loypoll"],
			[mu_kungfusecret, "shh, e un segreto", "loypoll"],
			[mu_strongcoldsecret, "Teeth Dust in\nThe Secret", "loypoll"],
			[mu_freezersecret, "A Leftover in\nThe Freezer", "loypoll"],
			[mu_sanctumsecret, "A Secret Under The\nFlooded Ruins", "loypoll"],
			[mu_mansionsecret, "you found a secret\nin the mansion", "loypoll"],
			[mu_beachsecret, "A Secret Buried\nin The Sand", "loypoll"],
			[mu_entrancesecretPP, "A Secret in The\nColor of Your Soul", "loypoll"],
			[mu_pausesecret, "A Secret Among\nThe Stars", "loypoll"],
			[mu_medievalsecret_re, "MEDIEVALSECRET", "loypoll"],
			[mu_ruinsecret_re, "RUINSECRET", "loypoll"],
			[mu_dungeonsecret_re, "DUNGEONSECRET", "loypoll"],
			[mu_entrancesecret_SP, "there's a secret\ninside my tower?", "loypoll"],
			[mu_entrancesecretPP_SP, "a secret in the\ncolor of your soul.", "loypoll"],
		]
		break;
	
	case 2:
		selarray = [
			[mu_title_pc, "Pizza Deluxe!", "loypoll"],
			[mu_prelogin_pc, "Move it, Boy " + lang_str("msg.songchoice.intro"), "loypoll"],
			[mu_characterselect_pc, "Shoppin'", "loypoll"],
			[mu_hub_pc, "Mondays", "loypoll"],
			[mu_pizzatime_pc, "It's Pizza Time!", "loypoll", 5],
			[mu_chase_pc, "The Death That\nI Deservioli", "loypoll", 5],
			[mu_noiseescape_pc, "Distasteful Anchovi", "loypoll", 5],
			[mu_noiseescape_OLD_pc, "Pesto Anchovi", "loypoll", 5],
			[mu_miniboss_pc, "Pimpin' Hot Stuff", "loypoll", 5],
			[mu_tutorial_pc, "Funiculario", "loypoll"],
			[mu_entrance_pc, "Unearthly Blues", "loypoll"],
			[mu_noiseentrance_pc, "The Noise's Jam-Packed\nRadical Anthem", "loypoll"],
			[mu_medievalentrance_pc, "Hot Spaghetti", "loypoll"],
			[mu_medievalremix_pc, "Spaghetti", "loypoll"],
			[mu_medieval_pc, "Cold Spaghetti", "loypoll"],
			[mu_ruin_pc, "Theatrical Shenanigans", "loypoll"],
			[mu_ruinremix_pc, "Theatrical Mischief", "loypoll"],
			[mu_dungeon_pc, "Dungeon Freakshow", "loypoll"],
			[mu_dungeondepth_pc, "Meatophobia", "loypoll"],
			[mu_desert_pc, "Oregano Mirage", "loypoll"],
			[mu_ufo_pc, "Oregano UFO", "loypoll"],
			[mu_graveyard_pc, "Tombstone Arizona", "loypoll"],
			[mu_farm_pc, "Mort's Farm", "loypoll"],
			[mu_saloon_pc, "Yeehaw DeliveryBoy", "loypoll"],
			[mu_space_pc, "Extraterrestrial Wahwahs", "loypoll"],
			[mu_beach_pc, "Tropical Crust", "loypoll"],
			[mu_forest_pc, "mmm yess put the tree\non my pizza", "loypoll"],
			[mu_gnomeforest_pc, "Wudpecker", "loypoll"],
			[mu_gustavo_pc, "gustavo", "loypoll"],
			[mu_kungfu_pc, "Way Of The Italian", "loypoll"],
			[mu_minigolf_pc, "Good Eatin'", "loypoll"],
			[mu_sewer_pc, "Tubular Trash Zone", "loypoll"],
			[mu_sewer2_pc, "Bite The Crust", "loypoll"],
			[mu_warintro_pc, "Thousand March " + lang_str("msg.songchoice.intro"), "loypoll"],
			[mu_war_pc, "Thousand March", "loypoll", 5],
			[mu_warfull_pc, "Thousand March " + lang_str("msg.songchoice.full"), "loypoll", 5],
			[mu_industrial_pc, "Pizza Engineer", "loypoll"],
			[mu_factory_pc, "Peppino's Sauce Machine", "loypoll"],
			[mu_mansion_pc, "Ground Bound", "loypoll"],
			[mu_freezer_pc, "dont preheat your oven", "loypoll"],
			[mu_freezer2_pc, "Celsius Troubles", "loypoll"],
			//[mu_kidsparty, "What's on the Kid's Menu", "loypoll"],
			[mu_dragonlair_pc, "Tarragon Pizza", "loypoll"],
			[mu_chateau_pc, "There's A Bone\nIn My Spaghetti!", "loypoll"],
			[mu_strongcold_pc, "Teeth Dust In\nThe Strongcold", "loypoll"],
			[mu_snickchallenge_pc, "SNICK IS COMING", "loypoll"],
			[mu_snickchallengeend_pc, "Leaning Nightmare", "loypoll"],
			[mu_medievalsecret_pc, "hmmm you found a secret", "loypoll"],
			[mu_ruinsecret_pc, "A Secret Under The Debris", "loypoll"],
			[mu_dungeonsecret_pc, "A Hidden Pepperoni\nin the Cage", "loypoll"],
			[mu_desertsecret_pc, "A Grain of Bread in\na Grain of Sand", "loypoll"],
			[mu_graveyardsecret_pc, "An Undead Secret", "loypoll"],
			[mu_farmsecret_pc, "A Secret in the Chicken", "loypoll"],
			[mu_saloonsecret_pc, "A Secret in my Boot", "loypoll"],
			[mu_pausesecret_pc, "da secret in da\nspace level", "loypoll"],
			[mu_forestsecret_pc, "A Secret in the Trees", "loypoll"],
			//[mu_editor, "Choosing The Toppings", "loypoll"],
			[mu_finalescape_pc, "Bye Bye There!", "loypoll", 6],
			[mu_null_pc, "Bumbling in the dark", "loypoll"],
			
			[mu_snickescape_pc, "06 Minutes Til' Boom", "loypoll"],
			//[mu_snickentrance, "Freefallin'", "loypoll"],
			//[mu_hub2, "Quintessence", "loypoll"],
			[mu_tunnel_pc, "Tunnely Shimbers", "loypoll"],
			[mu_pizzatime_PP_pc, "It's Piss Time!", "loypoll", 5],
			[mu_hube_pc, "Saturdays", "loypoll"],
			[mu_hubarcade_pc, "ARCADE", "loypoll"],
			[mu_hubrush_pc, "A Monday to be Hated", "loypoll"],
			[mu_fryboys_pc, "That Other Robotnik\nRemix BGM", "loypoll"],
			[mu_ancient_pc, "Garlic Noodles", "GraymonDgt (VGmusic)"],
			[mu_christmas_pc, "Grinch's Ultimatum", "loypoll"],
			[mu_sanctum_pc, "Cheesy Shenanigans", "loypoll"],
			[mu_phantom_pc, "The Phantom Tower", "loypoll"],
			[mu_apartment_pc, "Spooky Apartment", "loypoll"],
			[mu_dungeon_re_pc, "Bloodbath Dungeon", "loypoll"],
			[mu_snickrematch_pc, "Snick's Rematch", "loypoll"],
			[mu_snickrematchend_pc, "Peppino's\nLeaning Nightmare", "loypoll"],
			
			[mu_antonlevel_pc, "Dynamite Man", "loypoll"],
			[mu_antonsecret_pc, "Bonus Blitz", "loypoll"],
			[mu_antonpunchball_pc, "Punch Bowl", "loypoll"],
			[mu_antonescape_pc, "VS! Sewer Slam","loypoll", 5],
			
			[mu_entrancesecret_pc, "A Secret in The Tower", "loypoll"],
			[mu_entrancesecretSP_pc, "A Secret Waffle\nin The Spire", "loypoll"],
			[mu_chateausecret_pc, "A Secret Bone\nin my Spaghetti!", "loypoll"],
			[mu_sewersecret_pc, "A Manhole in\nThe Sewers", "loypoll"],
			[mu_factorysecret_pc, "A Loose Screw in\nThe Machinery", "loypoll"],
			[mu_kungfusecret_pc, "shh, e un segreto", "loypoll"],
			[mu_strongcoldsecret_pc, "Teeth Dust in\nThe Secret", "loypoll"],
			[mu_freezersecret_pc, "A Leftover in\nThe Freezer", "loypoll"],
			[mu_sanctumsecret_pc, "A Secret Under The\nFlooded Ruins", "loypoll"],
			[mu_mansionsecret_pc, "you found a secret\nin the mansion", "loypoll"],
			[mu_beachsecret_pc, "A Secret Buried\nin The Sand", "loypoll"],
			[mu_entrancesecretPP_pc, "A Secret in The\nColor of Your Soul", "loypoll"],
			[mu_spacesecret_pc, "A Secret Among\nThe Stars", "loypoll"],
			[mu_medievalsecret_re_pc, "MEDIEVALSECRET", "loypoll"],
			[mu_ruinsecret_re_pc, "RUINSECRET", "loypoll"],
			[mu_dungeonsecret_re_pc, "DUNGEONSECRET", "loypoll"],
			[mu_entrancesecret_ss_pc, "there's a secret\ninside my tower?", "loypoll"],
			
			
		]
		array_push(selarray, 
			[mu_pizzyescape_pc, "Glucose Getaway", "loypoll", 5],
			[mu_pizzyescape_OLD_pc, "Glucose Getaway\n" + lang_str("msg.songchoice.old"), "loypoll", 5],
			//[mu_sugaryhub_pc, "Welcome Back!", "loypoll"],
			[mu_tutorial_ss_pc, "Ragtime Ice Cream Gal", "loypoll"],
			[mu_waffle_pc, "Down - To - Noise", "loypoll"],
			[mu_cotton_pc, "Steamy Cotton Candy", "loypoll"],
			[mu_cotton2_pc, "Around The Gateau's Gears", "loypoll"],
			[mu_swamp_pc, "Lost Chocolate", "loypoll"],
			[mu_mines_pc, "Mineshaft Depths", "loypoll"],
			[mu_mines2_pc, "Cobalt Catastrophe", "loypoll"],
			[mu_cottonsecret_pc, "lookie! you've found\na steamy surprise.", "loypoll"],
			[mu_wafflesecret_pc, "there's a secret\ninside my breakfast?", "loypoll"],
			[mu_swampsecret_pc, "man's lost secret.", "loypoll"],
			[mu_minessecret_pc, "a jawbreaking secret.", "loypoll"],
		);
		break;
	
	case 3:
		selarray = [
			[mu_pizzyescape, "Glucose Getaway", "RodMod", 5],
			[mu_pizzyescape_OLD, "Glucose Getaway\n" + lang_str("msg.songchoice.old"), "RodMod", 5],
			[mu_pizzyescapelap2, "Sweet Release of Death", "RodMod", 5],
			[mu_sucrose, "Sugarcube Hailstorm", "Paperkitty", 5],
			[mu_bluelicorice, "Blue Licorice", "Paperkitty", 5],
			[mu_sugaryhub, "Welcome Back!", "101Undertale"],
			[mu_tutorial_ss, "Ragtime Ice Cream Gal", "Jessie Productions"],
			[mu_waffle, "Down - To - Noise", "RodMod"],
			[mu_gummyharry, "Pagotophobia", "RodMod"],
			[mu_cotton, "Steamy Cotton Candy", "RodMod"],
			[mu_cotton2, "Around The Gateau's Gears", "RodMod"],
			[mu_swamp, "Lost Chocolate", "Jessie Productions, RodMod"],
			[mu_mines, "Mineshaft Depths", "RodMod"],
			[mu_mines2, "Cobalt Catastrophe", "RodMod"],
			[mu_cottonsecret, "lookie! you've found\na steamy surprise.", "RodMod"],
			[mu_wafflesecret, "there's a secret\ninside my breakfast?", "RodMod"],
			[mu_swampsecret, "man's lost secret.", "RodMod"],
			[mu_minessecret, "a jawbreaking secret.", "RodMod"],
			[mu_medievalsecret_SP, "hmmm you found a\nsugary secret.", "RodMod"],
			[mu_ranks_ss, "Scrumptious Winner\n(S " + lang_str("msg.songchoice.rank") + ")", "101Undertale"],
			[mu_ranka_ss, "Scrumptious Winner\n(A " + lang_str("msg.songchoice.rank") + ")", "101Undertale"],
			[mu_rankb_ss, "Scrumptious Winner\n(B " + lang_str("msg.songchoice.rank") + ")", "101Undertale"],
			[mu_rankc_ss, "Scrumptious Winner\n(C " + lang_str("msg.songchoice.rank") + ")", "101Undertale"],
			[mu_rankd_ss, "Scrumptious Winner\n(D " + lang_str("msg.songchoice.rank") + ")", "101Undertale"]

		]
		break;
	case 4:
		selarray = [
			[mu_laphell, "Fettuccine Frenzy", "icomiki, brujyeah\n" + lang_str("msg.and") 
			+ " raf13lol", 8],
			[mu_lap3, "Pillar John's Revenge", "Vozaxhi"],
			[mu_lap4, "Absolute AbsurZiti", "Inceptradom"],
			[mu_lap5, "Pasta La Vista", "Oofator"],
			[mu_pizzyescapelap3, "Harry's Despair-y", "Inceptradom"],
			// [mu_racehub, "idk lol ask ico\n(not finished)", "icomiki"],
			// [mu_raceresultwin, "PROMOTION!", "Either Mr. Sauceman\nor Frostix"],
			[mu_mansionoutside, "Rain Bound", "icomiki\n" + lang_str("msg.and") + " brujyeah"],
			
			[mu_dragonlairsecret, "A Secret in\nthe Lair", "brujyeah"],
			[mu_forestsecretPECKER, "A Secret inside the\nWoodpecker tree", "brujyeah"],
			
			[mu_dogsong, "Dogsong", "Toby Fox"],
			
			[mu_chateausecret_SP, "a secret bone\nin my spaghetti.", "icomiki"],
			[mu_sewersecret_SP, "a manhole in the sewers.", "icomiki"],
			[mu_sewersecret2_SP, "bite the sugary secret.", "brujyeah"],
			[mu_factorysecret_SP, "a loose screw\nin the machinery.", "icomiki"],
			[mu_kungfusecret_SP, "shh, e un\nsegreto zuccherino.", "icomiki"],
			[mu_strongcoldsecret_SP, "teeth dust in\nthe secret.", "icomiki"],
			[mu_ruinsecret_SP, "a secret under\nthe debris.", "icomiki"],
			[mu_dungeonsecret_SP, "a hidden pepperoni\nin the cage.", "icomiki"],
			[mu_desertsecret_SP, "a grain of sugar in\na grain of sand.", "icomiki"],
			[mu_desertsecretUFO_SP, "a grain of sugar in\nthe ufo.", "icomiki"],
			[mu_forestsecret_SP, "everybody wanna be\nsugary.", "icomiki"],
			[mu_forestsecretPECKER_SP, "a secret inside the\nwoodpecker tree.", "brujyeah"],
			[mu_golfsecret_SP, "a secret on the\ngolf course.", "icomiki"],
			[mu_mansionsecret_SP, "you found a secret\nin the mansion.", "brujyeah"],
			
			[mu_laphell_pc, "Fettuccine Frenzy (MIDI)", "icomiki, brujyeah\n" + lang_str("msg.and") 
			+ " raf13lol", 8],
			[mu_dogsong_pc, "Dogsong (MIDI)", "MIDI by Radixan"],
		]
		break;
}
selmin = 0;
selmax = array_length(selarray) - 1;
