#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace userspawnselection;

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x2
// Checksum 0xf088bf4b, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"userspawnselection", &__init__, undefined, undefined);
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x41caba42, Offset: 0x1b8
// Size: 0x84
function __init__() {
    level.next_spawngroup_index = 0;
    level.spawngroups = [];
    level.useteamspecificforwardspawns = getgametypesetting(#"forwardspawnteamspecificspawns");
    callback::on_finalize_initialization(&setupspawngroups);
    setupuimodels();
    setupclientfields();
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0x73e24d70, Offset: 0x248
// Size: 0x20
function private getdatamodelprefix(id) {
    return "spawngroupStatus." + id + ".";
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xca40718b, Offset: 0x270
// Size: 0x1ac
function setupclientfields() {
    for (index = 0; index < 20; index++) {
        basename = getdatamodelprefix(index);
        clientfield::register("worlduimodel", basename + "visStatus", 1, 1, "int", undefined, 0, 1);
        clientfield::register("worlduimodel", basename + "useStatus", 1, 1, "int", undefined, 0, 1);
        clientfield::register("worlduimodel", basename + "team", 1, 2, "int", undefined, 0, 1);
    }
    clientfield::register("clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.killcamActive", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hideautospawnoption", 1, 1, "int", undefined, 0, 0);
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x3ec1924, Offset: 0x428
// Size: 0x136
function setupuimodels() {
    for (index = 0; index < 20; index++) {
        spawngroupprefix = getdatamodelprefix(index);
        createuimodel(getglobaluimodel(), spawngroupprefix + "regionName");
        createuimodel(getglobaluimodel(), spawngroupprefix + "origin.x");
        createuimodel(getglobaluimodel(), spawngroupprefix + "origin.y");
        createuimodel(getglobaluimodel(), spawngroupprefix + "origin.z");
        createuimodel(getglobaluimodel(), spawngroupprefix + "team");
    }
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0x3d8ba1e9, Offset: 0x568
// Size: 0x22c
function private setupstaticmodelfieldsforspawngroup(spawngroup) {
    basename = getdatamodelprefix(spawngroup.uiindex);
    namemodel = getuimodel(getglobaluimodel(), basename + "regionName");
    spawngroupname = "";
    if (isdefined(spawngroup.ui_label)) {
        spawngroupname = spawngroup.ui_label;
    }
    setuimodelvalue(namemodel, spawngroupname);
    teammodel = getuimodel(getglobaluimodel(), basename + "team");
    setuimodelvalue(teammodel, spawngroup.script_team);
    xmodel = getuimodel(getglobaluimodel(), basename + "origin.x");
    setuimodelvalue(xmodel, spawngroup.origin[0]);
    ymodel = getuimodel(getglobaluimodel(), basename + "origin.y");
    setuimodelvalue(ymodel, spawngroup.origin[1]);
    zmodel = getuimodel(getglobaluimodel(), basename + "origin.z");
    setuimodelvalue(zmodel, spawngroup.origin[2]);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x1f8cc500, Offset: 0x7a0
// Size: 0x12c
function function_f620e593(spawngroup) {
    spawns = struct::get_array(spawngroup.target, "groupname");
    var_5060190e = 0;
    var_76629377 = 0;
    var_45b243c = 0;
    var_2ec75f5 = 0;
    foreach (spawn in spawns) {
        var_5060190e += spawn.origin.x;
        var_76629377 += spawn.origin.y;
        var_45b243c += spawn.origin.z;
    }
    return var_76629377;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xe4db47a9, Offset: 0x8d8
// Size: 0x7c
function setupspawngroup(spawngroup) {
    spawngroup.uiindex = level.next_spawngroup_index;
    level.next_spawngroup_index++;
    level.spawngroups[spawngroup.uiindex] = spawngroup;
    function_f620e593(spawngroup);
    setupstaticmodelfieldsforspawngroup(spawngroup);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x83e0aaa2, Offset: 0x960
// Size: 0xd8
function setupspawngroups(localclientnum) {
    spawngroups = struct::get_array("spawn_group_marker", "targetname");
    if (!isdefined(spawngroups)) {
        return;
    }
    spawngroupssorted = array::get_all_closest((0, 0, 0), spawngroups);
    foreach (spawngroup in spawngroupssorted) {
        setupspawngroup(spawngroup);
    }
}

