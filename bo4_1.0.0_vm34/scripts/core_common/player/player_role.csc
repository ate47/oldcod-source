#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace player_role;

// Namespace player_role/player_role
// Params 0, eflags: 0x2
// Checksum 0x51bce0e4, Offset: 0x78
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"player_role", undefined, &__postload_init__, undefined);
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xb8
// Size: 0x4
function __postload_init__() {
    
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0xd279993d, Offset: 0xc8
// Size: 0xb6
function is_valid(index) {
    if (!isdefined(index)) {
        return false;
    }
    /#
        if (getdvarint(#"allowdebugcharacter", 0) == 1) {
            return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
        }
    #/
    return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

