#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_death_perception;

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x2
// Checksum 0xde5b4166, Offset: 0x148
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_death_perception", &__init__, undefined, undefined);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x1cf8e459, Offset: 0x190
// Size: 0x84
function __init__() {
    enable_death_perception_perk_for_level();
    level.var_d6cf8bd6 = [];
    for (i = 0; i < getmaxlocalclients(); i++) {
        level.var_d6cf8bd6[i] = 0;
    }
    ai::add_ai_spawn_function(&function_f3fa1ce6);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0xe9d17dcb, Offset: 0x220
// Size: 0xd4
function enable_death_perception_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_awareness", &function_5a5b381, &function_77cd5a8c);
    zm_perks::register_perk_effects(#"specialty_awareness", "divetonuke_light");
    zm_perks::register_perk_init_thread(#"specialty_awareness", &function_450f0786);
    zm_perks::function_32b099ec(#"specialty_awareness", #"p8_zm_vapor_altar_icon_01_deathperception", "zombie/fx8_perk_altar_symbol_ambient_death_perception");
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x300
// Size: 0x4
function function_450f0786() {
    
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x8b57b99c, Offset: 0x310
// Size: 0x84
function function_5a5b381() {
    clientfield::register("clientuimodel", "hudItems.perks.death_perception", 1, 1, "int", undefined, 0, 1);
    clientfield::register("toplayer", "perk_death_perception_visuals", 1, 1, "int", &perk_death_perception_visuals, 0, 0);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3a0
// Size: 0x4
function function_77cd5a8c() {
    
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 7, eflags: 0x0
// Checksum 0xf6dd145b, Offset: 0x3b0
// Size: 0x206
function perk_death_perception_visuals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (function_9a47ed7f(localclientnum)) {
        return;
    }
    if (newval && !(isdefined(level.var_fc04f28d) && level.var_fc04f28d)) {
        level.var_d6cf8bd6[localclientnum] = 1;
        a_ai = function_6cea032(localclientnum);
        foreach (ai in a_ai) {
            ai function_f3fa1ce6(localclientnum);
        }
        self thread function_1dce2547(localclientnum);
        return;
    }
    level.var_d6cf8bd6[localclientnum] = 0;
    a_ai = function_6cea032(localclientnum);
    foreach (ai in a_ai) {
        ai stoprenderoverridebundle(#"hash_30651f363ef055e9");
    }
    self notify(#"hash_45ed6efeef67b773");
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 1, eflags: 0x0
// Checksum 0xbc1184c9, Offset: 0x5c0
// Size: 0x44
function function_f3fa1ce6(localclientnum) {
    if (level.var_d6cf8bd6[localclientnum]) {
        self playrenderoverridebundle(#"hash_30651f363ef055e9");
    }
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 1, eflags: 0x0
// Checksum 0x5baf4780, Offset: 0x610
// Size: 0x1fc
function function_1dce2547(localclientnum) {
    self endon(#"death", #"hash_45ed6efeef67b773");
    while (true) {
        if (!(isdefined(level.var_fc04f28d) && level.var_fc04f28d)) {
            a_ai = function_6cea032(localclientnum);
            a_ai = arraysortclosest(a_ai, self.origin, undefined, undefined, 200);
            var_91a9d91c = anglestoforward(self.angles);
            foreach (ai in a_ai) {
                if (vectordot(var_91a9d91c, vectornormalize(ai.origin - self.origin)) < 0.35) {
                    var_b751f8e4 = ai.origin;
                    if (ai.type === #"vehicle") {
                        var_b751f8e4 = (ai.origin[0], ai.origin[1], self.origin[2]);
                    }
                    self addawarenessindicator(var_b751f8e4, "noncombat_danger", 75);
                }
            }
        }
        wait 0.05;
    }
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 1, eflags: 0x4
// Checksum 0x38ea6c04, Offset: 0x818
// Size: 0xb2
function private function_6cea032(localclientnum) {
    a_ai = getentarraybytype(localclientnum, 15);
    a_vh = getentarraybytype(localclientnum, 12);
    if (a_vh.size) {
        a_vh = array::filter(a_vh, 0, &function_54a5a340);
    }
    a_ai = arraycombine(a_ai, a_vh, 0, 0);
    return a_ai;
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 1, eflags: 0x0
// Checksum 0x4bfa7a5, Offset: 0x8d8
// Size: 0x24
function function_54a5a340(val) {
    return val.team === #"axis";
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 1, eflags: 0x0
// Checksum 0xb1211cdd, Offset: 0x908
// Size: 0x5c
function function_7659b49c(localclientnum) {
    value = self clientfield::get_to_player("perk_death_perception_visuals");
    self perk_death_perception_visuals(localclientnum, undefined, value, undefined, undefined, undefined, undefined);
}

