#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace location;

// Namespace location/location
// Params 0, eflags: 0x6
// Checksum 0xf8c152a6, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"location", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace location/location
// Params 0, eflags: 0x5 linked
// Checksum 0x53fbd24e, Offset: 0xe8
// Size: 0x8c
function private function_70a657d8() {
    level.var_1383915 = getentarray(0, "location_zone", "targetname");
    level.var_b6d0f0ba = getmapfields().destinationlabellist;
    level.var_d6c4af7f = &function_5f3b1735;
    callback::on_localplayer_spawned(&on_player_spawned);
}

// Namespace location/location
// Params 1, eflags: 0x1 linked
// Checksum 0x61ce326, Offset: 0x180
// Size: 0xb8
function function_ab7f70b9(str_zone) {
    if (!isdefined(str_zone)) {
        return undefined;
    }
    foreach (var_87ce7586 in level.var_b6d0f0ba) {
        if (var_87ce7586.zonename == hash(str_zone)) {
            return var_87ce7586.displayname;
        }
    }
}

// Namespace location/location
// Params 0, eflags: 0x1 linked
// Checksum 0x21def0ea, Offset: 0x240
// Size: 0xd8
function get_current_zone() {
    player = self;
    if (!isalive(player)) {
        return;
    }
    foreach (zone in level.var_1383915) {
        if (isalive(player) && player istouching(zone)) {
            return zone.script_location;
        }
    }
}

// Namespace location/location
// Params 1, eflags: 0x1 linked
// Checksum 0x2737ed3b, Offset: 0x328
// Size: 0xba
function function_5f3b1735(point) {
    foreach (zone in level.var_1383915) {
        if (istouching(point, zone)) {
            return function_ab7f70b9(zone.script_location);
        }
    }
    return undefined;
}

// Namespace location/location
// Params 1, eflags: 0x1 linked
// Checksum 0xed8010fe, Offset: 0x3f0
// Size: 0xe6
function function_f6ad2be6(localclientnum) {
    self endon(#"death");
    uimodel = getuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "locationText");
    while (true) {
        if (isdefined(self)) {
            str_location = get_current_zone();
            str_location = function_ab7f70b9(str_location);
            setuimodelvalue(uimodel, isdefined(str_location) ? str_location : #"");
        }
        wait 1;
    }
}

// Namespace location/location
// Params 1, eflags: 0x1 linked
// Checksum 0x6dad6567, Offset: 0x4e0
// Size: 0x6c
function on_player_spawned(localclientnum) {
    if (is_true(level.var_36a81b25)) {
        return;
    }
    if (!self function_21c0fa55()) {
        return;
    }
    if (!isdefined(level.var_1383915[0])) {
        return;
    }
    self thread function_f6ad2be6(localclientnum);
}

