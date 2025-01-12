#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\debug_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace weapons;

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x2
// Checksum 0xfa0aaf0d, Offset: 0x158
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"weapons_shared", &__init__, undefined, undefined);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xd6ba8308, Offset: 0x1a0
// Size: 0x64
function __init__() {
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_connect);
    callback::on_disconnect(&function_4e0bf61c);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x4bed02c5, Offset: 0x210
// Size: 0x24
function on_connect() {
    self callback::on_death(&function_4e0bf61c);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x2c6556a5, Offset: 0x240
// Size: 0x54
function on_player_spawned() {
    /#
        self thread function_b62d11d6();
    #/
    if (!isdefined(level.var_f591e76f) || level.var_f591e76f) {
        self thread function_5978258f();
    }
}

/#

    // Namespace weapons/weapons_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa3a11dd0, Offset: 0x2a0
    // Size: 0x1c8
    function function_b62d11d6() {
        self endon(#"death");
        player = self;
        gameobject_link = undefined;
        while (true) {
            wait float(function_f9f48566()) / 1000;
            if (self.sessionstate != "<dev string:x30>") {
                continue;
            }
            test_mount = getdvarint(#"test_mount", 0);
            if (test_mount == 0) {
                continue;
            }
            if (test_mount == 1) {
                if (isdefined(gameobject_link)) {
                    gameobject_link delete();
                    gameobject_link = undefined;
                }
                gameobject_link = util::spawn_model("<dev string:x38>", player.origin, player.angles);
                player playerlinkto(gameobject_link, "<dev string:x38>", 0, 60, 60, 30, 10, 0);
                player function_8ed28f19();
            } else if (test_mount == 2) {
                player unlink();
            }
            setdvar(#"test_mount", 0);
        }
    }

#/

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x97c3759, Offset: 0x470
// Size: 0x8a
function getbaseweapon(weapon) {
    if (weapon.isaltmode) {
        baseweapon = getweapon(weapon.altweapon.statname);
    } else {
        baseweapon = getweapon(weapon.statname);
    }
    if (level.weaponnone == baseweapon) {
        baseweapon = weapon;
    }
    return baseweapon.rootweapon;
}

// Namespace weapons/weapons_shared
// Params 3, eflags: 0x0
// Checksum 0x193df026, Offset: 0x508
// Size: 0x16a
function function_81413a0e(weapon, forward, var_d923c280) {
    player = self;
    var_e165a997 = var_d923c280;
    var_2652bcd3 = player function_46a09663();
    var_8a3145a1 = 31;
    var_12b0e2f7 = vectorscale(forward, var_8a3145a1);
    trace_start = player.origin + (0, 0, var_2652bcd3 + 5) + var_12b0e2f7;
    trace_end = trace_start + (0, 0, -10);
    var_22c838b5 = 3;
    trace = physicstrace(trace_start, trace_end, (var_22c838b5 * -1, var_22c838b5 * -1, 0), (var_22c838b5, var_22c838b5, 1), player, 1);
    if (trace[#"fraction"] < 1) {
        var_e165a997 = 30;
    }
    return min(var_d923c280, var_e165a997);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x60e9a4cf, Offset: 0x680
// Size: 0x5c
function function_ecb2e04e() {
    self endon(#"death");
    self clientfield::set("deathfx", 1);
    wait 0.25;
    self delete();
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0xfe7e29f, Offset: 0x6e8
// Size: 0x34
function function_4e0bf61c(params) {
    if (!isdefined(self.var_37317829)) {
        return;
    }
    self.var_37317829 thread function_ecb2e04e();
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x8d693f8f, Offset: 0x728
// Size: 0xd26
function function_5978258f() {
    self notify("562ab31eaeed790b");
    self endon("562ab31eaeed790b");
    player = self;
    player endon(#"death", #"disconnect");
    gameobject_link = undefined;
    vehicle = undefined;
    var_83698987 = undefined;
    while (isdefined(player.var_37317829)) {
        wait float(function_f9f48566()) / 1000;
    }
    while (true) {
        wait float(function_f9f48566()) / 1000;
        current_weapon = player getcurrentweapon();
        if (current_weapon == level.weaponnone) {
            continue;
        }
        if (!current_weapon.mountable) {
            continue;
        }
        if (!player function_ec18dcf()) {
            continue;
        }
        if (current_weapon.altweapon != level.weaponnone && current_weapon.inventorytype != "altmode") {
            continue;
        }
        if (player playerads() == 0) {
            waitresult = player waittill(#"weapon_switch_started", #"weapon_ads_started");
            if (waitresult._notify != "weapon_ads_started") {
                continue;
            }
        }
        if (!player function_ec18dcf()) {
            continue;
        }
        if (current_weapon.altweapon != level.weaponnone && current_weapon.inventorytype != "altmode") {
            continue;
        }
        if (isdefined(gameobject_link)) {
            gameobject_link delete();
            gameobject_link = undefined;
        }
        player_angles = player getplayerangles();
        player_forward = anglestoforward(player_angles);
        var_31a36d93 = player function_60833a8e();
        var_2cc6642 = player_angles;
        var_2268f93d = anglestoforward(var_2cc6642);
        if (isdefined(var_31a36d93)) {
            var_2268f93d = var_31a36d93 * -1;
            var_2cc6642 = vectortoangles(var_2268f93d);
        } else {
            var_31a36d93 = vectornormalize((var_2268f93d[0], var_2268f93d[1], 0)) * -1;
        }
        if (current_weapon.var_7bd2d150) {
            settings = function_8e7bf94(current_weapon);
            var_bd6ba578 = player function_46a09663();
            var_83698987 = settings.var_cedf50b9;
            var_f113cd8 = settings.var_381533d6;
            var_58c9297a = -20;
            if (var_bd6ba578 >= 48) {
                var_f113cd8 = settings.var_fe5db2f4;
                var_58c9297a = 3;
            } else if (var_bd6ba578 >= 44) {
                var_f113cd8 = settings.var_fe5db2f4;
                var_58c9297a = 0;
            } else if (var_bd6ba578 >= 40) {
                var_f113cd8 = settings.var_6653c950;
                var_58c9297a = -4;
            } else if (var_bd6ba578 >= 36) {
                var_f113cd8 = settings.var_d29dbb8b;
                var_58c9297a = -8;
            } else if (var_bd6ba578 >= 32) {
                var_f113cd8 = settings.var_6aa7a52f;
                var_58c9297a = -12;
            } else if (var_bd6ba578 >= 28) {
                var_f113cd8 = settings.var_d01f1d7a;
                var_58c9297a = -16;
            }
            if (player getstance() == "crouch" && var_bd6ba578 >= 36) {
                player setstance("stand");
            } else if (player getstance() == "stand" && var_bd6ba578 < 36) {
                player setstance("crouch");
            }
            var_a95ba065 = var_bd6ba578 >= 36 ? "stand" : "crouch";
            exit_origin = player.origin;
            vehicle_origin = player.origin + vectorscale(vectornormalize((player_forward[0], player_forward[1], 0)), float(isdefined(settings.var_cb146136) ? settings.var_cb146136 : 16));
            vehicle_origin += (0, 0, var_58c9297a);
            player.var_6d1aee3e = var_58c9297a;
            vehicle = spawnvehicle(var_83698987, vehicle_origin, var_2cc6642);
            vehicle.team = player.team;
            vehicle setteam(vehicle.team);
            vehicle hide();
            if (isdefined(var_f113cd8)) {
                var_dcfb566 = getsubstr(var_f113cd8, 0, var_f113cd8.size - 3);
                vehicle_weapon = getweapon(var_dcfb566);
                if (vehicle_weapon != level.weaponnone) {
                    vehicle setvehweapon(vehicle_weapon);
                }
            }
            var_51c72285 = 1;
            vehicle_used = 0;
            player thread function_7e688161(settings);
            ads_fraction = player playerads();
            var_379a61e1 = gettime() + (1 - ads_fraction) * current_weapon.var_88754bc8;
            while (player playerads() < 1) {
                if (player playerads() == 0) {
                    var_51c72285 = 0;
                    break;
                }
                wait float(function_f9f48566()) / 1000;
            }
            while (gettime() < var_379a61e1) {
                if (player playerads() == 0) {
                    var_51c72285 = 0;
                    break;
                }
                wait float(function_f9f48566()) / 1000;
            }
            var_ad178458 = 0;
            if (var_51c72285) {
                var_807d8ead = player getcurrentweapon();
                vehicle show();
                vehicle clientfield::set("enemyvehicle", 0);
                vehicle usevehicle(player, 0);
                vehicle_used = 1;
                vehicle turretsettargetangles(0, var_2cc6642 - player_angles);
                player.var_97f809e6 = 1;
                player.var_eacfaf46 = 1;
                player.var_37317829 = vehicle;
                while (player adsbuttonpressed()) {
                    wait float(function_f9f48566()) / 1000;
                    slot = player gadgetgetslot(current_weapon.altweapon != level.weaponnone ? current_weapon.altweapon : current_weapon);
                    if (0 <= slot && slot < 3) {
                        power = player gadgetpowerget(slot);
                        if (power < 0.1) {
                            var_ad178458 = 1;
                            break;
                        }
                    }
                }
                vehicle usevehicle(player, 0);
                player.var_97f809e6 = undefined;
                player.var_eacfaf46 = undefined;
                player setstance(var_a95ba065);
                vehicle hide();
            }
            vehicle delete();
            vehicle = undefined;
            if (vehicle_used) {
                player setorigin(exit_origin);
            }
            if (var_ad178458) {
                while (true) {
                    wait float(function_f9f48566()) / 1000;
                    current_weapon = player getcurrentweapon();
                    if (current_weapon == level.weaponnone) {
                        continue;
                    }
                    if (current_weapon.mountable) {
                        continue;
                    }
                    break;
                }
            } else if (vehicle_used) {
                wait 0.4;
            }
            continue;
        }
        gameobject_link = util::spawn_model("tag_origin", player.origin, var_2cc6642);
        player playerlinkto(gameobject_link);
        var_e165a997 = current_weapon.var_d11b9ada;
        var_e165a997 = player function_81413a0e(current_weapon, var_2268f93d, var_e165a997);
        player lerpviewangleclamp(0.5, 0.1, 0.1, current_weapon.var_680516af, current_weapon.var_44e66440, current_weapon.var_a7d14cf1, var_e165a997);
        player function_8ed28f19();
        var_c75dd07 = 1;
        while (var_c75dd07) {
            if (player adsbuttonpressed() == 0) {
                player unlink();
                var_c75dd07 = 0;
                continue;
            }
            wait float(function_f9f48566()) / 1000;
        }
    }
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x21ada0e5, Offset: 0x1458
// Size: 0x10c
function function_7e688161(settings) {
    self notify("21639be952ab6485");
    self endon("21639be952ab6485");
    if (!isdefined(settings.mountable_weapon_mounted_rumble)) {
        return;
    }
    player = self;
    player endon(#"death", #"disconnect");
    rumble_delay = float(isdefined(settings.var_5b30b1b0) ? settings.var_5b30b1b0 : 0.5);
    if (rumble_delay > 0) {
        wait rumble_delay;
    }
    if (player playerads() == 0) {
        return;
    }
    player playrumbleonentity(settings.mountable_weapon_mounted_rumble);
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x2af9e35b, Offset: 0x1570
// Size: 0xd4
function function_8e7bf94(weapon) {
    assert(isdefined(weapon.customsettings), "<dev string:x43>" + weapon.name);
    if (!isdefined(level.var_d5c4e7b3)) {
        level.var_d5c4e7b3 = [];
    }
    var_a716620c = hash(weapon.name);
    if (!isdefined(level.var_d5c4e7b3[var_a716620c])) {
        level.var_d5c4e7b3[var_a716620c] = getscriptbundle(weapon.customsettings);
    }
    return level.var_d5c4e7b3[var_a716620c];
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0xffbc0800, Offset: 0x1650
// Size: 0x70
function is_primary_weapon(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && (isdefined(level.primary_weapon_array[root_weapon]) || (isdefined(weapon.var_e2c79298) ? weapon.var_e2c79298 : 0));
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x5d92d6d5, Offset: 0x16c8
// Size: 0x48
function is_side_arm(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.side_arm_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x35c464bb, Offset: 0x1718
// Size: 0x48
function is_inventory(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.inventory_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x53b8524c, Offset: 0x1768
// Size: 0x48
function is_grenade(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.grenade_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x63cbafa7, Offset: 0x17b8
// Size: 0x34
function force_stowed_weapon_update() {
    detach_all_weapons();
    stow_on_back();
    stow_on_hip();
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xe8a485f5, Offset: 0x17f8
// Size: 0x94
function detach_carry_object_model() {
    if (isdefined(self.carryobject) && isdefined(self.carryobject gameobjects::get_visible_carrier_model())) {
        if (isdefined(self.tag_stowed_back)) {
            self detach(self.tag_stowed_back, "tag_stowed_back");
            self.tag_stowed_back = undefined;
        }
        if (isdefined(self.var_e26db9b2)) {
            self.var_e26db9b2 delete();
        }
    }
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x6aacac4, Offset: 0x1898
// Size: 0x144
function detach_all_weapons() {
    if (isdefined(self.tag_stowed_back)) {
        clear_weapon = 1;
        if (isdefined(self.carryobject)) {
            carriermodel = self.carryobject gameobjects::get_visible_carrier_model();
            if (isdefined(carriermodel) && carriermodel == self.tag_stowed_back) {
                self detach(self.tag_stowed_back, "tag_stowed_back");
                clear_weapon = 0;
            }
        }
        if (clear_weapon) {
            self clearstowedweapon();
        }
        self.tag_stowed_back = undefined;
    } else {
        self clearstowedweapon();
    }
    if (isdefined(self.tag_stowed_hip)) {
        detach_model = self.tag_stowed_hip.worldmodel;
        self detach(detach_model, "tag_stowed_hip_rear");
        self.tag_stowed_hip = undefined;
    }
    if (isdefined(self.var_e26db9b2)) {
        self.var_e26db9b2 delete();
    }
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x36636f67, Offset: 0x19e8
// Size: 0x3e4
function stow_on_back(current) {
    currentweapon = self getcurrentweapon();
    currentaltweapon = currentweapon.altweapon;
    self.tag_stowed_back = undefined;
    weaponoptions = 0;
    index_weapon = level.weaponnone;
    if (isdefined(self.carryobject) && isdefined(self.carryobject gameobjects::get_visible_carrier_model())) {
        self.tag_stowed_back = self.carryobject gameobjects::get_visible_carrier_model();
        if (isdefined(self.carryobject.identifier) && self.carryobject.identifier == "resource_object") {
            self.var_e26db9b2 = util::spawn_model(self.tag_stowed_back, self gettagorigin("tag_origin"));
            var_84e3f300 = self.carryobject.e_object.var_601ae3ba;
            if (issubstr(var_84e3f300, "medium")) {
                v_link_offset = (20, 15, 10);
                var_eb79a93f = (0, 0, 0);
            } else if (var_84e3f300 === "heavy") {
                v_link_offset = (30, 0, 20);
                var_eb79a93f = (0, 90, 0);
            }
            self.var_e26db9b2 linkto(self, "tag_origin", v_link_offset, var_eb79a93f);
            self.var_e26db9b2 setplayercollision(0);
            self.tag_stowed_back = undefined;
            return;
        }
        self attach(self.tag_stowed_back, "tag_stowed_back", 1);
        return;
    } else if (currentweapon != level.weaponnone) {
        for (idx = 0; idx < self.weapon_array_primary.size; idx++) {
            temp_index_weapon = self.weapon_array_primary[idx];
            assert(isdefined(temp_index_weapon), "<dev string:x75>");
            if (temp_index_weapon == currentweapon) {
                continue;
            }
            if (temp_index_weapon == currentaltweapon) {
                continue;
            }
            if (temp_index_weapon.nonstowedweapon) {
                continue;
            }
            if (util::function_dd149434(self, temp_index_weapon)) {
                continue;
            }
            index_weapon = temp_index_weapon;
        }
        if (index_weapon == level.weaponnone) {
            for (idx = 0; idx < self.weapon_array_sidearm.size; idx++) {
                temp_index_weapon = self.weapon_array_sidearm[idx];
                assert(isdefined(temp_index_weapon), "<dev string:x94>");
                if (temp_index_weapon == currentweapon) {
                    continue;
                }
                if (temp_index_weapon == currentaltweapon) {
                    continue;
                }
                if (temp_index_weapon.nonstowedweapon) {
                    continue;
                }
                index_weapon = temp_index_weapon;
            }
        }
    }
    self setstowedweapon(index_weapon);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x168bfc59, Offset: 0x1dd8
// Size: 0xec
function stow_on_hip() {
    currentweapon = self getcurrentweapon();
    self.tag_stowed_hip = undefined;
    for (idx = 0; idx < self.weapon_array_inventory.size; idx++) {
        if (self.weapon_array_inventory[idx] == currentweapon) {
            continue;
        }
        if (!self getweaponammostock(self.weapon_array_inventory[idx])) {
            continue;
        }
        self.tag_stowed_hip = self.weapon_array_inventory[idx];
    }
    if (!isdefined(self.tag_stowed_hip)) {
        return;
    }
    self attach(self.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
}

// Namespace weapons/weapons_shared
// Params 4, eflags: 0x0
// Checksum 0x8890e1cc, Offset: 0x1ed0
// Size: 0x66
function weapondamagetracepassed(from, to, startradius, ignore) {
    trace = weapondamagetrace(from, to, startradius, ignore);
    return trace[#"fraction"] == 1;
}

// Namespace weapons/weapons_shared
// Params 4, eflags: 0x0
// Checksum 0x3a260b4a, Offset: 0x1f40
// Size: 0x1f0
function weapondamagetrace(from, to, startradius, ignore) {
    midpos = undefined;
    diff = to - from;
    if (lengthsquared(diff) < startradius * startradius) {
        midpos = to;
    }
    dir = vectornormalize(diff);
    midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
    trace = bullettrace(midpos, to, 0, ignore);
    /#
        if (getdvarint(#"scr_damage_debug", 0) != 0) {
            if (trace[#"fraction"] == 1) {
                thread debug::drawdebugline(midpos, to, (1, 1, 1), 600);
            } else {
                thread debug::drawdebugline(midpos, trace[#"position"], (1, 0.9, 0.8), 600);
                thread debug::drawdebugline(trace[#"position"], to, (1, 0.4, 0.3), 600);
            }
        }
    #/
    return trace;
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x77023805, Offset: 0x2138
// Size: 0x3c
function has_lmg() {
    weapon = self getcurrentweapon();
    return weapon.weapclass == "mg";
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xade4dc2b, Offset: 0x2180
// Size: 0x32
function has_launcher() {
    weapon = self getcurrentweapon();
    return weapon.isrocketlauncher;
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xe4b5bd59, Offset: 0x21c0
// Size: 0x32
function has_heavy_weapon() {
    weapon = self getcurrentweapon();
    return weapon.isheavyweapon;
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0xde79b5de, Offset: 0x2200
// Size: 0x60
function has_lockon(target) {
    player = self;
    clientnum = player getentitynumber();
    return isdefined(target.locked_on) && target.locked_on & 1 << clientnum;
}

// Namespace weapons/weapons_shared
// Params 2, eflags: 0x0
// Checksum 0x584fc2a7, Offset: 0x2268
// Size: 0x8e
function function_d1377e28(weapon, attachmentname) {
    foreach (attachment in weapon.attachments) {
        if (attachment == attachmentname) {
            return true;
        }
    }
    return false;
}

// Namespace weapons/weapons_shared
// Params 3, eflags: 0x0
// Checksum 0xb4d70f0f, Offset: 0x2300
// Size: 0x90
function function_fa5602(damage, weapon, target) {
    if (weapon.var_6c21624d) {
        damage *= weapon.var_6c21624d;
    }
    if (isdefined(target)) {
        if (function_d1377e28(weapon, "fmj2")) {
            if (target.var_b0c1f126) {
                damage *= target.var_b0c1f126;
            }
        }
    }
    return damage;
}

// Namespace weapons/weapons_shared
// Params 2, eflags: 0x0
// Checksum 0x11807d26, Offset: 0x2398
// Size: 0x84
function isheadshot(shitloc, smeansofdeath) {
    if (isdefined(shitloc) && (shitloc == "head" || shitloc == "helmet")) {
        return true;
    }
    switch (smeansofdeath) {
    case #"mod_melee_assassinate":
    case #"mod_melee":
        return false;
    }
    return false;
}

