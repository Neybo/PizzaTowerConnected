if array_length(sel) < 4 && !comingfromtex
	sel = [obj_player.paletteselect, obj_player.character,  -4, global.playertexture]; // fucking true index i hate you
	
/// @description palettes & reset choice
switch sel[1]
{
	default:
		spr_palette = spr_peppalette;
		spr_idle = spr_player_idle;
		spr_select = spr_player_skinselect;
		break;
	
	case "N":
		spr_palette = spr_noisepalette;
		spr_idle = spr_playerN_idle;
		spr_select = spr_playerN_panicidle;
		break;
	
	case "V":
		spr_palette = spr_vigipalette;
		spr_idle = spr_playerV_idle;
		spr_select = spr_playerV_gate;
		break;
	
	case "S":
		spr_palette = spr_snickpalette;
		spr_idle = spr_snick_idle;
		spr_select = spr_snick_victory;
		break;
	
	case "SP":
		spr_palette = spr_pizzpalette;
		spr_idle = spr_playerSP_idle;
		spr_select = spr_playerSP_stunned;
		break;
	
	case "SN":
		spr_palette = spr_creampalette;
		spr_idle = spr_playerSN_idle;
		spr_select = spr_playerSN_idle;

	break;
	
	case "PP":
		spr_palette = spr_pisspalette;
		spr_idle = spr_playerPP_idle;
		spr_select = spr_playerPP_skinselect;
		break;
	
	case "J":
		spr_palette = spr_pufferpalette;
		spr_idle = spr_playerJ_idle;
		spr_select = spr_playerJ_idle;
		break;
}

switch sel[1]
{
	default:
		if check_online()
			locked = gms_ini_player_read("saveData", "customlock") == sel[1];
		else
			locked = false;
		break;
}
var basepal = (sel[1] == "P" or sel[1] == "SP" or sel[1] == "SN");

if sel[1] != playerid.character and !comingfromtex
	sel[0] = basepal;
else if !comingfromtex
	sel[0] = playerid.paletteselect;

selmin = 0;
selmax = pal_swap_get_pal_count(spr_palette) - 1;

if !check_shaders()
{
	sel[0] = 0;
	if basepal
		selarray[0] = selarray[1];
}
comingfromtex = false