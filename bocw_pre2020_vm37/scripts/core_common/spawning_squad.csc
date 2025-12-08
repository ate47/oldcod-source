#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace squad_spawn;

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x6
// Checksum 0x40e78e86, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"squad_spawning", &init, undefined, undefined, undefined );
}

// Namespace squad_spawn/spawning_squad
// Params 0
// Checksum 0xd85762b2, Offset: 0x188
// Size: 0x7c
function init()
{
    level.var_d0252074 = isdefined( getgametypesetting( #"hash_2b1f40bc711c41f3" ) ) ? getgametypesetting( #"hash_2b1f40bc711c41f3" ) : 0;
    
    if ( !level.var_d0252074 )
    {
        return;
    }
    
    setupclientfields();
}

// Namespace squad_spawn/spawning_squad
// Params 0
// Checksum 0xd674be32, Offset: 0x210
// Size: 0x1e4
function setupclientfields()
{
    clientfield::register_clientuimodel( "hudItems.squadSpawnOnStatus", #"hud_items", #"squadspawnonstatus", 1, 3, "int", undefined, 0, 0 );
    clientfield::register_clientuimodel( "hudItems.squadSpawnActive", #"hud_items", #"squadspawnactive", 1, 1, "int", undefined, 0, 0 );
    clientfield::register_clientuimodel( "hudItems.squadSpawnRespawnStatus", #"hud_items", #"squadspawnrespawnstatus", 1, 2, "int", undefined, 0, 0 );
    clientfield::register_clientuimodel( "hudItems.squadSpawnViewType", #"hud_items", #"squadspawnviewtype", 1, 1, "int", undefined, 0, 0 );
    clientfield::register_clientuimodel( "hudItems.squadAutoSpawnPromptActive", #"hud_items", #"squadautospawnpromptactive", 1, 1, "int", undefined, 0, 0 );
    clientfield::register_clientuimodel( "hudItems.squadSpawnSquadWipe", #"hud_items", #"squadspawnsquadwipe", 1, 1, "int", undefined, 0, 0 );
}

