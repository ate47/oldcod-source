#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_utility;

#namespace zm_bgb_phantom_reload;

// Namespace zm_bgb_phantom_reload/zm_bgb_phantom_reload
// Params 0, eflags: 0x2
// Checksum 0x40cc6fd7, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_phantom_reload", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_phantom_reload/zm_bgb_phantom_reload
// Params 0, eflags: 0x0
// Checksum 0x379ea33, Offset: 0xe0
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_phantom_reload", "time", 240, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_phantom_reload/zm_bgb_phantom_reload
// Params 0, eflags: 0x0
// Checksum 0x52c80ca4, Offset: 0x160
// Size: 0x1c
function enable() {
    self thread function_f7065f6e();
}

// Namespace zm_bgb_phantom_reload/zm_bgb_phantom_reload
// Params 0, eflags: 0x0
// Checksum 0xca1b7207, Offset: 0x188
// Size: 0x16
function disable() {
    self notify(#"hash_1980fe24a98adbe4");
}

// Namespace zm_bgb_phantom_reload/zm_bgb_phantom_reload
// Params 0, eflags: 0x0
// Checksum 0x9b5ad2dc, Offset: 0x1a8
// Size: 0xc0
function function_f7065f6e() {
    self endon(#"hash_1980fe24a98adbe4");
    while (true) {
        self waittill(#"reload_start");
        if (math::cointoss(13)) {
            w_current = self getcurrentweapon();
            if (w_current.isabilityweapon) {
                continue;
            }
            n_clip_size = w_current.clipsize;
            self setweaponammoclip(w_current, n_clip_size);
        }
    }
}

