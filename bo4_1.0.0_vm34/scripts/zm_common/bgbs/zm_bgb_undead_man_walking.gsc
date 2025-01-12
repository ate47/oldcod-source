#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_undead_man_walking;

// Namespace zm_bgb_undead_man_walking/zm_bgb_undead_man_walking
// Params 0, eflags: 0x2
// Checksum 0x3a142f32, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_undead_man_walking", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_undead_man_walking/zm_bgb_undead_man_walking
// Params 0, eflags: 0x0
// Checksum 0xb7485a9c, Offset: 0xf0
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_undead_man_walking", "time", 60, &enable, undefined, undefined, undefined);
}

// Namespace zm_bgb_undead_man_walking/zm_bgb_undead_man_walking
// Params 0, eflags: 0x0
// Checksum 0x2a235019, Offset: 0x160
// Size: 0xb4
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self thread function_40e95c74();
    if (bgb::increment_ref_count(#"zm_bgb_undead_man_walking")) {
        return;
    }
    function_b41dc007(1);
    spawner::add_global_spawn_function(#"axis", &function_f3d5076d);
}

// Namespace zm_bgb_undead_man_walking/zm_bgb_undead_man_walking
// Params 0, eflags: 0x0
// Checksum 0x2c584a8b, Offset: 0x220
// Size: 0xac
function function_40e95c74() {
    self waittill(#"disconnect", #"bled_out", #"bgb_update");
    if (bgb::decrement_ref_count(#"zm_bgb_undead_man_walking")) {
        return;
    }
    spawner::remove_global_spawn_function(#"axis", &function_f3d5076d);
    function_b41dc007(0);
}

// Namespace zm_bgb_undead_man_walking/zm_bgb_undead_man_walking
// Params 1, eflags: 0x0
// Checksum 0x4ea8b9d6, Offset: 0x2d8
// Size: 0x156
function function_b41dc007(b_walk = 1) {
    a_ai = getaiarray();
    for (i = 0; i < a_ai.size; i++) {
        var_3812f8bd = 0;
        if (isdefined(level.var_9e59cb5b)) {
            var_3812f8bd = [[ level.var_9e59cb5b ]](a_ai[i]);
        } else if (isalive(a_ai[i]) && a_ai[i].var_29ed62b2 === #"basic" && a_ai[i].team === level.zombie_team) {
            var_3812f8bd = 1;
        }
        if (var_3812f8bd) {
            if (b_walk) {
                a_ai[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
                continue;
            }
            a_ai[i] zombie_utility::set_zombie_run_cycle_restore_from_override();
        }
    }
}

// Namespace zm_bgb_undead_man_walking/zm_bgb_undead_man_walking
// Params 0, eflags: 0x0
// Checksum 0x2c23d874, Offset: 0x438
// Size: 0xac
function function_f3d5076d() {
    var_3812f8bd = 0;
    if (isdefined(level.var_9e59cb5b)) {
        var_3812f8bd = [[ level.var_9e59cb5b ]](self);
    } else if (isalive(self) && self.archetype === "zombie" && self.team === level.zombie_team) {
        var_3812f8bd = 1;
    }
    if (var_3812f8bd) {
        self zombie_utility::set_zombie_run_cycle_override_value("walk");
    }
}

