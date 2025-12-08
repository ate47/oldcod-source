#using script_7f6cd71c43c45c57;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_9205a0df;

// Namespace namespace_9205a0df/namespace_9205a0df
// Params 0, eflags: 0x6
// Checksum 0xef21d0f4, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_6460ff5d340f6751", undefined, &init, undefined, undefined );
}

// Namespace namespace_9205a0df/namespace_9205a0df
// Params 0
// Checksum 0x5bf1c780, Offset: 0xf0
// Size: 0x1c
function init()
{
    level.overrideactordamage = &actor_damage_override;
}

// Namespace namespace_9205a0df/namespace_9205a0df
// Params 12
// Checksum 0x49a5ed45, Offset: 0x118
// Size: 0xd4
function actor_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, *vdir, shitloc, *timeoffset, *boneindex, *modelindex )
{
    if ( timeoffset.name === #"hash_6460ff5d340f6751" && shitloc == "MOD_PISTOL_BULLET" )
    {
        self dodamage( 1.2 * vpoint, boneindex, weapon, smeansofdeath, modelindex, "MOD_BURNED", vdir, timeoffset );
        return 0;
    }
    
    return vpoint;
}

