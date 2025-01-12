#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\smart_bomb;

#namespace raps;

// Namespace raps/raps
// Params 0, eflags: 0x6
// Checksum 0xbec24bc5, Offset: 0x118
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"raps", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace raps/raps
// Params 0, eflags: 0x4
// Checksum 0xd5aa6f43, Offset: 0x160
// Size: 0xa4
function private function_70a657d8() {
    clientfield::register("vehicle", "raps_side_deathfx", 1, 1, "int");
    vehicle::add_main_callback("raps", &raps_initialize);
    5748 = getentarray("raps_slow", "targetname");
    array::thread_all(5748, &slow_raps_trigger);
}

// Namespace raps/raps
// Params 0, eflags: 0x0
// Checksum 0x1c0e3987, Offset: 0x210
// Size: 0x84
function raps_initialize() {
    smart_bomb::function_c6f75619();
    self useanimtree("generic");
    self initsounds();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace raps/raps
// Params 0, eflags: 0x0
// Checksum 0x3569f7b5, Offset: 0x2a0
// Size: 0x10c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &smart_bomb::state_combat_update;
    self vehicle_ai::get_state_callbacks("driving").update_func = &smart_bomb::state_scripted_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &smart_bomb::state_death_update;
    self vehicle_ai::get_state_callbacks("emped").update_func = &smart_bomb::state_emped_update;
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("combat");
}

// Namespace raps/raps
// Params 0, eflags: 0x0
// Checksum 0x46acf74d, Offset: 0x3b8
// Size: 0xb8
function slow_raps_trigger() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        other = waitresult.activator;
        if (isvehicle(other) && isdefined(other.archetype) && other.archetype == "raps") {
            other thread slow_raps(self);
        }
        wait 0.1;
    }
}

// Namespace raps/raps
// Params 1, eflags: 0x0
// Checksum 0xfb4d5b69, Offset: 0x478
// Size: 0x16e
function slow_raps(trigger) {
    self notify(#"slow_raps");
    self endon(#"slow_raps", #"death");
    self.slow_trigger = 1;
    if (isdefined(trigger.script_int)) {
        if (isdefined(self._override_raps_combat_speed) && self._override_raps_combat_speed < trigger.script_int) {
            self setspeedimmediate(self._override_raps_combat_speed);
        } else {
            self setspeedimmediate(trigger.script_int, 200, 200);
        }
    } else if (isdefined(self._override_raps_combat_speed) && self._override_raps_combat_speed < 0.5 * self.settings.defaultmovespeed) {
        self setspeed(self._override_raps_combat_speed);
    } else {
        self setspeed(0.5 * self.settings.defaultmovespeed);
    }
    wait 1;
    self resumespeed();
    self.slow_trigger = undefined;
}

// Namespace raps/raps
// Params 0, eflags: 0x0
// Checksum 0x1c2038f3, Offset: 0x5f0
// Size: 0x504
function initsounds() {
    self.sndalias = [];
    self.sndalias[#"inair"] = #"veh_raps_in_air";
    self.sndalias[#"land"] = #"veh_raps_land";
    self.sndalias[#"spawn"] = #"veh_raps_spawn";
    self.sndalias[#"direction"] = #"veh_raps_direction";
    self.sndalias[#"jump_up"] = #"veh_raps_jump_up";
    self.sndalias[#"vehclose250"] = #"veh_raps_close_250";
    self.sndalias[#"vehclose1500"] = #"veh_raps_close_1500";
    self.sndalias[#"vehtargeting"] = #"veh_raps_targeting";
    self.sndalias[#"vehalarm"] = #"evt_raps_alarm";
    self.sndalias[#"vehcollision"] = #"veh_wasp_wall_imp";
    if (isdefined(self.vehicletype) && (self.vehicletype == #"spawner_enemy_zombie_vehicle_raps_suicide" || self.vehicletype == #"spawner_zombietron_veh_meatball" || self.vehicletype == #"spawner_zombietron_veh_meatball_med" || self.vehicletype == #"spawner_zombietron_veh_meatball_small")) {
        self.sndalias[#"inair"] = #"zmb_meatball_in_air";
        self.sndalias[#"land"] = #"zmb_meatball_land";
        self.sndalias[#"spawn"] = undefined;
        self.sndalias[#"direction"] = undefined;
        self.sndalias[#"jump_up"] = #"zmb_meatball_jump_up";
        self.sndalias[#"vehclose250"] = #"zmb_meatball_close_250";
        self.sndalias[#"vehclose1500"] = undefined;
        self.sndalias[#"vehtargeting"] = #"zmb_meatball_targeting";
        self.sndalias[#"vehalarm"] = undefined;
        self.sndalias[#"vehcollision"] = #"zmb_meatball_collision";
    }
    if (isdefined(self.vehicletype) && self.vehicletype == #"hash_22f2770b0b570f88") {
        self.sndalias[#"inair"] = #"hash_b4c1fb7fb7b70be";
        self.sndalias[#"land"] = #"hash_56707e87f5b058df";
        self.sndalias[#"spawn"] = #"hash_220536a567c22f9d";
        self.sndalias[#"direction"] = undefined;
        self.sndalias[#"jump_up"] = #"hash_1182d9ecfe86442e";
        self.sndalias[#"vehclose250"] = #"hash_4d4a13f08b063112";
        self.sndalias[#"vehclose1500"] = undefined;
        self.sndalias[#"vehtargeting"] = #"hash_57d3d8cf8a3cb109";
        self.sndalias[#"vehalarm"] = #"hash_28033d94de922793";
        self.sndalias[#"vehcollision"] = #"hash_481f37c2ab12bdfe";
    }
}

// Namespace raps/raps
// Params 2, eflags: 0x0
// Checksum 0x232bda8e, Offset: 0xb00
// Size: 0x34
function detonate_damage_monitored(attacker, *weapon) {
    self.selfdestruct = 1;
    smart_bomb::detonate(weapon);
}

// Namespace raps/raps
// Params 1, eflags: 0x0
// Checksum 0x9cee90e0, Offset: 0xb40
// Size: 0x24
function detonate(attacker) {
    smart_bomb::detonate(attacker);
}

