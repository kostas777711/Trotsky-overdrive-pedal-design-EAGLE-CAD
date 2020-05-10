//POVRay-File created by 3d41.ulp v1.05
//Z:/home/kostas777711/Eagle_Projects/TROTSKY/trotsky.brd
//6/3/2012 8:51:47 PM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = on;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 163;
#local cam_z = -87;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 11;
#local lgt1_pos_y = 21;
#local lgt1_pos_z = 20;
#local lgt1_intense = 0.715994;
#local lgt2_pos_x = -11;
#local lgt2_pos_y = 21;
#local lgt2_pos_z = 20;
#local lgt2_intense = 0.715994;
#local lgt3_pos_x = 11;
#local lgt3_pos_y = 21;
#local lgt3_pos_z = -13;
#local lgt3_intense = 0.715994;
#local lgt4_pos_x = -11;
#local lgt4_pos_y = 21;
#local lgt4_pos_z = -13;
#local lgt4_intense = 0.715994;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 29.444000;
#declare pcb_y_size = 38.024000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 0;
#declare inc_testmode = off;
#declare global_seed=seed(186);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-14.722000,0,-19.012000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro TROTSKY(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,16
<0.000000,-2.540000><29.444000,-2.540000>
<29.444000,-2.540000><29.444000,35.484000>
<29.444000,35.484000><0.000000,35.484000>
<0.000000,35.484000><0.000000,-2.540000>
<14.732000,-0.762000><27.940000,-0.762000>
<27.940000,-0.762000><27.940000,1.524000>
<27.940000,1.524000><14.732000,1.524000>
<14.732000,1.524000><14.732000,-0.762000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_GAIN_POTENS_50K) #declare global_pack_GAIN_POTENS_50K=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<6.527800,0.000000,31.216600>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) GAIN_POTENS-50K  1X03
#ifndef(pack_LED) #declare global_pack_LED=yes; object {PH_1X1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<4.216400,0.000000,20.497800>}#end		//Header 2,54mm Grid 1Pin 1Row (jumper.lib) LED M01PTH 1X01
#ifndef(pack_LINE_IN) #declare global_pack_LINE_IN=yes; object {PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<18.973800,0.000000,31.394400>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) LINE_IN  1X02
#ifndef(pack_OUTPUT_POTENS_100K) #declare global_pack_OUTPUT_POTENS_100K=yes; object {PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<4.521200,0.000000,11.379200>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) OUTPUT_POTENS-100K  1X03
#ifndef(pack_POWER_9V) #declare global_pack_POWER_9V=yes; object {PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<3.987800,0.000000,27.254200>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) POWER_9V  1X02
#ifndef(pack_SW_BRIGHT_CUT) #declare global_pack_SW_BRIGHT_CUT=yes; object {PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<4.800600,0.000000,5.207000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) SW_BRIGHT_CUT  1X02
#ifndef(pack_T1) #declare global_pack_T1=yes; object {TR_TO18("2N2222",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<17.983200,0.000000,17.272000>}#end		//TO18 T1 2N2222 TO18
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<17.297400,0,24.104600> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<19.837400,0,24.104600> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<12.623800,0,17.983200> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<12.623800,0,15.443200> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<8.763000,0,14.427200> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.651000,0.700000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<8.763000,0,11.887200> texture{col_thl}}
#ifndef(global_pack_D1_1N34A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.800000,1.200000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<11.912600,0,5.105400> texture{col_thl}}
#ifndef(global_pack_D1_1N34A) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.800000,1.200000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<22.072600,0,5.105400> texture{col_thl}}
#ifndef(global_pack_D2_1N914) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.800000,1.200000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<22.072600,0,8.813800> texture{col_thl}}
#ifndef(global_pack_D2_1N914) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.800000,1.200000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<11.912600,0,8.813800> texture{col_thl}}
#ifndef(global_pack_GAIN_POTENS_50K) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<6.527800,0,31.216600> texture{col_thl}}
#ifndef(global_pack_GAIN_POTENS_50K) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<9.067800,0,31.216600> texture{col_thl}}
#ifndef(global_pack_GAIN_POTENS_50K) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<11.607800,0,31.216600> texture{col_thl}}
#ifndef(global_pack_LED) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<4.216400,0,20.497800> texture{col_thl}}
#ifndef(global_pack_LINE_IN) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<18.973800,0,31.394400> texture{col_thl}}
#ifndef(global_pack_LINE_IN) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<21.513800,0,31.394400> texture{col_thl}}
#ifndef(global_pack_OUTPUT_POTENS_100K) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<4.521200,0,11.379200> texture{col_thl}}
#ifndef(global_pack_OUTPUT_POTENS_100K) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<4.521200,0,13.919200> texture{col_thl}}
#ifndef(global_pack_OUTPUT_POTENS_100K) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<4.521200,0,16.459200> texture{col_thl}}
#ifndef(global_pack_POWER_9V) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<3.987800,0,27.254200> texture{col_thl}}
#ifndef(global_pack_POWER_9V) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<3.987800,0,24.714200> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<22.174200,0,27.533600> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.554200,0,27.533600> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<9.753600,0,19.532600> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<9.753600,0,27.152600> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<22.682200,0,11.379200> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<22.682200,0,18.999200> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<7.188200,0,19.608800> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<7.188200,0,27.228800> texture{col_thl}}
#ifndef(global_pack_SW_BRIGHT_CUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<4.800600,0,5.207000> texture{col_thl}}
#ifndef(global_pack_SW_BRIGHT_CUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<7.340600,0,5.207000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<19.253200,0,16.002000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<19.253200,0,18.542000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<16.713200,0,18.542000> texture{col_thl}}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<3.987800,0.000000,24.714200>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.064000,0.000000,24.638000>}
box{<0,0,-0.190500><0.107763,0.035000,0.190500> rotate<0,44.997030,0> translate<3.987800,0.000000,24.714200> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<3.556000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.216400,0.000000,20.497800>}
box{<0,0,-0.190500><0.683916,0.035000,0.190500> rotate<0,-15.067494,0> translate<3.556000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.521200,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.572000,0.000000,11.176000>}
box{<0,0,-0.190500><0.209454,0.035000,0.190500> rotate<0,75.958743,0> translate<4.521200,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.572000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.572000,0.000000,11.176000>}
box{<0,0,-0.190500><5.842000,0.035000,0.190500> rotate<0,90.000000,0> translate<4.572000,0.000000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.064000,0.000000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.572000,0.000000,24.638000>}
box{<0,0,-0.190500><0.508000,0.035000,0.190500> rotate<0,0.000000,0> translate<4.064000,0.000000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.572000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.800600,0.000000,5.207000>}
box{<0,0,-0.190500><0.261509,0.035000,0.190500> rotate<0,29.052687,0> translate<4.572000,0.000000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.800600,0.000000,5.207000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.826000,0.000000,5.080000>}
box{<0,0,-0.190500><0.129515,0.035000,0.190500> rotate<0,78.684874,0> translate<4.800600,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<5.588000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<5.588000,0.000000,4.572000>}
box{<0,0,-0.190500><0.508000,0.035000,0.190500> rotate<0,-90.000000,0> translate<5.588000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.826000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<5.588000,0.000000,5.080000>}
box{<0,0,-0.190500><0.762000,0.035000,0.190500> rotate<0,0.000000,0> translate<4.826000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<3.556000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.350000,0.000000,20.320000>}
box{<0,0,-0.190500><2.794000,0.035000,0.190500> rotate<0,0.000000,0> translate<3.556000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.527800,0.000000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.604000,0.000000,30.988000>}
box{<0,0,-0.190500><0.240966,0.035000,0.190500> rotate<0,71.560328,0> translate<6.527800,0.000000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<4.572000,0.000000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.731000,0.000000,22.479000>}
box{<0,0,-0.190500><3.053287,0.035000,0.190500> rotate<0,44.997030,0> translate<4.572000,0.000000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.731000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.858000,0.000000,22.606000>}
box{<0,0,-0.190500><0.179605,0.035000,0.190500> rotate<0,-44.997030,0> translate<6.731000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.858000,0.000000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.858000,0.000000,26.924000>}
box{<0,0,-0.190500><4.318000,0.035000,0.190500> rotate<0,90.000000,0> translate<6.858000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.350000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.112000,0.000000,19.558000>}
box{<0,0,-0.190500><1.077631,0.035000,0.190500> rotate<0,44.997030,0> translate<6.350000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.858000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.112000,0.000000,27.178000>}
box{<0,0,-0.190500><0.359210,0.035000,0.190500> rotate<0,-44.997030,0> translate<6.858000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.112000,0.000000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.188200,0.000000,19.608800>}
box{<0,0,-0.190500><0.091581,0.035000,0.190500> rotate<0,-33.687844,0> translate<7.112000,0.000000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.112000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.188200,0.000000,27.228800>}
box{<0,0,-0.190500><0.091581,0.035000,0.190500> rotate<0,-33.687844,0> translate<7.112000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.340600,0.000000,5.207000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.366000,0.000000,5.334000>}
box{<0,0,-0.190500><0.129515,0.035000,0.190500> rotate<0,-78.684874,0> translate<7.340600,0.000000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.366000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.366000,0.000000,10.414000>}
box{<0,0,-0.190500><5.080000,0.035000,0.190500> rotate<0,90.000000,0> translate<7.366000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<5.588000,0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.620000,0.000000,2.540000>}
box{<0,0,-0.190500><2.873682,0.035000,0.190500> rotate<0,44.997030,0> translate<5.588000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.366000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<8.636000,0.000000,11.684000>}
box{<0,0,-0.190500><1.796051,0.035000,0.190500> rotate<0,-44.997030,0> translate<7.366000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<8.636000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<8.763000,0.000000,11.887200>}
box{<0,0,-0.190500><0.239623,0.035000,0.190500> rotate<0,-57.990789,0> translate<8.636000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.067800,0.000000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.144000,0.000000,31.242000>}
box{<0,0,-0.190500><0.080322,0.035000,0.190500> rotate<0,-18.433732,0> translate<9.067800,0.000000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.731000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.652000,0.000000,19.558000>}
box{<0,0,-0.190500><4.130918,0.035000,0.190500> rotate<0,44.997030,0> translate<6.731000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<6.604000,0.000000,30.988000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.652000,0.000000,27.940000>}
box{<0,0,-0.190500><4.310523,0.035000,0.190500> rotate<0,44.997030,0> translate<6.604000,0.000000,30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.652000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.652000,0.000000,27.940000>}
box{<0,0,-0.190500><0.762000,0.035000,0.190500> rotate<0,90.000000,0> translate<9.652000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.652000,0.000000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.753600,0.000000,19.532600>}
box{<0,0,-0.190500><0.104727,0.035000,0.190500> rotate<0,14.035317,0> translate<9.652000,0.000000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.652000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.753600,0.000000,27.152600>}
box{<0,0,-0.190500><0.104727,0.035000,0.190500> rotate<0,14.035317,0> translate<9.652000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<7.620000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,2.540000>}
box{<0,0,-0.190500><3.556000,0.035000,0.190500> rotate<0,0.000000,0> translate<7.620000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,4.318000>}
box{<0,0,-0.190500><1.778000,0.035000,0.190500> rotate<0,90.000000,0> translate<11.176000,0.000000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,8.128000>}
box{<0,0,-0.190500><2.286000,0.035000,0.190500> rotate<0,90.000000,0> translate<11.176000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<9.144000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.430000,0.000000,31.242000>}
box{<0,0,-0.190500><2.286000,0.035000,0.190500> rotate<0,0.000000,0> translate<9.144000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.430000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.607800,0.000000,31.216600>}
box{<0,0,-0.190500><0.179605,0.035000,0.190500> rotate<0,8.129566,0> translate<11.430000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,4.826000>}
box{<0,0,-0.190500><0.718420,0.035000,0.190500> rotate<0,-44.997030,0> translate<11.176000,0.000000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,5.080000>}
box{<0,0,-0.190500><0.254000,0.035000,0.190500> rotate<0,90.000000,0> translate<11.684000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,8.636000>}
box{<0,0,-0.190500><0.718420,0.035000,0.190500> rotate<0,-44.997030,0> translate<11.176000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.607800,0.000000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,30.988000>}
box{<0,0,-0.190500><0.240966,0.035000,0.190500> rotate<0,71.560328,0> translate<11.607800,0.000000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,30.988000>}
box{<0,0,-0.190500><0.508000,0.035000,0.190500> rotate<0,90.000000,0> translate<11.684000,0.000000,30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.176000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.912600,0.000000,5.105400>}
box{<0,0,-0.190500><1.041710,0.035000,0.190500> rotate<0,44.997030,0> translate<11.176000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.912600,0.000000,5.105400>}
box{<0,0,-0.190500><0.230007,0.035000,0.190500> rotate<0,-6.339773,0> translate<11.684000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.912600,0.000000,8.813800>}
box{<0,0,-0.190500><0.289605,0.035000,0.190500> rotate<0,-37.872484,0> translate<11.684000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.912600,0.000000,8.813800>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.938000,0.000000,8.890000>}
box{<0,0,-0.190500><0.080322,0.035000,0.190500> rotate<0,-71.560328,0> translate<11.912600,0.000000,8.813800> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.938000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.938000,0.000000,14.732000>}
box{<0,0,-0.190500><5.842000,0.035000,0.190500> rotate<0,90.000000,0> translate<11.938000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.938000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.446000,0.000000,15.240000>}
box{<0,0,-0.190500><0.718420,0.035000,0.190500> rotate<0,-44.997030,0> translate<11.938000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.446000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.623800,0.000000,15.443200>}
box{<0,0,-0.190500><0.270006,0.035000,0.190500> rotate<0,-48.810853,0> translate<12.446000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.623800,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.700000,0.000000,18.034000>}
box{<0,0,-0.190500><0.091581,0.035000,0.190500> rotate<0,-33.687844,0> translate<12.623800,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.700000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.700000,0.000000,18.542000>}
box{<0,0,-0.190500><0.508000,0.035000,0.190500> rotate<0,90.000000,0> translate<12.700000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.478000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.478000,0.000000,27.432000>}
box{<0,0,-0.190500><7.366000,0.035000,0.190500> rotate<0,90.000000,0> translate<14.478000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<11.684000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.478000,0.000000,27.686000>}
box{<0,0,-0.190500><3.951313,0.035000,0.190500> rotate<0,44.997030,0> translate<11.684000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.478000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.554200,0.000000,27.533600>}
box{<0,0,-0.190500><0.127000,0.035000,0.190500> rotate<0,-53.126596,0> translate<14.478000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.478000,0.000000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.554200,0.000000,27.533600>}
box{<0,0,-0.190500><0.170388,0.035000,0.190500> rotate<0,63.430762,0> translate<14.478000,0.000000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<12.700000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<15.240000,0.000000,18.542000>}
box{<0,0,-0.190500><2.540000,0.035000,0.190500> rotate<0,0.000000,0> translate<12.700000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<14.478000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<15.240000,0.000000,19.304000>}
box{<0,0,-0.190500><1.077631,0.035000,0.190500> rotate<0,44.997030,0> translate<14.478000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<15.240000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<15.240000,0.000000,19.304000>}
box{<0,0,-0.190500><0.762000,0.035000,0.190500> rotate<0,90.000000,0> translate<15.240000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<15.240000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<16.713200,0.000000,18.542000>}
box{<0,0,-0.190500><1.473200,0.035000,0.190500> rotate<0,0.000000,0> translate<15.240000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<17.297400,0.000000,24.104600>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<17.526000,0.000000,24.130000>}
box{<0,0,-0.190500><0.230007,0.035000,0.190500> rotate<0,-6.339773,0> translate<17.297400,0.000000,24.104600> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.253200,0.000000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,16.002000>}
box{<0,0,-0.190500><0.050800,0.035000,0.190500> rotate<0,0.000000,0> translate<19.253200,0.000000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.253200,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,18.542000>}
box{<0,0,-0.190500><0.050800,0.035000,0.190500> rotate<0,0.000000,0> translate<19.253200,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<17.526000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,25.908000>}
box{<0,0,-0.190500><2.514472,0.035000,0.190500> rotate<0,-44.997030,0> translate<17.526000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,28.702000>}
box{<0,0,-0.190500><2.794000,0.035000,0.190500> rotate<0,90.000000,0> translate<19.304000,0.000000,28.702000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.812000,0.000000,19.050000>}
box{<0,0,-0.190500><0.718420,0.035000,0.190500> rotate<0,-44.997030,0> translate<19.304000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.812000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.812000,0.000000,23.876000>}
box{<0,0,-0.190500><4.826000,0.035000,0.190500> rotate<0,90.000000,0> translate<19.812000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.812000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.837400,0.000000,24.104600>}
box{<0,0,-0.190500><0.230007,0.035000,0.190500> rotate<0,-83.654287,0> translate<19.812000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.812000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.837400,0.000000,24.104600>}
box{<0,0,-0.190500><0.035921,0.035000,0.190500> rotate<0,44.997030,0> translate<19.812000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,28.702000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.336000,0.000000,30.734000>}
box{<0,0,-0.190500><2.873682,0.035000,0.190500> rotate<0,-44.997030,0> translate<19.304000,0.000000,28.702000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.336000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.336000,0.000000,31.242000>}
box{<0,0,-0.190500><0.508000,0.035000,0.190500> rotate<0,90.000000,0> translate<21.336000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.336000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.513800,0.000000,31.394400>}
box{<0,0,-0.190500><0.234176,0.035000,0.190500> rotate<0,-40.598615,0> translate<21.336000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.812000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.844000,0.000000,24.638000>}
box{<0,0,-0.190500><2.094538,0.035000,0.190500> rotate<0,-14.035317,0> translate<19.812000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<19.304000,0.000000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<22.098000,0.000000,18.796000>}
box{<0,0,-0.190500><3.951313,0.035000,0.190500> rotate<0,-44.997030,0> translate<19.304000,0.000000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<22.098000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<22.606000,0.000000,18.796000>}
box{<0,0,-0.190500><0.508000,0.035000,0.190500> rotate<0,0.000000,0> translate<22.098000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<22.606000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<22.682200,0.000000,18.999200>}
box{<0,0,-0.190500><0.217018,0.035000,0.190500> rotate<0,-69.439372,0> translate<22.606000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<21.844000,0.000000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<24.130000,0.000000,26.924000>}
box{<0,0,-0.190500><3.232892,0.035000,0.190500> rotate<0,-44.997030,0> translate<21.844000,0.000000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<22.174200,0.000000,27.533600>}
cylinder{<0,0,0><0,0.035000,0>0.190500 translate<24.130000,0.000000,26.924000>}
box{<0,0,-0.190500><2.048601,0.035000,0.190500> rotate<0,17.310504,0> translate<22.174200,0.000000,27.533600> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<0.000000,0.000000,-2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<29.438600,0.000000,-2.540000>}
box{<0,0,-0.317500><29.438600,0.035000,0.317500> rotate<0,0.000000,0> translate<0.000000,0.000000,-2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<0.000000,0.000000,35.483800>}
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<0.000000,0.000000,-2.540000>}
box{<0,0,-0.317500><38.023800,0.035000,0.317500> rotate<0,-90.000000,0> translate<0.000000,0.000000,-2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<0.000000,0.000000,35.483800>}
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<29.438600,0.000000,35.483800>}
box{<0,0,-0.317500><29.438600,0.035000,0.317500> rotate<0,0.000000,0> translate<0.000000,0.000000,35.483800> }
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<29.438600,0.000000,-2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.317500 translate<29.438600,0.000000,35.483800>}
box{<0,0,-0.317500><38.023800,0.035000,0.317500> rotate<0,90.000000,0> translate<29.438600,0.000000,35.483800> }
texture{col_pol}
}
#end
union{
cylinder{<17.297400,0.038000,24.104600><17.297400,-1.538000,24.104600>0.350000}
cylinder{<19.837400,0.038000,24.104600><19.837400,-1.538000,24.104600>0.350000}
cylinder{<12.623800,0.038000,17.983200><12.623800,-1.538000,17.983200>0.350000}
cylinder{<12.623800,0.038000,15.443200><12.623800,-1.538000,15.443200>0.350000}
cylinder{<8.763000,0.038000,14.427200><8.763000,-1.538000,14.427200>0.350000}
cylinder{<8.763000,0.038000,11.887200><8.763000,-1.538000,11.887200>0.350000}
cylinder{<11.912600,0.038000,5.105400><11.912600,-1.538000,5.105400>0.600000}
cylinder{<22.072600,0.038000,5.105400><22.072600,-1.538000,5.105400>0.600000}
cylinder{<22.072600,0.038000,8.813800><22.072600,-1.538000,8.813800>0.600000}
cylinder{<11.912600,0.038000,8.813800><11.912600,-1.538000,8.813800>0.600000}
cylinder{<6.527800,0.038000,31.216600><6.527800,-1.538000,31.216600>0.508000}
cylinder{<9.067800,0.038000,31.216600><9.067800,-1.538000,31.216600>0.508000}
cylinder{<11.607800,0.038000,31.216600><11.607800,-1.538000,31.216600>0.508000}
cylinder{<4.216400,0.038000,20.497800><4.216400,-1.538000,20.497800>0.508000}
cylinder{<18.973800,0.038000,31.394400><18.973800,-1.538000,31.394400>0.508000}
cylinder{<21.513800,0.038000,31.394400><21.513800,-1.538000,31.394400>0.508000}
cylinder{<4.521200,0.038000,11.379200><4.521200,-1.538000,11.379200>0.508000}
cylinder{<4.521200,0.038000,13.919200><4.521200,-1.538000,13.919200>0.508000}
cylinder{<4.521200,0.038000,16.459200><4.521200,-1.538000,16.459200>0.508000}
cylinder{<3.987800,0.038000,27.254200><3.987800,-1.538000,27.254200>0.508000}
cylinder{<3.987800,0.038000,24.714200><3.987800,-1.538000,24.714200>0.508000}
cylinder{<22.174200,0.038000,27.533600><22.174200,-1.538000,27.533600>0.450000}
cylinder{<14.554200,0.038000,27.533600><14.554200,-1.538000,27.533600>0.450000}
cylinder{<9.753600,0.038000,19.532600><9.753600,-1.538000,19.532600>0.450000}
cylinder{<9.753600,0.038000,27.152600><9.753600,-1.538000,27.152600>0.450000}
cylinder{<22.682200,0.038000,11.379200><22.682200,-1.538000,11.379200>0.450000}
cylinder{<22.682200,0.038000,18.999200><22.682200,-1.538000,18.999200>0.450000}
cylinder{<7.188200,0.038000,19.608800><7.188200,-1.538000,19.608800>0.450000}
cylinder{<7.188200,0.038000,27.228800><7.188200,-1.538000,27.228800>0.450000}
cylinder{<4.800600,0.038000,5.207000><4.800600,-1.538000,5.207000>0.508000}
cylinder{<7.340600,0.038000,5.207000><7.340600,-1.538000,5.207000>0.508000}
cylinder{<19.253200,0.038000,16.002000><19.253200,-1.538000,16.002000>0.406400}
cylinder{<19.253200,0.038000,18.542000><19.253200,-1.538000,18.542000>0.406400}
cylinder{<16.713200,0.038000,18.542000><16.713200,-1.538000,18.542000>0.406400}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.567400,0.000000,24.739600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.567400,0.000000,23.469600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<18.567400,0.000000,23.469600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.027400,0.000000,25.374600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.107400,0.000000,25.374600>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<16.027400,0.000000,25.374600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.107400,0.000000,25.374600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.107400,0.000000,22.834600>}
box{<0,0,-0.101600><2.540000,0.036000,0.101600> rotate<0,-90.000000,0> translate<21.107400,0.000000,22.834600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.107400,0.000000,22.834600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.027400,0.000000,22.834600>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<16.027400,0.000000,22.834600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.027400,0.000000,22.834600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.027400,0.000000,25.374600>}
box{<0,0,-0.101600><2.540000,0.036000,0.101600> rotate<0,90.000000,0> translate<16.027400,0.000000,25.374600> }
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.258800,0.000000,16.713200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<11.988800,0.000000,16.713200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<11.988800,0.000000,16.713200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.893800,0.000000,19.253200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.893800,0.000000,14.173200>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,-90.000000,0> translate<13.893800,0.000000,14.173200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.893800,0.000000,14.173200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<11.353800,0.000000,14.173200>}
box{<0,0,-0.101600><2.540000,0.036000,0.101600> rotate<0,0.000000,0> translate<11.353800,0.000000,14.173200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<11.353800,0.000000,14.173200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<11.353800,0.000000,19.253200>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,90.000000,0> translate<11.353800,0.000000,19.253200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<11.353800,0.000000,19.253200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.893800,0.000000,19.253200>}
box{<0,0,-0.101600><2.540000,0.036000,0.101600> rotate<0,0.000000,0> translate<11.353800,0.000000,19.253200> }
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.398000,0.000000,13.157200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.128000,0.000000,13.157200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.128000,0.000000,13.157200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.033000,0.000000,15.697200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.033000,0.000000,10.617200>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,-90.000000,0> translate<10.033000,0.000000,10.617200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.033000,0.000000,10.617200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.493000,0.000000,10.617200>}
box{<0,0,-0.101600><2.540000,0.036000,0.101600> rotate<0,0.000000,0> translate<7.493000,0.000000,10.617200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.493000,0.000000,10.617200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.493000,0.000000,15.697200>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,90.000000,0> translate<7.493000,0.000000,15.697200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.493000,0.000000,15.697200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.033000,0.000000,15.697200>}
box{<0,0,-0.101600><2.540000,0.036000,0.101600> rotate<0,0.000000,0> translate<7.493000,0.000000,15.697200> }
//D1-1N34A silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,6.375400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<18.897600,0.000000,6.375400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<18.897600,0.000000,6.375400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<18.897600,0.000000,6.375400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,6.375400>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.817600,0.000000,6.375400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,6.375400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,5.105400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<13.817600,0.000000,5.105400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,5.105400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,3.835400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<13.817600,0.000000,3.835400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,3.835400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<18.897600,0.000000,3.835400>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.817600,0.000000,3.835400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<18.897600,0.000000,3.835400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,3.835400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<18.897600,0.000000,3.835400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,3.835400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,5.105400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<20.167600,0.000000,5.105400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,5.105400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,6.375400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<20.167600,0.000000,6.375400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<18.897600,0.000000,6.375400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<18.897600,0.000000,3.835400>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,-90.000000,0> translate<18.897600,0.000000,3.835400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,5.105400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.182600,0.000000,5.105400>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.182600,0.000000,5.105400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,5.105400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.802600,0.000000,5.105400>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<20.167600,0.000000,5.105400> }
//D2-1N914 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,7.543800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<15.087600,0.000000,7.543800>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.817600,0.000000,7.543800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<15.087600,0.000000,7.543800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,7.543800>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,0.000000,0> translate<15.087600,0.000000,7.543800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,7.543800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,8.813800>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<20.167600,0.000000,8.813800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,8.813800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,10.083800>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<20.167600,0.000000,10.083800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,10.083800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<15.087600,0.000000,10.083800>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,0.000000,0> translate<15.087600,0.000000,10.083800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<15.087600,0.000000,10.083800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,10.083800>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.817600,0.000000,10.083800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,10.083800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,8.813800>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<13.817600,0.000000,8.813800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,8.813800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,7.543800>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<13.817600,0.000000,7.543800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<15.087600,0.000000,7.543800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<15.087600,0.000000,10.083800>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<15.087600,0.000000,10.083800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.167600,0.000000,8.813800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.802600,0.000000,8.813800>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<20.167600,0.000000,8.813800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.817600,0.000000,8.813800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<13.182600,0.000000,8.813800>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<13.182600,0.000000,8.813800> }
//GAIN_POTENS-50K silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.337800,0.000000,31.851600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.972800,0.000000,32.486600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<10.337800,0.000000,31.851600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.972800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.242800,0.000000,32.486600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<10.972800,0.000000,32.486600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.242800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.877800,0.000000,31.851600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<12.242800,0.000000,32.486600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.877800,0.000000,30.581600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.242800,0.000000,29.946600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<12.242800,0.000000,29.946600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.242800,0.000000,29.946600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.972800,0.000000,29.946600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<10.972800,0.000000,29.946600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.972800,0.000000,29.946600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.337800,0.000000,30.581600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<10.337800,0.000000,30.581600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.892800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162800,0.000000,32.486600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<5.892800,0.000000,32.486600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.797800,0.000000,31.851600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<7.162800,0.000000,32.486600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.797800,0.000000,30.581600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162800,0.000000,29.946600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<7.162800,0.000000,29.946600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.797800,0.000000,31.851600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.432800,0.000000,32.486600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<7.797800,0.000000,31.851600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.432800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.702800,0.000000,32.486600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.432800,0.000000,32.486600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.702800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.337800,0.000000,31.851600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<9.702800,0.000000,32.486600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.337800,0.000000,30.581600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.702800,0.000000,29.946600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<9.702800,0.000000,29.946600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.702800,0.000000,29.946600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.432800,0.000000,29.946600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.432800,0.000000,29.946600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.432800,0.000000,29.946600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.797800,0.000000,30.581600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<7.797800,0.000000,30.581600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,31.851600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,30.581600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<5.257800,0.000000,30.581600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.892800,0.000000,32.486600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,31.851600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<5.257800,0.000000,31.851600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,30.581600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.892800,0.000000,29.946600>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<5.257800,0.000000,30.581600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162800,0.000000,29.946600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.892800,0.000000,29.946600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<5.892800,0.000000,29.946600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.877800,0.000000,31.851600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<12.877800,0.000000,30.581600>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<12.877800,0.000000,30.581600> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<11.607800,0.000000,31.216600>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<9.067800,0.000000,31.216600>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<6.527800,0.000000,31.216600>}
//LED silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.486400,0.000000,21.132800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.851400,0.000000,21.767800>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<4.851400,0.000000,21.767800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.851400,0.000000,21.767800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.581400,0.000000,21.767800>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.581400,0.000000,21.767800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.581400,0.000000,21.767800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.946400,0.000000,21.132800>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<2.946400,0.000000,21.132800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.946400,0.000000,21.132800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.946400,0.000000,19.862800>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<2.946400,0.000000,19.862800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.946400,0.000000,19.862800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.581400,0.000000,19.227800>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<2.946400,0.000000,19.862800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.581400,0.000000,19.227800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.851400,0.000000,19.227800>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.581400,0.000000,19.227800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.851400,0.000000,19.227800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.486400,0.000000,19.862800>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<4.851400,0.000000,19.227800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.486400,0.000000,19.862800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.486400,0.000000,21.132800>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<5.486400,0.000000,21.132800> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<4.216400,0.000000,20.497800>}
//LINE_IN silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.338800,0.000000,32.664400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.608800,0.000000,32.664400>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<18.338800,0.000000,32.664400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.608800,0.000000,32.664400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.243800,0.000000,32.029400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<19.608800,0.000000,32.664400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.243800,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.608800,0.000000,30.124400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<19.608800,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.243800,0.000000,32.029400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.878800,0.000000,32.664400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<20.243800,0.000000,32.029400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.878800,0.000000,32.664400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.148800,0.000000,32.664400>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.878800,0.000000,32.664400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.148800,0.000000,32.664400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.783800,0.000000,32.029400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<22.148800,0.000000,32.664400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.783800,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.148800,0.000000,30.124400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<22.148800,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.148800,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.878800,0.000000,30.124400>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.878800,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.878800,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.243800,0.000000,30.759400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<20.243800,0.000000,30.759400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.703800,0.000000,32.029400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.703800,0.000000,30.759400>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<17.703800,0.000000,30.759400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.338800,0.000000,32.664400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.703800,0.000000,32.029400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<17.703800,0.000000,32.029400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.703800,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.338800,0.000000,30.124400>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<17.703800,0.000000,30.759400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.608800,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.338800,0.000000,30.124400>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<18.338800,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.783800,0.000000,32.029400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.783800,0.000000,30.759400>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<22.783800,0.000000,30.759400> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<21.513800,0.000000,31.394400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<18.973800,0.000000,31.394400>}
//OUTPUT_POTENS-100K silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,15.189200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,15.824200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<3.251200,0.000000,15.824200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,15.824200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,17.094200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.251200,0.000000,17.094200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,17.094200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,17.729200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.251200,0.000000,17.094200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,17.729200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,17.094200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<5.156200,0.000000,17.729200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,17.094200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,15.824200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<5.791200,0.000000,15.824200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,15.824200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,15.189200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<5.156200,0.000000,15.189200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,10.744200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,12.014200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.251200,0.000000,12.014200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,12.014200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,12.649200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.251200,0.000000,12.014200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,12.649200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,12.014200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<5.156200,0.000000,12.649200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,12.649200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,13.284200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<3.251200,0.000000,13.284200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,13.284200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,14.554200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<3.251200,0.000000,14.554200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,14.554200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,15.189200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.251200,0.000000,14.554200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,15.189200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,14.554200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<5.156200,0.000000,15.189200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,14.554200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,13.284200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<5.791200,0.000000,13.284200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,13.284200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,12.649200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<5.156200,0.000000,12.649200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,10.109200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,10.109200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.886200,0.000000,10.109200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.251200,0.000000,10.744200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,10.109200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<3.251200,0.000000,10.744200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,10.109200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,10.744200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<5.156200,0.000000,10.109200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,12.014200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.791200,0.000000,10.744200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<5.791200,0.000000,10.744200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.886200,0.000000,17.729200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.156200,0.000000,17.729200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.886200,0.000000,17.729200> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<4.521200,0.000000,16.459200>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<4.521200,0.000000,13.919200>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<4.521200,0.000000,11.379200>}
//POWER_9V silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,27.889200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,26.619200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<5.257800,0.000000,26.619200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,26.619200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.622800,0.000000,25.984200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<4.622800,0.000000,25.984200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.352800,0.000000,25.984200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,26.619200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<2.717800,0.000000,26.619200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.622800,0.000000,25.984200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,25.349200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<4.622800,0.000000,25.984200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,25.349200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,24.079200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<5.257800,0.000000,24.079200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,24.079200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.622800,0.000000,23.444200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<4.622800,0.000000,23.444200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.352800,0.000000,23.444200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,24.079200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<2.717800,0.000000,24.079200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,24.079200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,25.349200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<2.717800,0.000000,25.349200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,25.349200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.352800,0.000000,25.984200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<2.717800,0.000000,25.349200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.622800,0.000000,28.524200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.352800,0.000000,28.524200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.352800,0.000000,28.524200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.257800,0.000000,27.889200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.622800,0.000000,28.524200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<4.622800,0.000000,28.524200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.352800,0.000000,28.524200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,27.889200>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<2.717800,0.000000,27.889200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,26.619200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.717800,0.000000,27.889200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,90.000000,0> translate<2.717800,0.000000,27.889200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.622800,0.000000,23.444200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.352800,0.000000,23.444200>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.352800,0.000000,23.444200> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<3.987800,0.000000,24.714200>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<3.987800,0.000000,27.254200>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,26.771600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,26.771600>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.824200,0.000000,26.771600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,26.771600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,27.533600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,90.000000,0> translate<15.824200,0.000000,27.533600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,27.533600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,28.295600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,90.000000,0> translate<15.824200,0.000000,28.295600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,28.295600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,28.295600>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.824200,0.000000,28.295600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,28.295600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,27.533600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,-90.000000,0> translate<20.904200,0.000000,27.533600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,27.533600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,26.771600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,-90.000000,0> translate<20.904200,0.000000,26.771600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.824200,0.000000,27.533600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.570200,0.000000,27.533600>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.570200,0.000000,27.533600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<20.904200,0.000000,27.533600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.158200,0.000000,27.533600>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,0.000000,0> translate<20.904200,0.000000,27.533600> }
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.991600,0.000000,20.802600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.991600,0.000000,25.882600>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,90.000000,0> translate<8.991600,0.000000,25.882600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.991600,0.000000,25.882600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,25.882600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.991600,0.000000,25.882600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,25.882600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.515600,0.000000,25.882600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<9.753600,0.000000,25.882600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.515600,0.000000,25.882600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.515600,0.000000,20.802600>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,-90.000000,0> translate<10.515600,0.000000,20.802600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.515600,0.000000,20.802600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,20.802600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<9.753600,0.000000,20.802600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,20.802600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.991600,0.000000,20.802600>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<8.991600,0.000000,20.802600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,25.882600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,26.136600>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,90.000000,0> translate<9.753600,0.000000,26.136600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,20.802600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<9.753600,0.000000,20.548600>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,-90.000000,0> translate<9.753600,0.000000,20.548600> }
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.920200,0.000000,12.649200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.920200,0.000000,17.729200>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,90.000000,0> translate<21.920200,0.000000,17.729200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.920200,0.000000,17.729200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,17.729200>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.920200,0.000000,17.729200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,17.729200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.444200,0.000000,17.729200>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<22.682200,0.000000,17.729200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.444200,0.000000,17.729200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.444200,0.000000,12.649200>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,-90.000000,0> translate<23.444200,0.000000,12.649200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<23.444200,0.000000,12.649200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,12.649200>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<22.682200,0.000000,12.649200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,12.649200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.920200,0.000000,12.649200>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<21.920200,0.000000,12.649200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,17.729200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,17.983200>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,90.000000,0> translate<22.682200,0.000000,17.983200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,12.649200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.682200,0.000000,12.395200>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,-90.000000,0> translate<22.682200,0.000000,12.395200> }
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.426200,0.000000,20.878800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.426200,0.000000,25.958800>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,90.000000,0> translate<6.426200,0.000000,25.958800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.426200,0.000000,25.958800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,25.958800>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<6.426200,0.000000,25.958800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,25.958800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.950200,0.000000,25.958800>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<7.188200,0.000000,25.958800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.950200,0.000000,25.958800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.950200,0.000000,20.878800>}
box{<0,0,-0.101600><5.080000,0.036000,0.101600> rotate<0,-90.000000,0> translate<7.950200,0.000000,20.878800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.950200,0.000000,20.878800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,20.878800>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<7.188200,0.000000,20.878800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,20.878800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.426200,0.000000,20.878800>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<6.426200,0.000000,20.878800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,25.958800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,26.212800>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,90.000000,0> translate<7.188200,0.000000,26.212800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,20.878800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.188200,0.000000,20.624800>}
box{<0,0,-0.101600><0.254000,0.036000,0.101600> rotate<0,-90.000000,0> translate<7.188200,0.000000,20.624800> }
//SW_BRIGHT_CUT silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.165600,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.435600,0.000000,6.477000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.165600,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.435600,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.070600,0.000000,5.842000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<5.435600,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.070600,0.000000,4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.435600,0.000000,3.937000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<5.435600,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.070600,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.705600,0.000000,6.477000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<6.070600,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.705600,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.975600,0.000000,6.477000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<6.705600,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.975600,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.610600,0.000000,5.842000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<7.975600,0.000000,6.477000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.610600,0.000000,4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.975600,0.000000,3.937000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<7.975600,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.975600,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.705600,0.000000,3.937000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<6.705600,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.705600,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.070600,0.000000,4.572000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<6.070600,0.000000,4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.530600,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.530600,0.000000,4.572000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<3.530600,0.000000,4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.165600,0.000000,6.477000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.530600,0.000000,5.842000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,-44.997030,0> translate<3.530600,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.530600,0.000000,4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.165600,0.000000,3.937000>}
box{<0,0,-0.101600><0.898026,0.036000,0.101600> rotate<0,44.997030,0> translate<3.530600,0.000000,4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.435600,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.165600,0.000000,3.937000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,0.000000,0> translate<4.165600,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.610600,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.610600,0.000000,4.572000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<8.610600,0.000000,4.572000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<7.340600,0.000000,5.207000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<4.800600,0.000000,5.207000>}
//T1 silk screen
object{ARC(2.413000,0.050800,112.641418,157.358582,0.036000) translate<17.983200,0.000000,17.272000>}
object{ARC(2.413000,0.050800,22.641418,67.358582,0.036000) translate<17.983200,0.000000,17.272000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.491200,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.475200,0.000000,13.335000>}
box{<0,0,-0.063500><1.016000,0.036000,0.063500> rotate<0,0.000000,0> translate<17.475200,0.000000,13.335000> }
object{ARC(2.413100,0.050800,157.359496,292.640504,0.036000) translate<17.983200,0.000000,17.272100>}
object{ARC(2.413000,0.050800,292.641418,337.358582,0.036000) translate<17.983200,0.000000,17.272000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.491200,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.491200,0.000000,14.395500>}
box{<0,0,-0.063500><1.060500,0.036000,0.063500> rotate<0,90.000000,0> translate<18.491200,0.000000,14.395500> }
object{ARC(2.413000,0.050800,337.358582,382.641418,0.036000) translate<17.983200,0.000000,17.272000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.475200,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.475200,0.000000,14.395500>}
box{<0,0,-0.063500><1.060500,0.036000,0.063500> rotate<0,90.000000,0> translate<17.475200,0.000000,14.395500> }
object{ARC(2.413000,0.050800,67.358582,112.641418,0.036000) translate<17.983200,0.000000,17.272000>}
difference{
cylinder{<17.983200,0,17.272000><17.983200,0.036000,17.272000>2.984500 translate<0,0.000000,0>}
cylinder{<17.983200,-0.1,17.272000><17.983200,0.135000,17.272000>2.857500 translate<0,0.000000,0>}}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  TROTSKY(-14.722000,0,-16.472000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//C1	47n	CAP-PTH-SMALL2
//C2	100n	CAP-PTH-SMALL2
//C3	22n	CAP-PTH-SMALL2
//D1-1N34A		DIODE-1N4001
//D2-1N914		DIODE-1N4001
//R1	2.2M	AXIAL-0.3
//R2	3.3k	AXIAL-0.3
//R3	680	AXIAL-0.3
//R4	4.7k	AXIAL-0.3
