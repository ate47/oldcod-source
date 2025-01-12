#using script_101d8280497ff416;
#using script_1e30f5109f6bf48c;
#using script_20055f2f97341caa;
#using script_37560a24283a601;
#using script_3d35e2ff167b3a82;
#using script_680dddbda86931fa;
#using script_68ae4d25b2c90f7d;
#using script_7b5224fe73522c;
#using script_7c727635e50af640;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;

#namespace namespace_1b527536;

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x6
// Checksum 0x4c2d3dee, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_13a43d760497b54d", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x5 linked
// Checksum 0x1d8bb0f4, Offset: 0x188
// Size: 0x2fc
function private function_70a657d8() {
    level.var_9bff3a72 = getgametypesetting(#"hash_7dedd27bf994a9a9");
    if (!is_true(level.var_9bff3a72)) {
        return;
    }
    level.var_1b527536 = array(#"frost_blast", #"frost_blast_1", #"frost_blast_2", #"frost_blast_3", #"frost_blast_4", #"frost_blast_5", #"hash_7b5a77a85b0ffab7", #"hash_379869d5b6da974b", #"hash_37986ad5b6da98fe", #"hash_37986bd5b6da9ab1", #"hash_37986cd5b6da9c64", #"hash_37986dd5b6da9e17", #"hash_41adc0ca9daf6e9d", #"energy_mine_1", #"energy_mine_2", #"energy_mine_3", #"energy_mine_4", #"hash_4ac3fea4add2a2c9", #"aether_shroud", #"hash_164c43cbd0ee958", #"hash_164c73cbd0eee71", #"hash_164c63cbd0eecbe", #"hash_164c93cbd0ef1d7", #"hash_164c83cbd0ef024", #"hash_1d9cb9dbd298acba", #"hash_631a223758cd92a", #"hash_631a123758cd777", #"hash_631a023758cd5c4", #"hash_6319f23758cd411", #"hash_6319e23758cd25e");
    clientfield::register_clientuimodel("hud_items.ammoCooldowns.fieldUpgrade", #"hash_6f4b11a0bee9b73d", [#"hash_2f126bd99a74de8b", #"fieldupgrade"], 1, 5, "float", undefined, 0, 0);
    clientfield::register("toplayer", "field_upgrade_selected", 1, 5, "int", &function_473fedfd, 0, 0);
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 7, eflags: 0x1 linked
// Checksum 0x97770f81, Offset: 0x490
// Size: 0x10c
function function_473fedfd(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_64774ae3 = undefined;
    if (bwastimejump > 0) {
        var_64774ae3 = level.var_1b527536[bwastimejump - 1];
    }
    if (!isdefined(var_64774ae3)) {
        var_64774ae3 = #"";
    }
    model = function_1df4c3b0(fieldname, #"hash_282d81d9dcedf39f");
    setuimodelvalue(getuimodel(model, "count"), 0);
    setuimodelvalue(getuimodel(model, "id"), var_64774ae3);
}

