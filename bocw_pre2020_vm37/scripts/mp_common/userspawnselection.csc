#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace userspawnselection;

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x6
// Checksum 0x914f1340, Offset: 0x178
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"userspawnselection", &function_70a657d8, undefined, &setupspawngroups, undefined);
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x5 linked
// Checksum 0xd7ee4d97, Offset: 0x1c8
// Size: 0x54
function private function_70a657d8() {
    level.next_spawngroup_index = 0;
    level.spawngroups = [];
    level.useteamspecificforwardspawns = getgametypesetting(#"forwardspawnteamspecificspawns");
    setupclientfields();
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x1 linked
// Checksum 0x5b7b34ef, Offset: 0x228
// Size: 0x304
function setupclientfields() {
    for (index = 0; index < 20; index++) {
        basename = "spawngroupStatus_" + index + "_";
        clientfield::function_5b7d846d(basename + "visStatus", #"hash_5e10ae8c08eeb04b", [hash(isdefined(index) ? "" + index : ""), #"visstatus"], 1, 1, "int", undefined, 0, 1);
        clientfield::function_5b7d846d(basename + "useStatus", #"hash_5e10ae8c08eeb04b", [hash(isdefined(index) ? "" + index : ""), #"usestatus"], 1, 1, "int", undefined, 0, 1);
        clientfield::function_5b7d846d(basename + "team", #"hash_5e10ae8c08eeb04b", [hash(isdefined(index) ? "" + index : ""), #"team"], 1, 2, "int", undefined, 0, 1);
    }
    clientfield::register_clientuimodel("hudItems.showSpawnSelect", #"hash_6f4b11a0bee9b73d", #"showspawnselect", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.killcamActive", #"hash_6f4b11a0bee9b73d", #"killcamactive", 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hideautospawnoption", #"hash_5e10ae8c08eeb04b", #"hideautospawnoption", 1, 1, "int", undefined, 0, 0);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x5 linked
// Checksum 0xbc030f4e, Offset: 0x538
// Size: 0x1ec
function private setupstaticmodelfieldsforspawngroup(spawngroup) {
    basemodel = getuimodel(function_5f72e972(#"hash_5e10ae8c08eeb04b"), isdefined(spawngroup.uiindex) ? "" + spawngroup.uiindex : "");
    spawngroupname = "";
    if (isdefined(spawngroup.ui_label)) {
        spawngroupname = spawngroup.ui_label;
    }
    setuimodelvalue(getuimodel(basemodel, "regionName"), spawngroupname);
    setuimodelvalue(getuimodel(basemodel, "team"), spawngroup.script_team);
    var_1de19812 = getuimodel(basemodel, "origin");
    setuimodelvalue(getuimodel(var_1de19812, "x"), spawngroup.origin[0]);
    setuimodelvalue(getuimodel(var_1de19812, "y"), spawngroup.origin[1]);
    setuimodelvalue(getuimodel(var_1de19812, "z"), spawngroup.origin[2]);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x1 linked
// Checksum 0x7dbba081, Offset: 0x730
// Size: 0x128
function function_bc7ec9a1(spawngroup) {
    spawns = struct::get_array(spawngroup.target, "groupname");
    var_164af2a6 = 0;
    var_98dd92c = 0;
    var_fbc43d99 = 0;
    var_4f210458 = 0;
    foreach (spawn in spawns) {
        var_164af2a6 += spawn.origin.x;
        var_98dd92c += spawn.origin.y;
        var_fbc43d99 += spawn.origin.z;
    }
    return var_98dd92c;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x1 linked
// Checksum 0xe810a74e, Offset: 0x860
// Size: 0x6c
function setupspawngroup(spawngroup) {
    spawngroup.uiindex = level.next_spawngroup_index;
    level.next_spawngroup_index++;
    level.spawngroups[spawngroup.uiindex] = spawngroup;
    function_bc7ec9a1(spawngroup);
    setupstaticmodelfieldsforspawngroup(spawngroup);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x1 linked
// Checksum 0x7b875995, Offset: 0x8d8
// Size: 0xe8
function setupspawngroups(*localclientnum) {
    spawngroups = struct::get_array("spawn_group_marker", "targetname");
    if (!isdefined(spawngroups)) {
        return;
    }
    spawngroupssorted = array::get_all_closest((0, 0, 0), spawngroups);
    foreach (spawngroup in spawngroupssorted) {
        setupspawngroup(spawngroup);
    }
}

