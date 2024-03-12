ID = id;

image_speed = 0
image_index = 0;
depth = -1

if global.snickrematch && global.snickchallenge
	price = 0;
else
	price = 4;

if !check_online()
	sprite_index = spr_weaponmachine_score;
collect_shake = 0;
needtops = 30;

