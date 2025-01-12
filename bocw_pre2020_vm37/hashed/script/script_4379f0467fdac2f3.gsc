#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_4d214d02;

// Namespace namespace_4d214d02/namespace_4d214d02
// Params 0, eflags: 0x6
// Checksum 0xc7351703, Offset: 0x80
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_30f3aa1706b7cb3d", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_4d214d02/namespace_4d214d02
// Params 0, eflags: 0x5 linked
// Checksum 0xd454273, Offset: 0xd8
// Size: 0x3c
function private function_70a657d8() {
    /#
        level thread init_devgui();
        callback::on_spawned(&function_7a47eaf);
    #/
}

// Namespace namespace_4d214d02/namespace_4d214d02
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x120
// Size: 0x4
function private postinit() {
    
}

/#

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0x3d0ea026, Offset: 0x130
    // Size: 0x1ac
    function init_devgui() {
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        mapname = util::get_map_name();
        level.var_66e8da6c = 0;
        level.var_d1bab1c8 = 0;
        level.var_3330d3fd = 0;
        level.var_dd510bee = 0;
        level.var_78c9a347 = 0;
        level.var_1ec0ef7b = 0;
        level.var_7a47eaf = "<dev string:x38>";
        adddebugcommand("<dev string:x40>" + mapname + "<dev string:x51>");
        adddebugcommand("<dev string:x40>" + mapname + "<dev string:xa5>");
        adddebugcommand("<dev string:x40>" + mapname + "<dev string:xed>");
        adddebugcommand("<dev string:x40>" + mapname + "<dev string:x133>");
        adddebugcommand("<dev string:x40>" + mapname + "<dev string:x17b>");
        adddebugcommand("<dev string:x40>" + mapname + "<dev string:x1c7>");
        level thread function_dd927421();
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0x38e645bf, Offset: 0x2e8
    // Size: 0x24
    function function_7a47eaf() {
        level.var_7a47eaf = self getcharacterbodytype();
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0x1deba14a, Offset: 0x318
    // Size: 0x2ce
    function function_dd927421() {
        level endon(#"game_ended");
        while (true) {
            var_7233ec1c = getdvarint(#"hash_53f36d1041d6911e", 0);
            var_cdaf835a = getdvarint(#"hash_7dba628e0e8b12f0", 0);
            var_a2313ba3 = getdvarint(#"hash_5fc452ea14251cdf", 0);
            var_486abc42 = getdvarint(#"hash_66a893ef035aec0c", 0);
            var_4df84b05 = getdvarint(#"hash_2f6539fb6a3cba3b", 0);
            var_84b18de6 = getdvarint(#"hash_48c67550105879a9", 0);
            if (var_7233ec1c) {
                setdvar(#"hash_53f36d1041d6911e", 0);
                level function_f178ffde();
            }
            if (var_cdaf835a) {
                setdvar(#"hash_7dba628e0e8b12f0", 0);
                level function_35b5321c();
            }
            if (var_a2313ba3) {
                setdvar(#"hash_5fc452ea14251cdf", 0);
                level function_1e1d709d();
            }
            if (var_486abc42) {
                setdvar(#"hash_66a893ef035aec0c", 0);
                level function_336aa1d5();
            }
            if (var_4df84b05) {
                setdvar(#"hash_2f6539fb6a3cba3b", 0);
                level function_3ce8783f();
            }
            if (var_84b18de6) {
                setdvar(#"hash_48c67550105879a9", 0);
                level function_29a9ed35();
            }
            waitframe(1);
        }
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0xf9d667dc, Offset: 0x5f0
    // Size: 0xf4
    function reset_player() {
        players = getplayers();
        player = players[0];
        player takeallweapons();
        weapon = getweapon(#"bare_hands");
        player giveweapon(weapon);
        player switchtoweapon(weapon, 1);
        player setclientthirdperson(0);
        player setcharacterbodytype(level.var_7a47eaf);
        player setcharacteroutfit(0);
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0x7228980e, Offset: 0x6f0
    // Size: 0x408
    function function_f178ffde() {
        if (level.var_d1bab1c8 || level.var_dd510bee || level.var_3330d3fd) {
            level.var_d1bab1c8 = 0;
            level.var_dd510bee = 0;
            level.var_3330d3fd = 0;
            reset_player();
            waitframe(1);
        }
        if (level.var_1ec0ef7b) {
            if (isdefined(level.var_31adc03)) {
                level.var_1ec0ef7b = 0;
                level.var_31adc03 delete();
            }
        }
        if (level.var_78c9a347) {
            if (isdefined(level.var_6de2049b)) {
                level.var_78c9a347 = 0;
                level.var_6de2049b delete();
            }
        }
        if (!level.var_66e8da6c) {
            level.var_66e8da6c = 1;
            bodies = getallcharacterbodies(3);
            body_name = "<dev string:x38>";
            bodytype = "<dev string:x38>";
            foreach (playerbodytype in bodies) {
                body_name = dev::function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, 3))) + "<dev string:x20f>" + function_9e72a96(getcharacterassetname(playerbodytype, 3));
                if (body_name === "<dev string:x214>") {
                    bodytype = playerbodytype;
                    break;
                }
            }
            players = getplayers();
            player = players[0];
            player setclientthirdperson(1);
            setdvar(#"cg_thirdpersonmode", 0);
            setdvar(#"cg_thirdpersonsideoffset", -36);
            setdvar(#"cg_thirdpersonupoffset", 30);
            setdvar(#"cg_thirdpersonrange", 70);
            setdvar(#"ik_enable", 0);
            weapon = getweapon(#"hash_5b921175aa6e9c98");
            player giveweapon(weapon);
            player switchtoweapon(weapon, 1);
            player setcharacterbodytype(bodytype);
            player setcharacteroutfit(0);
            return;
        }
        reset_player();
        level.var_66e8da6c = 0;
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0xe9058dea, Offset: 0xb00
    // Size: 0x3e8
    function function_35b5321c() {
        if (level.var_66e8da6c || level.var_dd510bee) {
            level.var_66e8da6c = 0;
            level.var_dd510bee = 0;
            reset_player();
            waitframe(1);
        }
        if (level.var_1ec0ef7b) {
            if (isdefined(level.var_31adc03)) {
                level.var_1ec0ef7b = 0;
                level.var_31adc03 delete();
            }
        }
        if (level.var_78c9a347) {
            if (isdefined(level.var_6de2049b)) {
                level.var_78c9a347 = 0;
                level.var_6de2049b delete();
            }
        }
        if (!level.var_d1bab1c8) {
            level.var_d1bab1c8 = 1;
            bodies = getallcharacterbodies(3);
            body_name = "<dev string:x38>";
            bodytype = "<dev string:x38>";
            foreach (playerbodytype in bodies) {
                body_name = dev::function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, 3))) + "<dev string:x20f>" + function_9e72a96(getcharacterassetname(playerbodytype, 3));
                if (body_name === "<dev string:x241>") {
                    bodytype = playerbodytype;
                    break;
                }
            }
            players = getplayers();
            player = players[0];
            player setclientthirdperson(1);
            setdvar(#"cg_thirdpersonmode", 0);
            setdvar(#"cg_thirdpersonsideoffset", -20);
            setdvar(#"cg_thirdpersonupoffset", 8.7);
            setdvar(#"cg_thirdpersonrange", 77.5);
            setdvar(#"ik_enable", 0);
            weapon = getweapon(#"hash_214037a3a08cdfb6");
            player giveweapon(weapon);
            player switchtoweapon(weapon, 1);
            player setcharacterbodytype(bodytype);
            player setcharacteroutfit(0);
            return;
        }
        reset_player();
        level.var_d1bab1c8 = 0;
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0xc6c820ef, Offset: 0xef0
    // Size: 0x408
    function function_1e1d709d() {
        if (level.var_66e8da6c || level.var_dd510bee || level.var_d1bab1c8) {
            level.var_66e8da6c = 0;
            level.var_dd510bee = 0;
            level.var_d1bab1c8 = 0;
            reset_player();
            waitframe(1);
        }
        if (level.var_1ec0ef7b) {
            if (isdefined(level.var_31adc03)) {
                level.var_1ec0ef7b = 0;
                level.var_31adc03 delete();
            }
        }
        if (level.var_78c9a347) {
            if (isdefined(level.var_6de2049b)) {
                level.var_78c9a347 = 0;
                level.var_6de2049b delete();
            }
        }
        if (!level.var_3330d3fd) {
            level.var_3330d3fd = 1;
            bodies = getallcharacterbodies(3);
            body_name = "<dev string:x38>";
            bodytype = "<dev string:x38>";
            foreach (playerbodytype in bodies) {
                body_name = dev::function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, 3))) + "<dev string:x20f>" + function_9e72a96(getcharacterassetname(playerbodytype, 3));
                if (body_name === "<dev string:x269>") {
                    bodytype = playerbodytype;
                    break;
                }
            }
            players = getplayers();
            player = players[0];
            player setclientthirdperson(1);
            setdvar(#"cg_thirdpersonmode", 0);
            setdvar(#"cg_thirdpersonsideoffset", -40);
            setdvar(#"cg_thirdpersonupoffset", 17);
            setdvar(#"cg_thirdpersonrange", 90);
            setdvar(#"ik_enable", 0);
            weapon = getweapon(#"hash_535cdab5f8357e8f");
            player giveweapon(weapon);
            player switchtoweapon(weapon, 1);
            player setcharacterbodytype(bodytype);
            player setcharacteroutfit(0);
            return;
        }
        reset_player();
        level.var_3330d3fd = 0;
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0x3ae035a8, Offset: 0x1300
    // Size: 0x408
    function function_336aa1d5() {
        if (level.var_66e8da6c || level.var_d1bab1c8 || level.var_3330d3fd) {
            level.var_66e8da6c = 0;
            level.var_d1bab1c8 = 0;
            level.var_3330d3fd = 0;
            reset_player();
            waitframe(1);
        }
        if (level.var_1ec0ef7b) {
            if (isdefined(level.var_31adc03)) {
                level.var_1ec0ef7b = 0;
                level.var_31adc03 delete();
            }
        }
        if (level.var_78c9a347) {
            if (isdefined(level.var_6de2049b)) {
                level.var_78c9a347 = 0;
                level.var_6de2049b delete();
            }
        }
        if (!level.var_dd510bee) {
            level.var_dd510bee = 1;
            bodies = getallcharacterbodies(3);
            body_name = "<dev string:x38>";
            bodytype = "<dev string:x38>";
            foreach (playerbodytype in bodies) {
                body_name = dev::function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, 3))) + "<dev string:x20f>" + function_9e72a96(getcharacterassetname(playerbodytype, 3));
                if (body_name === "<dev string:x290>") {
                    bodytype = playerbodytype;
                    break;
                }
            }
            players = getplayers();
            player = players[0];
            player setclientthirdperson(1);
            setdvar(#"cg_thirdpersonmode", 0);
            setdvar(#"cg_thirdpersonsideoffset", -8.45);
            setdvar(#"cg_thirdpersonupoffset", 2.5);
            setdvar(#"cg_thirdpersonrange", 65);
            setdvar(#"ik_enable", 0);
            weapon = getweapon(#"hash_7d1de502c879c4b9");
            player giveweapon(weapon);
            player switchtoweapon(weapon, 1);
            player setcharacterbodytype(bodytype);
            player setcharacteroutfit(0);
            return;
        }
        reset_player();
        level.var_dd510bee = 0;
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0xbaaf8b9c, Offset: 0x1710
    // Size: 0x1a4
    function function_3ce8783f() {
        if (level.var_1ec0ef7b) {
            if (isdefined(level.var_31adc03)) {
                level.var_1ec0ef7b = 0;
                level.var_31adc03 delete();
            }
            waitframe(1);
        }
        if (!level.var_78c9a347) {
            level.var_78c9a347 = 1;
            spawner = getent("<dev string:x2b8>", "<dev string:x2c4>");
            assert(isdefined(spawner), "<dev string:x2d2>");
            player = getplayers()[0];
            if (isdefined(player) && isdefined(spawner)) {
                parasite = spawner spawnfromspawner("<dev string:x2f0>", 1);
                if (isdefined(parasite)) {
                    level.var_6de2049b = parasite;
                    parasite makeusable();
                    parasite usevehicle(player, 0);
                }
            }
            return;
        }
        if (isdefined(level.var_6de2049b)) {
            level.var_78c9a347 = 0;
            level.var_6de2049b delete();
            reset_player();
        }
    }

    // Namespace namespace_4d214d02/namespace_4d214d02
    // Params 0, eflags: 0x0
    // Checksum 0x1e0b8c15, Offset: 0x18c0
    // Size: 0x184
    function function_29a9ed35() {
        if (level.var_78c9a347) {
            if (isdefined(level.var_6de2049b)) {
                level.var_78c9a347 = 0;
                level.var_6de2049b delete();
            }
            waitframe(1);
        }
        if (!level.var_1ec0ef7b) {
            level.var_1ec0ef7b = 1;
            spawner = getent("<dev string:x305>", "<dev string:x2c4>");
            player = getplayers()[0];
            if (isdefined(player) && isdefined(spawner)) {
                var_7c2c3cda = spawner spawnfromspawner("<dev string:x30f>", 1);
                if (isdefined(var_7c2c3cda)) {
                    level.var_31adc03 = var_7c2c3cda;
                    var_7c2c3cda makeusable();
                    var_7c2c3cda usevehicle(player, 0);
                }
            }
            return;
        }
        if (isdefined(level.var_31adc03)) {
            level.var_1ec0ef7b = 0;
            level.var_31adc03 delete();
            reset_player();
        }
    }

#/
