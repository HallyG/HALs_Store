/*
	Macro: ERROR_WITH_TITLE()

	Parameters:
	0: CLASSNAME - Classname of item
	1: PRICE - Default item price
	2: STOCK - Default item stock
__________________________________________________________________*/
#define ITEM(CLASSNAME, PRICE, STOCK)\
	class CLASSNAME {\
		price = PRICE;\
		stock = STOCK;\
	};

class cfgHALsStore {
	containerTypes[] = {"LandVehicle", "Air", "Ship"};
	containerRadius = 10;
	currencySymbol = "$";
	sellFactor = 0.5;
	debug = 1;

	class categories {
		class handguns {
			displayName = "Handguns";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\handgun_ca.paa";

			#define HDG_STOCK 20
			class hgun_Pistol_Signal_F {
				price = 1337;
				stock = 1;
				description = "<t size='1' shadow='2' color='#FFB217'>yeet.</t>"
			};

			ITEM(hgun_Pistol_heavy_01_F, 300, HDG_STOCK);
			ITEM(hgun_Pistol_heavy_01_green_F, 300, HDG_STOCK);
			ITEM(hgun_ACPC2_F, 150, HDG_STOCK);
			ITEM(hgun_Pistol_01_F, 150, HDG_STOCK);
			ITEM(hgun_P07_F, 150, HDG_STOCK);
			ITEM(hgun_P07_khk_F, 150, HDG_STOCK);
			ITEM(hgun_Rook40_F, 150, HDG_STOCK);
			ITEM(hgun_Pistol_heavy_02_F, 300, HDG_STOCK);
		};
		class launchers {
			displayName = "Rocket Launchers";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";

			#define RL_STOCK 2
			ITEM(launch_RPG32_F, 3000, RL_STOCK);
			ITEM(launch_RPG32_green_F, 3000, RL_STOCK);
			ITEM(launch_RPG32_ghex_F, 3000, RL_STOCK);
			ITEM(launch_RPG7_F, 3000, 5);
			ITEM(launch_NLAW_F, 4000, RL_STOCK);
			ITEM(launch_B_Titan_F, 5000, RL_STOCK);
			ITEM(launch_I_Titan_F, 5000, RL_STOCK);
			ITEM(launch_O_Titan_F, 5000, RL_STOCK);
			ITEM(launch_O_Titan_ghex_F, 5000, RL_STOCK);
			ITEM(launch_B_Titan_tna_F, 5000, RL_STOCK);
			ITEM(launch_B_Titan_short_F, 5000, RL_STOCK);
			ITEM(launch_I_Titan_short_F, 5000, RL_STOCK);
			ITEM(launch_O_Titan_short_F, 5000, RL_STOCK);
			ITEM(launch_B_Titan_short_tna_F, 5000, RL_STOCK);
			ITEM(launch_O_Titan_short_ghex_F, 5000, RL_STOCK);
			ITEM(launch_I_Titan_eaf_F, 5000, RL_STOCK);
			ITEM(launch_B_Titan_olive_F, 5000, RL_STOCK);
			ITEM(launch_O_Vorona_brown_F, 6000, RL_STOCK);
			ITEM(launch_O_Vorona_green_F, 6000, RL_STOCK);
			ITEM(launch_MRAWS_olive_F, 5500, RL_STOCK);
			ITEM(launch_MRAWS_olive_rail_F, 5000, RL_STOCK);
			ITEM(launch_MRAWS_green_F, 5500, RL_STOCK);
			ITEM(launch_MRAWS_green_rail_F, 5000, RL_STOCK);
			ITEM(launch_MRAWS_sand_F, 5500, RL_STOCK);
			ITEM(launch_MRAWS_sand_rail_F, 5000, RL_STOCK);
		};
		class navigation {
			displayName = "Navigation";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";

			#define NN_STOCK 50
			ITEM(ItemWatch, 50, NN_STOCK);
			ITEM(ItemGPS, 100, NN_STOCK);
			ITEM(ItemMap, 75, NN_STOCK);
			ITEM(ItemCompass, 75, NN_STOCK);
			ITEM(ItemRadio, 75, NN_STOCK);
			ITEM(Binocular, 200, NN_STOCK);
			ITEM(Rangefinder, 400, NN_STOCK);
			ITEM(Laserdesignator, 750, NN_STOCK);
			ITEM(Laserdesignator_02, 750, NN_STOCK);
			ITEM(Laserdesignator_03, 750, NN_STOCK);
			ITEM(NVGoggles, 500, NN_STOCK);
			ITEM(NVGoggles_INDEP, 500, NN_STOCK);
			ITEM(NVGoggles_OPFOR, 500, NN_STOCK);
			ITEM(NVGoggles_tna_F, 500, NN_STOCK);
			ITEM(O_NVGoggles_hex_F, 500, NN_STOCK);
			ITEM(O_NVGoggles_urb_F, 500, NN_STOCK);
			ITEM(O_NVGoggles_ghex_F, 500, NN_STOCK);
			ITEM(NVGogglesB_blk_F, 3000, NN_STOCK);
			ITEM(NVGogglesB_grn_F, 3000, NN_STOCK);
			ITEM(NVGogglesB_gry_F, 3000, NN_STOCK);
			ITEM(O_NVGoggles_grn_F, 500, NN_STOCK);
		};
		class underbarrel {
			displayName = "Underbarrel Accessories";
			picture = "";

			#define UB_STOCK 10
			ITEM(bipod_02_F_arid, 75, UB_STOCK);
			ITEM(bipod_03_F_blk, 75, UB_STOCK);
			ITEM(bipod_02_F_blk, 75, UB_STOCK);
			ITEM(bipod_01_F_blk, 75, UB_STOCK);
			ITEM(bipod_02_F_hex, 75, UB_STOCK);
			ITEM(bipod_01_F_khk, 75, UB_STOCK);
			ITEM(bipod_02_F_lush, 75, UB_STOCK);
			ITEM(bipod_01_F_mtp, 75, UB_STOCK);
			ITEM(bipod_03_F_oli, 75, UB_STOCK);
			ITEM(bipod_01_F_snd, 75, UB_STOCK);
			ITEM(bipod_02_F_tan, 75, UB_STOCK);
		};
		class pointers {
			displayName = "Pointer Accessories";
			picture = "";

			#define PN_STOCK 10
			ITEM(acc_flashlight, 75, PN_STOCK);
			ITEM(acc_flashlight_smg_01, 75, PN_STOCK);
			ITEM(acc_pointer_IR, 100, PN_STOCK);
			ITEM(acc_flashlight_pistol, 75, PN_STOCK);
		};
		class smgs {
			displayName = "Submachine guns";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";

			#define SMG_STOCK 20
			ITEM(hgun_PDW2000_F, 300, SMG_STOCK);
			ITEM(SMG_05_F, 300, SMG_STOCK);
			ITEM(SMG_02_F, 300, SMG_STOCK);
			ITEM(SMG_01_F, 300, SMG_STOCK);
		};

		/*
		class muzzles {
			displayName = "Muzzle Accessories";
			picture = "";

			#define MZ_STOCK 5
			ITEM(muzzle_snds_338_black, 300, MZ_STOCK); //5
			ITEM(muzzle_snds_338_green, 300, MZ_STOCK);
			ITEM(muzzle_snds_338_sand, 300, MZ_STOCK);
			ITEM(muzzle_snds_93mmg, 300, MZ_STOCK); //4
			ITEM(muzzle_snds_93mmg_tan, 300, MZ_STOCK);
			ITEM(muzzle_snds_acp, 150, MZ_STOCK);
			ITEM(muzzle_snds_B, 200, MZ_STOCK);//3
			ITEM(muzzle_snds_B_khk_F, 200, MZ_STOCK);
			ITEM(muzzle_snds_B_snd_F, 200, MZ_STOCK);
			ITEM(muzzle_snds_H, 200, MZ_STOCK);//2
			ITEM(muzzle_snds_H_khk_F, 200, MZ_STOCK);//2
			ITEM(muzzle_snds_H_snd_F, 200, MZ_STOCK);
			ITEM(muzzle_snds_H_MG, 200, MZ_STOCK);
			ITEM(muzzle_snds_H_SW, 200, MZ_STOCK);
			ITEM(muzzle_snds_L, 200, MZ_STOCK);//1
			ITEM(muzzle_snds_M, 200, MZ_STOCK);
			ITEM(muzzle_snds_58_blk_F, 150, MZ_STOCK);//1
			ITEM(muzzle_snds_m_khk_F, 200, MZ_STOCK);
			ITEM(muzzle_snds_m_snd_F, 200, MZ_STOCK);
			ITEM(muzzle_snds_58_wdm_F, 150, MZ_STOCK);//1
			ITEM(muzzle_snds_58_ghex_F, 150, MZ_STOCK);
			ITEM(muzzle_snds_58_hex_F, 150, MZ_STOCK);
			ITEM(muzzle_snds_65_TI_blk_F, 350, MZ_STOCK); //2
			ITEM(muzzle_snds_65_TI_hex_F, 350, MZ_STOCK);
			ITEM(muzzle_snds_65_TI_ghex_F, 350, MZ_STOCK);
			ITEM(muzzle_snds_H_MG_blk_F, 200, MZ_STOCK);
			ITEM(muzzle_snds_H_MG_khk_F, 200, MZ_STOCK);
		};*/
		class optics {
			displayName = "Optics Accessories";
			picture = "";

			class optic_Hamr_khk_F {
				price = 300;
				stock = 100;
			};
			class optic_SOS_khk_F {
				price = 300;
				stock = 100;
			};
			class optic_Arco_ghex_F {
				price = 300;
				stock = 100;
			};
			class optic_Arco_blk_F {
				price = 300;
				stock = 100;
			};
			class optic_DMS_ghex_F {
				price = 300;
				stock = 100;
			};
			class optic_ERCO_blk_F {
				price = 300;
				stock = 100;
			};
			class optic_ERCO_khk_F {
				price = 300;
				stock = 100;
			};
			class optic_ERCO_snd_F {
				price = 300;
				stock = 100;
			};
			class optic_LRPS_ghex_F {
				price = 300;
				stock = 100;
			};
			class optic_LRPS_tna_F {
				price = 300;
				stock = 100;
			};
			class optic_Holosight_blk_F {
				price = 300;
				stock = 100;
			};
			class optic_Holosight_khk_F {
				price = 300;
				stock = 100;
			};
			class optic_Holosight_smg_blk_F {
				price = 300;
				stock = 100;
			};
			class optic_Holosight_smg_khk_F {
				price = 300;
				stock = 100;
			};
			class optic_Aco {
				price = 70; stock = 1;
			};
			class optic_ACO_grn {
				price = 70; stock = 1;
			};
			class optic_ACO_grn_smg {
				price = 70; stock = 1;
			};
			class optic_Aco_smg {
				price = 70; stock = 1;
			};
			class optic_AMS {
				price = 300;
				stock = 100;
			};
			class optic_AMS_khk {
				price = 300;
				stock = 100;
			};
			class optic_AMS_snd {
				price = 300;
				stock = 100;
			};
			class optic_Arco {
				price = 100;
				stock = 100;
			};
			class optic_DMS {
				price = 150;
				stock = 100;
			};
			class optic_Hamr {
				price = 200;
				stock = 100;
			};
			class optic_Holosight {
				price = 50;
				stock = 100;
			};
			class optic_Holosight_smg {
				price = 50;
				stock = 100;
			};
			class optic_KHS_blk {
				price = 300;
				stock = 100;
			};
			class optic_KHS_hex {
				price = 300;
				stock = 100;
			};
			class optic_KHS_old {
				price = 300;
				stock = 100;
			};
			class optic_KHS_tan {
				price = 300;
				stock = 100;
			};
			class optic_LRPS {
				price = 7000;
				stock = 100;
			};
			class optic_MRCO {
				price = 100;
				stock = 100;
			};
			class optic_MRD {
				price = 300;
				stock = 100;
			};
			class optic_Nightstalker {
				price = 12000;
				stock = 100;
			};
			class optic_NVS {
				price = 5000;
				stock = 100;
			};
			class optic_SOS {
				price = 200;
				stock = 100;
			};
			class optic_tws {
				price = 22000;
				stock = 100;
			};
			class optic_tws_mg {
				price = 22000;
				stock = 100;
			};
			class optic_Yorris {
				price = 300;
				stock = 100;
			};
		};
		class magazines {
			displayName = "Magazines";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";

			class 9Rnd_45ACP_Mag {
				price = 150;
				stock = 100;
			};
			class 6Rnd_45ACP_Cylinder {
				price = 150;
				stock = 100;
			};
			class 11Rnd_45ACP_Mag {
				price = 175;
				stock = 100;
			};
			class 16Rnd_9x21_Mag {
				price = 300;
				stock = 100;
			};
			class 16Rnd_9x21_red_Mag {
				price = 300;
				stock = 100;
			};
			class 16Rnd_9x21_green_Mag {
				price = 300;
				stock = 100;
			};
			class 16Rnd_9x21_yellow_Mag {
				price = 300;
				stock = 100;
			};
			class 30Rnd_9x21_Mag {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Red_Mag {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Yellow_Mag {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Green_Mag {
				price = 500;
				stock = 100;
			};
			class 10Rnd_9x21_Mag {
				price = 200;
				stock = 100;
			};
			class 30Rnd_45ACP_Mag_SMG_01 {
				price = 500;
				stock = 100;
			};
			class 30Rnd_45ACP_Mag_SMG_01_Tracer_Green {
				price = 500;
				stock = 100;
			};
			class 30Rnd_45ACP_Mag_SMG_01_Tracer_Red {
				price = 500;
				stock = 100;
			};
			class 30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Mag_SMG_02 {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Mag_SMG_02_Tracer_Red {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Mag_SMG_02_Tracer_Yellow {
				price = 500;
				stock = 100;
			};
			class 30Rnd_9x21_Mag_SMG_02_Tracer_Green {
				price = 500;
				stock = 100;
			};
			class RPG32_F {
				price = 1500;
				stock = 100;
			};
			class RPG32_HE_F {
				price = 2000;
				stock = 100;
			};
			class RPG7_F {
				price = 500;
				stock = 100;
			};
			class NLAW_F {
				price = 2500;
				stock = 100;
			};
			class Titan_AT {
				price = 3000;
				stock = 100;
			};
			class Titan_AP {
				price = 3500;
				stock = 100;
			};
			class Titan_AA {
				price = 4000;
				stock = 100;
			};
		};
		class mmgs {
			displayName = "Medium machine gun";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";

			class MMG_01_hex_F {
				price = 5000;
				stock = 20;
			};
			class MMG_01_tan_F {
				price = 5000;
				stock = 20;
			};
			class MMG_02_black_F {
				price = 3000;
				stock = 20;
			};
			class MMG_02_camo_F {
				price = 3000;
				stock = 20;
			};
			class MMG_02_sand_F {
				price = 3000;
				stock = 20;
			};
		};
	};

	class stores {
		class navigation {
			displayName = "Navigation Store";
			categories[] = {"navigation"};
		};

		class weapon {
			displayName = "Weapons Store";
			categories[] = {"handguns", "launchers", "magazines", "mmgs", "optics", "pointers", "smgs", "underbarrel"};
		};
	};
};
