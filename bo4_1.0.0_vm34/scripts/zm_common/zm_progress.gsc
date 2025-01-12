#using script_5ab658148b984423;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_progress;

// Namespace zm_progress/level_init
// Params 1, eflags: 0x40
// Checksum 0x3c24f925, Offset: 0x130
// Size: 0x2e
function event_handler[level_init] main(eventstruct) {
    level.zm_build_progress = zm_build_progress::register("zm_build_progress");
}

// Namespace zm_progress/zm_progress
// Params 6, eflags: 0x0
// Checksum 0x9a2346e1, Offset: 0x168
// Size: 0x156
function function_77f3eafe(var_ac3b561e, var_dbcad541, var_22a29334, var_d27f12ac, var_236c74d9, var_c4e182ff) {
    params = spawnstruct();
    params.var_70356403 = 1;
    params.var_5d9588a7 = 0.76;
    params.var_804ce69e = int(3000);
    params.var_352c1778 = getweapon(#"zombie_builder");
    params.fx_name = level._effect[#"building_dust"];
    params.fx_loop = 0.5;
    params.var_ac3b561e = var_ac3b561e;
    params.var_dbcad541 = var_dbcad541;
    params.var_22a29334 = var_22a29334;
    params.var_d27f12ac = var_d27f12ac;
    params.var_236c74d9 = var_236c74d9;
    params.var_c4e182ff = var_c4e182ff;
    return params;
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x0
// Checksum 0x8226e07a, Offset: 0x2c8
// Size: 0x22
function function_6d677d88(params, w_weapon) {
    params.var_352c1778 = w_weapon;
}

// Namespace zm_progress/zm_progress
// Params 3, eflags: 0x4
// Checksum 0x94f98d33, Offset: 0x2f8
// Size: 0x27a
function private function_eb27f7aa(params, unitrigger, b_start) {
    if (!isdefined(self)) {
        return false;
    }
    if (!zm_utility::is_player_valid(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger()) {
        return false;
    }
    if (!self usebuttonpressed()) {
        return false;
    }
    trigger = unitrigger zm_unitrigger::unitrigger_trigger(self);
    if (!isdefined(trigger)) {
        return false;
    }
    if (b_start) {
        if (isdefined(params.var_ac3b561e) && ![[ params.var_ac3b561e ]](self, unitrigger)) {
            return false;
        }
    } else if (isdefined(params.var_dbcad541) && ![[ params.var_dbcad541 ]](self, unitrigger)) {
        return false;
    }
    if (isdefined(params.var_70356403) && params.var_70356403 && !self util::is_player_looking_at(trigger.origin, params.var_5d9588a7)) {
        return false;
    }
    if (unitrigger.script_unitrigger_type == "unitrigger_radius_use") {
        torigin = unitrigger zm_unitrigger::unitrigger_origin();
        porigin = self geteye();
        radius_sq = 2.25 * unitrigger.radius * unitrigger.radius;
        if (distance2dsquared(torigin, porigin) > radius_sq) {
            return false;
        }
    } else if (!isdefined(trigger) || !trigger istouching(self, (10, 10, 10))) {
        return false;
    }
    return true;
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x4
// Checksum 0x3f98a6d4, Offset: 0x580
// Size: 0x32
function private function_c580a3ce(params, unitrigger) {
    return function_eb27f7aa(params, unitrigger, 1);
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x4
// Checksum 0xbdcca93b, Offset: 0x5c0
// Size: 0x32
function private function_e6b98277(params, unitrigger) {
    return function_eb27f7aa(params, unitrigger, 0);
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x4
// Checksum 0x622b64, Offset: 0x600
// Size: 0xce
function private player_progress_bar_update(start_time, use_time) {
    self endon(#"entering_last_stand", #"death", #"progress_end");
    while (isdefined(self) && gettime() - start_time < use_time) {
        progress = (gettime() - start_time) / use_time;
        if (progress < 0) {
            progress = 0;
        }
        if (progress > 1) {
            progress = 1;
        }
        level.zm_build_progress zm_build_progress::set_progress(self, progress);
        waitframe(1);
    }
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x4
// Checksum 0xcad9d6, Offset: 0x6d8
// Size: 0xa4
function private player_progress_bar(start_time, use_time) {
    if (level.zm_build_progress zm_build_progress::is_open(self) || !isdefined(start_time) || !isdefined(use_time)) {
        return;
    }
    level.zm_build_progress zm_build_progress::open(self);
    self player_progress_bar_update(start_time, use_time);
    level.zm_build_progress zm_build_progress::close(self);
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x0
// Checksum 0xebde29c1, Offset: 0x788
// Size: 0xf2
function function_e186cf36(player, params) {
    self endon(#"kill_trigger", #"progress_succeed", #"progress_failed");
    while (isdefined(params.fx_name)) {
        angles = player getplayerangles();
        forwarddir = anglestoforward(angles);
        playfx(params.fx_name, player getplayercamerapos(), forwarddir, (0, 1, 0));
        if (params.fx_loop > 0) {
            wait params.fx_loop;
            continue;
        }
        return;
    }
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x4
// Checksum 0x6799b5df, Offset: 0x888
// Size: 0x486
function private function_983e1fd3(player, params) {
    b_waited = 0;
    if (!isdefined(self)) {
        assertmsg("<dev string:x30>");
        if (!(isdefined(b_waited) && b_waited)) {
            b_waited = 1;
            waitframe(1);
        }
        return;
    }
    if (isdefined(params.var_22a29334)) {
        thread [[ params.var_22a29334 ]](player, self);
    }
    self.use_time = params.var_804ce69e;
    self.var_5ef67493 = gettime();
    use_time = self.use_time;
    var_5ef67493 = self.var_5ef67493;
    var_dba661f8 = params.var_352c1778 != level.weaponnone;
    if (use_time > 0) {
        player zm_utility::disable_player_move_states(1);
        player.var_885c20e3 = 1;
        player zm_utility::increment_is_drinking();
        if (var_dba661f8) {
            orgweapon = player getcurrentweapon();
            build_weapon = params.var_352c1778;
            player giveweapon(build_weapon);
            player switchtoweapon(build_weapon);
        }
        player thread player_progress_bar(var_5ef67493, use_time);
        while (isdefined(self) && player function_e6b98277(params, self) && gettime() - self.var_5ef67493 < self.use_time) {
            b_waited = 1;
            waitframe(1);
            if (!isdefined(self)) {
                assertmsg("<dev string:x30>");
                if (!(isdefined(b_waited) && b_waited)) {
                    b_waited = 1;
                    waitframe(1);
                }
                return;
            }
        }
        if (isdefined(player)) {
            player notify(#"progress_end");
            if (var_dba661f8) {
                player zm_weapons::switch_back_primary_weapon(orgweapon);
                player takeweapon(build_weapon);
            }
            if (isdefined(player.is_drinking) && player.is_drinking) {
                player zm_utility::decrement_is_drinking();
            }
            player.var_885c20e3 = 0;
            player zm_utility::enable_player_move_states();
        }
    }
    result = "progress_failed";
    if (isdefined(self) && player function_e6b98277(params, self) && (self.use_time <= 0 || gettime() - self.var_5ef67493 >= self.use_time)) {
        if (isdefined(params.var_236c74d9)) {
            thread [[ params.var_236c74d9 ]](player, self);
        }
        result = "progress_succeed";
    } else {
        if (isdefined(params.var_d27f12ac)) {
            thread [[ params.var_d27f12ac ]](player, self);
        }
        result = "progress_failed";
    }
    if (isdefined(params.var_c4e182ff)) {
        thread [[ params.var_c4e182ff ]](player, self);
    }
    if (!(isdefined(b_waited) && b_waited)) {
        b_waited = 1;
        waitframe(1);
    }
    if (!isdefined(self)) {
        assertmsg("<dev string:x30>");
        if (!(isdefined(b_waited) && b_waited)) {
            b_waited = 1;
            waitframe(1);
        }
        return;
    }
    self notify(result);
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x4
// Checksum 0xae82d52e, Offset: 0xd18
// Size: 0x94
function private function_6989a52d(player, params) {
    self thread function_e186cf36(player, params);
    self thread function_983e1fd3(player, params);
    retval = self waittill(#"progress_succeed", #"progress_failed");
    if (retval._notify == "progress_succeed") {
        return true;
    }
    return false;
}

// Namespace zm_progress/zm_progress
// Params 2, eflags: 0x0
// Checksum 0xf00a658e, Offset: 0xdb8
// Size: 0xac
function progress_think(player, params) {
    status = player function_c580a3ce(params, self.stub);
    if (!status) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return 0;
    }
    return self.stub function_6989a52d(player, params);
}

