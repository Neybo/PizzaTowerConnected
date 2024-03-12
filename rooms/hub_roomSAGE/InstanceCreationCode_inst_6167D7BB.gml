dialogue = [
	"Why are you here?",
	"You can play all these levels elsewhere.",
	"You can literally play as me if you missed me.",
	"Eh, whatever."
]
if obj_player.character == "S"
dialogue[2] = "You're literally playing as me."

// dialogue depending on progression
ini_open("saveData" + string(global.saveslot) + ".ini");
var medievalrank = ini_read_string("Ranks", "medieval", "none");
var ruinrank = ini_read_string("Ranks", "ruin", "none");
var dungeonrank = ini_read_string("Ranks", "dungeon", "none");
ini_close();


// destroy snick challenge pc
if medievalrank == "none" or ruinrank == "none" or dungeonrank == "none"
	instance_destroy(inst_4B888DF3);

