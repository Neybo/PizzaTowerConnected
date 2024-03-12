if !variable_global_exists("crashed")
{
	instance_destroy();
	exit;
}

scr_soundeffect(sfx_pephurt);

crashtext = choose(lang_string("general.crash"), "The game didn't like you last time.", 
"This has been reported to discord. I think.", 
"You know who else crashes?","Marior caused this. I'm sure.", "\"It Works On Offline Mode But...\"", 
"The game crashed last time! Or did it?", "You didn't hit C on your keyboard.", 
"yby vzntvar penfuvat", "My game didn't crash next time!", "i crashed u! :3",
"You did something, didn't you?", 
"This crash is no joking matter.", "This is such a saddening occurrence!", "Logitech, Fix this please.");
if irandom_range(1, 100) == 1 // 1% chance
	crashtext = "OOPSIE WOOPSIE!! Uwu We made a fucky wucky :3";

// do not judge my intentions

fading = false;
image_alpha = 0;

