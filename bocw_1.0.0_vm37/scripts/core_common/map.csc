#namespace map;

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0xa4544fe0, Offset: 0x60
// Size: 0x14
function init() {
    get_script_bundle();
}

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0x7ca91748, Offset: 0x80
// Size: 0x72
function get_script_bundle() {
    if (!isdefined(level.var_427d6976)) {
        level.var_427d6976 = function_2717b55f();
    }
    if (!isdefined(level.var_427d6976)) {
        level.var_179eaba8 = 1;
        level.var_427d6976 = {};
    } else {
        level.var_179eaba8 = 0;
    }
    return level.var_427d6976;
}

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0x6ede9735, Offset: 0x100
// Size: 0x2e
function is_default() {
    if (!isdefined(level.var_179eaba8)) {
        level.var_179eaba8 = 1;
    }
    return level.var_179eaba8;
}

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0x6696d688, Offset: 0x138
// Size: 0x144
function function_596f8772() {
    var_427d6976 = get_script_bundle();
    if (isdefined(var_427d6976.factionlist)) {
        factionlist = getscriptbundle(var_427d6976.factionlist);
    } else {
        switch (currentsessionmode()) {
        case 0:
            faction = #"factions_zm";
            break;
        case 1:
            faction = #"factions_mp";
            break;
        case 2:
            faction = #"factions_cp";
            break;
        case 3:
            faction = #"factions_wz";
            break;
        }
        factionlist = getscriptbundle(faction);
    }
    if (isdefined(factionlist.faction)) {
        return factionlist;
    }
    return undefined;
}

