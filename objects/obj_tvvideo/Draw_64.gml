if !opened
	return;
	
draw_set_alpha(0.2)
draw_set_colour(c_white)

draw_rectangle(0,0, 960, 540, false)

draw_set_alpha(1)

draw_set_font(global.bigfont)
draw_set_halign(fa_center)
draw_text(480, 10, "VIDEO PLAYER")

draw_set_font(global.font_small)
draw_text(480, 50, "Copy and paste a video URL here! (must be a direct\nlink to the video file, no youtube urls will work.)\nThis TV isn't synced for obvious reasons.\nUse Ctrl+V or Ctrl+F to pick from local files.\nSome videos are broken.")

draw_text(480, 310, (input == "" && (get_timer() / 1000000 % 1 > 0.5)) ? "_" : input)