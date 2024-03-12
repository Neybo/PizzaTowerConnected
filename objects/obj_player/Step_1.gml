/// @description state
image_angle = 0;

if state == oldstate
	exit;

oldstate = state

var newgrabbing = false
var newattacking = false

var newcolorfulafter = false
var newplayermaskthing = true

var newinstakillmove = false
var newinstakillmove_pepper = false // INVERSE FUCK YOU

var newstatefunction = scr_player_normal

switch state
{
	default: break;
	case states.normal: newstatefunction = scr_player_normal; break;
	case states.revolver: newstatefunction = scr_player_revolver; break;
	case states.dynamite: newstatefunction = scr_player_dynamite; break;
	case states.grabbed: newstatefunction = scr_player_grabbed; break;
	case states.finishingblow: newstatefunction = scr_player_finishingblow; break;
	case states.tumble: 
		newstatefunction = scr_player_tumble; 
		newplayermaskthing = false
		newinstakillmove = true
		break;
	case states.titlescreen: newstatefunction = scr_player_titlescreen; break;
	case states.ejected: newstatefunction = scr_player_ejected; break;
	case states.firemouth: 
		newstatefunction = scr_player_firemouth; 
		newinstakillmove = true
		break;
	case states.fireass: 
		newstatefunction = scr_player_fireass; 
		newinstakillmove = true
		break;
	case states.transitioncutscene: newstatefunction = scr_player_transitioncutscene; break;
	case states.hookshot: 
		newstatefunction = scr_playerN_hookshot; 
		newinstakillmove = true
		newcolorfulafter = true;
		break;
	case states.slap: newstatefunction = scr_player_slap; break;
	case states.tacklecharge: 
		newstatefunction = scr_player_tacklecharge;
		newattacking = true
		newinstakillmove = true
		newcolorfulafter = true;
		break;
	case states.cheesepep: 
		newstatefunction = scr_player_cheesepep; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.cheeseball: 
		newstatefunction = scr_player_cheeseball; 
		newinstakillmove = true
		break;
	case states.cheesepepstick: newstatefunction = scr_player_cheesepepstick; break;
	case states.boxxedpep: 
		newstatefunction = scr_player_boxxedpep; 
		newattacking = true
		newplayermaskthing = false
		break;
	/* UNUSED SHIT FOR NOW
	case states.boxxedpepspin: // doesnt exist yet
		newinstakillmove = true
		newplayermaskthing = false
		break;
	case states.trashroll:
		newinstakillmove = true
		break;
	case states.trashjump:
		newinstakillmove = true
		break;
	*/
	case states.pistolaim: newstatefunction = scr_player_pistolaim; break;
	case states.climbwall: 
		newstatefunction = scr_player_climbwall; 
		newinstakillmove = true
		newcolorfulafter = true;
		break;
	case states.knightpepslopes: 
		newstatefunction = scr_player_knightpepslopes; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.portal: newstatefunction = scr_player_portal; break;
	case states.secondjump: newstatefunction = scr_player_secondjump; break;
	case states.chainsawbump: newstatefunction = scr_player_chainsawbump; break;
	case states.handstandjump: 
		newstatefunction = scr_player_handstandjump; 
		newcolorfulafter = OLD_GAMEPLAY
		break;
	case states.gottreasure: newstatefunction = scr_player_gottreasure; break;
	case states.knightpep: 
		newstatefunction = scr_player_knightpep; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.knightpepbump: 
		newstatefunction = scr_player_knightpepbump; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.knightpepattack: 
		newstatefunction = scr_player_knightpepattack; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.meteorpep: newstatefunction = scr_player_meteorpep; break;
	case states.bombpep: 
		newstatefunction = scr_player_bombpep; 
		newattacking = true
		break;
	case states.bombgrab: newstatefunction = scr_player_bombgrab; break;
	case states.bombpepside: newstatefunction = scr_player_bombpepside; break;
	case states.bombpepup: newstatefunction = scr_player_bombpepup; break;
	case states.grabbing: newstatefunction = scr_player_grabbing; break;
	//case states.chainsawpogo: newstatefunction = scr_player_chainsawpogo; break;
	//case states.shotgunjump: newstatefunction = scr_player_shotgunjump; break;
	case states.stunned: 
		newstatefunction = scr_player_stunned; 
		newplayermaskthing = false
		break;
	case states.highjump: newstatefunction = scr_player_highjump; break;
	case states.chainsaw: 
		newstatefunction = scr_player_chainsaw;
		newinstakillmove = true
		newcolorfulafter = true
		break;
	case states.facestomp: 
		newstatefunction = scr_player_facestomp; 
		newattacking = true
		break;
	case states.timesup: newstatefunction = scr_player_timesup; break;
	case states.machroll: 
		newstatefunction = scr_player_machroll; 
		newattacking = true
		newinstakillmove = true
		newplayermaskthing = false
		newcolorfulafter = true;
		break;
	case states.pistol: newstatefunction = scr_player_pistol; break;
	case states.shotgun: newstatefunction = scr_player_shotgun; break;
	case states.machfreefall: 
		newstatefunction = scr_player_machfreefall; 
		newattacking = true
		newinstakillmove = true
		break;
	case states._throw: 
		newstatefunction = scr_player_throw; 
		newgrabbing = true;
		break;
	case states.superslam: newstatefunction = scr_player_superslam; break;
	case states.slam: newstatefunction = scr_player_slam; break;
	case states.skateboard: 
		newstatefunction = scr_player_skateboard; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.grind: newstatefunction = scr_player_grind; break;
	case states.grab: newstatefunction = scr_player_grab; break;
	case states.punch: 
		newstatefunction = scr_player_punch; 
		newgrabbing = true;
		newattacking = true;
		newcolorfulafter = true
		newinstakillmove = true
		break;
	case states.backkick:	
		newstatefunction = scr_player_backkick; 
		newgrabbing = true;
		break;
	case states.uppunch: 
		newstatefunction = scr_player_uppunch; 
		newgrabbing = true;
		break;
	case states.shoulder: 
		newstatefunction = scr_player_shoulder; 
		newgrabbing = true;
		break;
	case states.backbreaker: 
		newstatefunction = scr_player_backbreaker; 
		newinstakillmove_pepper = true;
		break;
	case states.bossdefeat: newstatefunction = scr_player_bossdefeat; break;
	case states.bossintro: newstatefunction = scr_player_bossintro; break;
	case states.pizzathrow: newstatefunction = scr_player_pizzathrow; break;
	case states.gameover: newstatefunction = scr_player_gameover; break;
	case states.Sjumpland: 
		newstatefunction = scr_player_Sjumpland; 
		newinstakillmove_pepper = true;
		break;
	case states.freefallprep: newstatefunction = scr_player_freefallprep; break;
	case states.runonball: newstatefunction = scr_player_runonball; break;
	case states.boulder: newstatefunction = scr_player_boulder; break;
	case states.keyget: newstatefunction = scr_player_keyget; break;
	case states.tackle: newstatefunction = scr_player_tackle; break;
	case states.slipnslide: 
		newstatefunction = scr_player_slipnslide;
		newinstakillmove = true
		break;
	case states.ladder: newstatefunction = scr_player_ladder; break;
	case states.jump: newstatefunction = scr_player_jump; break;
	case states.victory: newstatefunction = scr_player_victory; break;
	case states.comingoutdoor: newstatefunction = scr_player_comingoutdoor; break;
	case states.Sjump: 
		newstatefunction = scr_player_Sjump; 
		newattacking = true;
		newinstakillmove = true
		newcolorfulafter = (OLD_GAMEPLAY || !global.slopebitch);
		break;
	case states.Sjumpprep: 
		newstatefunction = scr_player_Sjumpprep;
		newplayermaskthing = false
		break;
	case states.crouch: 
		newstatefunction = scr_player_crouch; 
		newplayermaskthing = false
		break;
	case states.crouchjump: 
		newstatefunction = scr_player_crouchjump; 
		newplayermaskthing = false
		break;
	case states.crouchslide: 
		newstatefunction = scr_player_crouchslide; 
		newinstakillmove = true
		newattacking = true
		newplayermaskthing = false
		break;
	case states.mach1: newstatefunction = scr_player_mach1; break;
	case states.mach2:
		newstatefunction = scr_player_mach2; 
		newattacking = true
		newinstakillmove = true
		newcolorfulafter = true;
		break;
	case states.mach3: 
		newstatefunction = scr_player_mach3; 
		newinstakillmove = true
		newattacking = true
		newcolorfulafter = true;
		break;
	case states.machslide: 
		newstatefunction = scr_player_machslide;
		newcolorfulafter = true;
		break;
	case states.bump: 
		newstatefunction = scr_player_bump; 
		newplayermaskthing = false
		break;
	case states.hurt: 
		newstatefunction = scr_player_hurt; 
		break;
	case states.freefall: 
		newstatefunction = scr_player_freefall; 
		newinstakillmove = true
		newattacking = true
		break;
	case states.freefallland: newstatefunction = scr_player_freefallland; break;
	case states.hang: newstatefunction = scr_player_hang; break;
	case states.door: newstatefunction = scr_player_door; break;
	case states.barrel: 
		newstatefunction = scr_player_barrel; 
		newinstakillmove = true
		break;
	case states.trickjump: 
		newstatefunction = scr_player_trickjump; 
		newinstakillmove = true
		break;
	case states.current: newstatefunction = scr_player_current; break;
	case states.taxi: newstatefunction = scr_player_taxi; break;
	case states.policecartaxi: newstatefunction = scr_player_taxi; break;
	case states.pogo: newstatefunction = scr_player_pogo; break;
	case states.rideweenie: 
		newstatefunction = scr_player_rideweenie; 
		newinstakillmove = true
		newcolorfulafter = true;
		break;
	case states.newweenieriding: 
		newstatefunction = scr_player_rideweenienew; 
		newinstakillmove = true
		break;
	case states.faceplant: 
		newstatefunction = scr_player_faceplant; 
		newinstakillmove = true
		break;
	case states.ghost: 
		newstatefunction = scr_player_ghost; 
		newplayermaskthing = false
		break;
	case states.mort: newstatefunction = scr_player_mort; break;
	case states.hook: newstatefunction = scr_player_hook; break;
	case states.actor: 
		newstatefunction = scr_player_actor; 
		newinstakillmove_pepper = true;
		break;
	case states.parry: newstatefunction = scr_player_parry; break;
	case states.slipbanan: 
		newstatefunction = scr_player_slipbanan; 
		newattacking = true
		newinstakillmove = true
		break;
	case states.hitlag: newstatefunction = scr_player_hitlag; break;
	case states.rotate: newstatefunction = scr_player_rotate; break;
	case states.frozen: newstatefunction = scr_player_frozen; break;
	case states.spindash: 
		newstatefunction = scr_player_spindash; 
		newinstakillmove = true
		break;
	case states.golf: newstatefunction = scr_player_golf; break;
	case states.rocket: 
		newstatefunction = scr_player_rocket; 
		newinstakillmove = true
		break;
	case states.rocketslide: newstatefunction = scr_player_rocketslide; break;
	case states.tube: newstatefunction = scr_player_tube; break;
	case states.cotton: newstatefunction = scr_player_cotton; break;
	case states.fling: newstatefunction = scr_player_fling; break;
	case states.geyser: newstatefunction = scr_player_geyser; break;
	case states.breakdance: newstatefunction = scr_player_breakdance; break;
	case states.dance: newstatefunction = scr_player_dance; break;
	case states.supersideprep: newstatefunction = scr_player_supersidejumpprep; break;
	case states.supersidejump: newstatefunction = scr_player_supersidejump; break;
	case states.kungfu:
		newstatefunction = scr_player_kungfu;
		newinstakillmove = true
		newattacking = true;
		break;
	case states.firedrill: 
		newstatefunction = scr_player_firedrill 
		newinstakillmove = true
		break;
	case states.firedrillattack:
		newstatefunction = scr_player_firedrillattack;
		newinstakillmove = true
		newattacking = true;
		break;
	case states.dogmount: 
		newstatefunction = scr_player_dogmount; 
		newinstakillmove = true;
		newattacking = true;
		break;
	case states.dogmountspin: 
		newstatefunction = scr_player_dogmountspin;
		newinstakillmove = true;
		newattacking = true;
		newcolorfulafter = true;
		break;
}

statefunction = method(undefined, newstatefunction)

newcolorfulafter &= !global.performancemode

_grabbing = newgrabbing
_attacking = newattacking

_playermaskcheck = newplayermaskthing
_colorfulafterimages = newcolorfulafter

_instakillmove = newinstakillmove
_pepperinstakillmove = newinstakillmove_pepper // INVERSE NOTE














