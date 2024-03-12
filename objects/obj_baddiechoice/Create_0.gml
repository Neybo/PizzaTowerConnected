event_inherited();

selarray = [
	[obj_pizzaboy, "PIZZA BOY", "Cardboard."],
	[obj_cheeseslime, "CHEESESLIME", "Totally useless. Cannon fodder."],
	[obj_forknight, "FORKNIGHT", "His variant is Battle Royale."],
	[obj_swedishmonkey, "SWEDISH MONKEY", "Desperate to get a laugh."],
	[obj_pizzard, "PIZZARD", "The pizzard circle studies pizzamancy."],
	[obj_ancho, "WINGED ANCHOVY", "Missed their glasses at home."],
	[obj_pizzagoblin, "PIZZABOX GOBLIN", "Urban legends tell of goblins that would\nhide in a pizza box and put bombs inside them."],
	[obj_minijohn, "MINI JOHN", "How exactly did these come to be?"],
	[obj_pepgoblin, "PEPPERONI GOBLIN", "He will take any opportunity to practice kicks."],
	[obj_treasureguy, "TREASURE GUY", "I wouldn't call it a treasure."],
	[obj_piraneapple, "PIRANEAPPLE", "I'm glad they abide by the laws of physics now."],
	[obj_banditochicken, "BANDITO CHICKEN", "Boner explosion"],
	[obj_pizzice, "PIZZICE", "Rest in peaceice."],
	[obj_robot, "PEPPINO ROBOT", "How did they have the time to build these?"],
	[obj_kentukykenny, "KENTUCKY KENNY", "Might throw spicy chicken wings at you."],
	[obj_noisegoblin, "NOISE GOBLIN", "Looks like someone found 3 sticks and 3 string."],
	[obj_canongoblin, "CANNON GOBLIN", "Fire!"],
	[obj_pickle, "PICKLE", "Based on the Roper enemy from Memoirs of Magic,\nthey perfectly captured how annoying this enemy is meant to be."],
	[obj_rancher, "RANCH SHOOTER", "Doesn't really shoot ranch though.\nTrivia: Sprites for this enemy are unused in the SAGE 2019 demo."],
	[obj_bigcheese, "BIG CHEESE", "Born with its hard hat, eventually learned to be scared."],
	[obj_pizzaball, "GREASEBALL", "Nearly everything in this game HAS to be cheese, even a golf ball."],
	[obj_pizzaballOLD, "OLD GREASEBALL", "You see, instead of actually using a golf stick,\nyou just beat the shit out of them."],
	[obj_spitcheese, "SPIT CHEESE", "It... spits cheese. Makes sense."],
	[obj_trash, "TRASH PAN", "Someone has a lot of spare cheese."],
	[obj_peasanto, "PEASANTO", "Arson!"],
	[obj_ninja, "NINJA SLICE", "A pizza slice with their fulfilled dreams of becoming a ninja."],
	[obj_coolpineapple, "COOL PINEAPPLE", "Where's the cool in getting parried?"],
	[obj_noisey, "NOISEY", "Fortunately not as noisey."],
	[obj_miniufo, "UFOLIVE", "Morty\nRick and M\norty"],
	[obj_miniufo_grounded, "GROUNDED UFOLIVE", "No need for a spaceship when you have a death wish."],
	[obj_indiancheese, "INDIAN CHEESE", "I shit you not, this cheese right here comes straight from the indian lands."],
	[obj_fencer, "PENCER", "Pizza fencer."],
	[obj_sausageman, "SAUSAGE MAN", "Don't do drugs."],
	["special1", "SMOKED SAUSAGE MAN", "He did drugs."],
	[obj_weeniesquire, "WEENIE SQUIRE", "HOG RIDER"],
	[obj_thug_red, "SHRIMP THUG", "Stereotypical street criminal, for the chinese themed level."],
	["bluethug", "BLUE THUG", "On a mission to stab an italian man with a flying knife."],
	["greenthug", "GREEN THUG", "I dare you to find it if you can."],
	[obj_soldier, "PIZZA SOLDIER", "He's camping."],
	[obj_kentukybomber, "KENTUCKY BOMBER", "He's committed several war crimes."], // same
	[obj_peppinoclone, "PEPPINO CLONE", "Not related to anyone. Trust me."],
	[obj_coneboy, "CONEBOY", "Cardboard, now with a grain of sa-... sugar."],
	[obj_gumslime, "GUMSLIME", "Yeah, just um... replace the cheese with gum. Good enough. New enemy."],
	[obj_smurfknight, "SMOREKNIGHT", "You would not want to suffer the same fate that this Forknight had to."],
	[obj_charcherry, "CHAR CHERRY", "Cherry?! That's a walking fucking bomb!"],
	[obj_cottonwitch, "COTTON WITCH", "Not only is it a food swap but a gender swap as well."]
]
if FINAL_GAMEPLAY
{
	for(var i = array_length(selarray) - 1; i > 0; i--)
	{
		if selarray[i][0] == "greenthug"
			array_delete(selarray, i, 1);
		if selarray[i][0] == "bluethug"
			array_delete(selarray, i, 1);
	}
}

spr_idle = -1;

sel[0] = 0;
selvert = false;

baddiemenu = noone;

event_user(0);