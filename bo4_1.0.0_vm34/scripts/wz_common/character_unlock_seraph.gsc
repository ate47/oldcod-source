#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;
#using scripts\wz_common\wz_firing_range;

#namespace character_unlock_seraph;

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 0, eflags: 0x2
// Checksum 0x9aa73e33, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_seraph", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 0, eflags: 0x0
// Checksum 0xdba499f2, Offset: 0xf0
// Size: 0xa4
function __init__() {
    character_unlock::register_character_unlock(#"seraph_unlock", #"hash_17c02481305f0e24", #"hash_6a4d9380f1505d13", &function_5882300, #"hash_633d185cd2140f1a");
    callback::on_player_killed_with_params(&on_player_killed);
    callback::on_finalize_initialization(&on_finalize_initialization);
}

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 0, eflags: 0x0
// Checksum 0x7ca18062, Offset: 0x1a0
// Size: 0x24
function on_finalize_initialization() {
    wz_firing_range::init_targets(#"hash_3af83a27a707345a");
}

// Namespace character_unlock_seraph/event_52bf9a5a
// Params 1, eflags: 0x44
// Checksum 0x27bdbf94, Offset: 0x1d0
// Size: 0x254
function private event_handler[event_52bf9a5a] function_8e98cf9d(eventstruct) {
    dynent = eventstruct.ent;
    if (dynent.targetname !== #"hash_3af83a27a707345a") {
        return;
    }
    attacker = eventstruct.attacker;
    weapon = eventstruct.weapon;
    position = eventstruct.position;
    direction = eventstruct.dir;
    if (!isplayer(attacker) || !isdefined(weapon) || !isdefined(position) || !isdefined(direction)) {
        return;
    }
    if (weapon.weapclass != "pistol" && weapon.weapclass != "pistol spread") {
        return;
    }
    if (attacker character_unlock::function_fc39af28(#"seraph_unlock")) {
        return;
    }
    targetangles = dynent.angles + (0, 90, 0);
    var_e4d40ed8 = anglestoforward(targetangles);
    if (vectordot(var_e4d40ed8, direction) >= 0) {
        return;
    }
    var_24649b3 = dynent.origin + (0, 0, 45);
    if (distance2dsquared(var_24649b3, position) > 5 * 5) {
        return;
    }
    var_8ac70ab4 = getdynent(#"hash_81ef4f75cff4919");
    if (function_7f51b166(var_8ac70ab4) != 1) {
        function_9e7b6692(var_8ac70ab4, 1);
    }
}

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 1, eflags: 0x0
// Checksum 0x8ef7052c, Offset: 0x430
// Size: 0xf4
function on_player_killed(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    if (!isplayer(attacker) || !isdefined(weapon)) {
        return;
    }
    if (weapon.name != #"hero_annihilator") {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"seraph_unlock")) {
        return;
    }
    attacker character_unlock::function_4c582a05(#"seraph_unlock", #"hash_633d185cd2140f1a");
}

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 0, eflags: 0x0
// Checksum 0xcd83d855, Offset: 0x530
// Size: 0xd4
function function_5882300() {
    aliveplayers = 0;
    players = getplayers();
    foreach (player in players) {
        if (self == player) {
            continue;
        }
        if (isalive(player)) {
            aliveplayers++;
        }
    }
    if (aliveplayers + 1 <= 6) {
        return true;
    }
    return false;
}

/#

    // Namespace character_unlock_seraph/character_unlock_seraph
    // Params 0, eflags: 0x0
    // Checksum 0xce789cef, Offset: 0x610
    // Size: 0x5e
    function function_21ac1b6e() {
        while (true) {
            var_24649b3 = self.origin + (0, 0, 45);
            sphere(var_24649b3, 5, (1, 1, 0));
            waitframe(1);
        }
    }

#/
