#using script_24c32478acf44108;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_cf2b4f27;

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 0, eflags: 0x6
// Checksum 0x72ce8089, Offset: 0x1b8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_62a392bb15b68ccd", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 0, eflags: 0x5 linked
// Checksum 0xfdb19ae6, Offset: 0x208
// Size: 0x39c
function private function_70a657d8() {
    clientfield::register("actor", "fx_frost_blast_clientfield", 1, 3, "int");
    clientfield::register("toplayer", "fx_frost_blast_1p_lv1_clientfield", 1, 1, "counter");
    clientfield::register("toplayer", "fx_frost_blast_1p_lv3_clientfield", 1, 1, "counter");
    namespace_1b527536::function_36e0540e(#"frost_blast", 1, 30, #"field_upgrade_frost_blast_item_sr");
    namespace_1b527536::function_36e0540e(#"frost_blast_1", 1, 30, #"field_upgrade_frost_blast_1_item_sr");
    namespace_1b527536::function_36e0540e(#"frost_blast_2", 2, 30, #"field_upgrade_frost_blast_2_item_sr");
    namespace_1b527536::function_36e0540e(#"frost_blast_3", 2, 30, #"field_upgrade_frost_blast_3_item_sr");
    namespace_1b527536::function_36e0540e(#"frost_blast_4", 3, 30, #"field_upgrade_frost_blast_4_item_sr");
    namespace_1b527536::function_36e0540e(#"frost_blast_5", 3, 30, #"field_upgrade_frost_blast_5_item_sr");
    namespace_1b527536::function_dbd391bf(#"frost_blast", &function_d7d09902);
    namespace_1b527536::function_dbd391bf(#"frost_blast_1", &function_de15a58c);
    namespace_1b527536::function_dbd391bf(#"frost_blast_2", &function_3542d3e9);
    namespace_1b527536::function_dbd391bf(#"frost_blast_3", &function_4980fc65);
    namespace_1b527536::function_dbd391bf(#"frost_blast_4", &function_353fd3e7);
    namespace_1b527536::function_dbd391bf(#"frost_blast_5", &function_4959fc1b);
    namespace_9ff9f642::register_slowdown(#"frost_blast", 0.5, 3);
    namespace_9ff9f642::register_slowdown(#"frost_blast_5", 0.1, 5);
    zombie_utility::add_zombie_gib_weapon_callback("frost_blast_5", &no_gib, &no_gib);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0xb7f6b04b, Offset: 0x5b0
// Size: 0xe
function no_gib(*percent) {
    return false;
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0xc33baea1, Offset: 0x5c8
// Size: 0x7b2
function function_6736205c(var_638b775a = 0) {
    self endon(#"death");
    self namespace_1b527536::function_460882e2();
    if (var_638b775a < 3) {
        playfxontag("zm_weapons/fx9_fld_frost_blast_lvl1_3p", self, "j_spine4");
        self clientfield::increment_to_player("fx_frost_blast_1p_lv1_clientfield", 1);
    } else {
        playfxontag("zm_weapons/fx9_fld_frost_blast_lvl3_3p", self, "j_spine4");
        self clientfield::increment_to_player("fx_frost_blast_1p_lv3_clientfield", 1);
    }
    radius = 128;
    duration = 3;
    damage = 100;
    weapon = getweapon(#"frost_blast");
    var_3decbda2 = #"hash_474d6228a83f03b2";
    slowdown = #"frost_blast";
    switch (var_638b775a) {
    case 2:
        weapon = getweapon(#"frost_blast_2");
        var_3decbda2 = #"hash_474d6128a83f01ff";
        break;
    case 3:
        weapon = getweapon(#"frost_blast_3");
        var_3decbda2 = #"hash_474d6028a83f004c";
        radius = 256;
        damage = 200;
        break;
    case 4:
        weapon = getweapon(#"frost_blast_4");
        var_3decbda2 = #"hash_474d5f28a83efe99";
        radius = 256;
        damage = 200;
        break;
    case 5:
        weapon = getweapon(#"frost_blast_5");
        var_3decbda2 = #"hash_474d5e28a83efce6";
        radius = 256;
        damage = 200;
        duration = 5;
        slowdown = #"frost_blast_5";
        break;
    }
    self playsound(var_3decbda2);
    frost_blast_aoe = spawnstruct();
    frost_blast_aoe.origin = self.origin;
    var_15fbba29 = 0;
    while (true) {
        var_6c77565b = getentitiesinradius(frost_blast_aoe.origin, radius, 15);
        foreach (zombie in var_6c77565b) {
            if (isalive(zombie) && zombie.team != #"allies") {
                var_2b1ad45b = 0;
                if (zombie clientfield::get("fx_frost_blast_clientfield") == 0) {
                    zombie dodamage(damage, zombie.origin, self, undefined, undefined, "MOD_GRENADE", 0, weapon);
                    var_2b1ad45b = 1;
                }
                if (var_638b775a == 0) {
                    zombie clientfield::set("fx_frost_blast_clientfield", 1);
                } else {
                    zombie clientfield::set("fx_frost_blast_clientfield", var_638b775a);
                }
                if (!var_2b1ad45b) {
                    self function_93765018(var_638b775a);
                }
                if (var_638b775a >= 3) {
                    if (isdefined(zombie.archetype) && isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), zombie.archetype) || isdefined(zombie.archetype) && isinarray(array(#"stoker", #"gladiator", #"gladiator_marauder", #"gladiator_destroyer", #"werewolf", #"avogadro", #"raz"), zombie.archetype)) {
                        zombie thread namespace_9ff9f642::slowdown(slowdown);
                        if (var_638b775a == 5 && var_2b1ad45b) {
                            zombie damagemode("next_shot_kills");
                        }
                        zombie thread function_e287f5c2(duration, var_638b775a);
                    }
                } else if (isdefined(zombie.archetype) && isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), zombie.archetype)) {
                    zombie thread namespace_9ff9f642::slowdown(slowdown);
                    if (var_638b775a == 5 && var_2b1ad45b) {
                        zombie damagemode("next_shot_kills");
                    }
                    zombie thread function_e287f5c2(duration, var_638b775a);
                }
                waitframe(1);
            }
        }
        if (var_638b775a >= 1 && var_15fbba29 < 15) {
            wait 0.2;
            var_15fbba29++;
            continue;
        }
        return;
    }
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0x382ecbb7, Offset: 0xd88
// Size: 0x24
function function_d7d09902(*params) {
    self thread function_6736205c(0);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0xa9c1d96f, Offset: 0xdb8
// Size: 0x24
function function_de15a58c(*params) {
    self thread function_6736205c(1);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0x672ca065, Offset: 0xde8
// Size: 0x24
function function_3542d3e9(*params) {
    self thread function_6736205c(2);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0x8150f4e, Offset: 0xe18
// Size: 0x24
function function_4980fc65(*params) {
    self thread function_6736205c(3);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0x65dd37a5, Offset: 0xe48
// Size: 0x24
function function_353fd3e7(*params) {
    self thread function_6736205c(4);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0x7f94f48d, Offset: 0xe78
// Size: 0x24
function function_4959fc1b(*params) {
    self thread function_6736205c(5);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 2, eflags: 0x1 linked
// Checksum 0xadbd91a, Offset: 0xea8
// Size: 0xa4
function function_e287f5c2(duration, var_638b775a) {
    self notify(#"frost_blast");
    self endon(#"death", #"frost_blast");
    wait duration;
    self damagemode("normal");
    self clientfield::set("fx_frost_blast_clientfield", 0);
    self function_93765018(var_638b775a);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0xb62e0ae1, Offset: 0xf58
// Size: 0x64
function function_93765018(var_638b775a) {
    if (var_638b775a < 5) {
        self namespace_9ff9f642::function_520f4da5(#"frost_blast");
        return;
    }
    self namespace_9ff9f642::function_520f4da5(#"frost_blast_5");
}

