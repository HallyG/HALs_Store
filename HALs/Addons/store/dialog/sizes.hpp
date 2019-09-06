#define WIDTH	(((safezoneW / safezoneH) min 1.2) / 40) // 0.0267857
#define HEIGHT	((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) //0.0357143
#define GRIDX(num) (safeZoneX+ (safeZoneW * (((WIDTH * num) - safeZoneX)/safeZoneW)))
#define GRIDY(num) (safeZoneY + (safeZoneH * (((HEIGHT * num) - safeZoneY)/safeZoneH)))
#define GRIDW(num) (num * WIDTH) //(pixelGrid * pixelW * 2)
#define GRIDH(num) (num * HEIGHT) //(pixelGrid * pixelH * 2)
#define UITXTSIZE(TXTSIZE) (0.035)//(0.03125) //pixelGrid * pixelH)
#define MAIN_WIDTH 36
#define MAIN_HEIGHT 26
#define BUFFER_Y GRIDY(1.1)
