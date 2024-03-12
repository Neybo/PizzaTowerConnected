/// @description perform gms update

gms_self_set("x", x);
gms_self_set("y", y);

gms_self_set("room", scr_gms_room(room));

gms_self_set("xscale", xscale);
gms_self_set("yscale", yscale);

gms_self_set("nickcol", nickcol)

gms_self_set("visible", visible)
gms_self_set("spr_palette", spr_palette);
gms_self_set("texturepal", spr_texture);
gms_self_set("paletteselect", paletteselect);
gms_self_set("flash", flash);
gms_self_set("texture", global.texturelist[global.playertexture]);

gms_self_set("state", state); // pvp

gms_self_set("nickname", name_gms_empty(gms_self_name(), nickname));
gms_self_set("chat", global.__chat);

gms_self_set("visible", true);
gms_self_set("image_index", image_index);
gms_self_set("sprite_index", sprite_index);

var hook = instance_place(x, y, obj_hookup)
var hooked = (hook && state == states.ladder)
gms_self_set("hooked", hooked);
if hooked
	gms_self_set("hooky", hook.y);

gms_self_set("pizzashield", pizzashield);
gms_self_set("treasure", sprgot);
gms_self_set("cowboy", hatsprite);

if !instance_exists(baddiegrabbedID)
	baddiegrabbedID = 0;

gms_self_set("grabenemy", ((baddiegrabbedID != 0 && baddiegrabbedID != obj_null 
&& baddiegrabbedID != obj_otherplayer) ? baddiegrabbedID.sprite_index : -1));

if baddiegrabbedID != 0 && baddiegrabbedID != obj_null
{
	gms_self_set("grabenemyx", baddiegrabbedID.x);
	gms_self_set("grabenemyy", baddiegrabbedID.y);
	
	if baddiegrabbedID.object_index == obj_sausageman
		gms_self_set("grabenemycigar", baddiegrabbedID.cigar);
	else
		gms_self_set("grabenemycigar", false);
}

if global.panic
	gms_self_set("panic", 1);
else if global.snickchallenge && global.snickrematch
	gms_self_set("panic", 3);
else if global.snickchallenge
	gms_self_set("panic", 2);
else
	gms_self_set("panic", 0);

if global.panic or global.snickchallenge
{
	gms_self_set("panic_sec", global.seconds);
	gms_self_set("panic_min", global.minutes);
}

gms_self_set("pvp", global.pvp);
if global.pvp
{
	gms_self_set("pvp_hurted", hurted);
	gms_self_set("pvp_cutscene", cutscene);
	var pvpare = scr_pvparenacheck()
	gms_self_set("pvp_arena", pvpare)
	if (pvpare)
	{
		gms_self_set("pvp_kills", obj_pvparena.damagedealt)
		gms_self_set("timespent_pvp", floor(obj_pvparena.elapsedtimelasted)) // calc it yourself bitch.
	}
}

gms_self_set("petspr", petfollow > -1 ? obj_petfollow.sprite_index : petfollow);
gms_self_set("busy", online_busy);

gms_self_set("img_angle", img_angle);
if (instance_exists(obj_racemenu))
	gms_self_set("pause", 1)

/*if global.racing 
{
	var playercount = gms_session_player_count(gms_session_current_id())

	if (lastplayerracing < playercount)
	{
		scr_gms_p2p(p2p.race_info, gms_p2p_all_in_session, "cur-racing")
	}
	else if (lastplayerracing > playercount)
	{
		lastplayerracing = playercount
	}
}*/
