#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ac130;

// Namespace ac130/ac130_shared
// Params 0, eflags: 0x0
// Checksum 0x40212a8e, Offset: 0x138
// Size: 0x124
function init_shared() {
    callback::on_localclient_connect(&on_localclient_connect);
    clientfield::register_clientuimodel("vehicle.selectedWeapon", #"vehicle_info", #"selectedweapon", 1, 2, "int", &function_db40057d, 0, 0);
    clientfield::register_clientuimodel("vehicle.flareCount", #"vehicle_info", #"flarecount", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.inAC130", #"vehicle_info", #"inac130", 1, 1, "int", undefined, 0, 0);
}

// Namespace ac130/ac130_shared
// Params 3, eflags: 0x4
// Checksum 0x393afc63, Offset: 0x268
// Size: 0x8c
function private function_2c2bf9dc(localclientnum, uimodel, weapon_name) {
    weapon = getweapon(weapon_name);
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"vehicle_ac130"), uimodel), weapon.clipsize);
}

// Namespace ac130/ac130_shared
// Params 1, eflags: 0x0
// Checksum 0x968ab8c, Offset: 0x300
// Size: 0x84
function on_localclient_connect(localclientnum) {
    function_2c2bf9dc(localclientnum, "maincannonClipSize", #"hash_17df39d53492b0bf");
    function_2c2bf9dc(localclientnum, "autocannonClipSize", #"hash_7b24d0d0d2823bca");
    function_2c2bf9dc(localclientnum, "chaingunClipSize", #"ac130_chaingun");
}

// Namespace ac130/ac130_shared
// Params 7, eflags: 0x0
// Checksum 0x484b859e, Offset: 0x390
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

