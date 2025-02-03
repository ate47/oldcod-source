#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x6
// Checksum 0xc69c7322, Offset: 0x118
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"aat", &preinit, &finalize_clientfields, undefined, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x947a0983, Offset: 0x170
// Size: 0x4c
function private preinit() {
    level.aat_default_info_name = "none";
    level.aat_default_info_icon = "blacktransparent";
    register("none", level.aat_default_info_name, level.aat_default_info_icon);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x2c95600a, Offset: 0x1c8
// Size: 0x90
function function_2b3bcce0() {
    if (!isdefined(level.var_e44e90d6)) {
        return;
    }
    foreach (call in level.var_e44e90d6) {
        [[ call ]]();
    }
}

// Namespace aat/aat_shared
// Params 2, eflags: 0x0
// Checksum 0x58cc340c, Offset: 0x260
// Size: 0x84
function function_571fceb(aat_name, main) {
    if (!isdefined(level.var_e44e90d6)) {
        level.var_e44e90d6 = [];
    }
    /#
        if (isdefined(level.var_e44e90d6[aat_name])) {
            println("<dev string:x38>" + aat_name + "<dev string:x64>");
        }
    #/
    level.var_e44e90d6[aat_name] = main;
}

// Namespace aat/aat_shared
// Params 3, eflags: 0x0
// Checksum 0x7b060d9e, Offset: 0x2f0
// Size: 0x17a
function register(name, localized_string, icon) {
    if (!isdefined(level.aat)) {
        level.aat = [];
    }
    assert(!is_false(level.aat_initializing), "<dev string:x91>");
    assert(isdefined(name), "<dev string:xff>");
    assert(!isdefined(level.aat[name]), "<dev string:x128>" + name + "<dev string:x142>");
    assert(isdefined(localized_string), "<dev string:x163>");
    assert(isdefined(icon), "<dev string:x198>");
    level.aat[name] = spawnstruct();
    level.aat[name].name = name;
    level.aat[name].localized_string = localized_string;
    level.aat[name].icon = icon;
}

// Namespace aat/aat_shared
// Params 7, eflags: 0x0
// Checksum 0x2b0e637, Offset: 0x478
// Size: 0x94
function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.update_aat_hud)) {
        [[ level.update_aat_hud ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    update_aat_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x85b897c7, Offset: 0x518
// Size: 0x188
function finalize_clientfields() {
    println("<dev string:x1c1>");
    if (level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.n_index = i;
            i++;
            println("<dev string:x1de>" + aat.name);
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
    }
    level.aat_initializing = 0;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x9d7316e6, Offset: 0x6a8
// Size: 0xb2
function function_d1852e75(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return hash(aat.name);
        }
    }
    return #"none";
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x9f31b682, Offset: 0x768
// Size: 0xa6
function get_string(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return aat.localized_string;
        }
    }
    return level.aat_default_info_name;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x5ee71925, Offset: 0x818
// Size: 0xa6
function get_icon(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return aat.icon;
        }
    }
    return level.aat_default_info_icon;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x93a080d6, Offset: 0x8c8
// Size: 0x14e
function function_467efa7b(var_9f3fb329 = 0) {
    if (!isdefined(self.archetype)) {
        return "tag_origin";
    }
    switch (self.archetype) {
    case #"stoker":
    case #"catalyst":
    case #"gladiator":
    case #"nova_crawler":
    case #"zombie":
    case #"ghost":
    case #"brutus":
        if (var_9f3fb329) {
            str_tag = "j_spine4";
        } else {
            str_tag = "j_spineupper";
        }
        break;
    case #"blight_father":
    case #"tiger":
    case #"elephant":
        str_tag = "j_head";
        break;
    default:
        str_tag = "tag_origin";
        break;
    }
    return str_tag;
}

// Namespace aat/aat_shared
// Params 7, eflags: 0x0
// Checksum 0x16e0a98, Offset: 0xa20
// Size: 0x1a4
function update_aat_hud(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    name_hash = function_d1852e75(bwastimejump);
    str_localized = get_string(bwastimejump);
    icon = get_icon(bwastimejump);
    if (str_localized == "none") {
        str_localized = #"";
    }
    var_ca2e17a3 = function_1df4c3b0(fieldname, #"zm_hud");
    var_2961e149 = createuimodel(var_ca2e17a3, "aatNameHash");
    setuimodelvalue(var_2961e149, name_hash);
    aatmodel = createuimodel(var_ca2e17a3, "aat");
    setuimodelvalue(aatmodel, str_localized);
    aaticonmodel = createuimodel(var_ca2e17a3, "aatIcon");
    setuimodelvalue(aaticonmodel, icon);
}

