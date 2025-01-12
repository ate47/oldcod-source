#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_equip_shield;

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 0, eflags: 0x6
// Checksum 0xc2a4e8, Offset: 0x128
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_equip_shield", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 0, eflags: 0x4
// Checksum 0x6bbd8da8, Offset: 0x170
// Size: 0x104
function private function_70a657d8() {
    callback::on_spawned(&player_on_spawned);
    clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter", &zm_shield_damage_rumble, 0, 0);
    clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter", &zm_shield_break_rumble, 0, 0);
    clientfield::register_clientuimodel("ZMInventoryPersonal.shield_health", #"hash_1d3ddede734994d8", #"shield_health", 1, 4, "float", undefined, 0, 0);
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 1, eflags: 0x0
// Checksum 0xf5a66d78, Offset: 0x280
// Size: 0x24
function player_on_spawned(localclientnum) {
    self thread watch_weapon_changes(localclientnum);
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 1, eflags: 0x0
// Checksum 0x98a9b47f, Offset: 0x2b0
// Size: 0x120
function watch_weapon_changes(*localclientnum) {
    self endon(#"death");
    while (isdefined(self)) {
        waitresult = self waittill(#"weapon_change");
        w_current = waitresult.weapon;
        w_previous = waitresult.last_weapon;
        if (w_current.isriotshield) {
            for (i = 0; i < w_current.var_21329beb.size; i++) {
                util::lock_model(w_current.var_21329beb[i]);
            }
            continue;
        }
        if (w_previous.isriotshield) {
            for (i = 0; i < w_previous.var_21329beb.size; i++) {
                util::unlock_model(w_previous.var_21329beb[i]);
            }
        }
    }
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 7, eflags: 0x0
// Checksum 0xae387050, Offset: 0x3d8
// Size: 0x64
function zm_shield_damage_rumble(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrumbleonentity(fieldname, "zm_shield_damage");
    }
}

// Namespace zm_equip_shield/zm_weap_riotshield
// Params 7, eflags: 0x0
// Checksum 0x91d28e8b, Offset: 0x448
// Size: 0x64
function zm_shield_break_rumble(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrumbleonentity(fieldname, "zm_shield_break");
    }
}

