#using script_1940fc077a028a81;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_utility;

#namespace awareness;

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x6
// Checksum 0x89cafe52, Offset: 0x160
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"awareness", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x5 linked
// Checksum 0x28ab92e3, Offset: 0x1a8
// Size: 0x124
function private function_70a657d8() {
    level thread function_3041c2b8();
    level thread function_7a84e563();
    level.var_70dd6a1e = 1;
    level.var_782a62e0 = 0;
    level.var_7015803 = [];
    level.var_812c573d = new throttle();
    [[ level.var_812c573d ]]->initialize();
    level.var_108771cb = new throttle();
    [[ level.var_108771cb ]]->initialize();
    callback::on_ai_spawned(&function_4645d5f8);
    clientfield::register("actor", "sndAwarenessChange", 1, 2, "int");
    /#
        level thread function_dfe1997a();
    #/
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x0
// Checksum 0x618f53bc, Offset: 0x2d8
// Size: 0x42
function function_306a15d8(entity, radius) {
    if (radius > level.var_782a62e0) {
        level.var_782a62e0 = radius;
    }
    entity.var_88d7b5b4 = radius;
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0xd3a78b3d, Offset: 0x328
// Size: 0x48
function function_a2e5f01d(entity) {
    if (!isinarray(level.var_7015803, entity)) {
        level.var_7015803[level.var_7015803.size] = entity;
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0x9799fbe3, Offset: 0x378
// Size: 0x2c
function function_d703c8f8(entity) {
    arrayremovevalue(level.var_7015803, entity);
}

// Namespace awareness/namespace_df233b8a
// Params 5, eflags: 0x1 linked
// Checksum 0xb6345790, Offset: 0x3b0
// Size: 0x9c
function function_e732359c(type, position, var_4603c944, entity, params) {
    level.var_ee6c4739[level.var_ee6c4739.size] = {#type:type, #position:position, #radius:var_4603c944, #entity:entity, #params:params};
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0xde588bd2, Offset: 0x458
// Size: 0x380
function function_9d0a9f4e(entity, awareness_event) {
    /#
        if (getdvarint(#"hash_7228e2918da6da2a", 0) > 1) {
            colors = array((1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0), (0, 0, 1), (1, 0, 1), (1, 0.752941, 0.796078), (0, 1, 1));
            if (!isdefined(self.var_12726112)) {
                self.var_12726112 = 0;
            }
            var_a6373be0 = colors[self.var_12726112];
            self.var_12726112 = (self.var_12726112 + 1) % colors.size;
            start_pos = entity.origin + (0, 0, entity function_6a9ae71() / 2);
            recordline(start_pos, awareness_event.position, var_a6373be0, "<dev string:x38>", entity);
        }
    #/
    if (isdefined(self.var_3eaac485) && self.var_3eaac485 > gettime()) {
        /#
            if (getdvarint(#"hash_7228e2918da6da2a", 0) > 1) {
                record3dtext("<dev string:x42>", (start_pos + awareness_event.position) / 2, var_a6373be0, "<dev string:x38>", entity);
            }
        #/
        return false;
    }
    if (self isplayinganimscripted()) {
        /#
            if (getdvarint(#"hash_7228e2918da6da2a", 0) > 1) {
                record3dtext("<dev string:x69>", (start_pos + awareness_event.position) / 2, var_a6373be0, "<dev string:x38>", entity);
            }
        #/
        return false;
    }
    if (isdefined(entity.var_b4b8ad5f)) {
        if (distancesquared(entity.var_b4b8ad5f.position, awareness_event.position) <= function_a3f6cdac(256)) {
            /#
                if (getdvarint(#"hash_7228e2918da6da2a", 0) > 1) {
                    record3dtext("<dev string:x94>", (start_pos + awareness_event.position) / 2, var_a6373be0, "<dev string:x38>", entity);
                }
            #/
            return false;
        }
    }
    /#
        if (getdvarint(#"hash_7228e2918da6da2a", 0) > 1) {
            record3dtext("<dev string:xc4>", (start_pos + awareness_event.position) / 2, var_a6373be0, "<dev string:x38>", entity);
        }
    #/
    return true;
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0x3e639425, Offset: 0x7e0
// Size: 0x22
function function_1db27761(entity, event) {
    entity.var_b4b8ad5f = event;
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0xe9af78ce, Offset: 0x810
// Size: 0x2c
function pause(entity) {
    entity flag::set(#"hash_624e5d5dfb7f742b");
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0xd965936e, Offset: 0x848
// Size: 0x2c
function resume(entity) {
    entity flag::clear(#"hash_624e5d5dfb7f742b");
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xdac06f63, Offset: 0x880
// Size: 0x3c
function function_cf2fab43(event) {
    if (function_9d0a9f4e(self, event)) {
        function_1db27761(self, event);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x5 linked
// Checksum 0xbb56c458, Offset: 0x8c8
// Size: 0x110
function private function_3041c2b8() {
    level endon(#"game_ended");
    while (true) {
        waitresult = level waittill(#"glass_smash");
        origin = undefined;
        radius = undefined;
        entity = undefined;
        if (waitresult._notify === #"glass_smash") {
            origin = waitresult.position;
            radius = 800;
            ai = getentitiesinradius(origin, 50, 15);
            if (ai.size > 0) {
                continue;
            }
        }
        if (isdefined(origin) && isdefined(radius)) {
            function_e732359c(0, origin, radius, entity);
        }
    }
}

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x5 linked
// Checksum 0x1bcaabf, Offset: 0x9e0
// Size: 0x88
function private function_7a84e563() {
    level endon(#"game_ended");
    level.var_ee6c4739 = [];
    while (true) {
        waitframe(1);
        if (level.var_ee6c4739.size > 0) {
            event = array::pop(level.var_ee6c4739, 0, 0);
            function_83baeaf1(event);
        }
    }
}

// Namespace awareness/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0xc715ab1e, Offset: 0xa70
// Size: 0xb4
function event_handler[enter_vehicle] function_8a544559(eventstruct) {
    if (!is_true(level.var_70dd6a1e)) {
        return;
    }
    if (!isplayer(self) || !namespace_85745671::function_44a83b40(eventstruct.vehicle)) {
        return;
    }
    eventstruct.vehicle callback::function_d8abfc3d(#"hash_6e388f6a0df7bdac", &function_1d61b6d6);
    eventstruct.vehicle thread function_44454d0f();
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x5 linked
// Checksum 0x7a6c036e, Offset: 0xb30
// Size: 0x5c
function private function_1d61b6d6(params) {
    self.var_4efd1a01 = params.var_d8ceeba3;
    if (is_true(self.var_4efd1a01)) {
        function_e732359c(0, self.origin, 5000, self);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x822fc132, Offset: 0xb98
// Size: 0xd0
function function_44454d0f(n_radius) {
    self notify(#"hash_2ccfddebdf6bcf98");
    self endon(#"death", #"hash_2ccfddebdf6bcf98");
    if (isdefined(n_radius)) {
        var_80121938 = n_radius;
    } else {
        var_80121938 = 2000;
    }
    while (true) {
        var_fb6494ee = var_80121938;
        if (is_true(self.var_4efd1a01)) {
            var_fb6494ee = 5000;
        }
        function_e732359c(0, self.origin, var_fb6494ee, self);
        wait 0.5;
    }
}

// Namespace awareness/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0xb85fb1a, Offset: 0xc70
// Size: 0xb4
function event_handler[exit_vehicle] function_af1a8e24(eventstruct) {
    if (!is_true(level.var_70dd6a1e)) {
        return;
    }
    if (!isplayer(self) || !namespace_85745671::function_44a83b40(eventstruct.vehicle)) {
        return;
    }
    eventstruct.vehicle callback::function_52ac9652(#"hash_6e388f6a0df7bdac", &function_1d61b6d6);
    eventstruct.vehicle notify(#"hash_2ccfddebdf6bcf98");
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x5 linked
// Checksum 0xe4357a02, Offset: 0xd30
// Size: 0x228
function private function_83baeaf1(event) {
    /#
        if (getdvarint(#"hash_7228e2918da6da2a", 0)) {
            function_fbae6630(event);
        }
    #/
    close_ai = getentitiesinradius(event.position, event.radius + level.var_782a62e0, 15);
    foreach (ai in close_ai) {
        var_88d7b5b4 = isdefined(ai.var_88d7b5b4) ? ai.var_88d7b5b4 : 0;
        if (distancesquared(event.position, ai.origin) > function_a3f6cdac(event.radius + var_88d7b5b4) || abs(event.position[2] - ai.origin[2]) > 300) {
            continue;
        }
        ai callback::callback(#"awareness_event", {#type:event.type, #entity:event.entity, #position:event.position, #params:event.params});
    }
}

// Namespace awareness/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xb6304489, Offset: 0xf60
// Size: 0x44
function event_handler[grenade_fire] function_da91200f(eventstruct) {
    if (!is_true(level.var_70dd6a1e)) {
        return;
    }
    eventstruct.projectile thread function_bf26aaf9();
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x5 linked
// Checksum 0x8dbd443c, Offset: 0xfb0
// Size: 0x74
function private function_bf26aaf9(*params) {
    self endon(#"death");
    waitresult = self waittill(#"grenade_bounce");
    if (isdefined(waitresult)) {
        function_e732359c(0, waitresult.position, 256, self);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x5 linked
// Checksum 0x9e63942f, Offset: 0x1030
// Size: 0x2be
function private function_4645d5f8(*params) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"gunshot", #"explode", #"hash_c77d45f3ba174cb", #"alert");
        if (self.current_state.name === #"chase") {
            self waittill(#"state_changed");
            continue;
        }
        switch (waitresult._notify) {
        case #"gunshot":
            self callback::callback(#"awareness_event", {#type:0, #entity:waitresult.suppressor, #position:waitresult.position});
            break;
        case #"explode":
            self callback::callback(#"awareness_event", {#type:2, #entity:waitresult.owner, #position:waitresult.position, #params:{#radius:1024}});
            break;
        case #"hash_c77d45f3ba174cb":
            self callback::callback(#"awareness_event", {#type:3, #entity:waitresult.originator, #position:waitresult.originator.origin, #params:{#enemy:waitresult.originator.enemy}});
            break;
        case #"alert":
            self.var_1033fa72 = 1;
            break;
        }
    }
}

// Namespace awareness/namespace_df233b8a
// Params 7, eflags: 0x1 linked
// Checksum 0xd489392c, Offset: 0x12f8
// Size: 0xf4
function register_state(entity, name, enter, update, exit, target_update, debug_update) {
    if (!isdefined(entity.var_d2a0e298)) {
        entity.var_d2a0e298 = [];
    }
    assert(!isdefined(entity.var_d2a0e298[name]));
    entity.var_d2a0e298[name] = {#name:name, #enter_func:enter, #update_func:update, #exit_func:exit, #target_func:target_update, #debug_func:debug_update};
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0xde2b01e9, Offset: 0x13f8
// Size: 0x16c
function set_state(entity, state_name) {
    assert(isdefined(entity.var_d2a0e298[state_name]), "<dev string:xd6>" + (ishash(state_name) ? function_9e72a96(state_name) : state_name));
    state = entity.var_d2a0e298[state_name];
    if (isdefined(entity.current_state)) {
        if (isdefined(entity.current_state.exit_func)) {
            [[ entity.current_state.exit_func ]](entity);
        }
        entity callback::callback(#"hash_540e54ba804a87b9");
    }
    entity notify(#"state_changed");
    if (isdefined(state) && isdefined(state.enter_func)) {
        [[ state.enter_func ]](entity);
    }
    entity.current_state = state;
    entity callback::callback(#"hash_4afe635f36531659");
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x4ae098e, Offset: 0x1570
// Size: 0x90
function target_update(entity) {
    if (flag::get(#"hash_624e5d5dfb7f742b")) {
        return;
    }
    if (entity function_dd070839()) {
        return;
    }
    if (isdefined(entity.current_state) && isdefined(entity.current_state.target_func)) {
        entity [[ entity.current_state.target_func ]](entity);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x1 linked
// Checksum 0x4959b568, Offset: 0x1608
// Size: 0x41a
function function_fa6e010d() {
    level endon(#"game_ended");
    self endon(#"death");
    while (true) {
        if ((self getentitynumber() & 1) == (getlevelframenumber() & 1) || flag::get(#"hash_624e5d5dfb7f742b")) {
            /#
                if (getdvarint(#"hash_7228e2918da6da2a", 0) && flag::get(#"hash_624e5d5dfb7f742b")) {
                    if (getdvarint(#"recorder_enablerec", 0)) {
                        record3dtext("<dev string:x10d>", self.origin, (0, 1, 1), "<dev string:x38>", self);
                    } else {
                        print3d(self.origin, "<dev string:x10d>", (0, 1, 1), 1, 1);
                    }
                }
            #/
            if (getplayers(undefined, self.origin, getdvarint(#"hash_40e792a0b1b00e89", 5000)).size) {
                waitframe(1);
            } else {
                self waittilltimeout(1, #"hash_7a49c65fe733bb0b", #"state_changed", #"hash_1ea32021fdf52a8b");
            }
            continue;
        }
        if (isdefined(self.current_state) && isdefined(self.current_state.update_func)) {
            [[ self.current_state.update_func ]](self);
        }
        /#
            if (isdefined(self.current_state) && getdvarint(#"hash_7228e2918da6da2a", 0)) {
                if (getdvarint(#"recorder_enablerec", 0)) {
                    record3dtext(function_9e72a96(self.current_state.name), self.origin, (0, 1, 1), "<dev string:x38>", self);
                } else {
                    print3d(self.origin, function_9e72a96(self.current_state.name), (0, 1, 1), 1, 1);
                }
                if (is_true(self.var_1033fa72)) {
                    if (getdvarint(#"recorder_enablerec", 0)) {
                        record3dtext("<dev string:x117>", self.origin, (0, 1, 1), "<dev string:x38>", self);
                    } else {
                        print3d(self.origin, "<dev string:x117>", (0, 1, 1), 1, 1);
                    }
                }
                if (isdefined(self.current_state.debug_func)) {
                    [[ self.current_state.debug_func ]](self);
                }
            }
        #/
        waitframe(1);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xba7d6862, Offset: 0x1a30
// Size: 0x104
function function_5f511313(params) {
    if (isdefined(params.eattacker) && isdefined(params) && isdefined(self.current_state) && self.current_state.name !== #"chase" && distancesquared(params.eattacker.origin, self.origin) <= function_a3f6cdac(5000) && function_4df0b826(self, params.eattacker)) {
        set_state(self, #"chase");
        function_c241ef9a(self, params.eattacker, -1);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 5, eflags: 0x1 linked
// Checksum 0xc9204135, Offset: 0x1b40
// Size: 0x1fe
function function_b184324d(origin, radius, var_5e8ea34a = 0, dist_from_boundary = 15, var_5e95f317 = dist_from_boundary) {
    theta = randomfloatrange(0, 360);
    var_34b0ef7b = anglestoforward((0, theta, 0));
    var_43c4564a = 0;
    if (radius > 0) {
        var_43c4564a = min(var_5e8ea34a / radius, 0.99);
    }
    point = (var_34b0ef7b[0] * radius * randomfloatrange(var_43c4564a, 1), var_34b0ef7b[1] * radius * randomfloatrange(var_43c4564a, 1), 0);
    point = (origin[0] + point[0], origin[1] + point[1], origin[2]);
    if (isdefined(point)) {
        /#
            recordstar(point, (0, 0, 1), "<dev string:x38>", self);
        #/
        point = checknavmeshdirection(origin, point - origin, max(distance(point, origin), dist_from_boundary), var_5e95f317);
        return getclosestpointonnavmesh(point, var_5e95f317, dist_from_boundary);
    }
    return undefined;
}

// Namespace awareness/namespace_df233b8a
// Params 6, eflags: 0x1 linked
// Checksum 0xf8cdfc9b, Offset: 0x1d48
// Size: 0x116
function function_496e0dbc(entity, origin, radius, var_5e8ea34a = 0, dist_from_boundary = 15, height) {
    queryresult = positionquery_source_navigation(origin, var_5e8ea34a, radius, max(height, 10) / 2, dist_from_boundary, entity);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    queryresult.data = function_7b8e26b3(queryresult.data, 0, "inClaimedLocation");
    if (isdefined(queryresult) && queryresult.data.size > 0) {
        return queryresult.data[0].origin;
    }
    return undefined;
}

/#

    // Namespace awareness/namespace_df233b8a
    // Params 1, eflags: 0x1 linked
    // Checksum 0xffa0b441, Offset: 0x1e68
    // Size: 0x1f8
    function function_555d960b(entity) {
        if (isdefined(entity.spawn_point) && isdefined(entity.wander_radius)) {
            circle(entity.spawn_point.origin, int(entity.wander_radius), (0, 1, 1), 1, 1, 1);
        }
        goalinfo = entity function_4794d6a3();
        if (isdefined(goalinfo)) {
            debugstar(goalinfo.goalpos, 1, (0, 1, 0));
        }
        if (isdefined(entity.var_1267fdea)) {
            record3dtext("<dev string:x12e>" + int(entity.var_1267fdea * 1000), entity.origin, (0, 1, 0), "<dev string:x38>", entity);
        }
        foreach (index, var_1d3d7802 in entity.var_eb5eeb0f) {
            record3dtext("<dev string:x13f>" + index + "<dev string:x14b>" + gettime() - var_1d3d7802, entity.origin, (0, 1, 0), "<dev string:x38>", entity);
        }
    }

#/

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x4309186a, Offset: 0x2068
// Size: 0x124
function function_9c9d96b5(entity) {
    if (self.current_state.name === #"chase" || self.current_state.name === #"investigate") {
        self.var_2772a472 = 1;
    }
    self.var_9f6112bb = 1;
    entity.ignoreexplosionevents = 1;
    entity.awarenesslevelcurrent = "unaware";
    if (!isdefined(entity.var_6324ed63) || gettime() >= entity.var_6324ed63) {
        entity.favoriteenemy = undefined;
    }
    entity.var_eb5eeb0f = [];
    if (ispointonnavmesh(entity.origin, entity)) {
        entity thread function_3bac247(entity);
    }
    entity callback::function_d8abfc3d(#"awareness_event", &function_cf2fab43);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x2061c248, Offset: 0x2198
// Size: 0x24
function function_3b4cac9b(*notifyhash) {
    [[ level.var_108771cb ]]->leavequeue(self);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x76787ae6, Offset: 0x21c8
// Size: 0x488
function function_3bac247(entity) {
    entity endoncallback(&function_3b4cac9b, #"death", #"state_changed");
    origin = entity.origin;
    var_af6bd013 = entity getpathfindingradius() * 1.2;
    var_e49abf9f = isdefined(entity.var_958e7ee4) ? entity.var_958e7ee4 : 3;
    var_a33458ef = isdefined(entity.var_eb3258b) ? entity.var_eb3258b : 5;
    var_f0b43a45 = isdefined(entity.var_e4514346) ? entity.var_e4514346 : 1;
    var_7f4fe0f1 = isdefined(entity.var_f6ea781c) ? entity.var_f6ea781c : 3;
    entity.wander_radius = isdefined(entity.spawn_point.wander_radius) ? entity.spawn_point.wander_radius : 128;
    while (true) {
        flag::wait_till_clear(#"hash_624e5d5dfb7f742b");
        [[ level.var_108771cb ]]->waitinqueue(entity);
        if (isdefined(entity.spawn_point) && isdefined(entity.spawn_point.origin)) {
            goal = function_b184324d(entity.spawn_point.origin, entity.wander_radius, entity getpathfindingradius() * 1.2, var_af6bd013);
        } else {
            goal = function_b184324d(entity.origin, 300, 100, var_af6bd013, entity getpathfindingradius());
            /#
                if (getdvarint(#"hash_50e7f4258cd6dd5", 0)) {
                    type = "<dev string:x152>";
                }
            #/
        }
        if (flag::get(#"hash_624e5d5dfb7f742b")) {
            continue;
        }
        if (!isdefined(goal)) {
            goal = entity.origin;
        }
        entity setgoal(goal);
        if (!getdvarint(#"hash_50e7f4258cd6dd5", 0)) {
            waitresult = entity waittilltimeout(randomfloatrange(var_e49abf9f, var_a33458ef), #"goal");
        } else {
            /#
                waitresult = entity waittilltimeout(randomfloatrange(var_e49abf9f, var_a33458ef), #"goal", #"bad_path");
                if (waitresult._notify === #"bad_path") {
                    /#
                        debugstar(waitresult.position, 100, (1, 0, 1), type);
                        line(entity.origin, waitresult.position, (1, 0, 1), 1, 0, 100);
                    #/
                }
            #/
        }
        if (waitresult._notify === #"goal" || waitresult._notify === #"bad_path") {
            wait randomfloatrange(var_f0b43a45, var_7f4fe0f1);
        }
    }
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0x4c74829, Offset: 0x2658
// Size: 0x116
function function_c91092d2(var_f83c1c54, var_4972773c) {
    var_27cd0f02 = self seerecently(var_f83c1c54, 1);
    if (!var_27cd0f02) {
        self.var_eb5eeb0f[var_f83c1c54 getentitynumber()] = undefined;
        if (!isdefined(var_4972773c)) {
            return false;
        }
    } else {
        if (!isdefined(self.var_eb5eeb0f[var_f83c1c54 getentitynumber()])) {
            self.var_eb5eeb0f[var_f83c1c54 getentitynumber()] = gettime();
        }
        if (!isdefined(var_4972773c)) {
            return true;
        }
    }
    return var_27cd0f02 && gettime() - self.var_eb5eeb0f[var_f83c1c54 getentitynumber()] > int(var_4972773c * 1000);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x4881860f, Offset: 0x2778
// Size: 0x224
function function_4ebe4a6d(entity) {
    if (isdefined(entity.enemy) && function_4df0b826(entity, entity.enemy)) {
        var_e91a592a = entity function_c91092d2(entity.enemy, entity.var_1267fdea) || entity seerecently(entity.enemy, 1) && namespace_85745671::function_142c3c86(entity.enemy);
        var_7be806db = entity attackedrecently(entity.enemy, 1);
        var_8bbedf63 = entity.enemy attackedrecently(entity, 1);
        if (var_e91a592a || var_7be806db || var_8bbedf63) {
            entity.favoriteenemy = entity.enemy;
            entity.var_5aaa7f76 = entity.favoriteenemy.origin;
        }
    }
    if (isdefined(entity.favoriteenemy) || isdefined(entity.enemy_override) || isdefined(entity.attackable)) {
        set_state(entity, #"chase");
        return;
    }
    if (isdefined(entity.var_b4b8ad5f)) {
        set_state(entity, #"investigate");
        return;
    }
    if (!is_true(entity.got_to_entrance)) {
        function_7c72a5c7(entity);
    }
    function_fd83d499(entity);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x5d8e8bb9, Offset: 0x29a8
// Size: 0x54
function function_b264a0bc(entity) {
    entity.ignoreexplosionevents = 0;
    entity.wander_radius = undefined;
    entity callback::function_52ac9652(#"awareness_event", &function_cf2fab43);
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0x5a02947c, Offset: 0x2a08
// Size: 0x7c
function function_4df0b826(entity, enemy) {
    if (!isdefined(entity.var_341387d5) || !isdefined(entity.var_b518f045)) {
        return true;
    }
    return distance2dsquared(entity.var_341387d5, enemy.origin) <= function_a3f6cdac(entity.var_b518f045);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x27737c3, Offset: 0x2a90
// Size: 0x3c
function function_853a6d58(event) {
    if (function_9d0a9f4e(self, event)) {
        self thread function_2eab2251(self, event);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x3c512f19, Offset: 0x2ad8
// Size: 0x84
function function_b41f0471(entity) {
    assert(isdefined(entity.var_b4b8ad5f));
    entity.var_eb5eeb0f = [];
    callback::function_d8abfc3d(#"awareness_event", &function_853a6d58);
    entity thread function_2eab2251(entity, entity.var_b4b8ad5f);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xcca95d4f, Offset: 0x2b68
// Size: 0x24
function function_56907d56(*notifyhash) {
    [[ level.var_812c573d ]]->leavequeue(self);
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0x2d9fe748, Offset: 0x2b98
// Size: 0xd2
function function_6938f39b(entity, awareness_event) {
    if (distancesquared(entity.origin, awareness_event.position) < 200) {
        function_c241ef9a(entity, awareness_event.params.enemy, -1);
        set_state(entity, #"chase");
        return true;
    } else if (!isdefined(awareness_event.entity) || !entity seerecently(awareness_event.entity, 1)) {
        return false;
    }
    return true;
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0xaa133a4f, Offset: 0x2c78
// Size: 0x63c
function function_2eab2251(entity, awareness_event) {
    self notify(#"hash_1ea32021fdf52a8b");
    self endoncallback(&function_56907d56, #"death", #"state_changed", #"hash_1ea32021fdf52a8b");
    investigate_point = undefined;
    var_2e7ba82c = undefined;
    var_79c2b6b8 = 256;
    if (isdefined(awareness_event)) {
        switch (awareness_event.type) {
        case 0:
            var_2e7ba82c = awareness_event.position;
            break;
        case 1:
            var_2e7ba82c = awareness_event.params.position;
            break;
        case 2:
            var_2e7ba82c = awareness_event.position;
            var_79c2b6b8 = awareness_event.params.radius;
            break;
        case 3:
            var_2e7ba82c = awareness_event.params.enemy.origin;
            if (!function_6938f39b(entity, awareness_event)) {
                return;
            }
            break;
        }
        entity.var_5aaa7f76 = var_2e7ba82c;
        entity.awarenesslevelcurrent = "low_alert";
        /#
            recordstar(entity.var_5aaa7f76, (0, 1, 0), "<dev string:x38>", entity);
            recordline(entity.origin, entity.var_5aaa7f76, (0, 1, 0), "<dev string:x38>", entity);
            record3dtext("<dev string:x16b>", entity.var_5aaa7f76, (0, 1, 0), "<dev string:x38>", entity);
            record3dtext("<dev string:x180>", entity.origin, (0, 1, 0), "<dev string:x38>", entity);
        #/
        [[ level.var_812c573d ]]->waitinqueue(entity);
        investigate_point = function_496e0dbc(entity, var_2e7ba82c, 256, 8, entity getpathfindingradius() * 1.2, 200);
    }
    if (!isdefined(investigate_point) && isdefined(var_2e7ba82c)) {
        /#
            if (getdvarint(#"hash_7228e2918da6da2a", 0)) {
                record3dtext("<dev string:x19a>", entity.origin, (1, 0, 0), "<dev string:x38>", entity);
            }
        #/
        investigate_point = checknavmeshdirection(entity.origin, var_2e7ba82c - entity.origin, distance(var_2e7ba82c, entity.origin) * randomfloatrange(0.8, 1.2), entity getpathfindingradius());
    }
    if (!isdefined(investigate_point) || distancesquared(entity.origin, investigate_point) <= function_a3f6cdac(entity.goalradius)) {
        /#
            if (getdvarint(#"hash_7228e2918da6da2a", 0)) {
                record3dtext("<dev string:x1d0>", entity.origin, (1, 0, 0), "<dev string:x38>", entity);
            }
        #/
        entity setgoal(entity.origin);
        wait randomfloatrange(2, 5);
        if (isdefined(awareness_event) && awareness_event === entity.var_b4b8ad5f) {
            function_1db27761(entity, undefined);
        }
        return;
    }
    if (flag::get(#"hash_624e5d5dfb7f742b")) {
        return;
    }
    function_1db27761(entity, awareness_event);
    if (!entity isingoal(investigate_point)) {
        entity setgoal(investigate_point);
        waitresult = entity waittill(#"goal", #"bad_path");
        if (isdefined(waitresult) && waitresult._notify == #"bad_path") {
            self.var_3eaac485 = gettime() + int(randomfloatrange(1.5, 2.5) * 1000);
            self setgoal(self.origin);
        }
        wait randomfloatrange(2, 5);
    } else {
        wait randomfloatrange(2, 5);
    }
    function_1db27761(entity, undefined);
}

/#

    // Namespace awareness/namespace_df233b8a
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9a49ec65, Offset: 0x32c0
    // Size: 0x198
    function function_a360dd00(entity) {
        if (isdefined(entity.goalpos)) {
            debugstar(entity.goalpos, 1, (0, 0, 1));
            line(entity.origin, entity.goalpos, (0, 0, 1), 1, 1, 1);
        }
        if (isdefined(entity.var_1267fdea)) {
            record3dtext("<dev string:x12e>" + int(entity.var_1267fdea * 1000), entity.origin, (0, 1, 0), "<dev string:x38>", entity);
        }
        foreach (index, var_1d3d7802 in entity.var_eb5eeb0f) {
            record3dtext("<dev string:x13f>" + index + "<dev string:x14b>" + gettime() - var_1d3d7802, entity.origin, (0, 1, 0), "<dev string:x38>", entity);
        }
    }

#/

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xd35fd1df, Offset: 0x3460
// Size: 0x20e
function function_9eefc327(entity) {
    if (isdefined(entity.enemy) && function_4df0b826(entity, entity.enemy)) {
        var_e91a592a = entity function_c91092d2(entity.enemy, entity.var_1267fdea) || entity seerecently(entity.enemy, 1) && namespace_85745671::function_142c3c86(entity.enemy);
        var_7be806db = entity attackedrecently(entity.enemy, 1);
        var_8bbedf63 = entity.enemy attackedrecently(entity, 1);
        if (var_e91a592a || var_7be806db || var_8bbedf63) {
            entity.favoriteenemy = entity.enemy;
        }
    }
    if (!is_true(entity.got_to_entrance)) {
        function_7c72a5c7(entity);
    }
    if (function_fd83d499(entity)) {
        return;
    }
    if (isdefined(entity.favoriteenemy) || isdefined(entity.enemy_override) || isdefined(entity.attackable)) {
        set_state(entity, #"chase");
        return;
    }
    if (!isdefined(entity.var_b4b8ad5f)) {
        set_state(entity, #"wander");
        return;
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xd2e14407, Offset: 0x3678
// Size: 0x54
function function_34162a25(entity) {
    function_1db27761(entity, undefined);
    entity callback::function_52ac9652(#"awareness_event", &function_853a6d58);
}

// Namespace awareness/namespace_df233b8a
// Params 3, eflags: 0x1 linked
// Checksum 0x181761bc, Offset: 0x36d8
// Size: 0xbe
function function_c241ef9a(ai, enemy, var_fb09158c) {
    if (!issentient(enemy) || is_true(enemy.ignoreme) || enemy isnotarget()) {
        return;
    }
    ai.favoriteenemy = enemy;
    ai.var_6324ed63 = var_fb09158c < 0 ? -1 : gettime() + int(var_fb09158c * 1000);
}

// Namespace awareness/namespace_df233b8a
// Params 2, eflags: 0x1 linked
// Checksum 0x83deb8e3, Offset: 0x37a0
// Size: 0x108
function function_2bc424fd(entity, target) {
    if (!issentient(target)) {
        return false;
    }
    var_a63ddc4 = entity.var_6324ed63 === -1 || isdefined(entity.var_6324ed63) && gettime() < entity.var_6324ed63;
    var_27cd0f02 = entity seerecently(target, 5);
    var_7be806db = entity attackedrecently(target, 10);
    var_8bbedf63 = target attackedrecently(entity, 10);
    return var_a63ddc4 || var_27cd0f02 || var_7be806db || var_8bbedf63;
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xfe4b003b, Offset: 0x38b0
// Size: 0x5be
function function_5c40e824(entity) {
    potential_targets = [];
    var_8d6705e8 = [];
    var_61203702 = [];
    target_player = entity.team === level.zombie_team;
    if (target_player) {
        var_61203702 = getplayers();
        function_1eaaceab(level.var_7015803, 0);
        var_61203702 = arraycombine(var_61203702, level.var_7015803);
    } else {
        var_61203702 = getentitiesinradius(entity.origin, 1500, 15);
        var_2019ec4e = isdefined(entity.var_443d78cc) ? entity.var_443d78cc : entity;
        var_61203702 = arraysortclosest(var_61203702, var_2019ec4e.origin);
    }
    foreach (target in var_61203702) {
        if (target_player && !namespace_85745671::is_player_valid(target) && !namespace_85745671::function_1b9ed9b0(target)) {
            continue;
        }
        if (!target_player && (namespace_85745671::function_1b9ed9b0(target) || target.team === entity.team)) {
            continue;
        }
        position = isdefined(target.last_valid_position) ? target.last_valid_position : target.origin;
        if (function_2bc424fd(entity, target) && isalive(target)) {
            potential_targets[potential_targets.size] = {#target:target, #origin:position};
            var_8d6705e8[var_8d6705e8.size] = position;
        }
        if (potential_targets.size >= 16) {
            break;
        }
    }
    if (potential_targets.size) {
        var_8bce469c = function_9cc082d2(entity.origin, 2 * 39.3701);
        var_7c0a584d = entity.origin;
        if (isdefined(var_8bce469c) && isdefined(var_8bce469c[#"point"])) {
            var_7c0a584d = var_8bce469c[#"point"];
        }
        var_81f0959c = [];
        foreach (origin in var_8d6705e8) {
            var_8bce469c = function_9cc082d2(origin, 2 * 39.3701);
            if (isdefined(var_8bce469c) && isdefined(var_8bce469c[#"point"])) {
                array::add(var_81f0959c, var_8bce469c[#"point"]);
                continue;
            }
            array::add(var_81f0959c, origin);
        }
        pathdata = generatenavmeshpath(var_7c0a584d, var_81f0959c, entity);
        if (isdefined(pathdata) && pathdata.status === "succeeded") {
            var_6f5b42c8 = arraygetclosest(pathdata.pathpoints[pathdata.pathpoints.size - 1], potential_targets);
            if (isdefined(var_6f5b42c8)) {
                target = var_6f5b42c8.target;
                if (!isdefined(target.last_valid_position) || abs(target.last_valid_position[2] - target.origin[2]) < 32) {
                    zm_ai_utility::function_4d22f6d1(entity);
                } else {
                    zm_ai_utility::function_68ab868a(entity);
                }
                entity.favoriteenemy = target;
            }
        } else if (!isdefined(self.var_597f08bf)) {
            zm_ai_utility::function_68ab868a(entity);
            entity.favoriteenemy = undefined;
        }
        return;
    }
    entity.favoriteenemy = undefined;
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xeb9d18a5, Offset: 0x3e78
// Size: 0xb8
function function_978025e4(entity) {
    entity.awarenesslevelcurrent = "combat";
    function_1db27761(entity, undefined);
    entity thread function_85bb995c();
    if (isalive(entity.favoriteenemy) && entity.favoriteenemy.team !== level.var_8fc3f1c4) {
        entity notify(#"hash_151828d1d5e024ee", {#enemy:entity.favoriteenemy});
    }
}

// Namespace awareness/namespace_df233b8a
// Params 3, eflags: 0x1 linked
// Checksum 0x429fc056, Offset: 0x3f38
// Size: 0xf2
function function_d0939c67(entity, target, min_dist) {
    lastknownpos = entity lastknownpos(target);
    if (isdefined(lastknownpos)) {
        if (!isdefined(target.var_125d950b)) {
            target.var_125d950b = [];
        }
        goal = arraygetclosest(lastknownpos, target.var_125d950b, min_dist);
        if (!isdefined(goal)) {
            goal = getclosestpointonnavmesh(lastknownpos, 200, entity getpathfindingradius() * 1.2);
            if (isdefined(goal)) {
                target.var_125d950b[entity getentitynumber()] = goal;
            }
        }
        return goal;
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x51c1fda7, Offset: 0x4038
// Size: 0x3b4
function function_39da6c3c(entity) {
    if (!is_true(entity.got_to_entrance)) {
        function_7c72a5c7(entity);
    }
    if (function_fd83d499(entity)) {
        return;
    }
    if (is_true(entity.var_1fa24724)) {
        if (float(gettime() - entity.var_4ca11261) / 1000 > 5) {
            entity.var_6324ed63 = undefined;
        }
        goal = getclosestpointonnavmesh(entity.origin, 2 * 39.3701, entity getpathfindingradius() * 1.2);
        if (isdefined(goal)) {
            entity setgoal(goal);
        } else {
            entity setgoal(self.origin);
        }
    }
    if (!isdefined(entity.enemy_override) && !isdefined(entity.attackable) && !function_2bc424fd(entity, entity.enemy)) {
        set_state(entity, #"wander");
        return;
    }
    if (isdefined(entity.var_b238ef38) && isdefined(entity.var_b238ef38.position)) {
        entity setgoal(entity.var_b238ef38.position);
        return;
    }
    if (isdefined(entity.enemy_override)) {
        goal = getclosestpointonnavmesh(entity.enemy_override.origin, 200, entity getpathfindingradius() * 1.2);
        if (isdefined(goal)) {
            entity setgoal(goal);
            return;
        }
    }
    if (isdefined(entity.favoriteenemy)) {
        goal = function_d0939c67(entity, entity.favoriteenemy, 32);
        if (isdefined(goal)) {
            if (getdvarint(#"hash_6fcfffa58806f673", 1) && !is_true(entity.var_1fa24724)) {
                entity namespace_e292b080::zombieupdategoal(goal);
            } else {
                entity.keep_moving = 0;
                entity setgoal(goal);
            }
        }
        return;
    }
    goal = getclosestpointonnavmesh(entity.origin, 200, entity getpathfindingradius() * 1.2);
    if (isdefined(goal)) {
        entity setgoal(goal);
        return;
    }
    entity setgoal(self.origin);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xd023f15, Offset: 0x43f8
// Size: 0x24
function function_b9f81e8b(entity) {
    zm_ai_utility::function_4d22f6d1(entity);
}

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x1 linked
// Checksum 0xa204789a, Offset: 0x4428
// Size: 0x70
function function_85bb995c() {
    self endon(#"death", #"state_changed");
    while (true) {
        wait 1;
        if (!isdefined(self.enemy)) {
            continue;
        }
        self generateradioevent("radio_event_high", 400);
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0x554f2783, Offset: 0x44a0
// Size: 0x28a
function function_7c72a5c7(entity) {
    entity.var_c5a69ef5 = entity.var_26088aea === entity.var_a5add0c0;
    entity.var_26088aea = entity.var_a5add0c0;
    if (isdefined(entity.var_a5add0c0)) {
        blocker = entity.var_a5add0c0.var_597f08bf;
        if (isdefined(blocker.targetname) && blocker.targetname === "barricade_window") {
            entity.first_node = blocker;
            entity.var_597f08bf = blocker;
            entity.barrier_align = blocker.barrier_align;
            if (!entity.var_c5a69ef5) {
                entity zombie_utility::reset_attack_spot();
                entity.at_entrance_tear_spot = 0;
                /#
                    if (getdvarint(#"hash_2f078c2224f40586", 0) && isdefined(entity.first_node.zbarrier)) {
                        record3dtext("<dev string:x1f3>" + entity.first_node.zbarrier getentnum(), entity.origin + (0, 0, 2), (1, 0, 0), "<dev string:x210>", entity);
                    }
                #/
            }
            /#
                if (getdvarint(#"hash_2f078c2224f40586", 0) && isdefined(entity.first_node.zbarrier)) {
                    record3dtext("<dev string:x21e>" + entity.first_node.zbarrier getentnum(), entity.origin + (0, 0, 7), (1, 0.5, 0), "<dev string:x210>", entity);
                }
            #/
        }
        return;
    }
    if (!entity.var_c5a69ef5) {
        entity.first_node = undefined;
        entity.barrier_align = undefined;
        entity zombie_utility::reset_attack_spot();
        entity.at_entrance_tear_spot = 0;
        entity.got_to_entrance = 0;
    }
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x1 linked
// Checksum 0xa89aee84, Offset: 0x4738
// Size: 0x1bc
function function_fd83d499(entity) {
    if (zm_behavior::function_b86a1b9d(entity)) {
        if (distancesquared(entity.first_node.origin, entity.origin) < 22801) {
            if (!is_true(entity.got_to_entrance)) {
                goalinfo = entity function_4794d6a3();
                entity.var_67ab7d45 = isdefined(goalinfo.overridegoalpos) ? goalinfo.overridegoalpos : goalinfo.goalpos;
            }
            entity.var_1033fa72 = undefined;
            entity.got_to_entrance = 1;
            /#
                if (getdvarint(#"hash_2f078c2224f40586", 0)) {
                    record3dtext("<dev string:x238>" + entity.first_node.zbarrier getentnum(), entity.origin + (0, 0, 2), (1, 0.5, 0), "<dev string:x210>", entity);
                    line(entity.origin, entity.first_node.origin, (0.1, 0.9, 0));
                }
            #/
            return true;
        }
    }
    return false;
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0x5ca9fe58, Offset: 0x4900
// Size: 0xe4
function function_b6aca908(entity) {
    if (self.current_state.name === #"chase" || self.current_state.name === #"investigate") {
        self.var_2772a472 = 1;
    }
    self.var_9f6112bb = 1;
    entity.awarenesslevelcurrent = "unaware";
    if (!isdefined(entity.var_6324ed63) || gettime() >= entity.var_6324ed63) {
        entity.favoriteenemy = undefined;
    }
    entity.var_eb5eeb0f = [];
    entity callback::function_d8abfc3d(#"awareness_event", &function_cf2fab43);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0xdd439d2c, Offset: 0x49f0
// Size: 0x24
function function_a4076709(entity) {
    function_4ebe4a6d(entity);
}

// Namespace awareness/namespace_df233b8a
// Params 1, eflags: 0x0
// Checksum 0x61ee9a10, Offset: 0x4a20
// Size: 0x3c
function function_8d21ac75(entity) {
    entity callback::function_52ac9652(#"awareness_event", &function_cf2fab43);
}

/#

    // Namespace awareness/namespace_df233b8a
    // Params 0, eflags: 0x4
    // Checksum 0x65b5bbbe, Offset: 0x4a68
    // Size: 0x84
    function private function_dfe1997a() {
        util::waittill_can_add_debug_command();
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x24f>" + mapname + "<dev string:x260>");
        adddebugcommand("<dev string:x24f>" + mapname + "<dev string:x298>");
    }

    // Namespace awareness/namespace_df233b8a
    // Params 1, eflags: 0x4
    // Checksum 0xb3efaa52, Offset: 0x4af8
    // Size: 0x82
    function private function_66c2ca1e(type) {
        switch (type) {
        case 0:
            return "<dev string:x2e1>";
        case 1:
            return "<dev string:x301>";
        case 3:
            return "<dev string:x322>";
        case 2:
            return "<dev string:x344>";
        }
    }

    // Namespace awareness/namespace_df233b8a
    // Params 1, eflags: 0x4
    // Checksum 0x78f9fdbc, Offset: 0x4b88
    // Size: 0x144
    function private function_fbae6630(awareness_event) {
        duration = isdefined(awareness_event.params.var_74bdb7f8) ? awareness_event.params.var_74bdb7f8 : int(10 / float(function_60d95f53()) / 1000);
        color = isdefined(awareness_event.params.var_f71eb7fe) ? awareness_event.params.var_f71eb7fe : (0, 1, 0);
        circle(awareness_event.position, awareness_event.radius, color, 0, 1, duration);
        print3d(awareness_event.position, function_66c2ca1e(awareness_event.type), color, 1, 0.5, duration, 1);
    }

#/

// Namespace awareness/namespace_df233b8a
// Params 0, eflags: 0x1 linked
// Checksum 0xa825b305, Offset: 0x4cd8
// Size: 0x13a
function function_c6b1009e() {
    self notify(#"sndawarenesschange");
    self endon(#"death");
    self endon(#"sndawarenesschange");
    wait 0.2;
    switch (self.current_state.name) {
    case #"wander":
        self clientfield::set("sndAwarenessChange", 1);
        break;
    case #"investigate":
        self clientfield::set("sndAwarenessChange", 2);
        break;
    case #"chase":
        self clientfield::set("sndAwarenessChange", 3);
        break;
    default:
        self clientfield::set("sndAwarenessChange", 1);
        break;
    }
}

