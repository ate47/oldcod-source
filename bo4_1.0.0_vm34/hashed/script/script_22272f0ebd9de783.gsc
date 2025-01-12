#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_towers_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_traps;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace namespace_503e710a;

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x2
// Checksum 0xe327637a, Offset: 0x1d8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_55c1d88784016490", &__init__, &__main__, undefined);
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0xb4da0fbc, Offset: 0x228
// Size: 0x3c
function __init__() {
    level thread function_3713959e();
    callback::on_finalize_initialization(&init);
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x270
// Size: 0x4
function __main__() {
    
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0xa92fdbc6, Offset: 0x280
// Size: 0x24
function init() {
    callback::on_connect(&function_7f0b7fe0);
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2b0
// Size: 0x4
function function_7f0b7fe0() {
    
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0x219ae015, Offset: 0x2c0
// Size: 0x174
function function_3713959e() {
    level.var_67240e6f = getentarray("trap_blade_pillar", "script_label");
    a_zombie_traps = getentarray("zombie_trap", "targetname");
    level.var_71ffaa6a = array::filter(a_zombie_traps, 0, &function_83077d9b);
    foreach (var_3f94177a in level.var_71ffaa6a) {
        var_3f94177a function_97095391();
    }
    zm_traps::register_trap_basic_info("blade_pillar", &function_94ddd5, &function_665e2b86);
    zm_traps::register_trap_damage("blade_pillar", &player_damage, &damage);
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 1, eflags: 0x0
// Checksum 0x733219cb, Offset: 0x440
// Size: 0x20
function function_83077d9b(e_ent) {
    return e_ent.script_noteworthy == "blade_pillar";
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0xc5a8ef78, Offset: 0x468
// Size: 0xbe
function function_97095391() {
    self flag::init("activated");
    var_d4bb77cc = arraygetclosest(self.origin, level.var_67240e6f);
    var_d4bb77cc flag::init("activated");
    self zm_traps::function_c4cf2752();
    var_d4bb77cc.var_3eed98f9 = var_d4bb77cc.origin;
    var_d4bb77cc.var_438359e7 = var_d4bb77cc.angles;
    self.var_d4bb77cc = var_d4bb77cc;
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0x79c89bbd, Offset: 0x530
// Size: 0x2f4
function function_94ddd5() {
    self._trap_duration = 30;
    self._trap_cooldown_time = 60;
    if (isdefined(level.sndtrapfunc)) {
        level thread [[ level.sndtrapfunc ]](self, 1);
    }
    self notify(#"trap_activate");
    level notify(#"trap_activate", self);
    self.activated_by_player thread function_3dd640cb(self.script_string);
    foreach (t_trap in level.var_71ffaa6a) {
        if (t_trap.script_string === self.script_string) {
            var_e8286554 = getentarray(t_trap.target, "targetname");
            mdl_trap = getent(var_e8286554[0].target, "targetname");
            mdl_trap scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 1", mdl_trap);
            mdl_trap thread scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 2", mdl_trap);
            t_trap thread zm_traps::trap_damage();
        }
    }
    self waittilltimeout(self._trap_duration, #"trap_deactivate");
    foreach (t_trap in level.var_71ffaa6a) {
        if (t_trap.script_string === self.script_string) {
            var_e8286554 = getentarray(t_trap.target, "targetname");
            mdl_trap = getent(var_e8286554[0].target, "targetname");
            mdl_trap thread scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 3", mdl_trap);
            t_trap notify(#"trap_done");
        }
    }
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x830
// Size: 0x4
function function_665e2b86() {
    
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 1, eflags: 0x0
// Checksum 0x2098d655, Offset: 0x840
// Size: 0x1a0
function function_3dd640cb(str_id) {
    foreach (e_pillar in level.var_67240e6f) {
        if (e_pillar.script_string === str_id) {
            e_pillar thread activate_trap(self);
            level.var_b537952c = getent(e_pillar.target, "targetname");
            level.var_b537952c thread function_67fd9483();
        }
    }
    level notify(#"traps_activated", {#var_f6bb8854:str_id});
    wait 30;
    level notify(#"traps_cooldown", {#var_f6bb8854:str_id});
    n_cooldown = zm_traps::function_4bcd0324(60, self);
    wait n_cooldown;
    level notify(#"traps_available", {#var_f6bb8854:str_id});
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 0, eflags: 0x0
// Checksum 0x3586513, Offset: 0x9e8
// Size: 0xec
function function_67fd9483() {
    level endon(#"traps_cooldown");
    while (true) {
        s_info = self waittill(#"trigger");
        e_player = s_info.activator;
        if (!isplayer(e_player)) {
            continue;
        }
        if (!e_player issliding()) {
            continue;
        }
        var_9398d69d = e_player.health;
        wait 0.85;
        if (isdefined(e_player) && var_9398d69d == e_player.health) {
            e_player notify(#"hash_731c84be18ae9fa3");
        }
    }
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 1, eflags: 0x0
// Checksum 0xcf4ea285, Offset: 0xae0
// Size: 0x62
function activate_trap(e_player) {
    if (!self flag::get("activated")) {
        self flag::set("activated");
        if (isdefined(e_player)) {
            self.activated_by_player = e_player;
        }
    }
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 1, eflags: 0x0
// Checksum 0xef4ac401, Offset: 0xb50
// Size: 0x4e
function deactivate_trap(e_trap) {
    e_trap notify(#"trap_deactivate");
    self flag::clear("activated");
    self notify(#"deactivate");
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 1, eflags: 0x0
// Checksum 0x45fd3a05, Offset: 0xba8
// Size: 0x24c
function damage(e_trap) {
    if (self.var_29ed62b2 === #"miniboss" || self.var_29ed62b2 === #"heavy") {
        e_trap.var_d4bb77cc deactivate_trap(e_trap);
        e_trap.activated_by_player notify(#"hash_74fc45698491be88");
        return;
    }
    if (!isalive(self) || self.archetype === "tiger" || isvehicle(self)) {
        return;
    }
    self.marked_for_death = 1;
    if (isdefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player)) {
        e_trap.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
    }
    v_away = self.origin - e_trap.origin;
    v_away = vectornormalize((v_away[0], v_away[1], 0)) * 64;
    v_dest = self.origin + v_away;
    level notify(#"trap_kill", {#e_victim:self, #e_trap:e_trap});
    self dodamage(self.health + 666, self.origin, e_trap);
    self thread function_21d88f7(v_dest, 0.25, 0, 0.125);
    self thread zm_towers_util::function_ebdff9e5(90, 75, 25);
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 1, eflags: 0x0
// Checksum 0xe5949d69, Offset: 0xe00
// Size: 0xbe
function player_damage(t_damage) {
    self endon(#"death", #"disconnect");
    if (self getstance() == "stand" && !self issliding()) {
        self dodamage(50, self.origin, undefined, t_damage);
        self setstance("crouch");
        wait 0.1;
        self.is_burning = undefined;
    }
}

// Namespace namespace_503e710a/namespace_c5369caf
// Params 4, eflags: 0x0
// Checksum 0x5e218191, Offset: 0xec8
// Size: 0x16c
function function_21d88f7(v_dest, n_time = 1, n_accel = 0, var_1fbff2a7 = 0) {
    if (isplayer(self)) {
        var_4ddfc7f6 = util::spawn_model("tag_origin", self.origin, self.angles);
        self linkto(var_4ddfc7f6);
        var_4ddfc7f6 moveto(v_dest, n_time, n_accel, var_1fbff2a7);
        var_4ddfc7f6 waittill(#"movedone");
        var_4ddfc7f6 delete();
        return;
    }
    v_direction = vectornormalize(v_dest);
    v_force = v_direction * 64;
    self startragdoll();
    self launchragdoll(v_force);
}

