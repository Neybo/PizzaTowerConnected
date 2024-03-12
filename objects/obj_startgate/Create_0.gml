if global.panic && string_startswith(room_get_name(room), "tower_")
	instance_destroy();

bgalpha = 1
bgalpha2 = 1
bgalpha3 = 1
bgalpha4 = 1
depth = 50 + floor((room_height - y) / 64); // show higher startgates BEHIND lower ones
level = "none"
oglevel = "none"

drawing = false
targetDoor = "A"
world = 1
pizza = 0
boss = 0
drawing = 0
manualhide = false
short = false

msg = ""

if FINAL_GAMEPLAY
	sprite_index = spr_gate_entrance;
if check_sugary()
	sprite_index = spr_entrancegate_ss;
image_speed = 0.35;

readsave = false;

tasec = 0;
tamin = 0;
tachar = "";
toppin1 = false;
toppin2 = false;
toppin3 = false;
toppin4 = false;
toppin5 = false;
highscore = 0;
secret = 0;
lap = 0
computer = 0
bgsprite = spr_gate_grinchBG

bgmask_surface = -4
bgclip_surface = -4

myturn = false;
img = 0

titlecard_sprite = spr_titlecards;
titlecard_index = 0;
title_sprite = spr_titlecards_title;
title_index = 0;
title_music = "event:/music/titlecards/entrancetitle";
notitle = 0