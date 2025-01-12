#using scripts\abilities\ability_player;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\scoreevents_shared;
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
// Checksum 0xd6d0e4b2, Offset: 0x1b0
// Size: 0xd4
function init_shared() {
    if (!isdefined(level.dog_shared)) {
        level.dog_shared = {};
        archetypempdog::init();
        clientfield::register("clientuimodel", "hudItems.dogState", 1, 2, "int");
        clientfield::register("actor", "dogState", 1, 1, "int");
        ability_player::function_642003d3(34, undefined, &deployed_off);
        level thread function_bb59e915();
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xde7cc47b, Offset: 0x290
// Size: 0xd8
function function_bb59e915() {
    level waittill(#"game_ended");
    corpses = getcorpsearray();
    foreach (corpse in corpses) {
        if (isactorcorpse(corpse) && corpse.archetype === "mp_dog") {
            corpse delete();
        }
    }
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0x8780d721, Offset: 0x370
// Size: 0xc0
function deployed_off(slot, weapon) {
    self gadgetpowerset(slot, 0);
    if (isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self._gadgets_player[slot]) && isdefined(self.pers[#"held_gadgets_power"][self._gadgets_player[slot]])) {
        self.pers[#"held_gadgets_power"][self._gadgets_player[slot]] = 0;
    }
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xf065ca67, Offset: 0x438
// Size: 0x1c8
function spawned(type) {
    assert(isplayer(self));
    playsoundatposition(#"hash_7245f25f5953631c", self.origin);
    player = self;
    bundle = level.killstreaks[type].script_bundle;
    if (!player killstreakrules::iskillstreakallowed(type, player.team)) {
        if (isdefined(bundle) && isdefined(level.var_57918348)) {
            player [[ level.var_57918348 ]](bundle.ksweapon);
        }
        return false;
    }
    player tracking::track(2);
    dog = spawn_dog(bundle, player);
    if (!isdefined(dog)) {
        if (isdefined(bundle) && isdefined(level.var_57918348)) {
            player [[ level.var_57918348 ]](bundle.ksweapon);
        }
        return false;
    }
    dog killstreak_bundles::spawned(bundle);
    dog influencers::create_entity_enemy_influencer("dog", player.team);
    ability_player::function_184edba5(bundle.ksweapon);
    return true;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x7f9f184e, Offset: 0x608
// Size: 0xbe
function function_6cd148b0(tacpoint) {
    players = getplayers();
    foreach (player in players) {
        if (distancesquared(tacpoint.origin, player.origin) <= 150 * 150) {
            return true;
        }
    }
    return false;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0x5bbb4a11, Offset: 0x6d0
// Size: 0xaa
function function_19edab19(tacpoint) {
    players = getplayers();
    foreach (player in players) {
        if (function_c80ec59e(tacpoint, player.origin)) {
            return true;
        }
    }
    return false;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0x150bc909, Offset: 0x788
// Size: 0xec
function private function_42b50663(tacpoints) {
    assert(isdefined(tacpoints) && tacpoints.size);
    filteredpoints = [];
    foreach (tacpoint in tacpoints) {
        if (!function_19edab19(tacpoint) && !function_6cd148b0(tacpoint)) {
            filteredpoints[filteredpoints.size] = tacpoint;
        }
    }
    return filteredpoints;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0x8fce4d88, Offset: 0x880
// Size: 0x2b0
function private function_959cedf1(owner) {
    cylinder = ai::t_cylinder(owner.origin, 800, 150);
    angles = owner getplayerangles();
    forwarddir = anglestoforward(angles);
    var_60b8e47f = owner.origin + vectorscale(forwarddir, 100);
    var_bb460730 = ai::t_cylinder(owner.origin, 100, 150);
    tacpoints = tacticalquery("mp_dog_spawn", owner.origin, owner, cylinder, var_bb460730, var_60b8e47f);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_42b50663(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:owner.angles};
        }
    }
    tacpoints = tacticalquery("mp_dog_spawn_fallback", owner.origin, owner, cylinder, var_bb460730, var_60b8e47f);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_42b50663(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:owner.angles};
        }
    }
    closest = getclosestpointonnavmesh(owner.origin, 500);
    if (isdefined(closest)) {
        return {#origin:closest, #angles:owner.angles};
    }
    return undefined;
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0x43156d72, Offset: 0xb38
// Size: 0x356
function spawn_dog(bundle, owner) {
    if (isdefined(level.var_56690ddd)) {
        spawn = [[ level.var_56690ddd ]](owner);
    }
    if (!isdefined(spawn)) {
        spawn = function_959cedf1(owner);
    }
    if (!isdefined(spawn)) {
        return undefined;
    }
    angles = spawn.angles;
    origin = spawn.origin;
    dog = spawnactor(bundle.var_2ce63078, origin, angles, "", 1);
    dog ai_patrol::function_8c3ba57b(bundle);
    dog ai_escort::function_a137177d(bundle);
    dog ai_leave::init_leave(bundle.var_75682bd4);
    dog callback::function_1dea870d(#"hash_c3f225c9fa3cb25", &function_97cec8ff);
    dog.goalradius = bundle.var_390a3bd1;
    dog setentityowner(owner);
    dog setteam(owner.team);
    dog callback::function_1dea870d(#"on_ai_killed", &function_e397fc44);
    dog callback::function_1dea870d(#"on_killed_player", &function_168f2dc0);
    dog.ai.var_41ac9f40 = 1;
    dog set_state(1, 1);
    owner thread function_12209b72(dog);
    owner thread function_e3f6ead8(dog, bundle.ksweapon);
    dog thread killstreaks::function_501f1a63(owner, &abort_dog);
    dog callback::function_1dea870d(#"on_end_game", &function_27ae0b15);
    if (isdefined(bundle.ksduration)) {
        dog thread killstreaks::waitfortimeout(bundle.var_e409027f, bundle.ksduration, &timeout, "death");
    }
    if (isdefined(level.var_dbbcfc5c)) {
        dog [[ level.var_dbbcfc5c ]]();
    }
    /#
        owner.killstreak_dog = dog;
    #/
    return dog;
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0xf315196a, Offset: 0xe98
// Size: 0x114
function set_state(state, var_22a19997) {
    self.favoriteenemy = undefined;
    self.ai.hasseenfavoriteenemy = 0;
    function_d5f0f245(self.script_owner, state + 1);
    if (isdefined(level.var_151de896) && isdefined(var_22a19997) && !var_22a19997) {
        self [[ level.var_151de896 ]](state, self);
    }
    if (state == 2) {
        self clientfield::set("dogState", 1);
        if (isdefined(self.script_owner)) {
            self.script_owner globallogic_score::function_8fe8d71e(#"hash_28a8b95557ddc249");
        }
        wait 0.5;
    }
    self ai_state::set_state(state);
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0x9d1e9bda, Offset: 0xfb8
// Size: 0x3c
function function_d5f0f245(owner, value) {
    if (isdefined(owner)) {
        owner clientfield::set_player_uimodel("hudItems.dogState", value);
    }
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xfd56ced5, Offset: 0x1000
// Size: 0xac
function function_cce0012b(owner) {
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
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    return true;
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xf8d79111, Offset: 0x10b8
// Size: 0xb4
function toggle_state(owner) {
    if (function_cce0012b(owner)) {
        owner gestures::function_42215dfa(#"hash_2c75f3bef8443438", undefined, 0);
    }
    if (self ai_state::is_state(1)) {
        self set_state(0, 0);
        return;
    }
    if (self ai_state::is_state(0)) {
        self set_state(1, 0);
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xd55e169b, Offset: 0x1178
// Size: 0x2c
function function_2abedd39() {
    self ai_patrol::function_dd3cad1f(self.script_owner.origin);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x0
// Checksum 0xa6e40315, Offset: 0x11b0
// Size: 0xe6
function function_12209b72(dog) {
    self endon(#"disconnect");
    dog endon(#"death");
    dog notify(#"hash_27a4203e237c5098");
    dog endon(#"hash_27a4203e237c5098");
    wait 0.5;
    while (true) {
        if (self offhandspecialbuttonpressed() && !self function_500afda2() && !self isusingoffhand()) {
            dog toggle_state(self);
            wait 0.5;
        }
        waitframe(1);
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xab641aff, Offset: 0x12a0
// Size: 0x2c
function function_27ae0b15() {
    self.ignoreall = 1;
    self set_state(0, 0);
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x9ed065d0, Offset: 0x12d8
// Size: 0x44
function abort_dog() {
    self.ignoreall = 1;
    self set_state(2, 0);
    self delete();
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xcdec1269, Offset: 0x1328
// Size: 0x2c
function function_5d32addc() {
    self.ignoreall = 1;
    self set_state(2, 0);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0xb71e95a6, Offset: 0x1360
// Size: 0x218
function private function_7c1057c1(owner) {
    if (isdefined(owner)) {
        origin = owner.origin;
        angles = owner getplayerangles();
    } else {
        origin = self.origin;
        angles = self.angles;
    }
    cylinder = ai::t_cylinder(self.origin, 1500, 250);
    var_60b8e47f = origin;
    var_bb460730 = ai::t_cylinder(origin, 100, 250);
    tacpoints = tacticalquery("mp_dog_spawn", origin, self, cylinder, var_bb460730, var_60b8e47f);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_42b50663(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:angles};
        }
    }
    tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, self, cylinder, var_bb460730, var_60b8e47f);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_42b50663(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:angles};
        }
    }
    return undefined;
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x8bd4e24c, Offset: 0x1580
// Size: 0x3c
function function_97cec8ff() {
    self.exit_spawn = function_7c1057c1(self.script_owner);
    function_d5f0f245(self.script_owner, 0);
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x6b67e2d7, Offset: 0x15c8
// Size: 0x84
function timeout() {
    self endon(#"death");
    if (isdefined(level.var_8661954b) && level.var_8661954b) {
        return;
    }
    if (isdefined(self.script_owner)) {
        self.script_owner killstreaks::play_taacom_dialog("dogWeaponTimeout");
    }
    self function_5d32addc();
}

// Namespace dog/dog_shared
// Params 2, eflags: 0x0
// Checksum 0x3ccb3a00, Offset: 0x1658
// Size: 0x54
function function_e3f6ead8(dog, weapon) {
    self endon(#"disconnect");
    dog waittill(#"death");
    self ability_player::function_281eba9f(weapon, 0);
}

// Namespace dog/dog_shared
// Params 1, eflags: 0x4
// Checksum 0x2b2880f1, Offset: 0x16b8
// Size: 0x2b4
function private function_e397fc44(params) {
    if (!isdefined(self) || !isdefined(params)) {
        return;
    }
    function_d5f0f245(self.script_owner, 0);
    if (isdefined(params.eattacker) && isplayer(params.eattacker)) {
        bundle = self killstreak_bundles::function_bf8322cd();
        if (isdefined(params.weapon) && params.weapon != getweapon(#"dog_ai_defaultmelee") && isplayer(params.eattacker)) {
            if (isdefined(self.script_owner)) {
                self.script_owner globallogic_score::function_a63adb85(params.eattacker, params.weapon, getweapon("dog_ai_defaultmelee"));
            }
        }
        if (isdefined(bundle.var_4f545fab)) {
            if (isdefined(self.attackers)) {
                foreach (attacker in self.attackers) {
                    if (attacker != params.eattacker && isdefined(self.script_owner)) {
                        scoreevents::processscoreevent(#"killed_dog_assist", attacker, self.script_owner, undefined);
                    }
                }
            }
        }
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](params.eattacker, self.script_owner, self.meleeweapon, params.weapon);
        }
        if (isdefined(self.script_owner)) {
            self.script_owner killstreaks::play_taacom_dialog("dogWeaponDestroyed");
        }
    }
    if (isdefined(self.script_owner)) {
        self.script_owner globallogic_score::function_8fe8d71e(#"hash_28a8b95557ddc249");
    }
}

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1978
// Size: 0x4
function function_168f2dc0() {
    
}

