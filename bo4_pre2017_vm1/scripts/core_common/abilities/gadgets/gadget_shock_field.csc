#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_shock_field;

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x2
// Checksum 0xcf6bbddb, Offset: 0x2d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_shock_field", &__init__, undefined, undefined);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0x73656d99, Offset: 0x318
// Size: 0x5c
function __init__() {
    clientfield::register("allplayers", "shock_field", 1, 1, "int", &function_281e2b38, 0, 1);
    level.var_a01dacf5 = [];
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 1, eflags: 0x0
// Checksum 0x10d9eacc, Offset: 0x380
// Size: 0x58
function is_local_player(localclientnum) {
    player_view = getlocalplayer(localclientnum);
    if (!isdefined(player_view)) {
        return 0;
    }
    var_2389f10a = self == player_view;
    return var_2389f10a;
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 7, eflags: 0x0
// Checksum 0xb814661a, Offset: 0x3e0
// Size: 0x16c
function function_281e2b38(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    entid = getlocalplayer(localclientnum) getentitynumber();
    if (newval) {
        if (!isdefined(level.var_a01dacf5[entid])) {
            fx = "player/fx_plyr_shock_field";
            if (is_local_player(localclientnum)) {
                fx = "player/fx_plyr_shock_field_1p";
            }
            tag = "j_spinelower";
            level.var_a01dacf5[entid] = playfxontag(localclientnum, fx, self, tag);
        }
        return;
    }
    if (isdefined(level.var_a01dacf5[entid])) {
        stopfx(localclientnum, level.var_a01dacf5[entid]);
        level.var_a01dacf5[entid] = undefined;
    }
}

