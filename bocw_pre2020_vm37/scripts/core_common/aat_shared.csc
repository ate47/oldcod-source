#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x6
// Checksum 0xe60b0387, Offset: 0x108
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"aat", &function_70a657d8, &finalize_clientfields, undefined, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x495503fd, Offset: 0x160
// Size: 0x4c
function private function_70a657d8() {
    level.aat_default_info_name = "none";
    level.aat_default_info_icon = "blacktransparent";
    register("none", level.aat_default_info_name, level.aat_default_info_icon);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x64247ac1, Offset: 0x1b8
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
// Params 2, eflags: 0x1 linked
// Checksum 0xc9cb6d3a, Offset: 0x250
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
// Params 3, eflags: 0x1 linked
// Checksum 0x83891f87, Offset: 0x2e0
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
// Params 7, eflags: 0x1 linked
// Checksum 0x4962d4e, Offset: 0x468
// Size: 0x94
function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.update_aat_hud)) {
        [[ level.update_aat_hud ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    update_aat_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2765829a, Offset: 0x508
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
// Params 1, eflags: 0x1 linked
// Checksum 0x4e178feb, Offset: 0x698
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
// Params 1, eflags: 0x1 linked
// Checksum 0x67d4024c, Offset: 0x748
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb3ff8b97, Offset: 0x7f8
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
// Params 7, eflags: 0x1 linked
// Checksum 0x3a11b64, Offset: 0x950
// Size: 0x144
function update_aat_hud(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    str_localized = get_string(bwastimejump);
    icon = get_icon(bwastimejump);
    if (str_localized == "none") {
        str_localized = #"";
    }
    var_ca2e17a3 = function_1df4c3b0(fieldname, #"zm_hud");
    aatmodel = createuimodel(var_ca2e17a3, "aat");
    setuimodelvalue(aatmodel, str_localized);
    aaticonmodel = createuimodel(var_ca2e17a3, "aatIcon");
    setuimodelvalue(aaticonmodel, icon);
}

