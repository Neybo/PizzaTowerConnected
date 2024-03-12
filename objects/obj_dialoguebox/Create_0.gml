con = -1;
size = 0;

writer = 0;
dialogue = ["No problem here."];
curdiag = 0;
rate = 1;

face = -1;
face_idx = 0;

canskip = true;
cancon = true;
playsound = true;
instant = false;

t = 0;
concon = 0;
diagsound = sfx_antonstep3;

depth = -10001;
tex_x = 0;
text_xscale = ((540 - 64) / sprite_get_width(spr_tutorialbubble)) * 1.8
text_yscale = 1.5
surfclip = -4
surffinal = -4
texture = spr_diatexture_placeholder
xplus = 0
yplus = 0
diagsnd = FMOD_EMPTY