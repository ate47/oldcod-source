#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace aimappingtable;

// Namespace aimappingtable/aimappingtable
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0xf0
// Size: 0x4
function autoexec init() {
    
}

#namespace aimappingtableutility;

// Namespace aimappingtableutility/aimappingtable
// Params 2, eflags: 0x0
// Checksum 0x34daddff, Offset: 0x100
// Size: 0x46
function setmappingtableforteam(str_team, aimappingtable) {
    str_team = util::get_team_mapping(str_team);
    level.aimapppingtable[str_team] = aimappingtable;
}

// Namespace aimappingtableutility/aimappingtable
// Params 3, eflags: 0x0
// Checksum 0x6fcb0b1e, Offset: 0x150
// Size: 0x120
function getspawnerforai(ai, team, str_mapping_table_override) {
    if (!isdefined(ai)) {
        return undefined;
    }
    aimappingtable = undefined;
    if (isdefined(str_mapping_table_override)) {
        aimappingtable = str_mapping_table_override;
    } else if (isdefined(level.aimapppingtable) && isdefined(level.aimapppingtable[team])) {
        aimappingtable = level.aimapppingtable[team];
    }
    if (!isdefined(aimappingtable)) {
        return undefined;
    }
    aimappingtablebundle = struct::get_script_bundle("aimappingtable", aimappingtable);
    if (!isdefined(aimappingtablebundle)) {
        return undefined;
    }
    aitype = aimappingtablebundle.("aitype_" + ai);
    if (isdefined(aitype)) {
        return aitype;
    }
    return aimappingtablebundle.("vehicle_" + ai);
}

