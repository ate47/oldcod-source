#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_roulette;

// Namespace gadget_roulette/gadget_roulette
// Params 0, eflags: 0x2
// Checksum 0x7571b803, Offset: 0x1a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace gadget_roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xff40e952, Offset: 0x1e8
// Size: 0x6c
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int", &roulette_clientfield_cb, 0, 0);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace gadget_roulette/gadget_roulette
// Params 7, eflags: 0x0
// Checksum 0x8aaea5d5, Offset: 0x260
// Size: 0x54
function roulette_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    update_roulette(localclientnum, newval);
}

// Namespace gadget_roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0x33c35c29, Offset: 0x2c0
// Size: 0x8c
function update_roulette(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        roulettestatusmodel = getuimodel(controllermodel, "playerAbilities.playerGadget3.rouletteStatus");
        if (isdefined(roulettestatusmodel)) {
            setuimodelvalue(roulettestatusmodel, newval);
        }
    }
}

// Namespace gadget_roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x65e4873e, Offset: 0x358
// Size: 0x74
function on_localplayer_spawned(localclientnum) {
    roulette_state = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        roulette_state = self clientfield::get_to_player("roulette_state");
    }
    update_roulette(localclientnum, roulette_state);
}

