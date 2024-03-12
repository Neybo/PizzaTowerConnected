playerid = obj_player
visible = playerid.visible

if !set
{
	switch toppinwarrior
	{
		case 1:
			spr_idle = spr_twarrior1_idle
			spr_pose = spr_twarrior1_pose
			spr_run =  spr_twarrior1_run
			spr_attack = spr_twarrior1_attack
			spr_hurt = spr_twarrior1_hurt
			global.toppinwarriorid1 = id
			set = true
			break
	
		case 2:
			spr_idle = spr_twarrior2_idle
			spr_pose = spr_twarrior2_pose
			spr_run =  spr_twarrior2_run
			spr_attack = spr_twarrior2_attack
			spr_hurt = spr_twarrior2_hurt
			global.toppinwarriorid2 = id
			break

		case 3:
			spr_idle = spr_twarrior3_idle
			spr_pose = spr_twarrior3_pose
			spr_run =  spr_twarrior3_run
			spr_attack  = spr_twarrior3_attack
			spr_hurt  = spr_twarrior3_hurt
			global.toppinwarriorid3 = id
			break

		case 4:
			spr_idle = spr_twarrior4_idle
			spr_pose = spr_twarrior4_pose
			spr_run =  spr_twarrior4_run
			spr_attack  = spr_twarrior4_attack
			spr_hurt  = spr_twarrior4_hurt
			global.toppinwarriorid4 = id
			break

		case 5:
			spr_idle = spr_twarrior5_idle
			spr_pose = spr_twarrior5_pose
			spr_run =  spr_twarrior5_run
			spr_attack  = spr_twarrior5_attack
			spr_hurt  = spr_twarrior5_hurt
			global.toppinwarriorid5 = id
			break
	}
	set = true
}

