#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_loadout;

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x2
// Checksum 0xb73b9cca, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_loadout", &__init__, undefined, undefined);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x5f5f666d, Offset: 0x158
// Size: 0x2c
function __init__() {
    /#
        callback::on_localplayer_spawned(&on_localplayer_spawned);
    #/
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x4db2bfc4, Offset: 0x190
// Size: 0x1ce
function on_localplayer_spawned(localclientnum) {
    self.class_num = 0;
    self.loadout = [];
    var_556a3847 = self get_loadout_item(localclientnum, "primarygrenade");
    self.loadout[#"lethal"] = getunlockableiteminfofromindex(var_556a3847, 1);
    var_dc5b5fb7 = self get_loadout_item(localclientnum, "primary");
    self.loadout[#"primary"] = getunlockableiteminfofromindex(var_dc5b5fb7, 1);
    self.loadout[#"perks"] = [];
    for (i = 1; i <= 4; i++) {
        var_9a6b6100 = self get_loadout_item(localclientnum, "specialty" + i);
        self.loadout[#"perks"][i] = getunlockableiteminfofromindex(var_9a6b6100, 3);
    }
    self.loadout[#"hero"] = self function_2e08c289(localclientnum, "herogadget");
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0x7b3e58e6, Offset: 0x368
// Size: 0xaa
function get_loadout_item(localclientnum, slot) {
    if (!self isplayer()) {
        return undefined;
    }
    if (!isdefined(self.class_num)) {
        self.class_num = self stats::get_stat(localclientnum, #"selectedcustomclass");
    }
    if (!isdefined(self.class_num)) {
        self.class_num = 0;
    }
    return self getloadoutitem(localclientnum, self.class_num, slot);
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0xf99f8778, Offset: 0x420
// Size: 0xaa
function function_2e08c289(localclientnum, slot) {
    if (!self isplayer()) {
        return undefined;
    }
    if (!isdefined(self.class_num)) {
        self.class_num = self stats::get_stat(localclientnum, #"selectedcustomclass");
    }
    if (!isdefined(self.class_num)) {
        self.class_num = 0;
    }
    return self getloadoutweapon(localclientnum, self.class_num, slot);
}

