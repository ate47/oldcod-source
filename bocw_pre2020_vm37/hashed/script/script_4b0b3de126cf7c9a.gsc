#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_47a807c3;

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 0, eflags: 0x6
// Checksum 0x648caa46, Offset: 0x118
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_7587f8ddd6b0d47a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 1, eflags: 0x0
// Checksum 0x19857342, Offset: 0x170
// Size: 0xdc
function function_8d37256a(e_player) {
    foreach (player in function_a1ef346b()) {
        level thread function_81eaae89(player);
    }
    level zm_utility::function_7a35b1d7(self.hint);
    level thread zm_powerups::show_on_hud(e_player.team, "pack_a_punch");
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 0, eflags: 0x1 linked
// Checksum 0x509ad889, Offset: 0x258
// Size: 0x5c
function function_ad31c153() {
    self endon(#"death", #"bled_out");
    if (self laststand::player_is_in_laststand()) {
        self waittill(#"player_revived");
        wait 0.5;
    }
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 1, eflags: 0x1 linked
// Checksum 0x1050e42f, Offset: 0x2c0
// Size: 0x24c
function function_81eaae89(e_player) {
    e_player endon(#"death", #"bled_out");
    e_player function_ad31c153();
    var_e8145621 = e_player getweaponslistprimaries();
    w_current_weapon = e_player getcurrentweapon();
    foreach (weapon in var_e8145621) {
        if (e_player zm_weapons::can_upgrade_weapon(weapon)) {
            var_5198244f = zm_weapons::get_upgrade_weapon(weapon, 1);
        } else {
            continue;
        }
        n_clip = var_5198244f.clipsize;
        n_stock = e_player getweaponammostock(weapon);
        if (w_current_weapon == weapon) {
            var_147bd2 = var_5198244f;
        }
        e_player zm_weapons::weapon_take(weapon);
        e_player zm_weapons::weapon_give(var_5198244f, 1, 1);
        e_player setweaponammoclip(var_5198244f, n_clip);
        e_player setweaponammostock(var_5198244f, n_stock);
    }
    if (isdefined(var_147bd2)) {
        e_player shoulddoinitialweaponraise(var_147bd2, 0);
        e_player switchtoweaponimmediate(var_147bd2);
    }
    e_player thread function_40935801();
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 0, eflags: 0x1 linked
// Checksum 0x74ae57e, Offset: 0x518
// Size: 0x22c
function function_40935801() {
    self notify(#"picked_up_pap");
    self endon(#"picked_up_pap", #"death", #"bled_out");
    wait 30;
    self function_ad31c153();
    var_e8145621 = self getweaponslistprimaries();
    w_current_weapon = self getcurrentweapon();
    foreach (w_upgraded in var_e8145621) {
        var_2af07147 = self zm_weapons::get_base_weapon(w_upgraded);
        n_clip = self getweaponammoclip(w_upgraded);
        n_stock = self getweaponammostock(w_upgraded);
        if (w_current_weapon == w_upgraded) {
            var_147bd2 = var_2af07147;
        }
        self zm_weapons::weapon_take(w_upgraded);
        self zm_weapons::weapon_give(var_2af07147, 1, 0);
        self setweaponammoclip(var_2af07147, n_clip);
        self setweaponammostock(var_2af07147, n_stock);
    }
    if (isdefined(var_147bd2)) {
        self shoulddoinitialweaponraise(var_147bd2, 0);
        self switchtoweaponimmediate(var_147bd2);
    }
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 1, eflags: 0x0
// Checksum 0xcebb167a, Offset: 0x750
// Size: 0x23c
function function_35ae342e(e_player) {
    if (e_player isthrowinggrenade()) {
        while (e_player getcurrentweapon() == getweapon(#"none")) {
            wait 0.1;
        }
    }
    w_current_weapon = e_player getcurrentweapon();
    e_player.current_weapon = w_current_weapon;
    var_a56ad7fa = w_current_weapon;
    if (e_player zm_weapons::can_upgrade_weapon(w_current_weapon)) {
        var_5198244f = zm_weapons::get_upgrade_weapon(w_current_weapon, 1);
    }
    if (!isdefined(var_5198244f)) {
        e_player thread function_d0ea0364(w_current_weapon);
        return;
    }
    n_clip = var_5198244f.clipsize;
    n_stock = e_player getweaponammostock(w_current_weapon);
    e_player zm_weapons::weapon_take(w_current_weapon);
    e_player zm_weapons::weapon_give(var_5198244f, 1, 1);
    e_player shoulddoinitialweaponraise(var_5198244f, 0);
    e_player switchtoweaponimmediate(var_5198244f);
    e_player setweaponammoclip(var_5198244f, n_clip);
    e_player setweaponammostock(var_5198244f, n_stock);
    e_player zm_audio::create_and_play_dialog(#"pap", #"pickup");
    e_player zm_weapons::play_weapon_vo(var_5198244f);
    e_player thread function_d0ea0364(var_5198244f);
}

// Namespace namespace_47a807c3/namespace_33e4d1e0
// Params 1, eflags: 0x5 linked
// Checksum 0xbd42ff45, Offset: 0x998
// Size: 0x204
function private function_d0ea0364(var_5198244f) {
    self notify("picked_up_pap_" + var_5198244f.name);
    self endon("picked_up_pap_" + var_5198244f.name);
    wait 30;
    var_75c77fa = self zm_weapons::get_base_weapon(var_5198244f);
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        var_2af07147 = self zm_weapons::get_base_weapon(w_weapon);
        if (var_2af07147 == var_75c77fa) {
            var_2af07147 = self zm_weapons::get_base_weapon(var_5198244f);
            n_clip = self getweaponammoclip(var_5198244f);
            n_stock = self getweaponammostock(var_5198244f);
            self zm_weapons::weapon_take(var_5198244f);
            self zm_weapons::weapon_give(var_2af07147, 1, 0);
            self shoulddoinitialweaponraise(var_2af07147, 0);
            self switchtoweaponimmediate(var_2af07147);
            self setweaponammoclip(var_2af07147, n_clip);
            self setweaponammostock(var_2af07147, n_stock);
            break;
        }
    }
}

