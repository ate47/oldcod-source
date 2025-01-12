#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x2
// Checksum 0x34eede1f, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("aat", &__init__, undefined, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0xe3dd7ec7, Offset: 0x1b8
// Size: 0x9c
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
// Checksum 0xa6f92cb9, Offset: 0x260
// Size: 0x190
function register(name, localized_string, icon) {
    assert(isdefined(level.aat_initializing) && level.aat_initializing, "<dev string:x28>");
    assert(isdefined(name), "<dev string:x93>");
    assert(!isdefined(level.aat[name]), "<dev string:xb9>" + name + "<dev string:xd0>");
    assert(isdefined(localized_string), "<dev string:xee>");
    assert(isdefined(icon), "<dev string:x120>");
    level.aat[name] = spawnstruct();
    level.aat[name].name = name;
    level.aat[name].localized_string = localized_string;
    level.aat[name].icon = icon;
}

// Namespace aat/aat_shared
// Params 7, eflags: 0x0
// Checksum 0x462926bd, Offset: 0x3f8
// Size: 0x7c
function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.update_aat_hud)) {
        [[ level.update_aat_hud ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x10ac41e8, Offset: 0x480
// Size: 0x19c
function finalize_clientfields() {
    println("<dev string:x146>");
    if (level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.n_index = i;
            i++;
            println("<dev string:x160>" + aat.name);
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
    }
    level.aat_initializing = 0;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x6df8a208, Offset: 0x628
// Size: 0xb2
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
// Checksum 0x4d67657b, Offset: 0x6e8
// Size: 0xb2
function get_icon(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return aat.icon;
        }
    }
    return level.aat_default_info_icon;
}

