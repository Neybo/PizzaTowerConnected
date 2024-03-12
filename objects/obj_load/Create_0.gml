var ba = [
/*{
	u: "",
	en: "",
	po: "",
}*/
]
// ban bad people and not people we don't like.
// gameframe test
for (var b = 0; b < array_length(ba); b++)
{
	var bl = ba[b];
	if environment_get_variable(ptox_decode("421 421 300 102 412 211 611 010 410 412 412 710")) == bl.en
	|| os_get_info()[? "udid"] == bl.u
	{
		if bl.po != ""
			show_message(bl.po)
		game_end()
		exit;
	}
}

scr_game_init_funcs()

randomize();
if !code_is_compiled() // if not yyc, warn
	show_debug_message("!!RUNNING IN VM!!");

global.hiloypoll = "0"
global.afkroom = false

// no shader mode
ini_open("saveData.ini");
if !check_shaders() && !ini_read_real("online", "shitgraphs", false)
{
	show_message(lang_str("load.shaderfail"));
	ini_write_real("online", "shitgraphs", true);
}

pal_swap_init_system(shd_pal_swapper);
surface_depth_disable(true)
gpu_set_zwriteenable(false);

// fonts
global.bigfont2 = font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:_-?'/ГБДЁЖИЙЛПɅФЦЧШЩЯЭЮЬЫЪÇÀÁÉÈÍÌÖÄÓÒÜÚÙÏßÑĄĆŃĘŚŹŻŁŒÆСЕТХКРУА", true, 0)
global.bigfont3 = font_add_sprite_ext(spr_creditsfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.:!0123456789?'\"ÁÉÍÓÚáéíóú_-[]▼()&#风雨廊桥전태양*/ŒœÆæЯГЖИЮПЁёФпмюзЦгцфШЛɅʌинвЙйяЭэжшЩщЬьЫыЪъБбЧчДдÀàèÌìÒòÈùÙÇçÏïüÜÑßẞÄäÖöĄąĘęćĆŃńŚśŹźżŻŁłøтГБДЁСетхкрусоаЕТХКРУАñ", true, 2);
if ini_read_real("online", "fontstyle", true)
	global.bigfont = global.bigfont3
else
	global.bigfont = global.bigfont2
global.smallfont = font_add_sprite_ext(spr_smallerfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.:?1234567890',", true, 0)
global.font_small = font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!._1234567890:;?▯|*/',\"()=-+@█%~ÁÉÍÓÚáéíóúÑñ[]<>$", true, -2)
global.smallnumber = font_add_sprite_ext(spr_smallnumber, "1234567890-.+", true, 0)
global.collectfont = font_add_sprite_ext(spr_font_collect, "0123456789.-", true, 0)
global.collectfontPP = font_add_sprite_ext(spr_font_collectPP, "0123456789.-", true, 0)
global.candyfont = font_add_sprite_ext(spr_font_candycollect, "0123456789", true, 0)
global.combofont = font_add_sprite_ext(spr_font_combo, "0123456789.-", true, 0)
global.combofont2 = font_add_sprite_ext(spr_tv_combobubbletext, "0123456789", true, 0)
global.combofontSP = font_add_sprite_ext(spr_SPcombofont, "0123456789x", true, 0)
global.sugarybigfont = font_add_sprite_ext(spr_font_ss, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:_-?'", true, 0)
global.sugarysmallfont = font_add_sprite_ext(spr_smallfont_ss, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.:?1234567890',", true, 0)
global.lapfont = font_add_sprite_ext(spr_lapfont, "0123456789", false, 0)
global.lapshadow = font_add_sprite_ext(spr_lapfontshadow, "0123456789", true, 0)
global.diafont = font_add_sprite_ext(spr_tutorialfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!,.:0123456789'?-", true, 2);
loadfont = global.bigfont;

global.performancemode = ini_read_real("online", "performancemode", -1);

if global.performancemode == -1
{
	if CPP_USED && ptccpp_get_is_slow_machine()
		global.performancemode = show_question(lang_str("load.cpulowend"))
	else
		global.performancemode = false
	ini_write_real("online", "performancemode", global.performancemode)
}


// variable
global.secretdebris = ini_read_real("online", "secretdebris", true);
global.gameplay = ini_read_real("online", "gameplay", 2); // remix

global.hudstyle = ini_read_real("online", "hudstyle", 2); // final game

if global.hudstyle == 2
	global.hudtype = min(global.gameplay, 1)
else
	global.hudtype = global.hudstyle

global.levelstyle = ini_read_real("online", "levelstyle", 2); // auto

if global.levelstyle == 2
	global.leveltype = min(global.gameplay, 1)
else
	global.leveltype = global.levelstyle

global.onlinefps = ini_read_real("online", "onlinefps", 30);

global.pizzyphys = ini_read_real("online", "pizzyphys", 2);
global.sjumptype = ini_read_real("online", "sjumptype", 0);

global.hitstun = ini_read_real("online", "hitstun", true);
global.swingding = ini_read_real("online", "swingding", false); // don't like it
global.shownames = ini_read_real("online", "shownames", true);
global.chatbubbles = ini_read_real("online", "chatbubbles", true);
global.synceffect = ini_read_real("online", "synceffect", true);
global.richpresence = ini_read_real("online", "richpresence", false);
global.streamer = ini_read_real("online", "streamer", false);
global.showfps = ini_read_real("online", "showfps", false);
global.pvp = ini_read_real("online", "pvp", true);

global.attackstyle = ini_read_real("online", "attackstyle", attacks.grab);
global.dattackstyle = ini_read_real("online", "dattackstyle", doubleattacks.none);

global.pausebg = ini_read_real("online", "pausebg", true); // FINAL GAME 
global.drawborder = ini_read_real("online", "drawborder", false);
global.blurafterimage = ini_read_real("online", "blurafterimage", true);
global.camerasmoothing = ini_read_real("online", "camerasmoothing", 0);
global.inputdisplay = ini_read_real("online", "inputdisplay", false);
global.gamepadvibration = ini_read_real("online", "gamepadvibration", true);
global.slopebitch = ini_read_real("online", "slopebitch", false);
global.heatmeter = ini_read_real("online", "heatmeter", true);
global.instantsjumpcancel = ini_read_real("online", "instantsjumpcancel", false);
global.animmachturn = ini_read_real("online", "animmachturn", false);
global.oggamespeed = ini_read_real("online", "oggamespeed", true);
global.notgonnasugarcoatit = ini_read_real("online", "notgonnasugarcoatit", false);
global.showhud = true;

global.showownmsg = ini_read_real("online", "showownmsg", false);
global.infspeed = ini_read_real("online", "infspeed", false);

global.raceinvites = ini_read_real("online", "raceinvites", true);
global.webhook = ini_read_real("online", "webhook", true);

global.panicbg = ini_read_real("online", "panicbg", false); // waving background
global.panicmelt = ini_read_real("online", "panicmelt", false); // motion blur
global.panicshake = ini_read_real("online", "panicshake", true); // shaking
global.panicnightmare = ini_read_real("online", "panicnightmare", true); // panic backgrounds

global.musicvolume = ini_read_real("online", "musicvolume", 0.75);
global.soundvolume = ini_read_real("online", "soundvolume", 1);
global.mastervolume = ini_read_real("online", "mastervolume", 1);
global.machsound = ini_read_real("online", "machsound", 0);
global.musicgame = ini_read_real("online", "musicgame", 0);
global.muteuntabbed = ini_read_real("online", "muteuntabbed", 0);

global.palsel = ini_read_real("pal", "palsel", 1);
global.storenickname = "RESET"

global.useammo = ini_read_real("online", "useammo", 0);
global.usebullet = ini_read_real("online", "usebullet", 0);
global.breakdance = ini_read_real("online", "breakdance", 1);

global.sloperot = false//ini_read_real("online", "sloperot", 0);

global.blockedtpreq = ini_read_real("online", "blockedtpreq", 0);
global.newpizzy = ini_read_real("online", "newpizzy", true);
global.classiclap = ini_read_real("online", "classiclap", false);
global.fontstyle = ini_read_real("online", "fontstyle", true)

init_holiday()

// other variables
/*
global.lastroom = 0;
while room_exists(global.lastroom)
	global.lastroom++;
global.lastroom -= 1;
*/

// shit needed to be defined
global.tprequserid = -1
global.tprequsername = lang_str("load.tpreqbug") // placeholder text incase of bugs

global.leveltosave = "none"

global.texturelist = [-4, 
spr_paltex1, spr_paltex2, spr_paltex3, spr_paltex4, spr_paltex5, spr_paltex6, spr_paltex7,
spr_paltex8, spr_paltex9, spr_paltex10, spr_paltex11, spr_paltex12, spr_paltex13, spr_paltex14,
spr_paltex15, spr_paltex16, spr_paltex17, spr_paltex18, spr_paltex19, spr_paltex20, spr_paltex21
]

global.saveslot = "";
global.fun = irandom_range(0, 100);

global.chancetogetonthatprank = false;
global.lap2 = false
global.wartimer = false
global.playertexture = 0
global.minichatstore = 0
// create the shell
instance_create(0, 0, obj_shell);

// language
global.language = ini_read_string("online", "language", get_specific_lang()) // language
global.langmap = -1;
lang_load(global.language);

// window resolution
global.option_fullscreen = ini_read_real("Option", "fullscreen", false)  
global.option_resolution = ini_read_real("Option", "resolution", 1)  
window_set_fullscreen(global.option_fullscreen);

if !global.option_fullscreen
{
	switch global.option_resolution
	{
		case 0: window_set_size( 480, 270 ); break;
		case 1: window_set_size( 960, 540 ); break;
		case 2: window_set_size( 1920, 1080 ); break;
	}
}

// eggplant build loading screen
draw_flush();
var group_arr = ["tg_player", "tg_background", "tg_baddie", "tg_palette", "tg_hud", "Default"]

tex_list = ds_list_create();
tex_pos = 0;
for (var i = 0; i < array_length(group_arr); i++)
{
    var _tex_array = texturegroup_get_textures(group_arr[i]);
    ds_list_add(tex_list, _tex_array);
}
tex_max = ds_list_size(tex_list);
alarm[0] = 30;

// done
loadwhat = -1;

global.messagelist = ds_list_create()
global.messageselect = -1
global.racing = false

global.DISCORD_APP_ID = "1116754667750305972"

var choosers = [lang_str("caption.playername"), lang_str("caption.moretitles"),
lang_str("caption.locationonearth"), lang_str("caption.scoutdigoismymodem"),
lang_str("caption.playerever"), lang_str("caption.stroke"), 
lang_str("caption.thevoices"), lang_str("caption.happyhour"),
lang_str("caption.youlivehere"), lang_str("caption.peppinoinamerica"), 
lang_str("caption.apccmd"), lang_str("caption.whosptoxplus"),
lang_str("caption.marior"), lang_str("caption.antonwho"),
lang_str("caption.somelevels"), lang_str("caption.onlinemodofalltimes"),
lang_str("caption.twitter"), lang_str("caption.walterwhitelocation"),
lang_str("caption.whattheblast"), lang_str("caption.notsugarcoat"),
lang_str("caption.ismyfavourite"), lang_str("caption.backwithanothermilk"), 
lang_str("caption.likewhatthedamn"), lang_str("caption.moretitletexts"), lang_str("caption.somessedup"),
lang_str("caption.someyturl"), lang_str("caption.stillneedmoretitles"),
lang_str("caption.dramafuckyou"), lang_str("caption.mostoriginalconcept"),
lang_str("caption.banned"), lang_str("caption.purplemnm"),
(CPP_USED ? lang_str("caption.primarymonitorp1") + " " + string(ptccpp_get_primary_screen_width()) 
+ "x" + string(ptccpp_get_primary_screen_height()) + " " + lang_str("caption.primarymonitorp2")
: lang_str("caption.nomonitorguessing")),
lang_str("caption.areyoulonely"), lang_str("caption.icomikreal")
]

var extra = " - "

randomize()
if (random_range(0, 10000) <= 1)
   extra += lang_str("caption.rarechance")
else if (irandom_range(0,1))
	extra += choosers[irandom_range(0, array_length(choosers) - 1)]
else
	extra = ""

window_set_caption("Pizza Tower: Connected" + extra)

ini_close()
