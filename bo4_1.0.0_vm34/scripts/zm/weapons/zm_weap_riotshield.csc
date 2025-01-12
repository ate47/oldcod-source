#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_weapons;

#namespace zm_equip_shield;

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 0, eflags: 0x2
// Checksum 0x293c1353, Offset: 0x130
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_equip_shield", &__init__, undefined, undefined);
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0xa5ac8e06, Offset: 0x178
// Size: 0xec
function __init__() {
    callback::on_spawned(&player_on_spawned);
    clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter", &zm_shield_damage_rumble, 0, 0);
    clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter", &zm_shield_break_rumble, 0, 0);
    clientfield::register("clientuimodel", "ZMInventoryPersonal.shield_health", 1, 4, "float", undefined, 0, 0);
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 1, eflags: 0x0
// Checksum 0x3d4fd1a2, Offset: 0x270
// Size: 0x24
function player_on_spawned(localclientnum) {
    self thread watch_weapon_changes(localclientnum);
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 1, eflags: 0x0
// Checksum 0x26846c22, Offset: 0x2a0
// Size: 0x90
function watch_weapon_changes(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    while (isdefined(self)) {
        waitresult = self waittill(#"weapon_change");
        if (waitresult.weapon.isriotshield) {
            self thread function_9287ee54(localclientnum, waitresult.weapon);
        }
    }
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 2, eflags: 0x0
// Checksum 0xa0350d21, Offset: 0x338
// Size: 0xde
function function_9287ee54(localclientnum, weapon) {
    for (i = 0; i < weapon.var_4bf95482.size; i++) {
        util::lock_model(weapon.var_4bf95482[i]);
    }
    self waittill(#"weapon_change", #"disconnect", #"death");
    for (i = 0; i < weapon.var_4bf95482.size; i++) {
        util::unlock_model(weapon.var_4bf95482[i]);
    }
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 7, eflags: 0x0
// Checksum 0xdbb23953, Offset: 0x420
// Size: 0x64
function zm_shield_damage_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrumbleonentity(localclientnum, "zm_shield_damage");
    }
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 7, eflags: 0x0
// Checksum 0xfe421550, Offset: 0x490
// Size: 0x64
function zm_shield_break_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrumbleonentity(localclientnum, "zm_shield_break");
    }
}

