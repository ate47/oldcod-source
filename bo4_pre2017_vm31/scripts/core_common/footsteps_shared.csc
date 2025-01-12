#using scripts/core_common/audio_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace footsteps;

// Namespace footsteps/footsteps_shared
// Params 0, eflags: 0x2
// Checksum 0xfca2ef07, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("footsteps", &__init__, undefined, undefined);
}

// Namespace footsteps/footsteps_shared
// Params 0, eflags: 0x0
// Checksum 0x26d867ef, Offset: 0x1c8
// Size: 0x19e
function __init__() {
    var_7d05beb1 = getsurfacestrings();
    var_bc79fffd = [];
    var_bc79fffd[var_bc79fffd.size] = "step_run";
    var_bc79fffd[var_bc79fffd.size] = "land";
    level.var_5e17f7ae = [];
    for (var_515234af = 0; var_515234af < var_bc79fffd.size; var_515234af++) {
        movementtype = var_bc79fffd[var_515234af];
        for (var_9b9b98f3 = 0; var_9b9b98f3 < var_7d05beb1.size; var_9b9b98f3++) {
            surfacetype = var_7d05beb1[var_9b9b98f3];
            for (index = 0; index < 4; index++) {
                if (index < 2) {
                    firstperson = 0;
                } else {
                    firstperson = 1;
                }
                if (index % 2 == 0) {
                    var_7c95fc4 = 0;
                } else {
                    var_7c95fc4 = 1;
                }
                snd = function_2d42a17f(movementtype, surfacetype, firstperson, var_7c95fc4);
            }
        }
    }
}

/#

    // Namespace footsteps/footsteps_shared
    // Params 2, eflags: 0x0
    // Checksum 0x2e39a9f5, Offset: 0x370
    // Size: 0x11c
    function function_ce2898b2(movetype, surfacetype) {
        if (!isdefined(level.var_5e17f7ae[movetype][surfacetype])) {
            println("<dev string:x28>" + surfacetype + "<dev string:x3e>");
            println("<dev string:x63>");
            println("<dev string:x7b>");
            arraykeys = getarraykeys(level.var_5e17f7ae[movetype]);
            for (i = 0; i < arraykeys.size; i++) {
                println(arraykeys[i]);
            }
            println("<dev string:x84>");
        }
    }

#/

// Namespace footsteps/footsteps_shared
// Params 6, eflags: 0x0
// Checksum 0xdc3ca469, Offset: 0x498
// Size: 0xcc
function function_2e13c5c2(client_num, player, surfacetype, firstperson, quiet, var_7c95fc4) {
    if (isdefined(player.audiomaterialoverride)) {
        surfacetype = player.audiomaterialoverride;
        /#
            function_ce2898b2("<dev string:x8b>", surfacetype);
        #/
    }
    sound_alias = level.var_5e17f7ae["step_run"][surfacetype][firstperson][var_7c95fc4];
    player playsound(client_num, sound_alias);
}

// Namespace footsteps/footsteps_shared
// Params 7, eflags: 0x0
// Checksum 0xc35be9cc, Offset: 0x570
// Size: 0x1dc
function function_1aa3f5bd(client_num, player, surfacetype, firstperson, quiet, var_77e922e5, var_7c95fc4) {
    if (isdefined(player.audiomaterialoverride)) {
        surfacetype = player.audiomaterialoverride;
        /#
            function_ce2898b2("<dev string:x94>", surfacetype);
        #/
    }
    sound_alias = level.var_5e17f7ae["land"][surfacetype][firstperson][var_7c95fc4];
    player playsound(client_num, sound_alias);
    if (isdefined(player.step_sound) && !quiet && player.step_sound != "none") {
        volume = audio::get_vol_from_speed(player);
        player playsound(client_num, player.step_sound, player.origin, volume);
    }
    if (var_77e922e5) {
        if (isdefined(level.playerfalldamagesound)) {
            player [[ level.playerfalldamagesound ]](client_num, firstperson);
            return;
        }
        sound_alias = "fly_land_damage_npc";
        if (firstperson) {
            sound_alias = "fly_land_damage_plr";
            player playsound(client_num, sound_alias);
        }
    }
}

// Namespace footsteps/footsteps_shared
// Params 4, eflags: 0x0
// Checksum 0x294e3beb, Offset: 0x758
// Size: 0x9c
function function_1e9a5eeb(client_num, player, firstperson, quiet) {
    sound_alias = "fly_movement_foliage_npc";
    if (firstperson) {
        sound_alias = "fly_movement_foliage_plr";
    }
    volume = audio::get_vol_from_speed(player);
    player playsound(client_num, sound_alias, player.origin, volume);
}

// Namespace footsteps/footsteps_shared
// Params 4, eflags: 0x0
// Checksum 0xb36933a5, Offset: 0x800
// Size: 0x268
function function_2d42a17f(movementtype, surfacetype, firstperson, var_7c95fc4) {
    sound_alias = "fly_" + movementtype;
    if (firstperson) {
        sound_alias += "_plr_";
    } else {
        sound_alias += "_npc_";
    }
    sound_alias += surfacetype;
    if (!isdefined(level.var_5e17f7ae)) {
        level.var_5e17f7ae = [];
    }
    if (!isdefined(level.var_5e17f7ae[movementtype])) {
        level.var_5e17f7ae[movementtype] = [];
    }
    if (!isdefined(level.var_5e17f7ae[movementtype][surfacetype])) {
        level.var_5e17f7ae[movementtype][surfacetype] = [];
    }
    if (!isdefined(level.var_5e17f7ae[movementtype][surfacetype][firstperson])) {
        level.var_5e17f7ae[movementtype][surfacetype][firstperson] = [];
    }
    assert(isarray(level.var_5e17f7ae));
    assert(isarray(level.var_5e17f7ae[movementtype]));
    assert(isarray(level.var_5e17f7ae[movementtype][surfacetype]));
    assert(isarray(level.var_5e17f7ae[movementtype][surfacetype][firstperson]));
    level.var_5e17f7ae[movementtype][surfacetype][firstperson][var_7c95fc4] = sound_alias;
    return sound_alias;
}

// Namespace footsteps/footsteps_shared
// Params 4, eflags: 0x0
// Checksum 0x87f7c76c, Offset: 0xa70
// Size: 0x170
function function_29897e3b(client_num, var_9e38e41f, var_5305dd36, var_e069c441) {
    if (!isdefined(level.var_719a8c10)) {
        return;
    }
    if (var_e069c441) {
        var_9e38e41f = "fire";
    }
    /#
        if (getdvarint("<dev string:x99>")) {
            print3d(var_5305dd36, var_9e38e41f, (0.5, 0.5, 0.8), 1, 3, 30);
        }
    #/
    for (i = 0; i < level.var_719a8c10.size; i++) {
        if (level.var_719a8c10[i] == var_9e38e41f) {
            effect = "fly_step_" + var_9e38e41f;
            if (isdefined(level._effect[effect])) {
                playfx(client_num, level._effect[effect], var_5305dd36, var_5305dd36 + (0, 0, 100));
                return;
            }
        }
    }
}

// Namespace footsteps/footsteps_shared
// Params 0, eflags: 0x0
// Checksum 0x7db42c05, Offset: 0xbe8
// Size: 0x74
function missing_ai_footstep_callback() {
    /#
        type = self.archetype;
        if (!isdefined(type)) {
            type = "<dev string:xac>";
        }
        println("<dev string:xb4>" + type + "<dev string:xc3>" + self._aitype + "<dev string:x147>");
    #/
}

// Namespace footsteps/footsteps_shared
// Params 5, eflags: 0x0
// Checksum 0x1ab76dbc, Offset: 0xc68
// Size: 0xfa
function playaifootstep(client_num, pos, surface, notetrack, bone) {
    if (!isdefined(self.archetype)) {
        println("<dev string:x175>");
        footstepdoeverything();
        return;
    }
    if (!isdefined(level._footstepcbfuncs) || !isdefined(level._footstepcbfuncs[self.archetype])) {
        self missing_ai_footstep_callback();
        footstepdoeverything();
        return;
    }
    [[ level._footstepcbfuncs[self.archetype] ]](client_num, pos, surface, notetrack, bone);
}
