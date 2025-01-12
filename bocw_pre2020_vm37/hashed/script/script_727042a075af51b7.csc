#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_7da6f8ca;

// Namespace namespace_7da6f8ca/namespace_7da6f8ca
// Params 0, eflags: 0x6
// Checksum 0x49e4543f, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_40a4f03bb2983ee3", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_7da6f8ca/namespace_7da6f8ca
// Params 0, eflags: 0x5 linked
// Checksum 0x9380c6a, Offset: 0x120
// Size: 0x94
function private function_70a657d8() {
    clientfield::register("scriptmover", "item_drop_tail", 1, 1, "int", &item_drop_tail, 0, 0);
    clientfield::register("scriptmover", "item_updateWorldFX", 1, 1, "int", &item_updateWorldFX, 0, 0);
}

// Namespace namespace_7da6f8ca/namespace_7da6f8ca
// Params 1, eflags: 0x1 linked
// Checksum 0x2b848bc3, Offset: 0x1c0
// Size: 0x102
function function_6ee35a0a(rarity) {
    switch (rarity) {
    case #"resource":
        return #"hash_20b3d352fb23155c";
    case #"common":
        return #"hash_1c62f1903d03705a";
    case #"rare":
        return #"hash_3e3f86ff3fc6055";
    case #"epic":
        return #"hash_6c7840c9ca34f2a3";
    case #"legendary":
        return #"hash_7f4c941a9564c78f";
    case #"ultra":
        return #"hash_3dad79ca7ca879b5";
    default:
        return #"hash_20b3d352fb23155c";
    }
}

// Namespace namespace_7da6f8ca/namespace_7da6f8ca
// Params 7, eflags: 0x1 linked
// Checksum 0xc3a77cca, Offset: 0x2d0
// Size: 0x10e
function item_drop_tail(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(self.var_a6762160.rarity)) {
            rarity = self.var_a6762160.rarity;
        } else {
            rarity = "None";
        }
        fx_to_play = function_6ee35a0a(rarity);
        if (!isdefined(self.var_11154944)) {
            self.var_11154944 = util::playfxontag(fieldname, fx_to_play, self, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_11154944)) {
        stopfx(fieldname, self.var_11154944);
        self.var_11154944 = undefined;
    }
}

// Namespace namespace_7da6f8ca/namespace_7da6f8ca
// Params 7, eflags: 0x1 linked
// Checksum 0xf1f8ab40, Offset: 0x3e8
// Size: 0x11c
function item_updateWorldFX(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump != 0) {
        self.falling = 0;
        if (isdefined(level.var_d342a3fd) && isdefined(level.var_d342a3fd[fieldname])) {
            clientdata = level.var_d342a3fd[fieldname];
            model = clientdata.modellist[self.networkid];
            if (isdefined(model)) {
                item_world::function_2990e5f(fieldname, model);
                model.modelfx = undefined;
                wait 0.5;
                if (isdefined(self.networkid) && isdefined(self) && isdefined(model)) {
                    item_world::function_a4886b1e(fieldname, self.networkid, model);
                }
            }
        }
    }
}

