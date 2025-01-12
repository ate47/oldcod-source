#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x79b83166, Offset: 0x140
// Size: 0x196
function init_shared() {
    clientfield::register("clientuimodel", "locSel.commandMode", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "locSel.snapTo", 1, 1, "int", undefined, 0, 0);
    clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
    clientfield::register("toplayer", "thermal_glow", 1, 1, "int", &function_368cb88f, 0, 0);
    clientfield::register("allplayers", "killstreak_spawn_protection", 1, 1, "int", &function_86eccaa9, 0, 0);
    callback::on_spawned(&on_player_spawned);
    level.killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x69be95c0, Offset: 0x2e0
// Size: 0x1a2
function timeout_beep(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"timeout_beep");
    if (!newval) {
        return;
    }
    if (isdefined(self.killstreakbundle)) {
        beepalias = self.killstreakbundle.kstimeoutbeepalias;
    }
    self endon(#"death");
    self endon(#"timeout_beep");
    interval = 1;
    if (newval == 2) {
    }
    for (interval = 0.133; true; interval = math::clamp(interval / 1.17, 0.1, 1)) {
        if (isdefined(beepalias)) {
            self playsound(localclientnum, beepalias);
        }
        if (self.timeoutlightsoff === 1) {
            self vehicle::lights_on(localclientnum);
            self.timeoutlightsoff = 0;
        } else {
            self vehicle::lights_off(localclientnum);
            self.timeoutlightsoff = 1;
        }
        util::server_wait(localclientnum, interval);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x36a5491, Offset: 0x490
// Size: 0x100
function function_368cb88f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        player renderoverridebundle::function_a95eb710(localclientnum, newval, #"hash_2c6fce4151016478", &function_bbae8ec3);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xce04199e, Offset: 0x598
// Size: 0x8e
function function_bbae8ec3(localclientnum, should_play) {
    if (!should_play) {
        return 0;
    }
    if (!self isplayer()) {
        return should_play;
    }
    if (self hasperk(localclientnum, #"specialty_nokillstreakreticle")) {
        return 0;
    }
    if (self clientfield::get("killstreak_spawn_protection")) {
        return 0;
    }
    return 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0xd32dcd84, Offset: 0x630
// Size: 0x7c
function function_86eccaa9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread renderoverridebundle::function_78b7aef9(localclientnum, "thermal_glow", #"hash_2c6fce4151016478", &function_bbae8ec3);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x8518cf58, Offset: 0x6b8
// Size: 0x34
function on_player_spawned(localclientnum) {
    self renderoverridebundle::function_a95eb710(localclientnum, 0, #"hash_2c6fce4151016478");
}

