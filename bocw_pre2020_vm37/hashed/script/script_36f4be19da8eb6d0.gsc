#using script_24c32478acf44108;
#using script_556e19065f09f8a2;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_weapons;

#namespace namespace_b376a999;

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x6
// Checksum 0x2004dde5, Offset: 0x290
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_36cdf1547e49b57a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x5 linked
// Checksum 0xebbbfa02, Offset: 0x2d8
// Size: 0x858
function private function_70a657d8() {
    callback::on_connect(&on_player_connect);
    callback::on_ai_damage(&function_33fb41f6);
    callback::on_ai_killed(&function_d72b9d03);
    level.var_652bc5ed = getweapon(#"ww_ieu_shockwave_t9");
    weaponobjects::function_e6400478(#"ww_ieu_shockwave_t9", &function_d48a01a5, 1);
    level.var_810eda2b = getweapon(#"ww_ieu_acid_t9");
    level.var_fb37bf51 = getweapon(#"ww_ieu_gas_t9");
    weaponobjects::function_e6400478(#"ww_ieu_gas_t9", &function_47c38bc8, 1);
    zombie_utility::add_zombie_gib_weapon_callback(#"ww_ieu_gas_t9", &function_7a7d85a4, &function_7a7d85a4);
    callback::add_weapon_fired(level.var_fb37bf51, &function_c8adf16f);
    level.var_12b450dc = getweapon(#"ww_ieu_plasma_t9");
    weaponobjects::function_e6400478(#"ww_ieu_plasma_t9", &function_3c39516d, 1);
    zm::function_84d343d(level.var_12b450dc.name, &function_fd195372);
    clientfield::register("missile", "" + #"hash_68195637521e3973", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_492f4817c4296ddf", 1, 1, "counter");
    clientfield::register("allplayers", "" + #"hash_392d4dd36fe37ce7", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"hash_7e9eb1c31cf618f0", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_40635c43f5d87929", 1, 3, "int");
    clientfield::register("actor", "" + #"hash_306339376ad218f0", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_2d55cfbf02091dd1", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_7c865b5dcfbe46c0", 1, 1, "int");
    clientfield::register("missile", "" + #"hash_685e6cfaf658518e", 1, 1, "int");
    level.var_e0be56c0 = getweapon(#"ww_ieu_electric_t9");
    function_efcce3c1();
    zm::function_84d343d(level.var_e0be56c0.name, &function_ce364583);
    zm::function_84d343d(#"hash_d621816f9c357a5", &function_60e38f77);
    callback::add_weapon_fired(level.var_e0be56c0, &function_635ff818);
    namespace_9ff9f642::register_slowdown(#"hash_659e542bc102c218", 0.95, 0.25);
    namespace_9ff9f642::register_slowdown(#"hash_e5fddce96190022", 1, 1);
    namespace_9ff9f642::register_slowdown(#"hash_37ca44613f9ed8bc", 1, 0);
    namespace_9ff9f642::register_slowdown(#"hash_1262748e23d5dff8", 0.75, 2);
    namespace_9ff9f642::register_slowdown(#"hash_a40f7d48ac714db", 0.75, 2);
    namespace_9ff9f642::register_slowdown(#"hash_40ca16d063cdb34f", 0.8, 3);
    clientfield::register("actor", "" + #"hash_6dca42b5563953ef", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_2a7b72235f0b387e", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_1709a7bbfac5e1e0", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_3a35110e6ccc5486", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_48257c0dba76b140", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_97d03a2a0786ba6", 1, 2, "int");
    clientfield::register("allplayers", "" + #"hash_3c92af57fde1f8f7", 1, 4, "int");
    level.var_58e6238 = &function_caac60f2;
    level.var_f975b6ae = &function_301812b0;
    level.var_9ea358cc = 0;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x5 linked
// Checksum 0x7dd396f7, Offset: 0xb38
// Size: 0x2c
function private function_1475944a() {
    level.var_9ea358cc++;
    self waittill(#"death");
    level.var_9ea358cc--;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x5 linked
// Checksum 0xaeb2a815, Offset: 0xb70
// Size: 0x34
function private on_player_connect() {
    self thread watch_weapon_changes();
    self thread function_18fbdeee();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x7c006019, Offset: 0xbb0
// Size: 0x140
function function_18fbdeee() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hash_3abc816f9601bdd3");
        weapon = waitresult.weapon;
        if (!function_5fef4201(weapon)) {
            continue;
        }
        println("<dev string:x38>");
        var_4745348a = self getweaponammoclipsize(weapon);
        var_379c9ca1 = self getweaponammoclip(weapon);
        if (var_379c9ca1 < var_4745348a) {
            self function_a0a2d8ee(1);
            self thread function_f0c18475(weapon);
            self thread function_427f113c(weapon);
            continue;
        }
        iprintlnbold("Vacuum Container Full");
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x4d758dfe, Offset: 0xcf8
// Size: 0x14a
function watch_weapon_changes() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"weapon_change");
        weapon = waitresult.weapon;
        if (function_5fef4201(weapon)) {
            if (function_f1c015e1(weapon)) {
                if (!isdefined(self.var_343d2604)) {
                    self.var_343d2604 = 0;
                }
            }
            function_96db9f3(weapon, 0);
        } else {
            self allowads(1);
        }
        if (function_c988c217(weapon)) {
            self.var_3f74bd46 = 0;
            self.var_c627b034 = 1;
        }
        if (function_f1c015e1(waitresult.last_weapon)) {
            self function_53e5275c(9);
            self.var_343d2604 = 0;
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xf953eda9, Offset: 0xe50
// Size: 0xe
function function_7a7d85a4(*damage_percent) {
    return false;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x2b0b7fed, Offset: 0xe68
// Size: 0xa4
function function_5fef4201(weapon) {
    if (isdefined(weapon)) {
        w_root = zm_weapons::function_386dacbc(weapon);
        switch (w_root.name) {
        case #"ww_ieu_shockwave_t9":
        case #"ww_ieu_electric_t9":
        case #"ww_ieu_acid_t9":
        case #"ww_ieu_gas_t9":
        case #"ww_ieu_plasma_t9":
            return true;
        }
    }
    return false;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x93128cf, Offset: 0xf18
// Size: 0x108
function function_a93a6096(player) {
    var_57b1ae9e = player getweaponslist();
    foreach (var_681004f8 in var_57b1ae9e) {
        switch (var_681004f8.name) {
        case #"ww_ieu_shockwave_t9":
        case #"ww_ieu_electric_t9":
        case #"ww_ieu_acid_t9":
        case #"ww_ieu_gas_t9":
        case #"ww_ieu_plasma_t9":
            return true;
        }
    }
    return false;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xb33cfa78, Offset: 0x1028
// Size: 0x36
function function_7c292369(weapon) {
    return isdefined(weapon) && zm_weapons::function_386dacbc(weapon) == level.var_652bc5ed;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x840a5365, Offset: 0x1068
// Size: 0x36
function function_c988c217(weapon) {
    return isdefined(weapon) && zm_weapons::function_386dacbc(weapon) == level.var_e0be56c0;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xacf5c040, Offset: 0x10a8
// Size: 0x36
function function_f1c015e1(weapon) {
    return isdefined(weapon) && zm_weapons::function_386dacbc(weapon) == level.var_fb37bf51;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x621d66b6, Offset: 0x10e8
// Size: 0x36
function function_8fbb3409(weapon) {
    return isdefined(weapon) && zm_weapons::function_386dacbc(weapon) == level.var_810eda2b;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xc0c4ddbc, Offset: 0x1128
// Size: 0x36
function function_f17bb85a(weapon) {
    return isdefined(weapon) && zm_weapons::function_386dacbc(weapon) == level.var_12b450dc;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x37d032fc, Offset: 0x1168
// Size: 0x46
function function_760c0d2d(weapon, means_of_death) {
    return function_5fef4201(weapon) && isdefined(means_of_death) && means_of_death == "MOD_DOT";
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0xbc1bc57d, Offset: 0x11b8
// Size: 0x11a
function function_51986fd2(weapon, means_of_death) {
    if (means_of_death == "MOD_DOT") {
        return #"hash_659e542bc102c218";
    }
    w_root = zm_weapons::function_386dacbc(weapon);
    switch (w_root.name) {
    case #"ww_ieu_shockwave_t9":
        return #"hash_e5fddce96190022";
    case #"ww_ieu_acid_t9":
        return #"hash_40ca16d063cdb34f";
    case #"ww_ieu_electric_t9":
        return #"hash_1262748e23d5dff8";
    case #"ww_ieu_gas_t9":
        return #"hash_37ca44613f9ed8bc";
    case #"ww_ieu_plasma_t9":
        return #"hash_a40f7d48ac714db";
    }
    return #"";
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x6f0a12f3, Offset: 0x12e0
// Size: 0xdc
function function_3f1cb8ec(weapon, means_of_death) {
    if (means_of_death == "MOD_DOT") {
        return 0.25;
    }
    w_root = zm_weapons::function_386dacbc(weapon);
    switch (w_root.name) {
    case #"ww_ieu_shockwave_t9":
        return 1;
    case #"ww_ieu_acid_t9":
        return 3;
    case #"ww_ieu_electric_t9":
        return 2;
    case #"ww_ieu_gas_t9":
        return 0;
    case #"ww_ieu_plasma_t9":
        return 2;
    }
    return 0;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xc9657059, Offset: 0x13c8
// Size: 0x1ec
function function_33fb41f6(params) {
    player = params.eattacker;
    if (!isplayer(player) || params.idamage == 0) {
        return;
    }
    if (!isalive(self)) {
        return;
    }
    if (function_5fef4201(params.weapon)) {
        function_4adc16f(params);
        if (function_760c0d2d(params.weapon, params.smeansofdeath)) {
            var_62afb28a = tablelookup(#"hash_754223d87d824caf", 0, self.archetype, 1);
            var_37beadfa = var_62afb28a == "" ? 0 : int(var_62afb28a);
            player function_96db9f3(params.weapon, var_37beadfa);
            return;
        }
        if (function_8fbb3409(params.weapon) && params.idamage >= self.health) {
            self thread function_fb58c072(params);
            return;
        }
        if (function_f1c015e1(params.weapon) && params.idamage >= self.health) {
            self thread function_c9ccbd54();
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x45e134ab, Offset: 0x15c0
// Size: 0xc4
function function_4adc16f(params) {
    var_bdbde2d2 = function_51986fd2(params.weapon, params.smeansofdeath);
    var_11c67a51 = function_3f1cb8ec(params.weapon, params.smeansofdeath);
    if (var_bdbde2d2 == #"" || var_11c67a51 == 0) {
        return;
    }
    self thread namespace_9ff9f642::slowdown(var_bdbde2d2);
    if (isdefined(self.var_b077b73d)) {
        self thread [[ self.var_b077b73d ]](var_11c67a51);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x81df9b47, Offset: 0x1690
// Size: 0x14c
function function_d72b9d03(params) {
    if (function_7c292369(params.weapon)) {
        self function_f2262f33(params);
    }
    if (function_760c0d2d(params.weapon, params.smeansofdeath)) {
        player = params.eattacker;
        if (!isplayer(player) || !isalive(player)) {
            return;
        }
        self thread function_7e071045(player);
        var_62afb28a = tablelookup(#"hash_754223d87d824caf", 0, self.archetype, 2);
        var_37beadfa = var_62afb28a == "" ? 0 : int(var_62afb28a);
        player function_96db9f3(params.weapon, var_37beadfa);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x75093772, Offset: 0x17e8
// Size: 0x366
function function_13da7675() {
    targets = [];
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    a_targets = getentitiesinradius(view_pos, 400, 15);
    if (!isdefined(a_targets)) {
        return;
    }
    a_targets = arraysortclosest(a_targets, view_pos);
    end_pos = view_pos + vectorscale(forward_view_angles, 400);
    /#
        if (2 == getdvarint(#"hash_528e35e5faa6eb75", 0)) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            sphericalcone(view_pos, view_pos + forward_view_angles * 400, 30, 20, (1, 0, 0), 0.5, 0, 100);
        }
    #/
    foreach (ai in a_targets) {
        target = spawnstruct();
        if (!isdefined(ai) || ai getteam() !== level.zombie_team || !isalive(ai)) {
            continue;
        }
        test_origin = ai getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        var_a931ea0a = 160000;
        if (test_range_squared > var_a931ea0a) {
            ai function_b68ec182("range", (1, 0, 0));
            break;
        }
        if (function_bd61e5e5(ai, view_pos, forward_view_angles)) {
            target.ai = ai;
            target.distance = distance2d(view_pos, test_origin);
            if (!isdefined(targets)) {
                targets = [];
            } else if (!isarray(targets)) {
                targets = array(targets);
            }
            targets[targets.size] = target;
        }
        if (targets.size >= 1) {
            break;
        }
    }
    return targets;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x1b18195d, Offset: 0x1b58
// Size: 0x3b4
function function_427f113c(weapon) {
    self notify(#"hash_3271846e2b85db1c");
    self endon(#"death", #"hash_3271846e2b85db1c");
    while (self throwbuttonpressed()) {
        view_pos = self getweaponmuzzlepoint();
        forward_view_angles = self getweaponforwarddir();
        var_6a77cda0 = getentarray("trigger_damage", "classname");
        arrayremovevalue(var_6a77cda0, undefined);
        if (!var_6a77cda0.size) {
            return;
        }
        var_6a77cda0 = arraysortclosest(var_6a77cda0, view_pos, undefined, undefined, 400);
        var_df3c0672 = [];
        foreach (trigger in var_6a77cda0) {
            if (function_bd61e5e5(trigger, view_pos, forward_view_angles)) {
                var_1c3abda3 = distance2d(trigger.origin, view_pos);
                trigger notify(#"damage", {#attacker:self, #weapon:weapon, #amount:function_a712364b(var_1c3abda3), #var_98e101b0:1});
                if (isdefined(trigger.var_22cea3da)) {
                    if (!isdefined(var_df3c0672)) {
                        var_df3c0672 = [];
                    } else if (!isarray(var_df3c0672)) {
                        var_df3c0672 = array(var_df3c0672);
                    }
                    if (!isinarray(var_df3c0672, trigger)) {
                        var_df3c0672[var_df3c0672.size] = trigger;
                    }
                }
            }
        }
        foreach (trigger in var_df3c0672) {
            println("<dev string:x58>" + trigger getentitynumber());
            if (!isdefined(trigger.var_42859232)) {
                trigger.var_42859232 = [];
            }
            if (!isdefined(trigger.var_42859232[self getentitynumber()])) {
                trigger.var_42859232[self getentitynumber()] = gettime();
                self thread function_c8f96d23(trigger);
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xb15539b3, Offset: 0x1f18
// Size: 0x21c
function function_c8f96d23(trigger) {
    self endon(#"death");
    trigger endon(#"death");
    if (isdefined(trigger.var_37d2c8f6)) {
        trigger [[ trigger.var_37d2c8f6 ]](self, trigger.var_42859232[self getentitynumber()]);
    }
    while (true) {
        view_pos = self getweaponmuzzlepoint();
        forward_view_angles = self getweaponforwarddir();
        if (!isdefined(trigger) || !isdefined(trigger.var_22cea3da)) {
            break;
        }
        if (!function_bd61e5e5(trigger, view_pos, forward_view_angles) || !self throwbuttonpressed() || !function_5fef4201(self getcurrentweapon())) {
            break;
        }
        println(gettime() - trigger.var_42859232[self getentitynumber()] + "<dev string:x74>" + trigger getentitynumber());
        trigger [[ trigger.var_22cea3da ]](self, gettime() - trigger.var_42859232[self getentitynumber()]);
        waitframe(1);
    }
    if (isdefined(trigger.var_4ffc53f)) {
        trigger [[ trigger.var_4ffc53f ]](self);
    }
    trigger.var_42859232[self getentitynumber()] = undefined;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 3, eflags: 0x1 linked
// Checksum 0x87fb16e1, Offset: 0x2140
// Size: 0x10c
function function_bd61e5e5(target, view_pos, forward_view_angles) {
    test_origin = target getcentroid();
    normal = vectornormalize(test_origin - view_pos);
    dot = vectordot(forward_view_angles, normal);
    if (0 > dot) {
        target function_b68ec182("dot", (1, 0, 0));
        return false;
    }
    if (0 == target damageconetrace(view_pos, self, forward_view_angles, 30)) {
        target function_b68ec182("cone", (1, 0, 0));
        return false;
    }
    return true;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xe8b670a9, Offset: 0x2258
// Size: 0x58
function function_a712364b(distance) {
    if (distance > 200) {
        return (50 + 100 * (400 - distance) / 200);
    }
    return 150 + 350 * (200 - distance) / 200;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x2cdae568, Offset: 0x22b8
// Size: 0x23c
function function_f0c18475(weapon) {
    self notify(#"hash_30694ebb96507aa4");
    self endon(#"death", #"hash_30694ebb96507aa4");
    self function_42402593(1);
    while (self throwbuttonpressed() && function_5fef4201(self getcurrentweapon())) {
        targets = self function_13da7675();
        count = 0;
        foreach (target in targets) {
            if (isalive(target.ai)) {
                target.ai dodamage(int(function_a712364b(target.distance)), target.ai.origin, self, undefined, "none", "MOD_DOT", 0, weapon);
                count += 1;
            }
        }
        self function_42402593(math::clamp(1 + count, 1, 7));
        wait 0.35;
    }
    self function_a0a2d8ee(0);
    self function_42402593(0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x9518eb77, Offset: 0x2500
// Size: 0x15c
function function_7e071045(player) {
    self.freezegun_death = 1;
    self.skip_death_notetracks = 1;
    self.nodeathragdoll = 1;
    self.var_49fdad6a = 1;
    self clientfield::set("" + #"hash_2d55cfbf02091dd1", 1);
    waittime = 0.5;
    self clientfield::set("" + #"hash_306339376ad218f0", 1);
    while (waittime > 0 && isdefined(self)) {
        if (!mayspawnentity()) {
            break;
        }
        self thread function_6dbf1bb3(player);
        waittime -= 0.1;
        wait 0.1;
    }
    player clientfield::increment("" + #"hash_392d4dd36fe37ce7");
    self thread util::delayed_delete(1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x5 linked
// Checksum 0x8c75330c, Offset: 0x2668
// Size: 0x55c
function private function_6dbf1bb3(player) {
    var_c848a436 = array("j_elbow_le", "j_elbow_ri", "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_hip_le", "j_hip_ri", "j_head", "j_knee_le", "j_knee_ri");
    if (self.archetype == #"zombie_dog") {
        var_c848a436 = array("j_spine2", "j_spine3", "j_spine4", "j_neck", "j_head");
    }
    tag = array::random(var_c848a436);
    tag_pos = self gettagorigin(tag);
    if (!isdefined(tag_pos)) {
        assert(0, "<dev string:x81>" + self.archetype + "<dev string:x8f>" + tag);
        return;
    }
    target_pos = player gettagorigin("tag_flash");
    var_d5985d56 = vectornormalize(target_pos - tag_pos);
    var_d58aca35 = spawn("script_model", tag_pos + var_d5985d56 * 10);
    var_d58aca35 setmodel(#"tag_origin");
    var_d58aca35.angles = vectortoangles(var_d5985d56);
    var_d58aca35 clientfield::set("" + #"hash_7e9eb1c31cf618f0", 1);
    for (wait_time = 0.05; wait_time > 0 && isdefined(self) && isdefined(player); wait_time -= 0.1) {
        tag_pos = self gettagorigin(tag);
        target_pos = player gettagorigin("tag_flash");
        var_d5985d56 = vectornormalize(target_pos - tag_pos);
        var_d58aca35.angles = vectortoangles(var_d5985d56);
        var_d58aca35.origin = tag_pos + var_d5985d56 * 10;
        wait 0.1;
    }
    if (!isdefined(player)) {
        var_d58aca35 delete();
        return;
    }
    if (isdefined(self)) {
        tag_pos = self gettagorigin(tag);
    }
    target_pos = player gettagorigin("tag_flash");
    var_d5985d56 = vectornormalize(target_pos - tag_pos);
    var_d58aca35.angles = vectortoangles(var_d5985d56);
    distance = distance(var_d58aca35.origin, target_pos);
    for (speed = 50; distance > 70; speed += 2) {
        target_pos = player gettagorigin("tag_flash") + (0, 0, 20) + player getweaponforwarddir() * 70;
        var_d5985d56 = vectornormalize(target_pos - var_d58aca35.origin);
        var_d58aca35.angles = vectortoangles(var_d5985d56);
        var_d58aca35 moveto(var_d58aca35.origin + var_d5985d56 * speed, float(function_60d95f53()) / 1000);
        waitframe(1);
        if (!isdefined(player)) {
            break;
        }
        distance = distance(var_d58aca35.origin, target_pos);
    }
    var_d58aca35 clientfield::set("" + #"hash_7e9eb1c31cf618f0", 0);
    waitframe(1);
    var_d58aca35 delete();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x1dd7e3c1, Offset: 0x2bd0
// Size: 0x1a0
function function_96db9f3(weapon, delta) {
    var_ac1c1bdc = self getweaponammoclip(weapon) + delta;
    var_4745348a = self getweaponammoclipsize(weapon);
    if (var_ac1c1bdc < 0) {
        var_ac1c1bdc = 0;
    } else if (var_ac1c1bdc > var_4745348a) {
        var_ac1c1bdc = var_4745348a;
    }
    if (var_ac1c1bdc < var_4745348a) {
        self allowads(1);
    } else {
        self allowads(0);
        self notify(#"hash_30694ebb96507aa4");
        self notify(#"hash_3271846e2b85db1c");
        self function_a0a2d8ee(0);
        self function_42402593(0);
    }
    self setweaponammoclip(weapon, var_ac1c1bdc);
    if (function_f1c015e1(weapon)) {
        var_f6cb1ce6 = int(var_ac1c1bdc / var_4745348a * 8);
        if (self.var_343d2604 !== var_f6cb1ce6) {
            self.var_343d2604 = var_f6cb1ce6;
            self function_53e5275c(var_f6cb1ce6);
        }
    }
    return var_ac1c1bdc;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xa8204c25, Offset: 0x2d78
// Size: 0x74
function function_a0a2d8ee(turnon) {
    if (turnon) {
        self clientfield::set("" + #"hash_7c865b5dcfbe46c0", 1);
        return;
    }
    self clientfield::set("" + #"hash_7c865b5dcfbe46c0", 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x995e2c82, Offset: 0x2df8
// Size: 0x34
function function_42402593(value) {
    self clientfield::set("" + #"hash_40635c43f5d87929", value);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x5b0368de, Offset: 0x2e38
// Size: 0x22
function function_d48a01a5(watcher) {
    watcher.onspawn = &function_cdb97cd1;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0xa719d0f8, Offset: 0x2e68
// Size: 0x74
function function_cdb97cd1(*watcher, player) {
    self clientfield::set("" + #"hash_685e6cfaf658518e", 1);
    self thread function_8811e4ff(player);
    self thread function_b065c62d();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x808b6c8c, Offset: 0x2ee8
// Size: 0x44
function function_b065c62d() {
    self waittill(#"death");
    self clientfield::set("" + #"hash_685e6cfaf658518e", 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xb40b49ae, Offset: 0x2f38
// Size: 0x2e6
function function_8811e4ff(owner) {
    self endon(#"death");
    ai_damaged = [];
    while (true) {
        a_targets = getentitiesinradius(self.origin, 100, 15);
        foreach (ai in a_targets) {
            if (!isalive(ai) || ai getteam() !== level.zombie_team || isinarray(ai_damaged, ai)) {
                continue;
            }
            ai dodamage(10000, self.origin, owner, undefined, undefined, "MOD_PROJECTILE", 0, level.var_652bc5ed);
            if (!isdefined(ai_damaged)) {
                ai_damaged = [];
            } else if (!isarray(ai_damaged)) {
                ai_damaged = array(ai_damaged);
            }
            ai_damaged[ai_damaged.size] = ai;
        }
        var_6a77cda0 = getentarray("trigger_damage", "classname");
        arrayremovevalue(var_6a77cda0, undefined);
        var_6a77cda0 = arraysortclosest(var_6a77cda0, self.origin, undefined, undefined, 100);
        foreach (trigger in var_6a77cda0) {
            if (self istouching(trigger)) {
                trigger notify(#"damage", {#attacker:owner, #weapon:level.var_652bc5ed});
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x4d253ccc, Offset: 0x3228
// Size: 0x144
function function_f2262f33(params) {
    if (params.smeansofdeath !== "MOD_PROJECTILE") {
        return 0;
    }
    if (!isactor(self)) {
        return 0;
    }
    if (level.var_9ea358cc >= 8) {
        return 0;
    }
    if (self.health <= params.idamage) {
        v_z_offset = (0, 0, randomfloatrange(0.6, 1)) * randomintrange(150, 300);
        v_launch = vectornormalize(params.vdir) * randomintrange(100, 175) + v_z_offset;
        self startragdoll(1);
        self launchragdoll(v_launch);
        self thread function_1475944a();
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x5a17c770, Offset: 0x3378
// Size: 0x1c
function function_21b7e322() {
    self zombie_eye_glow::function_95cae3e3();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xf514fe5, Offset: 0x33a0
// Size: 0x6e
function function_fb58c072(params) {
    if (self.archetype === #"zombie_dog") {
        self function_21b7e322();
        return;
    }
    self.freezegun_death = 1;
    self.skip_death_notetracks = 1;
    self.nodeathragdoll = 1;
    self.var_39184114 = params;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xae018220, Offset: 0x3418
// Size: 0x224
function function_caac60f2() {
    if (is_true(self.var_49fdad6a)) {
        return;
    }
    if (!(getdvarint(#"splitscreen_playercount", 1) > 2)) {
        self thread function_4942e7b9();
        self thread function_f94aa073();
    }
    self thread function_57e0c5e();
    shatter_trigger = spawn("trigger_damage", self.origin, 0, 15, 72);
    shatter_trigger.var_af6e27ba = 0;
    shatter_trigger enablelinkto();
    shatter_trigger linkto(self);
    shatter_trigger thread function_e31780b1();
    spawnflags = 512 | 1 | 512 | 2 | 512 | 4 | 16;
    crumple_trigger = spawn("trigger_radius", self.origin, spawnflags, 15, 72);
    crumple_trigger enablelinkto();
    crumple_trigger linkto(self);
    crumple_trigger thread function_e31780b1();
    self.shatter_trigger = shatter_trigger;
    self.crumple_trigger = crumple_trigger;
    self thread function_ee76afdc(self.var_39184114, shatter_trigger, crumple_trigger);
    self thread function_2e74e3c2(self.var_39184114, shatter_trigger, crumple_trigger);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x9955fcdf, Offset: 0x3648
// Size: 0x104
function function_301812b0() {
    if (is_true(self.var_49fdad6a)) {
        return;
    }
    if (is_true(self.var_da9b93fa)) {
        return;
    }
    if (isdefined(self.shatter_trigger) && isdefined(self.crumple_trigger)) {
        self function_1a915299(self.var_39184114, self.shatter_trigger, self.crumple_trigger);
        return;
    }
    if (isdefined(self)) {
        if (!(getdvarint(#"splitscreen_playercount", 1) > 2)) {
            self function_97bcf56f();
            self function_8af9f027();
        }
        self startragdoll();
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x8e4f19db, Offset: 0x3758
// Size: 0x54
function function_e31780b1() {
    level endon(#"end_game");
    self endon(#"death");
    wait 10;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 3, eflags: 0x1 linked
// Checksum 0x927f2327, Offset: 0x37b8
// Size: 0x100
function function_ee76afdc(params, shatter_trigger, crumple_trigger) {
    shatter_trigger endon(#"death", #"hash_4b43502d3b6d5a0");
    self endon(#"death");
    wait 0.1;
    orig_attacker = params.eattacker;
    while (true) {
        s_notify = shatter_trigger waittill(#"damage");
        if (isdefined(s_notify.amount)) {
            shatter_trigger.var_af6e27ba += s_notify.amount;
            if (shatter_trigger.var_af6e27ba >= 100) {
                self thread function_b439fd9b(params, shatter_trigger, crumple_trigger);
            }
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 3, eflags: 0x1 linked
// Checksum 0xe5fb479b, Offset: 0x38c0
// Size: 0x8c
function function_2e74e3c2(params, shatter_trigger, crumple_trigger) {
    crumple_trigger endon(#"death", #"hash_4b43502d3b6d5a0");
    self endon(#"death");
    wait 0.1;
    crumple_trigger waittill(#"trigger");
    self thread function_1a915299(params, shatter_trigger, crumple_trigger);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 3, eflags: 0x1 linked
// Checksum 0xc07324d7, Offset: 0x3958
// Size: 0x9c
function function_1a915299(*params, shatter_trigger, crumple_trigger) {
    /#
        self function_b68ec182("<dev string:xa6>");
    #/
    self thread function_60a1b1de(shatter_trigger, crumple_trigger);
    self zombie_eye_glow::function_95cae3e3();
    self function_ae87eaf();
    self startragdoll();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 3, eflags: 0x1 linked
// Checksum 0x21dca4ec, Offset: 0x3a00
// Size: 0x26c
function function_b439fd9b(params, shatter_trigger, crumple_trigger) {
    /#
        self function_b68ec182("<dev string:xb2>");
    #/
    self thread function_60a1b1de(shatter_trigger, crumple_trigger);
    centroid = self getcentroid();
    a_targets = getentitiesinradius(centroid, 300, 15);
    foreach (ai in a_targets) {
        if (!isdefined(ai) || ai.archetype !== #"zombie" && ai.archetype !== #"zombie_dog" && ai.archetype !== #"nova_crawler" || ai getteam() !== level.zombie_team) {
            continue;
        }
        if (isalive(ai)) {
            ai dodamage(5000, ai.origin, params.eattacker, undefined, undefined, "MOD_EXPLOSIVE");
            continue;
        }
        if (isdefined(ai.shatter_trigger)) {
            ai.shatter_trigger dodamage(5000, ai.origin, params.eattacker, undefined, undefined, "MOD_EXPLOSIVE");
        }
    }
    self zombie_eye_glow::function_95cae3e3();
    self function_2a7980e();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0xac5b034b, Offset: 0x3c78
// Size: 0xa4
function function_60a1b1de(shatter_trigger, crumple_trigger) {
    self endon(#"death");
    self.var_da9b93fa = 1;
    self notify(#"hash_4b43502d3b6d5a0");
    shatter_trigger notify(#"hash_4b43502d3b6d5a0");
    crumple_trigger notify(#"hash_4b43502d3b6d5a0");
    wait 1;
    shatter_trigger delete();
    crumple_trigger delete();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x8c4de6b2, Offset: 0x3d28
// Size: 0x34
function function_4942e7b9() {
    self clientfield::set("" + #"hash_3a35110e6ccc5486", 1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xa6deb3b1, Offset: 0x3d68
// Size: 0x2c
function function_97bcf56f() {
    self clientfield::set("" + #"hash_3a35110e6ccc5486", 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x17f0566f, Offset: 0x3da0
// Size: 0x34
function function_f94aa073() {
    self clientfield::set("" + #"hash_1709a7bbfac5e1e0", 1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x2a4639bb, Offset: 0x3de0
// Size: 0x2c
function function_8af9f027() {
    self clientfield::set("" + #"hash_1709a7bbfac5e1e0", 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xe021a5a9, Offset: 0x3e18
// Size: 0x34
function function_57e0c5e() {
    self clientfield::set("" + #"hash_48257c0dba76b140", 1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x0
// Checksum 0x8021c681, Offset: 0x3e58
// Size: 0x2c
function function_e7829213() {
    self clientfield::set("" + #"hash_48257c0dba76b140", 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x8b653aa9, Offset: 0x3e90
// Size: 0x34
function function_ae87eaf() {
    self clientfield::set("" + #"hash_6dca42b5563953ef", 1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xd1f33099, Offset: 0x3ed0
// Size: 0x34
function function_2a7980e() {
    self clientfield::set("" + #"hash_2a7b72235f0b387e", 1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x6d109336, Offset: 0x3f10
// Size: 0x22
function function_47c38bc8(watcher) {
    watcher.onspawn = &function_4af61eed;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0xeb3624b1, Offset: 0x3f40
// Size: 0x5c
function function_4af61eed(*watcher, player) {
    player endon(#"death");
    level endon(#"end_game");
    self thread function_6793b4dc(player);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xd43ffabc, Offset: 0x3fa8
// Size: 0xac
function function_6793b4dc(owner) {
    self endon(#"hash_3d4b5f79f21a96b0");
    self thread function_3bf9052d();
    waitresult = self waittill(#"projectile_impact_explode", #"explode");
    if (waitresult._notify == "projectile_impact_explode") {
        function_302616d5(owner, waitresult.position, waitresult.normal);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x33d433d0, Offset: 0x4060
// Size: 0x2e
function function_3bf9052d() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"hash_3d4b5f79f21a96b0");
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 3, eflags: 0x1 linked
// Checksum 0xa4226261, Offset: 0x4098
// Size: 0x114
function function_302616d5(owner, position, normal) {
    dir_up = (0, 0, 1);
    ent = spawntimedfx(getweapon(#"hash_43f15ab903e2e35"), position, dir_up, int(10));
    if (isdefined(owner)) {
        ent setteam(owner.team);
        if (isplayer(owner)) {
            ent setowner(owner);
        }
    }
    thread function_f9ebf407(owner, position, normal, 65, 100, int(gettime() + 10000));
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 6, eflags: 0x1 linked
// Checksum 0x40331cba, Offset: 0x41b8
// Size: 0x24c
function function_f9ebf407(owner, position, *normal, radius, height, damageendtime) {
    level endon(#"end_game");
    trigger_radius_position = normal - (0, 0, height);
    trigger_radius_height = height * 2;
    gaseffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
    while (gettime() < damageendtime) {
        all_targets = [];
        all_targets = arraycombine(all_targets, getaiarray(), 0, 0);
        foreach (target in all_targets) {
            if (target istouching(gaseffectarea) && isalive(target)) {
                target dodamage(500, target.origin, position, getweapon(#"ww_ieu_gas_t9"), "none", "MOD_UNKNOWN", 0, getweapon(#"ww_ieu_gas_t9"));
                if (500 < target.health) {
                    target thread function_48c9861b(gettime());
                }
            }
        }
        wait 0.3;
    }
    if (isdefined(gaseffectarea)) {
        gaseffectarea delete();
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x5 linked
// Checksum 0x4c757fb, Offset: 0x4410
// Size: 0xee
function private function_48c9861b(var_66284057) {
    level endon(#"end_game");
    self.var_ca98503 = var_66284057 + 0.4;
    if (is_true(self.var_65ebe4ec)) {
        return;
    }
    function_74be4c3e(1);
    self.var_65ebe4ec = 1;
    for (time_now = gettime(); time_now < self.var_ca98503; time_now = gettime()) {
        wait self.var_ca98503 - time_now;
        if (!isdefined(self)) {
            return;
        }
    }
    if (isalive(self)) {
        function_41ac088f();
        self.var_65ebe4ec = 0;
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0x9db89b00, Offset: 0x4508
// Size: 0x8c
function function_c9ccbd54() {
    level endon(#"end_game");
    function_74be4c3e(2);
    result = self waittill(#"actor_corpse");
    if (isdefined(result.corpse)) {
        result.corpse function_74be4c3e(2);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x8fa618a0, Offset: 0x45a0
// Size: 0x64
function function_c8adf16f(*weapon) {
    self.var_343d2604--;
    if (self.var_343d2604 < 0) {
        self.var_343d2604 = 0;
    } else if (self.var_343d2604 > 8) {
        self.var_343d2604 = 8;
    }
    function_53e5275c(self.var_343d2604);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xe9fb8717, Offset: 0x4610
// Size: 0x34
function function_74be4c3e(stage) {
    self clientfield::set("" + #"hash_97d03a2a0786ba6", stage);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xfa2ded9, Offset: 0x4650
// Size: 0x2c
function function_41ac088f() {
    self clientfield::set("" + #"hash_97d03a2a0786ba6", 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x70625f7d, Offset: 0x4688
// Size: 0x34
function function_53e5275c(ammo_count) {
    self clientfield::set("" + #"hash_3c92af57fde1f8f7", ammo_count);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xbc97e891, Offset: 0x46c8
// Size: 0x22
function function_3c39516d(watcher) {
    watcher.onspawn = &function_83869cdb;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x6fbe4072, Offset: 0x46f8
// Size: 0x5c
function function_83869cdb(*watcher, player) {
    self clientfield::set("" + #"hash_68195637521e3973", 1);
    self thread function_615ff5e9(player);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xfe206075, Offset: 0x4760
// Size: 0x166
function function_615ff5e9(owner) {
    self endon(#"death");
    while (true) {
        var_6a77cda0 = getentarray("trigger_damage", "classname");
        arrayremovevalue(var_6a77cda0, undefined);
        var_6a77cda0 = arraysortclosest(var_6a77cda0, self.origin, undefined, undefined, 100);
        foreach (trigger in var_6a77cda0) {
            if (self istouching(trigger)) {
                trigger notify(#"damage", {#attacker:owner, #weapon:level.var_12b450dc});
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 12, eflags: 0x1 linked
// Checksum 0xabfa559a, Offset: 0x48d0
// Size: 0x148
function function_fd195372(inflictor, attacker, damage, *flags, meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (isdefined(shitloc) && surfacetype != "MOD_DOT") {
        if (!isdefined(shitloc.var_4bc2bb56)) {
            shitloc.var_4bc2bb56 = 100000;
        }
        boneindex = min(self.health, shitloc.var_4bc2bb56);
        shitloc.var_4bc2bb56 -= boneindex;
        if (isplayer(psoffsettime)) {
            psoffsettime clientfield::increment("" + #"hash_492f4817c4296ddf");
        }
        if (shitloc.var_4bc2bb56 == 0) {
            shitloc deletedelay();
        }
    }
    return boneindex;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xda660cb7, Offset: 0x4a20
// Size: 0x172
function function_efcce3c1() {
    level.var_284e25d2 = [];
    level.var_284e25d2[1] = spawnstruct();
    level.var_284e25d2[1].damage = 10;
    level.var_284e25d2[1].var_dfd1c927 = 1;
    level.var_284e25d2[1].var_4a0c6d55 = 1500;
    level.var_284e25d2[2] = spawnstruct();
    level.var_284e25d2[2].damage = 25;
    level.var_284e25d2[2].var_dfd1c927 = 2;
    level.var_284e25d2[2].var_4a0c6d55 = 5000;
    level.var_284e25d2[3] = spawnstruct();
    level.var_284e25d2[3].damage = 50;
    level.var_284e25d2[3].var_dfd1c927 = 3;
    level.var_284e25d2[3].var_4a0c6d55 = undefined;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x7212b7c5, Offset: 0x4ba0
// Size: 0x14c
function function_635ff818(*weapon) {
    if (!is_true(self.var_3f74bd46)) {
        self.var_3f74bd46 = 1;
        self.var_7c223de7 = gettime();
        self.var_9cb64422 = 0;
        self.var_c627b034 = 1;
        thread function_a8733e49();
    } else {
        time_now = gettime();
        self.var_9cb64422 += time_now - self.var_7c223de7;
        self.var_7c223de7 = time_now;
        if (isdefined(level.var_284e25d2[self.var_c627b034].var_4a0c6d55) && self.var_9cb64422 > level.var_284e25d2[self.var_c627b034].var_4a0c6d55) {
            self.var_c627b034 += 1;
        }
    }
    self function_96db9f3(self getcurrentweapon(), level.var_284e25d2[self.var_c627b034].var_dfd1c927 * -1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x1 linked
// Checksum 0xd9a18355, Offset: 0x4cf8
// Size: 0x100
function function_a8733e49() {
    self endon(#"death", #"weapon_change");
    level endon(#"end_game");
    while (is_true(self.var_3f74bd46)) {
        wait 0.1;
        if (!self isfiring()) {
            self.var_3f74bd46 = 0;
            continue;
        }
        self magicmissile(getweapon(#"hash_d621816f9c357a5"), self gettagorigin("tag_flash"), anglestoforward(self getplayerangles()) * 2000);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 12, eflags: 0x1 linked
// Checksum 0x9f76065d, Offset: 0x4e00
// Size: 0x82
function function_ce364583(*inflictor, *attacker, damage, *flags, meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (surfacetype === "MOD_DOT") {
        return boneindex;
    }
    return 0;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 12, eflags: 0x1 linked
// Checksum 0x402776d2, Offset: 0x4e90
// Size: 0xb6
function function_60e38f77(*inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (isdefined(level.var_284e25d2[boneindex.var_c627b034].damage)) {
        return int(level.var_284e25d2[boneindex.var_c627b034].damage);
    }
    return surfacetype;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x3b607417, Offset: 0x4f50
// Size: 0x8c
function function_b68ec182(msg, color = (1, 1, 1)) {
    /#
        if (!getdvarint(#"hash_528e35e5faa6eb75", 0)) {
            return;
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    #/
}

