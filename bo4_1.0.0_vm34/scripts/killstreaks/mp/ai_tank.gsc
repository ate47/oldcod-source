#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\ai\patrol;
#using scripts\killstreaks\ai_tank_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\killstreak_vehicle;
#using scripts\killstreaks\mp\supplydrop;
#using scripts\mp_common\gametypes\battlechatter;

#namespace ai_tank;

// Namespace ai_tank/ai_tank
// Params 0, eflags: 0x2
// Checksum 0x58e3d432, Offset: 0x120
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"ai_tank", &__init__, undefined, #"killstreaks");
}

// Namespace ai_tank/ai_tank
// Params 0, eflags: 0x0
// Checksum 0xa8ddbd64, Offset: 0x170
// Size: 0xa6
function __init__() {
    init_shared();
    level.var_a2209510 = &function_66863393;
    level.aitank_explode = &function_3123776c;
    level.var_b0bb2344 = &function_2741aef4;
    level.var_7cda9384 = &function_21a1113;
    level.var_fc8e6013 = &function_56922bfa;
    level.var_f2db9aa9 = &function_9ede5ec0;
}

// Namespace ai_tank/ai_tank
// Params 1, eflags: 0x0
// Checksum 0xb66983ec, Offset: 0x220
// Size: 0xc4
function function_66863393(drone) {
    drone = self;
    bundle = struct::get_script_bundle("killstreak", "killstreak_" + "tank_robot");
    drone ai_patrol::function_8c3ba57b(bundle);
    drone.goalradius = bundle.var_390a3bd1;
    drone thread killstreaks::waitfortimecheck(90000 * 0.5, &ontimecheck, "delete", "death", "crashing");
}

// Namespace ai_tank/ai_tank
// Params 0, eflags: 0x0
// Checksum 0x7050c7af, Offset: 0x2f0
// Size: 0x34
function ontimecheck() {
    self killstreaks::play_pilot_dialog_on_owner("timecheck", "tank_robot", self.killstreak_id);
}

// Namespace ai_tank/ai_tank
// Params 1, eflags: 0x0
// Checksum 0xec510532, Offset: 0x330
// Size: 0x64
function function_56922bfa(drone) {
    if (!isdefined(self.currentkillstreakdialog) && isdefined(level.heroplaydialog)) {
        self thread [[ level.heroplaydialog ]]("controlAiTank");
    }
    drone clientfield::set("ai_tank_change_control", 1);
}

// Namespace ai_tank/ai_tank
// Params 1, eflags: 0x0
// Checksum 0xe3618f82, Offset: 0x3a0
// Size: 0x2c
function function_9ede5ec0(drone) {
    drone clientfield::set("ai_tank_change_control", 0);
}

// Namespace ai_tank/ai_tank
// Params 1, eflags: 0x0
// Checksum 0xab36ffac, Offset: 0x3d8
// Size: 0x22
function function_2741aef4(killstreaktype) {
    return supplydrop::issupplydropgrenadeallowed(killstreaktype);
}

// Namespace ai_tank/ai_tank
// Params 3, eflags: 0x0
// Checksum 0x6bfc0bf5, Offset: 0x408
// Size: 0x88
function function_21a1113(killstreak_id, context, team) {
    result = self supplydrop::usesupplydropmarker(killstreak_id, context);
    self notify(#"supply_drop_marker_done");
    if (!(isdefined(result) && result)) {
        return false;
    }
    self killstreaks::play_killstreak_start_dialog("tank_robot", team, killstreak_id);
    return true;
}

// Namespace ai_tank/ai_tank
// Params 2, eflags: 0x0
// Checksum 0xe4b9eecf, Offset: 0x498
// Size: 0x62
function function_3123776c(attacker, weapon) {
    profilestart();
    var_757a988f = killstreak_vehicle::explode(attacker, weapon);
    if (var_757a988f) {
        scoreevents::function_fc0510f4(attacker, self, weapon);
    }
    profilestop();
    return var_757a988f;
}

