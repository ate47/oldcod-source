#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_traps;

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x2
// Checksum 0x92bbc78, Offset: 0x390
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_traps", &__init__, &__main__, undefined);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x3ab8ee28, Offset: 0x3e0
// Size: 0x3c
function __init__() {
    level.trap_kills = 0;
    level.burning_zombies = [];
    callback::on_finalize_initialization(&init);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x403f0c7b, Offset: 0x428
// Size: 0x74
function init() {
    if (!zm_custom::function_5638f689(#"zmtrapsenabled")) {
        return;
    }
    traps = getentarray("zombie_trap", "targetname");
    array::thread_all(traps, &trap_init);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xfd545c60, Offset: 0x4a8
// Size: 0x74
function __main__() {
    if (!zm_custom::function_5638f689(#"zmtrapsenabled")) {
        return;
    }
    traps = getentarray("zombie_trap", "targetname");
    array::thread_all(traps, &trap_main);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xd4d61a4f, Offset: 0x528
// Size: 0x6ec
function trap_init() {
    self flag::init("flag_active");
    self flag::init("flag_cooldown");
    self._trap_type = "";
    if (isdefined(self.script_noteworthy)) {
        self._trap_type = self.script_noteworthy;
        if (isdefined(level._custom_traps) && isdefined(level._custom_traps[self.script_noteworthy]) && isdefined(level._custom_traps[self.script_noteworthy].activate)) {
            self._trap_activate_func = level._custom_traps[self.script_noteworthy].activate;
        } else {
            switch (self.script_noteworthy) {
            case #"rotating":
                self._trap_activate_func = &trap_activate_rotating;
                break;
            case #"flipper":
                self._trap_activate_func = &trap_activate_flipper;
                break;
            default:
                self._trap_activate_func = &trap_activate_fire;
                break;
            }
        }
        if (isdefined(level._zombiemode_trap_use_funcs) && isdefined(level._zombiemode_trap_use_funcs[self._trap_type])) {
            self._trap_use_func = level._zombiemode_trap_use_funcs[self._trap_type];
        } else {
            self._trap_use_func = &trap_use_think;
        }
    }
    self trap_model_type_init();
    self._trap_use_trigs = [];
    self._trap_lights = [];
    self._trap_movers = [];
    self._trap_switches = [];
    components = getentarray(self.target, "targetname");
    for (i = 0; i < components.size; i++) {
        if (isdefined(components[i].script_noteworthy)) {
            switch (components[i].script_noteworthy) {
            case #"counter_1s":
                self.counter_1s = components[i];
                continue;
            case #"counter_10s":
                self.counter_10s = components[i];
                continue;
            case #"counter_100s":
                self.counter_100s = components[i];
                continue;
            case #"mover":
                self._trap_movers[self._trap_movers.size] = components[i];
                continue;
            case #"switch":
                self._trap_switches[self._trap_switches.size] = components[i];
                continue;
            case #"light":
                self._trap_lights[self._trap_lights.size] = components[i];
                continue;
            }
        }
        if (isdefined(components[i].script_string)) {
            switch (components[i].script_string) {
            case #"flipper1":
                self.flipper1 = components[i];
                continue;
            case #"flipper2":
                self.flipper2 = components[i];
                continue;
            case #"flipper1_radius_check":
                self.flipper1_radius_check = components[i];
                continue;
            case #"flipper2_radius_check":
                self.flipper2_radius_check = components[i];
                continue;
            case #"target1":
                self.target1 = components[i];
                continue;
            case #"target2":
                self.target2 = components[i];
                continue;
            case #"target3":
                self.target3 = components[i];
                continue;
            }
        }
        switch (components[i].classname) {
        case #"trigger_use_new":
        case #"trigger_use":
            self._trap_use_trigs[self._trap_use_trigs.size] = components[i];
            components[i]._trap = self;
            break;
        case #"script_model":
            if (components[i].model == self._trap_light_model_off) {
                self._trap_lights[self._trap_lights.size] = components[i];
            } else if (components[i].model == self._trap_switch_model) {
                self._trap_switches[self._trap_switches.size] = components[i];
            }
            break;
        }
    }
    self._trap_fx_structs = [];
    components = struct::get_array(self.target, "targetname");
    for (i = 0; i < components.size; i++) {
        if (isdefined(components[i].script_string) && components[i].script_string == "use_this_angle") {
            self.use_this_angle = components[i];
            continue;
        }
        self._trap_fx_structs[self._trap_fx_structs.size] = components[i];
    }
    if (!isdefined(self.zombie_cost)) {
        self.zombie_cost = 1000;
    }
    self._trap_in_use = 0;
    self thread trap_dialog();
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x3a7fc7a, Offset: 0xc20
// Size: 0x2e6
function trap_main() {
    level flag::wait_till("start_zombie_round_logic");
    for (i = 0; i < self._trap_use_trigs.size; i++) {
        self._trap_use_trigs[i] setcursorhint("HINT_NOICON");
    }
    if (!isdefined(self.script_string) || "disable_wait_for_power" != self.script_string) {
        self trap_set_string(#"zombie/need_power");
        if (isdefined(self.script_int) && level flag::exists("power_on" + self.script_int)) {
            level flag::wait_till("power_on" + self.script_int);
        } else {
            level flag::wait_till("power_on");
        }
    }
    if (isdefined(self.script_flag_wait)) {
        self trap_set_string("");
        self triggerenable(0);
        self trap_lights_red();
        if (!isdefined(level.flag[self.script_flag_wait])) {
            level flag::init(self.script_flag_wait);
        }
        level flag::wait_till(self.script_flag_wait);
        self triggerenable(1);
    }
    if (util::get_game_type() == "zstandard") {
        self trap_set_string(#"hash_24a438482954901");
    } else {
        self trap_set_string(#"hash_23c1c09e94181fdb", self.zombie_cost);
    }
    self trap_lights_green();
    for (i = 0; i < self._trap_use_trigs.size; i++) {
        self._trap_use_trigs[i] thread [[ self._trap_use_func ]](self);
        self._trap_use_trigs[i] thread update_trigger_visibility();
    }
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0xfec09666, Offset: 0xf10
// Size: 0x158
function trap_use_think(trap) {
    while (true) {
        waitresult = self waittill(#"trigger");
        who = waitresult.activator;
        if (!zm_utility::can_use(who)) {
            continue;
        }
        if (zm_utility::is_player_valid(who) && !trap._trap_in_use) {
            players = getplayers();
            if (who zm_score::can_player_purchase(trap.zombie_cost)) {
                who zm_score::minus_to_player_score(trap.zombie_cost);
            } else {
                self playsound(#"zmb_trap_deny");
                who zm_audio::create_and_play_dialog("general", "outofmoney");
                continue;
            }
            trap_activate(trap, who);
        }
    }
}

// Namespace zm_traps/zm_traps
// Params 2, eflags: 0x0
// Checksum 0x2439b360, Offset: 0x1070
// Size: 0x304
function trap_activate(trap, who) {
    trap.activated_by_player = who;
    trap._trap_in_use = 1;
    trap trap_set_string(#"zombie/trap_active");
    if (isdefined(who)) {
        zm_utility::play_sound_at_pos("purchase", who.origin);
        if (isdefined(trap._trap_type)) {
            who zm_audio::create_and_play_dialog("trap_activate", trap._trap_type);
        }
        level notify(#"trap_activated", {#trap_activator:who, #trap:trap});
    }
    if (trap._trap_switches.size) {
        trap thread trap_move_switches();
        trap waittill(#"switch_activated");
    }
    trap triggerenable(1);
    trap thread [[ trap._trap_activate_func ]]();
    trap waittill(#"trap_done");
    trap triggerenable(0);
    trap trap_set_string(#"zombie/trap_cooldown");
    /#
        if (getdvarint(#"zombie_cheat", 0) >= 1) {
            trap._trap_cooldown_time = 5;
        }
    #/
    n_cooldown = function_4bcd0324(trap._trap_cooldown_time, who);
    wait n_cooldown;
    playsoundatposition(#"zmb_trap_ready", trap.origin);
    if (isdefined(level.sndtrapfunc)) {
        level thread [[ level.sndtrapfunc ]](trap, 0);
    }
    trap notify(#"available");
    trap._trap_in_use = 0;
    if (util::get_game_type() == "zstandard") {
        trap trap_set_string(#"hash_24a438482954901");
        return;
    }
    trap trap_set_string(#"hash_23c1c09e94181fdb", trap.zombie_cost);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x4
// Checksum 0xf12fbd87, Offset: 0x1380
// Size: 0x104
function private update_trigger_visibility() {
    self endon(#"death");
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            if (distancesquared(level.players[i].origin, self.origin) < 16384) {
                if (level.players[i] zm_utility::is_drinking()) {
                    self setinvisibletoplayer(level.players[i], 1);
                    continue;
                }
                self setinvisibletoplayer(level.players[i], 0);
            }
        }
        wait 0.25;
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x772e1441, Offset: 0x1490
// Size: 0xb6
function trap_lights_red() {
    for (i = 0; i < self._trap_lights.size; i++) {
        light = self._trap_lights[i];
        str_light_red = light.targetname + "_red";
        str_light_green = light.targetname + "_green";
        exploder::stop_exploder(str_light_green);
        exploder::exploder(str_light_red);
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x50a84a6a, Offset: 0x1550
// Size: 0xc6
function trap_lights_green() {
    for (i = 0; i < self._trap_lights.size; i++) {
        light = self._trap_lights[i];
        if (isdefined(light.var_d64a5ffb)) {
            continue;
        }
        str_light_red = light.targetname + "_red";
        str_light_green = light.targetname + "_green";
        exploder::stop_exploder(str_light_red);
        exploder::exploder(str_light_green);
    }
}

// Namespace zm_traps/zm_traps
// Params 3, eflags: 0x0
// Checksum 0x56a5edab, Offset: 0x1620
// Size: 0xce
function trap_set_string(string, param1, param2) {
    for (i = 0; i < self._trap_use_trigs.size; i++) {
        if (!isdefined(param1)) {
            self._trap_use_trigs[i] sethintstring(string);
            continue;
        }
        if (!isdefined(param2)) {
            self._trap_use_trigs[i] sethintstring(string, param1);
            continue;
        }
        self._trap_use_trigs[i] sethintstring(string, param1, param2);
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x47b2955c, Offset: 0x16f8
// Size: 0x1bc
function trap_move_switches() {
    self trap_lights_red();
    for (i = 0; i < self._trap_switches.size; i++) {
        self._trap_switches[i] rotatepitch(180, 0.5);
        if (isdefined(self._trap_type) && self._trap_type == "fire") {
            self._trap_switches[i] playsound(#"evt_switch_flip_trap_fire");
            continue;
        }
        self._trap_switches[i] playsound(#"evt_switch_flip_trap");
    }
    self._trap_switches[0] waittill(#"rotatedone");
    self notify(#"switch_activated");
    self waittill(#"available");
    for (i = 0; i < self._trap_switches.size; i++) {
        self._trap_switches[i] rotatepitch(-180, 0.5);
    }
    self._trap_switches[0] waittill(#"rotatedone");
    self trap_lights_green();
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xeac70248, Offset: 0x18c0
// Size: 0xce
function trap_activate_fire() {
    self._trap_duration = 40;
    self._trap_cooldown_time = 60;
    fx_points = struct::get_array(self.target, "targetname");
    for (i = 0; i < fx_points.size; i++) {
        util::wait_network_frame();
        fx_points[i] thread trap_audio_fx(self);
    }
    self thread trap_damage();
    wait self._trap_duration;
    self notify(#"trap_done");
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xd2d5e675, Offset: 0x1998
// Size: 0x22e
function trap_activate_rotating() {
    self endon(#"trap_done");
    self._trap_duration = 30;
    self._trap_cooldown_time = 60;
    self thread trap_damage();
    self thread trig_update(self._trap_movers[0]);
    old_angles = self._trap_movers[0].angles;
    for (i = 0; i < self._trap_movers.size; i++) {
        self._trap_movers[i] rotateyaw(360, 5, 4.5);
    }
    wait 5;
    step = 1.5;
    for (t = 0; t < self._trap_duration; t += step) {
        for (i = 0; i < self._trap_movers.size; i++) {
            self._trap_movers[i] rotateyaw(360, step);
        }
        wait step;
    }
    for (i = 0; i < self._trap_movers.size; i++) {
        self._trap_movers[i] rotateyaw(360, 5, 0, 4.5);
    }
    wait 5;
    for (i = 0; i < self._trap_movers.size; i++) {
        self._trap_movers[i].angles = old_angles;
    }
    self notify(#"trap_done");
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1bd0
// Size: 0x4
function trap_activate_flipper() {
    
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0x2ab95c48, Offset: 0x1be0
// Size: 0x11c
function trap_audio_fx(trap) {
    if (isdefined(level._custom_traps) && isdefined(level._custom_traps[trap.script_noteworthy]) && isdefined(level._custom_traps[trap.script_noteworthy].audio)) {
        self [[ level._custom_traps[trap.script_noteworthy].audio ]](trap);
        return;
    }
    sound_origin = undefined;
    trap waittilltimeout(trap._trap_duration, #"trap_done");
    if (isdefined(sound_origin)) {
        playsoundatposition(#"wpn_zmb_electrap_stop", sound_origin.origin);
        sound_origin stoploopsound();
        waitframe(1);
        sound_origin delete();
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x590d6484, Offset: 0x1d08
// Size: 0x356
function trap_damage() {
    self endon(#"trap_done");
    while (true) {
        waitresult = self waittill(#"trigger");
        ent = waitresult.activator;
        if (isplayer(ent)) {
            if (self function_7146f101(ent)) {
                continue;
            }
            if (isdefined(level._custom_traps) && isdefined(level._custom_traps[self._trap_type]) && isdefined(level._custom_traps[self._trap_type].player_damage)) {
                ent thread [[ level._custom_traps[self._trap_type].player_damage ]](self);
            } else {
                switch (self._trap_type) {
                case #"rocket":
                    ent thread player_fire_damage();
                    break;
                case #"rotating":
                    if (ent getstance() == "stand") {
                        ent dodamage(50, ent.origin + (0, 0, 20));
                        ent setstance("crouch");
                    }
                    break;
                }
            }
            if (ent.health <= 1 && !(isdefined(ent.var_f7c7d22f) && ent.var_f7c7d22f)) {
                ent thread function_4a704efc(self);
            }
            continue;
        }
        if (!isdefined(ent.marked_for_death)) {
            if (isdefined(level._custom_traps) && isdefined(level._custom_traps[self._trap_type]) && isdefined(level._custom_traps[self._trap_type].damage)) {
                ent thread [[ level._custom_traps[self._trap_type].damage ]](self);
                continue;
            }
            switch (self._trap_type) {
            case #"rocket":
                ent thread zombie_trap_death(self, 100);
                break;
            case #"rotating":
                ent thread zombie_trap_death(self, 200);
                break;
            default:
                ent thread zombie_trap_death(self, randomint(100));
                break;
            }
        }
    }
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0x6fc0e291, Offset: 0x2068
// Size: 0xaa
function function_4a704efc(e_trap) {
    self endon(#"disconnect");
    self.var_f7c7d22f = 1;
    level notify(#"trap_kill", {#e_victim:self, #e_trap:e_trap});
    while (isalive(self) && self laststand::player_is_in_laststand()) {
        waitframe(1);
    }
    self.var_f7c7d22f = undefined;
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0x51853ea, Offset: 0x2120
// Size: 0x58
function trig_update(parent) {
    self endon(#"trap_done");
    start_angles = self.angles;
    while (true) {
        self.angles = parent.angles;
        waitframe(1);
    }
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0xd45e9d6e, Offset: 0x2180
// Size: 0x1f2
function player_elec_damage(trigger) {
    self endon(#"death", #"disconnect");
    if (!isdefined(level.elec_loop)) {
        level.elec_loop = 0;
    }
    if (!(isdefined(self.is_burning) && self.is_burning) && zm_utility::is_player_valid(self)) {
        self.is_burning = 1;
        if (isdefined(level.var_20537efa) && level.var_20537efa) {
            visionset_mgr::activate("overlay", "zm_trap_electric", self, 1.25, 1.25);
        } else {
            self setelectrified(1.25);
        }
        shocktime = 2.5;
        if (isdefined(level.str_elec_damage_shellshock_override)) {
            str_elec_shellshock = level.str_elec_damage_shellshock_override;
        } else {
            str_elec_shellshock = "electrocution";
        }
        self shellshock(str_elec_shellshock, shocktime);
        self playrumbleonentity("damage_heavy");
        if (level.elec_loop == 0) {
            elec_loop = 1;
            self playsound(#"wpn_zmb_electrap_zap");
        }
        self dodamage(150, self.origin, undefined, trigger);
        wait 1;
        self.is_burning = undefined;
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x42e27629, Offset: 0x2380
// Size: 0x196
function player_fire_damage() {
    self endon(#"death", #"disconnect");
    if (!(isdefined(self.is_burning) && self.is_burning) && !self laststand::player_is_in_laststand()) {
        self.is_burning = 1;
        if (isdefined(level.trap_fire_visionset_registered) && level.trap_fire_visionset_registered) {
            visionset_mgr::activate("overlay", "zm_trap_burn", self, 1.25, 1.25);
        } else {
            self setburn(1.25);
        }
        self notify(#"burned");
        if (!self hasperk(#"specialty_armorvest") || self.health - 100 < 1) {
            radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
            self.is_burning = undefined;
            return;
        }
        self dodamage(50, self.origin);
        wait 0.1;
        self.is_burning = undefined;
    }
}

// Namespace zm_traps/zm_traps
// Params 2, eflags: 0x0
// Checksum 0x9c8fde11, Offset: 0x2520
// Size: 0x49c
function zombie_trap_death(e_trap, param) {
    self endon(#"death");
    self.marked_for_death = 1;
    switch (e_trap._trap_type) {
    case #"rocket":
        if (isdefined(self.animname) && self.animname != "zombie_dog") {
            if (param > 90 && level.burning_zombies.size < 6) {
                level.burning_zombies[level.burning_zombies.size] = self;
                self thread zombie_flame_watch();
                self playsound(#"zmb_ignite");
                self thread zombie_death::flame_death_fx();
                playfxontag(level._effect[#"character_fire_death_torso"], self, "J_SpineLower");
                wait randomfloat(1.25);
            } else {
                refs[0] = "guts";
                refs[1] = "right_arm";
                refs[2] = "left_arm";
                refs[3] = "right_leg";
                refs[4] = "left_leg";
                refs[5] = "no_legs";
                refs[6] = "head";
                self.a.gib_ref = refs[randomint(refs.size)];
                playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);
                wait randomfloat(1.25);
                self playsound(#"wpn_zmb_electrap_zap");
            }
        }
        if (isdefined(self.var_3925c480)) {
            self [[ self.var_3925c480 ]](e_trap);
        } else {
            level notify(#"trap_kill", {#e_victim:self, #e_trap:e_trap});
            self dodamage(self.health + 666, self.origin, e_trap);
        }
        break;
    case #"rotating":
    case #"centrifuge":
        ang = vectortoangles(e_trap.origin - self.origin);
        direction_vec = vectorscale(anglestoright(ang), param);
        if (isdefined(self.var_16180c77)) {
            self [[ self.var_16180c77 ]](e_trap);
        }
        level notify(#"trap_kill", {#e_victim:self, #e_trap:e_trap});
        self startragdoll();
        self launchragdoll(direction_vec);
        util::wait_network_frame();
        self.a.gib_ref = "head";
        self dodamage(self.health, self.origin, e_trap);
        break;
    }
    if (isdefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player)) {
        e_trap.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x34081fb7, Offset: 0x29c8
// Size: 0x4c
function zombie_flame_watch() {
    self waittill(#"death");
    self stoploopsound();
    arrayremovevalue(level.burning_zombies, self);
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xb19e143a, Offset: 0x2a20
// Size: 0x8c
function play_elec_vocals() {
    if (isdefined(self)) {
        org = self.origin;
        wait 0.15;
        playsoundatposition(#"zmb_elec_vocals", org);
        playsoundatposition(#"wpn_zmb_electrap_zap", org);
        playsoundatposition(#"zmb_exp_jib_zombie", org);
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xd41f9fc5, Offset: 0x2ab8
// Size: 0x324
function electroctute_death_fx() {
    self endon(#"death");
    if (isdefined(self.is_electrocuted) && self.is_electrocuted) {
        return;
    }
    self.is_electrocuted = 1;
    self thread electrocute_timeout();
    if (self.team == level.zombie_team) {
        level.bconfiretime = gettime();
        level.bconfireorg = self.origin;
    }
    if (isdefined(level._effect[#"elec_torso"])) {
        playfxontag(level._effect[#"elec_torso"], self, "J_SpineLower");
    }
    self playsound(#"zmb_elec_jib_zombie");
    wait 1;
    tagarray = [];
    tagarray[0] = "J_Elbow_LE";
    tagarray[1] = "J_Elbow_RI";
    tagarray[2] = "J_Knee_RI";
    tagarray[3] = "J_Knee_LE";
    tagarray = array::randomize(tagarray);
    if (isdefined(level._effect[#"elec_md"])) {
        playfxontag(level._effect[#"elec_md"], self, tagarray[0]);
    }
    self playsound(#"zmb_elec_jib_zombie");
    wait 1;
    self playsound(#"zmb_elec_jib_zombie");
    tagarray[0] = "J_Wrist_RI";
    tagarray[1] = "J_Wrist_LE";
    if (!isdefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
        tagarray[2] = "J_Ankle_RI";
        tagarray[3] = "J_Ankle_LE";
    }
    tagarray = array::randomize(tagarray);
    if (isdefined(level._effect[#"elec_sm"])) {
        playfxontag(level._effect[#"elec_sm"], self, tagarray[0]);
        playfxontag(level._effect[#"elec_sm"], self, tagarray[1]);
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x4d62dfa3, Offset: 0x2de8
// Size: 0x96
function electrocute_timeout() {
    self endon(#"death");
    self playloopsound(#"amb_fire_manager_0");
    wait 12;
    self stoploopsound();
    if (isdefined(self) && isalive(self)) {
        self.is_electrocuted = 0;
        self notify(#"stop_flame_damage");
    }
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x807ce4b1, Offset: 0x2e88
// Size: 0x194
function trap_dialog() {
    self endon(#"warning_dialog");
    level endon(#"switch_flipped");
    timer = 0;
    while (true) {
        wait 0.5;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i])) {
                continue;
            }
            dist = distancesquared(players[i].origin, self.origin);
            if (dist > 4900) {
                timer = 0;
                continue;
            }
            if (dist < 4900 && timer < 3) {
                wait 0.5;
                timer++;
            }
            if (dist < 4900 && timer == 3) {
                index = zm_utility::get_player_index(players[i]);
                plr = "plr_" + index + "_";
                wait 3;
                self notify(#"warning_dialog");
            }
        }
    }
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0x564c1dea, Offset: 0x3028
// Size: 0xa2
function get_trap_array(trap_type) {
    ents = getentarray("zombie_trap", "targetname");
    traps = [];
    for (i = 0; i < ents.size; i++) {
        if (ents[i].script_noteworthy == trap_type) {
            traps[traps.size] = ents[i];
        }
    }
    return traps;
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x7e40b02, Offset: 0x30d8
// Size: 0xba
function trap_disable() {
    cooldown = self._trap_cooldown_time;
    if (self._trap_in_use) {
        self notify(#"trap_done");
        self._trap_cooldown_time = 0.05;
        self waittill(#"available");
    }
    if (self._trap_use_trigs.size > 0) {
        array::thread_all(self._trap_use_trigs, &triggerenable, 0);
    }
    self trap_lights_red();
    self._trap_cooldown_time = cooldown;
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x45e40e60, Offset: 0x31a0
// Size: 0x54
function trap_enable() {
    if (self._trap_use_trigs.size > 0) {
        array::thread_all(self._trap_use_trigs, &triggerenable, 1);
    }
    self trap_lights_green();
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xa5abeec7, Offset: 0x3200
// Size: 0xf2
function trap_model_type_init() {
    if (!isdefined(self.script_parameters)) {
        self.script_parameters = "default";
    }
    switch (self.script_parameters) {
    case #"pentagon_electric":
        self._trap_light_model_off = "zombie_trap_switch_light";
        self._trap_light_model_green = "zombie_trap_switch_light_on_green";
        self._trap_light_model_red = "zombie_trap_switch_light_on_red";
        self._trap_switch_model = "zombie_trap_switch_handle";
        break;
    case #"default":
    default:
        self._trap_light_model_off = "zombie_zapper_cagelight";
        self._trap_light_model_green = "zombie_zapper_cagelight";
        self._trap_light_model_red = "zombie_zapper_cagelight";
        self._trap_switch_model = "zombie_zapper_handle";
        break;
    }
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0x5c6e927e, Offset: 0x3300
// Size: 0x11e
function function_7146f101(e_player) {
    if (e_player hasperk(#"specialty_mod_phdflopper") || isdefined(self.var_52b1047c) && self.var_52b1047c || isdefined(e_player.var_bf33afc5) && e_player.var_bf33afc5) {
        if (e_player issliding()) {
            e_player thread function_4e6514d7();
            return true;
        } else if (isdefined(e_player.var_6e9d241c) && e_player.var_6e9d241c || isdefined(e_player.var_bf33afc5) && e_player.var_bf33afc5) {
            return true;
        }
    }
    if (e_player bgb::is_enabled(#"zm_bgb_anti_entrapment")) {
        return true;
    }
    return false;
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0xc449b8c1, Offset: 0x3428
// Size: 0x5a
function function_4e6514d7() {
    self notify(#"hash_337fc06844d7d1bb");
    self endon(#"disconnect", #"hash_337fc06844d7d1bb");
    self.var_6e9d241c = 1;
    wait 0.25;
    self.var_6e9d241c = undefined;
}

// Namespace zm_traps/zm_traps
// Params 0, eflags: 0x0
// Checksum 0x807e5004, Offset: 0x3490
// Size: 0x12
function function_c4cf2752() {
    self.var_52b1047c = 1;
}

// Namespace zm_traps/zm_traps
// Params 2, eflags: 0x0
// Checksum 0x4e608a6e, Offset: 0x34b0
// Size: 0x54
function function_4bcd0324(n_cooldown, e_player) {
    if (isdefined(e_player) && e_player hasperk(#"specialty_cooldown")) {
        n_cooldown *= 0.5;
    }
    return n_cooldown;
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0xec6ae808, Offset: 0x3510
// Size: 0x1a
function is_trap_registered(a_registered_traps) {
    return isdefined(a_registered_traps[self.script_noteworthy]);
}

// Namespace zm_traps/zm_traps
// Params 3, eflags: 0x0
// Checksum 0x8b4cea20, Offset: 0x3538
// Size: 0xce
function register_trap_basic_info(str_trap, func_activate, func_audio) {
    assert(isdefined(str_trap), "<dev string:x30>");
    assert(isdefined(func_activate), "<dev string:x6e>");
    assert(isdefined(func_audio), "<dev string:xad>");
    _register_undefined_trap(str_trap);
    level._custom_traps[str_trap].activate = func_activate;
    level._custom_traps[str_trap].audio = func_audio;
}

// Namespace zm_traps/zm_traps
// Params 1, eflags: 0x0
// Checksum 0xa5971923, Offset: 0x3610
// Size: 0x66
function _register_undefined_trap(str_trap) {
    if (!isdefined(level._custom_traps)) {
        level._custom_traps = [];
    }
    if (!isdefined(level._custom_traps[str_trap])) {
        level._custom_traps[str_trap] = spawnstruct();
    }
}

// Namespace zm_traps/zm_traps
// Params 3, eflags: 0x0
// Checksum 0x80370312, Offset: 0x3680
// Size: 0x8e
function register_trap_damage(str_trap, func_player_damage, func_damage) {
    assert(isdefined(str_trap), "<dev string:x30>");
    _register_undefined_trap(str_trap);
    level._custom_traps[str_trap].player_damage = func_player_damage;
    level._custom_traps[str_trap].damage = func_damage;
}

