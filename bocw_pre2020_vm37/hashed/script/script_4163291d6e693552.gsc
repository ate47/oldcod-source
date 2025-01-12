#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\util_shared;

#namespace namespace_7589cf5c;

// Namespace namespace_7589cf5c/namespace_7589cf5c
// Params 0, eflags: 0x0
// Checksum 0xd744068d, Offset: 0x70
// Size: 0xc8
function function_8eafd734() {
    self endon(#"death");
    while (true) {
        s_result = self waittill(#"damage");
        if (isplayer(s_result.attacker) && isalive(s_result.attacker)) {
            s_result.attacker util::show_hit_marker();
            self playsoundtoplayer(#"hash_2ce81d103e923201", s_result.attacker);
        }
    }
}

// Namespace namespace_7589cf5c/namespace_7589cf5c
// Params 1, eflags: 0x0
// Checksum 0x98caebc3, Offset: 0x140
// Size: 0xf2
function function_83eb80af(v_org) {
    var_a940cf88 = getaiarray();
    for (i = 0; i < var_a940cf88.size; i++) {
        if (is_true(var_a940cf88[i].allowdeath) && isalive(var_a940cf88[i]) && distancesquared(v_org, var_a940cf88[i].origin) <= function_a3f6cdac(5000)) {
            var_a940cf88[i] kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
        waitframe(1);
    }
}

// Namespace namespace_7589cf5c/namespace_7589cf5c
// Params 2, eflags: 0x0
// Checksum 0x6bf6a0f4, Offset: 0x240
// Size: 0x110
function function_3899cfea(v_org, n_radius) {
    a_zombies = function_a38db454(v_org, n_radius);
    foreach (zombie in a_zombies) {
        if (isdefined(zombie)) {
            zombie.allowdeath = 1;
            if (zombie.archetype === #"zombie") {
                gibserverutils::annihilate(zombie);
            }
            zombie kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
}

