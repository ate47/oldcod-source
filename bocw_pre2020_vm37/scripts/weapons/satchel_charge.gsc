#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0xe7b4e2cb, Offset: 0x120
// Size: 0xa4
function init_shared() {
    if (!isdefined(level.var_ac78d00e)) {
        level.var_ac78d00e = {};
    }
    weaponobjects::function_e6400478(#"satchel_charge", &function_a8a4341, 1);
    callback::on_player_killed(&onplayerkilled);
    clientfield::register("missile", "satchelChargeWarning", 1, 1, "int");
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x368889b7, Offset: 0x1d0
// Size: 0x18a
function function_a8a4341(watcher) {
    if (isdefined(watcher.weapon.customsettings)) {
        var_6f1c6122 = getscriptbundle(watcher.weapon.customsettings);
        assert(isdefined(var_6f1c6122));
        level.var_ac78d00e.var_a74161cc = var_6f1c6122;
    }
    watcher.altdetonate = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ondetonatecallback = &function_b96af076;
    watcher.onspawn = &function_af3365b5;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ownergetsassist = 1;
    watcher.detonatestationary = 1;
    watcher.detonationdelay = getdvarfloat(#"hash_6639441fa6223b36", 0);
    watcher.immunespecialty = "specialty_immunetriggerc4";
    if (function_a2f3d962()) {
        watcher.var_e7ebbd38 = &function_a39c62de;
    }
}

// Namespace satchel_charge/satchel_charge
// Params 2, eflags: 0x1 linked
// Checksum 0x4512619a, Offset: 0x368
// Size: 0x1d4
function function_af3365b5(watcher, owner) {
    self endon(#"death", #"hacked", #"detonating");
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    if (isdefined(owner)) {
        owner stats::function_e24eec31(self.weapon, #"used", 1);
        if (!isdefined(owner.var_1e593689)) {
            owner.var_1e593689 = [];
        }
        if (!isdefined(owner.var_1e593689)) {
            owner.var_1e593689 = [];
        } else if (!isarray(owner.var_1e593689)) {
            owner.var_1e593689 = array(owner.var_1e593689);
        }
        owner.var_1e593689[owner.var_1e593689.size] = self;
    }
    self.var_3f9bd15 = &onvehiclekilled;
    if (function_a2f3d962()) {
        self thread function_939d8a36(watcher);
    } else {
        /#
            self thread function_87e9f461();
        #/
        self thread function_acc500c4(watcher);
    }
    if (isdefined(self.killcament)) {
        self.killcament setweapon(self.weapon);
    }
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x95cea52c, Offset: 0x548
// Size: 0x2e
function function_a0778d59() {
    self waittilltimeout(10, #"stationary", #"death");
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x2715fa25, Offset: 0x580
// Size: 0x24
function function_a2f3d962() {
    return level.var_ac78d00e.var_a74161cc.var_c66e4eb1 === 1;
}

// Namespace satchel_charge/satchel_charge
// Params 3, eflags: 0x1 linked
// Checksum 0x2b5323b3, Offset: 0x5b0
// Size: 0x94
function function_b96af076(attacker, weapon, target) {
    if (isdefined(self.owner.var_1e593689)) {
        arrayremovevalue(self.owner.var_1e593689, self);
        if (self.owner.var_1e593689.size <= 0) {
            self.owner.var_1e593689 = undefined;
        }
    }
    weaponobjects::proximitydetonate(attacker, weapon, target);
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x5f9ff7ad, Offset: 0x650
// Size: 0x134
function function_939d8a36(*watcher) {
    self endon(#"death", #"detonating");
    if (level.var_ac78d00e.var_a74161cc.var_3a06462 !== 1) {
        util::waittillnotmoving();
    }
    var_c4725fe8 = isdefined(level.var_ac78d00e.var_a74161cc.var_342ad32c) ? level.var_ac78d00e.var_a74161cc.var_342ad32c : 0;
    if (var_c4725fe8 > 0) {
        self playsound(isdefined(level.var_ac78d00e.var_a74161cc.var_f1c52016) ? level.var_ac78d00e.var_a74161cc.var_f1c52016 : "");
        wait var_c4725fe8;
    }
    flag::set("satchelIsArmed");
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x62898557, Offset: 0x790
// Size: 0xe8
function function_a0a96965() {
    if (isdefined(self.var_1e593689) && isdefined(level.var_ac78d00e.var_a74161cc.var_90724e7f)) {
        arrayremovevalue(self.var_1e593689, undefined);
        foreach (var_77a228b3 in self.var_1e593689) {
            var_77a228b3 playsound(level.var_ac78d00e.var_a74161cc.var_90724e7f);
        }
    }
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x9fa26971, Offset: 0x880
// Size: 0x284
function function_acc500c4(watcher) {
    self endon(#"death", #"hacked", #"detonating");
    if (isdefined(watcher.weapon.customsettings)) {
        function_a0778d59();
        if (isdefined(level.var_ac78d00e.var_a74161cc.var_28f86309)) {
            self playloopsound(level.var_ac78d00e.var_a74161cc.var_28f86309);
        }
        var_1911997c = level.var_ac78d00e.var_a74161cc.var_e26881f;
        if (isdefined(var_1911997c)) {
            var_5d0f385a = isdefined(level.var_ac78d00e.var_a74161cc.var_c932e2b0) ? level.var_ac78d00e.var_a74161cc.var_c932e2b0 : 0;
            assert(var_5d0f385a <= self.weapon.fusetime);
            var_d3839360 = float(self.weapon.fusetime) / 1000 - var_5d0f385a;
            wait var_d3839360;
            if (isdefined(level.var_ac78d00e.var_a74161cc.var_28f86309)) {
                self stoploopsound(0.1);
            }
            self clientfield::set("satchelChargeWarning", 1);
            self playsound(var_1911997c);
            return;
        }
        wait float(self.weapon.fusetime) / 1000;
        if (isdefined(level.var_ac78d00e.var_a74161cc.var_28f86309)) {
            self stoploopsound(0.1);
        }
    }
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0xdd43b548, Offset: 0xb10
// Size: 0xb4
function function_6db0705() {
    for (;;) {
        if (isdefined(self.var_1e593689)) {
            foreach (var_77a228b3 in self.var_1e593689) {
                if (var_77a228b3 flag::get("satchelIsArmed")) {
                    return true;
                }
            }
        } else {
            return false;
        }
        waitframe(1);
    }
    return false;
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x61335cf0, Offset: 0xbd0
// Size: 0xd2
function function_51108722() {
    for (;;) {
        if (isdefined(self.var_1e593689)) {
            var_263fb98 = 1;
            foreach (var_77a228b3 in self.var_1e593689) {
                if (!var_77a228b3 flag::get("satchelIsArmed")) {
                    var_263fb98 = 0;
                }
            }
            if (var_263fb98) {
                return true;
            }
        } else {
            return false;
        }
        waitframe(1);
    }
    return false;
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0xedead429, Offset: 0xcb0
// Size: 0xb8
function function_542663a0() {
    var_5d175791 = getweapon(#"satchel_charge");
    var_e8b7635c = self getcurrentoffhand();
    if (var_e8b7635c !== var_5d175791) {
        self switchtooffhand(var_5d175791);
    }
    waitframe(1);
    function_a0a96965();
    if (!self playgestureviewmodel(#"ges_t9_satchel_charge_clacker_fire_oneoff", undefined, 1)) {
        return;
    }
    wait 0.5;
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x558cda33, Offset: 0xd70
// Size: 0x3c
function function_adee7bee() {
    if (level.var_ac78d00e.var_a74161cc.var_7ab8e1cb === 1) {
        function_542663a0();
    }
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x49daa58f, Offset: 0xdb8
// Size: 0x24e
function function_521f546a(watcher) {
    self endon(#"death");
    if (self.var_bf73db8c === 1 || self inlaststand() || self function_55acff10(1)) {
        return;
    }
    self.var_bf73db8c = 1;
    if (isdefined(self.var_1e593689)) {
        arrayremovevalue(self.var_1e593689, undefined);
        if (self.var_1e593689.size > 0) {
            var_4ca85007 = level.var_ac78d00e.var_a74161cc.var_f258f7d4 === 1 ? &function_51108722 : &function_6db0705;
            if (!self [[ var_4ca85007 ]]()) {
                function_adee7bee();
                self.var_bf73db8c = undefined;
                return;
            }
            function_542663a0();
            if (isdefined(self.var_1e593689)) {
                foreach (var_77a228b3 in self.var_1e593689) {
                    if (var_77a228b3 flag::get("satchelIsArmed") && self.isjammed === 0) {
                        watcher thread weaponobjects::waitanddetonate(var_77a228b3, 0, self, var_77a228b3.weapon);
                    }
                }
            }
        } else {
            self.var_1e593689 = undefined;
            function_adee7bee();
        }
    } else {
        function_adee7bee();
    }
    self.var_bf73db8c = undefined;
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0xbd061d91, Offset: 0x1010
// Size: 0x13c
function function_a39c62de(watcher) {
    self endon(#"death");
    weapon = getweapon(#"satchel_charge");
    if (isdefined(weapon) && self hasweapon(weapon) || isdefined(self.var_1e593689) && self.var_1e593689.size > 0) {
        if (!isdefined(self.var_1e593689) && self getammocount(weapon) == 0) {
            self playsoundtoplayer("uin_default_action_denied", self);
            itemindex = getitemindexfromref(weapon.name);
            self luinotifyevent(#"hash_74dc06b4b4fb436c", 1, itemindex);
        }
        function_521f546a(watcher);
    }
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0xd1abc876, Offset: 0x1158
// Size: 0x18c
function onplayerkilled(params) {
    weapon = params.weapon;
    eattacker = params.eattacker;
    einflictor = params.einflictor;
    self.var_1e593689 = undefined;
    self.var_bf73db8c = undefined;
    if (weapon.name == #"satchel_charge" && eattacker util::isenemyplayer(self) && self isinvehicle()) {
        if (!isdefined(einflictor.var_3c0a7eef)) {
            einflictor.var_3c0a7eef = [];
        }
        var_71f7928d = spawnstruct();
        var_71f7928d.player = self;
        var_71f7928d.vehicle = self getvehicleoccupied();
        var_71f7928d.var_33c9fbd5 = gettime();
        if (!isdefined(einflictor.var_3c0a7eef)) {
            einflictor.var_3c0a7eef = [];
        } else if (!isarray(einflictor.var_3c0a7eef)) {
            einflictor.var_3c0a7eef = array(einflictor.var_3c0a7eef);
        }
        einflictor.var_3c0a7eef[einflictor.var_3c0a7eef.size] = var_71f7928d;
    }
}

// Namespace satchel_charge/satchel_charge
// Params 9, eflags: 0x1 linked
// Checksum 0x94f452c3, Offset: 0x12f0
// Size: 0x1d4
function onvehiclekilled(einflictor, eattacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, occupants) {
    if (isdefined(occupants.size) && occupants.size > 0) {
        foreach (occupant in occupants) {
            if (psoffsettime util::isenemyplayer(occupant)) {
                shitloc function_af9b1762(psoffsettime);
                break;
            }
        }
        return;
    }
    if (isdefined(shitloc.var_3c0a7eef)) {
        foreach (var_71f7928d in shitloc.var_3c0a7eef) {
            if (self == var_71f7928d.vehicle && var_71f7928d.var_33c9fbd5 == gettime()) {
                shitloc function_af9b1762(psoffsettime);
                break;
            }
        }
    }
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x96d4dd68, Offset: 0x14d0
// Size: 0x6c
function function_af9b1762(eattacker) {
    scoreevents = globallogic_score::function_3cbc4c6c(self.weapon.var_2e4a8800);
    if (isdefined(scoreevents.var_f8792376)) {
        scoreevents::processscoreevent(scoreevents.var_f8792376, eattacker, undefined, self.weapon, undefined);
    }
}

// Namespace satchel_charge/event_36cd4a90
// Params 1, eflags: 0x40
// Checksum 0xce3821e2, Offset: 0x1548
// Size: 0x124
function event_handler[event_36cd4a90] function_7391455(eventstruct) {
    if (function_a2f3d962()) {
        player = eventstruct.player;
        if (eventstruct.slot == 0) {
            weapon = getweapon(#"satchel_charge");
            if (isdefined(weapon) && player hasweapon(weapon)) {
                var_383b646d = player getammocount(weapon);
                if (var_383b646d <= 0) {
                    watcher = player weaponobjects::getweaponobjectwatcherbyweapon(weapon);
                    if (isdefined(watcher)) {
                        player function_abe8608d(weapon, 1);
                        player thread function_521f546a(watcher);
                    }
                }
            }
        }
    }
}

/#

    // Namespace satchel_charge/satchel_charge
    // Params 1, eflags: 0x0
    // Checksum 0x664be074, Offset: 0x1678
    // Size: 0x74
    function function_335a9072(text) {
        if (level.weaponobjectdebug == 1) {
            entitynumber = self getentitynumber();
            println("<dev string:x38>" + entitynumber + "<dev string:x4b>" + text);
        }
    }

    // Namespace satchel_charge/satchel_charge
    // Params 0, eflags: 0x0
    // Checksum 0x5b03f12c, Offset: 0x16f8
    // Size: 0xb6
    function function_87e9f461() {
        self endon(#"death", #"hacked", #"detonating");
        function_a0778d59();
        starttime = gettime();
        while (true) {
            function_335a9072("<dev string:x51>" + float(self.weapon.fusetime - gettime() - starttime) / 1000);
            waitframe(1);
        }
    }

#/
