if (!isServer) exitWith {};

[
	west, ["hvt"], "Kill/Capture Jalali Khara", "Jalali Khara, a key insurgent leader, has been located in the area. Your objective is to kill or capture him. Khara is a high-value target with direct ties to recent attacks on Coalition forces. Expect heavy resistance near his last known location. Eliminate the threat or detain him if possible.", 
	"Kill", objNull, {true}, {task_hvt distance lpd < 100 || !alive task_hvt}, {false}
] spawn tsp_fnc_task;

[
	west, ["cache"], "Destroy Weapons Caches", "Enemy weapons caches have been discovered nearby, containing explosives and arms intended for insurgent forces. Your mission is to locate and destroy all identified caches to disrupt enemy supply lines. Ensure complete destruction to prevent any salvage.", 
	"Destroy", objNull, {true}, {!alive task_cache1 && !alive task_cache2 && !alive task_cache3 && !alive task_cache4}
] spawn tsp_fnc_task;

//ѕмαℓℓ