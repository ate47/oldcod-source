#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x2
// Checksum 0x27fb7d4f, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"aat", &__init__, undefined, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x1a60c2bc, Offset: 0x100
// Size: 0x94
function private __init__() {
    level.aat_initializing = 1;
    level.aat_default_info_name = "none";
    level.aat_default_info_icon = "blacktransparent";
    level.aat = [];
    register("none", level.aat_default_info_name, level.aat_default_info_icon);
    callback::on_finalize_initialization(&finalize_clientfields);
}

// Namespace aat/aat_shared
// Params 3, eflags: 0x0
// Checksum 0x447f3e69, Offset: 0x1a0
// Size: 0x16a
function register(name, localized_string, icon) {
    assert(isdefined(level.aat_initializing) && level.aat_initializing, "<dev string:x30>");
    assert(isdefined(name), "<dev string:x9b>");
    assert(!isdefined(level.aat[name]), "<dev string:xc1>" + name + "<dev string:xd8>");
    assert(isdefined(localized_string), "<dev string:xf6>");
    assert(isdefined(icon), "<dev string:x128>");
    level.aat[name] = spawnstruct();
    level.aat[name].name = name;
    level.aat[name].localized_string = localized_string;
    level.aat[name].icon = icon;
}

// Namespace aat/aat_shared
// Params 7, eflags: 0x0
// Checksum 0x22df8f4, Offset: 0x318
// Size: 0x78
function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.update_aat_hud)) {
        [[ level.update_aat_hud ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x4a3b1a78, Offset: 0x398
// Size: 0x18a
function finalize_clientfields() {
    println("<dev string:x14e>");
    if (level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.n_index = i;
            i++;
            println("<dev string:x168>" + aat.name);
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
    }
    level.aat_initializing = 0;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x732dcb4f, Offset: 0x530
// Size: 0x9a
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
// Checksum 0x3dc66f5d, Offset: 0x5d8
// Size: 0x9a
function get_icon(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return aat.icon;
        }
    }
    return level.aat_default_info_icon;
}

