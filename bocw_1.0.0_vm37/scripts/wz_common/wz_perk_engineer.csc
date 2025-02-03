#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;

#namespace wz_perk_engineer;

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x6
// Checksum 0xb8f7d755, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_perk_engineer", &preinit, undefined, undefined, undefined);
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x4
// Checksum 0x1c0f0bb8, Offset: 0xf8
// Size: 0x10c
function private preinit() {
    if (false) {
        renderoverridebundle::function_f72f089c(#"hash_f5de00feee70c13", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", &function_8550d243);
    }
    renderoverridebundle::function_f72f089c(#"hash_77f7418d2f2a7890", #"rob_sonar_set_enemyequip", &function_62888a11);
    renderoverridebundle::function_f72f089c(#"hash_61c696df3d5a1765", #"hash_44adc567f9f60d61", &function_b52a94e5);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0x7e6d564f, Offset: 0x210
// Size: 0x3c
function private on_localplayer_spawned(localclientnum) {
    if (self function_21c0fa55()) {
        self thread function_7800b9c2(localclientnum);
    }
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x0
// Checksum 0x486453, Offset: 0x258
// Size: 0xbe
function function_e446e567(*notifyhash) {
    if (!isdefined(self.var_100abb43) || !isarray(self.var_100abb43)) {
        return;
    }
    foreach (item in self.var_100abb43) {
        if (isdefined(item)) {
            item.var_f19b4afd = undefined;
        }
    }
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0xda780498, Offset: 0x320
// Size: 0x390
function private function_7800b9c2(localclientnum) {
    level endon(#"game_ended");
    self endoncallback(&function_e446e567, #"death");
    if (!isdefined(self.var_100abb43)) {
        self.var_100abb43 = [];
    }
    while (true) {
        var_94c264dd = self hasperk(localclientnum, #"specialty_showenemyequipment");
        if (!var_94c264dd && isdefined(self.var_53204996)) {
            var_94c264dd |= self [[ self.var_53204996 ]](localclientnum);
        }
        if (!var_94c264dd && self.var_100abb43.size == 0) {
            wait 0.2;
            continue;
        }
        var_5ef114b0 = [];
        if (var_94c264dd) {
            var_7c16c290 = array::filter(level.enemyequip, 0, &function_5118c0a3);
            items = arraycombine(level.allvehicles, var_7c16c290, 0, 0);
            arrayremovevalue(items, undefined, 0);
            var_5ef114b0 = arraysortclosest(items, self.origin, 5, 0, 7200);
        }
        foreach (item in self.var_100abb43) {
            if (isdefined(item)) {
                item.var_f19b4afd = undefined;
            }
        }
        foreach (item in var_5ef114b0) {
            item.var_f19b4afd = 1;
        }
        var_2e2e2808 = arraycombine(self.var_100abb43, var_5ef114b0, 0, 0);
        foreach (item in var_2e2e2808) {
            if (isdefined(item)) {
                if (isdefined(item.vehicletype)) {
                } else {
                    item weaponobjects::updateenemyequipment(localclientnum, undefined);
                }
            }
            waitframe(1);
        }
        self.var_100abb43 = var_5ef114b0;
        wait 0.2;
    }
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0xd8ed1ec0, Offset: 0x6b8
// Size: 0x2e
function private function_5118c0a3(item) {
    return isdefined(item) && !item function_ca024039();
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x4
// Checksum 0x1d28e0f0, Offset: 0x6f0
// Size: 0x6a
function private function_76a0624a() {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return 0;
    }
    if (self.owner.team == #"neutral") {
        return 0;
    }
    return self.owner function_ca024039();
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x4
// Checksum 0x4fc12cef, Offset: 0x768
// Size: 0x6c
function private function_da8108ae() {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return false;
    }
    if (self.owner.team == #"neutral") {
        return false;
    }
    return !self.owner function_ca024039();
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 2, eflags: 0x4
// Checksum 0x50ee02aa, Offset: 0x7e0
// Size: 0xc0
function private function_8550d243(localclientnum, *bundle) {
    if (function_4e3684f2(bundle)) {
        return false;
    }
    if (self.type === "vehicle" && isinvehicle(bundle, self)) {
        return false;
    }
    if (self.type === "vehicle_corpse") {
        return false;
    }
    if (self function_76a0624a() && is_true(self.var_f19b4afd)) {
        return true;
    }
    return false;
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 2, eflags: 0x4
// Checksum 0xa6b3e071, Offset: 0x8a8
// Size: 0xc0
function private function_62888a11(localclientnum, *bundle) {
    if (function_4e3684f2(bundle)) {
        return false;
    }
    if (self.type === "vehicle" && isinvehicle(bundle, self)) {
        return false;
    }
    if (self.type === "vehicle_corpse") {
        return false;
    }
    if (self function_da8108ae() && is_true(self.var_f19b4afd)) {
        return true;
    }
    return false;
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 2, eflags: 0x4
// Checksum 0xa4ae03a7, Offset: 0x970
// Size: 0xe0
function private function_b52a94e5(localclientnum, *bundle) {
    if (function_4e3684f2(bundle)) {
        return false;
    }
    if (self.type === "vehicle" && isinvehicle(bundle, self)) {
        return false;
    }
    if (self.type === "vehicle_corpse") {
        return false;
    }
    if (!self function_76a0624a() && !self function_da8108ae() && is_true(self.var_f19b4afd)) {
        return true;
    }
    return false;
}

