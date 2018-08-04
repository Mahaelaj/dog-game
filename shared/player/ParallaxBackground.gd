extends ParallaxBackground

var skyColorOffset = 0;
var dayToNight = false;

const SKY = null;
const SKY_COLOR_DAY_1 = 'a9def8';
const SKY_COLOR_DAY_2 = '7f96c6';
const SKY_COLOR_NIGHT = '53525a';
const CLOUDS = null;
const STARS1 = null;
const STARS2 = null;
const STARS3 = null;

func _ready():
	
	SKY = get_node("SkyLayer/Sky").texture.gradient;
	CLOUDS = get_node("CloudsLayer/Clouds");
	STARS1 = get_node("StarsLayer/Stars1");
	STARS2 = get_node("StarsLayer/Stars2");
	STARS3 = get_node("StarsLayer/Stars3");
	
	#SKY_GRADIENT.set_offset(1, .01);
	#NIGHT_SKY_SPRITE = get_node("ParallaxBackground/SkyLayer/NightSky");
	#NIGHT_SKY_GRADIENT_SPRITE = get_node("ParallaxBackground/SkyLayer/NightSkyGradient");
	#DAY_SKY_SPRITE = get_node("ParallaxBackground/SkyLayer/DaySky");
	
	#SKY_GRADIENT.set_color(0, Color(SKY_COLOR_NIGHT))
	CLOUDS.modulate.a = 0;

func _process(delta):
	if (SKY != null): setSkyGradient()
	

func setSkyGradient():
	#var currOffset = SKY_GRADIENT.get_offset(1);
	#print(SKY_GRADIENT.get_offset(0));
	# switch the position of the sky colors if one of the sky colors fills up the entire gradient
	# this is to keep the sky changing from the top of the screen
	#if (currOffset >= 20):
	#	var tempColor = SKY_GRADIENT.get_color(0);
	#	SKY_GRADIENT.set_color(0, SKY_GRADIENT.get_color(1));
	#	SKY_GRADIENT.set_color(1, tempColor);
	#	currOffset = 0;
	#SKY_GRADIENT.set_offset(1, currOffset + 0.01);
	
	skyColorOffset += 0.001;
	if (dayToNight):
		
		# change the color of the sky to night
		if (skyColorOffset > 2 && skyColorOffset < 3): SKY.set_color(0, Color(SKY_COLOR_DAY_1).linear_interpolate(Color(SKY_COLOR_DAY_2), skyColorOffset - 2));
		if (skyColorOffset > 3 && skyColorOffset < 4): SKY.set_color(0, Color(SKY_COLOR_DAY_2).linear_interpolate(Color(SKY_COLOR_NIGHT), skyColorOffset - 3));
	
		# fade out the clouds
		if (skyColorOffset > 2.5 && skyColorOffset < 3.5): CLOUDS.modulate.a = 3.5 - skyColorOffset
		
		# fade in the stars
		if (skyColorOffset > 3.5 && skyColorOffset < 4): 
			STARS1.modulate.a = (skyColorOffset - 3.5) * 2;
			STARS2.modulate.a = (skyColorOffset - 3.5) * 2;
			STARS3.modulate.a = (skyColorOffset - 3.5) * 2;
	
	else:
		
		# twinkle stars
		if (skyColorOffset < 0.25):
			 STARS1.modulate.a = (0.25 - skyColorOffset) * 4;
		if (skyColorOffset > 0.25 && skyColorOffset < 0.5):
			 STARS1.modulate.a = 4 * (skyColorOffset - 0.25);
		if (skyColorOffset > 0.75 && skyColorOffset < 1):
			 STARS2.modulate.a = (1 - skyColorOffset) * 4;
		if (skyColorOffset > 1 && skyColorOffset < 1.25):
			 STARS2.modulate.a = 4 * (skyColorOffset - 1);
		if (skyColorOffset > 1.5 && skyColorOffset < 1.75):
			STARS3.modulate.a = (1.75 - skyColorOffset) * 4;
		if (skyColorOffset > 1.75 && skyColorOffset < 2):
			 STARS3.modulate.a = 4 * (skyColorOffset - 1.75);
				
		# fade out the stars
		if (skyColorOffset > 2 && skyColorOffset < 2.5): 
			STARS1.modulate.a = (2.5 - skyColorOffset) * 2;
			STARS2.modulate.a = (2.5 - skyColorOffset) * 2;
			STARS3.modulate.a = (2.5 - skyColorOffset) * 2;
		
		# change the color of the sky to day
		if (skyColorOffset > 2 && skyColorOffset < 3): SKY.set_color(0, Color(SKY_COLOR_NIGHT).linear_interpolate(Color(SKY_COLOR_DAY_2), skyColorOffset - 2));
		if (skyColorOffset > 3 && skyColorOffset < 4): SKY.set_color(0, Color(SKY_COLOR_DAY_2).linear_interpolate(Color(SKY_COLOR_DAY_1), skyColorOffset - 3));
		
		# fade in the clouds
		if (skyColorOffset > 2.5 && skyColorOffset < 3.5): CLOUDS.modulate.a = skyColorOffset - 2.5
	
	if (skyColorOffset >= 4):
		skyColorOffset = 0;
		dayToNight = !dayToNight
	
