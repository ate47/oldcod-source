#using scripts\core_common\system_shared;

#namespace classicmode;

// Namespace classicmode/classicmode
// Params 0, eflags: 0x6
// Checksum 0x33b75a39, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"classicmode", &preinit, undefined, undefined, undefined);
}

// Namespace classicmode/classicmode
// Params 0, eflags: 0x4
// Checksum 0xbab8bc08, Offset: 0xb0
// Size: 0x4c
function private preinit() {
    level.classicmode = getgametypesetting(#"classicmode");
    if (level.classicmode) {
        enableclassicmode();
    }
}

// Namespace classicmode/classicmode
// Params 0, eflags: 0x0
// Checksum 0x4ed0f3de, Offset: 0x108
// Size: 0x164
function enableclassicmode() {
    setdvar(#"playerenergy_slideenergyenabled", 0);
    setdvar(#"trm_maxsidemantleheight", 0);
    setdvar(#"trm_maxbackmantleheight", 0);
    setdvar(#"player_swimming_enabled", 0);
    setdvar(#"player_swimheightratio", 0.9);
    setdvar(#"jump_slowdownenable", 1);
    setdvar(#"sprint_allowrestore", 0);
    setdvar(#"sprint_allowrechamber", 0);
    setdvar(#"cg_blur_time", 500);
    setdvar(#"tu11_enableclassicmode", 1);
}

