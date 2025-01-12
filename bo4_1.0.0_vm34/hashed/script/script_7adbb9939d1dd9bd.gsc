#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d43177a8;

// Namespace namespace_d43177a8/namespace_d43177a8
// Params 0, eflags: 0x2
// Checksum 0xd32f929a, Offset: 0xf0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_6d3c5317001d4fc6", &__init__, undefined, undefined);
}

// Namespace namespace_d43177a8/namespace_d43177a8
// Params 0, eflags: 0x0
// Checksum 0xfd3b5ad2, Offset: 0x138
// Size: 0xbc
function __init__() {
    setdvar(#"hash_6d3c5317001d4fc6", 0);
    /#
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x73>");
        adddebugcommand("<dev string:xc4>");
    #/
    var_ea030172 = isprofilebuild();
    /#
        var_ea030172 = 1;
    #/
    if (var_ea030172) {
        level thread function_f77ca161();
    }
}

// Namespace namespace_d43177a8/namespace_d43177a8
// Params 0, eflags: 0x0
// Checksum 0x23a419e4, Offset: 0x200
// Size: 0x3c4
function zombie_open_sesame() {
    setdvar(#"zombie_unlock_all", 1);
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 0);
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::set("power_on" + trig.script_int);
            level clientfield::set("zombie_power_on", trig.script_int);
        }
    }
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (isdefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    wait 1;
    setdvar(#"zombie_unlock_all", 0);
}

// Namespace namespace_d43177a8/namespace_d43177a8
// Params 0, eflags: 0x0
// Checksum 0xa2559253, Offset: 0x5d0
// Size: 0x27a
function function_f77ca161() {
    var_9f7f8c1e = getdvarint(#"hash_6d3c5317001d4fc6", 0);
    while (true) {
        new_value = getdvarint(#"hash_6d3c5317001d4fc6", 0);
        players = getplayers();
        if (new_value) {
            foreach (player in players) {
                player enableinvulnerability();
            }
        }
        if (new_value != var_9f7f8c1e) {
            /#
                if (!(var_9f7f8c1e && new_value)) {
                    adddebugcommand("<dev string:x108>");
                }
            #/
            if (new_value != 0) {
                if (new_value == 2) {
                    level thread zombie_open_sesame();
                }
                remainingplayers = 4 - players.size;
                /#
                    adddebugcommand("<dev string:x10c>" + remainingplayers);
                #/
                waitframe(1);
                /#
                    adddebugcommand("<dev string:x129>");
                #/
            } else {
                /#
                    adddebugcommand("<dev string:x142>");
                #/
                players = getplayers();
                foreach (player in players) {
                    player disableinvulnerability();
                }
            }
        }
        var_9f7f8c1e = new_value;
        waitframe(1);
    }
}

