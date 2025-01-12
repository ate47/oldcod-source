#using scripts\core_common\perks;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_weapons;

#namespace zm_bgb_free_fire;

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x2
// Checksum 0x45f95e5c, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_free_fire", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x0
// Checksum 0xa7c51692, Offset: 0xf0
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_free_fire", "time", 30, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x0
// Checksum 0x9bb108f9, Offset: 0x170
// Size: 0x180
function enable() {
    self thread function_597e6e74();
    self.n_ammo_total = 0;
    var_d64d7700 = self getweaponslistprimaries();
    foreach (var_1e8f26a0 in var_d64d7700) {
        n_ammo_stock = self getweaponammostock(var_1e8f26a0);
        n_ammo_clip = self getweaponammoclip(var_1e8f26a0);
        self.n_ammo_total += n_ammo_stock + n_ammo_clip;
    }
    if (!self.n_ammo_total) {
        foreach (var_1e8f26a0 in var_d64d7700) {
            self setweaponammoclip(var_1e8f26a0, 1);
        }
    }
}

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x0
// Checksum 0x32d1aeed, Offset: 0x2f8
// Size: 0x5c
function disable() {
    self notify(#"hash_1b878c77be2d017b");
    wait 0.1;
    if (self hasperk("specialty_freefire")) {
        self perks::perk_unsetperk("specialty_freefire");
    }
}

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x0
// Checksum 0x3e308aaf, Offset: 0x360
// Size: 0x1a8
function function_597e6e74() {
    self endon(#"disconnect", #"player_downed", #"hash_1b878c77be2d017b");
    w_current = self getcurrentweapon();
    if (!(isdefined(w_current.isheroweapon) && w_current.isheroweapon) && !zm_weapons::is_wonder_weapon(w_current)) {
        self perks::perk_setperk("specialty_freefire");
    }
    while (true) {
        s_notify = self waittill(#"weapon_change");
        w_check = s_notify.weapon;
        if (isdefined(w_check.isheroweapon) && w_check.isheroweapon || zm_weapons::is_wonder_weapon(w_check)) {
            if (self hasperk("specialty_freefire")) {
                self perks::perk_unsetperk("specialty_freefire");
            }
            continue;
        }
        if (!self hasperk("specialty_freefire")) {
            self perks::perk_setperk("specialty_freefire");
        }
    }
}

