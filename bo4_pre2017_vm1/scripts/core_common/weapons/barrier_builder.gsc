#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/core_common/weapons/weaponobjects;

#namespace barrier_builder;

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x2
// Checksum 0xd6ac7015, Offset: 0x500
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("barrier_builder", &__init__, undefined, undefined);
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x0
// Checksum 0xafab9c5c, Offset: 0x540
// Size: 0x7c
function __init__() {
    level.var_bc312999 = getweapon("barrier_builder");
    level.var_44ead27c = [];
    function_6b6aedb5();
    function_6c733092();
    function_10960bf9();
    setupcallbacks();
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x0
// Checksum 0x2d2cb637, Offset: 0x5c8
// Size: 0x42
function function_6c733092() {
    level._effect["barrier_door_mp"] = "destruct/fx8_dest_barrier_door_mp";
    level._effect["barrier_archway_mp"] = "destruct/fx8_dest_barrier_archway_mp";
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x0
// Checksum 0x23848d28, Offset: 0x618
// Size: 0x18
function function_6b6aedb5() {
    level.var_245008d8 = "mpl_barrier_destroy";
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x0
// Checksum 0x88d93cdb, Offset: 0x638
// Size: 0x54
function setupcallbacks() {
    callback::on_spawned(&on_player_spawned);
    ability_player::register_gadget_activation_callbacks(56, &function_160f6fd7, &function_8f0067ab);
}

// Namespace barrier_builder/barrier_builder
// Params 2, eflags: 0x0
// Checksum 0x21bdc4c9, Offset: 0x698
// Size: 0x74
function function_160f6fd7(slot, weapon) {
    if (isdefined(self.var_67921732) && self.var_67921732) {
        return;
    }
    if (isdefined(self.var_7542f498)) {
        self.var_67921732 = 1;
        self thread function_23b580c0(self.var_7542f498, weapon);
    }
}

// Namespace barrier_builder/barrier_builder
// Params 2, eflags: 0x0
// Checksum 0x286a4d21, Offset: 0x718
// Size: 0x20
function function_8f0067ab(slot, weapon) {
    self.var_67921732 = 0;
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x4
// Checksum 0xa43389cd, Offset: 0x740
// Size: 0x110
function private function_10960bf9() {
    level.var_60ca1262 = getgametypesetting("deployableBarrierBuildTime");
    level.deployablebarrierdestroytime = getgametypesetting("deployableBarrierDestroyTime");
    level.deployablebarrierhealth = getgametypesetting("deployableBarrierHealth");
    level.var_6c7aed22 = getgametypesetting("deployableBarriersEnabled");
    level.var_79ca335e = getgametypesetting("deployableBarrierExplosiveMultiplier");
    level.var_195271c8 = 100;
    level.var_2c6aa788 = level.var_195271c8 / getgametypesetting("deployableBarrierRechargeTime") * 1000;
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x0
// Checksum 0xa8e807e0, Offset: 0x858
// Size: 0xc2
function setup_deployable_barriers() {
    var_44ead27c = getentarray("deployable_barrier_controller", "classname");
    if (!isdefined(var_44ead27c)) {
        return;
    }
    foreach (var_5ca6e3bd in var_44ead27c) {
        function_e3c7d20a(var_5ca6e3bd);
    }
}

// Namespace barrier_builder/barrier_builder
// Params 1, eflags: 0x4
// Checksum 0x7ce9adde, Offset: 0x928
// Size: 0x36
function private function_580bfc00(barrier) {
    self.var_7542f498 = barrier;
    self notify(#"barrier_zone_entered", {#var_a01e96a1:barrier});
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x4
// Checksum 0x89e72cf0, Offset: 0x968
// Size: 0x1a
function private function_179eb227() {
    self.var_7542f498 = undefined;
    self notify(#"barrier_zone_cleared");
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x4
// Checksum 0x4b71749d, Offset: 0x990
// Size: 0x58
function private function_7bf05942() {
    level endon(#"game_ended");
    for (;;) {
        waitresult = self.var_2d13e2b7 waittill("trigger");
        waitresult.activator function_580bfc00(self);
    }
}

// Namespace barrier_builder/barrier_builder
// Params 1, eflags: 0x0
// Checksum 0x6f31c23b, Offset: 0x9f0
// Size: 0x4fc
function function_e3c7d20a(var_c1aa1852) {
    visuals = getentarray(var_c1aa1852.targetname + "_visual", "targetname");
    var_493c850a = getent(var_c1aa1852.targetname + "_trigger", "targetname");
    var_40fe9581 = struct::get_array(var_c1aa1852.targetname + "_destruct_fx", "targetname");
    var_5ca6e3bd = spawnstruct();
    var_5ca6e3bd.var_2d13e2b7 = var_493c850a;
    var_5ca6e3bd.var_2d13e2b7.var_8e603408 = var_5ca6e3bd;
    var_5ca6e3bd.visuals = visuals;
    var_5ca6e3bd.var_b26e2e82 = 0;
    var_5ca6e3bd.var_db1958b0 = [];
    var_5ca6e3bd.var_3cf51901 = var_c1aa1852;
    var_5ca6e3bd.var_48eb942b = 0;
    var_5ca6e3bd.var_efb11ff9 = var_c1aa1852.script_objective;
    var_5ca6e3bd.var_7cdfe95 = var_c1aa1852.var_f1c9e7e4;
    var_5ca6e3bd.var_aad00433 = var_c1aa1852.var_a5e5c8ea;
    foreach (var_9a767f1e in var_40fe9581) {
        fxid = var_9a767f1e.var_aa295b1f;
        var_44a4ca0d = spawnfx(var_9a767f1e.script_fxid, var_9a767f1e.origin);
        array::add(var_5ca6e3bd.var_db1958b0, var_44a4ca0d);
    }
    foreach (visual in visuals) {
        visual hide();
        visual notsolid();
        if (isdefined(level.var_6c7aed22) && level.var_6c7aed22) {
            visual.var_1553cd63 = var_5ca6e3bd;
        }
    }
    array::add(level.var_44ead27c, var_5ca6e3bd);
    if (isdefined(level.var_6c7aed22) && level.var_6c7aed22) {
        if (isdefined(var_5ca6e3bd.var_efb11ff9) && var_5ca6e3bd.var_efb11ff9 != "") {
            var_5ca6e3bd.objectiveid = gameobjects::get_next_obj_id();
            objective_add(var_5ca6e3bd.objectiveid, "active", var_c1aa1852.origin, istring(var_5ca6e3bd.var_efb11ff9));
            objective_visibleteams(var_5ca6e3bd.objectiveid, level.spawnsystem.ispawn_teammask["all"]);
        }
        var_5ca6e3bd thread function_7bf05942();
    }
    if (isdefined(var_c1aa1852.spawnflags) && (var_c1aa1852.spawnflags & 1) == 1) {
        thread function_bcaa75f6(var_5ca6e3bd);
    }
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x0
// Checksum 0x24eddb8b, Offset: 0xef8
// Size: 0x18a
function function_bcb3593c() {
    foreach (fx in self.var_db1958b0) {
        triggerfx(fx);
    }
    foreach (visual in self.visuals) {
        visual hide();
        visual notsolid();
        visual playsound(level.var_245008d8);
    }
    self.var_48eb942b = 0;
    println("<dev string:x28>");
    self notify(#"is_destroyed");
}

// Namespace barrier_builder/barrier_builder
// Params 1, eflags: 0x4
// Checksum 0xc6ef6886, Offset: 0x1090
// Size: 0x14c
function private function_4770bc3b(var_aafe7100) {
    level endon(#"game_ended");
    var_aafe7100 endon(#"is_destroyed");
    while (var_aafe7100.health > 0) {
        waitresult = var_aafe7100 waittill("damage");
        damageapplied = waitresult.amount;
        if (weapon_utils::isexplosivedamage(waitresult.mod)) {
            damageapplied = int(waitresult.amount * level.var_79ca335e - waitresult.amount);
            var_aafe7100.health -= damageapplied;
        }
        println("<dev string:x43>" + var_aafe7100.health + "<dev string:x68>" + damageapplied);
    }
    var_aafe7100 function_bcb3593c();
}

// Namespace barrier_builder/barrier_builder
// Params 1, eflags: 0x4
// Checksum 0x9a1dc9d6, Offset: 0x11e8
// Size: 0xec
function private function_bcaa75f6(barrier) {
    foreach (visual in barrier.visuals) {
        visual.takedamage = 1;
        visual.health = level.deployablebarrierhealth;
        visual show();
        visual solid();
    }
    barrier.var_48eb942b = 1;
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x4
// Checksum 0x33ccdff3, Offset: 0x12e0
// Size: 0x1c
function private on_player_spawned() {
    self thread function_212fedea();
}

// Namespace barrier_builder/barrier_builder
// Params 2, eflags: 0x0
// Checksum 0x86d5aaf1, Offset: 0x1308
// Size: 0x110
function function_1ddfffdd(weapon, slot) {
    self endon(#"disconnect", #"death");
    lasttime = gettime();
    gadgetpower = self gadgetpowerget(slot);
    while (gadgetpower < 100) {
        waitframe(1);
        gadgetpower = self gadgetpowerget(slot);
        currenttime = gettime();
        timesincelast = currenttime - lasttime;
        lasttime = currenttime;
        newpower = timesincelast * level.var_2c6aa788;
        gadgetpower += newpower;
        self gadgetpowerset(slot, gadgetpower);
    }
}

// Namespace barrier_builder/barrier_builder
// Params 4, eflags: 0x0
// Checksum 0xf3b22cdb, Offset: 0x1420
// Size: 0x104
function function_aeb6c25(barrier, weapon, zone, slot) {
    if (barrier.var_48eb942b) {
        barrier function_bcb3593c();
    } else {
        thread function_bcaa75f6(barrier);
        slot = self gadgetgetslot(weapon);
        self ability_power::power_drain_completely(slot);
        barrier.var_48eb942b = 1;
        self thread function_1ddfffdd(weapon, slot);
    }
    self function_179eb227();
    self gadgetdeactivate(slot, weapon);
}

// Namespace barrier_builder/barrier_builder
// Params 3, eflags: 0x4
// Checksum 0xac444c76, Offset: 0x1530
// Size: 0x32c
function private function_23b580c0(barrier, weapon, zone) {
    self endon(#"disconnect", #"death");
    barrier endon(#"is_activated");
    capturetime = 0;
    starttime = gettime();
    slot = self gadgetgetslot(weapon);
    objective_setteam(barrier.objectiveid, self.team);
    objective_setprogress(barrier.objectiveid, 0);
    var_79256add = 1;
    var_6e5fa80 = barrier.var_48eb942b ? level.deployablebarrierdestroytime : level.var_60ca1262;
    while (capturetime < var_6e5fa80) {
        capturetime = (gettime() - starttime) / 1000;
        var_26c3c7c = capturetime / var_6e5fa80;
        objective_setprogress(barrier.objectiveid, math::clamp(var_26c3c7c, 0, 1));
        waitframe(1);
        if (!self istouchingswept(self.var_7542f498.var_2d13e2b7)) {
            self gadgetdeactivate(slot, weapon);
            var_79256add = 0;
            break;
        }
        var_e322c2d8 = 0;
        foreach (visual in barrier.visuals) {
            if (self util::is_looking_at(visual, 0)) {
                var_e322c2d8 = 1;
                break;
            }
        }
        if (!var_e322c2d8) {
            self gadgetdeactivate(slot, weapon);
            var_79256add = 0;
            break;
        }
        if (!self.var_67921732) {
            var_79256add = 0;
            break;
        }
    }
    objective_setprogress(barrier.objectiveid, 0);
    if (var_79256add) {
        self function_aeb6c25(barrier, weapon, zone, slot);
    }
}

// Namespace barrier_builder/barrier_builder
// Params 1, eflags: 0x4
// Checksum 0xfcbffc99, Offset: 0x1868
// Size: 0x7e
function private function_c82f3a7d(var_18b9ece0) {
    self.var_7542f498 endon(#"disconnect");
    self.var_7542f498 endon(#"death");
    self endon(#"barrier_zone_cleared");
    for (;;) {
        waitframe(1);
        if (!self istouchingswept(self.var_7542f498.var_2d13e2b7)) {
            self notify(#"barrier_zone_cleared");
        }
    }
}

// Namespace barrier_builder/barrier_builder
// Params 0, eflags: 0x4
// Checksum 0xad4815b2, Offset: 0x18f0
// Size: 0x170
function private function_212fedea() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        waitresult = self waittill("barrier_zone_entered");
        self thread function_c82f3a7d();
        if (self hasweapon(level.var_bc312999) && self getweaponammoclip(level.var_bc312999) > 0) {
            var_6f76b263 = undefined;
            if (isdefined(waitresult.var_a01e96a1.var_48eb942b)) {
                var_6f76b263 = waitresult.var_a01e96a1.var_48eb942b ? waitresult.var_a01e96a1.var_aad00433 : waitresult.var_a01e96a1.var_7cdfe95;
            }
            if (isdefined(var_6f76b263)) {
                self sethintstring(istring(var_6f76b263));
            }
        }
        waitresult = self waittill("barrier_zone_cleared");
        self sethintstring("");
    }
}

