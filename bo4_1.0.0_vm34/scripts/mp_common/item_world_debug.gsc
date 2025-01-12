#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\item_world;
#using scripts\mp_common\item_world_util;

#namespace item_world_debug;

// Namespace item_world_debug/item_world_debug
// Params 0, eflags: 0x2
// Checksum 0xe8910454, Offset: 0xa8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"item_world_debug", &__init__, undefined, #"item_world");
}

// Namespace item_world_debug/item_world_debug
// Params 0, eflags: 0x4
// Checksum 0x5abbb772, Offset: 0xf8
// Size: 0xa4
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    /#
        level thread _setup_devgui();
    #/
    /#
        level thread function_8956d025();
    #/
    /#
        level thread function_b4f9fc();
    #/
}

/#

    // Namespace item_world_debug/item_world_debug
    // Params 2, eflags: 0x4
    // Checksum 0x2d4fecd3, Offset: 0x1a8
    // Size: 0xc0
    function private function_1338dea4(xoffset, yoffset) {
        elem = newdebughudelem();
        elem.alignx = "<dev string:x30>";
        elem.horzalign = "<dev string:x30>";
        elem.x = xoffset + 0;
        elem.y = yoffset;
        elem.fontscale = 1;
        elem.color = (1, 1, 1);
        elem.fontstyle3d = "<dev string:x35>";
        return elem;
    }

    // Namespace item_world_debug/item_world_debug
    // Params 2, eflags: 0x4
    // Checksum 0x846f4120, Offset: 0x270
    // Size: 0x326
    function private function_1239587e(typestring, type) {
        tab = "<dev string:x42>";
        return typestring + "<dev string:x53>" + (isdefined(level.var_38f49aaf[type]) ? level.var_38f49aaf[type] : 0) + "<dev string:x5d>" + int((isdefined(level.var_38f49aaf[type]) ? level.var_38f49aaf[type] : 0) / int(max(level.var_ca061808, 1)) * 100) + "<dev string:x60>" + tab + "<dev string:x67>" + (isdefined(level.var_e8a238c0[type]) ? level.var_e8a238c0[type] : 0) + "<dev string:x5d>" + int((isdefined(level.var_e8a238c0[type]) ? level.var_e8a238c0[type] : 0) / int(max(level.var_ec72fe2d, 1)) * 100) + "<dev string:x60>" + tab + "<dev string:x76>" + (isdefined(level.var_8531ea67[type]) ? level.var_8531ea67[type] : 0) + "<dev string:x5d>" + int((isdefined(level.var_8531ea67[type]) ? level.var_8531ea67[type] : 0) / int(max(level.var_c27994fc, 1)) * 100) + "<dev string:x60>" + tab + "<dev string:x86>" + (isdefined(level.var_b4fb55ee[type]) ? level.var_b4fb55ee[type] : 0) + "<dev string:x5d>" + int((isdefined(level.var_b4fb55ee[type]) ? level.var_b4fb55ee[type] : 0) / int(max(level.var_c8f26663, 1)) * 100) + "<dev string:x60>";
    }

    // Namespace item_world_debug/item_world_debug
    // Params 2, eflags: 0x0
    // Checksum 0x73e0190, Offset: 0x5a0
    // Size: 0x158
    function function_785381e8(bundle, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        if (isdefined(bundle) && isdefined(bundle.target)) {
            spawn_points = function_60374d7d(bundle.target);
            foreach (point in spawn_points) {
                if (vectordot(point.origin - getplayers()[0].origin, anglestoforward(getplayers()[0].angles)) > 0) {
                    sphere(point.origin, 32, color);
                }
            }
        }
    }

    // Namespace item_world_debug/item_world_debug
    // Params 0, eflags: 0x4
    // Checksum 0xeb0f7e57, Offset: 0x700
    // Size: 0x84c
    function private function_202106bc() {
        println("<dev string:x97>" + (isdefined(level.var_1ec2e08[#"hash_16e58fdb9ade6618"]) ? level.var_1ec2e08[#"hash_16e58fdb9ade6618"] : 0));
        println("<dev string:xb6>" + (isdefined(level.var_1ec2e08[#"hash_6043ef5b0eecf15d"]) ? level.var_1ec2e08[#"hash_6043ef5b0eecf15d"] : 0));
        println("<dev string:xd0>" + (isdefined(level.var_1ec2e08[#"hash_4f9ea850c89bf9a5"]) ? level.var_1ec2e08[#"hash_4f9ea850c89bf9a5"] : 0));
        println("<dev string:xe8>" + (isdefined(level.var_1ec2e08[#"hash_620616edab904fad"]) ? level.var_1ec2e08[#"hash_620616edab904fad"] : 0));
        println("<dev string:xfe>" + (isdefined(level.var_1ec2e08[#"hash_31bdb1b9b62aa3c"]) ? level.var_1ec2e08[#"hash_31bdb1b9b62aa3c"] : 0));
        println("<dev string:x113>" + (isdefined(level.var_1ec2e08[#"hash_325fedc2bd49554"]) ? level.var_1ec2e08[#"hash_325fedc2bd49554"] : 0));
        println("<dev string:x12b>" + (isdefined(level.var_1ec2e08[#"hash_62911c524fdbb54a"]) ? level.var_1ec2e08[#"hash_62911c524fdbb54a"] : 0));
        println("<dev string:x141>" + (isdefined(level.var_1ec2e08[#"hash_42b6412375d8884e"]) ? level.var_1ec2e08[#"hash_42b6412375d8884e"] : 0));
        println("<dev string:x155>" + (isdefined(level.var_1ec2e08[#"hash_3e438672e58ca46e"]) ? level.var_1ec2e08[#"hash_3e438672e58ca46e"] : 0));
        println("<dev string:x16d>" + (isdefined(level.var_1ec2e08[#"hash_322bc7d5f039522"]) ? level.var_1ec2e08[#"hash_322bc7d5f039522"] : 0));
        println("<dev string:x18b>" + (isdefined(level.var_1ec2e08[#"hash_d04e1b48220aab"]) ? level.var_1ec2e08[#"hash_d04e1b48220aab"] : 0));
        println("<dev string:x1a7>" + (isdefined(level.var_1ec2e08[#"hash_55c22f939ae8c3"]) ? level.var_1ec2e08[#"hash_55c22f939ae8c3"] : 0));
        println("<dev string:x1c9>" + (isdefined(level.var_1ec2e08[#"hash_77f6a34c2a66f1b2"]) ? level.var_1ec2e08[#"hash_77f6a34c2a66f1b2"] : 0));
        println("<dev string:x1e1>" + (isdefined(level.var_1ec2e08[#"hash_8a1b6b2348d943d"]) ? level.var_1ec2e08[#"hash_8a1b6b2348d943d"] : 0));
        println("<dev string:x1fa>" + (isdefined(level.var_1ec2e08[#"hash_44b90f09edb9de07"]) ? level.var_1ec2e08[#"hash_44b90f09edb9de07"] : 0));
        println("<dev string:x20f>" + (isdefined(level.var_1ec2e08[#"items_array"]) ? level.var_1ec2e08[#"items_array"] : 0));
        println("<dev string:x224>" + (isdefined(level.var_1ec2e08[#"hash_3f57f6103196026e"]) ? level.var_1ec2e08[#"hash_3f57f6103196026e"] : 0));
        println("<dev string:x23e>" + (isdefined(level.var_1ec2e08[#"hash_6d9d931a97e62378"]) ? level.var_1ec2e08[#"hash_6d9d931a97e62378"] : 0));
        println("<dev string:x255>" + (isdefined(level.var_1ec2e08[#"hash_18565983e19d3bd6"]) ? level.var_1ec2e08[#"hash_18565983e19d3bd6"] : 0));
        println("<dev string:x26e>" + (isdefined(level.var_1ec2e08[#"hash_5aadb4bb0a015bef"]) ? level.var_1ec2e08[#"hash_5aadb4bb0a015bef"] : 0));
        println("<dev string:x288>" + (isdefined(level.var_1ec2e08[#"hash_772d210a480697e5"]) ? level.var_1ec2e08[#"hash_772d210a480697e5"] : 0));
        println("<dev string:x2a5>" + (isdefined(level.var_1ec2e08[#"hash_288894ed575dba13"]) ? level.var_1ec2e08[#"hash_288894ed575dba13"] : 0));
        println("<dev string:x2be>" + (isdefined(level.var_1ec2e08[#"hash_43097d7d852f38eb"]) ? level.var_1ec2e08[#"hash_43097d7d852f38eb"] : 0));
        println("<dev string:x2dd>" + (isdefined(level.var_1ec2e08[#"hash_28137fc01ea989f"]) ? level.var_1ec2e08[#"hash_28137fc01ea989f"] : 0));
    }

    // Namespace item_world_debug/item_world_debug
    // Params 0, eflags: 0x4
    // Checksum 0x1cab2956, Offset: 0xf58
    // Size: 0xa5c
    function private function_c1ba056() {
        self notify("<invalid>");
        self endon("<invalid>");
        world_items = [];
        var_f9588ab3 = function_60374d7d("<dev string:x305>");
        world_items = arraycombine(world_items, var_f9588ab3, 1, 0);
        var_ef8834b2 = function_60374d7d("<dev string:x313>");
        world_items = arraycombine(world_items, var_ef8834b2, 1, 0);
        var_b18396e0 = function_60374d7d("<dev string:x323>");
        world_items = arraycombine(world_items, var_b18396e0, 1, 0);
        var_de36ec7 = function_60374d7d("<dev string:x32e>");
        world_items = arraycombine(world_items, var_de36ec7, 1, 0);
        var_265b3c94 = function_60374d7d("<dev string:x33e>");
        world_items = arraycombine(world_items, var_265b3c94, 1, 0);
        var_b8633687 = function_60374d7d("<dev string:x34d>");
        world_items = arraycombine(world_items, var_b8633687, 1, 0);
        var_173232f8 = function_60374d7d("<dev string:x360>");
        world_items = arraycombine(world_items, var_173232f8, 1, 0);
        var_e2e44ec6 = function_60374d7d("<dev string:x36d>");
        world_items = arraycombine(world_items, var_e2e44ec6, 1, 0);
        var_a7845159 = function_60374d7d("<dev string:x37c>");
        world_items = arraycombine(world_items, var_a7845159, 1, 0);
        var_71ed533c = function_60374d7d("<dev string:x389>");
        world_items = arraycombine(world_items, var_71ed533c, 1, 0);
        var_f2145ad = function_60374d7d("<dev string:x39a>");
        world_items = arraycombine(world_items, var_f2145ad, 1, 0);
        var_3cbd5dee = function_60374d7d("<dev string:x3a9>");
        world_items = arraycombine(world_items, var_3cbd5dee, 1, 0);
        var_f81032a5 = function_60374d7d("<dev string:x3b5>");
        world_items = arraycombine(world_items, var_f81032a5, 1, 0);
        var_cea188cc = function_60374d7d("<dev string:x3c6>");
        world_items = arraycombine(world_items, var_cea188cc, 1, 0);
        var_923370f1 = function_60374d7d("<dev string:x3d6>");
        world_items = arraycombine(world_items, var_923370f1, 1, 0);
        var_3bcaab5b = function_60374d7d("<dev string:x3ea>");
        world_items = arraycombine(world_items, var_3bcaab5b, 1, 0);
        var_1b799b04 = function_60374d7d("<dev string:x3fa>");
        world_items = arraycombine(world_items, var_1b799b04, 1, 0);
        var_e06f8913 = function_60374d7d("<dev string:x40e>");
        world_items = arraycombine(world_items, var_e06f8913, 1, 0);
        var_6b09e919 = function_60374d7d("<dev string:x41f>");
        world_items = arraycombine(world_items, var_6b09e919, 1, 0);
        var_3187649a = function_60374d7d("<dev string:x42b>");
        world_items = arraycombine(world_items, var_3187649a, 1, 0);
        var_a31249d1 = function_60374d7d("<dev string:x43e>");
        world_items = arraycombine(world_items, var_a31249d1, 1, 0);
        file = openfile("<dev string:x44e>", "<dev string:x46b>");
        if (file == -1) {
            iprintlnbold("<dev string:x471>");
            return;
        }
        println("<dev string:x4c0>");
        fprintln(file, "<dev string:x4f2>" + world_items.size + "<dev string:x509>");
        foreach (item in world_items) {
            var_dedc67ef = item_world::function_33d2057a(item.origin, undefined, 1, 1, -1, 1);
            if (var_dedc67ef.size > 0) {
                type = "<dev string:x516>";
                rarity = "<dev string:x516>";
                if (isdefined(var_dedc67ef[0].itementry) && isdefined(var_dedc67ef[0].itementry.rarity)) {
                    switch (var_dedc67ef[0].itementry.rarity) {
                    case #"common":
                        rarity = "<dev string:x51b>";
                        break;
                    case #"rare":
                        rarity = "<dev string:x522>";
                        break;
                    case #"legendary":
                        rarity = "<dev string:x527>";
                        break;
                    case #"epic":
                        rarity = "<dev string:x531>";
                        break;
                    default:
                        rarity = "<dev string:x516>";
                        break;
                    }
                }
                if (isdefined(var_dedc67ef[0].itementry) && isdefined(var_dedc67ef[0].itementry.itemtype)) {
                    switch (var_dedc67ef[0].itementry.itemtype) {
                    case #"ammo":
                        type = "<dev string:x536>";
                        break;
                    case #"weapon":
                        type = "<dev string:x53b>";
                        break;
                    case #"health":
                        type = "<dev string:x542>";
                        break;
                    case #"armor":
                        type = "<dev string:x549>";
                        break;
                    case #"equipment":
                        type = "<dev string:x54f>";
                        break;
                    case #"backpack":
                        type = "<dev string:x559>";
                        break;
                    case #"generic":
                        type = "<dev string:x562>";
                        break;
                    case #"killstreak":
                        type = "<dev string:x56a>";
                        break;
                    case #"attachment":
                        type = "<dev string:x575>";
                        break;
                    default:
                        type = "<dev string:x516>";
                        break;
                    }
                }
                if (isdefined(var_dedc67ef[0].itementry)) {
                    debug_string = var_dedc67ef[0].itementry.name + "<dev string:x580>" + function_15979fa9(var_dedc67ef[0].targetname) + "<dev string:x580>" + var_dedc67ef[0].origin + "<dev string:x580>" + type + "<dev string:x580>" + rarity;
                    fprintln(file, debug_string);
                    waitframe(1);
                }
            }
        }
        println("<dev string:x582>");
        closefile(file);
    }

    // Namespace item_world_debug/item_world_debug
    // Params 0, eflags: 0x4
    // Checksum 0xeaa1133f, Offset: 0x19c0
    // Size: 0x1b12
    function private function_8956d025() {
        while (true) {
            waitframe(1);
            if (!isdefined(level flagsys::get(#"item_world_initialized"))) {
                continue;
            }
            if (getdvarint(#"hash_4341150bd02e99a1", 0) > 0) {
                xoffset = 20;
                yoffset = 185;
                var_71a4282f = 15;
                var_a61b891 = 10;
                if (!isdefined(level.var_16d46cd2)) {
                    level.var_16d46cd2 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f + var_a61b891;
                }
                if (!isdefined(level.var_e7d78bdc)) {
                    level.var_e7d78bdc = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_c379cf81)) {
                    level.var_c379cf81 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f + var_a61b891;
                }
                if (!isdefined(level.var_1270c20f)) {
                    level.var_1270c20f = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_5d21c295)) {
                    level.var_5d21c295 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_e54fb442)) {
                    level.var_e54fb442 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_3a96a118)) {
                    level.var_3a96a118 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_151870e2)) {
                    level.var_151870e2 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_bcc948c7)) {
                    level.var_bcc948c7 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                if (!isdefined(level.var_61c619fa)) {
                    level.var_61c619fa = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f + var_a61b891;
                }
                if (!isdefined(level.var_34cf2e00)) {
                    level.var_34cf2e00 = function_1338dea4(xoffset, yoffset);
                    yoffset += var_71a4282f;
                }
                tab = "<dev string:x42>";
                level.var_16d46cd2 settext("<dev string:x5b0>" + (isdefined(level.var_e8a238c0[#"blank"]) ? level.var_e8a238c0[#"blank"] : 0) + "<dev string:x5d>" + int((isdefined(level.var_e8a238c0[#"blank"]) ? level.var_e8a238c0[#"blank"] : 0) / int(max(level.var_ec72fe2d, 1) + (isdefined(level.var_e8a238c0[#"blank"]) ? level.var_e8a238c0[#"blank"] : 0)) * 100) + "<dev string:x60>");
                level.var_e7d78bdc settext("<dev string:x5bf>" + level.var_ec72fe2d + (isdefined(level.var_e8a238c0[#"blank"]) ? level.var_e8a238c0[#"blank"] : 0));
                level.var_c379cf81 settext("<dev string:x5d1>" + level.var_ca061808 + tab + tab + "<dev string:x67>" + level.var_ec72fe2d + tab + tab + "<dev string:x76>" + level.var_c27994fc + tab + tab + "<dev string:x5e0>" + level.var_c8f26663);
                level.var_1270c20f settext(function_1239587e("<dev string:x5f6>", "<dev string:x53b>"));
                level.var_5d21c295 settext(function_1239587e("<dev string:x5fd>", "<dev string:x549>"));
                level.var_e54fb442 settext(function_1239587e("<dev string:x603>", "<dev string:x559>"));
                level.var_3a96a118 settext(function_1239587e("<dev string:x60c>", "<dev string:x54f>"));
                level.var_151870e2 settext(function_1239587e("<dev string:x616>", "<dev string:x542>"));
                level.var_bcc948c7 settext(function_1239587e("<dev string:x61d>", "<dev string:x562>"));
                level.var_bcc948c7 settext(function_1239587e("<dev string:x625>", "<dev string:x56a>"));
                level.var_61c619fa settext(function_1239587e("<dev string:x630>", "<dev string:x536>"));
                level.var_34cf2e00 settext("<dev string:x635>" + (isdefined(level.var_4b9cc2c2) ? level.var_4b9cc2c2 : 0));
            } else {
                if (isdefined(level.var_16d46cd2)) {
                    level.var_16d46cd2 destroy();
                }
                if (isdefined(level.var_e7d78bdc)) {
                    level.var_e7d78bdc destroy();
                }
                if (isdefined(level.var_c379cf81)) {
                    level.var_c379cf81 destroy();
                }
                if (isdefined(level.var_1270c20f)) {
                    level.var_1270c20f destroy();
                }
                if (isdefined(level.var_5d21c295)) {
                    level.var_5d21c295 destroy();
                }
                if (isdefined(level.var_e54fb442)) {
                    level.var_e54fb442 destroy();
                }
                if (isdefined(level.var_3a96a118)) {
                    level.var_3a96a118 destroy();
                }
                if (isdefined(level.var_151870e2)) {
                    level.var_151870e2 destroy();
                }
                if (isdefined(level.var_bcc948c7)) {
                    level.var_bcc948c7 destroy();
                }
                if (isdefined(level.var_61c619fa)) {
                    level.var_61c619fa destroy();
                }
                if (isdefined(level.var_34cf2e00)) {
                    level.var_34cf2e00 destroy();
                }
            }
            if (getdvarint(#"hash_66ec171c69a26bfe", 0) > 0) {
                level clientfield::set("<dev string:x646>", 0);
            }
            if (getdvarint(#"hash_cc335a24301e7a1", 0) > 0) {
                if (!level.var_218e2ae8) {
                    level.var_218e2ae8 = 1;
                    level thread function_c1ba056();
                }
            }
            if (getdvarint(#"hash_170b29b9b506feed", 0)) {
                setdvar(#"hash_170b29b9b506feed", 0);
                level thread function_202106bc();
            }
            if (getdvarint(#"hash_cc335a24301e7a1", 0) == 0) {
                level.var_218e2ae8 = 0;
            }
            if (getdvarint(#"hash_3fdd3b60f349d462", 0) > 0) {
                players = getplayers();
                if (players.size <= 0) {
                    continue;
                }
                origin = players[0].origin;
                var_2cd4142c = item_world::function_33d2057a(origin, undefined, 100, 2000);
                foreach (item in var_2cd4142c) {
                    print3d(item.origin + (0, 0, 10), "<dev string:x659>" + item.networkid + "<dev string:x65c>" + item.itementry.name, (1, 0.5, 0), 1, 0.4);
                }
            }
            if (getdvarint(#"hash_326974dd9b8c3414", 0)) {
                itemtype = getdvarint(#"hash_326974dd9b8c3414", 1);
                players = getplayers();
                if (players.size <= 0) {
                    continue;
                }
                origin = players[0].origin;
                if (itemtype == 13) {
                    item_spawn_groups = struct::get_array("<dev string:x65e>", "<dev string:x679>");
                    foreach (group in item_spawn_groups) {
                        switch (group.scriptbundlename) {
                        case #"open_skyscraper_vehicles_atv":
                            function_785381e8(group, (0, 0, 1));
                            break;
                        case #"open_skyscraper_vehicles_cargo_truck":
                            function_785381e8(group, (1, 1, 0));
                            break;
                        case #"open_skyscraper_vehicles_heli":
                            function_785381e8(group, (1, 0, 0));
                            break;
                        case #"open_skyscraper_vehicles_heli_clearing":
                            function_785381e8(group, (1, 0, 0));
                            break;
                        case #"open_skyscraper_vehicles_zodiac":
                            function_785381e8(group, (1, 0.5, 0));
                            break;
                        case #"open_skyscraper_vehicles_zodiac_docks":
                            function_785381e8(group, (1, 0.5, 0));
                            break;
                        case #"open_skyscraper_vehicles_zodiac_nuketown":
                            function_785381e8(group, (1, 0.5, 0));
                            break;
                        case #"hash_746e02555f78cc9f":
                            function_785381e8(group, (1, 0, 1));
                        default:
                            break;
                        }
                    }
                    continue;
                }
                if (itemtype == 14) {
                    vehicles = getvehiclearray();
                    foreach (vehicle in vehicles) {
                        color = (0.75, 0.75, 0.75);
                        radius = 128;
                        var_790cf63d = 4096;
                        if (distancesquared(origin, vehicle.origin) < var_790cf63d * var_790cf63d) {
                            radius = max(distance(origin, vehicle.origin) / var_790cf63d * radius, 1);
                        }
                        if (isdefined(vehicle.scriptvehicletype)) {
                            color = (1, 1, 1);
                            switch (vehicle.scriptvehicletype) {
                            case #"player_atv":
                                color = (0, 1, 1);
                                break;
                            case #"cargo_truck_wz":
                                color = (1, 1, 0);
                                break;
                            case #"zodiac_boat_wz":
                                color = (1, 0.5, 0);
                                break;
                            case #"helicopter_light":
                                color = (1, 0, 1);
                                break;
                            }
                            sphere(vehicle.origin, radius, color);
                        }
                    }
                    continue;
                }
                if (itemtype == 12) {
                    item_spawn_groups = struct::get_array("<dev string:x65e>", "<dev string:x679>");
                    foreach (group in item_spawn_groups) {
                        switch (group.scriptbundlename) {
                        case #"supply_stash_parent":
                            function_785381e8(group, (0, 0, 1));
                            break;
                        case #"zombie_supply_stash_parent":
                            function_785381e8(group, (1, 0.5, 0));
                            break;
                        case #"supply_stash_buoy":
                            function_785381e8(group, (1, 0.5, 0));
                        case #"hash_64a82440c45e0564":
                            function_785381e8(group, (1, 0, 1));
                        case #"health_stash_parent":
                            function_785381e8(group, (0, 1, 0));
                        case #"hash_6ff3b4f8560e57d2":
                            function_785381e8(group, (1, 1, 1));
                        default:
                            break;
                        }
                    }
                    continue;
                }
                var_2cd4142c = item_world::function_33d2057a(origin, undefined, 4000, 30000, -1, 0);
                foreach (item in var_2cd4142c) {
                    if (isdefined(item.itementry) && isdefined(item.itementry.rarity)) {
                        switch (item.itementry.rarity) {
                        case #"common":
                            color = (0, 1, 0);
                            break;
                        case #"rare":
                            color = (0, 0, 1);
                            break;
                        case #"legendary":
                            color = (1, 0, 1);
                            break;
                        case #"epic":
                            color = (1, 0.5, 0);
                            break;
                        default:
                            color = (1, 0, 0);
                            break;
                        }
                    } else {
                        color = (1, 0, 0);
                    }
                    radius = 64;
                    var_790cf63d = 2048;
                    if (distancesquared(origin, item.origin) < var_790cf63d * var_790cf63d) {
                        radius = max(distance(origin, item.origin) / var_790cf63d * radius, 1);
                    }
                    switch (itemtype) {
                    case 1:
                        color = (1, 0, 1);
                        sphere(item.origin, radius, color);
                        break;
                    case 2:
                        if (isdefined(item.itementry)) {
                            sphere(item.origin, radius, color);
                        }
                    case 3:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"ammo") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    case 4:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"weapon") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    case 5:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"health") {
                            if (item.itementry.name == "<dev string:x683>") {
                                sphere(item.origin, radius, (0, 1, 0));
                            } else if (item.itementry.name == "<dev string:x695>") {
                                sphere(item.origin, radius, (0, 0, 1));
                            } else if (item.itementry.name == "<dev string:x6a8>") {
                                sphere(item.origin, radius, (1, 0.5, 0));
                            } else {
                                sphere(item.origin, radius, color);
                            }
                        }
                        break;
                    case 6:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"armor") {
                            if (item.itementry.name == "<dev string:x6ba>") {
                                sphere(item.origin, radius, (0, 1, 0));
                            } else if (item.itementry.name == "<dev string:x6cb>") {
                                sphere(item.origin, radius, (0, 0, 1));
                            } else if (item.itementry.name == "<dev string:x6dd>") {
                                sphere(item.origin, radius, (1, 1, 0));
                            } else {
                                sphere(item.origin, radius, color);
                            }
                        }
                        break;
                    case 7:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"equipment") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    case 8:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"backpack") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    case 9:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"attachment") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    case 10:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"generic") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    case 11:
                        if (isdefined(item.itementry) && item.itementry.itemtype === #"killstreak") {
                            sphere(item.origin, radius, color);
                        }
                        break;
                    }
                }
            }
        }
    }

    // Namespace item_world_debug/item_world_debug
    // Params 0, eflags: 0x4
    // Checksum 0xa3ed1cde, Offset: 0x34e0
    // Size: 0x164
    function private _setup_devgui() {
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x6ee>");
        adddebugcommand("<dev string:x7be>" + mapname + "<dev string:x7cd>");
        adddebugcommand("<dev string:x7ff>");
        adddebugcommand("<dev string:x7be>" + mapname + "<dev string:x841>");
        adddebugcommand("<dev string:x875>" + mapname + "<dev string:x883>");
        adddebugcommand("<dev string:x875>" + mapname + "<dev string:x8c6>");
        adddebugcommand("<dev string:x875>" + mapname + "<dev string:x903>");
        adddebugcommand("<dev string:x875>" + mapname + "<dev string:x941>");
    }

    // Namespace item_world_debug/item_world_debug
    // Params 0, eflags: 0x0
    // Checksum 0xe3980ea6, Offset: 0x3650
    // Size: 0x8e
    function function_b4f9fc() {
        level endon(#"game_ended");
        while (true) {
            r = level waittill(#"devgui_bot");
            switch (r.args[0]) {
            case #"hash_29f59f6b62fdbf94":
                function_ade480b1();
                break;
            }
        }
    }

    // Namespace item_world_debug/item_world_debug
    // Params 0, eflags: 0x0
    // Checksum 0xc37d32d8, Offset: 0x36e8
    // Size: 0x244
    function function_ade480b1() {
        var_8d71006 = [];
        itemcount = function_6a1c8e6f();
        for (i = 0; i < itemcount; i++) {
            item = function_9c3c6ff2(i);
            if (isdefined(item.itementry) && item.itementry.itemtype == "<dev string:x53b>" && item.itementry.weapon.isprimary) {
                array::add(var_8d71006, item_world_util::function_fe2abb62(item.itementry), 0);
            }
        }
        var_8d71006 = array::randomize(var_8d71006);
        if (var_8d71006.size == 0) {
            return;
        }
        players = getplayers();
        var_785efdd5 = 0;
        foreach (player in players) {
            if (isbot(player)) {
                weapon = var_8d71006[var_785efdd5];
                player giveweapon(weapon);
                player givemaxammo(weapon);
                player switchtoweaponimmediate(weapon);
                var_785efdd5++;
                if (var_785efdd5 >= var_8d71006.size) {
                    var_785efdd5 = 0;
                }
            }
        }
    }

#/
