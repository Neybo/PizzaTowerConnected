if !global.pastdisclaimer
{
	room_goto(room_of_dog);
	exit;
}
if instance_number(object_index) > 1
	instance_destroy()
scr_getinput();

global.miniboss = false

basegrav = 0.5;
grav = basegrav;

breakdancetime = 0;
pizzymidairgrab = 0; // fucker! no more flying
gravmult = 1;
hsp = 0;
vsp = 0;
xscale = 1;
yscale = 1;
facehurt = false
steppy = false
depth = -14
movespeed = 0
jumpstop = false

visible = true
state = states.normal
if room == Realtitlescreen
	state = states.titlescreen
oldstate = state
statefunction = method(undefined, (state == states.normal) ? scr_player_normal : scr_player_titlescreen)

jumpAnim = true
landAnim = false
machslideAnim = false
moveAnim = true
stopAnim = true
crouchslideAnim = true
crouchAnim = true
machhitAnim = false
stompAnim = false

inv_frames = false

hurted = false
autodash = false
mach2 = 0

parry = false
parry_inst = noone
taunt_to_parry_max = 10
parry_count = 0
parry_max = 8

input_buffer_jump = 8
input_buffer_secondjump = 8
input_buffer_highjump = 8
player_x = x
player_y = y
targetRoom = 0
targetDoor = "A"

flash = false

key_particles = false
barrel = false
bounce = false
knightdowncloud = true
idle = 0
attacking = false
slamming = false
superslam = 0
grounded = true
grinding = false

machpunchAnim = false
punch = false
machfreefall = 0
shoot = true
instakillmove = false
windingAnim = 0
facestompAnim = false
ladderbuffer = 0
faceplantbuffer = 0 
toomuchalarm1 = 0
toomuchalarm2 = 0

idleanim = 0
momentum = false
cutscene = false
grabbing = false
dir = xscale
shotgunAnim = false

goingdownslope = false
goingupslope = false
fallinganimation = 0
bombpeptimer = 100

suplexmove = false
suplexmove2 = false
suplexhavetomash = 0

anger = 0
angry = false
baddiegrabbedID = 0
spr_palette = spr_peppalette
spr_texture = spr_peptexture
character = "P"

paletteselect = check_shaders()

colorchange = false

//Second lap
treasure_x = 0
treasure_y = 0
treasure_room = 0

wallspeed = 0

tauntstoredstate = states.normal
tauntstoredmovespeed = 6
taunttimer = 0

tube_id = -1

backtohubstartx = 0
backtohubstarty = 0
backtohubroom = hub_room1

slapcharge = 0
slaphand = 1
slapbuffer = 8
slapflash = 0

freefallsmash = 0
costumercutscenetimer = 0

heavy = false

lastroom_x = 0
lastroom_y = 0
lastroom = 0

hallway = false
hallwaydirection = 0
box = false
oldhallway = false

roomstartx = 0
roomstarty = 0

swingdingbuffer = 0
swingdingdash = 0
lastmove = 0
backupweapon = false

stickpressed = false

macheffect = false
chargeeffectid = obj_null
dashcloudid = obj_null

crazyruneffectid = obj_null
superslameffectid = obj_null
speedlineseffectid = obj_null
angryeffectid = obj_null
thrown = false

knightslide = FMOD_EMPTY
bombpep1snd = FMOD_EMPTY
tumble1snd = FMOD_EMPTY
tumble2snd = FMOD_EMPTY
tumble3snd = FMOD_EMPTY
tumble3alt = FMOD_EMPTY
superjumpholdsnd = FMOD_EMPTY
suplexdashsnd = FMOD_EMPTY
flipsnd = FMOD_EMPTY
snd_fireass = FMOD_EMPTY
_sfx_mach1 = FMOD_EMPTY
_sfx_mach2 = FMOD_EMPTY
_sfx_mach3 = FMOD_EMPTY
_sfx_mach4 = FMOD_EMPTY
tauntsnd = FMOD_EMPTY
superjumpreleasesnd = FMOD_EMPTY
groundpoundsnd = FMOD_EMPTY
sjumpprepsnd = FMOD_EMPTY

scr_playersounds_refresh()

scr_characterspr()
sprite_index = spr_idle
tauntstoredsprite = spr_idle

candyeffect = noone

freefallstart = 0
pogospeed = 2
pogocharge = 100
pogochargeactive = false
wallclingcooldown = 10

bombcharge = 0

flashflicker = false
flashflickertime = 0
kickbomb = false
doublejump = false

pogospeedprev = false

supercharge = 0
supercharged = false
superchargedeffectid = obj_null

pizzashield = false
pizzashieldid = obj_null

pizzapepper = 0

transformation = [
	states.bombpep,
	states.knightpep,
	states.knightpepslopes,
	states.boxxedpep,
	states.cheeseball,
	states.cheesepep,
	states.cheesepepstick,
	states.firemouth,
	states.fireass,
	states.tumble,
	states.stunned,
	states.rideweenie,
	states.gameover,
	states.door,
	states.ghost,
	states.mort,
	states.hitlag,
	states.knightpepattack,
	states.tube,
	states.rocket,
	states.actor,
	states.gotoplayer,
	states.bombgrab,
	states.bombpepup,
	states.bombpepside,
	states.barrelslide,
	states.barreljump,
	states.barrelclimbwall,
	states.cheeseballclimbwall,
	states.motorcycle,
	states.knightpepbump,
	states.knightpepattack,
	states.mortattack,
	states.morthook,
	states.mortjump,
	states.boxxedpepjump,
	states.boxxedpepspin,
	states.rocketslide,
	states.newweenieriding,
	states.cotton,
]

insidefreezer = false

c = 0
breakdance = 50;

hooked = false;
sprgot = -1;
nickname = "";
noisetype = (OLD_GAMEPLAY ? 0 : 1);
noisebombcooldown = 0;
springsjump = false;
keydoor = false;
storedstate = states.normal;
grabbedby = -1;
shake = 0;
drawspr = sprite_index;
online_busy = false;
sjump = true;

// hat
hatsprite = -1;
hatimg = 0;

// pet
petfollow = -1;

// new shit
skateboarding = false;

hurt_buffer = -1;
hurt_max = 120;
invhurt_buffer = 0;
invhurt_max = 30;

shot = false;
shoot_buffer = 0;
shoot_max = 20;
breakdance_buffer = 0;

mort = false;
sjumpvsp = -12;
freefallvsp = 15;

hitX = x;
hitY = y;
hithsp = 0;
hitvsp = 0;
hitstunned = false;
hitxscale = 1;
stunned = false;
hitLag = 25;

doorx = x;

verticalhallway = false;
vhallwaydirection = 0;
vhallwaypos = 0;

endtumble = false
hascollision = true

img_angle = 0
canfall = true
godmode = false

konami = "";
konamiend = "UUDDLRLRBA";

input_buffer_faceplant = 8;

// eggplant build shit
vsp_carry = 0
hsp_carry = 0
rocketvsp = 0
sticking = false
platformid = noone
jetpackdash = 0
flamecloud_buffer = 0
rankpos_x = x
rankpos_y = y
transformationlives = 0
punch_afterimage = 0
superattackstate = states.normal
scale_xs = 1
scale_ys = 1
verticalbuffer = 0
verticalstate = states.normal
webID = noone
float = 0
boxxedpepjump = 10
boxxedpepjumpmax = 10
icemovespeed = 0
prevhsp = 0
prevstate = states.normal
prevxscale = 1
prevsprite = sprite_index
move = 0
prevmovespeed = 0
previcemovespeed = 0
icedir = 1
icemomentum = 0
savedicedir = 1
isgustavo = false
jumped = true
ramp = false
ramp_points = 0
ramp_buffer = 0
bombup_dir = 1
knightmomentum = 0
grabbingenemy = 0
blur_effect = 0
firemouth_dir = 1
firemouth_max = 10
firemouth_buffer = firemouth_max
firemouth_afterimage = 0
balloonbuffer = 0
golfid = -4
bombgrabID = noone
barrelslope = 0
barrel_maxmovespeed = 16
barrel_maxfootspeed = 10
barrel_rollspeed_threshold = 10
barrel_accel = 1
//barrel_deccel = 1
barrel_slopeaccel = 0.25
barrel_slopedeccel = 0.5
barrelroll_slopeaccel = 0.5
barrelroll_slopedeccel = 0.35
ratmount_movespeed = 8
//ratmount_fallingspeed = 0
ratgrabbedID = -4
ratpowerup = -4
ratshootbuffer = 0
rateaten = 0
gustavodash = 0
brick = 0
ratmountpunchtimer = 25
gustavokicktimer = 5
cheesepep_buffer = 0
cheesepep_max = 10
pepperman_deccel = 0.5
pepperman_accel_air = 0.15
pepperman_deccel_air = 0.25
pepperman_maxhsp_normal = 6
pepperman_jumpspeed = 11
pepperman_grabID = -4
shoulderbash_mspeed_start = 12
shoulderbash_mspeed_loop = 10
shoulderbash_jumpspeed = 11
input_attack_buffer = 0
input_finisher_buffer = 0
//input_up_buffer = 0
input_down_buffer = 0
hit_connected = false
mach4mode = false
railmomentum = 0
railmovespeed = 0
raildir = 1
boxxed = false
boxxeddash = 0
cheesepeptimer = -1
cheeseballbounce = 0
slopejump = 0
hooked = false
swingdingendcooldown = 0
crouchslipbuffer = 0
breakdance_speed = 0.25
notecreate = 50
doublejump = false

secretsneeded = 3
treasureneeded = true
lap2needed = true
toppinsneeded = 3

steppybuffer = 8
wallclimbbuffer = 0
fuckyouteleporter = false
lastplayerracing = 0

scr_playerspeed()
nickcol = c_white

if (check_online())
{
	if gms_self_isowner()
		nickcol = c_owner;
	else if gms_self_admin_rights()
		nickcol = c_admin;
	else if global.pvp
		nickcol = c_pvp;
}

// OPTIMIZIERS!

_colorfulafterimages = false
_playermaskcheck = false
_attacking = false
_grabbing = false
_instakillmove = false
_pepperinstakillmove = false // THIS SHIT IS INVERSE!!

// globals
global.combodropped = false

global.saveroom = ds_list_create();
global.baddieroom = ds_list_create();
global.followerlist = ds_list_create();
global.baddietomb = ds_list_create();
global.escaperoom = ds_list_create();

global.playerhealth = 100

global.tauntcount = 0
	
global.toppintotal = 1
global.shroomfollow = false
global.cheesefollow = false
global.tomatofollow = false
global.sausagefollow = false
global.pineapplefollow = false

global.key_inv = 0
global.keyget = false
global.giantkey = false
global.collect = 0
global.treasure = false
global.gotshotgun = false

global.combo = 0
global.previouscombo = 0
global.combotime = 0
global.comboscore = 0
global.savedcomboscore = 0
global.savedcombo = 0

global.panic = false
global.snickchallenge = false
global.snickrematch = false

global.golfhit = 0
global.funmode = false
global.secretfound = 0

scr_setcoin(0)
global.pizzacoinstart = global.pizzacoin;

global.heattime = 0;
global.style = 0;
global.stylethreshold = 0;
global.baddiespeed = 1;
global.baddiepowerup = false;
global.baddierage = false;

global.showgnomelist = true;
global.pizzadelivery = false;
global.failcutscene = false;
global.pizzasdelivered = 0;

global.spaceblockswitch = true;

global.bullet = 0;
global.mort = false;

global.gerome = false;
global.stylelock = false;
	
global.horse = false
global.checkpoint_room = -4
global.checkpoint_door = "A"
global.kungfu = false
global.graffiticount = 0
global.graffitimax = 20
global.noisejetpack = false
global.hasfarmer = [0, 0, 0]
	
global.lap = false
global.laps = 0	

global.seconds = 59
global.minutes = 1

scr_playerreset()


//inverted = false
surf = -4
last_chat_message = "";
last_chat_time = 0;
last_chat_color = 0;

#region FAKE PEP SHIT
	dance_timer = 0
	dance_ticktimer = 0
	dance_lastpose = [0, 0] 
	dance_lastcombo = [0, 0]
	dance_cancombo = true
	dance_curpose = -1
	dance_timessincelastcombo = 0
	dance_style = 0
	dance_storeposes = []
	dance_dancing = false
	dance_imgspeed = 0.35

	dance_dances = [
	{key: "key_up2", sprite: "spr_jump", imgspd: 0.5, vsp: -5, dance: dancesfpb.flipmidair},
	{key: "key_down2", sprite: "spr_breakdancesuper", imgspd: 0.35, vsp: 0, dance: dancesfpb.breakdancefloor},
	{key: "key_slap2", sprite: spr_player_hanstandjump, imgspd: 0.9, vsp: 0, dance: dancesfpb.handstand},
	{key: -1, sprite: spr_backflip, imgspd: 0.4
		, vsp: -5, dance: dancesfpb.backflip},
	{key: -1, sprite: spr_player_climbstairs, imgspd: 0.6, vsp: 0, dance: dancesfpb.climbstairs},
	{key: "key_right2", sprite: spr_player_suplexdance, imgspd: 0.9, vsp: 0, dance: dancesfpb.twirl},
	{key: "key_left2", sprite: "spr_tackle", imgspd: 0.35, vsp: 0, dance: dancesfpb.tackle},
	{key: "key_taunt2", func: function(){
		with obj_player
		{
			sprite_index = spr_taunt;
			image_index = irandom(sprite_get_number(spr_taunt) - 1)
			if sprite_index == spr_player_taunt			
			{
					// 11 = look right
					// 12 = look left
					if image_index == 11 && xscale == -1
						image_index = 12;
					else if image_index == 12 && xscale == 1
						image_index = 11;
			}
			instance_create(x, y, obj_taunteffect)
		}
		}, imgspd: 0.0, vsp: 0, dance: dancesfpb.taunt, sprite: "spr_taunt"
	}, ]

	dance_length = array_length(dance_dances)

	dance_combos = [
	{dance: dancesfpb.climbstairs, uses_array: true, array: [dancesfpb.taunt, dancesfpb.poses,
		dancesfpb.handstand, dancesfpb.flipmidair], pose_to_start: dancesfpb.breakdancefloor},
	
	{dance: dancesfpb.backflip, uses_array: false, 
	pose_to_start: dancesfpb.flipmidair, pose_before: dancesfpb.breakdancefloor}
	]

	function dance_restart(anim, spd = 0.35)
	{
		dance_dancing = false
		sprite_index = anim
		image_index = 0
		dance_imgspeed = spd
		animEnd = false
		dance_timer = 0
	}

	function dance_find(dance_id)
	{
		var len = array_length(dance_dances)
		for (var i = 0; i < len; i++)
		{
			if dance_dances[i].dance = dance_id
				return dance_dances[i]
		}
		return dancesfpb.handstand
	}

	function dance_parse(json, _combo = false)
	{
		if (json.key == -1 && _combo) 
		|| (json.key != -1 && (variable_instance_get(id, json.key) != 0))
		{
			if typeof(json.sprite) == "number"
			{
				sprite_index = json.sprite
			}
			else
			{
				sprite_index = variable_instance_get(id, json.sprite)
			}
			image_index = 0
			dance_imgspeed = json.imgspd
			image_speed = dance_imgspeed
			dance_timer = 0
			if variable_struct_exists(json, "func")
				json.func()
			vsp = json.vsp
			// parse dance
			var dance_time = json.dance
			var len = array_length(dance_combos)
			for (var i = 0; i < len; i++)
			{
				if !dance_cancombo
					break;
				var file = dance_combos[i]
				if file.pose_to_start == dance_time // init check complete, time to do more checks
				{
					if file.uses_array
					{
						if array_equals(file.array, dance_storeposes)
						{
							if file.dance == dance_lastcombo[0]
							{
								dance_lastcombo[1]++
							}
							else
							{
								dance_lastcombo[1] = 0
								dance_lastcombo[0] = file.dance
							}
							dance_storeposes = []
							dance_cancombo = false
							dance_timessincelastcombo = 0
							return dance_parse(dance_find(file.dance), true);
						}
					}
					else
					{
						if file.pose_before == dance_lastpose[0]
						{
							if file.dance == dance_lastcombo[0]
							{
								dance_lastcombo[1]++
							}
							else
							{
								dance_lastcombo[1] = 0
								dance_lastcombo[0] = file.dance
							}
							dance_cancombo = false
							dance_timessincelastcombo = 0
							return dance_parse(dance_find(file.dance), true);
						}
					}
				}
			}
			dance_dancing = true
			dance_handledance(dance_time)
			return true
		}
		return false
	}

	dance_scores = ds_map_create()
	// non basic
	ds_map_add(dance_scores, dancesfpb.climbstairs, 150)
	ds_map_add(dance_scores, dancesfpb.backflip, 100)
	// basic
	ds_map_add(dance_scores, dancesfpb.flipmidair, 50)
	ds_map_add(dance_scores, dancesfpb.breakdancefloor, 50)
	ds_map_add(dance_scores, dancesfpb.taunt, 50)
	ds_map_add(dance_scores, dancesfpb.handstand, 50)
	ds_map_add(dance_scores, dancesfpb.poses, 50)
	ds_map_add(dance_scores, dancesfpb.twirl, 50)
	ds_map_add(dance_scores, dancesfpb.tackle, 50)

	enum dancesfpb
	{
		flipmidair, //
		backflip, // bdf -> flipmidair
		taunt, //
		breakdancefloor, //
		handstand, //
		poses,
		climbstairs, // backflip -> handstand -> poses -> taunt -> poses
		twirl,
		tackle,
	}

	function dance_handledance(dance)
	{
		var dance_combo_is = dance == dancesfpb.backflip || dance == dancesfpb.climbstairs
		if dance_curpose != -1 && !dance_combo_is // last pose 
		{
			if dance_lastpose[0] = dance
				dance_lastpose[1]++
			else
			{
				dance_lastpose[0] = dance
				dance_lastpose[1] = 0
				dance_cancombo = true
			}
			dance_timessincelastcombo++;
			if dance_timessincelastcombo > 5
			{
				dance_lastcombo = [0, 0]	
			}
			array_insert(dance_storeposes, 0, dance_lastpose[0])
			array_resize(dance_storeposes, 4)
		}
		dance_curpose = dance
	
		// score
		var rep = dance_lastpose[1] + 1
		var style = ds_map_find_value(dance_scores, dance)
		if dance_combo_is
			rep = dance_lastcombo[1] + 1
		if rep > 5 // stop spamming please
			return; 
		var bpmmatch = false
		if fmod_get_instance_name(global.music) == mu_fakepeppart2
		{
			var divby = ceil(fmod_get_instance_timeline_pos(global.music) / 0.465)
			var num = 0.465 - ((0.465 * divby) - fmod_get_instance_timeline_pos(global.music))
			if num < 0.6 || num > 0.4
			{
				bpmmatch = true;
			}
		}
		if bpmmatch 
			dance_style += (style * 1.25) / rep
		else
			dance_style += style / rep
	}
#endregion