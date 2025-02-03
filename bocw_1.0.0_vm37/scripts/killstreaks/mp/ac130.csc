#using script_13da4e6b98ca81a1;
#using script_79917113c7593edd;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ac130;

// Namespace ac130/ac130
// Params 0, eflags: 0x6
// Checksum 0x72b9b624, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"ac130", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x4
// Checksum 0x7aca5578, Offset: 0x140
// Size: 0x7c
function private preinit() {
    init_shared();
    clientfield::register("toplayer", "inAC130", 1, 1, "int", &function_555656fe, 0, 1);
    callback::function_a880899e(&function_a880899e);
}

// Namespace ac130/ac130
// Params 7, eflags: 0x0
// Checksum 0xfb13530d, Offset: 0x1c8
// Size: 0x13c
function function_555656fe(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    bundle = getscriptbundle("killstreak_ac130");
    postfxbundle = bundle.("ksVehiclePostEffectBun");
    if (!isdefined(postfxbundle)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump && codcaster::function_45a5c04c(fieldname)) {
        bwastimejump = 0;
    }
    if (bwastimejump) {
        if (self postfx::function_556665f2(postfxbundle) == 0) {
            self codeplaypostfxbundle(postfxbundle);
        }
        return;
    }
    if (self postfx::function_556665f2(postfxbundle)) {
        self codestoppostfxbundle(postfxbundle);
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x8c411845, Offset: 0x310
// Size: 0xa4
function function_a880899e(eventparams) {
    localclientnum = eventparams.localclientnum;
    if (codcaster::function_b8fe9b52(localclientnum)) {
        player = function_5c10bd79(localclientnum);
        if (player clientfield::get_to_player("inAC130")) {
            function_555656fe(localclientnum, undefined, !codcaster::function_45a5c04c(localclientnum));
        }
    }
}

