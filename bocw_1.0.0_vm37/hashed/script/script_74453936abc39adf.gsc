#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;

#namespace namespace_38ee089b;

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 0, eflags: 0x0
// Checksum 0x5aa17757, Offset: 0x70
// Size: 0x3c
function preinit() {
    onstartgametype = function_72b9b674();
    if (isdefined(onstartgametype)) {
        callback::on_start_gametype(onstartgametype);
    }
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 0, eflags: 0x4
// Checksum 0x8dd3bad9, Offset: 0xb8
// Size: 0xf4
function private function_72b9b674() {
    if (!isdefined(level.gametype)) {
        return undefined;
    }
    switch (level.gametype) {
    case #"dm":
    case #"tdm_bots":
    case #"tdm_hc":
    case #"dm_hc":
    case #"tdm":
    case #"dm_bots":
        return &function_13821498;
    case #"dom":
    case #"dom_bots":
        return &dom_start;
    case #"koth":
        return &koth_start;
    }
    return undefined;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 0, eflags: 0x4
// Checksum 0x52c114a2, Offset: 0x1b8
// Size: 0x50c
function private dom_start() {
    level endon(#"game_ended");
    foreach (team in level.teams) {
        level function_7a20f3a6(team, undefined, undefined, undefined, #"chase_enemy", #"patrol", undefined);
    }
    while (!isdefined(level.domflags) || level.domflags.size <= 0) {
        waitframe(1);
    }
    var_647c4a69 = [];
    foreach (object in level.domflags) {
        var_647c4a69[var_647c4a69.size] = level function_5e156104(object);
    }
    var_654bc2bc = [#"capture":&function_19d221fa, #"defend":&function_d5bf23f5];
    while (true) {
        foreach (info in var_647c4a69) {
            object = info.object;
            ownerteam = object gameobjects::get_owner_team();
            touchcount = 0;
            foreach (user in object.users) {
                if (user.touching.num > 0) {
                    touchcount++;
                }
            }
            foreach (team in level.teams) {
                intel = info.var_6deb0f13[team];
                order = team == ownerteam ? #"defend" : #"capture";
                if (!isdefined(intel) || intel.var_a1980fcb != order) {
                    level function_259f72d8(team, intel);
                    weight = var_654bc2bc[order];
                    intel = level function_7a20f3a6(team, object, info.var_dd2331cb, info.neighborids, order, #"assault", weight);
                    info.var_6deb0f13[team] = intel;
                }
                intel.contested = touchcount > 1;
                if (team == ownerteam && touchcount > 0) {
                    var_57ac36a0 = object.users[team];
                    intel.losing = !isdefined(var_57ac36a0) || var_57ac36a0.touching.num <= 0;
                    continue;
                }
                intel.losing = 0;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0x636e53dc, Offset: 0x6d0
// Size: 0x74
function private function_19d221fa(intel) {
    teamcount = getplayers(self.team).size;
    var_3637fc36 = level function_13927405(intel, self.team);
    if (var_3637fc36 > 0) {
        return (teamcount / var_3637fc36);
    }
    return teamcount;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0x3d259f28, Offset: 0x750
// Size: 0x74
function private function_d5bf23f5(intel) {
    teamcount = getplayers(self.team).size;
    var_3637fc36 = level function_13927405(intel, self.team);
    if (var_3637fc36 > 0) {
        return (teamcount / var_3637fc36);
    }
    return teamcount;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 0, eflags: 0x4
// Checksum 0xf164544e, Offset: 0x7d0
// Size: 0x5c8
function private koth_start() {
    level endon(#"game_ended");
    var_df7737f1 = [];
    foreach (team in level.teams) {
        var_df7737f1[team] = level function_7a20f3a6(team, undefined, undefined, undefined, #"chase_enemy", #"patrol", undefined);
    }
    while (!isdefined(level.zones) || level.zones.size <= 0) {
        waitframe(1);
    }
    var_4185bc81 = [];
    foreach (zone in level.zones) {
        if (!isdefined(zone.gameobject)) {
            continue;
        }
        var_4185bc81[var_4185bc81.size] = level function_5e156104(zone.gameobject);
    }
    var_df910e1 = undefined;
    while (true) {
        if (isdefined(var_df910e1)) {
            object = var_df910e1.object;
            if (!object.trigger istriggerenabled()) {
                foreach (team, intel in var_df910e1.var_6deb0f13) {
                    level function_259f72d8(team, intel);
                }
                var_df910e1 = undefined;
            }
        }
        if (!isdefined(var_df910e1)) {
            foreach (info in var_4185bc81) {
                object = info.object;
                if (object.trigger istriggerenabled()) {
                    var_df910e1 = info;
                    foreach (team in level.teams) {
                        intel = var_df7737f1[team];
                        level function_259f72d8(team, intel);
                        var_df7737f1[team] = level function_7a20f3a6(team, undefined, undefined, undefined, #"chase_enemy", #"patrol", undefined);
                        info.var_6deb0f13[team] = level function_7a20f3a6(team, object, info.var_dd2331cb, info.neighborids, #"capture", #"assault", &function_16dd5162);
                    }
                    break;
                }
            }
        }
        if (isdefined(var_df910e1)) {
            object = var_df910e1.object;
            touchcount = 0;
            foreach (user in object.users) {
                if (user.touching.num > 0) {
                    touchcount++;
                }
            }
            foreach (intel in var_df910e1.var_6deb0f13) {
                intel.contested = touchcount > 0;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0x97220ce6, Offset: 0xda0
// Size: 0x10
function private function_16dd5162(*intel) {
    return 5;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 0, eflags: 0x4
// Checksum 0xf453e6cb, Offset: 0xdb8
// Size: 0xb8
function private function_13821498() {
    foreach (team in level.teams) {
        level function_7a20f3a6(team, undefined, undefined, undefined, #"chase_enemy", #"patrol", undefined);
    }
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0xd3414e00, Offset: 0xe78
// Size: 0x15a
function private function_5e156104(object) {
    info = {#object:object, #var_6deb0f13:[]};
    regions = level function_dbd1704d(object);
    neighbors = level function_323a3bdf(regions);
    info.var_dd2331cb = level function_8d2aa32e(regions);
    info.neighborids = level function_8d2aa32e(neighbors);
    foreach (team in level.teams) {
        intel = {#object:object};
        info.var_6deb0f13 = [];
    }
    return info;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0x4306f7c4, Offset: 0xfe0
// Size: 0x19c
function private function_dbd1704d(object) {
    regions = [];
    if (isdefined(object.trigger)) {
        points = tacticalquery(#"hash_6ab834dd93762a6e", object.trigger);
        foreach (point in points) {
            info = function_b507a336(point.region);
            if (info.tacpoints.size < 5) {
                continue;
            }
            regions[info.id] = info;
        }
    }
    if (regions.size <= 0) {
        tpoint = getclosesttacpoint(object.origin);
        if (isdefined(tpoint)) {
            region = function_b507a336(tpoint.region);
            regions[region.id] = region;
        }
    }
    return regions;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0x6475027f, Offset: 0x1188
// Size: 0x14a
function private function_323a3bdf(regions) {
    neighbors = [];
    foreach (regioninfo in regions) {
        foreach (id in regioninfo.neighbors) {
            if (isdefined(regions[id])) {
                continue;
            }
            region = function_b507a336(id);
            if (region.tacpoints.size < 5) {
                continue;
            }
            neighbors[id] = region;
        }
    }
    return neighbors;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 1, eflags: 0x4
// Checksum 0x3e935560, Offset: 0x12e0
// Size: 0x96
function private function_8d2aa32e(regions) {
    ids = [];
    foreach (id, region in regions) {
        ids[ids.size] = id;
    }
    return ids;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 7, eflags: 0x4
// Checksum 0x925d3d93, Offset: 0x1380
// Size: 0xfc
function private function_7a20f3a6(team, object, var_dd2331cb, neighborids, var_a1980fcb, var_5e99151a, weight) {
    intel = {#object:object, #var_dd2331cb:var_dd2331cb, #neighborids:neighborids, #var_a1980fcb:var_a1980fcb, #var_5e99151a:var_5e99151a, #count:0, #weight:weight, #active:1};
    var_6deb0f13 = level.var_156a37c8[team];
    var_6deb0f13[var_6deb0f13.size] = intel;
    return intel;
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 2, eflags: 0x4
// Checksum 0xe8b40f5f, Offset: 0x1488
// Size: 0x5c
function private function_259f72d8(team, intel) {
    if (!isdefined(intel)) {
        return;
    }
    intel.active = 0;
    var_6deb0f13 = level.var_156a37c8[team];
    arrayremovevalue(var_6deb0f13, intel);
}

// Namespace namespace_38ee089b/namespace_38ee089b
// Params 2, eflags: 0x4
// Checksum 0xe0baffae, Offset: 0x14f0
// Size: 0xec
function private function_13927405(intel, team) {
    count = 0;
    players = intel.object.users[team].touching.players;
    if (isdefined(players)) {
        foreach (player in players) {
            if (!isbot(player)) {
                count++;
            }
        }
    }
    return count + intel.count;
}

