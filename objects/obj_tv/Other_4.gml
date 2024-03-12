/// @description ranks & level appearance

var roomid = scr_gms_room()

switch roomid
{
	// please redo some of these specially the old level ones
	// will do & plan to
	case entrance_1: global.srank = 20050; break;
 	case medieval_1: global.srank = 10300; break;
	case chateau_1: global.srank = 9300; break;
	case ruin_1: global.srank = 11200; break;
	case ufo_1: global.srank = 10950; break;
	case floor1_room0: global.srank = 13400; break; // desert
	case oldmansion_9: global.srank = 10000; break; // mansion
	case oldfactory_0: global.srank = 6500; break; // factory
	case oldsewer_0: global.srank = 5800; break; // sewer
	case oldfreezer_1: global.srank = 7800; break; // freezer
	case golf_1: global.srank = (FINAL_GAMEPLAY ? 3200 : 4500); break;
	case farm_1: global.srank = 10300; break;
	case saloon_1: global.srank = 15000; break;
	case tower_finalhallway: global.srank = 6000;
	case graveyard_1: global.srank = 11850; break;
	case dungeon_1: global.srank = 10300; break;
	case strongcold_10: global.srank = 9000; break;
	case dragonlair_1: global.srank = 4500; break;
	case forest_1: global.srank = 14000; break;
	case beach_1: global.srank = 14000; break;
	case kungfu_1: global.srank = 15000; break;
	case war_1: global.srank = 20000; break;
	
	case etb_1: global.srank = 10200; break;
	case grinch_1: global.srank = 7000; break;
	case ancient_1: global.srank = 12800; break;
	case d2factory_1: global.srank = 11000; break;
	
	case entryway_1: global.srank = 11600; break;
	case cotton_1: global.srank = 75000; break;
	case molasses_1: global.srank = 35000; break;
	case secret_entrance: global.srank = 5000; break;
}
if global.snickchallenge
	global.srank = (global.snickrematch) ? 7560 : 8000

// calculate lesser ranks
global.arank = global.srank - global.srank / 4;
global.brank = global.srank - global.srank / 4 * 2;
global.crank = global.srank - global.srank / 4 * 3;


ds_list_clear(global.roombgs);
var layers = layer_get_all();
for (var i = 0; i < array_length(layers); i++)
{
	// add to room bgs
	var lbg = layer_background_get_id(layers[i]);
	if lbg != -1
	{
		ds_list_add(global.roombgs, {
			lay : layers[i],
			bg : lbg,
			x : layer_get_x(layers[i]),
			y : layer_get_y(layers[i]),
			hsp : layer_get_hspeed(layers[i]),
			vsp : layer_get_vspeed(layers[i]),
		});
	}
	
	// layer depths
	var layername = layer_get_name(layers[i]);
	if string_startswith(layername, "Tiles_")
	{
		var tilesuffix = string_replace(layername, "Tiles_", "");
		var number = 1
		if string_contains(tilesuffix, "Foreground")
		{
			var asd = string_replace(tilesuffix, "Foreground", "")
			if string_is_number(asd)
				number = real(asd)
			layer_depth(layers[i], 100 - number)
		}
		if string_is_number(tilesuffix)
			layer_depth(layers[i], 101 - real(tilesuffix));
		if string_contains(tilesuffix, "BG")
		{
			var asd = string_replace(tilesuffix, "BG", "")
			if string_is_number(asd)
				number = real(asd)
			layer_depth(layers[i], 201 - number)
		}
	}
	if string_startswith(layername, "Assets_L")
	{
		var tilesuffix = string_replace(layername, "Assets_L", "");
		if string_is_number(tilesuffix)
			layer_depth(layers[i], 102 - real(tilesuffix));
	}
	if layername == "Assets_FG"
		layer_depth(layers[i], 89);
	if string_startswith(layername, "Assets_BG")
		layer_depth(layers[i], 289);
	if layername == "Backgrounds_FG"
		layer_depth(layers[i], -100);
	
	// change snick rematch appearance
	var layers_e = layer_get_all_elements(layers[i]);
	for (var j = 0; j < array_length(layers_e); j++)
	{
		if global.snickrematch
		{
			// backgrounds
			if layer_get_element_type(layers_e[j]) == layerelementtype_background
			{
				var getch = asset_get_index(sprite_get_name(layer_background_get_sprite(layers_e[j])) + "_re");
				if sprite_exists(getch)
					layer_background_sprite(layers_e[j], getch);
			}
			// tiles
			else if layer_get_element_type(layers_e[j]) == layerelementtype_tilemap
			{
				var getch = asset_get_index(tileset_get_name(tilemap_get_tileset(layers_e[j])) + "_re");
				if getch != -1
					tilemap_tileset(layers_e[j], getch);
			}
			// assets
			else if layer_get_element_type(layers_e[j]) == layerelementtype_sprite
			{
				var getch = asset_get_index(sprite_get_name(layer_sprite_get_sprite(layers_e[j])) + "_re");
				if sprite_exists(getch)
					layer_sprite_change(layers_e[j], getch);
			}
		}
		else if global.panic
		{
			if layer_get_element_type(layers_e[j]) == layerelementtype_background
			&& layer_background_get_sprite(layers_e[j]) == bg_farm2
				layer_hspeed(layers[i], -2);
		}
	}
}

if global.hudtype == 0 && (tvsprite == scr_sprite_charsuffix(spr_tv_whitenoise) 
|| tvsprite == scr_sprite_charsuffix(spr_tv_placeholder))
{
	tvsprite = spr_tvdefault
	image_speed = 0.1
	imageindexstore = 0
}

// panic background
if !check_shaders()
	global.panicbg = false;
if (global.panic or global.snickchallenge) && global.panicbg
&& !(instance_exists(obj_secretfound) && FINAL_GAMEPLAY) && room != tower_2
	scr_panicbg_init();

if string_startswith(room_get_name(room), "space_") or string_startswith(room_get_name(room), "cafe_") 
{
	// detects if there's any "Tiles_" layers in the room.
	var hastiles = false;
	for (var i = 0; i < array_length(layers); i++;)
	{
		if string_startswith(layer_get_name(layers[i]), "Tiles_")
		{
			hastiles = true;
			break;
		}
	}
	
	// if there AREN'T any tiles
	if !hastiles
	{
		// make backgrounds not overlap objects
		for (var i = 0; i < array_length(layers); i++;)
		{
			if string_startswith(layer_get_name(layers[i]), "Backgrounds_")
				layer_depth(layers[i], layer_get_depth(layers[i]) + 500);
		}
		
		// and make some invisible stuff visible
		with obj_solid
			visible = true;
		with obj_slope
			visible = true;
		with obj_platform
			visible = true;
		with obj_secretblock
			visible = true;
		with obj_secretbigblock
			visible = true;
		with obj_secretmetalblock
			visible = true;
	}
}

for (var i = 0; i < array_length(layers); i++;)
{
	if string_startswith(layer_get_name(layers[i]), "Tiles_")
	{
		if is_holiday(holidays.aprilfools)
			tilemap_tileset(layer_tilemap_get_id(layers[i]), tileset_puffer)
	}
}

// i dont even know if i use this
if layer_exists("Tiles_1_NEW")
{
	if OLD_GAMEPLAY
		layer_destroy("Tiles_1_NEW");
	else
		layer_destroy("Tiles_1");
}

