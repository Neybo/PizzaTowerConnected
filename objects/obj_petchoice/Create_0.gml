event_inherited();

selarray = [
	[spr_nohat, "NOBODY", "All alone..."],
	[spr_petrat_idle, "CHEESED NOISE", "Father, those are wretches."],
	[spr_petraton_idle, "RATON", "Their beloved, I suppose."],
	[spr_petspamton_idle, "SPAMTON", choose("ENL4RGE Yourself", "TRANSMIT KROMER", 
	"HELP", "HAEAHAEAHAEAHAEAH!!", "DON'T YOU WANNA BE A BIG SHOT?")],
	[spr_petgrunt_idle, "GRUNT", "Do you ever just need some Madness?"],
	[spr_petslug_idle, "BLUE SLUGGY", "Diabetes."],
	[spr_petmariro_move, choose("MARIRO", "MARIOR", "MARIROR", "MAIRORR"), "Seuaper Maroi!"],
	[spr_petnerd_idle, "NERDLING", ""],
	[spr_petelmo_idle, "ELMO", "Don't know who this guy is."],
	[spr_petsneck_idle, "SNECK", "Sneck is here for you."],
	[spr_playerW_idle, "WEENIE", "Don't use drugs. Ever."],
	[spr_toppinshroom_NEW, "MUSHROOM", "+1000 points."],
	[spr_toppincheese_NEW, "CHEESE", "Don't use it to cheese up yourself."],
	[spr_toppintomato_NEW, "TOMATO", "This one has blood."],
	[spr_toppinsausage_NEW, "SAUSAGE", "This sausage is cooked unlike some others..."],
	[spr_toppinpineapple_NEW, "PINEAPPLE", "Sunglasses are expensive y'know."],
	[jimmer_alberto, "JIMMER ALBERTO", "We don't know how he appeared.\nWe're serious."],
];
spr_idle = selarray[0][0];
selvert = false;

event_user(0);

