class CfgPatches {
    class tsp_core {requiredAddons[] = {"cba_common"}; units[] = {"tsp_WeaponHolderSimulated"};};
    class tsp_earplug {requiredAddons[] = {}; units[] = {};};
    class tsp_crash {requiredAddons[] = {}; units[] = {};};
    class tsp_flare {requiredAddons[] = {"A3_Weapons_F"}; units[] = {}; ammo[] = {"FlareBase", "F_40mm_White", "Flare_82mm_AMOS_White", "Sh_155mm_AMOS"};};
    class tsp_ragdoll {requiredAddons[] = {}; units[] = {};};
    //class tsp_immerse {requiredAddons[] = {}; units[] = {};};
	class tsp_faction {requiredAddons[] = {}; units[] = {};};
};

#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "scripts\chvd.hpp"
#include "scripts\gui.hpp"

class Extended_PreInit_EventHandlers {class tsp_core {init = "[] call compileScript ['\tsp_core\initFramework.sqf']";};};
class CfgFunctions {class A3 {class effects {file = "tsp_core\crash";};};};  //-- Remove fn_effectKilled so that RHS helis work

class CfgVehicles {  //-- Weapon holder that doesn't act as shield, used by throw func, animate sling
    class WeaponHolderSimulated;
    class tsp_WeaponHolderSimulated: WeaponHolderSimulated {model = "tsp_core\data\holder.p3d";};
};

class CfgAmmo {
    class FlareCore;
    class FlareBase: FlareCore {timeToLive = 999;};
    class F_40mm_White: FlareBase {timeToLive = 999;};
    class Flare_82mm_AMOS_White: FlareCore {timeToLive = 999;};
};

class CfgMovesBasic {
    class default;
    class DefaultDie;
    class ManActions {
        tsp_common_stop[] = {"tsp_common_stop","Gesture"};
        tsp_common_stop_instant[] = {"tsp_common_stop","Gesture"};
        tsp_common_stop_right[] = {"tsp_common_stop_right","Gesture"};	
        tsp_common_stop_left[] = {"tsp_common_stop_left","Gesture"};
    };
};
class CfgGesturesMale {
    skeletonName = "OFP2_ManSkeleton";
    class Default {};
    class States {
        class GestureNo;		
        class tsp_common_stop: GestureNo {
            mask = "empty";
            interpolationSpeed = 5;
            showHandGun = 0;
            rightHandIKCurve[] = {1}; 
            leftHandIKCurve[] = {1};
            canPullTrigger = true;
            enableBinocular = true;
            enableMissile = true;
            enableOptics = true;
            disableWeapons = false;
        };	
        class tsp_common_stop_instant: tsp_common_stop {interpolationSpeed = 99999; speed = 99999; showHandGun = 1;};	
        class tsp_common_stop_right: tsp_common_stop {rightHandIKCurve[] = {0,0,0.5,1}; leftHandIKCurve[] = {1};};	
        class tsp_common_stop_left: tsp_common_stop {rightHandIKCurve[] = {1}; leftHandIKCurve[] = {0,0,0.5,1};};
    };
    class BlendAnims {
        rightArmHead[] = {
            "head",1,"neck1",1,"neck",1,
            "RightShoulder", 1, "RightArm", 1, "RightArmRoll", 1, "RightForeArm", 1, "RightForeArmRoll", 1, "RightHand", 1, 
            "RightHandThumb1", 1, "RightHandThumb2", 1, "RightHandThumb3", 1,
            "RightHandIndex1", 1, "RightHandIndex2", 1, "RightHandIndex3", 1, 
            "RightHandMiddle1", 1, "RightHandMiddle2", 1, "RightHandMiddle3", 1, 
            "RightHandRing", 1, "RightHandRing1", 1, "RightHandRing2", 1, "RightHandRing3", 1, 
            "RightHandPinky1", 1, "RightHandPinky2", 1, "RightHandPinky3", 1
        };
        rightArm[] = {
            "RightShoulder", 1, "RightArm", 1, "RightArmRoll", 1, "RightForeArm", 1, "RightForeArmRoll", 1, "RightHand", 1, 
            "RightHandThumb1", 1, "RightHandThumb2", 1, "RightHandThumb3", 1,
            "RightHandIndex1", 1, "RightHandIndex2", 1, "RightHandIndex3", 1, 
            "RightHandMiddle1", 1, "RightHandMiddle2", 1, "RightHandMiddle3", 1, 
            "RightHandRing", 1, "RightHandRing1", 1, "RightHandRing2", 1, "RightHandRing3", 1, 
            "RightHandPinky1", 1, "RightHandPinky2", 1, "RightHandPinky3", 1
        };
        leftArm[] = {
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1, 
            "LeftHandThumb1", 1, "LeftHandThumb2", 1, "LeftHandThumb3", 1,
            "LeftHandIndex1", 1, "LeftHandIndex2", 1, "LeftHandIndex3", 1, 
            "LeftHandMiddle1", 1, "LeftHandMiddle2", 1, "LeftHandMiddle3", 1, 
            "LeftHandRing", 1, "LeftHandRing1", 1, "LeftHandRing2", 1, "LeftHandRing3", 1, 
            "LeftHandPinky1", 1, "LeftHandPinky2", 1, "LeftHandPinky3", 1
        };
        leftArmSpine[] = {
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1, 
            "LeftHandThumb1", 1, "LeftHandThumb2", 1, "LeftHandThumb3", 1,
            "LeftHandIndex1", 1, "LeftHandIndex2", 1, "LeftHandIndex3", 1, 
            "LeftHandMiddle1", 1, "LeftHandMiddle2", 1, "LeftHandMiddle3", 1, 
            "LeftHandRing", 1, "LeftHandRing1", 1, "LeftHandRing2", 1, "LeftHandRing3", 1, 
            "LeftHandPinky1", 1, "LeftHandPinky2", 1, "LeftHandPinky3", 1,
            "neck", 1, "neck1", 1, "head", 1, "Spine", 1, "Spine1", 1, "Spine2", 1, "Spine3", 1, "pelvis", "MaskStart"
        };
        bothArms[] = {
            "RightShoulder", 1, "RightArm", 1, "RightArmRoll", 1, "RightForeArm", 1, "RightForeArmRoll", 1, "RightHand", 1, 
            "RightHandThumb1", 1, "RightHandThumb2", 1, "RightHandThumb3", 1,
            "RightHandIndex1", 1, "RightHandIndex2", 1, "RightHandIndex3", 1, 
            "RightHandMiddle1", 1, "RightHandMiddle2", 1, "RightHandMiddle3", 1, 
            "RightHandRing", 1, "RightHandRing1", 1, "RightHandRing2", 1, "RightHandRing3", 1, 
            "RightHandPinky1", 1, "RightHandPinky2", 1, "RightHandPinky3", 1,
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1, 
            "LeftHandThumb1", 1, "LeftHandThumb2", 1, "LeftHandThumb3", 1,
            "LeftHandIndex1", 1, "LeftHandIndex2", 1, "LeftHandIndex3", 1, 
            "LeftHandMiddle1", 1, "LeftHandMiddle2", 1, "LeftHandMiddle3", 1, 
            "LeftHandRing", 1, "LeftHandRing1", 1, "LeftHandRing2", 1, "LeftHandRing3", 1, 
            "LeftHandPinky1", 1, "LeftHandPinky2", 1, "LeftHandPinky3", 1
        };
        readyPistol[] = {
            "RightShoulder", 1, "RightArm", 1, "RightArmRoll", 1, "RightForeArm", 1, "RightForeArmRoll", 1, "RightHand", 1, 
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1
        };
        readyPistolSpine[] = {
            "RightShoulder", 1, "RightArm", 1, "RightArmRoll", 1, "RightForeArm", 1, "RightForeArmRoll", 1, "RightHand", 1, 
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1,
            "neck", 1, "neck1", 1, "head", 1, "Spine", 1, "Spine1", 1, "Spine2", 1, "Spine3", 1, "pelvis", "MaskStart"
        };
        weapon[] = {"weapon", 1};
        weaponSpine[] = {"weapon", 1, "neck", 1, "neck1", 1, "Spine", 1, "Spine1", 0.1};	
        weaponLeftArm[] = {
            "weapon", 1,
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1, 
            "LeftHandThumb1", 1, "LeftHandThumb2", 1, "LeftHandThumb3", 1,
            "LeftHandIndex1", 1, "LeftHandIndex2", 1, "LeftHandIndex3", 1, 
            "LeftHandMiddle1", 1, "LeftHandMiddle2", 1, "LeftHandMiddle3", 1, 
            "LeftHandRing", 1, "LeftHandRing1", 1, "LeftHandRing2", 1, "LeftHandRing3", 1, 
            "LeftHandPinky1", 1, "LeftHandPinky2", 1, "LeftHandPinky3", 1
        };
        upperTorsoWeak[] = {
            "neck", 1, "neck1", 1, "Spine", 1, "Spine1", 0.1,
            "RightShoulder", 1, "RightArm", 1, "RightArmRoll", 1, "RightForeArm", 1, "RightForeArmRoll", 1, "RightHand", 1, 
            "LeftShoulder", 1, "LeftArm", 1, "LeftArmRoll", 1, "LeftForeArm", 1, "LeftForeArmRoll", 1, "LeftHand", 1
        };
    };
};

class CfgEditorSubCategories {
	class tsp_inf_sf {displayName = "Infantry (Special Forces)";};
	class tsp_inf_navy {displayName = "Infantry (Navy)"};
	class tsp_inf_crew {displayName = "Infantry (Crew)";};
	class tsp_inf_1990 {displayName = "Infantry (1990)";};
	class tsp_inf_death {displayName = "Infantry (Death Squads)";};
	class tsp_men_contractor {displayName = "Contractors";};
	class tsp_men_guard {displayName = "Guards";}; 
	class tsp_men_thug {displayName = "Men (Thug)";};
    class tsp_men_chernarus {displayName = "Men (Chernarus)";}; 
    class tsp_men_sahrani {displayName = "Men (Sahrani)";};
    class tsp_men_takistan {displayName = "Men (Takistan)";};
    class tsp_cars_chernarus {displayName = "Cars (Chernarus)";};
    class tsp_cars_sahrani {displayName = "Cars (Sahrani)";};
    class tsp_cars_takistan {displayName = "Cars (Takistan)";};
};

class CfgWorlds {
    class genericNames {
        class SahraniMen {
            class FirstNames {
                diego = "Diego";
                mateo = "Mateo";
                antonio = "Antonio";
                santiago = "Santiago";
                juan = "Juan";
                manuel = "Manual";
                miguel = "Miguel";
                carlos = "Carlos";
                alejandro = "Alejandro";
            };
            class LastNames {                
                garcia = "Garcia";
                martinez = "Matinez";
                lopez = "Lopez";
                gomez = "Gomez";
                rodriguez = "Rodriguez";
                perez = "Perez";
                hernandez = "Hernandez";
                fernandez = "Fernandez";
                sanchez = "Sanchez";
            };
        };
    };
};