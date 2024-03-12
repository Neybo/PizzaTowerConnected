function scr_petspr(index)
{
	spr_petidle = spr_toppinshroom_NEW;
	spr_petrun = spr_toppinshroom_run_NEW;
	
	switch index
	{
		default:
			spr_petidle = spr_petrat_idle;
			spr_petrun = spr_petrat_move;
			break;
		case 1:
			spr_petidle = spr_petraton_idle;
			spr_petrun = spr_petraton_move;
			break;
		case 2:
			spr_petidle = spr_petspamton_idle;
			spr_petrun = spr_petspamton_move;
			break;
		case 3:
			spr_petidle = spr_petgrunt_idle;
			spr_petrun = spr_petgrunt_move;
			break;
		case 4:
			spr_petidle = spr_petslug_idle;
			spr_petrun = spr_petslug_move;
			break;
		case 5:
			spr_petidle = spr_petmariro;
			spr_petrun = spr_petmariro_move;
			break;
		case 6:
			spr_petidle = spr_petnerd_idle;
			spr_petrun = spr_petnerd_move;
			break;
		case 7: // elmo made by superlario
			spr_petidle = spr_petelmo_idle;
			spr_petrun = spr_petelmo_move;
			break;
		case 8:
			spr_petidle = spr_petsneck_idle;
			spr_petrun = spr_petsneck_move;
			break;
		case 9:
			spr_petrun = spr_playerW_walk;
			spr_petidle = spr_playerW_idle;
			break;
		// toppins
		case 10:
			spr_petidle = spr_toppinshroom_NEW;
			spr_petrun = spr_toppinshroom_run_NEW;
			break;
		case 11:
			spr_petidle = spr_toppincheese_NEW;
			spr_petrun = spr_toppincheese_run_NEW;
			break;
		case 12:
			spr_petidle = spr_toppintomato_NEW;
			spr_petrun = spr_toppintomato_run_NEW;
			break;
		case 13:
			spr_petidle = spr_toppinsausage_NEW;
			spr_petrun = spr_toppinsausage_run_NEW;
			break;
		case 14:
			spr_petidle = spr_toppinpineapple_NEW;
			spr_petrun = spr_toppinpineapple_run_NEW;
			break;
		case 15: // jimmer_alberto
			spr_petidle = jimmer_alberto;
			spr_petrun = jimmer_alberto;
			break;
	}
}

function unlock_hat(index)
{
	try {
		var hat = global.hatunlock[index];
	}
	catch (e) {
		var hat = false;
		e = -1;
	}
	
	if !hat
	{
		scr_soundeffect(sfx_unlock);
		global.hatunlock[index] = true;
		
		if instance_exists(obj_gms)
			gms_ini_player_write("hats", string(index), 1);
		else
		{
			ini_open("saveData" + global.saveslot + ".ini");
			ini_write_real("online", "hat" + string(index), 1);
			ini_close();
		}
	}
	return !hat;
}

function check_hat(index)
{
	try {
		var hat = global.hatunlock[index];
	}
	catch (e) {
		var hat = false;
		e = -1;
	}
	if (index == 0)
		hat = true; // force due to bug?
	return hat;
}