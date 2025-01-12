#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;

#namespace player_role;

// Namespace player_role/player_role
// Params 0, eflags: 0x2
// Checksum 0xa1d8ef5d, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player_role", &__init__, undefined, undefined);
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0x35c59f7c, Offset: 0xd0
// Size: 0x22
function __init__() {
    if (!isdefined(world.playerroles)) {
        world.playerroles = [];
    }
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0xce132f81, Offset: 0x100
// Size: 0xb2
function get_category_for_index(characterindex) {
    categoryname = getplayerrolecategory(characterindex, currentsessionmode());
    if (isdefined(categoryname)) {
        categoryinfo = getplayerrolecategoryinfo(categoryname);
        assert(isdefined(categoryinfo));
        if (isdefined(categoryinfo.enabled) && categoryinfo.enabled) {
            return categoryname;
        }
    }
    return "default";
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xcc0c72a1, Offset: 0x1c0
// Size: 0xa2
function get_category() {
    player = self;
    assert(isplayer(player));
    characterindex = player get();
    assert(is_valid(characterindex));
    return get_category_for_index(characterindex);
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0x2b169082, Offset: 0x270
// Size: 0x24
function function_398d8919() {
    return world.playerroles[self getentitynumber()];
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0xcaa5a6c2, Offset: 0x2a0
// Size: 0x156
function is_valid(index) {
    if (!isdefined(index)) {
        return 0;
    }
    if (currentsessionmode() == 0) {
        if (isdefined(level.charindexarray)) {
            return isinarray(level.charindexarray, index);
        }
        return 0;
    } else if (currentsessionmode() == 2) {
        return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
    }
    /#
        if (getdvarint(#"allowdebugcharacter", 0) == 1) {
            return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
        }
    #/
    return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0x937d12d8, Offset: 0x400
// Size: 0x52
function get() {
    player = self;
    assert(isplayer(player));
    return player getspecialistindex();
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xfb355e40, Offset: 0x460
// Size: 0x22
function update_fields() {
    self.playerrole = self getrolefields();
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x334a2c24, Offset: 0x490
// Size: 0x1e0
function set(index) {
    player = self;
    assert(isplayer(player));
    assert(is_valid(index));
    player.pers[#"characterindex"] = index;
    player setspecialistindex(index);
    player update_fields();
    world.playerroles[self getentitynumber()] = index;
    if (currentsessionmode() == 0) {
        customloadoutindex = get_custom_loadout_index(index);
    } else if (currentsessionmode() == 2) {
        customloadoutindex = self stats::get_stat(#"selectedcustomclass");
    } else if (currentsessionmode() == 3) {
        customloadoutindex = 0;
    } else {
        customloadoutindex = self.pers[#"loadoutindex"];
    }
    if (isdefined(customloadoutindex)) {
        result = self [[ level.curclass ]]("custom" + customloadoutindex);
        if (!isdefined(result)) {
            return 1;
        }
        return result;
    }
    return 0;
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0x5776c2d3, Offset: 0x678
// Size: 0x7a
function clear() {
    player = self;
    assert(isplayer(player));
    player setspecialistindex(0);
    player.pers[#"characterindex"] = undefined;
    player.playerrole = undefined;
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x7edfd4a4, Offset: 0x700
// Size: 0x22
function get_custom_loadout_index(characterindex) {
    return getcharacterclassindex(characterindex);
}

