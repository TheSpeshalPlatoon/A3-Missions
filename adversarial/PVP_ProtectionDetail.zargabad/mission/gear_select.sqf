//-- Default Stuff
tsp_default_uniform = "BDU_M_MarpatWD";
tsp_allowedstuff = Radios_West + Medical + Medical_Advanced + Equipment + Equipment_West + Explosives_West + Naked + Eyewear + Parachutes +
				US_Ammo + USMC_Weapons + USMC_Attach + 
				USMC_Eyewear + USMC_Headgear + USMC_Uniforms + USMC_Vests + USMC_Backpacks;

_allowedStuff_Recon = USMC_Recon_Eyewear + USMC_Recon_Headgear + USMC_Recon_Uniforms + USMC_Recon_Vests + USMC_Recon_Backpacks + USMC_Recon_Weapons + USMC_Recon_Pistols + USMC_Recon_Pistols + USMC_Recon_Attach;

_lwhMask = [
	"rhsusf_lwh_helmet_marpatd",
	"rhsusf_lwh_helmet_marpatd_ess",
	"rhsusf_lwh_helmet_marpatd_headset",
	"rhsusf_lwh_helmet_marpatwd",
	"rhsusf_lwh_helmet_marpatwd_blk_ess",
	"rhsusf_lwh_helmet_marpatwd_headset_blk2",
	"rhsusf_lwh_helmet_marpatwd_headset_blk",
	"rhsusf_lwh_helmet_marpatwd_headset",
	"rhsusf_lwh_helmet_marpatwd_ess"
];

//-- Special Stuff
switch (true) do {
	//-- Officer
	case (typeof vehicle player == "B_Officer_F"): {
		tsp_allowedstuff = tsp_allowedstuff + _allowedStuff_Recon + 
					USMC_Jet + USMC_Heli + USMC_Tank + USMC_Officer + 
					USMC_Weapons_Grenadier + USMC_Weapons_LMG + USMC_Weapons_HMG + USMC_Weapons_SMG + USMC_Weapons_Marksman + USMC_Weapons_Sniper + USMC_Weapons_Rockets + 
					USMC_Attach_MG + USMC_Attach_Sniper;
	};
	//-- UAV Operator
	case (typeof vehicle player == "B_soldier_UAV_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Recon_Headgear;
	};
	//-- Heli Pilot
	case (typeof vehicle player == "B_Helipilot_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Heli + USMC_Weapons_SMG - USMC_Headgear;
	};
	//-- Jet Pilot
	case (typeof vehicle player == "B_Pilot_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Jet - USMC_Headgear - USMC_Uniforms - USMC_Vests;	
	};
	//-- Tanker
	case (typeof vehicle player == "B_crew_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Tank;
	};
	//-- Marksman
	case (typeof vehicle player == "B_soldier_M_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_Marksman + USMC_Attach_Sniper + USMC_Recon_Headgear;
	};
	//-- Sniper
	case (typeof vehicle player == "B_sniper_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_Marksman + USMC_Weapons_Sniper + USMC_Attach_Sniper + USMC_Recon_All;	
	};
	//-- Autorifleman
	case (typeof vehicle player == "B_soldier_AR_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_LMG + USMC_Attach_MG;
	};
	//-- Heavy Gunner
	case (typeof vehicle player == "B_HeavyGunner_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_LMG + USMC_Weapons_HMG + USMC_Attach_MG + USMC_Recon_Headgear;
	};
	//-- Missile Specialist
	case (typeof vehicle player == "B_Soldier_AT_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_Rockets;
	};
	//-- Grenadier
	case (typeof vehicle player == "B_Soldier_GL_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_Grenadier;
	};
	//-- SF Scout
	case (typeof vehicle player == "B_recon_F"): {
		tsp_allowedstuff = tsp_allowedstuff + _allowedStuff_Recon - _lwhMask;
	};
	//-- SF Marksman
	case (typeof vehicle player == "B_recon_M_F"): {
		tsp_allowedstuff = tsp_allowedstuff + USMC_Weapons_Marksman + USMC_Weapons_Sniper + USMC_Attach_Sniper + _allowedStuff_Recon - _lwhMask;	
	};
	//-- SF Missile Specialist
	case (typeof vehicle player == "B_recon_LAT_F"): {
		tsp_allowedstuff = tsp_allowedstuff + _allowedStuff_Recon + USMC_Weapons_Rockets - _lwhMask;
	};
	//-- SF Autorifleman
	case (typeof vehicle player == "B_recon_JTAC_F"): {
		tsp_allowedstuff = tsp_allowedstuff + _allowedStuff_Recon + USMC_Weapons_LMG + USMC_Weapons_HMG + USMC_Attach_MG - _lwhMask;
	};
};

tsp_allowedstuff_arsenal = tsp_allowedstuff;
tsp_arsenal_distance = 100;