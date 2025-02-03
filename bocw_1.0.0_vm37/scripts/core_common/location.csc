#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace location;

// Namespace location/location
// Params 0, eflags: 0x6
// Checksum 0x31f9b868, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"location", &preinit, undefined, undefined, undefined);
}

// Namespace location/location
// Params 0, eflags: 0x4
// Checksum 0xa6e78490, Offset: 0xe8
// Size: 0x8c
function private preinit() {
    level.var_1383915 = getentarray(0, "location_zone", "targetname");
    level.var_b6d0f0ba = getmapfields().destinationlabellist;
    level.var_d6c4af7f = &function_5f3b1735;
    callback::on_localplayer_spawned(&on_player_spawned);
}

// Namespace location/location
// Params 1, eflags: 0x0
// Checksum 0x556c90f9, Offset: 0x180
// Size: 0xc8
function function_ab7f70b9(str_zone) {
    if (!isdefined(str_zone) || !isdefined(level.var_b6d0f0ba)) {
        return undefined;
    }
    foreach (var_87ce7586 in level.var_b6d0f0ba) {
        if (var_87ce7586.zonename == hash(str_zone)) {
            return var_87ce7586.displayname;
        }
    }
}

// Namespace location/location
// Params 0, eflags: 0x0
// Checksum 0x5dd19739, Offset: 0x250
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
// Params 1, eflags: 0x0
// Checksum 0xf00a6027, Offset: 0x338
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
// Params 1, eflags: 0x0
// Checksum 0xc9fc816e, Offset: 0x400
// Size: 0xe6
function function_f6ad2be6(localclientnum) {
    self endon(#"death");
    uimodel = getuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "locationText");
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
// Params 1, eflags: 0x0
// Checksum 0x51b4a594, Offset: 0x4f0
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

