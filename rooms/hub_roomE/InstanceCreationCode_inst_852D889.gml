level = "snickchallenge"
targetRoom = medieval_1
targetDoor = "A";
sprite_index = spr_snickchallengecomputeroff
bgsprite = spr_snickchallengecomputer
computer = 1

if global.timeattack or global.modifier == mods.no_toppings
	instance_destroy();