#namespace activecamo;

// Namespace activecamo/activecamo_shared_util
// Params 1, eflags: 0x0
// Checksum 0x924001a7, Offset: 0x70
// Size: 0x6e
function function_b259f3e0(camoweapon) {
    assert(isdefined(camoweapon));
    var_e69cf15d = function_3786d342(camoweapon);
    if (isdefined(var_e69cf15d) && var_e69cf15d != level.weaponnone) {
        camoweapon = var_e69cf15d;
    }
    return camoweapon;
}

// Namespace activecamo/activecamo_shared_util
// Params 1, eflags: 0x0
// Checksum 0xa8e044ff, Offset: 0xe8
// Size: 0xea
function function_c14cb514(weapon) {
    if (isdefined(level.var_f06de157)) {
        return [[ level.var_f06de157 ]](weapon);
    }
    if (isdefined(weapon)) {
        if (level.weaponnone != weapon) {
            activecamoweapon = function_b259f3e0(weapon);
            if (activecamoweapon.isaltmode) {
                if (isdefined(activecamoweapon.altweapon) && level.weaponnone != activecamoweapon.altweapon) {
                    activecamoweapon = activecamoweapon.altweapon;
                }
            }
            if (isdefined(activecamoweapon.rootweapon) && level.weaponnone != activecamoweapon.rootweapon) {
                return activecamoweapon.rootweapon;
            }
            return activecamoweapon;
        }
    }
    return weapon;
}

// Namespace activecamo/activecamo_shared_util
// Params 1, eflags: 0x0
// Checksum 0x2cfdd1b0, Offset: 0x1e0
// Size: 0xd0
function function_94c2605(weapon) {
    if (isdefined(weapon)) {
        if (level.weaponnone != weapon) {
            activecamoweapon = weapon;
            if (activecamoweapon.inventorytype == "dwlefthand") {
                if (isdefined(activecamoweapon.dualwieldweapon) && level.weaponnone != activecamoweapon.dualwieldweapon) {
                    activecamoweapon = activecamoweapon.dualwieldweapon;
                }
            }
            if (activecamoweapon.isaltmode) {
                if (isdefined(activecamoweapon.altweapon) && level.weaponnone != activecamoweapon.altweapon) {
                    activecamoweapon = activecamoweapon.altweapon;
                }
            }
            return activecamoweapon;
        }
    }
    return weapon;
}

// Namespace activecamo/activecamo_shared_util
// Params 1, eflags: 0x0
// Checksum 0x302f4252, Offset: 0x2b8
// Size: 0x72
function function_13e12ab1(camoindex) {
    var_f4eb4a50 = undefined;
    activecamoname = getactivecamo(camoindex);
    if (isdefined(activecamoname) && activecamoname != #"") {
        var_f4eb4a50 = getscriptbundle(activecamoname);
    }
    return var_f4eb4a50;
}

// Namespace activecamo/activecamo_shared_util
// Params 1, eflags: 0x0
// Checksum 0xaff6e5b4, Offset: 0x338
// Size: 0x42
function function_edd6511(camooptions) {
    camoindex = getcamoindex(camooptions);
    return function_13e12ab1(camoindex);
}

// Namespace activecamo/activecamo_shared_util
// Params 1, eflags: 0x0
// Checksum 0xac73e1d1, Offset: 0x388
// Size: 0x42
function function_5af7df72(camooptions) {
    camoindex = getcamoindex(camooptions);
    return getactivecamo(camoindex);
}

