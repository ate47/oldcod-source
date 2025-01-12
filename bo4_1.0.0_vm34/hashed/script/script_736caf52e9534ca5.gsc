#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_13b01f59;

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x2
// Checksum 0x13cc5adb, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_4b6aad59587b2b51", &__init__, undefined, undefined);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xd04b96e2, Offset: 0x130
// Size: 0x14c
function __init__() {
    level.var_53022701 = isdefined(getgametypesetting(#"deathzones")) && getgametypesetting(#"deathzones");
    level.deathzones = [];
    level.var_618a0feb = [];
    if (!level.var_53022701) {
        return;
    }
    clientfield::register("toplayer", "deathzonepostfx", 1, 1, "int");
    clientfield::register("toplayer", "deathzonewarningsound", 1, 2, "int");
    level.var_c102797c = 5;
    level.var_c6dde68f = 1;
    callback::on_game_playing(&function_de7ae64);
    /#
        level thread devgui_loop();
        level thread debug_loop();
    #/
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 3, eflags: 0x0
// Checksum 0x730ac34c, Offset: 0x288
// Size: 0x1ce
function init(targetname, var_ec5fecae = undefined, var_566cd0f3 = undefined) {
    assert(!isdefined(level.deathzones[targetname]), "<invalid>" + "<dev string:x42>" + targetname);
    if (isdefined(level.deathzones[targetname])) {
        return;
    }
    ent = getent(targetname, "targetName");
    assert(isdefined(ent), "<invalid>" + "<dev string:x68>" + targetname);
    if (!isdefined(ent)) {
        return;
    }
    zone = {#ent:ent, #index:level.deathzones.size, #state:0, #var_2a569af3:1, #dodamage:1, #links:[], #var_ec5fecae:var_ec5fecae, #var_566cd0f3:var_566cd0f3};
    function_61cd2208(zone.index, zone.state);
    level.deathzones[targetname] = zone;
    return zone;
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x0
// Checksum 0xb5878958, Offset: 0x460
// Size: 0x146
function link(var_d12d8e58, var_4334fd93) {
    var_d94ee2bc = level.deathzones[var_d12d8e58];
    var_4b5651f7 = level.deathzones[var_4334fd93];
    assert(isdefined(var_d94ee2bc), "<invalid>" + "<dev string:x9a>" + var_d12d8e58);
    assert(isdefined(var_4b5651f7), "<invalid>" + "<dev string:xbd>" + var_4334fd93);
    if (!isdefined(var_d94ee2bc) || !isdefined(var_4b5651f7)) {
        return;
    }
    if (!isinarray(var_d94ee2bc.links, var_4b5651f7)) {
        var_d94ee2bc.links[var_d94ee2bc.links.size] = var_4b5651f7;
    }
    if (!isinarray(var_4b5651f7.links, var_d94ee2bc)) {
        var_4b5651f7.links[var_4b5651f7.links.size] = var_d94ee2bc;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x51f34a29, Offset: 0x5b0
// Size: 0x1f8
function init_zones() {
    foreach (tower in level.var_7045f0c9.var_83ddbbac) {
        var_69901428 = undefined;
        foreach (floor in tower.var_f232f67f) {
            linkAdjacentFloors = isdefined(tower.linkAdjacentFloors) ? tower.linkAdjacentFloors : 0;
            init(floor.targetname);
            if (linkAdjacentFloors && isdefined(var_69901428)) {
                link(var_69901428, floor.targetname);
            }
            var_69901428 = floor.targetname;
        }
    }
    foreach (var_fec0ded7 in level.var_7045f0c9.var_2bf81182) {
        link(var_fec0ded7.var_f1a48208, var_fec0ded7.var_63abf143);
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 3, eflags: 0x0
// Checksum 0xf923b683, Offset: 0x7b0
// Size: 0x10a
function function_af1d1f12(count, var_31c9afab, var_a8c52c76) {
    assert(level.var_618a0feb.size <= 0 || var_31c9afab >= level.var_618a0feb[level.var_618a0feb.size - 1].var_31c9afab, "<invalid>" + "<dev string:xf6>");
    wave = {#count:count, #var_31c9afab:var_31c9afab, #var_a8c52c76:var_a8c52c76, #zones:[], #index:level.var_618a0feb.size};
    level.var_618a0feb[wave.index] = wave;
    return wave;
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0x31a4c7ad, Offset: 0x8c8
// Size: 0x14a
function function_f04fb703(targetname) {
    assert(level.var_618a0feb.size != 0, "<invalid>" + "<dev string:x151>");
    assert(isdefined(level.deathzones[targetname]), "<invalid>" + "<dev string:x162>" + targetname);
    assert(!isdefined(level.deathzones[targetname].wave), "<invalid>" + "<dev string:x179>" + targetname);
    wave = level.var_618a0feb[level.var_618a0feb.size - 1];
    zone = level.deathzones[targetname];
    zone.wave = wave;
    zone.var_1b3850a7 = 0;
    wave.zones[wave.zones.size] = zone;
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x74bc3f12, Offset: 0xa20
// Size: 0xa2
function function_c85dfc2d() {
    if (level.deathzones.size == 0) {
        return;
    }
    foreach (zone in level.var_618a0feb[level.var_618a0feb.size - 1].zones) {
        zone.var_1b3850a7 = 1;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x835c2a57, Offset: 0xad0
// Size: 0x126
function function_de7ae64() {
    level endon(#"game_ended");
    if (!level.var_53022701 || level.var_618a0feb.size <= 0) {
        return;
    }
    level thread function_c0f43b14();
    level thread function_cf210752();
    var_d1f3276c = 0;
    foreach (wave in level.var_618a0feb) {
        waittime = wave.var_31c9afab - var_d1f3276c;
        wait waittime;
        level thread function_c5c146a5(wave);
        var_d1f3276c = wave.var_31c9afab;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x4
// Checksum 0xd13c74dd, Offset: 0xc00
// Size: 0x2c8
function private function_c5c146a5(wave) {
    level endon(#"game_ended");
    wave.shutdowntime = gettime();
    foreach (zone in wave.zones) {
        zone.state = 1;
        function_61cd2208(zone.index, zone.state);
    }
    foreach (zone in wave.zones) {
        if (isfunctionptr(zone.var_ec5fecae)) {
            level thread [[ zone.var_ec5fecae ]](zone, wave);
        }
    }
    level notify(#"hash_eb9b00011f2603");
    wait wave.var_a8c52c76;
    foreach (zone in wave.zones) {
        zone.state = 2;
        function_61cd2208(zone.index, zone.state);
    }
    foreach (zone in wave.zones) {
        if (isfunctionptr(zone.var_566cd0f3)) {
            level thread [[ zone.var_566cd0f3 ]](zone, wave);
        }
    }
    level notify(#"hash_d59a75066c0061c");
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xdbfe4013, Offset: 0xed0
// Size: 0x2d0
function function_e7a695ba() {
    foreach (zone in level.deathzones) {
        zone.open = 0;
        zone.var_1b3850a7 = 0;
    }
    targetnames = getarraykeys(level.deathzones);
    waveindex = level.var_618a0feb.size - 1;
    var_26c3fe76 = level.var_618a0feb[waveindex];
    var_2c55459a = [];
    for (i = 0; i < var_26c3fe76.count; i++) {
        targetnameindex = randomint(targetnames.size);
        targetname = targetnames[targetnameindex];
        arrayremoveindex(targetnames, targetnameindex);
        zone = level.deathzones[targetname];
        zone.open = 1;
        zone.var_1b3850a7 = 1;
        var_2c55459a[i] = zone;
    }
    while (waveindex >= 0 && var_2c55459a.size > 0) {
        for (i = 0; i < var_26c3fe76.count; i++) {
            if (var_2c55459a.size <= 0) {
                function_4b8ab8e6(var_26c3fe76.zones, var_2c55459a);
                if (var_2c55459a.size <= 0) {
                    break;
                }
            }
            zoneindex = randomint(var_2c55459a.size);
            zone = var_2c55459a[zoneindex];
            zone.wave = var_26c3fe76;
            var_26c3fe76.zones[i] = zone;
            arrayremoveindex(var_2c55459a, zoneindex);
        }
        function_4b8ab8e6(var_26c3fe76.zones, var_2c55459a);
        waveindex--;
        var_26c3fe76 = level.var_618a0feb[waveindex];
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x4
// Checksum 0x2896a6f0, Offset: 0x11a8
// Size: 0x90
function private function_4b8ab8e6(zones, &var_2c55459a) {
    foreach (zone in zones) {
        function_64ca7bde(zone.links, var_2c55459a);
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x4
// Checksum 0x70f102d5, Offset: 0x1240
// Size: 0xba
function private function_64ca7bde(zones, &var_2c55459a) {
    foreach (zone in zones) {
        if (isdefined(zone.open) && zone.open) {
            continue;
        }
        var_2c55459a[var_2c55459a.size] = zone;
        zone.open = 1;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x4
// Checksum 0x4691a658, Offset: 0x1308
// Size: 0x308
function private function_c0f43b14() {
    level endon(#"game_ended");
    while (true) {
        time = gettime();
        foreach (player in getplayers()) {
            if (!isalive(player)) {
                player function_19c8c63b();
                continue;
            }
            var_1ec1abe4 = 1;
            foreach (zone in level.deathzones) {
                if (zone.state == 0 || !zone.var_2a569af3 || !player istouching(zone.ent)) {
                    continue;
                }
                if (zone.state == 1) {
                    var_cf4def2a = int(ceil(zone.wave.var_a8c52c76 - (time - zone.wave.shutdowntime) / 1000));
                    player function_19c8c63b();
                    player function_283bb833(1);
                    player function_b39d6747(var_cf4def2a);
                } else {
                    player show_postfx();
                    player function_283bb833(2);
                    player function_b39d6747(0);
                }
                var_1ec1abe4 = 0;
                break;
            }
            if (var_1ec1abe4) {
                player function_283bb833(0);
                player function_19c8c63b();
                player function_d55d7cce();
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x4
// Checksum 0x8008cef8, Offset: 0x1618
// Size: 0x1a8
function private function_cf210752() {
    level endon(#"game_ended");
    while (true) {
        foreach (player in getplayers()) {
            if (!isalive(player)) {
                continue;
            }
            foreach (zone in level.deathzones) {
                if (zone.state != 2 || !zone.dodamage || !player istouching(zone.ent)) {
                    continue;
                }
                player dodamage(level.var_c102797c, zone.ent.origin, zone.ent);
                break;
            }
        }
        wait level.var_c6dde68f;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x0
// Checksum 0xcc42ecfe, Offset: 0x17c8
// Size: 0x14
function function_83af8a0b(zone, wave) {
    
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x0
// Checksum 0xb9dc5524, Offset: 0x17e8
// Size: 0x14
function on_shutdown(zone, wave) {
    
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0xb4c11370, Offset: 0x1808
// Size: 0x74
function function_b39d6747(var_cf4def2a) {
    if (!isdefined(level.deathZoneElem)) {
        return;
    }
    if (!level.deathZoneElem [[ level.var_e6d0a17e ]](self)) {
        level.deathZoneElem [[ level.var_13af540a ]](self, 0);
    }
    level.deathZoneElem [[ level.var_bf65d627 ]](self, var_cf4def2a);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xed5cd68b, Offset: 0x1888
// Size: 0x4c
function function_d55d7cce() {
    if (!isdefined(level.deathZoneElem)) {
        return;
    }
    if (level.deathZoneElem [[ level.var_e6d0a17e ]](self)) {
        level.deathZoneElem [[ level.var_36dfdb0e ]](self);
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xed794535, Offset: 0x18e0
// Size: 0x24
function show_postfx() {
    self clientfield::set_to_player("deathzonepostfx", 1);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xcf90361f, Offset: 0x1910
// Size: 0x24
function function_19c8c63b() {
    self clientfield::set_to_player("deathzonepostfx", 0);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0xef78be1a, Offset: 0x1940
// Size: 0x2c
function function_283bb833(zonestate) {
    self clientfield::set_to_player("deathzonewarningsound", zonestate);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x0
// Checksum 0xade59607, Offset: 0x1978
// Size: 0x246
function function_90de4a3a(width = 10, height = 10) {
    for (x = 0; x < 10; x++) {
        for (y = 0; y < 10; y++) {
            targetname = "zone." + x + "." + y;
            vol = spawn("info_volume", (x * 200, y * 200, 0), 0, 200, 200, 100);
            vol.targetname = targetname;
            init(targetname, &function_83af8a0b, &on_shutdown);
            if (x > 0) {
                var_4db3e032 = "zone." + x - 1 + "." + y;
                link(targetname, var_4db3e032);
            }
            if (y > 0) {
                var_4db3e032 = "zone." + x + "." + y - 1;
                link(targetname, var_4db3e032);
            }
        }
    }
    wavetime = 3;
    for (i = 4; i > 0; i--) {
        for (j = 0; j < 10; j++) {
            function_af1d1f12(i, wavetime, 1.5);
            wavetime += 3;
        }
    }
}

/#

    // Namespace namespace_13b01f59/namespace_13b01f59
    // Params 0, eflags: 0x4
    // Checksum 0xaf871987, Offset: 0x1bc8
    // Size: 0x1b6
    function private devgui_loop() {
        level endon(#"game_ended");
        adddebugcommand("<dev string:x199>");
        adddebugcommand("<dev string:x1b8>");
        adddebugcommand("<dev string:x1e0>");
        adddebugcommand("<dev string:x207>");
        adddebugcommand("<dev string:x24a>");
        adddebugcommand("<dev string:x28d>");
        adddebugcommand("<dev string:x2cc>");
        while (true) {
            wait 0.25;
            dvarstr = getdvarstring(#"hash_5599bbb2e77c55ac", "<dev string:x325>");
            if (dvarstr == "<dev string:x325>") {
                continue;
            }
            setdvar(#"hash_5599bbb2e77c55ac", "<dev string:x325>");
            args = strtok(dvarstr, "<dev string:x326>");
            switch (args[0]) {
            case #"hash_27fd764670268040":
                function_4ab99d06();
                break;
            }
        }
    }

    // Namespace namespace_13b01f59/namespace_13b01f59
    // Params 0, eflags: 0x4
    // Checksum 0x6507afa3, Offset: 0x1d88
    // Size: 0xf6
    function private debug_loop() {
        level endon(#"game_ended");
        while (true) {
            if (getdvarint(#"hash_71a34af8d08bac67", 0)) {
                radius = getdvarint(#"hash_3d7651fdc82b0c35", 10) * 10;
                var_769de915 = getdvarint(#"hash_5638cb4d533fbb7e", -1);
                if (var_769de915 >= 0) {
                    function_f657409c(radius, var_769de915);
                } else {
                    function_ebd10083(radius);
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_13b01f59/namespace_13b01f59
    // Params 0, eflags: 0x4
    // Checksum 0xbb2cd30a, Offset: 0x1e88
    // Size: 0xb4
    function private function_4ab99d06() {
        if (level.deathzones.size == 0) {
            function_90de4a3a();
        }
        foreach (wave in level.var_618a0feb) {
            wave.zones = [];
        }
        function_e7a695ba();
    }

    // Namespace namespace_13b01f59/namespace_13b01f59
    // Params 2, eflags: 0x4
    // Checksum 0x14e60021, Offset: 0x1f48
    // Size: 0x162
    function private function_f657409c(radius, var_769de915) {
        for (i = 0; i < level.var_618a0feb.size; i++) {
            wave = level.var_618a0feb[i];
            foreach (zone in wave.zones) {
                color = (1, 0, 0);
                if (i == var_769de915) {
                    color = (1, 0.5, 0);
                } else if (i > var_769de915) {
                    color = isdefined(zone.var_1b3850a7) && zone.var_1b3850a7 ? (1, 0, 1) : (0, 1, 0);
                }
                function_2782c6e8(zone, zone.ent.targetname, radius, color);
            }
        }
    }

    // Namespace namespace_13b01f59/namespace_13b01f59
    // Params 1, eflags: 0x4
    // Checksum 0xfa2be185, Offset: 0x20b8
    // Size: 0x120
    function private function_ebd10083(radius) {
        foreach (targetname, zone in level.deathzones) {
            color = zone.state == 1 ? (1, 0.5, 0) : (1, 0, 0);
            if (zone.state == 0) {
                color = isdefined(zone.var_1b3850a7) && zone.var_1b3850a7 ? (1, 0, 1) : (0, 1, 0);
            }
            function_2782c6e8(zone, function_15979fa9(targetname), radius, color);
        }
    }

    // Namespace namespace_13b01f59/namespace_13b01f59
    // Params 4, eflags: 0x4
    // Checksum 0x84fac6b2, Offset: 0x21e0
    // Size: 0x228
    function private function_2782c6e8(zone, label, radius, color) {
        if (!isdefined(radius)) {
            radius = 100;
        }
        if (!isdefined(color)) {
            color = (0, 1, 0);
        }
        print3d(zone.ent.origin, label);
        sphere(zone.ent.origin, radius, color);
        foreach (var_8563d934 in zone.links) {
            line(zone.ent.origin, var_8563d934.ent.origin, (1, 0, 1));
        }
        targets = struct::get_array(zone.ent.target, "<dev string:x328>");
        foreach (target in targets) {
            line(zone.ent.origin, target.origin, (0, 0, 1));
            sphere(target.origin, 8, (1, 0, 1));
        }
    }

#/
