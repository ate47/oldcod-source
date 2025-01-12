#using scripts\core_common\perks;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_stock_option;

// Namespace zm_bgb_stock_option/zm_bgb_stock_option
// Params 0, eflags: 0x2
// Checksum 0x71d26a7d, Offset: 0xa8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_stock_option", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_stock_option/zm_bgb_stock_option
// Params 0, eflags: 0x0
// Checksum 0x2e9404e, Offset: 0xf8
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_stock_option", "time", 120, &enable, &disable, undefined);
}

// Namespace zm_bgb_stock_option/zm_bgb_stock_option
// Params 0, eflags: 0x0
// Checksum 0x811e8694, Offset: 0x178
// Size: 0x174
function enable() {
    self perks::perk_setperk("specialty_ammodrainsfromstockfirst");
    w_previous = self.previousweapon;
    if (w_previous.isprimary) {
        n_clip = self getweaponammoclip(w_previous);
        n_clip_size = w_previous.clipsize;
        n_stock_size = self getweaponammostock(w_previous);
        var_1f414ba4 = n_clip_size - n_clip;
        if (var_1f414ba4 > 0 && n_stock_size > 0) {
            if (n_stock_size >= var_1f414ba4) {
                self setweaponammoclip(w_previous, n_clip_size);
                var_6cd3c191 = n_stock_size - var_1f414ba4;
                self setweaponammostock(w_previous, var_6cd3c191);
                return;
            }
            var_dab9a453 = n_clip + n_stock_size;
            self setweaponammoclip(w_previous, var_dab9a453);
            self setweaponammostock(w_previous, 0);
        }
    }
}

// Namespace zm_bgb_stock_option/zm_bgb_stock_option
// Params 0, eflags: 0x0
// Checksum 0x6a73a152, Offset: 0x2f8
// Size: 0x24
function disable() {
    self perks::perk_unsetperk("specialty_ammodrainsfromstockfirst");
}

