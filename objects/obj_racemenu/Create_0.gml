enum session_types
{
	normal,
	race
}


instance_destroy(obj_fadeout);
fmod_stop_all();
scr_sound(mu_medieval_race);
obj_player.sprite_index = obj_player.spr_idle
obj_player.image_index = 0
with obj_player
	event_perform(ev_step, ev_step_end)

instance_deactivate_all(true);
instance_activate_object(obj_gms);
instance_activate_object(obj_roomname)
instance_activate_object(obj_global)
instance_activate_object(obj_fmod)
instance_activate_object(obj_controller)

application_surface_draw_enable(true)


enum racestates
{
	creating_or_joining,
	created,
	joined,
	create_making,
	joining_setting,
	create_loading,
	joining_loading
}

menu = 0;
maxplayer = 2;
startrace = false;

destroythis = false

idtojoin = 3

levelselect = 0
levelselectname = ["JOHN GUTTER", "PIZZASCAPE", 
"THE ANCIENT CHEESE", "BLOODSAUCE DUNGEON", "OREGANO DESERT", "THE WASTEYARD", "SPACE PINBALL",
"PINEAPPLE BEACH", "GNOME FOREST", "KUNG FU", "PIZZASCARE", "STRONGCOLD", "DRAGON LAIR", "SPACE", 
"SEWERS", "FREEZER", "FACTORY", "GOLF", "MANSION", "EARLY TEST BUILD", "ANCIENT TOWER",
"ENTRYWAY", "COTTONTOWN", "MOLASSES SWAMP"]
levelselectroom = [entrance_1_NEW, medieval_1, ruin_1, dungeon_1,
floor1_room0, graveyard_1_NEW, ufo_1, beach_1, forest_1, kungfu_1, chateau_1, strongcold_10,
dragonlair_1, space_1, oldsewer_0_NEW, oldfreezer_1, oldfactory_0, golf_1, oldmansion_9, etb_1, 
ancient_1, entryway_1, cotton_1, molasses_1]

levelselectlimit = [
5,5,5,6, // entrance, pizzascape, ruin, dungeon
7,7,7,8, // desert, wasteyard, pinball, beach
8,8,5,7, // forest, kung fu, chateau, coldstrong
5,10,5,4, // lair, space, sewers, freezer
4,8,6,4, // factory, golf, mansion, etb
5,5,8,10 // ancient, entryway, cotton, molasses 
]


lastplayer = 0

errormsg = "ERROR MSG HERE"

backdelay = 0.2

function gms_session_change(session_id) {
	with obj_racemenu
		if menu == racestates.create_loading
		{
			gms_p2p_send(p2p.race_invite, gms_p2p_all_in_game,
			levelselectname[levelselect] + ". (ID: " + string(gms_session_current_id()) + ")", gms_self_name())
			menu = racestates.created
		}
		else if menu == racestates.joining_loading
		{
			menu = racestates.joined
			// checks
			var playercount = gms_session_player_count(gms_session_current_id())
			if playercount == 1 // self somehow (invalid)
			{
				errormsg = lang_str("online.race.empty")
				event_user(3)
			}
			else if playercount >= 13
			{
				errormsg = lang_str("online.race.full")
				event_user(3)
			}
		}
}

global.raceleader = ds_list_create()
global.racetime = ds_list_create()
global.racing = 0
global.racelimit = 5
global.createantispam = 0

gms_script_set_session_change(gms_session_change);
