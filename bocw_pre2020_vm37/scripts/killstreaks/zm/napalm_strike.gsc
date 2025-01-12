#using script_7475f917e6d3bed9;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\zm\airsupport;
#using scripts\zm_common\zm_player;

#namespace napalm_strike;

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x6
// Checksum 0x57a34e74, Offset: 0x130
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"napalm_strike", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x5 linked
// Checksum 0xabff1e00, Offset: 0x180
// Size: 0x84
function private function_70a657d8() {
    init_shared("killstreak_napalm_strike" + "_zm", &function_a865cea6);
    clientfield::register("scriptmover", "napalm_strike_marker_on", 1, 1, "int");
    zm_player::register_player_damage_callback(&function_f6ea413);
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x1 linked
// Checksum 0xbdb467be, Offset: 0x210
// Size: 0x6a
function function_a865cea6() {
    if (self killstreakrules::iskillstreakallowed("napalm_strike", self.team) == 0) {
        return 0;
    }
    result = self function_53a0e7ce();
    return is_true(result);
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x1 linked
// Checksum 0x6463977f, Offset: 0x288
// Size: 0x19c
function function_53a0e7ce() {
    self endon(#"disconnect");
    s_params = killstreaks::get_script_bundle("napalm_strike");
    var_2558cb51 = array("napalm_strike_complete", "napalm_strike_failed");
    self namespace_bf7415ae::function_890b3889(s_params.var_fc0c8eae, 2500, &function_ce23d48a, &function_ffa80fa4, var_2558cb51);
    s_location = self namespace_bf7415ae::function_be6de952();
    if (isdefined(s_location)) {
        s_location.yaw = self.angles[1] + 90;
        s_location.height = 1500 + 3000 + randomfloatrange(-200, 200);
        killstreak_id = self killstreakrules::killstreakstart("napalm_strike", self.team, 0, 1);
        if (killstreak_id == -1) {
            self notify(#"napalm_strike_failed");
            return false;
        }
        self thread function_9aa2535(s_location, killstreak_id);
        return true;
    }
    return false;
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x5 linked
// Checksum 0x2d764f9e, Offset: 0x430
// Size: 0x24
function private function_ce23d48a() {
    self clientfield::set("napalm_strike_marker_on", 1);
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x5 linked
// Checksum 0x793b40f2, Offset: 0x460
// Size: 0x24
function private function_ffa80fa4() {
    self clientfield::set("napalm_strike_marker_on", 0);
}

// Namespace napalm_strike/napalm_strike
// Params 2, eflags: 0x5 linked
// Checksum 0x8a97dc28, Offset: 0x490
// Size: 0x46
function private function_9aa2535(location, killstreakid) {
    self function_88e2e18a(location, self.team, killstreakid);
    self notify(#"napalm_strike_complete");
}

// Namespace napalm_strike/napalm_strike
// Params 10, eflags: 0x5 linked
// Checksum 0x9c527dd1, Offset: 0x4e0
// Size: 0x8c
function private function_f6ea413(*einflictor, eattacker, *idamage, *idflags, *smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (shitloc === self && psoffsettime == getweapon("napalm_strike")) {
        return 20;
    }
    return -1;
}

