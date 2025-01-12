#using scripts/core_common/system_shared;

#namespace tweakables;

// Namespace tweakables/tweakables_shared
// Params 0, eflags: 0x2
// Checksum 0x77cdb7fe, Offset: 0x458
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("tweakables", &__init__, undefined, undefined);
}

// Namespace tweakables/tweakables_shared
// Params 0, eflags: 0x0
// Checksum 0xd729223f, Offset: 0x498
// Size: 0x4f4
function __init__() {
    level.clienttweakables = [];
    level.tweakablesinitialized = 1;
    level.rules = [];
    level.gametweaks = [];
    level.teamtweaks = [];
    level.playertweaks = [];
    level.classtweaks = [];
    level.weapontweaks = [];
    level.hardpointtweaks = [];
    level.hudtweaks = [];
    registertweakable("game", "arcadescoring", "scr_game_arcadescoring", 0);
    registertweakable("game", "difficulty", "scr_game_difficulty", 1);
    registertweakable("game", "pinups", "scr_game_pinups", 0);
    registertweakable("team", "teamkillerplaylistbanquantum", "scr_team_teamkillerplaylistbanquantum", 0);
    registertweakable("team", "teamkillerplaylistbanpenalty", "scr_team_teamkillerplaylistbanpenalty", 0);
    registertweakable("player", "allowrevive", "scr_player_allowrevive", 1);
    registertweakable("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
    registertweakable("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
    registertweakable("weapon", "allowflash", "scr_weapon_allowflash", 1);
    registertweakable("weapon", "allowc4", "scr_weapon_allowc4", 1);
    registertweakable("weapon", "allowsatchel", "scr_weapon_allowsatchel", 1);
    registertweakable("weapon", "allowbetty", "scr_weapon_allowbetty", 1);
    registertweakable("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
    registertweakable("weapon", "allowmines", "scr_weapon_allowmines", 1);
    registertweakable("hud", "showobjicons", "ui_hud_showobjicons", 1);
    setclienttweakable("hud", "showobjicons");
    registertweakable("killstreak", "allowradar", "scr_hardpoint_allowradar", 1);
    registertweakable("killstreak", "allowradardirection", "scr_hardpoint_allowradardirection", 1);
    registertweakable("killstreak", "allowcounteruav", "scr_hardpoint_allowcounteruav", 1);
    registertweakable("killstreak", "allowdogs", "scr_hardpoint_allowdogs", 1);
    registertweakable("killstreak", "allowhelicopter_comlink", "scr_hardpoint_allowhelicopter_comlink", 1);
    registertweakable("killstreak", "allowrcbomb", "scr_hardpoint_allowrcbomb", 1);
    registertweakable("killstreak", "allowauto_turret", "scr_hardpoint_allowauto_turret", 1);
    /#
        debug_refresh = 1;
    #/
    level thread updateuitweakables(debug_refresh);
}

// Namespace tweakables/tweakables_shared
// Params 2, eflags: 0x0
// Checksum 0xeedfadbb, Offset: 0x998
// Size: 0x1e4
function gettweakabledvarvalue(category, name) {
    switch (category) {
    case #"rule":
        dvar = level.rules[name].dvar;
        break;
    case #"game":
        dvar = level.gametweaks[name].dvar;
        break;
    case #"team":
        dvar = level.teamtweaks[name].dvar;
        break;
    case #"player":
        dvar = level.playertweaks[name].dvar;
        break;
    case #"class":
        dvar = level.classtweaks[name].dvar;
        break;
    case #"weapon":
        dvar = level.weapontweaks[name].dvar;
        break;
    case #"killstreak":
        dvar = level.hardpointtweaks[name].dvar;
        break;
    case #"hud":
        dvar = level.hudtweaks[name].dvar;
        break;
    default:
        dvar = undefined;
        break;
    }
    /#
        assert(isdefined(dvar));
    #/
    value = getdvarint(dvar);
    return value;
}

// Namespace tweakables/tweakables_shared
// Params 2, eflags: 0x0
// Checksum 0x9ed35252, Offset: 0xb88
// Size: 0x1c0
function gettweakabledvar(category, name) {
    switch (category) {
    case #"rule":
        value = level.rules[name].dvar;
        break;
    case #"game":
        value = level.gametweaks[name].dvar;
        break;
    case #"team":
        value = level.teamtweaks[name].dvar;
        break;
    case #"player":
        value = level.playertweaks[name].dvar;
        break;
    case #"class":
        value = level.classtweaks[name].dvar;
        break;
    case #"weapon":
        value = level.weapontweaks[name].dvar;
        break;
    case #"killstreak":
        value = level.hardpointtweaks[name].dvar;
        break;
    case #"hud":
        value = level.hudtweaks[name].dvar;
        break;
    default:
        value = undefined;
        break;
    }
    /#
        assert(isdefined(value));
    #/
    return value;
}

// Namespace tweakables/tweakables_shared
// Params 2, eflags: 0x0
// Checksum 0x81f226e3, Offset: 0xd50
// Size: 0x240
function gettweakablevalue(category, name) {
    switch (category) {
    case #"rule":
        value = level.rules[name].value;
        break;
    case #"game":
        value = level.gametweaks[name].value;
        break;
    case #"team":
        value = level.teamtweaks[name].value;
        break;
    case #"player":
        value = level.playertweaks[name].value;
        break;
    case #"class":
        value = level.classtweaks[name].value;
        break;
    case #"weapon":
        value = level.weapontweaks[name].value;
        break;
    case #"killstreak":
        value = level.hardpointtweaks[name].value;
        break;
    case #"hud":
        value = level.hudtweaks[name].value;
        break;
    default:
        value = undefined;
        break;
    }
    overridedvar = "scr_" + level.gametype + "_" + category + "_" + name;
    if (getdvarstring(overridedvar) != "") {
        return getdvarint(overridedvar);
    }
    /#
        assert(isdefined(value));
    #/
    return value;
}

// Namespace tweakables/tweakables_shared
// Params 2, eflags: 0x0
// Checksum 0xfc197e6c, Offset: 0xf98
// Size: 0x1c0
function gettweakablelastvalue(category, name) {
    switch (category) {
    case #"rule":
        value = level.rules[name].lastvalue;
        break;
    case #"game":
        value = level.gametweaks[name].lastvalue;
        break;
    case #"team":
        value = level.teamtweaks[name].lastvalue;
        break;
    case #"player":
        value = level.playertweaks[name].lastvalue;
        break;
    case #"class":
        value = level.classtweaks[name].lastvalue;
        break;
    case #"weapon":
        value = level.weapontweaks[name].lastvalue;
        break;
    case #"killstreak":
        value = level.hardpointtweaks[name].lastvalue;
        break;
    case #"hud":
        value = level.hudtweaks[name].lastvalue;
        break;
    default:
        value = undefined;
        break;
    }
    /#
        assert(isdefined(value));
    #/
    return value;
}

// Namespace tweakables/tweakables_shared
// Params 3, eflags: 0x0
// Checksum 0xa609cd64, Offset: 0x1160
// Size: 0x1c4
function settweakablevalue(category, name, value) {
    switch (category) {
    case #"rule":
        dvar = level.rules[name].dvar;
        break;
    case #"game":
        dvar = level.gametweaks[name].dvar;
        break;
    case #"team":
        dvar = level.teamtweaks[name].dvar;
        break;
    case #"player":
        dvar = level.playertweaks[name].dvar;
        break;
    case #"class":
        dvar = level.classtweaks[name].dvar;
        break;
    case #"weapon":
        dvar = level.weapontweaks[name].dvar;
        break;
    case #"killstreak":
        dvar = level.hardpointtweaks[name].dvar;
        break;
    case #"hud":
        dvar = level.hudtweaks[name].dvar;
        break;
    default:
        dvar = undefined;
        break;
    }
    setdvar(dvar, value);
}

// Namespace tweakables/tweakables_shared
// Params 3, eflags: 0x0
// Checksum 0xf3de381b, Offset: 0x1330
// Size: 0x19a
function settweakablelastvalue(category, name, value) {
    switch (category) {
    case #"rule":
        level.rules[name].lastvalue = value;
        break;
    case #"game":
        level.gametweaks[name].lastvalue = value;
        break;
    case #"team":
        level.teamtweaks[name].lastvalue = value;
        break;
    case #"player":
        level.playertweaks[name].lastvalue = value;
        break;
    case #"class":
        level.classtweaks[name].lastvalue = value;
        break;
    case #"weapon":
        level.weapontweaks[name].lastvalue = value;
        break;
    case #"killstreak":
        level.hardpointtweaks[name].lastvalue = value;
        break;
    case #"hud":
        level.hudtweaks[name].lastvalue = value;
        break;
    default:
        break;
    }
}

// Namespace tweakables/tweakables_shared
// Params 4, eflags: 0x0
// Checksum 0x489ccabf, Offset: 0x14d8
// Size: 0x64a
function registertweakable(category, name, dvar, value) {
    if (isstring(value)) {
        if (getdvarstring(dvar) == "") {
            setdvar(dvar, value);
        } else {
            value = getdvarstring(dvar);
        }
    } else if (getdvarstring(dvar) == "") {
        setdvar(dvar, value);
    } else {
        value = getdvarint(dvar);
    }
    switch (category) {
    case #"rule":
        if (!isdefined(level.rules[name])) {
            level.rules[name] = spawnstruct();
        }
        level.rules[name].value = value;
        level.rules[name].lastvalue = value;
        level.rules[name].dvar = dvar;
        break;
    case #"game":
        if (!isdefined(level.gametweaks[name])) {
            level.gametweaks[name] = spawnstruct();
        }
        level.gametweaks[name].value = value;
        level.gametweaks[name].lastvalue = value;
        level.gametweaks[name].dvar = dvar;
        break;
    case #"team":
        if (!isdefined(level.teamtweaks[name])) {
            level.teamtweaks[name] = spawnstruct();
        }
        level.teamtweaks[name].value = value;
        level.teamtweaks[name].lastvalue = value;
        level.teamtweaks[name].dvar = dvar;
        break;
    case #"player":
        if (!isdefined(level.playertweaks[name])) {
            level.playertweaks[name] = spawnstruct();
        }
        level.playertweaks[name].value = value;
        level.playertweaks[name].lastvalue = value;
        level.playertweaks[name].dvar = dvar;
        break;
    case #"class":
        if (!isdefined(level.classtweaks[name])) {
            level.classtweaks[name] = spawnstruct();
        }
        level.classtweaks[name].value = value;
        level.classtweaks[name].lastvalue = value;
        level.classtweaks[name].dvar = dvar;
        break;
    case #"weapon":
        if (!isdefined(level.weapontweaks[name])) {
            level.weapontweaks[name] = spawnstruct();
        }
        level.weapontweaks[name].value = value;
        level.weapontweaks[name].lastvalue = value;
        level.weapontweaks[name].dvar = dvar;
        break;
    case #"killstreak":
        if (!isdefined(level.hardpointtweaks[name])) {
            level.hardpointtweaks[name] = spawnstruct();
        }
        level.hardpointtweaks[name].value = value;
        level.hardpointtweaks[name].lastvalue = value;
        level.hardpointtweaks[name].dvar = dvar;
        break;
    case #"hud":
        if (!isdefined(level.hudtweaks[name])) {
            level.hudtweaks[name] = spawnstruct();
        }
        level.hudtweaks[name].value = value;
        level.hudtweaks[name].lastvalue = value;
        level.hudtweaks[name].dvar = dvar;
        break;
    }
}

// Namespace tweakables/tweakables_shared
// Params 2, eflags: 0x0
// Checksum 0x6d6b664f, Offset: 0x1b30
// Size: 0x32
function setclienttweakable(category, name) {
    level.clienttweakables[level.clienttweakables.size] = name;
}

// Namespace tweakables/tweakables_shared
// Params 1, eflags: 0x0
// Checksum 0x9e1edd71, Offset: 0x1b70
// Size: 0x136
function updateuitweakables(debug_refresh) {
    do {
        for (index = 0; index < level.clienttweakables.size; index++) {
            clienttweakable = level.clienttweakables[index];
            curvalue = gettweakabledvarvalue("hud", clienttweakable);
            lastvalue = gettweakablelastvalue("hud", clienttweakable);
            if (curvalue != lastvalue) {
                function_13dc3b34(gettweakabledvar("hud", clienttweakable), curvalue);
                settweakablelastvalue("hud", clienttweakable, curvalue);
            }
        }
        wait randomfloatrange(0.9, 1.1);
    } while (isdefined(debug_refresh));
}

// Namespace tweakables/tweakables_shared
// Params 2, eflags: 0x0
// Checksum 0xf01fb83f, Offset: 0x1cb0
// Size: 0x14
function function_13dc3b34(dvar, value) {
    
}

