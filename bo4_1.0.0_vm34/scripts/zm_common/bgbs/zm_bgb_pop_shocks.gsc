#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\trials\zm_trial_headshots_only;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_pop_shocks;

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x2
// Checksum 0x4be9404a, Offset: 0xb8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_pop_shocks", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x0
// Checksum 0x937beafd, Offset: 0x108
// Size: 0xc4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_pop_shocks", "event", &event, undefined, undefined, undefined);
    bgb::register_actor_damage_override(#"zm_bgb_pop_shocks", &actor_damage_override);
    bgb::register_vehicle_damage_override(#"zm_bgb_pop_shocks", &vehicle_damage_override);
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x0
// Checksum 0x2ae1f522, Offset: 0x1d8
// Size: 0x60
function event() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"bgb_update");
    self.var_69d5dd7c = 5;
    while (self.var_69d5dd7c > 0) {
        wait 0.1;
    }
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 12, eflags: 0x0
// Checksum 0x45440567, Offset: 0x240
// Size: 0xa8
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (meansofdeath === "MOD_MELEE" && !zm_trial_headshots_only::is_active()) {
        attacker function_e0e68a99(self);
    }
    return damage;
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 15, eflags: 0x0
// Checksum 0xc2212562, Offset: 0x2f0
// Size: 0xa8
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath === "MOD_MELEE") {
        eattacker function_e0e68a99(self);
    }
    return idamage;
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 1, eflags: 0x0
// Checksum 0x59346f54, Offset: 0x3a0
// Size: 0x1a8
function function_e0e68a99(target) {
    if (isdefined(self.beastmode) && self.beastmode) {
        return;
    }
    self bgb::do_one_shot_use();
    self.var_69d5dd7c -= 1;
    self bgb::set_timer(self.var_69d5dd7c, 5);
    self playsound(#"zmb_bgb_popshocks_impact");
    zombie_list = getaiteamarray(level.zombie_team);
    foreach (ai in zombie_list) {
        if (!isdefined(ai) || !isalive(ai)) {
            continue;
        }
        test_origin = ai getcentroid();
        dist_sq = distancesquared(target.origin, test_origin);
        if (dist_sq < 16384) {
            self thread electrocute_actor(ai);
        }
    }
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 1, eflags: 0x0
// Checksum 0x9f4121d, Offset: 0x550
// Size: 0x13a
function electrocute_actor(ai) {
    self endon(#"disconnect");
    if (!isdefined(ai) || !isalive(ai)) {
        return;
    }
    bhtnactionstartevent(ai, "electrocute");
    ai notify(#"bhtn_action_notify", {#action:"electrocute"});
    if (!isdefined(self.tesla_enemies_hit)) {
        self.tesla_enemies_hit = 1;
    }
    create_lightning_params();
    ai.tesla_death = 0;
    ai thread arc_damage_init(self);
    switch (ai.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        ai thread tesla_death();
        break;
    }
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x0
// Checksum 0x2ffa3ff7, Offset: 0x698
// Size: 0x62
function create_lightning_params() {
    level.zm_bgb_pop_shocks_lightning_params = lightning_chain::create_lightning_chain_params(5);
    level.zm_bgb_pop_shocks_lightning_params.head_gib_chance = 100;
    level.zm_bgb_pop_shocks_lightning_params.network_death_choke = 4;
    level.zm_bgb_pop_shocks_lightning_params.should_kill_enemies = 0;
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 1, eflags: 0x0
// Checksum 0x8d3fb123, Offset: 0x708
// Size: 0x5c
function arc_damage_init(player) {
    player endon(#"disconnect");
    if (self ai::is_stunned()) {
        return;
    }
    self lightning_chain::arc_damage_ent(player, 1, level.zm_bgb_pop_shocks_lightning_params);
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x0
// Checksum 0x3a6b2a99, Offset: 0x770
// Size: 0x64
function tesla_death() {
    self endon(#"death");
    self thread function_862aadab(1);
    wait 2;
    self dodamage(self.health + 1, self.origin);
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 1, eflags: 0x0
// Checksum 0x6c3c9d68, Offset: 0x7e0
// Size: 0x144
function function_862aadab(random_gibs) {
    self waittill(#"death");
    if (isdefined(self) && isactor(self)) {
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibhead(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibleftarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibrightarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::giblegs(self);
        }
    }
}

