#namespace player_role;

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x8d0f92e4, Offset: 0xa0
// Size: 0xce
function get_category_for_index(characterindex) {
    categoryname = getplayerrolecategory(characterindex, currentsessionmode());
    /#
        assert(isdefined(categoryname));
    #/
    categoryinfo = getplayerrolecategoryinfo(categoryname);
    /#
        assert(isdefined(categoryinfo));
    #/
    if (isdefined(categoryinfo.enabled) && categoryinfo.enabled) {
        return categoryname;
    }
    return "default";
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xad6cf6b3, Offset: 0x178
// Size: 0xaa
function get_category() {
    player = self;
    /#
        assert(isplayer(player));
    #/
    characterindex = player get();
    /#
        assert(is_valid(characterindex));
    #/
    return get_category_for_index(characterindex);
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0xeca254ea, Offset: 0x230
// Size: 0xd4
function is_valid(index) {
    if (!isdefined(index)) {
        return false;
    }
    if (currentsessionmode() != 1) {
        return true;
    }
    /#
        if (getdvarint("<dev string:x28>", 0) == 1) {
            return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
        }
    #/
    return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xdb322f98, Offset: 0x310
// Size: 0x5a
function get() {
    player = self;
    /#
        assert(isplayer(player));
    #/
    return player getspecialistindex();
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0x54220baa, Offset: 0x378
// Size: 0x24
function update_fields() {
    self.playerrole = self getrolefields();
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0xd7953ff7, Offset: 0x3a8
// Size: 0x112
function set(index) {
    player = self;
    /#
        assert(isplayer(player));
    #/
    /#
        assert(is_valid(index));
    #/
    player.pers["characterIndex"] = index;
    player setspecialistindex(index);
    player update_fields();
    customloadoutindex = get_custom_loadout_index(index);
    return self [[ level.curclass ]]("custom" + customloadoutindex);
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xf8ace7df, Offset: 0x4c8
// Size: 0x7e
function clear() {
    player = self;
    /#
        assert(isplayer(player));
    #/
    player setspecialistindex(0);
    player.pers["characterIndex"] = undefined;
    player.playerrole = undefined;
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0xa862745c, Offset: 0x550
// Size: 0x22
function get_custom_loadout_index(characterindex) {
    return getcharacterclassindex(characterindex);
}

