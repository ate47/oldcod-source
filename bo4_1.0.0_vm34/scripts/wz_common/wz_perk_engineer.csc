#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;

#namespace wz_perk_engineer;

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x2
// Checksum 0x86b205ee, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_perk_engineer", &__init__, undefined, undefined);
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x0
// Checksum 0x8dea3ef0, Offset: 0xe8
// Size: 0x104
function __init__() {
    renderoverridebundle::function_9f4eff5e(#"hash_f5de00feee70c13", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", &function_ca9f6f89);
    renderoverridebundle::function_9f4eff5e(#"hash_77f7418d2f2a7890", #"rob_sonar_set_enemyequip", &function_2168e010);
    renderoverridebundle::function_9f4eff5e(#"hash_61c696df3d5a1765", #"hash_44adc567f9f60d61", &function_ff4f4737);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0x916c21ec, Offset: 0x1f8
// Size: 0x3c
function private on_localplayer_spawned(localclientnum) {
    if (self function_60dbc438()) {
        self thread function_a07f756(localclientnum);
    }
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0x60bc7ea1, Offset: 0x240
// Size: 0x330
function private function_a07f756(localclientnum) {
    level endon(#"game_ended");
    self endon(#"death");
    self.var_48db13fc = [];
    while (true) {
        var_532ea33c = self hasperk(localclientnum, #"specialty_showenemyequipment");
        if (!var_532ea33c && self.var_48db13fc.size == 0) {
            wait 0.2;
            continue;
        }
        var_b16e5990 = [];
        if (var_532ea33c) {
            var_4d0ab3ca = array::filter(level.enemyequip, 0, &function_f6cd0af);
            items = arraycombine(level.allvehicles, var_4d0ab3ca, 0, 0);
            arrayremovevalue(items, undefined, 0);
            var_b16e5990 = arraysortclosest(items, self.origin, 5, 0, 7200);
        }
        foreach (item in self.var_48db13fc) {
            if (isdefined(item)) {
                item.var_ee4739a0 = undefined;
            }
        }
        foreach (item in var_b16e5990) {
            item.var_ee4739a0 = 1;
        }
        var_733e4ff3 = arraycombine(self.var_48db13fc, var_b16e5990, 0, 0);
        foreach (item in var_733e4ff3) {
            if (isdefined(item)) {
                if (isdefined(item.vehicletype)) {
                    item function_8a494f3d(localclientnum);
                } else {
                    item weaponobjects::updateenemyequipment(localclientnum, undefined);
                }
            }
            waitframe(1);
        }
        self.var_48db13fc = var_b16e5990;
        wait 0.2;
    }
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0xb706ebfb, Offset: 0x578
// Size: 0x2e
function private function_f6cd0af(item) {
    return isdefined(item) && !item function_31d3dfec();
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 1, eflags: 0x4
// Checksum 0xc4af9fe7, Offset: 0x5b0
// Size: 0xb4
function private function_8a494f3d(localclientnum) {
    self renderoverridebundle::function_15e70783(localclientnum, #"friendly", #"hash_f5de00feee70c13");
    self renderoverridebundle::function_15e70783(localclientnum, #"enemy", #"hash_77f7418d2f2a7890");
    self renderoverridebundle::function_15e70783(localclientnum, #"neutral", #"hash_61c696df3d5a1765");
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x4
// Checksum 0x6d69bf6b, Offset: 0x670
// Size: 0x6a
function private function_49f8a2ac() {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return 0;
    }
    if (self.owner.team == #"neutral") {
        return 0;
    }
    return self.owner function_55a8b32b();
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 0, eflags: 0x4
// Checksum 0x59c3c60c, Offset: 0x6e8
// Size: 0x6c
function private function_f7418f7d() {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return false;
    }
    if (self.owner.team == #"neutral") {
        return false;
    }
    return !self.owner function_55a8b32b();
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 2, eflags: 0x4
// Checksum 0x943f7fd9, Offset: 0x760
// Size: 0xaa
function private function_ca9f6f89(localclientnum, bundle) {
    if (function_d224c0e6(localclientnum)) {
        return false;
    }
    if (self.type === "vehicle" && isinvehicle(localclientnum, self)) {
        return false;
    }
    if (self function_49f8a2ac() && isdefined(self.var_ee4739a0) && self.var_ee4739a0) {
        return true;
    }
    return false;
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 2, eflags: 0x4
// Checksum 0xfeb2c433, Offset: 0x818
// Size: 0xaa
function private function_2168e010(localclientnum, bundle) {
    if (function_d224c0e6(localclientnum)) {
        return false;
    }
    if (self.type === "vehicle" && isinvehicle(localclientnum, self)) {
        return false;
    }
    if (self function_f7418f7d() && isdefined(self.var_ee4739a0) && self.var_ee4739a0) {
        return true;
    }
    return false;
}

// Namespace wz_perk_engineer/wz_perk_engineer
// Params 2, eflags: 0x4
// Checksum 0xb7a54189, Offset: 0x8d0
// Size: 0xc6
function private function_ff4f4737(localclientnum, bundle) {
    if (function_d224c0e6(localclientnum)) {
        return false;
    }
    if (self.type === "vehicle" && isinvehicle(localclientnum, self)) {
        return false;
    }
    if (!self function_49f8a2ac() && !self function_f7418f7d() && isdefined(self.var_ee4739a0) && self.var_ee4739a0) {
        return true;
    }
    return false;
}

