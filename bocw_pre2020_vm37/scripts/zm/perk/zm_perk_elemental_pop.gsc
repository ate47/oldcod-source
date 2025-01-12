#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_elemental_pop;

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x6
// Checksum 0x4a5b5dc3, Offset: 0x180
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zm_perk_elemental_pop", &function_70a657d8, undefined, undefined, #"hash_2d064899850813e2");
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x5 linked
// Checksum 0x4ac2531b, Offset: 0x1d0
// Size: 0x14
function private function_70a657d8() {
    function_27473e44();
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x13c85247, Offset: 0x1f0
// Size: 0x18c
function function_27473e44() {
    zm_perks::register_perk_basic_info(#"hash_51b6cc6dbafb7f31", #"perk_elemental_pop", 2000, #"hash_3aca6fccecde9e86", getweapon("zombie_perk_bottle_elemental_pop"), undefined, #"hash_363622d67a410b29");
    zm_perks::register_perk_precache_func(#"hash_51b6cc6dbafb7f31", &precache);
    zm_perks::register_perk_clientfields(#"hash_51b6cc6dbafb7f31", &register_clientfield, &set_clientfield);
    zm_perks::register_perk_machine(#"hash_51b6cc6dbafb7f31", &perk_machine_setup);
    zm_perks::register_perk_host_migration_params(#"hash_51b6cc6dbafb7f31", "vending_elemental_pop", "elemental_pop_light");
    zm_perks::register_perk_damage_override_func(&function_28ef693e);
    zm_perks::register_actor_damage_override(#"hash_51b6cc6dbafb7f31", &function_abddd809);
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x680929b9, Offset: 0x388
// Size: 0xf6
function precache() {
    if (isdefined(level.var_cf57ff63)) {
        [[ level.var_cf57ff63 ]]();
        return;
    }
    level._effect[#"elemental_pop_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    level.machine_assets[#"hash_51b6cc6dbafb7f31"] = spawnstruct();
    level.machine_assets[#"hash_51b6cc6dbafb7f31"].weapon = getweapon("zombie_perk_bottle_elemental_pop");
    level.machine_assets[#"hash_51b6cc6dbafb7f31"].off_model = "p9_sur_elemental_pop";
    level.machine_assets[#"hash_51b6cc6dbafb7f31"].on_model = "p9_sur_elemental_pop";
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x488
// Size: 0x4
function register_clientfield() {
    
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 1, eflags: 0x1 linked
// Checksum 0x49eb618e, Offset: 0x498
// Size: 0xc
function set_clientfield(*state) {
    
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 4, eflags: 0x1 linked
// Checksum 0x6001bdec, Offset: 0x4b0
// Size: 0x9a
function perk_machine_setup(use_trigger, perk_machine, bump_trigger, *collision) {
    perk_machine.script_sound = "mus_perks_elementalpop_jingle";
    perk_machine.script_string = "elemental_perk";
    perk_machine.script_label = "mus_perks_elementalpop_sting";
    perk_machine.target = "vending_elemental_pop";
    bump_trigger.script_string = "elemental_perk";
    bump_trigger.targetname = "vending_elemental_pop";
    if (isdefined(collision)) {
        collision.script_string = "elemental_perk";
    }
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 10, eflags: 0x1 linked
// Checksum 0x84a1e5fc, Offset: 0x558
// Size: 0xc4
function function_28ef693e(*einflictor, *eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (self namespace_e86ffa8::function_cd6787b(1)) {
        switch (psoffsettime) {
        case #"mod_burned":
        case #"mod_electrocuted":
        case #"mod_dot":
            return (shitloc / 2);
        }
    }
    return undefined;
}

// Namespace zm_perk_elemental_pop/zm_perk_elemental_pop
// Params 12, eflags: 0x1 linked
// Checksum 0x76b3bd3f, Offset: 0x628
// Size: 0x352
function function_abddd809(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker)) {
        if (attacker namespace_e86ffa8::function_cd6787b(5)) {
            if (math::cointoss(1) && !is_true(attacker.var_13a70bc8)) {
                attacker.var_13a70bc8 = 1;
                var_43cad97a = damage > self.health;
                str_name = attacker.aat[aat::function_702fb333(weapon)];
                var_5a18b619 = array(#"zm_aat_kill_o_watt", #"zm_aat_brain_decay", #"zm_aat_frostbite", #"zm_aat_plasmatic_burst");
                if (isdefined(str_name)) {
                    var_5980e1ed = zm_aat::function_296cde87(str_name);
                    if (!isdefined(var_5a18b619)) {
                        var_5a18b619 = [];
                    } else if (!isarray(var_5a18b619)) {
                        var_5a18b619 = array(var_5a18b619);
                    }
                    var_5a18b619[var_5a18b619.size] = var_5980e1ed;
                }
                var_3d46284b = getarraykeys(level.var_e44e90d6);
                foreach (aat in var_5a18b619) {
                    arrayremovevalue(var_3d46284b, aat);
                }
                var_1bfeafad = array::random(var_3d46284b);
                attacker.var_2defbefd = 1;
                var_1799ae59 = getweapon(#"hash_46125fd7f3ad4b82");
                attacker.aat[var_1799ae59] = var_1bfeafad;
                aat::aat_response(var_43cad97a, inflictor, attacker, damage, flags, meansofdeath, var_1799ae59, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
                attacker.aat[var_1799ae59] = undefined;
                attacker.var_13a70bc8 = undefined;
            }
        }
    }
    return damage;
}

