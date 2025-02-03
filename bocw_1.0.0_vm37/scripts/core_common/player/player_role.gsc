#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;

#namespace player_role;

// Namespace player_role/player_role
// Params 0, eflags: 0x6
// Checksum 0xf58947d5, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_role", &preinit, undefined, undefined, undefined);
}

// Namespace player_role/player_role
// Params 0, eflags: 0x4
// Checksum 0x5abe22eb, Offset: 0xd8
// Size: 0x20
function private preinit() {
    if (!isdefined(world.playerroles)) {
        world.playerroles = [];
    }
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x6db5606a, Offset: 0x100
// Size: 0xaa
function get_category_for_index(characterindex) {
    categoryname = getplayerrolecategory(characterindex, currentsessionmode());
    if (isdefined(categoryname)) {
        categoryinfo = getplayerrolecategoryinfo(categoryname);
        assert(isdefined(categoryinfo));
        if (is_true(categoryinfo.enabled)) {
            return categoryname;
        }
    }
    return "default";
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xd0722f03, Offset: 0x1b8
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
// Checksum 0xa2bbb069, Offset: 0x268
// Size: 0x24
function function_c1f61ea2() {
    return world.playerroles[self getentitynumber()];
}

// Namespace player_role/player_role
// Params 2, eflags: 0x0
// Checksum 0x266d811f, Offset: 0x298
// Size: 0x12e
function function_965ea244(var_6c93328a = 0, var_f99420aa = 0) {
    var_ba015ed = getplayerroletemplatecount(currentsessionmode());
    var_13711f02 = [];
    for (i = 0; i < var_ba015ed; i++) {
        var_d5557bda = var_6c93328a === 1 || function_f4bf7e3f(i);
        var_e6df8df4 = var_f99420aa === 1 || function_63d13ea3(i);
        if (var_d5557bda && var_e6df8df4) {
            var_13711f02[var_13711f02.size] = i;
        }
    }
    roleindex = var_13711f02[randomint(var_13711f02.size)];
    return roleindex;
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x602e3657, Offset: 0x3d0
// Size: 0x16a
function function_63d13ea3(characterindex) {
    maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);
    if (maxuniqueroles == 0) {
        return false;
    }
    rolecount = 0;
    foreach (player in level.players) {
        if (player == self) {
            continue;
        }
        playercharacterindex = player get();
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == self.pers[#"team"] && playercharacterindex == characterindex) {
            rolecount++;
            if (rolecount >= maxuniqueroles) {
                return false;
            }
        }
    }
    return true;
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x687505f3, Offset: 0x548
// Size: 0x10e
function is_valid(index) {
    if (!isdefined(index)) {
        return false;
    }
    if (currentsessionmode() == 2) {
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
// Checksum 0xdd16a70d, Offset: 0x660
// Size: 0x4a
function get() {
    assert(isplayer(self));
    return self getspecialistindex();
}

// Namespace player_role/player_role
// Params 0, eflags: 0x0
// Checksum 0xb4e57993, Offset: 0x6b8
// Size: 0x22
function update_fields() {
    self.playerrole = self getrolefields();
}

// Namespace player_role/player_role
// Params 2, eflags: 0x0
// Checksum 0xde0266e, Offset: 0x6e8
// Size: 0x230
function set(index, force) {
    player = self;
    assert(isplayer(player));
    assert(is_valid(index));
    player.pers[#"characterindex"] = index;
    player setspecialistindex(index);
    if (isbot(self) && getdvarint(#"hash_542c037530526acb", 0) && !is_true(force)) {
        self botsetrandomcharactercustomization();
    }
    player update_fields();
    world.playerroles[self getentitynumber()] = index;
    if (currentsessionmode() == 2) {
        customloadoutindex = self stats::get_stat(#"selectedcustomclass");
    } else if (currentsessionmode() == 3 && !loadout::function_87bcb1b()) {
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
// Checksum 0xd6d4655, Offset: 0x920
// Size: 0x76
function clear() {
    player = self;
    assert(isplayer(player));
    player setspecialistindex(0);
    player.pers[#"characterindex"] = undefined;
    player.playerrole = undefined;
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x18cc06e2, Offset: 0x9a0
// Size: 0x22
function get_custom_loadout_index(characterindex) {
    return getcharacterclassindex(characterindex);
}

// Namespace player_role/player_role
// Params 1, eflags: 0x0
// Checksum 0x418566c8, Offset: 0x9d0
// Size: 0x98
function function_97d19493(name) {
    sessionmode = currentsessionmode();
    playerroletemplatecount = getplayerroletemplatecount(sessionmode);
    for (i = 0; i < playerroletemplatecount; i++) {
        var_3c6fd4f7 = function_b14806c6(i, sessionmode);
        if (var_3c6fd4f7 == name) {
            return i;
        }
    }
    return undefined;
}

