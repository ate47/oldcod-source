#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace emp;

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0xa52fd3fd, Offset: 0xe8
// Size: 0xbc
function init_shared() {
    if (!isdefined(level.var_53c12be5)) {
        level.var_53c12be5 = {};
        clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int", &emp_turret_init, 0, 0);
        clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int", &emp_turret_deploy_start, 0, 0);
        thread monitor_emp_killstreaks();
    }
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0xa68e079a, Offset: 0x1b0
// Size: 0x1a0
function monitor_emp_killstreaks() {
    level endon(#"disconnect");
    if (!isdefined(level.emp_killstreaks)) {
        level.emp_killstreaks = [];
    }
    for (;;) {
        has_at_least_one_active_enemy_turret = 0;
        arrayremovevalue(level.emp_killstreaks, undefined);
        local_players = getlocalplayers();
        foreach (local_player in local_players) {
            if (local_player function_60dbc438() == 0) {
                continue;
            }
            closest_enemy_emp = get_closest_enemy_emp_killstreak(local_player);
            if (isdefined(closest_enemy_emp)) {
                has_at_least_one_active_enemy_turret = 1;
                localclientnum = local_player getlocalclientnumber();
                update_distance_to_closest_emp(localclientnum, distance(local_player.origin, closest_enemy_emp.origin));
            }
        }
        wait has_at_least_one_active_enemy_turret ? 0.1 : 0.7;
    }
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0x6048a5a9, Offset: 0x358
// Size: 0x11a
function get_closest_enemy_emp_killstreak(local_player) {
    closest_emp = undefined;
    closest_emp_distance_squared = 99999999;
    foreach (emp in level.emp_killstreaks) {
        if (emp.owner == local_player || emp.team == local_player.team) {
            continue;
        }
        distance_squared = distancesquared(local_player.origin, emp.origin);
        if (distance_squared < closest_emp_distance_squared) {
            closest_emp = emp;
            closest_emp_distance_squared = distance_squared;
        }
    }
    return closest_emp;
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0x416d5dcf, Offset: 0x480
// Size: 0x74
function update_distance_to_closest_emp(localclientnum, new_value) {
    if (!isdefined(localclientnum)) {
        return;
    }
    distance_to_closest_enemy_emp_ui_model = getuimodel(getuimodelforcontroller(localclientnum), "distanceToClosestEnemyEmpKillstreak");
    if (isdefined(distance_to_closest_enemy_emp_ui_model)) {
        setuimodelvalue(distance_to_closest_enemy_emp_ui_model, new_value);
    }
}

// Namespace emp/emp_shared
// Params 7, eflags: 0x0
// Checksum 0xfa39bc93, Offset: 0x500
// Size: 0xd4
function emp_turret_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (!newval) {
        return;
    }
    self useanimtree("generic");
    self setanimrestart(#"o_turret_emp_core_deploy", 1, 0, 0);
    self setanimtime(#"o_turret_emp_core_deploy", 0);
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0x6e4e53ce, Offset: 0x5e0
// Size: 0x54
function cleanup_fx_on_shutdown(localclientnum, handle) {
    self endon(#"kill_fx_cleanup");
    self waittill(#"death");
    stopfx(localclientnum, handle);
}

// Namespace emp/emp_shared
// Params 7, eflags: 0x0
// Checksum 0xfc8bff7a, Offset: 0x640
// Size: 0xde
function emp_turret_deploy_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self thread emp_turret_deploy(localclientnum);
        return;
    }
    self notify(#"kill_fx_cleanup");
    if (isdefined(self.fxhandle)) {
        stopfx(localclientnum, self.fxhandle);
        self.fxhandle = undefined;
    }
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0x2b9afe01, Offset: 0x728
// Size: 0x17c
function emp_turret_deploy(localclientnum) {
    self endon(#"death");
    self useanimtree("generic");
    self setanimrestart(#"o_turret_emp_core_deploy", 1, 0, 1);
    length = getanimlength(#"o_turret_emp_core_deploy");
    wait length * 0.75;
    self useanimtree("generic");
    self setanim(#"o_turret_emp_core_spin", 1);
    self.fxhandle = util::playfxontag(localclientnum, #"killstreaks/fx_emp_core", self, "tag_fx");
    self thread cleanup_fx_on_shutdown(localclientnum, self.fxhandle);
    wait length * 0.25;
    self setanim(#"o_turret_emp_core_deploy", 0);
}

