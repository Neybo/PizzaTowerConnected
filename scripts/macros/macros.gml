// config macro

#macro debug (GM_build_type == "run")  // running the game thru gamemaker enables debug

//release macros
#macro release false
#macro notfullgameRELEASE:release true
#macro fullgameRELEASE:release true

// fullgame macros
#macro fullgame true
#macro notfullgameRELEASE:fullgame false
#macro notfullgameNOTRELEASE:fullgame false

// more macros
#macro c_owner merge_colour(c_blue, c_white, 0.75)
#macro c_admin merge_colour(c_yellow, c_white, 0.5)
#macro c_eatery merge_colour(c_orange, c_white, 0.25)
#macro c_beebawp merge_colour(c_fuchsia, c_white, 0.5)
#macro c_pvp merge_colour(c_red, c_white, 0.3)
#macro c_error merge_colour(c_red, c_white, 0.25)
#macro c_success merge_colour(c_yellow, c_white, 0.25)

#macro MAX_BLUR 0.55

#macro _camx camera_get_view_x(view_camera[0])
#macro _camy camera_get_view_y(view_camera[0])
#macro _camw camera_get_view_width(view_camera[0])
#macro _camh camera_get_view_height(view_camera[0])

#macro room_name room_get_name(room)
#macro obj_player1 obj_player
#macro obj_player2 obj_player

// gameplay
#macro OLD_GAMEPLAY global.gameplay == 0
#macro FINAL_GAMEPLAY global.gameplay != 0
#macro FINAL_GAMEPLAY_ONLY global.gameplay == 1
#macro NOT_FINAL_GAMEPLAY_ONLY global.gameplay != 1
#macro REMIX_GAMEPLAY global.gameplay == 2
#macro NOT_REMIX_GAMEPLAY global.gameplay != 2

// states enum
enum states {
	normal,
	revolver,
	dynamite,
	boots,
	grabbed,
	tumble,
	finishingblow,
	ejected,
	transitioncutscene,
	fireass,
	firemouth,
	mort,
	hook,
	ghost,
	titlescreen,
	hookshot,
	tacklecharge,
	cheeseball,
	slap,
	
	cheesepep,
	cheesepepstick,
	cheesepepstickside,
	cheesepepstickup,
	
	rideweenie,
	boxxedpep,
	pistolaim,
	climbwall,
	knightpepslopes,
	portal,
	secondjump,
	chainsawbump,
	handstandjump,
	gottreasure,
	
	knightpep,
	knightpepattack,
	
	meteorpep,
	bombpep,
	grabbing,
	chainsawpogo,
	shotgunjump,
	pogo,
	stunned,
	highjump,
	chainsaw,
	facestomp,
	mach4,
	timesup,
	machroll,
	shotgun,
	pistol,
	machfreefall,
	_throw,
	slam,
	superslam,
	skateboard,
	grind,
	grab,
	punch,
	backkick,
	uppunch,
	shoulder,
	backbreaker,
	bossdefeat,
	pizzathrow,
	bossintro,
	gameover,
	keyget,
	tackle,
	jump,
	ladder,
	slipnslide,
	comingoutdoor,
	smirk,
	Sjump,
	victory,
	Sjumpprep,
	crouch,
	crouchjump,
	crouchslide,
	mach1,
	mach2,
	machslide,
	bump,
	hurt,
	freefall,
	hang,
	turning,
	freefallland,
	door,
	barrel,
	current,
	boulder,
	taxi,
	policecartaxi,
	runonball,
	mach3,
	freefallprep,
	Sjumpland,
	faceplant,
	rage,
	idle,
	bounce,
	charge,
	pizzagoblinthrow,
	turn,
	hitceilling,
	hitwall,
	walk,
	fall,
	land,
	hit,
	stun,
	recovery,
	stomped,
	chase,
	spawn, // tank
	arenaintro,
	actor,
	parry,
	golf,
	tube,
	pummel,
	slipbanan,
	rocket,
	gotoplayer,
	hitlag, // hitlag... my enemy....
	dance,
	rotate,
	frozen,
	spindash,
	cotton,
	cherrywait, // cherry enemy
	fling,
	geyser,
	
	cheesepepjump,
	cheesepepfling,
	cheeseballclimbwall,
	cheesepeplaunch,
	
	boxxedpepjump,
	boxxedpepspin,
	
	spiderweb,
	kungfu, // unused_1? no longer - turn into kungfu!
	shoulderbash,
	knightpepbump,
	bombpepup,
	bombpepside,
	bombgrab,
	thrown,
	throwing,
	graffiti,
	barrelslide,
	barrelclimbwall,
	clown,
	mortjump,
	mortattack,
	morthook,
	bombdelete,
	lungeattack,
	rocketslide,
	trickjump,
	ridecow,
	
	ratmount,
	ratmounthurt,
	ratmountjump,
	ratmountattack,
	ratmountspit,
	ratmountclimbwall,
	ratmountgroundpound,
	ratmountbounce,
	ratmountballoon,
	ratmountgrind,
	ratmounttumble,
	ratmountpunch,
	ratmounttrickjump,
	ratmountskid,
	ratmountcrouch,
	ratmountladder,
	
	balloon,
	trashjump,
	trashroll,
	
	stringfling,
	stringjump,
	stringfall,
	
	noisejetpack,
	newweenieriding,
	animatronic,
	jetpackjump,

	antigrav,
	motorcycle,
	barreljump,
	breakdance,
	
	supersideprep,
	supersidejump,
	
	firedrill,
	firedrillattack,
	
	dogmount, // i know the name of the states from the dev streams
	dogmountspin,
}

