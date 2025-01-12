#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace dynamic_loadout;

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x2
// Checksum 0xeff78049, Offset: 0x390
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"dynamic_loadout", &__init__, undefined, #"weapons");
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xdae09aba, Offset: 0x3e0
// Size: 0x14
function private __init__() {
    registerclientfields();
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xcd466792, Offset: 0x400
// Size: 0x47c
function private registerclientfields() {
    packagelist = getscriptbundlelist("bounty_hunter_package_list");
    if (isdefined(packagelist)) {
        var_2aefcc3a = int(ceil(log2(packagelist.size + 1)));
        var_372c749a = getgametypesetting(#"bountybagomoneymoney");
        level.var_1fd62126 = getgametypesetting(#"hash_63f8d60d122e755b");
        var_c5093b7f = int(ceil(log2(var_372c749a / level.var_1fd62126)));
        clientfield::register("toplayer", "bountyMoney", 1, 14, "int", &function_f94f7d4d, 0, 0);
        clientfield::register("toplayer", "bountyBagMoney", 1, var_c5093b7f, "int", &function_67a53291, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primary", 1, var_2aefcc3a, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondary", 1, var_2aefcc3a, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.armor", 1, var_2aefcc3a, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.reconTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.assaultTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.supportTrack.tierPurchased", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.scorestreak", 1, var_2aefcc3a, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.equipment", 1, var_2aefcc3a, "int", undefined, 0, 0);
        clientfield::register("worlduimodel", "BountyHunterLoadout.timeRemaining", 1, 5, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.BountyCarryingBag", 1, 1, "int", undefined, 0, 0);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 7, eflags: 0x4
// Checksum 0x927aecbe, Offset: 0x888
// Size: 0xc4
function private function_f94f7d4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    parent = getuimodelforcontroller(localclientnum);
    var_c1d7bbf8 = getuimodel(parent, "luielement.BountyHunterLoadout.money");
    if (!isdefined(var_c1d7bbf8)) {
        var_c1d7bbf8 = createuimodel(parent, "luielement.BountyHunterLoadout.money");
    }
    setuimodelvalue(var_c1d7bbf8, newval);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 7, eflags: 0x4
// Checksum 0x92d6e094, Offset: 0x958
// Size: 0xe4
function private function_67a53291(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    parent = getuimodelforcontroller(localclientnum);
    var_6864c8 = getuimodel(parent, "hudItems.bountyBagMoney");
    if (!isdefined(var_6864c8)) {
        var_6864c8 = createuimodel(parent, "hudItems.bountyBagMoney");
    }
    var_4ad8d0f4 = newval * level.var_1fd62126;
    setuimodelvalue(var_6864c8, var_4ad8d0f4);
}

