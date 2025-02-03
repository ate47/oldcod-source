#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace squad_spawn;

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x6
// Checksum 0xece51e3a, Offset: 0x198
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"squad_spawning", &init, undefined, undefined, undefined);
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xcdc7b6d2, Offset: 0x1e0
// Size: 0x7c
function init() {
    level.var_d0252074 = isdefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0;
    if (!level.var_d0252074) {
        return;
    }
    setupclientfields();
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xe603732e, Offset: 0x268
// Size: 0x204
function setupclientfields() {
    clientfield::register_clientuimodel("hudItems.squadSpawnOnStatus", #"hud_items", #"squadspawnonstatus", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnActive", #"hud_items", #"squadspawnactive", 1, 1, "int", &function_cc03b772, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnRespawnStatus", #"hud_items", #"hash_6b8b915fbdeaa722", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnViewType", #"hud_items", #"hash_2d210ef59c073abd", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadAutoSpawnPromptActive", #"hud_items", #"hash_4b3a0953a67ca151", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnSquadWipe", #"hud_items", #"hash_241b5d6ff260de2d", 1, 1, "int", &function_a58f32b0, 0, 0);
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x65566c58, Offset: 0x478
// Size: 0x70
function function_21b773d5(localclientnum) {
    if (!is_true(level.var_d0252074)) {
        return false;
    }
    player = function_27673a7(localclientnum);
    if (!isdefined(player)) {
        return false;
    }
    return player clientfield::get_player_uimodel("hudItems.squadSpawnActive") == 1;
}

// Namespace squad_spawn/spawning_squad
// Params 7, eflags: 0x0
// Checksum 0x3d44ae6f, Offset: 0x4f0
// Size: 0xec
function function_cc03b772(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        level thread function_58710bd2(fieldname);
        level thread function_cbcbd56d(fieldname);
        setsoundcontext("spawn_select_screen", "true");
        return;
    }
    level thread function_c97b609d(fieldname);
    level thread function_48811bf4(fieldname);
    setsoundcontext("spawn_select_screen", "");
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x699e2e24, Offset: 0x5e8
// Size: 0x5c
function function_cbcbd56d(*localclientnum) {
    if (game.state != #"playing") {
        return;
    }
    if (!is_true(level.var_acf54eb7)) {
        soundsetmusicstate("squad_spawn");
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x9008d6f9, Offset: 0x650
// Size: 0x5c
function function_48811bf4(*localclientnum) {
    if (game.state != #"playing") {
        return;
    }
    if (!is_true(level.var_acf54eb7)) {
        soundsetmusicstate("squad_spawn_exit");
    }
}

// Namespace squad_spawn/spawning_squad
// Params 7, eflags: 0x0
// Checksum 0xecc1cabc, Offset: 0x6b8
// Size: 0x64
function function_a58f32b0(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        playsound(fieldname, #"hash_5d2e54389286b7f8");
    }
}

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0x77d7ff20, Offset: 0x728
// Size: 0xee
function function_429c452(localclientnum, should_play) {
    if (!should_play) {
        return 0;
    }
    if (!isdefined(self)) {
        return 0;
    }
    if (!isplayer(self)) {
        return should_play;
    }
    localplayer = function_5c10bd79(localclientnum);
    if (isdefined(localplayer) && !localplayer util::isenemyteam(self.team)) {
        return 0;
    }
    if (!function_266be0d4(localclientnum)) {
        return 0;
    }
    if (self hasperk(localclientnum, #"specialty_immunenvthermal")) {
        return 0;
    }
    return 1;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x641d6042, Offset: 0x820
// Size: 0x254
function private function_58710bd2(localclientnum) {
    self endon(#"disconnect", #"hash_6843c6f6d0e53fd");
    while (true) {
        players = getplayers(localclientnum);
        for (index = 0; index < players.size; index++) {
            player = players[index];
            if (!isdefined(player)) {
                continue;
            }
            player renderoverridebundle::function_f4eab437(localclientnum, 1, #"hash_c37f4f4d19191cb", &function_429c452);
            corpse = player getplayercorpse();
            if (!isdefined(corpse) || corpse == player) {
                continue;
            }
            corpse renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", &function_429c452);
            if ((index + 1) % 3 == 0) {
                waitframe(1);
            }
        }
        if (isarray(level.allvehicles)) {
            for (index = 0; index < level.allvehicles.size; index++) {
                vehicle = level.allvehicles[index];
                if (!isdefined(vehicle)) {
                    continue;
                }
                occupants = vehicle getvehoccupants(localclientnum);
                vehicle renderoverridebundle::function_f4eab437(localclientnum, occupants.size > 0, #"hash_c37f4f4d19191cb", &function_429c452);
                if ((index + 1) % 3 == 0) {
                    waitframe(1);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x27fdf4e4, Offset: 0xa80
// Size: 0x1e0
function private function_c97b609d(localclientnum) {
    level notify(#"hash_6843c6f6d0e53fd");
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        player renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
        corpse = player getplayercorpse();
        if (!isdefined(corpse) || corpse == player) {
            continue;
        }
        corpse renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
        if (isarray(level.allvehicles)) {
            for (index = 0; index < level.allvehicles.size; index++) {
                vehicle = level.allvehicles[index];
                if (!isdefined(vehicle)) {
                    continue;
                }
                vehicle renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
            }
        }
    }
}

