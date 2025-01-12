#using script_2c5daa95f8fec03c;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_797fe2e7;

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 0, eflags: 0x6
// Checksum 0x4ab9d1af, Offset: 0x1b8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_607f0336b64df630", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 0, eflags: 0x5 linked
// Checksum 0x4f23b078, Offset: 0x208
// Size: 0x3ac
function private function_70a657d8() {
    clientfield::register("missile", "" + #"hash_36112e7cad541b66", 1, 2, "int");
    clientfield::register("missile", "" + #"hash_2d55ead1309349bc", 1, 2, "int");
    level.var_325da77b = array(getweapon(#"energy_mine_1"), getweapon(#"energy_mine_2"), getweapon(#"energy_mine_3"), getweapon(#"energy_mine_4"), getweapon(#"hash_4ac3fea4add2a2c9"));
    level.var_887c77a4 = "destroyed_armor_zm";
    callback::on_ai_damage(&function_de90aeb0);
    namespace_1b527536::function_36e0540e(#"hash_41adc0ca9daf6e9d", 2, 20, "field_upgrade_energy_mine_item_sr");
    namespace_1b527536::function_36e0540e(#"energy_mine_1", 2, 20, "field_upgrade_energy_mine_1_item_sr");
    namespace_1b527536::function_36e0540e(#"energy_mine_2", 2, 20, "field_upgrade_energy_mine_2_item_sr");
    namespace_1b527536::function_36e0540e(#"energy_mine_3", 2, 20, "field_upgrade_energy_mine_3_item_sr");
    namespace_1b527536::function_36e0540e(#"energy_mine_4", 3, 20, "field_upgrade_energy_mine_4_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_4ac3fea4add2a2c9", 3, 20, "field_upgrade_energy_mine_5_item_sr");
    namespace_1b527536::function_dbd391bf(#"hash_41adc0ca9daf6e9d", &function_a6da15be);
    namespace_1b527536::function_dbd391bf(#"energy_mine_1", &function_a6da15be);
    namespace_1b527536::function_dbd391bf(#"energy_mine_2", &function_a6da15be);
    namespace_1b527536::function_dbd391bf(#"energy_mine_3", &function_a6da15be);
    namespace_1b527536::function_dbd391bf(#"energy_mine_4", &function_a6da15be);
    namespace_1b527536::function_dbd391bf(#"hash_4ac3fea4add2a2c9", &function_a6da15be);
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 1, eflags: 0x1 linked
// Checksum 0x240045c1, Offset: 0x5c0
// Size: 0x3da
function function_a6da15be(params) {
    self namespace_1b527536::function_460882e2();
    weapon = params.weapon;
    e_mine = params.projectile;
    var_289fc5e6 = 0;
    var_f61738a0 = 0;
    b_stun = 0;
    var_f224b687 = 0;
    var_29030410 = 1;
    var_79e920ac = 1;
    switch (weapon.name) {
    case #"hash_41adc0ca9daf6e9d":
    case #"energy_mine_1":
        var_289fc5e6 = 1;
        var_f61738a0 = 0;
        b_stun = 0;
        var_f224b687 = 1;
        break;
    case #"energy_mine_2":
        var_289fc5e6 = 1;
        var_f61738a0 = 0;
        b_stun = 0;
        var_f224b687 = 1;
        var_29030410 = 2;
        var_79e920ac = 2;
        break;
    case #"energy_mine_3":
        var_289fc5e6 = 1;
        var_f61738a0 = 1;
        b_stun = 0;
        var_f224b687 = 2;
        var_29030410 = 2;
        var_79e920ac = 2;
        break;
    case #"energy_mine_4":
        var_289fc5e6 = 1;
        var_f61738a0 = 1;
        b_stun = 0;
        var_f224b687 = 2;
        var_29030410 = 2;
        var_79e920ac = 2;
        break;
    case #"hash_4ac3fea4add2a2c9":
        var_289fc5e6 = 1;
        var_f61738a0 = 1;
        b_stun = 1;
        var_f224b687 = 3;
        var_29030410 = 3;
        var_79e920ac = 3;
        break;
    }
    v_origin = e_mine.origin;
    e_mine function_1e6559d5(var_29030410);
    e_mine function_a24e7103(self, 100);
    if (isdefined(e_mine)) {
        e_mine notify(#"hash_6aba376e9b4ede6f");
        e_mine clientfield::set("" + #"hash_36112e7cad541b66", 0);
        e_mine clientfield::set("" + #"hash_2d55ead1309349bc", var_79e920ac);
        v_origin = e_mine.origin;
    }
    wait 0.6;
    if (isdefined(e_mine)) {
        e_mine detonate(self);
    }
    for (i = 0; i < var_f224b687; i++) {
        if (i >= 1) {
            e_mine = self magicgrenadeplayer(getweapon(#"hash_7e4053e6965bafa7"), v_origin, (0, 0, 0));
            e_mine detonate(self);
        }
        a_ai_targets = function_3655d156(self, weapon.explosionradius, v_origin);
        self thread function_71efd0e6(a_ai_targets, v_origin, var_289fc5e6, var_f61738a0, b_stun);
        wait 1;
    }
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 5, eflags: 0x5 linked
// Checksum 0xab3124d1, Offset: 0x9a8
// Size: 0x26e
function private function_71efd0e6(a_ai_targets, v_origin, var_289fc5e6 = 0, var_f61738a0 = 0, b_stun = 0) {
    foreach (ai in a_ai_targets) {
        if (!isalive(ai)) {
            continue;
        }
        if (var_289fc5e6) {
        }
        if (var_f61738a0 && isdefined(ai.archetype) && isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), ai.archetype)) {
            ai zombie_utility::setup_zombie_knockdown(v_origin);
        }
        if (b_stun && isdefined(ai.archetype) && isinarray(array(#"stoker", #"gladiator", #"gladiator_marauder", #"gladiator_destroyer", #"werewolf", #"avogadro", #"raz"), ai.archetype)) {
            ai ai::clear_stun();
            ai ai::stun();
        }
        waitframe(1);
    }
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 1, eflags: 0x5 linked
// Checksum 0xd928e5f7, Offset: 0xc20
// Size: 0x6c
function private function_1e6559d5(var_29030410) {
    self endon(#"death", #"hash_6aba376e9b4ede6f");
    self util::waittillnotmoving();
    self clientfield::set("" + #"hash_36112e7cad541b66", var_29030410);
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 2, eflags: 0x5 linked
// Checksum 0x5aeeddcd, Offset: 0xc98
// Size: 0x74
function private function_a24e7103(e_player, n_radius) {
    self endon(#"death");
    while (true) {
        a_ai_targets = self function_3655d156(e_player, n_radius, self.origin);
        if (a_ai_targets.size) {
            return;
        }
        waitframe(1);
    }
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 3, eflags: 0x5 linked
// Checksum 0x697bcc75, Offset: 0xd18
// Size: 0x8a
function private function_3655d156(e_player, n_radius, v_origin) {
    if (isdefined(e_player)) {
        a_ai_targets = e_player getenemiesinradius(v_origin, n_radius);
    } else {
        a_ai_targets = getaiteamarray(level.zombie_team);
    }
    a_ai_targets = arraysortclosest(a_ai_targets, v_origin, undefined, 0, n_radius);
    return a_ai_targets;
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 1, eflags: 0x5 linked
// Checksum 0x9e88c9d3, Offset: 0xdb0
// Size: 0x6c
function private function_de90aeb0(params) {
    if (isplayer(params.eattacker) && isinarray(level.var_325da77b, params.weapon)) {
        namespace_81245006::function_76e239dc(self, params.eattacker);
    }
}

