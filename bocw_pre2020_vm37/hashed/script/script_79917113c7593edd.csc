#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ac130;

// Namespace ac130/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xd83c9a7e, Offset: 0x138
// Size: 0x124
function init_shared() {
    callback::on_localclient_connect(&on_localclient_connect);
    clientfield::register_clientuimodel("vehicle.selectedWeapon", #"vehicle_info", #"hash_3b221bb80ee9e4b8", 1, 2, "int", &function_db40057d, 0, 0);
    clientfield::register_clientuimodel("vehicle.flareCount", #"vehicle_info", #"hash_21c145e04c776d6e", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.inAC130", #"vehicle_info", #"inac130", 1, 1, "int", undefined, 0, 0);
}

// Namespace ac130/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x40909092, Offset: 0x268
// Size: 0xfc
function on_localclient_connect(localclientnum) {
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_2bf958a355503d00"), "maincannonClipSize"), 2);
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_2bf958a355503d00"), "autocannonClipSize"), 4);
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_2bf958a355503d00"), "chaingunClipSize"), 20);
}

// Namespace ac130/namespace_2d34cefc
// Params 7, eflags: 0x1 linked
// Checksum 0x9ad7d9cf, Offset: 0x370
// Size: 0x16a
function function_db40057d(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (fieldname == 0) {
        return;
    }
    switch (bwastimejump) {
    case 1:
        playsound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
        self playrumbleonentity(binitialsnap, "ac130_weap_switch");
        break;
    case 2:
        playsound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
        self playrumbleonentity(binitialsnap, "ac130_weap_switch");
        break;
    case 3:
        playsound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
        self playrumbleonentity(binitialsnap, "ac130_weap_switch");
        break;
    }
}

