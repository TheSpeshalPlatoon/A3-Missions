class CfgPatches {
	class tsp_faction_civ {
		requiredAddons[] = {"UK3CB_Factions_Common_Editor","UK3CB_Factions_Equipment_Backpack","UK3CB_Factions_Equipment_Vests","UK3CB_Factions_Equipment_CW_Backpack_Soviet","UK3CB_Factions_Equipment_CW_Backpack_US","UK3CB_Factions_Equipment_CW_Soviet_Uniforms","UK3CB_Factions_Equipment_CW_SOV_Vests","UK3CB_Factions_Headgear","UK3CB_Factions_Uniforms","UK3CB_Factions_Equipment_CW_Headgear_Soviet","UK3CB_Factions_Equipment_CW_Headgear_US","UK3CB_Factions_Common","UK3CB_Factions_Equipment","UK3CB_Factions_Equipment_CW","UK3CB_Factions_Vehicles_Common","UK3CB_Factions_Vehicles_Armed_Boat","UK3CB_Factions_Vehicles_Fishing_Boat","UK3CB_Factions_Vehicles_Fishing_Vessel","UK3CB_Factions_Vehicles_Motorboat_Police","UK3CB_Factions_Vehicles_Rhib","UK3CB_Factions_Vehicles_Rubber_Rhib","UK3CB_Factions_Vehicles_Seafox","UK3CB_Factions_Vehicles_Skiff","UK3CB_Factions_Vehicles_Small_Boat","UK3CB_Factions_Vehicles_Bicycles","UK3CB_Factions_Vehicles_BRDM","UK3CB_Factions_Vehicles_BTR","UK3CB_Factions_Vehicles_BTR40","UK3CB_Factions_Vehicles_BTR60","UK3CB_Factions_Vehicles_BTR70","UK3CB_Factions_Vehicles_BTR80","UK3CB_Factions_Vehicles_Datsun","UK3CB_Factions_Vehicles_Forklift","UK3CB_Factions_Vehicles_GAZ_TIGR","UK3CB_Factions_Vehicles_Hilux","UK3CB_Factions_Vehicles_Ikarus","UK3CB_Factions_Vehicles_kraz255","UK3CB_Factions_Vehicles_Landcruiser","UK3CB_Factions_Vehicles_LandRover","UK3CB_Factions_Vehicles_M939","UK3CB_Factions_Vehicles_MaxxPro","UK3CB_Factions_Vehicles_Motorbikes","UK3CB_Factions_Vehicles_Octavia","UK3CB_Factions_Vehicles_Pickup","UK3CB_Factions_Vehicles_Quadbike","UK3CB_Factions_Vehicles_S1203","UK3CB_Factions_Vehicles_Scud","UK3CB_Factions_Vehicles_Sedan","UK3CB_Factions_Vehicles_Skoda","UK3CB_Factions_Vehicles_SUV","UK3CB_Factions_Vehicles_T810","UK3CB_Factions_Vehicles_Tractor","UK3CB_Factions_Vehicles_Transit","UK3CB_Factions_Vehicles_Typhoon","UK3CB_Factions_Vehicles_UAZ","UK3CB_Factions_Vehicles_Ural","UK3CB_Factions_Vehicles_V3S","UK3CB_Factions_Vehicles_Vodnik","UK3CB_Factions_Vehicles_Volha","UK3CB_Factions_Vehicles_VWGolf","UK3CB_Factions_Vehicles_Jeeps","UK3CB_Factions_Static_Searchlight","UK3CB_Factions_Vehicles_AC500","UK3CB_Factions_Vehicles_Antonov_An2","UK3CB_Factions_Vehicles_Bell412","UK3CB_Factions_Vehicles_C130J","UK3CB_Factions_Vehicles_C400","UK3CB_Factions_Vehicles_Cessna","UK3CB_Factions_Vehicles_DC3","UK3CB_Factions_Vehicles_MELB","UK3CB_Factions_Vehicles_Mi24","UK3CB_Factions_Vehicles_Mi8","UK3CB_Factions_Vehicles_Mig21","UK3CB_Factions_Vehicles_Mystere","UK3CB_Factions_Vehicles_Orca","UK3CB_Factions_Vehicles_Osprey","UK3CB_Factions_Vehicles_Shahed","UK3CB_Factions_Vehicles_SU25","UK3CB_Factions_Vehicles_Trojan","UK3CB_Factions_Vehicles_Shilka","UK3CB_Factions_Vehicles_AAV","UK3CB_Factions_Vehicles_BMP","UK3CB_Factions_Vehicles_LAV25","UK3CB_Factions_Vehicles_M1117","UK3CB_Factions_Vehicles_MTLB","UK3CB_Factions_Vehicles_M270","UK3CB_Factions_Vehicles_M60","UK3CB_Factions_Vehicles_Tseries","UK3CB_Factions_Vehicles_Lada","UK3CB_Factions_Vehicles_Civilian_Loadorder","UK3CB_Factions_Vehicles_Militia_LoadOrder","UK3CB_Factions_Vehicles_Military_LoadOrder","UK3CB_Factions_Vehicles_Police_LoadOrder"};
        units[] = {
            "tsp_civilian_mechanic",
            "tsp_civilian_firefighter",
            "tsp_civilian_paramedic",
            "tsp_civilian_policeman",

            "tsp_civilian_doctor",
            "tsp_civilian_teacher",
            "tsp_civilian_assistant",
            
            "tsp_civilian_pilot",

            "tsp_civilian_functionary",
            "tsp_civilian_citizen",
            "tsp_civilian_worker",
            "tsp_civilian_profiteer",
            "tsp_civilian_woodlander",
            "tsp_civilian_villager",
            "tsp_civilian_rocker",
            "tsp_civilian_priest",

            "tsp_civilian_secretary",
            "tsp_civilian_sportswoman",
            "tsp_civilian_hooker",
            "tsp_civilian_workwoman",
            "tsp_civilian_madam",
            "tsp_civilian_farmwife",
            "tsp_civilian_housewife",
            "tsp_civilian_euro",
            
            "tsp_civilian_baker",
            "tsp_civilian_ensler",
            "tsp_civilian_valentina",

            "tsp_civilian_tak1",
            "tsp_civilian_tak2",
            "tsp_civilian_tak3",
            "tsp_civilian_tak6",
            "tsp_civilian_takwoman1",
            "tsp_civilian_takwoman2",
            "tsp_civilian_takwoman3"
        };
	};
};

class CfgEditorSubCategories {
    class tsp_men_chernarus {displayName = "Men (Chernarus)";}; 
    class tsp_men_sahrani {displayName = "Men (Sahrani)";};
    class tsp_men_takistan {displayName = "Men (Takistan)";};
    class tsp_cars_chernarus {displayName = "Cars (Chernarus)";};
    class tsp_cars_sahrani {displayName = "Cars (Sahrani)";};
    class tsp_cars_takistan {displayName = "Cars (Takistan)";};
};

class CfgVehicles {
    class C_man_1;

    class tsp_civilian_secretary: C_man_1 {displayName = "Secretary"; editorSubcategory = "tsp_men_chernarus"; identitytypes[] = {"Head_Euro"}; genericNames = "RussianWomen"; nakedUniform = "clarion_female_body";};
    class tsp_civilian_sportswoman: tsp_civilian_secretary {displayName = "Sports Woman";};
    class tsp_civilian_hooker: tsp_civilian_secretary {displayName = "Hooker";};
    class tsp_civilian_workwoman: tsp_civilian_secretary {displayName = "Work Woman";};
    class tsp_civilian_madam: tsp_civilian_secretary {displayName = "Madam";};
    class tsp_civilian_farmwife: tsp_civilian_secretary {displayName = "Farm Wife";};
    class tsp_civilian_housewife: tsp_civilian_secretary {displayName = "House Wife";};
    class tsp_civilian_baker: tsp_civilian_secretary {displayName = "Baker"; editorSubcategory = "EdSubcat_Personnel_Story";};
    class tsp_civilian_ensler: tsp_civilian_baker {displayName = "Ensler";};    
    class tsp_civilian_euro: tsp_civilian_baker {displayName = "European Woman";};
    class tsp_civilian_valentina: tsp_civilian_baker {displayName = "Valentina";};
    class tsp_civilian_takwoman1: tsp_civilian_secretary {displayName = "Woman (Formal)"; editorSubcategory = "tsp_men_takistan"; genericNames = "TakistaniWomen";};
    class tsp_civilian_takwoman2: tsp_civilian_takwoman1 {displayName = "Woman";};        
    class tsp_civilian_takwoman3: tsp_civilian_takwoman1 {displayName = "Woman (Summer)";};

    class tsp_civilian_mechanic: C_man_1 {displayName = "Mechanic"; editorSubcategory = "tsp_men_chernarus"; identitytypes[] = {"LanguageRUS","Head_Euro"}; genericNames = "RussianMen";};
    class tsp_civilian_firefighter: tsp_civilian_mechanic {displayName = "Fire Fighter";};
    class tsp_civilian_paramedic: tsp_civilian_mechanic {displayName = "Paramedic";};
    class tsp_civilian_pilot: tsp_civilian_mechanic {displayName = "Pilot";};
    class tsp_civilian_functionary: tsp_civilian_mechanic {displayName = "Functionary";};
    class tsp_civilian_citizen: tsp_civilian_mechanic {displayName = "Citizen";};
    class tsp_civilian_worker: tsp_civilian_mechanic {displayName = "Worker";};
    class tsp_civilian_profiteer: tsp_civilian_mechanic {displayName = "Profiteer";};
    class tsp_civilian_woodlander: tsp_civilian_mechanic {displayName = "Woodlander";};
    class tsp_civilian_villager: tsp_civilian_mechanic {displayName = "Villager";};
    class tsp_civilian_rocker: tsp_civilian_mechanic {displayName = "Rocker";};
    class tsp_civilian_priest: tsp_civilian_mechanic {displayName = "Priest";};
    class tsp_civilian_policeman: tsp_civilian_mechanic {displayName = "Policeman";};
    class tsp_civilian_doctor: tsp_civilian_mechanic {displayName = "Doctor";};
    class tsp_civilian_teacher: tsp_civilian_mechanic {displayName = "Teacher";};
    class tsp_civilian_assistant: tsp_civilian_mechanic {displayName = "Assistant";};
    class tsp_civilian_tak1: tsp_civilian_mechanic {displayName = "Civilian"; editorSubcategory = "tsp_men_takistan"; identityTypes[] = {"LanguagePER_F","Head_TK"}; genericNames = "TakistaniMen";};
    class tsp_civilian_tak2: tsp_civilian_tak1 {displayName = "Civilian (Casual)";};
    class tsp_civilian_tak3: tsp_civilian_tak1 {displayName = "Civilian (Summer)";};
    class tsp_civilian_tak6: tsp_civilian_tak1 {displayName = "Commoner";};

    //-- Male, Sahrani
        //civilian
        //farmer
        //begger
    //-- Female, Sahrani
        //woman (farmer)
        //woman (jogger)
        //woman (worker)

//-- VEHICLES
    class UK3CB_Fishing_Boat; class UK3CB_C_Fishing_Boat: UK3CB_Fishing_Boat {crew = "C_man_sport_1_F_tanoan"; typicalCargo[] = {"C_man_sport_2_F_tanoan"}; textureList[] = {"BW",1,"GRW",1,"RW",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_C_Fishing_Boat_Smuggler: UK3CB_Fishing_Boat {crew = "C_man_sport_2_F_tanoan"; typicalCargo[] = {"C_man_sport_3_F_tanoan"}; textureList[] = {"BW",1,"GRW",1,"RW",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_Fishing_Boat_VIV_FFV; class UK3CB_C_Fishing_Boat_VIV_FFV: UK3CB_Fishing_Boat_VIV_FFV {crew = "C_man_sport_1_F_tanoan"; typicalCargo[] = {"C_man_sport_3_F_tanoan"}; textureList[] = {"BW",1,"GRW",1,"RW",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_C_Fishing_Boat_Smuggler_VIV_FFV: UK3CB_Fishing_Boat_VIV_FFV {crew = "C_man_sport_3_F_tanoan"; typicalCargo[] = {"C_man_sport_1_F_tanoan"}; textureList[] = {"BW",1,"GRW",1,"RW",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_Fishing_Vessel; class UK3CB_C_Fishing_Vessel: UK3CB_Fishing_Vessel {crew = "C_man_sport_1_F_tanoan"; typicalCargo[] = {"C_man_sport_1_F_tanoan"}; textureList[] = {"Black",1,"Blue",1,"Green",1,"Red",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_Small_Boat_Closed; class UK3CB_C_Small_Boat_Closed: UK3CB_Small_Boat_Closed {crew = "C_man_sport_1_F_tanoan"; typicalCargo[] = {"C_man_sport_2_F_tanoan"}; textureList[] = {"Blue_Blue_Stripe",1,"Blue_Green",1,"Blue_Green_Stripe",1,"Green_Blue_Stripe",1,"Green_Green_Stripe",1,"Green_Red",1,"Red",1,"Red_Blue",1,"Red_Green",1,"Red_Red_Stripe",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_Small_Boat_Open; class UK3CB_C_Small_Boat_Open: UK3CB_Small_Boat_Open {crew = "C_man_sport_2_F_tanoan"; typicalCargo[] = {"C_man_sport_3_F_tanoan"}; textureList[] = {"Blue_Blue_Stripe",1,"Blue_Green",1,"Blue_Green_Stripe",1,"Green_Blue_Stripe",1,"Green_Green_Stripe",1,"Green_Red",1,"Red",1,"Red_Blue",1,"Red_Green",1,"Red_Red_Stripe",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_Small_Boat_Wood; class UK3CB_C_Small_Boat_Wood: UK3CB_Small_Boat_Wood {crew = "C_man_sport_3_F_tanoan"; typicalCargo[] = {"C_man_sport_2_F_tanoan"}; textureList[] = {"Red",1,"Blue",1,"Green",1,"Wood",1}; editorSubcategory = "EdSubcat_Boats";};
    class UK3CB_MMT_Base; class UK3CB_C_MMT: UK3CB_MMT_Base {crew = "tsp_civilian_worker"; typicalCargo[] = {"tsp_civilian_worker"}; textureList[] = {"Black",1,"Blue",1,"DarkGreen",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_OLD_BIKE_BASE; class UK3CB_C_OLD_BIKE: UK3CB_OLD_BIKE_BASE {crew = "tsp_civilian_worker"; typicalCargo[] = {"tsp_civilian_worker"}; textureList[] = {"Black",1,"Blue",1,"DarkGreen",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Datsun_Closed; class UK3CB_C_Datsun_Closed: UK3CB_Datsun_Closed {crew = "tsp_civilian_woodlander"; typicalCargo[] = {"tsp_civilian_woodlander"}; textureList[] = {"Blue",1,"Green",1,"Green2",1,"Grey",1,"Red",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Datsun_Open; class UK3CB_C_Datsun_Open: UK3CB_Datsun_Open {crew = "tsp_civilian_woodlander"; typicalCargo[] = {"tsp_civilian_woodlander"}; textureList[] = {"Blue",1,"Green",1,"Green2",1,"Grey",1,"Red",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Forklift; class UK3CB_C_Forklift: UK3CB_Forklift {crew = "C_Man_ConstructionWorker_01_Red_F"; typicalCargo[] = {"C_Man_ConstructionWorker_01_Red_F"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "EdSubcat_Cars";};
    class UK3CB_Hilux_Ambulance; class UK3CB_C_Hilux_Ambulance: UK3CB_Hilux_Ambulance {crew = "tsp_civilian_doctor"; typicalCargo[] = {"tsp_civilian_doctor"}; textureList[] = {"AMB_02",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_C_Hilux_Ambulance_MEC: UK3CB_Hilux_Ambulance {crew = "tsp_civilian_doctor"; typicalCargo[] = {"tsp_civilian_doctor"}; textureList[] = {"MEC",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Hilux_Closed; class UK3CB_C_Hilux_Closed: UK3CB_Hilux_Closed {crew = "tsp_civilian_woodlander"; typicalCargo[] = {"tsp_civilian_woodlander"}; textureList[] = {"Blue",1,"Brown",1,"Green",1,"Green_2",1,"Light_Green",1,"Grey",1,"Orange",1,"Red",1,"Red_2",1,"White",1,"White_2",1,"White_3",1,"White_4",1,"White_3",1,"White_4",1,"Yellow",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Hilux_Open; class UK3CB_C_Hilux_Open: UK3CB_Hilux_Open {crew = "tsp_civilian_woodlander"; typicalCargo[] = {"tsp_civilian_woodlander"}; textureList[] = {"Blue",1,"Brown",1,"Green",1,"Green_2",1,"Light_Green",1,"Grey",1,"Orange",1,"Red",1,"Red_2",1,"White",1,"White_2",1,"White_3",1,"White_4",1,"White_3",1,"White_4",1,"Yellow",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Ikarus; class UK3CB_C_Ikarus: UK3CB_Ikarus {crew = "tsp_civilian_worker"; typicalCargo[] = {"tsp_civilian_worker"}; textureList[] = {"Chernarus",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_C_Ikarus_ADC: UK3CB_Ikarus {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak3"}; textureList[] = {"ADC",1,"Red",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_Ikarus_MEC: UK3CB_Ikarus {crew = "tsp_civilian_worker"; typicalCargo[] = {"tsp_civilian_worker"}; textureList[] = {"MEC",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_Ikarus_TK: UK3CB_Ikarus {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak3"}; textureList[] = {"Takistan",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_Ikarus_RED: UK3CB_Ikarus {crew = "tsp_civilian_worker"; typicalCargo[] = {"tsp_civilian_worker"}; textureList[] = {"Red",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Landcruiser; class UK3CB_C_Landcruiser: UK3CB_Landcruiser {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak2"}; textureList[] = {"BEIGE",1,"BLACK",1,"BLUE",1,"GREEN",1,"OLIVE",1,"ORANGE",1,"RED",1,"WHITE",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_LandRover_Hardtop_Civilian_Ambulance; class UK3CB_C_LandRover_Hardtop_Ambulance: UK3CB_LandRover_Hardtop_Civilian_Ambulance {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"CIV_01",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Transport_Closed; class UK3CB_C_LandRover_Softtop_Transport_Closed: UK3CB_LandRover_Softtop_Civilian_Transport_Closed {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Blue",1,"Green",1,"Olive",1,"Red",1,"Silver",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Transport_Open; class UK3CB_C_LandRover_Softtop_Transport_Open: UK3CB_LandRover_Softtop_Civilian_Transport_Open {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Blue",1,"Green",1,"Olive",1,"Red",1,"Silver",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Refuel_Closed; class UK3CB_C_LandRover_Softtop_Refuel_Closed_Port: UK3CB_LandRover_Softtop_Civilian_Refuel_Closed {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Port",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Refuel_Open; class UK3CB_C_LandRover_Softtop_Refuel_Open_Port: UK3CB_LandRover_Softtop_Civilian_Refuel_Open {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Port",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Repair_Closed; class UK3CB_C_LandRover_Softtop_Repair_Closed_Port: UK3CB_LandRover_Softtop_Civilian_Repair_Closed {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Port",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Repair_Open; class UK3CB_C_LandRover_Softtop_Repair_Open_Port: UK3CB_LandRover_Softtop_Civilian_Repair_Open {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Port",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Transport_Closed; class UK3CB_C_LandRover_Softtop_Transport_Closed_Port: UK3CB_LandRover_Softtop_Civilian_Transport_Closed {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Port",1};}; 
    class UK3CB_LandRover_Softtop_Civilian_Transport_Open; class UK3CB_C_LandRover_Softtop_Transport_Open_Port: UK3CB_LandRover_Softtop_Civilian_Transport_Open {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Port",1};}; 
    class UK3CB_C_LandRover_Softtop_Transport_Closed; class UK3CB_C_LandRover_Closed: UK3CB_C_LandRover_Softtop_Transport_Closed {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Blue",1,"Green",1,"Olive",1,"Red",1,"Silver",1};}; 
    class UK3CB_C_LandRover_Softtop_Transport_Open; class UK3CB_C_LandRover_Open: UK3CB_C_LandRover_Softtop_Transport_Open {editorSubcategory = "tsp_cars_takistan"; crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_tka_rifleman"}; textureList[] = {"Blue",1,"Green",1,"Olive",1,"Red",1,"Silver",1};}; 
    class UK3CB_YAVA; class UK3CB_C_YAVA: UK3CB_YAVA {crew = "tsp_civilian_villager"; typicalCargo[] = {"tsp_civilian_villager"}; textureList[] = {"White",1,"Blue",1,"Red",1,"Green",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_C_YAVA_TAK: UK3CB_YAVA {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak2"}; textureList[] = {"White",1,"Blue",1,"Red",1,"Green",1,"Decorated",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_YAVA_APD: UK3CB_YAVA {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak2"}; textureList[] = {"APD",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_TT650; class UK3CB_C_TT650: UK3CB_TT650 {crew = "tsp_civilian_woodlander"; typicalCargo[] = {"tsp_civilian_woodlander"}; textureList[] = {"Red_White",1,"Blue_White",1,"Green_White",1,"Yellow_White",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_C_TT650_TAK: UK3CB_TT650 {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak2"}; textureList[] = {"Rusted",1,"Red_White",1,"Blue_White",1,"Green_White",1,"Yellow_White",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Octavia; class UK3CB_C_Octavia: UK3CB_Octavia {crew = "tsp_civilian_citizen"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"Black",1,"Blue",1,"DarkBlue",1,"DarkGrey",1,"Green",1,"Grey",1,"Mauve",1,"Red",1,"Turquoise",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Pickup_Unarmed; class UK3CB_C_Pickup: UK3CB_Pickup_Unarmed {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak2"}; textureList[] = {"BLACK",1,"BLUE",1,"GREEN",1,"GREY",1,"GREY_STRIPE",1,"RED",1,"WHITE",1,"WHITE_STRIPE",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_Pickup_ADC: UK3CB_Pickup_Unarmed {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak2"}; textureList[] = {"AD",1,"AD_STRIPE",1,"BLACK",1,"BLUE",1,"GREEN",1,"GREY",1,"GREY_STRIPE",1,"RED",1,"WHITE",1,"WHITE_STRIPE",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_S1203; class UK3CB_C_S1203: UK3CB_S1203 {crew = "tsp_civilian_rocker"; typicalCargo[] = {"tsp_civilian_rocker"}; textureList[] = {"Blue",1,"Green",1,"Orange",1,"Red",1,"Silver",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_S1203_Ambulance; class UK3CB_C_S1203_Ambulance: UK3CB_S1203_Ambulance {crew = "tsp_civilian_doctor"; typicalCargo[] = {"tsp_civilian_assistant"}; textureList[] = {"Chernarus",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_C_S1203_Ambulance_MEC: UK3CB_S1203_Ambulance {crew = "tsp_civilian_doctor"; typicalCargo[] = {"tsp_civilian_assistant"}; textureList[] = {"MEC",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_S1203_Ambulance_TK: UK3CB_S1203_Ambulance {crew = "tsp_civilian_doctor"; typicalCargo[] = {"tsp_civilian_assistant"}; textureList[] = {"Takistan",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_S1203_Police; class UK3CB_C_S1203_Police_CPD: UK3CB_S1203_Police {crew = "tsp_civilian_policeman"; typicalCargo[] = {"tsp_civilian_policeman"}; textureList[] = {"CPD",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Sedan; class UK3CB_C_Sedan: UK3CB_Sedan {crew = "C_Man_1"; typicalCargo[] = {"C_Man_1"}; textureList[] = {"Blue",1,"Red",1,"White",1,"Yellow",1}; editorSubcategory = "tsp_cars_sahrani";};
    class UK3CB_Hatchback; class UK3CB_C_Hatchback: UK3CB_Hatchback {crew = "C_Man_1"; typicalCargo[] = {"C_Man_1"}; textureList[] = {"Blue",1,"Green",1,"Yellow",1}; editorSubcategory = "tsp_cars_sahrani";};
    class UK3CB_Skoda; class UK3CB_C_Skoda: UK3CB_Skoda {crew = "C_Man_1"; typicalCargo[] = {"C_Man_1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"White",1}; editorSubcategory = "tsp_cars_sahrani";};
    class UK3CB_SUV; class UK3CB_C_SUV: UK3CB_SUV {crew = "C_Man_formal_4_F"; typicalCargo[] = {"C_Man_formal_2_F"}; textureList[] = {"Black",1,"Black_White",1,"Blue",1,"Blue_White",1,"Green",1,"Green_White",1,"Purple",1,"Purple_White",1,"Red",1,"Red_White",1,"Tan",1,"Tan_White",1,"White",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_SUV_Armoured_Base; class UK3CB_C_SUV_Armoured: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_2_F"; typicalCargo[] = {"C_Man_formal_4_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_AAF: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_1_F"; typicalCargo[] = {"C_Man_formal_1_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_AFG: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_4_F"; typicalCargo[] = {"C_Man_formal_2_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_CSAT: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_2_F"; typicalCargo[] = {"C_Man_formal_4_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_MEC: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_4_F"; typicalCargo[] = {"C_Man_formal_1_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_NATO: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_4_F"; typicalCargo[] = {"C_Man_formal_2_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_RUS: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_1_F"; typicalCargo[] = {"C_Man_formal_1_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_UK: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_2_F"; typicalCargo[] = {"C_Man_formal_2_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_US: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_1_F"; typicalCargo[] = {"C_Man_formal_4_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_SUV_Armoured_UN: UK3CB_SUV_Armoured_Base {crew = "C_Man_formal_4_F"; typicalCargo[] = {"C_Man_formal_4_F"}; textureList[] = {"Black",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Tractor_Old; class UK3CB_C_Tractor_Old: UK3CB_Tractor_Old {crew = "C_Man_1"; typicalCargo[] = {"C_Man_1"}; textureList[] = {"Blue",1,"Green",1,"Red",1}; editorSubcategory = "tsp_cars_sahrani";};
    class UK3CB_Tractor; class UK3CB_C_Tractor: UK3CB_Tractor {crew = "tsp_civilian_worker"; typicalCargo[] = {"tsp_civilian_worker"}; textureList[] = {"Red",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Van_Transit_Medevac_Base; class UK3CB_C_Van_Transit_Medevac_MEC: UK3CB_Van_Transit_Medevac_Base {crew = "C_Man_1"; typicalCargo[] = {"C_Man_1"}; textureList[] = {"MEC",1}; editorSubcategory = "EdSubcat_Cars";};
    class UK3CB_UAZ_Closed_Base; class UK3CB_C_UAZ_Closed: UK3CB_UAZ_Closed_Base {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Cream",1,"Dark_Green",1,"Green",1,"Khaki",1,"Red",1,"White",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_UAZ_Open_Base; class UK3CB_C_UAZ_Open: UK3CB_UAZ_Open_Base {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Cream",1,"Dark_Green",1,"Green",1,"Khaki",1,"Red",1,"White",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Ammo; class UK3CB_C_Ural_Ammo: UK3CB_Ural_Ammo {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Empty; class UK3CB_C_Ural_Empty: UK3CB_Ural_Empty {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Recovery; class UK3CB_C_Ural_Recovery: UK3CB_Ural_Recovery {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Repair; class UK3CB_C_Ural_Repair: UK3CB_Ural_Repair {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Covered; class UK3CB_C_Ural_Covered: UK3CB_Ural_Covered {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Open; class UK3CB_C_Ural_Open: UK3CB_Ural_Open {crew = "tsp_civilian_tak2"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Ural_Fuel; class UK3CB_C_Ural_Fuel: UK3CB_Ural_Fuel {crew = "tsp_civilian_tak3"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Blue_Red",1,"Khaki",1,"Tan",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_V3S_Closed; class UK3CB_C_V3S_Closed: UK3CB_V3S_Closed {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_V3S_Open; class UK3CB_C_V3S_Open: UK3CB_V3S_Open {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_V3S_Recovery; class UK3CB_C_V3S_Recovery: UK3CB_V3S_Recovery {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_V3S_Refuel; class UK3CB_C_V3S_Refuel: UK3CB_V3S_Refuel {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_V3S_Repair; class UK3CB_C_V3S_Repair: UK3CB_V3S_Repair {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_V3S_Reammo; class UK3CB_C_V3S_Reammo: UK3CB_V3S_Reammo {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Blue",1,"Green",1,"Red",1,"Yellow",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Gaz24; class UK3CB_C_Gaz24: UK3CB_Gaz24 {crew = "tsp_civilian_citizen"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"Black",1,"Blue",1,"Grey",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Golf; class UK3CB_C_Golf: UK3CB_Golf {crew = "tsp_civilian_profiteer"; typicalCargo[] = {"tsp_civilian_profiteer"}; textureList[] = {"Black",1,"Blue",1,"Green",1,"Red",1,"White",1,"Yellow",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_AC500_Base; class UK3CB_C_AC500: UK3CB_AC500_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"CIV_1",1,"CIV_2",1,"CIV_3",1,"CIV_4",1,"CIV_5",1,"CIV_6",1,"CIV_7",1,"CIV_8",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_Antonov_An2; class UK3CB_C_Antonov_An2: UK3CB_Antonov_An2 {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"BLACK",1,"Black_White",1,"BLUE",1,"BLUE_STRIPE",1,"BLUE_WHITE",1,"BLUE_YELLOW",1,"LIGHT_GREEN",1,"GREEN",1,"GREEN_STRIPE",1,"GREEN_YELLOW",1,"ORANGE",1,"ORANGE_STRIPE",1,"ORANGE_WHITE",1,"RED",1,"RED_STRIPE",1,"RED_WHITE",1,"RED_YELLOW",1,"YELLOW",1,"YELLOW_STRIPE",1,"YELLOW_WHITE",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_C_Antonov_An2_ADC: UK3CB_Antonov_An2 {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"ADC",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_C_Antonov_An2_CH: UK3CB_Antonov_An2 {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"CHERNARUS_AIR",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_C_Antonov_An2_TK: UK3CB_Antonov_An2 {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"TAK_AIR",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_Cessna_172_Base; class UK3CB_C_Cessna_172: UK3CB_Cessna_172_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"Skin_01",1,"Skin_02",1,"Skin_03",1,"Skin_04",1,"Skin_05",1,"Skin_06",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_DC3_Base; class UK3CB_C_DC3: UK3CB_DC3_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"CIV_01",1,"CIV_02",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_C_DC3_CH: UK3CB_DC3_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"CIV_03",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_C_DC3_TKC: UK3CB_DC3_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"CIV_04",1}; editorSubcategory = "EdSubcat_Planes";};
    class UK3CB_Mi8AMT; class UK3CB_C_Mi8AMT: UK3CB_Mi8AMT {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"CIV_AIR",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_C_Mi8AMT_ADC: UK3CB_Mi8AMT {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"ADC",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_C_Mi8AMT_TK: UK3CB_Mi8AMT {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"TAK_AIR",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_Lada; class UK3CB_C_Lada: UK3CB_Lada {crew = "tsp_civilian_citizen"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"Green",1,"Red",1,"White",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_C_Lada_TK: UK3CB_Lada {crew = "tsp_civilian_tak1"; typicalCargo[] = {"tsp_civilian_tak1"}; textureList[] = {"Green",1,"Red",1,"Takistan",1,"Takistan_Green",1,"Takistan_Red",1,"Takistan_White",1,"White",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_C_Lada_Taxi_TK: UK3CB_Lada {crew = "tsp_civilian_citizen"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"Takistan_Taxi",1}; editorSubcategory = "tsp_cars_takistan";};
    class UK3CB_Lada_Police; class UK3CB_C_Lada_Police: UK3CB_Lada_Police {crew = "tsp_civilian_policeman"; typicalCargo[] = {"tsp_civilian_policeman"}; textureList[] = {"CPD",1}; editorSubcategory = "tsp_cars_chernarus";};
    class UK3CB_Bell412_Medic_base; class UK3CB_C_Bell412_Medic: UK3CB_Bell412_Medic_base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_assistant"}; textureList[] = {"SAR_01",1,"SAR_02",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_C_Bell412_Medic_IDAP: UK3CB_Bell412_Medic_base {crew = "C_IDAP_Pilot_01_F"; typicalCargo[] = {"C_IDAP_Man_AidWorker_07_F"}; textureList[] = {"IDAP",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_Bell412_Luxury_Base; class UK3CB_C_Bell412_Luxury: UK3CB_Bell412_Luxury_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"C_Man_formal_1_F"}; textureList[] = {"Vrana",1,"BlackWhite",1,"Luxury",1,"Shark",1,"Bluelines",1,"Blue",1,"Redlines",1,"Red",1,"Parrot",1,"Frostfire",1,"Flamingo",1,"Twilight",1,"Sun",1,"Wasp",1,"Wave",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_C_Bell412_Luxury_IDAP: UK3CB_Bell412_Luxury_Base {crew = "C_IDAP_Pilot_01_F"; typicalCargo[] = {"C_IDAP_Man_AidWorker_07_F"}; textureList[] = {"IDAP",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_Bell412_Civ_Base; class UK3CB_C_Bell412_Civ: UK3CB_Bell412_Civ_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"BlackWhite",1,"Blue",1,"Bluelines",1,"Flamingo",1,"Frostfire",1,"Parrot",1,"Red",1,"Redlines",1,"Shark",1,"Sun",1,"Twilight",1,"Vrana",1,"Wasp",1,"Wave",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_C_Bell412_Civ_IDAP: UK3CB_Bell412_Civ_Base {crew = "C_IDAP_Pilot_01_F"; typicalCargo[] = {"C_IDAP_Man_AidWorker_07_F"}; textureList[] = {"IDAP",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_Bell412_FLIR_Base; class UK3CB_C_Bell412_FLIR_IDAP: UK3CB_Bell412_FLIR_Base {crew = "C_IDAP_Pilot_01_F"; typicalCargo[] = {"C_IDAP_Man_AidWorker_07_F"}; textureList[] = {"IDAP",1}; editorSubcategory = "EdSubcat_Helicopters";};
    class UK3CB_C400_Base; class UK3CB_C_C400: UK3CB_C400_Base {crew = "tsp_civilian_pilot"; typicalCargo[] = {"tsp_civilian_citizen"}; textureList[] = {"BLUE",1,"GREEN",1,"GREY",1,"RED",1}; editorSubcategory = "EdSubcat_Planes";};
};

class CfgLoadouts {  //-- QT allows for using #definitions within a string
    #define QT " 

    tsp_civilian_mechanic = QT _n=((round random 4)+1);[[],[],[],['UK3CB_CHC_C_U_Overall_0'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_firefighter = QT QT;
    tsp_civilian_paramedic = QT QT;    
    tsp_civilian_policeman = QT[[],[],['rhs_weap_makarov_pm','','','',['rhs_mag_9x18_8_57N181S',8],[],''],['a2_policeman',[['ACRE_BF888S',1],['FirstAidKit',1]]],['rhs_vest_pistol_holster',[['rhs_mag_9x18_8_57N181S',2,8]]],[],'UK3CB_H_Police_Cap','',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    
    tsp_civilian_doctor = QT[[],[],[],['UK3CB_CHC_C_U_DOC_01',[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_teacher = QT[[],[],[],['UK3CB_CHC_C_U_DOC_02',[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_assistant = QT[[],[],[],['UK3CB_CHC_C_U_DOC_03',[]],[],[],'','',[],['','','','','','']]QT;

    tsp_civilian_pilot = QT[[],[],[],['a2_pilot',[]],[],[],'','',[],['','','','','','']]QT;
    
    tsp_civilian_functionary = QT[[],[],[],[selectRandom['U_C_FormalSuit_01_black_F','U_C_FormalSuit_01_blue_F','U_C_FormalSuit_01_gray_F','U_C_FormalSuit_01_khaki_F','U_C_FormalSuit_01_tshirt_black_F','U_C_FormalSuit_01_tshirt_gray_F'],[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_citizen = QT _n=((round random 4)+1);[[],[],[],['UK3CB_CHC_C_U_CIT_0'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_worker = QT _n=((round random 3)+1);[[],[],[],['UK3CB_CHC_C_U_WORK_0'+(str _n),[]],[],[],'UK3CB_H_Worker_Cap_0'+(str _n),'',[],['','','','','','']]QT;
    tsp_civilian_profiteer = QT _n=((round random 3)+1);[[],[],[],['UK3CB_CHC_C_U_PROF_0'+(str _n),[]],[],[],'UK3CB_H_Profiteer_Cap_0'+(str _n),'',[],['','','','','','']]QT;
    tsp_civilian_woodlander = QT _n=((round random 3)+1);[[],[],[],['UK3CB_CHC_C_U_WOOD_0'+(str _n),[]],[],[],'UK3CB_H_Ushanka_Cap_0'+(str _n),'',[],['','','','','','']]QT;
    tsp_civilian_villager = QT _n=((round random 3)+1);[[],[],[],['UK3CB_CHC_C_U_VILL_0'+(str _n),[]],[],[],'UK3CB_H_Villager_Cap_0'+(str _n),'',[],['','','','','','']]QT;
    tsp_civilian_rocker = QT _n=((round random 3)+1);[[],[],[],['a2_rocker_'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_priest = QT[[],[],[],['UK3CB_CHC_C_U_PRIEST_01',[]],[],[],'','',[],['','','','','','']]QT;

    tsp_civilian_secretary = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_secretary'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_secretary'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_sportswoman = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_sportswoman'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_sportswoman'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_hooker = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_hooker'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_hooker'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_workwoman = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_workwoman'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_workwoman'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_madam = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_madam'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_madam'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_farmwife = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_farmwife'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_farmwife'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_housewife = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,('a2_head_housewife'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_housewife'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_euro = QT _n=((round random 1)+1);[_this, _n] spawn {[_this#0,('a2_head_euro'+(str (_this#1)))] remoteExec ['setFace',0]};[[],[],[],['a2_euro'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;

    tsp_civilian_baker = QT[_this] spawn {[_this#0,'a2_head_baker'] remoteExec ['setFace',0]};[[],[],[],['a2_baker',[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_ensler = QT[_this] spawn {[_this#0,'a2_head_ensler'] remoteExec ['setFace',0]};[[],[],[],['a2_ensler',[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_valentina = QT[_this] spawn {[_this#0,'a2_head_valentina'] remoteExec ['setFace',0]};[[],[],[],['a2_valentina',[]],[],[],'','',[],['','','','','','']]QT;   

    #define HEAD_CIV 'UK3CB_TKC_H_Turban_0'+str ((round random 5)+1)+'_'+str ((round random 4)+1)
    #define HEAD_MIL 'UK3CB_TKM_B_H_Turban_0'+str ((round random 5)+1)+'_'+str ((round random 2)+1)
    #define HEAD selectRandom[HEAD_CIV,HEAD_MIL]
    tsp_civilian_tak1 = QT _n=((round random 4)+1);[[],[],[],['a2_tak1_'+(str _n),[]],[],[],HEAD,'',[],['','','','','','']]QT;
    tsp_civilian_tak2 = QT _n=((round random 4)+1);[[],[],[],['a2_tak2_'+(str _n),[]],[],[],HEAD,'',[],['','','','','','']]QT;
    tsp_civilian_tak3 = QT _n=((round random 4)+1);[[],[],[],['a2_tak3_'+(str _n),[]],[],[],HEAD,'',[],['','','','','','']]QT;
    tsp_civilian_tak6 = QT _n=((round random 4)+1);[[],[],[],['a2_tak6_'+(str _n),[]],[],[],HEAD,'',[],['','','','','','']]QT;

    tsp_civilian_takwoman1 = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,'a2_head_sportswoman'+(str (_this#1))] remoteExec ['setFace',0]};[[],[],[],['a2_takwoman1_'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_takwoman2 = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,'a2_head_sportswoman'+(str (_this#1))] remoteExec ['setFace',0]};[[],[],[],['a2_takwoman2_'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    tsp_civilian_takwoman3 = QT _n=((round random 4)+1);[_this, _n] spawn {[_this#0,'a2_head_sportswoman'+(str (_this#1))] remoteExec ['setFace',0]};[[],[],[],['a2_takwoman3_'+(str _n),[]],[],[],'','',[],['','','','','','']]QT;
    
    #define ITEMS ['tsp_ifak',1],['ACE_EarPlugs',1],['ACE_Cellphone',1],['ACRE_BF888S',1],['acex_intelitems_notepad',1,1],['Chemlight_green',2,1]
    #define UNIFORMS selectRandom['U_C_Journalist']
    C_journalist_F = QT[[],[],[],[UNIFORMS,[]],['V_Press_F',[ITEMS]],[],'H_Cap_press','',['Nikon_DSLR','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    C_Journalist_01_War_F = QT[[],[],['Bro_Camcorder','','','',[],[],''],[UNIFORMS,[['H_Cap_press',1]]],['V_Press_F',[ITEMS]],[],'rhsgref_helmet_pasgt_press','',['Hate_Smartphone','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
};