#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;

#namespace zm_perk_dying_wish;

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x2
// Checksum 0x73b999dd, Offset: 0x1b8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_dying_wish", &__init__, &__main__, undefined);
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xf1e30e52, Offset: 0x208
// Size: 0x14
function __init__() {
    enable_dying_wish_perk_for_level();
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x228
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xec2ef135, Offset: 0x238
// Size: 0x1ec
function enable_dying_wish_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_berserker", "perk_dying_wish", 4000, #"zombie/perk_dying_wish", getweapon("zombie_perk_bottle_nuke"), getweapon("zombie_perk_totem_dying_wish"), #"zmperksdyingwish");
    zm_perks::register_perk_precache_func(#"specialty_berserker", &function_e3e79172);
    zm_perks::register_perk_clientfields(#"specialty_berserker", &function_2eb737d0, &function_e73aaf69);
    zm_perks::register_perk_machine(#"specialty_berserker", &function_cfb08445, &function_f8e75f45);
    zm_perks::register_perk_host_migration_params(#"specialty_berserker", "p7_zm_vending_nuke", "divetonuke_light");
    zm_perks::register_perk_threads(#"specialty_berserker", &function_6724902d, &function_66450b8b, &reset_cooldown);
    zm_player::function_c78e5a5(&function_73561850);
    zm::register_actor_damage_callback(&function_f34cdc7a);
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x430
// Size: 0x4
function function_f8e75f45() {
    
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x3d291a10, Offset: 0x440
// Size: 0x10e
function function_e3e79172() {
    if (isdefined(level.var_c67be5e6)) {
        [[ level.var_c67be5e6 ]]();
        return;
    }
    level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
    level.machine_assets[#"specialty_berserker"] = spawnstruct();
    level.machine_assets[#"specialty_berserker"].weapon = getweapon("zombie_perk_bottle_nuke");
    level.machine_assets[#"specialty_berserker"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_berserker"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xd2f77393, Offset: 0x558
// Size: 0x74
function function_2eb737d0() {
    clientfield::register("clientuimodel", "hudItems.perks.dying_wish", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_10f459edea6b3eb", 1, 1, "int");
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 1, eflags: 0x0
// Checksum 0x26f01f92, Offset: 0x5d8
// Size: 0x2c
function function_e73aaf69(state) {
    self clientfield::set_player_uimodel("hudItems.perks.dying_wish", state);
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 4, eflags: 0x0
// Checksum 0x63c837db, Offset: 0x610
// Size: 0xb6
function function_cfb08445(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_phd_jingle";
    use_trigger.script_string = "divetonuke_perk";
    use_trigger.script_label = "mus_perks_phd_sting";
    use_trigger.target = "vending_divetonuke";
    perk_machine.script_string = "divetonuke_perk";
    perk_machine.targetname = "vending_divetonuke";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "divetonuke_perk";
    }
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xe8e1107f, Offset: 0x6d0
// Size: 0x32
function function_c67be5e6() {
    level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x10171fa4, Offset: 0x710
// Size: 0x7a
function function_6724902d() {
    self.var_15522e96 = zm_perks::function_ec1dff78(#"specialty_berserker");
    if (!isdefined(self.var_7684df5b)) {
        self.var_7684df5b = 0;
    }
    if (!isdefined(self.var_20f6ea4)) {
        self.var_20f6ea4 = 1;
    }
    if (!isdefined(self.var_18a7d4d4)) {
        self.var_18a7d4d4 = 540;
    }
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 3, eflags: 0x0
// Checksum 0x7d942fb5, Offset: 0x798
// Size: 0x5e
function function_66450b8b(b_pause, str_perk, str_result) {
    self notify(#"specialty_berserker" + "_take");
    self zm_perks::function_2b57e880(self.var_15522e96, 0);
    self.var_15522e96 = undefined;
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 10, eflags: 0x0
// Checksum 0x327f1e07, Offset: 0x800
// Size: 0xbe
function function_73561850(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (self hasperk(#"specialty_berserker")) {
        if (idamage >= self.health && !self.var_7684df5b) {
            self thread function_f36ca068();
            return (self.health - 1);
        }
    }
    return -1;
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x8ab66d95, Offset: 0x8c8
// Size: 0x164
function function_f36ca068() {
    self endon(#"disconnect");
    self val::set(#"dying_wish", "takedamage", 0);
    self.heal.enabled = 0;
    self.var_e99541c5 = 1;
    self clientfield::set("" + #"hash_10f459edea6b3eb", 1);
    level waittilltimeout(10, #"round_reset");
    self val::reset(#"dying_wish", "takedamage");
    self.heal.enabled = 1;
    self.var_e99541c5 = undefined;
    self thread function_dbe0c504(self.var_18a7d4d4);
    self.var_20f6ea4++;
    self.var_18a7d4d4 += 60 * self.var_20f6ea4;
    self clientfield::set("" + #"hash_10f459edea6b3eb", 0);
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 12, eflags: 0x0
// Checksum 0x4e193945, Offset: 0xa38
// Size: 0x23e
function function_f34cdc7a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker) && attacker hasperk(#"specialty_berserker")) {
        if (isdefined(attacker.var_e99541c5) && attacker.var_e99541c5 && meansofdeath === "MOD_MELEE" || attacker hasperk(#"specialty_mod_berserker") && attacker.health <= 50 && meansofdeath === "MOD_MELEE") {
            damage *= 6;
            switch (self.var_29ed62b2) {
            case #"popcorn":
            case #"basic":
                self zombie_utility::gib_random_parts();
                gibserverutils::annihilate(self);
                damage = self.health;
                break;
            case #"heavy":
            case #"miniboss":
            case #"boss":
                damage += 7000;
                break;
            }
            if (attacker hasperk(#"specialty_mod_berserker")) {
                self thread function_62b2e6e2(damage, attacker);
            }
            return damage;
        }
    }
    return -1;
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 2, eflags: 0x0
// Checksum 0x6d9fa9a2, Offset: 0xc80
// Size: 0xd8
function function_62b2e6e2(n_damage, player) {
    a_ai_targets = player getenemiesinradius(self.origin, 75);
    arrayremovevalue(a_ai_targets, self);
    foreach (ai in a_ai_targets) {
        ai dodamage(n_damage, self.origin, player, player);
    }
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 1, eflags: 0x0
// Checksum 0x6c74b399, Offset: 0xd60
// Size: 0x6c
function function_dbe0c504(var_97dca583) {
    self endon(#"hash_ed7c0dc0ca165df", #"disconnect");
    self.var_7684df5b = 1;
    self thread function_4b99f760(var_97dca583);
    wait var_97dca583;
    self thread reset_cooldown();
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 1, eflags: 0x0
// Checksum 0x7d625635, Offset: 0xdd8
// Size: 0x148
function function_4b99f760(var_97dca583) {
    self endon(#"disconnect", #"hash_ed7c0dc0ca165df");
    self.var_811c1cc5 = var_97dca583;
    self zm_perks::function_2b57e880(self.var_15522e96, 1);
    while (true) {
        wait 0.1;
        self.var_811c1cc5 -= 0.1;
        self.var_811c1cc5 = math::clamp(self.var_811c1cc5, 0, var_97dca583);
        n_percentage = 1 - self.var_811c1cc5 / var_97dca583;
        n_percentage = math::clamp(n_percentage, 0.02, var_97dca583);
        if (self hasperk(#"specialty_berserker") && isdefined(self.var_15522e96)) {
            self zm_perks::function_2b57e880(self.var_15522e96, n_percentage);
        }
    }
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x65a3b7b4, Offset: 0xf28
// Size: 0x64
function reset_cooldown() {
    self notify(#"hash_ed7c0dc0ca165df");
    self.var_7684df5b = 0;
    if (self hasperk(#"specialty_berserker")) {
        self zm_perks::function_2b57e880(self.var_15522e96, 0);
    }
}

