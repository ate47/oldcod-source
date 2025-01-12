#using script_24c32478acf44108;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_laststand;

#namespace namespace_32e85820;

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x6
// Checksum 0xfd2d54c6, Offset: 0x170
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_36a2cb0be45d9374", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x5 linked
// Checksum 0x98334606, Offset: 0x1c0
// Size: 0x304
function private function_70a657d8() {
    clientfield::register("toplayer", "fx_heal_aoe_player_clientfield", 1, 1, "counter");
    clientfield::register("scriptmover", "fx_heal_aoe_bubble_clientfield", 1, 1, "int");
    clientfield::register("scriptmover", "fx_heal_aoe_bubble_beam_clientfield", 1, 1, "int");
    namespace_1b527536::function_36e0540e(#"hash_7b5a77a85b0ffab7", 1, 60, #"field_upgrade_heal_aoe_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_379869d5b6da974b", 1, 60, #"field_upgrade_heal_aoe_1_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_37986ad5b6da98fe", 1, 60, #"field_upgrade_heal_aoe_2_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_37986bd5b6da9ab1", 1, 60, #"field_upgrade_heal_aoe_3_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_37986cd5b6da9c64", 1, 60, #"field_upgrade_heal_aoe_4_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_37986dd5b6da9e17", 1, 60, #"field_upgrade_heal_aoe_5_item_sr");
    namespace_1b527536::function_dbd391bf(#"hash_7b5a77a85b0ffab7", &function_e190864a);
    namespace_1b527536::function_dbd391bf(#"hash_379869d5b6da974b", &function_1447ebb8);
    namespace_1b527536::function_dbd391bf(#"hash_37986ad5b6da98fe", &function_6ff0a318);
    namespace_1b527536::function_dbd391bf(#"hash_37986bd5b6da9ab1", &function_62280787);
    namespace_1b527536::function_dbd391bf(#"hash_37986cd5b6da9c64", &function_594c75d0);
    namespace_1b527536::function_dbd391bf(#"hash_37986dd5b6da9e17", &function_4a8d5852);
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0x5fc64fa8, Offset: 0x4d0
// Size: 0xa8
function function_f823ab5e() {
    foreach (player in getplayers()) {
        player.health = player.var_66cb03ad;
        player clientfield::increment_to_player("fx_heal_aoe_player_clientfield", 1);
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0x3c55931d, Offset: 0x580
// Size: 0x128
function function_e1dad5f7() {
    foreach (player in getplayers()) {
        if (player == self) {
            player.health = player.var_66cb03ad;
            player clientfield::increment_to_player("fx_heal_aoe_player_clientfield", 1);
            continue;
        }
        if (player laststand::player_is_in_laststand()) {
            player thread zm_laststand::auto_revive(self);
            waitframe(1);
        }
        if (isdefined(player)) {
            player.health = player.var_66cb03ad;
            player clientfield::increment_to_player("fx_heal_aoe_player_clientfield", 1);
        }
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0x353dd760, Offset: 0x6b0
// Size: 0x1ac
function function_451de831() {
    foreach (player in getplayers()) {
        var_6c77565b = getentitiesinradius(player.origin, 128, 15);
        foreach (zombie in var_6c77565b) {
            if (zombie.var_6f84b820 == #"normal") {
                zombie zombie_utility::setup_zombie_knockdown(self);
                continue;
            }
            if (zombie.var_6f84b820 == #"special" || zombie.var_6f84b820 == #"elite") {
                zombie ai::stun(2);
            }
        }
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x0
// Checksum 0x856cef71, Offset: 0x868
// Size: 0x7a
function function_8182a64d() {
    foreach (player in getplayers()) {
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0x429b5aed, Offset: 0x8f0
// Size: 0x3c
function function_e190864a(*params) {
    self namespace_1b527536::function_460882e2();
    self function_f823ab5e();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0x5082a182, Offset: 0x938
// Size: 0x54
function function_1447ebb8(*params) {
    self namespace_1b527536::function_460882e2();
    self function_f823ab5e();
    self thread function_381f09f3();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0x5e59465e, Offset: 0x998
// Size: 0x6c
function function_6ff0a318(*params) {
    self namespace_1b527536::function_460882e2();
    self function_f823ab5e();
    self thread function_381f09f3();
    self function_451de831();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0xff8ade33, Offset: 0xa10
// Size: 0x6c
function function_62280787(*params) {
    self namespace_1b527536::function_460882e2();
    self thread function_e1dad5f7();
    self thread function_381f09f3();
    self function_451de831();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0x14bdeae1, Offset: 0xa88
// Size: 0x10c
function function_594c75d0(*params) {
    self namespace_1b527536::function_460882e2();
    self thread function_e1dad5f7();
    self thread function_381f09f3();
    foreach (player in getplayers()) {
        if (isdefined(player.armor) && isdefined(player.maxarmor)) {
            player.armor = player.maxarmor;
        }
    }
    self function_451de831();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0x9bb1d8a7, Offset: 0xba0
// Size: 0x230
function function_4a8d5852(params) {
    self namespace_1b527536::function_460882e2();
    self endon(#"death");
    self function_594c75d0(params);
    foreach (player in getplayers()) {
        var_bf135e90 = spawn("script_model", player.origin);
        var_6af41078 = spawn("script_model", (player.origin[0], player.origin[1], player.origin[2] + 10));
        var_6af41078.angles = (270, 0, 0);
        var_bf135e90 setmodel("tag_origin");
        var_6af41078 setmodel("tag_origin");
        var_bf135e90 clientfield::set("fx_heal_aoe_bubble_clientfield", 1);
        var_bf135e90.player = player;
        var_bf135e90 thread function_6f2ddf8e();
        var_bf135e90 thread function_93b178ae();
        var_6af41078 clientfield::set("fx_heal_aoe_bubble_beam_clientfield", 1);
        var_6af41078 thread function_93b178ae();
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0xa995d719, Offset: 0xdd8
// Size: 0xbc
function function_381f09f3() {
    self endon(#"death");
    self notify("4af45e1ff5d5e054");
    self endon("4af45e1ff5d5e054");
    count = 0;
    while (count <= 10) {
        currenthealth = self.health;
        regen_amount = 25;
        if (currenthealth + regen_amount > self.var_66cb03ad) {
            regen_amount = self.var_66cb03ad - currenthealth;
        } else {
            self.health += regen_amount;
        }
        count++;
        wait 1;
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 2, eflags: 0x1 linked
// Checksum 0x7ad20263, Offset: 0xea0
// Size: 0xc8
function function_92297dd0(var_c27b1726, *var_c360c10f) {
    foreach (player in getplayers()) {
        if (distance2d(var_c360c10f, player.origin) <= 256) {
            player function_594c75d0();
        }
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0x302c4793, Offset: 0xf70
// Size: 0x4c
function function_93b178ae() {
    level endon(#"game_ended");
    self endon(#"death");
    wait 10;
    self delete();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0x99bf4da0, Offset: 0xfc8
// Size: 0x56
function function_6f2ddf8e() {
    self endon(#"death");
    var_b9403c9 = self.origin;
    while (true) {
        function_92297dd0(var_b9403c9, self.player);
        wait 1;
    }
}

