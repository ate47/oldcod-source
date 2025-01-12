#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace squad_spawn;

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x6
// Checksum 0x40e78e86, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_4ceb0867dc2d780f", &init, undefined, undefined, undefined);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0xd85762b2, Offset: 0x188
// Size: 0x7c
function init() {
    level.var_d0252074 = isdefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0;
    if (!level.var_d0252074) {
        return;
    }
    setupclientfields();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0xd674be32, Offset: 0x210
// Size: 0x1e4
function setupclientfields() {
    clientfield::register_clientuimodel("hudItems.squadSpawnOnStatus", #"hash_6f4b11a0bee9b73d", #"squadspawnonstatus", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnActive", #"hash_6f4b11a0bee9b73d", #"squadspawnactive", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnRespawnStatus", #"hash_6f4b11a0bee9b73d", #"hash_6b8b915fbdeaa722", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnViewType", #"hash_6f4b11a0bee9b73d", #"hash_2d210ef59c073abd", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadAutoSpawnPromptActive", #"hash_6f4b11a0bee9b73d", #"hash_4b3a0953a67ca151", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.squadSpawnSquadWipe", #"hash_6f4b11a0bee9b73d", #"hash_241b5d6ff260de2d", 1, 1, "int", undefined, 0, 0);
}

