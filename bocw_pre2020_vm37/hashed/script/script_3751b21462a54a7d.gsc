#using script_113dd7f0ea2a1d4f;
#using script_2c5daa95f8fec03c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\item_inventory;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;

#namespace namespace_791d0451;

// Namespace namespace_791d0451/namespace_791d0451
// Params 0, eflags: 0x6
// Checksum 0x6292deed, Offset: 0xc0
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_2d064899850813e2", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0, eflags: 0x1 linked
// Checksum 0xbb61bd47, Offset: 0x118
// Size: 0x38c
function function_70a657d8() {
    level.var_fcb9f1fb = [];
    callback::on_spawned(&on_player_spawn);
    callback::on_item_pickup(&on_item_pickup);
    /#
        level.var_c0f77370 = &function_c0f77370;
    #/
    level.var_c723ac75 = [];
    function_e854b81f(#"talent_juggernog", #"hash_afdc97f440fbcec", #"hash_afdcc7f440fc205", #"hash_afdcb7f440fc052", #"hash_afdc67f440fb7d3", #"hash_afdc57f440fb620");
    function_e854b81f(#"hash_7f98b3dd3cce95aa", #"hash_504b41f717f8931a", #"hash_504b40f717f89167", #"hash_504b3ff717f88fb4", #"hash_504b3ef717f88e01", #"hash_504b3df717f88c4e");
    function_e854b81f(#"hash_5930cf0eb070e35a", #"hash_520b5db0216b778a", #"hash_520b5cb0216b75d7", #"hash_520b5bb0216b7424", #"hash_520b5ab0216b7271", #"hash_520b59b0216b70be");
    function_e854b81f(#"hash_4110e6372aa77f7e", #"hash_4110e6372aa77f7e", #"hash_4110e6372aa77f7e", #"hash_4110e6372aa77f7e", #"hash_4110e6372aa77f7e", #"hash_4110e6372aa77f7e");
    function_e854b81f(#"hash_210097a75bb6c49a", #"hash_1f95b48e4a49df4a", #"hash_1f95b38e4a49dd97", #"hash_1f95b28e4a49dbe4", #"hash_1f95b18e4a49da31", #"hash_1f95b08e4a49d87e");
    function_e854b81f(#"hash_602a1b6107105f07", #"hash_17ccbaee64daa05b", #"hash_17ccbbee64daa20e", #"hash_17ccbcee64daa3c1", #"hash_17ccbdee64daa574", #"hash_17ccbeee64daa727");
    function_e854b81f(#"hash_51b6cc6dbafb7f31", #"hash_79774556f321d921", #"hash_79774256f321d408", #"hash_79774356f321d5bb", #"hash_79774856f321de3a", #"hash_79774956f321dfed");
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x4b0
// Size: 0x4
function postinit() {
    
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x21 linked variadic
// Checksum 0x768577fa, Offset: 0x4c0
// Size: 0xf8
function function_e854b81f(var_24303d72, ...) {
    var_50846129 = [];
    if (!isdefined(var_50846129)) {
        var_50846129 = [];
    } else if (!isarray(var_50846129)) {
        var_50846129 = array(var_50846129);
    }
    var_50846129[var_50846129.size] = var_24303d72;
    for (i = 0; i < vararg.size; i++) {
        if (!isdefined(var_50846129)) {
            var_50846129 = [];
        } else if (!isarray(var_50846129)) {
            var_50846129 = array(var_50846129);
        }
        var_50846129[var_50846129.size] = vararg[i];
    }
    level.var_c723ac75[var_24303d72] = var_50846129;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x1 linked
// Checksum 0x5ff69f64, Offset: 0x5c0
// Size: 0xca
function function_1b16bd84(var_24303d72, tier) {
    var_8c590502 = isdefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;
    if (var_8c590502 > 0) {
        tier = var_8c590502;
    }
    var_50846129 = level.var_c723ac75[var_24303d72];
    if (!isdefined(var_50846129)) {
        return var_24303d72;
    }
    talent = var_50846129[tier];
    if (!isdefined(talent)) {
        return var_24303d72;
    }
    return talent;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x1 linked
// Checksum 0xa53a14d2, Offset: 0x698
// Size: 0x34
function function_1050b262(talent, func) {
    if (isdefined(talent) && isdefined(func)) {
        level.var_fcb9f1fb[talent] = func;
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0x83b8644c, Offset: 0x6d8
// Size: 0xbc
function function_56cedda7(perk) {
    if (!isplayer(self) || !isdefined(self.var_7341f980)) {
        return false;
    }
    foreach (var_7387d8e1 in self.var_7341f980) {
        if (perk == var_7387d8e1) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0xbfdb0f6e, Offset: 0x7a0
// Size: 0x92
function function_12b698fa(statname) {
    var_8c590502 = isdefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;
    if (var_8c590502 > 0) {
        return var_8c590502;
    }
    return self stats::function_6d50f14b(#"hash_1b24e5b336f5ae8d", statname);
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0x973fe530, Offset: 0x840
// Size: 0xc2
function function_b852953c(var_aac3d74d) {
    item_index = getitemindexfromref(var_aac3d74d);
    var_438da649 = function_b143666d(item_index, 5);
    var_40e28ba = var_438da649.var_cd070e56;
    if (!isdefined(var_40e28ba) || var_40e28ba == #"") {
        return var_aac3d74d;
    }
    tier = self function_12b698fa(var_40e28ba);
    return function_1b16bd84(var_aac3d74d, tier);
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x1 linked
// Checksum 0x86c9393f, Offset: 0x910
// Size: 0x610
function function_3fecad82(talent, var_6e2cc6cb = 1) {
    if (!isplayer(self) || !isdefined(self.var_7341f980)) {
        return;
    }
    if (!isdefined(self.var_7341f980)) {
        self.var_7341f980 = [];
    } else if (!isarray(self.var_7341f980)) {
        self.var_7341f980 = array(self.var_7341f980);
    }
    if (!isinarray(self.var_7341f980, talent)) {
        self.var_7341f980[self.var_7341f980.size] = talent;
    }
    if (!isdefined(self.var_cd5d9345)) {
        self.var_cd5d9345 = [];
    } else if (!isarray(self.var_cd5d9345)) {
        self.var_cd5d9345 = array(self.var_cd5d9345);
    }
    if (!isinarray(self.var_cd5d9345, talent)) {
        self.var_cd5d9345[self.var_cd5d9345.size] = talent;
    }
    self item_inventory::function_9f438f15();
    if (isdefined(level.var_fcb9f1fb) && isdefined(level.var_fcb9f1fb[talent])) {
        self [[ level.var_fcb9f1fb[talent] ]]();
    }
    switch (talent) {
    case #"hash_504b41f717f8931a":
    case #"hash_504b3ff717f88fb4":
    case #"hash_504b3ef717f88e01":
    case #"hash_504b3df717f88c4e":
    case #"hash_7f98b3dd3cce95aa":
    case #"hash_504b40f717f89167":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"hash_7f98b3dd3cce95aa");
        }
        break;
    case #"hash_5930cf0eb070e35a":
    case #"hash_520b5bb0216b7424":
    case #"hash_520b5db0216b778a":
    case #"hash_520b5cb0216b75d7":
    case #"hash_520b5ab0216b7271":
    case #"hash_520b59b0216b70be":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"hash_5930cf0eb070e35a");
        }
        break;
    case #"hash_1f95b28e4a49dbe4":
    case #"hash_1f95b38e4a49dd97":
    case #"hash_1f95b48e4a49df4a":
    case #"hash_210097a75bb6c49a":
    case #"hash_1f95b08e4a49d87e":
    case #"hash_1f95b18e4a49da31":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"hash_210097a75bb6c49a");
        }
        break;
    case #"hash_4110e6372aa77f7e":
    case #"hash_4110e6372aa77f7e":
    case #"hash_4110e6372aa77f7e":
    case #"hash_4110e6372aa77f7e":
    case #"hash_4110e6372aa77f7e":
    case #"hash_4110e6372aa77f7e":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"hash_4110e6372aa77f7e");
        }
        break;
    case #"talent_juggernog":
    case #"hash_afdc57f440fb620":
    case #"hash_afdc67f440fb7d3":
    case #"hash_afdc97f440fbcec":
    case #"hash_afdcb7f440fc052":
    case #"hash_afdcc7f440fc205":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"talent_juggernog");
        }
        healthoverlay::function_d2880c8f();
        break;
    case #"hash_17ccbeee64daa727":
    case #"hash_17ccbdee64daa574":
    case #"hash_17ccbcee64daa3c1":
    case #"hash_17ccbbee64daa20e":
    case #"hash_17ccbaee64daa05b":
    case #"hash_602a1b6107105f07":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"hash_602a1b6107105f07");
        }
        break;
    case #"hash_51b6cc6dbafb7f31":
    case #"hash_79774356f321d5bb":
    case #"hash_79774556f321d921":
    case #"hash_79774856f321de3a":
    case #"hash_79774956f321dfed":
    case #"hash_79774256f321d408":
        if (var_6e2cc6cb) {
            self perk_give_bottle_begin(#"hash_51b6cc6dbafb7f31");
        }
        break;
    }
    if (isdefined(level._custom_perks[talent]) && isdefined(level._custom_perks[talent].player_thread_give)) {
        self thread [[ level._custom_perks[talent].player_thread_give ]]();
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0x76ffc100, Offset: 0xf28
// Size: 0x5c
function perk_give_bottle_begin(str_perk) {
    weapon = get_perk_weapon(str_perk);
    self thread gestures::function_f3e2696f(self, weapon, undefined, 2.5, undefined, undefined, undefined);
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0xa232ec36, Offset: 0xf90
// Size: 0x1e2
function get_perk_weapon(str_perk) {
    switch (str_perk) {
    case #"hash_7f98b3dd3cce95aa":
        weapon = getweapon(#"zombie_perk_bottle_revive");
        return weapon;
    case #"hash_5930cf0eb070e35a":
        weapon = getweapon(#"zombie_perk_bottle_sleight");
        return weapon;
    case #"hash_210097a75bb6c49a":
        weapon = getweapon(#"zombie_perk_bottle_deadshot");
        return weapon;
    case #"hash_4110e6372aa77f7e":
        weapon = getweapon(#"hash_4cb1d055c485ebdc");
        return weapon;
    case #"talent_juggernog":
        weapon = getweapon(#"zombie_perk_bottle_jugg");
        return weapon;
    case #"hash_602a1b6107105f07":
        weapon = getweapon(#"zombie_perk_bottle_marathon");
        return weapon;
    case #"hash_51b6cc6dbafb7f31":
        weapon = getweapon(#"zombie_perk_bottle_elemental_pop");
        return weapon;
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0x37d1f62b, Offset: 0x1180
// Size: 0x100
function function_4c1d0e25(perk) {
    if (!isplayer(self) || !isdefined(self.var_7341f980)) {
        return;
    }
    arrayremovevalue(self.var_7341f980, perk);
    arrayremovevalue(self.var_cd5d9345, perk, 0);
    self item_inventory::function_9f438f15();
    self function_f7886822(perk, 0);
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, undefined, undefined, -1);
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 0, eflags: 0x1 linked
// Checksum 0xc83be4be, Offset: 0x1288
// Size: 0x1a
function on_player_spawn() {
    if (!isdefined(self.var_7341f980)) {
        self.var_7341f980 = [];
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 2, eflags: 0x1 linked
// Checksum 0x8aa627ed, Offset: 0x12b0
// Size: 0x34a
function function_f7886822(perk, b_enable = 1) {
    if (isdefined(level.var_31028c5d)) {
        switch (perk) {
        case #"talent_juggernog":
        case #"hash_afdc57f440fb620":
        case #"hash_afdc67f440fb7d3":
        case #"hash_afdc97f440fbcec":
        case #"hash_afdcb7f440fc052":
        case #"hash_afdcc7f440fc205":
            level.var_31028c5d prototype_hud::function_d2fbc8ea(self, b_enable);
            break;
        case #"hash_504b3ef717f88e01":
        case #"hash_504b3ff717f88fb4":
        case #"hash_504b40f717f89167":
        case #"hash_504b41f717f8931a":
        case #"hash_7f98b3dd3cce95aa":
        case #"hash_504b3df717f88c4e":
            level.var_31028c5d prototype_hud::function_e0aca7d1(self, b_enable);
            break;
        case #"hash_520b59b0216b70be":
        case #"hash_520b5ab0216b7271":
        case #"hash_520b5bb0216b7424":
        case #"hash_520b5cb0216b75d7":
        case #"hash_520b5db0216b778a":
        case #"hash_5930cf0eb070e35a":
            level.var_31028c5d prototype_hud::function_63d25b40(self, b_enable);
            break;
        case #"hash_1f95b08e4a49d87e":
        case #"hash_1f95b18e4a49da31":
        case #"hash_1f95b28e4a49dbe4":
        case #"hash_1f95b38e4a49dd97":
        case #"hash_1f95b48e4a49df4a":
        case #"hash_210097a75bb6c49a":
            level.var_31028c5d prototype_hud::function_c8ecaa6e(self, b_enable);
            break;
        case #"hash_17ccbaee64daa05b":
        case #"hash_17ccbbee64daa20e":
        case #"hash_17ccbcee64daa3c1":
        case #"hash_17ccbdee64daa574":
        case #"hash_17ccbeee64daa727":
        case #"hash_602a1b6107105f07":
            level.var_31028c5d prototype_hud::function_aa1a1cab(self, b_enable);
            break;
        case #"hash_79774256f321d408":
        case #"hash_79774356f321d5bb":
        case #"hash_79774556f321d921":
        case #"hash_79774856f321de3a":
        case #"hash_79774956f321dfed":
        case #"hash_51b6cc6dbafb7f31":
            level.var_31028c5d prototype_hud::function_1ae171f(self, b_enable);
            break;
        }
    }
}

// Namespace namespace_791d0451/namespace_791d0451
// Params 1, eflags: 0x1 linked
// Checksum 0xd77ae988, Offset: 0x1608
// Size: 0x2c4
function on_item_pickup(params) {
    item = params.item;
    if (isplayer(self)) {
        if (isdefined(item.var_a6762160)) {
            if (item.var_a6762160.itemtype === #"survival_perk") {
                if (isdefined(item.var_a6762160.talents)) {
                    foreach (talent in item.var_a6762160.talents) {
                        if (isdefined(talent.talent)) {
                            talent = self function_b852953c(talent.talent);
                            function_f7886822(talent);
                            function_3fecad82(talent);
                        }
                    }
                }
                return;
            }
            if (item.var_a6762160.itemtype === #"armor") {
                talent = #"gear_armor";
                switch (self.armortier) {
                case 2:
                    if (function_56cedda7(#"gear_armor")) {
                        function_4c1d0e25(#"gear_armor");
                    }
                    talent = #"hash_7a71dcca83b381ae";
                    break;
                case 3:
                    if (function_56cedda7(#"gear_armor")) {
                        function_4c1d0e25(#"gear_armor");
                    }
                    if (function_56cedda7(#"hash_16cfc7f70dbd8712")) {
                        function_4c1d0e25(#"hash_16cfc7f70dbd8712");
                    }
                    talent = #"hash_39045b0020cc3e00";
                    break;
                }
                function_3fecad82(talent);
            }
        }
    }
}

/#

    // Namespace namespace_791d0451/namespace_791d0451
    // Params 0, eflags: 0x0
    // Checksum 0x58950561, Offset: 0x18d8
    // Size: 0x12cc
    function function_c0f77370() {
        level endon(#"game_ended");
        setdvar(#"hash_24d26fc861b6ec66", "<dev string:x38>");
        setdvar(#"hash_2a5f4e9d8ec20538", "<dev string:x38>");
        adddebugcommand("<dev string:x3c>" + function_9e72a96(#"hash_7f98b3dd3cce95aa") + "<dev string:x8c>");
        adddebugcommand("<dev string:x91>" + function_9e72a96(#"hash_5930cf0eb070e35a") + "<dev string:x8c>");
        adddebugcommand("<dev string:xdb>" + function_9e72a96(#"hash_210097a75bb6c49a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x123>" + function_9e72a96(#"talent_juggernog") + "<dev string:x8c>");
        adddebugcommand("<dev string:x16c>" + function_9e72a96(#"hash_602a1b6107105f07") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1b4>" + function_9e72a96(#"hash_51b6cc6dbafb7f31") + "<dev string:x8c>");
        adddebugcommand("<dev string:x201>" + function_9e72a96(#"hash_7f98b3dd3cce95aa") + "<dev string:x8c>");
        adddebugcommand("<dev string:x251>" + function_9e72a96(#"hash_5930cf0eb070e35a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x29b>" + function_9e72a96(#"hash_210097a75bb6c49a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x2e3>" + function_9e72a96(#"talent_juggernog") + "<dev string:x8c>");
        adddebugcommand("<dev string:x32c>" + function_9e72a96(#"hash_602a1b6107105f07") + "<dev string:x8c>");
        adddebugcommand("<dev string:x374>" + function_9e72a96(#"hash_51b6cc6dbafb7f31") + "<dev string:x8c>");
        adddebugcommand("<dev string:x3c1>" + function_9e72a96(#"hash_504b41f717f8931a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x413>" + function_9e72a96(#"hash_520b5db0216b778a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x45f>" + function_9e72a96(#"hash_1f95b48e4a49df4a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x4a9>" + function_9e72a96(#"hash_afdc97f440fbcec") + "<dev string:x8c>");
        adddebugcommand("<dev string:x4f4>" + function_9e72a96(#"hash_17ccbaee64daa05b") + "<dev string:x8c>");
        adddebugcommand("<dev string:x53e>" + function_9e72a96(#"hash_79774556f321d921") + "<dev string:x8c>");
        adddebugcommand("<dev string:x58d>" + function_9e72a96(#"hash_504b41f717f8931a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x5df>" + function_9e72a96(#"hash_520b5db0216b778a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x62b>" + function_9e72a96(#"hash_1f95b48e4a49df4a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x675>" + function_9e72a96(#"hash_afdc97f440fbcec") + "<dev string:x8c>");
        adddebugcommand("<dev string:x6c0>" + function_9e72a96(#"hash_17ccbaee64daa05b") + "<dev string:x8c>");
        adddebugcommand("<dev string:x70a>" + function_9e72a96(#"hash_79774556f321d921") + "<dev string:x8c>");
        adddebugcommand("<dev string:x759>" + function_9e72a96(#"hash_504b40f717f89167") + "<dev string:x8c>");
        adddebugcommand("<dev string:x7ab>" + function_9e72a96(#"hash_520b5cb0216b75d7") + "<dev string:x8c>");
        adddebugcommand("<dev string:x7f7>" + function_9e72a96(#"hash_1f95b38e4a49dd97") + "<dev string:x8c>");
        adddebugcommand("<dev string:x841>" + function_9e72a96(#"hash_afdcc7f440fc205") + "<dev string:x8c>");
        adddebugcommand("<dev string:x88c>" + function_9e72a96(#"hash_17ccbbee64daa20e") + "<dev string:x8c>");
        adddebugcommand("<dev string:x8d6>" + function_9e72a96(#"hash_79774256f321d408") + "<dev string:x8c>");
        adddebugcommand("<dev string:x925>" + function_9e72a96(#"hash_504b40f717f89167") + "<dev string:x8c>");
        adddebugcommand("<dev string:x977>" + function_9e72a96(#"hash_520b5cb0216b75d7") + "<dev string:x8c>");
        adddebugcommand("<dev string:x9c3>" + function_9e72a96(#"hash_1f95b38e4a49dd97") + "<dev string:x8c>");
        adddebugcommand("<dev string:xa0d>" + function_9e72a96(#"hash_afdcc7f440fc205") + "<dev string:x8c>");
        adddebugcommand("<dev string:xa58>" + function_9e72a96(#"hash_17ccbbee64daa20e") + "<dev string:x8c>");
        adddebugcommand("<dev string:xaa2>" + function_9e72a96(#"hash_79774256f321d408") + "<dev string:x8c>");
        adddebugcommand("<dev string:xaf1>" + function_9e72a96(#"hash_504b3ff717f88fb4") + "<dev string:x8c>");
        adddebugcommand("<dev string:xb43>" + function_9e72a96(#"hash_520b5bb0216b7424") + "<dev string:x8c>");
        adddebugcommand("<dev string:xb8f>" + function_9e72a96(#"hash_1f95b28e4a49dbe4") + "<dev string:x8c>");
        adddebugcommand("<dev string:xbd9>" + function_9e72a96(#"hash_afdcb7f440fc052") + "<dev string:x8c>");
        adddebugcommand("<dev string:xc24>" + function_9e72a96(#"hash_17ccbcee64daa3c1") + "<dev string:x8c>");
        adddebugcommand("<dev string:xc6e>" + function_9e72a96(#"hash_79774356f321d5bb") + "<dev string:x8c>");
        adddebugcommand("<dev string:xcbd>" + function_9e72a96(#"hash_504b3ff717f88fb4") + "<dev string:x8c>");
        adddebugcommand("<dev string:xd0f>" + function_9e72a96(#"hash_520b5bb0216b7424") + "<dev string:x8c>");
        adddebugcommand("<dev string:xd5b>" + function_9e72a96(#"hash_1f95b28e4a49dbe4") + "<dev string:x8c>");
        adddebugcommand("<dev string:xda5>" + function_9e72a96(#"hash_afdcb7f440fc052") + "<dev string:x8c>");
        adddebugcommand("<dev string:xdf0>" + function_9e72a96(#"hash_17ccbcee64daa3c1") + "<dev string:x8c>");
        adddebugcommand("<dev string:xe3a>" + function_9e72a96(#"hash_79774356f321d5bb") + "<dev string:x8c>");
        adddebugcommand("<dev string:xe89>" + function_9e72a96(#"hash_504b3ef717f88e01") + "<dev string:x8c>");
        adddebugcommand("<dev string:xedb>" + function_9e72a96(#"hash_520b5ab0216b7271") + "<dev string:x8c>");
        adddebugcommand("<dev string:xf27>" + function_9e72a96(#"hash_1f95b18e4a49da31") + "<dev string:x8c>");
        adddebugcommand("<dev string:xf71>" + function_9e72a96(#"hash_afdc67f440fb7d3") + "<dev string:x8c>");
        adddebugcommand("<dev string:xfbc>" + function_9e72a96(#"hash_17ccbdee64daa574") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1006>" + function_9e72a96(#"hash_79774856f321de3a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1055>" + function_9e72a96(#"hash_504b3ef717f88e01") + "<dev string:x8c>");
        adddebugcommand("<dev string:x10a7>" + function_9e72a96(#"hash_520b5ab0216b7271") + "<dev string:x8c>");
        adddebugcommand("<dev string:x10f3>" + function_9e72a96(#"hash_1f95b18e4a49da31") + "<dev string:x8c>");
        adddebugcommand("<dev string:x113d>" + function_9e72a96(#"hash_afdc67f440fb7d3") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1188>" + function_9e72a96(#"hash_17ccbdee64daa574") + "<dev string:x8c>");
        adddebugcommand("<dev string:x11d2>" + function_9e72a96(#"hash_79774856f321de3a") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1221>" + function_9e72a96(#"hash_504b3df717f88c4e") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1273>" + function_9e72a96(#"hash_520b59b0216b70be") + "<dev string:x8c>");
        adddebugcommand("<dev string:x12bf>" + function_9e72a96(#"hash_1f95b08e4a49d87e") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1309>" + function_9e72a96(#"hash_afdc57f440fb620") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1354>" + function_9e72a96(#"hash_17ccbeee64daa727") + "<dev string:x8c>");
        adddebugcommand("<dev string:x139e>" + function_9e72a96(#"hash_79774956f321dfed") + "<dev string:x8c>");
        adddebugcommand("<dev string:x13ed>" + function_9e72a96(#"hash_504b3df717f88c4e") + "<dev string:x8c>");
        adddebugcommand("<dev string:x143f>" + function_9e72a96(#"hash_520b59b0216b70be") + "<dev string:x8c>");
        adddebugcommand("<dev string:x148b>" + function_9e72a96(#"hash_1f95b08e4a49d87e") + "<dev string:x8c>");
        adddebugcommand("<dev string:x14d5>" + function_9e72a96(#"hash_afdc57f440fb620") + "<dev string:x8c>");
        adddebugcommand("<dev string:x1520>" + function_9e72a96(#"hash_17ccbeee64daa727") + "<dev string:x8c>");
        adddebugcommand("<dev string:x156a>" + function_9e72a96(#"hash_79774956f321dfed") + "<dev string:x8c>");
        function_cd140ee9(#"hash_24d26fc861b6ec66", &function_1d36527d);
        function_cd140ee9(#"hash_2a5f4e9d8ec20538", &function_1d36527d);
    }

    // Namespace namespace_791d0451/namespace_791d0451
    // Params 1, eflags: 0x0
    // Checksum 0xa24ae461, Offset: 0x2bb0
    // Size: 0x1f4
    function function_1d36527d(params) {
        self notify("<dev string:x15b9>");
        self endon("<dev string:x15b9>");
        waitframe(1);
        foreach (player in getplayers()) {
            if (params.value == "<dev string:x38>") {
                continue;
            }
            if (params.name === #"hash_24d26fc861b6ec66") {
                player function_f7886822(hash(params.value));
                player function_3fecad82(hash(params.value), 0);
                continue;
            }
            player function_f7886822(hash(params.value), 0);
            player function_4c1d0e25(hash(params.value));
        }
        setdvar(#"hash_24d26fc861b6ec66", "<dev string:x38>");
        setdvar(#"hash_2a5f4e9d8ec20538", "<dev string:x38>");
    }

#/
