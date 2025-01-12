#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_16b1b77a76492c6a;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\math_shared;

#namespace namespace_826acffa;

// Namespace namespace_826acffa/level_init
// Params 1, eflags: 0x40
// Checksum 0xd11e6679, Offset: 0x108
// Size: 0x9c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "supply_portal", 1, 1, "int");
    clientfield::register("scriptmover", "portal_form", 1, 1, "int");
    clientfield::register("scriptmover", "smoke_fx", 1, 1, "int");
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 1, eflags: 0x0
// Checksum 0x8126f372, Offset: 0x1b0
// Size: 0xc
function init(*s_instance) {
    
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 2, eflags: 0x0
// Checksum 0x7112c85d, Offset: 0x1c8
// Size: 0x284
function function_af97868(s_instance, activator) {
    var_44292111 = array::random(s_instance.var_fe2612fe[#"hash_42043afbdf06011b"]);
    s_portal = var_44292111.var_fe2612fe[#"supply_portal"][0];
    if (isplayer(activator)) {
        callback::on_stash_open(&on_stash_open);
        level thread function_d687fba3();
        var_1a569f6b = item_supply_drop::function_9771c7db(s_portal.origin, #"hash_5f4c110f01c55af9");
        if (math::cointoss()) {
            namespace_2c949ef8::function_be6ec6c(var_44292111.origin);
        } else {
            level thread function_35bfa27f(var_44292111);
        }
        if (isdefined(var_1a569f6b)) {
            n_objective_id = gameobjects::get_next_obj_id();
            objective_add(n_objective_id, "active", var_1a569f6b, #"hash_5c1314fe5f4bf45d");
            var_1a569f6b waittill(#"hash_582b400644b5f920");
            var_1a569f6b objective_manager::function_811514c3();
            objective_delete(n_objective_id);
            foreach (player in getplayers()) {
                level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
            }
            objective_manager::objective_ended(s_instance, 1);
        }
    }
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 1, eflags: 0x0
// Checksum 0x7a43419b, Offset: 0x458
// Size: 0x138
function function_35bfa27f(var_44292111) {
    a_spawn_locs = var_44292111.var_fe2612fe[#"hash_57b94959fe0fc02f"];
    if (!isdefined(a_spawn_locs) || a_spawn_locs.size) {
        namespace_2c949ef8::function_be6ec6c(var_44292111.origin);
        return;
    }
    var_479c5fdd = 0;
    while (true) {
        a_s_locs = array::randomize(a_spawn_locs);
        for (i = 0; i < a_s_locs.size; i++) {
            ai_spawned = spawnactor(#"hash_7cba8a05511ceedf", a_s_locs[i].origin, a_s_locs[i].angles, "objective_zombie", 1);
            if (isdefined(ai_spawned)) {
                var_479c5fdd++;
                if (var_479c5fdd == 25) {
                    return;
                }
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 0, eflags: 0x0
// Checksum 0x4ce28de7, Offset: 0x598
// Size: 0x160
function function_d687fba3() {
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_6a241aad97123efc");
    }
    wait 6;
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_6a241aad97123efc");
        level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
    }
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 1, eflags: 0x0
// Checksum 0x8a7d9ff7, Offset: 0x700
// Size: 0x4e
function on_stash_open(*a_params) {
    if (isdefined(self.var_b91441dd) && self.var_b91441dd.name === #"hash_5f4c110f01c55af9") {
        self notify(#"hash_582b400644b5f920");
    }
}

