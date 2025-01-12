#using script_1160d62024d6945b;
#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_c8fb02a7;

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x0
// Checksum 0x4c79fa6a, Offset: 0x1d8
// Size: 0x1ec
function function_a01726dd() {
    self.var_d6691161 = 3000;
    self.var_5002d77c = 0.7;
    self.var_56b349b4 = 0;
    self.var_cd4099ea = 0;
    self.var_38800c0 = 1;
    self.var_c82ffc5e = 0;
    self setheliheightcap(1);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_1435d6c2);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_6ad9ed56);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_6ad9ed56);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_b515cb89);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_6258a76c);
    self callback::on_vehicle_collision(&function_adbcb48d);
    self.overridevehiclekilled = &function_f7f4dbf0;
    self thread function_97305c79();
    self thread function_d6742832();
    self thread function_638d1ade();
    self thread function_4f8aa02d();
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x4968bcb2, Offset: 0x3d0
// Size: 0x84
function private function_6ad9ed56() {
    if (getdvarint(#"hash_6e660633f2dbac2a", 1) > 0) {
        driver = self getseatoccupant(0);
        if (isdefined(driver) && isplayer(driver)) {
            self thread player_vehicle::function_d3da7e1e();
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x1 linked
// Checksum 0xd3fd9ea5, Offset: 0x460
// Size: 0xc8
function function_56ee2902(state) {
    foreach (occupant in self getvehoccupants()) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.malfunction", state);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xad7298ab, Offset: 0x530
// Size: 0xca
function private function_455f2b9b() {
    self function_803e9bf3(2);
    self setrotorspeed(0.7);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x38>" + self getentnum() + "<dev string:x57>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 2;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xff08a5c5, Offset: 0x608
// Size: 0xaa
function private function_2ea47d8() {
    self function_803e9bf3(3);
    self setrotorspeed(0.7);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x61>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 3;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xa7b1cdb2, Offset: 0x6c0
// Size: 0xa2
function private function_b80bf20f() {
    self function_803e9bf3(3);
    self setrotorspeed(1);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x7c>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 4;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x1 linked
// Checksum 0x5e8ac1e1, Offset: 0x770
// Size: 0xb6
function function_a2b127e3() {
    self returnplayercontrol();
    self setrotorspeed(1);
    self function_803e9bf3(1);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x9c>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 0;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xa89452e4, Offset: 0x830
// Size: 0xba
function private function_edd50d7d() {
    self takeplayercontrol();
    self function_803e9bf3(0);
    self setrotorspeed(1);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:xb6>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 1;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x7bbbe20f, Offset: 0x8f8
// Size: 0xb2
function private function_6aa62d8b() {
    self player_vehicle::function_8cf138bb();
    player_vehicle::turn_off();
    self function_803e9bf3(0);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:xd0>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 5;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xdcef0977, Offset: 0x9b8
// Size: 0xba
function private function_8b99abde() {
    self function_803e9bf3(1);
    self setrotorspeed(1);
    self thread function_7b63d976();
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:xef>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 6;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x1 linked
// Checksum 0x16eb9efd, Offset: 0xa80
// Size: 0xc2
function function_2a0f9c3c() {
    self takeplayercontrol();
    self function_803e9bf3(3);
    self setrotorspeed(0.7);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x111>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_38800c0 = 7;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x483c9f61, Offset: 0xb50
// Size: 0x5a6
function private function_97305c79() {
    self endon(#"death");
    while (isalive(self)) {
        if (!is_true(self.var_52e23e90) && self.var_38800c0 != 5) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x12e>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_63016e7b3baecd6b");
            continue;
        }
        if (self.var_38800c0 == 0) {
            self thread function_499252fe();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x144>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_2d3ebedb650b9759");
            continue;
        }
        if (self.var_38800c0 == 1) {
            self thread function_1c32d368();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x15d>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_51cf6123efa445ce");
            continue;
        }
        if (self.var_38800c0 == 2) {
            self thread function_7a66682a();
            self thread function_55a21c7f();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x176>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_74bba4f3dddf9fc3");
            continue;
        }
        if (self.var_38800c0 == 3) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x194>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_573e89d990d75799");
            continue;
        }
        if (self.var_38800c0 == 4) {
            self thread function_158a4c05();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1ae>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_1df27f53ba982860");
            continue;
        }
        if (self.var_38800c0 == 5) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1cd>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_b87b2afaca5829c");
            continue;
        }
        if (self.var_38800c0 == 6) {
            self thread function_b2cbe3f8();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1eb>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_ecab417d1ae9d64");
            continue;
        }
        if (self.var_38800c0 == 7) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x20c>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_453082d0b252c039");
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x3c695fa2, Offset: 0x1100
// Size: 0x1de
function private function_d6742832() {
    self endon(#"death");
    while (isalive(self)) {
        if (self.var_c82ffc5e == 0) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x228>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_1c3dc90bd345b165");
            continue;
        }
        if (self.var_c82ffc5e == 1) {
            self thread function_a133d262();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x24a>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_275d130720063641");
            continue;
        }
        if (self.var_c82ffc5e == 2) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x26c>" + self getentnum() + "<dev string:x5c>");
                }
            #/
            self waittill(#"hash_b52e63b6ac3646a");
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xe59b278f, Offset: 0x12e8
// Size: 0xe8
function private function_638d1ade() {
    self endon(#"death");
    while (true) {
        if (death_circle::is_active()) {
            if (death_circle::function_f8dae197() <= 4298) {
                function_825bbe3f();
            } else if (death_circle::function_65cb78e7(self.origin) > 0) {
                function_c060273d();
            } else {
                function_586d9fee();
            }
            wait 0.1;
            continue;
        }
        function_586d9fee();
        wait 2;
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x543bb3bb, Offset: 0x13d8
// Size: 0x6e
function private function_586d9fee() {
    if (self.var_c82ffc5e == 1) {
        function_5b6643c1();
        self notify(#"hash_275d130720063641");
        return;
    }
    if (self.var_c82ffc5e == 2) {
        function_5b6643c1();
        self notify(#"hash_b52e63b6ac3646a");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x7200803f, Offset: 0x1450
// Size: 0x36
function private function_c060273d() {
    if (self.var_c82ffc5e == 0) {
        function_3705cb9a();
        self notify(#"hash_1c3dc90bd345b165");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x7b282d55, Offset: 0x1490
// Size: 0x6e
function private function_825bbe3f() {
    if (self.var_c82ffc5e == 0) {
        function_cfb0d0ad();
        self notify(#"hash_1c3dc90bd345b165");
        return;
    }
    if (self.var_c82ffc5e == 1) {
        function_cfb0d0ad();
        self notify(#"hash_275d130720063641");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xc4b82cfa, Offset: 0x1508
// Size: 0x186
function private function_5b6643c1() {
    self function_56ee2902(0);
    self clientfield::set("update_malfunction", 0);
    self clientfield::set("flickerlights", 3);
    if (!is_true(self.var_52e23e90) && self.var_38800c0 == 5) {
        player_vehicle::turn_off();
        self notify(#"hash_b87b2afaca5829c");
    } else if (self.var_38800c0 == 6) {
        function_a2b127e3();
        self notify(#"hash_ecab417d1ae9d64");
    } else if (self.var_38800c0 == 7) {
        function_a2b127e3();
        self notify(#"hash_453082d0b252c039");
    }
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x290>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_c82ffc5e = 0;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x50c35a5e, Offset: 0x1698
// Size: 0x1a2
function private function_3705cb9a() {
    self function_56ee2902(1);
    self clientfield::set("update_malfunction", 1);
    self clientfield::set("flickerlights", 2);
    if (!is_true(self.var_52e23e90)) {
        function_6aa62d8b();
        self notify(#"hash_63016e7b3baecd6b");
    } else if (self.var_38800c0 == 0 && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
        function_8b99abde();
        self notify(#"hash_2d3ebedb650b9759");
    } else if (self.var_38800c0 == 1) {
        function_6aa62d8b();
        self notify(#"hash_51cf6123efa445ce");
    }
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x2b3>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_c82ffc5e = 1;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x15a1d004, Offset: 0x1848
// Size: 0x282
function private function_cfb0d0ad() {
    self clientfield::set("update_malfunction", 2);
    self clientfield::set("flickerlights", 3);
    self function_56ee2902(2);
    if (!is_true(self.var_52e23e90)) {
        function_6aa62d8b();
        self notify(#"hash_63016e7b3baecd6b");
    } else if (self.var_38800c0 == 1) {
        function_6aa62d8b();
        self notify(#"hash_51cf6123efa445ce");
    } else if (self.var_38800c0 == 0 && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
        function_2a0f9c3c();
        self notify(#"hash_2d3ebedb650b9759");
    } else if (self.var_38800c0 == 2) {
        function_2a0f9c3c();
        self notify(#"hash_74bba4f3dddf9fc3");
    } else if (self.var_38800c0 == 3) {
        function_2a0f9c3c();
        self notify(#"hash_573e89d990d75799");
    } else if (self.var_38800c0 == 4) {
        function_2a0f9c3c();
        self notify(#"hash_1df27f53ba982860");
    } else if (self.var_38800c0 == 6) {
        function_2a0f9c3c();
        self notify(#"hash_ecab417d1ae9d64");
    }
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x2d6>" + self getentnum() + "<dev string:x5c>");
        }
    #/
    self.var_c82ffc5e = 2;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x4c1a9d53, Offset: 0x1ad8
// Size: 0x76
function private function_a133d262() {
    self notify(#"hash_1707434571fb5e82");
    self endon(#"death", #"hash_275d130720063641", #"hash_1707434571fb5e82");
    waitframe(1);
    wait 30;
    function_cfb0d0ad();
    self notify(#"hash_275d130720063641");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x1 linked
// Checksum 0x3a5f0640, Offset: 0x1b58
// Size: 0xc6
function function_82224f4b(scale) {
    self notify("28f8b5152bf1afd9");
    self endon("28f8b5152bf1afd9");
    self endon(#"death", #"hash_ecab417d1ae9d64", #"hash_1d3acb3966f46517");
    while (true) {
        accel = anglestoup(self.angles) * scale;
        self setphysacceleration((accel[0], accel[1], -200));
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xc84cc8d5, Offset: 0x1c28
// Size: 0xb4
function private function_838515ae() {
    self takeplayercontrol();
    self clientfield::set("update_malfunction", 2);
    self setrotorspeed(0.7);
    self clientfield::set("flickerlights", 3);
    self function_56ee2902(2);
    self thread function_82224f4b(1600);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xe0c242f1, Offset: 0x1ce8
// Size: 0x150
function private function_7b63d976() {
    self endon(#"death", #"hash_ecab417d1ae9d64");
    wait 5;
    self clientfield::set("flickerlights", 2);
    while (true) {
        self function_838515ae();
        wait randomfloatrange(1, 3);
        self notify(#"hash_1d3acb3966f46517");
        self returnplayercontrol();
        self setrotorspeed(1);
        self function_56ee2902(1);
        self clientfield::set("update_malfunction", 1);
        self clientfield::set("flickerlights", 2);
        wait randomfloatrange(3, 10);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x65f52c51, Offset: 0x1e40
// Size: 0x36
function private function_54f9ca32() {
    return self.var_38800c0 === 3 || self.var_38800c0 === 4 || self.var_38800c0 === 7;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x5 linked
// Checksum 0x66651763, Offset: 0x1e80
// Size: 0x6e
function private function_adbcb48d(*params) {
    if (is_true(self function_54f9ca32())) {
        self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
        return;
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xa163fdda, Offset: 0x1ef8
// Size: 0x14a
function private function_4f8aa02d() {
    self endon(#"death");
    while (true) {
        waterheight = getwaterheight(self.origin, 100, -10000);
        if (waterheight != -131072) {
            var_19dbcac7 = self.origin[2] + -70 - waterheight;
            if (var_19dbcac7 <= 0) {
                self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
            }
            if (var_19dbcac7 < 1000) {
                wait 0.25;
            } else if (var_19dbcac7 < 2000) {
                wait 1;
            } else {
                time = math::clamp(int(var_19dbcac7 / 1000), 1, 5);
                wait time;
            }
            continue;
        }
        wait 2;
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 8, eflags: 0x5 linked
// Checksum 0x2807ec43, Offset: 0x2050
// Size: 0xc4
function private function_f7f4dbf0(*einflictor, *eattacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime) {
    player_vehicle::turn_off();
    self function_56ee2902(0);
    self clientfield::set("update_malfunction", 0);
    self clientfield::set("flickerlights", 3);
    self function_803e9bf3(0);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 2, eflags: 0x1 linked
// Checksum 0x1a021edd, Offset: 0x2120
// Size: 0x2a
function function_9ffa5fd(var_92eb9b7d, var_6d872cea) {
    return self function_47fb62f4(var_92eb9b7d, var_6d872cea);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 3, eflags: 0x1 linked
// Checksum 0x16750ff1, Offset: 0x2158
// Size: 0x94
function function_60bfc90(player, var_92eb9b7d, var_6d872cea) {
    self endon(#"death");
    player function_a61cb23e(1);
    tweentime = self function_ff1bf59c(var_92eb9b7d, var_6d872cea);
    wait tweentime * 2;
    player function_a61cb23e(0);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 3, eflags: 0x1 linked
// Checksum 0x19642725, Offset: 0x21f8
// Size: 0x74
function function_b1088764(player, var_92eb9b7d, var_6d872cea) {
    player luinotifyevent(#"quick_fade", 0);
    player luinotifyeventtospectators(#"quick_fade", 0);
    self thread function_60bfc90(player, var_92eb9b7d, var_6d872cea);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x5 linked
// Checksum 0xd469ab65, Offset: 0x2278
// Size: 0x10c
function private function_b515cb89(params) {
    if (isalive(self)) {
        if (params.eventstruct.seat_index === 0) {
            function_dce84927();
        } else if (params.eventstruct.old_seat_index === 0) {
            function_d7021cf2();
        }
        if (isdefined(params.player)) {
            enter_seat = params.eventstruct.seat_index;
            exit_seat = params.eventstruct.old_seat_index;
            if (function_9ffa5fd(exit_seat, enter_seat)) {
                self function_b1088764(params.player, exit_seat, enter_seat);
            }
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x5 linked
// Checksum 0x2bf3d5f9, Offset: 0x2390
// Size: 0xc4
function private function_1435d6c2(params) {
    if (isalive(self)) {
        if (params.eventstruct.seat_index === 0) {
            function_dce84927();
        }
        if (isdefined(params.player)) {
            enter_seat = params.eventstruct.seat_index;
            if (function_9ffa5fd(undefined, enter_seat)) {
                self function_b1088764(params.player, undefined, enter_seat);
            }
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x5 linked
// Checksum 0xc0c2432b, Offset: 0x2460
// Size: 0xf4
function private function_6258a76c(params) {
    if (isalive(self)) {
        occupants = self getvehoccupants();
        if (!isdefined(occupants) || !occupants.size) {
            if (self.var_38800c0 == 1) {
                player_vehicle::turn_off();
                self notify(#"hash_51cf6123efa445ce");
            }
        }
        if (params.eventstruct.seat_index === 0) {
            function_d7021cf2();
        }
    }
    if (isdefined(params.player)) {
        params.player clientfield::set_player_uimodel("vehicle.malfunction", 0);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x551d0207, Offset: 0x2560
// Size: 0x186
function private function_dce84927() {
    if (!is_true(self.var_52e23e90)) {
        params = spawnstruct();
        params.var_30a04b16 = 1;
        player_vehicle::turn_on(params);
        /#
            if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                print("<dev string:xb6>" + self getentnum() + "<dev string:x5c>");
            }
        #/
        self.var_38800c0 = 1;
        self.var_cd532f2c = gettime() + 3000;
        self notify(#"hash_63016e7b3baecd6b");
        return;
    }
    if (self.var_38800c0 == 2) {
        if (self.var_c82ffc5e == 0) {
            function_a2b127e3();
        } else {
            function_8b99abde();
        }
        self notify(#"hash_74bba4f3dddf9fc3");
        return;
    }
    if (self.var_38800c0 == 3) {
        function_b80bf20f();
        self notify(#"hash_573e89d990d75799");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x2493dd86, Offset: 0x26f0
// Size: 0x96
function private function_d7021cf2() {
    if (self.var_38800c0 == 0 && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
        function_455f2b9b();
        self notify(#"hash_2d3ebedb650b9759");
        return;
    }
    if (self.var_38800c0 == 4) {
        function_2ea47d8();
        self notify(#"hash_1df27f53ba982860");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x9218f37c, Offset: 0x2790
// Size: 0x184
function private function_1c32d368() {
    self notify(#"hash_203455df2978ba88");
    self endon(#"death", #"hash_51cf6123efa445ce", #"hash_203455df2978ba88");
    waitframe(1);
    while (true) {
        player = self getseatoccupant(0);
        if (isdefined(player) && (!isdefined(self.var_cd532f2c) || gettime() - self.var_cd532f2c >= 0)) {
            self.var_cd532f2c = undefined;
            move = player getnormalizedmovement();
            var_d4865741 = player vehiclemoveupbuttonpressed() || isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2);
            if (var_d4865741) {
                function_a2b127e3();
                self notify(#"hash_51cf6123efa445ce");
                break;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x2c188423, Offset: 0x2920
// Size: 0x1ac
function private function_499252fe() {
    self notify(#"hash_69e2c4ec2a3d91b4");
    self endon(#"death", #"hash_2d3ebedb650b9759", #"hash_69e2c4ec2a3d91b4");
    waitframe(1);
    while (true) {
        player = self getseatoccupant(0);
        if (!isdefined(player) || !player function_6947dde2() || player vehiclemoveupbuttonpressed()) {
            waitframe(1);
            continue;
        }
        move = player getnormalizedmovement();
        if (isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            waitframe(1);
            continue;
        }
        if (self function_479389f3() && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
            function_edd50d7d();
            self notify(#"hash_2d3ebedb650b9759");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x1cf8062c, Offset: 0x2ad8
// Size: 0xf4
function private function_7a66682a() {
    self notify(#"hash_73b33f91c657e33e");
    self endon(#"death", #"hash_74bba4f3dddf9fc3", #"hash_73b33f91c657e33e");
    waitframe(1);
    while (true) {
        if (self function_479389f3()) {
            occupants = self getvehoccupants();
            if (!isdefined(occupants) || !occupants.size) {
                player_vehicle::turn_off();
            } else {
                function_edd50d7d();
            }
            self notify(#"hash_74bba4f3dddf9fc3");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x84cbec62, Offset: 0x2bd8
// Size: 0xa4
function private function_b2cbe3f8() {
    self notify(#"hash_5b78f14ae4e8dc43");
    self endon(#"death", #"hash_ecab417d1ae9d64", #"hash_5b78f14ae4e8dc43");
    waitframe(1);
    while (true) {
        if (self function_479389f3()) {
            function_6aa62d8b();
            self notify(#"hash_ecab417d1ae9d64");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0xdf59b00c, Offset: 0x2c88
// Size: 0x76
function private function_55a21c7f() {
    self notify(#"hash_655e0e5013875cda");
    self endon(#"death", #"hash_74bba4f3dddf9fc3", #"hash_655e0e5013875cda");
    waitframe(1);
    wait 1;
    function_2ea47d8();
    self notify(#"hash_74bba4f3dddf9fc3");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x2f11e615, Offset: 0x2d08
// Size: 0xa6
function private function_158a4c05() {
    self notify(#"hash_413db73113f75c85");
    self endon(#"death", #"hash_1df27f53ba982860", #"hash_413db73113f75c85");
    waitframe(1);
    wait 0.8;
    if (self.var_c82ffc5e == 0) {
        function_a2b127e3();
    } else {
        function_8b99abde();
    }
    self notify(#"hash_1df27f53ba982860");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x5 linked
// Checksum 0x400bccbf, Offset: 0x2db8
// Size: 0x682
function private function_479389f3() {
    if (self function_5e768331() > 200) {
        return false;
    }
    height = self.height;
    assert(isdefined(self.radius));
    assert(isdefined(self.height));
    var_33a206d0 = [];
    var_33a206d0[#"leftrear"] = self gettagorigin("tag_ground_contact_left_rear");
    var_33a206d0[#"leftmiddle"] = self gettagorigin("tag_ground_contact_left_middle");
    var_33a206d0[#"leftfront"] = self gettagorigin("tag_ground_contact_left_front");
    var_8fc02d3b = [];
    var_8fc02d3b[#"rightrear"] = self gettagorigin("tag_ground_contact_right_rear");
    var_8fc02d3b[#"rightmiddle"] = self gettagorigin("tag_ground_contact_right_middle");
    var_8fc02d3b[#"rightfront"] = self gettagorigin("tag_ground_contact_right_front");
    var_df47b913 = [];
    foreach (tag, origin in var_33a206d0) {
        if (!isdefined(origin)) {
            return false;
        }
        var_df47b913[tag] = physicstrace(origin + (0, 0, 25), origin - (0, 0, 75), (0, 0, 0), (0, 0, 0), self, 2);
    }
    var_dc8469e2 = [];
    foreach (tag, origin in var_8fc02d3b) {
        if (!isdefined(origin)) {
            return false;
        }
        var_dc8469e2[tag] = physicstrace(origin + (0, 0, 25), origin - (0, 0, 75), (0, 0, 0), (0, 0, 0), self, 2);
    }
    var_d643c4fc = 0;
    var_e10b67f7 = [];
    var_b0e8278f = (0, 0, 0);
    avgnormal = (0, 0, 0);
    var_4c962569 = 0;
    foreach (tag, trace in var_df47b913) {
        if (isdefined(trace[#"entity"])) {
            var_d643c4fc = 1;
            continue;
        }
        if (trace[#"fraction"] < 1) {
            var_b0e8278f += var_33a206d0[tag];
            var_4c962569 += trace[#"position"][2] - var_33a206d0[tag][2];
            avgnormal += trace[#"normal"];
            var_e10b67f7[tag] = trace;
        }
    }
    var_d3532cfe = [];
    foreach (tag, trace in var_dc8469e2) {
        if (isdefined(trace[#"entity"])) {
            var_d643c4fc = 1;
            continue;
        }
        if (trace[#"fraction"] < 1) {
            var_b0e8278f += var_8fc02d3b[tag];
            var_4c962569 += trace[#"position"][2] - var_8fc02d3b[tag][2];
            avgnormal += trace[#"normal"];
            var_d3532cfe[tag] = trace;
        }
    }
    if (var_e10b67f7.size > 0 || var_d3532cfe.size > 0) {
        avgnormal /= var_d3532cfe.size + var_e10b67f7.size;
        self.var_eb4e4182 = avgnormal;
    }
    if (avgnormal[2] < 0.94) {
        return false;
    }
    if (var_e10b67f7.size == 0 || var_d3532cfe.size == 0 || var_d3532cfe.size + var_e10b67f7.size < 3) {
        return false;
    }
    if (var_d643c4fc) {
        return false;
    }
    var_4c962569 /= var_d3532cfe.size + var_e10b67f7.size + 1;
    if (var_4c962569 > 20) {
        return false;
    }
    var_b0e8278f /= var_d3532cfe.size + var_e10b67f7.size;
    self.helilandingorigin = var_b0e8278f;
    self.var_6fac6f50 = var_4c962569;
    self.var_67136cb0 = avgnormal;
    return true;
}

