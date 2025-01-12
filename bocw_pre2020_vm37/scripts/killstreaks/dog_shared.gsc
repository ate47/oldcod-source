#using script_4721de209091b1a6;
#using scripts\abilities\ability_player;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\ai\dog;
#using scripts\killstreaks\ai\escort;
#using scripts\killstreaks\ai\leave;
#using scripts\killstreaks\ai\patrol;
#using scripts\killstreaks\ai\state;
#using scripts\killstreaks\ai\tracking;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace dog;

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xf4bd0e12, Offset: 0x200
// Size: 0xcc
function init_shared() {
    if (!isdefined(level.dog_shared)) {
        level.dog_shared = {};
        archetypempdog::init();
        clientfield::register_clientuimodel("hudItems.dogState", 1, 2, "int");
        clientfield::register("actor", "dogState", 1, 1, "int");
        ability_player::function_92292af6(34, undefined, &deployed_off);
        level thread function_8d543b98();
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x6a07f761, Offset: 0x2d8
// Size: 0xe8
function function_8d543b98() {
    level waittill(#"game_ended");
    corpses = getcorpsearray();
    foreach (corpse in corpses) {
        if (isactorcorpse(corpse) && corpse.archetype === #"mp_dog") {
            corpse delete();
        }
    }
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0x5a314eb6, Offset: 0x3c8
// Size: 0xbe
function deployed_off(slot, *weapon) {
    self gadgetpowerset(weapon, 0);
    if (isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self._gadgets_player[weapon]) && isdefined(self.pers[#"held_gadgets_power"][self._gadgets_player[weapon]])) {
        self.pers[#"held_gadgets_power"][self._gadgets_player[weapon]] = 0;
    }
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x80243160, Offset: 0x490
// Size: 0x2f8
function spawned(type) {
    assert(isplayer(self));
    playsoundatposition(#"hash_7245f25f5953631c", self.origin);
    player = self;
    bundle = killstreaks::get_script_bundle(type);
    if (player isplayerswimming()) {
        if (isdefined(bundle)) {
            player thread battlechatter::function_916b4c72(bundle.ksweapon);
        }
        if (isdefined(bundle.var_502a0e23)) {
            player iprintlnbold(bundle.var_502a0e23);
        }
        return false;
    }
    if (!player killstreakrules::iskillstreakallowed(type, player.team)) {
        if (isdefined(bundle)) {
            player thread battlechatter::function_916b4c72(bundle.ksweapon);
        }
        return false;
    }
    spawn = function_fb11cc0f(player);
    if (!isdefined(spawn)) {
        if (isdefined(bundle)) {
            player thread battlechatter::function_916b4c72(bundle.ksweapon);
        }
        return false;
    }
    player tracking::track(2);
    level thread popups::displaykillstreakteammessagetoall(type, self);
    killstreak_id = player killstreakrules::killstreakstart(type, player.team);
    if (killstreak_id == -1) {
        return false;
    }
    dog = spawn_dog(bundle, player, spawn);
    if (!isdefined(dog)) {
        if (isdefined(bundle)) {
            player thread battlechatter::function_916b4c72(bundle.ksweapon);
        }
        return false;
    }
    dog.hardpointtype = type;
    dog.killstreak_id = killstreak_id;
    dog killstreak_bundles::spawned(bundle);
    dog influencers::create_entity_enemy_influencer("dog", player.team);
    ability_player::function_c22f319e(bundle.ksweapon);
    dog clientfield::set("enemyvehicle", 1);
    return true;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xd501b2b2, Offset: 0x790
// Size: 0xdc
function function_a38d2d73(tacpoint) {
    players = getplayers();
    foreach (player in players) {
        if (distancesquared(tacpoint.origin, player.origin) <= function_a3f6cdac(150)) {
            return true;
        }
    }
    return false;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xa0bb5b36, Offset: 0x878
// Size: 0xba
function function_4670789f(tacpoint) {
    players = getplayers();
    foreach (player in players) {
        if (function_96c81b85(tacpoint, player.origin)) {
            return true;
        }
    }
    return false;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0xb3bd553d, Offset: 0x940
// Size: 0x10c
function private function_9cb166cd(tacpoints) {
    assert(isdefined(tacpoints) && tacpoints.size);
    filteredpoints = [];
    foreach (tacpoint in tacpoints) {
        if (!function_4670789f(tacpoint) && !function_a38d2d73(tacpoint) && ai_escort::function_d15dd929(tacpoint.origin)) {
            filteredpoints[filteredpoints.size] = tacpoint;
        }
    }
    return filteredpoints;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0xfb5d7926, Offset: 0xa58
// Size: 0x398
function private function_fb11cc0f(owner) {
    cylinder = ai::t_cylinder(owner.origin, 800, 150);
    angles = owner getplayerangles();
    forwarddir = anglestoforward(angles);
    var_84e7232 = owner.origin + vectorscale(forwarddir, 100);
    var_441c6196 = ai::t_cylinder(owner.origin, 100, 150);
    tacpoints = tacticalquery("mp_dog_spawn", owner.origin, owner, cylinder, var_441c6196, var_84e7232);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_9cb166cd(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:owner.angles};
        }
    }
    tacpoints = tacticalquery("mp_dog_spawn_fallback", owner.origin, owner, cylinder, var_441c6196, var_84e7232);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_9cb166cd(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:owner.angles};
        }
    }
    tacpoints = tacticalquery("mp_dog_spawn_fallback_2", owner.origin, owner, cylinder, var_441c6196);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_9cb166cd(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:owner.angles};
        }
    }
    closest = getclosestpointonnavmesh(owner.origin, 1200, 1);
    if (isdefined(closest)) {
        return {#origin:closest, #angles:owner.angles};
    }
    if (sessionmodeiswarzonegame()) {
        return {#origin:owner.origin, #angles:owner.angles};
    }
    return undefined;
}

// Namespace dog/dog_shared
// Params 3, eflags: 0x0
// Checksum 0x82f04b25, Offset: 0xdf8
// Size: 0x40e
function spawn_dog(bundle, owner, spawn) {
    angles = spawn.angles;
    origin = spawn.origin;
    dog = spawnactor(bundle.var_60e7f78, origin, angles, "", 1);
    dog ai_patrol::function_d091ff45(bundle);
    dog ai_escort::function_60415868(bundle);
    dog ai_leave::init_leave(bundle.var_cadb59a0);
    dog callback::function_d8abfc3d(#"hash_c3f225c9fa3cb25", &function_3fb68a86);
    dog.goalradius = bundle.var_a562774d;
    dog.var_2f8f0d5e = bundle.var_a1e0647b;
    dog.var_bac8fffe = bundle.var_f25e1ca * 1000;
    dog setentityowner(owner);
    dog.owner = owner;
    dog setteam(owner.team);
    dog callback::function_d8abfc3d(#"on_ai_killed", &function_d86da2e8);
    dog callback::function_d8abfc3d(#"on_killed_player", &function_64247932);
    dog.ai.var_b1248bd1 = 1;
    dog set_state(1, 1);
    owner thread function_2f6f43cf(dog, bundle.ksweapon);
    dog thread killstreaks::function_fff56140(owner, &function_747a6ed6);
    dog callback::function_d8abfc3d(#"on_end_game", &function_a1b9ccf1);
    if (isdefined(bundle.ksduration)) {
        dog thread killstreaks::waitfortimeout(bundle.var_d3413870, bundle.ksduration, &timeout, "death");
    }
    if (!ai_escort::function_d15dd929(dog.origin)) {
        cylinder = ai::t_cylinder(origin, 1500, 250);
        var_441c6196 = ai::t_cylinder(origin, 100, 250);
        tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, self, cylinder, var_441c6196, self.origin);
        if (isdefined(tacpoints) && tacpoints.size) {
            tacpoints = function_9cb166cd(tacpoints);
            if (tacpoints.size) {
                tacpoint = array::random(tacpoints);
                dog forceteleport(tacpoint.origin, dog.angles);
            }
        }
    }
    if (isdefined(level.var_8d02c681)) {
        dog [[ level.var_8d02c681 ]]();
    }
    /#
        owner.killstreak_dog = dog;
    #/
    return dog;
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0xb83556c9, Offset: 0x1210
// Size: 0x104
function set_state(state, var_deeb4ee7) {
    self.favoriteenemy = undefined;
    self.ai.hasseenfavoriteenemy = 0;
    function_3fda709e(self.script_owner, 2);
    if (isdefined(var_deeb4ee7) && !var_deeb4ee7) {
        self battlechatter::function_1d4b0ec0(state, self);
    }
    if (state == 2) {
        self clientfield::set("dogState", 1);
        if (isdefined(self.script_owner)) {
            self.script_owner globallogic_score::function_d3ca3608(#"hash_28a8b95557ddc249");
        }
        wait 0.5;
    }
    self ai_state::set_state(state);
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0xe85ad844, Offset: 0x1320
// Size: 0x1c
function function_3fda709e(owner, *value) {
    if (isdefined(value)) {
    }
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x2d796b56, Offset: 0x1348
// Size: 0xa6
function function_8296c0eb(owner) {
    if (!isdefined(owner)) {
        return false;
    }
    if (!isalive(owner)) {
        return false;
    }
    if (!isplayer(owner)) {
        return false;
    }
    if (owner.sessionstate == "spectator") {
        return false;
    }
    if (owner.sessionstate == "intermission") {
        return false;
    }
    if (is_true(level.intermission)) {
        return false;
    }
    return true;
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0x60c3f504, Offset: 0x13f8
// Size: 0x9c
function function_d61879c9(owner, var_5e42819a = 1) {
    if (var_5e42819a && function_8296c0eb(owner)) {
        owner gestures::function_56e00fbf(#"hash_2c75f3bef8443438", undefined, 0);
    }
    self set_state(1, 0);
    self set_state(0, 0);
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xf83f17f3, Offset: 0x14a0
// Size: 0x2c
function function_2d96af8d() {
    self ai_patrol::function_325c6829(self.script_owner.origin);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x7f136e43, Offset: 0x14d8
// Size: 0x1e6
function function_458bc8de(dog) {
    self endon(#"disconnect");
    dog endon(#"death");
    dog notify(#"hash_27a4203e237c5098");
    dog endon(#"hash_27a4203e237c5098");
    wait 0.5;
    while (true) {
        if (dog ai_state::is_state(2)) {
            break;
        }
        if (!is_true(level.var_347a87db) && self util::use_button_held() && !self function_104d7b4d() && !self isusingoffhand()) {
            dog function_d61879c9(self);
            wait 0.5;
        } else if (dog ai_state::is_state(0)) {
            if (isdefined(dog.ai.patrol.starttime) && gettime() - dog.ai.patrol.starttime >= dog.var_bac8fffe) {
                if (!isdefined(dog.favoriteenemy) || !is_true(dog.ai.hasseenfavoriteenemy)) {
                    dog set_state(1, 0);
                    wait 0.5;
                }
            }
        }
        waitframe(1);
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xd16862c2, Offset: 0x16c8
// Size: 0x2c
function function_a1b9ccf1() {
    self.ignoreall = 1;
    self set_state(0, 0);
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x21936c2c, Offset: 0x1700
// Size: 0x44
function function_747a6ed6() {
    self.ignoreall = 1;
    self set_state(2, 0);
    self delete();
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x6c9d9f48, Offset: 0x1750
// Size: 0x2c
function function_441cdbb6() {
    self.ignoreall = 1;
    self set_state(2, 0);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0xdc79f6a3, Offset: 0x1788
// Size: 0x394
function private function_e74b21de(owner) {
    if (isdefined(owner) && distancesquared(owner.origin, self.origin) < function_a3f6cdac(256)) {
        origin = owner.origin;
        angles = owner getplayerangles();
        forwarddir = anglestoforward(angles);
        var_84e7232 = owner.origin + vectorscale(forwarddir, 100);
    } else {
        origin = self.origin;
        angles = self.angles;
        var_84e7232 = origin;
    }
    cylinder = ai::t_cylinder(origin, 1500, 250);
    var_441c6196 = ai::t_cylinder(origin, 100, 250);
    if (isdefined(owner)) {
        tacpoints = tacticalquery("mp_dog_spawn", origin, owner, cylinder, var_441c6196, var_84e7232);
    } else {
        tacpoints = tacticalquery("mp_dog_spawn", origin, self, cylinder, var_441c6196, var_84e7232);
    }
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_9cb166cd(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:angles};
        }
    }
    if (isdefined(owner)) {
        tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, owner, cylinder, var_441c6196, var_84e7232);
    } else {
        tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, self, cylinder, var_441c6196, var_84e7232);
    }
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_9cb166cd(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:angles};
        }
    }
    var_ead7a19 = function_b777d194(self.origin);
    if (isdefined(var_ead7a19) && var_ead7a19.size) {
        leavepoint = array::random(var_ead7a19);
        return {#origin:leavepoint, #angles:self.angles};
    }
    return {#origin:self.origin, #angles:self.angles};
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xe756c7ca, Offset: 0x1b28
// Size: 0x3c
function function_3fb68a86() {
    self.exit_spawn = function_e74b21de(self.script_owner);
    function_3fda709e(self.script_owner, 0);
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x3e42845, Offset: 0x1b70
// Size: 0xac
function timeout() {
    self endon(#"death");
    if (is_true(level.var_12347bf6)) {
        return;
    }
    if (isdefined(self.script_owner)) {
        self.script_owner namespace_f9b02f80::play_taacom_dialog("timeout", "dog");
        killstreakrules::killstreakstop(self.hardpointtype, self.team, self.killstreak_id);
    }
    self function_441cdbb6();
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0xb4715b1a, Offset: 0x1c28
// Size: 0x54
function function_2f6f43cf(dog, weapon) {
    self endon(#"disconnect");
    dog waittill(#"death");
    self ability_player::function_f2250880(weapon, 0);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0xc85a7986, Offset: 0x1c88
// Size: 0x2d4
function private function_d86da2e8(params) {
    if (!isdefined(self) || !isdefined(params)) {
        return;
    }
    function_3fda709e(self.script_owner, 0);
    if (isdefined(params.eattacker) && isplayer(params.eattacker)) {
        bundle = self killstreak_bundles::function_48e9536e();
        if (isdefined(params.weapon) && params.weapon != getweapon(#"dog_ai_defaultmelee") && isplayer(params.eattacker)) {
            if (isdefined(self.script_owner)) {
                self.script_owner globallogic_score::function_5829abe3(params.eattacker, params.weapon, getweapon("dog_ai_defaultmelee"));
            }
        }
        if (isdefined(bundle.var_74711af9)) {
            if (isdefined(self.attackers)) {
                foreach (attacker in self.attackers) {
                    if (attacker != params.eattacker && isdefined(self.script_owner)) {
                        scoreevents::processscoreevent(#"killed_dog_assist", attacker, self.script_owner, undefined);
                    }
                }
            }
        }
        self thread battlechatter::function_d2600afc(params.eattacker, self.script_owner, self.meleeweapon, params.weapon);
        if (isdefined(self.script_owner)) {
            self.script_owner namespace_f9b02f80::play_taacom_dialog("destroyed", "dog");
        }
    }
    if (isdefined(self.script_owner)) {
        self.script_owner globallogic_score::function_d3ca3608(#"hash_28a8b95557ddc249");
        killstreakrules::killstreakstop(self.hardpointtype, self.team, self.killstreak_id);
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1f68
// Size: 0x4
function function_64247932() {
    
}

