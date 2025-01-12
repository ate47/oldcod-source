#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace namespace_662ff671;

// Namespace namespace_662ff671/level_init
// Params 1, eflags: 0x40
// Checksum 0xb8d4d787, Offset: 0x138
// Size: 0x124
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("actor", "" + #"hash_74382f598f4de051", 1, getminbitcountfornum(4), "counter", &function_9f72eb8b, 0, 0);
    clientfield::register("actor", "" + #"hash_b74182bd1e44a44", 1, 1, "int", &function_cdc867b2, 0, 0);
    clientfield::register("actor", "" + #"hash_435db79c304e12a5", 1, 1, "counter", &function_f15a1018, 0, 0);
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 7, eflags: 0x0
// Checksum 0xf1fa8624, Offset: 0x268
// Size: 0x9c
function function_f15a1018(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, "maps/zm_escape/fx8_brutus_transformation_shockwave", self.origin + (0, 0, 32), anglestoforward(self.angles), anglestoup(self.angles));
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 7, eflags: 0x0
// Checksum 0xd05537fb, Offset: 0x310
// Size: 0x214
function function_9f72eb8b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    earthquake(fieldname, 0.3, 2, self.origin, 2500);
    function_36e4ebd4(fieldname, #"hash_28f3f7b037cdb4bc");
    switch (bwastimejump) {
    case 1:
        var_8ae0b6c7 = #"hash_7cba8ef6bb10607";
        break;
    case 2:
        var_8ae0b6c7 = #"hash_61f74f4458252ccc";
        break;
    case 3:
        var_8ae0b6c7 = #"hash_7cba8ef6bb10607";
        break;
    case 4:
        var_8ae0b6c7 = #"hash_7cba8ef6bb10607";
        break;
    }
    self playsound(fieldname, var_8ae0b6c7);
    a_players = getplayers(fieldname, undefined, self.origin, 2500);
    array::thread_all(a_players, &postfx::playpostfxbundle, #"hash_4bce2bc0fe1ee966");
    wait 1;
    arrayremovevalue(a_players, undefined);
    array::thread_all(a_players, &postfx::exitpostfxbundle, #"hash_4bce2bc0fe1ee966");
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 7, eflags: 0x0
// Checksum 0xfb138b4a, Offset: 0x530
// Size: 0xec
function function_cdc867b2(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!isdefined(self.var_bb6d69f0)) {
            self.var_bb6d69f0 = util::playfxontag(fieldname, "sr/fx9_boss_orb_aether_shield_spawn", self, "j_spine4");
        }
        return;
    }
    if (isdefined(self.var_bb6d69f0)) {
        stopfx(fieldname, self.var_bb6d69f0);
        self.var_bb6d69f0 = undefined;
    }
    playfx(fieldname, "sr/fx9_boss_orb_aether_shield_despawn", self gettagorigin("j_spine4"));
}

