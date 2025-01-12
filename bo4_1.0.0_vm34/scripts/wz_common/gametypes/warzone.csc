#using script_45475af71e7fcab6;
#using script_71f2f8a6fc184b69;
#using script_7dd3fdbd09d5b252;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\map;
#using scripts\core_common\player_insertion;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\laststand_warzone;
#using scripts\wz_common\vehicle;
#using scripts\wz_common\wz_ai;

#namespace warzone;

// Namespace warzone/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xa58902a, Offset: 0x260
// Size: 0x28c
function event_handler[gametype_init] main(eventstruct) {
    insertion_passenger_count::register("insertionPassengerElem");
    death_zone::register("deathZoneElem");
    clientfield::register("worlduimodel", "hudItems.warzone.collapseTimerState", 1, 2, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.warzone.collapseProgress", 1, 7, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.distanceFromDeathCircle", 1, 7, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.alivePlayerCount", 1, 7, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.aliveTeammateCount", 1, 7, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.spectatorsCount", 1, 7, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.playerKills", 1, 7, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "presence.modeparam", 1, 7, "int", undefined, 0, 0);
    callback::on_localplayer_spawned(&function_b550f1d2);
    level.var_7ac9346b = [];
    level thread function_8ade9ce0();
    level thread function_46444e3d();
    callback::on_gameplay_started(&start_warzone);
    function_eb5cd524();
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0xd44066ba, Offset: 0x4f8
// Size: 0x1c
function start_warzone(localclientnum) {
    function_e729750();
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x53c91958, Offset: 0x520
// Size: 0x198
function function_8ade9ce0() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"teammate_waypoint_placed");
        localclientnum = waitresult.localclientnum;
        obj_id = util::getnextobjid(localclientnum);
        clientobjid = level.var_7ac9346b[waitresult.clientnum];
        if (isdefined(clientobjid)) {
            objective_delete(localclientnum, clientobjid);
            util::releaseobjid(localclientnum, clientobjid);
        }
        level.var_7ac9346b[waitresult.clientnum] = obj_id;
        objective_add(localclientnum, obj_id, "active", #"teammate_waypoint", (waitresult.xcoord, waitresult.ycoord, 0), #"none", getentbynum(localclientnum, waitresult.clientnum));
        function_d4f59e1d(localclientnum, obj_id, 1);
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x3bc208ac, Offset: 0x6c0
// Size: 0xf8
function function_46444e3d() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"teammate_waypoint_removed");
        localclientnum = waitresult.localclientnum;
        localplayer = function_f97e7787(localclientnum);
        clientobjid = level.var_7ac9346b[waitresult.clientnum];
        if (isdefined(clientobjid)) {
            objective_delete(localclientnum, clientobjid);
            util::releaseobjid(localclientnum, clientobjid);
            level.var_7ac9346b[waitresult.clientnum] = undefined;
        }
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x65bcbe8b, Offset: 0x7c0
// Size: 0x2e4
function function_eb5cd524() {
    localclientnum = 0;
    mapbundle = map::get_script_bundle();
    var_9136ef38 = [];
    if (isdefined(mapbundle) && isdefined(mapbundle.destinationlabellist)) {
        foreach (destinationlabel in mapbundle.destinationlabellist) {
            var_9136ef38[destinationlabel.targetname] = destinationlabel.displayname;
        }
    }
    foreach (struct in level.struct) {
        if (isdefined(struct.targetname) && isdefined(var_9136ef38[struct.targetname])) {
            function_a60f6936(localclientnum, var_9136ef38[struct.targetname], struct.origin);
            var_9136ef38[struct.targetname] = undefined;
        }
        if (struct.classname === "script_struct") {
            struct.classname = undefined;
        }
    }
    /#
        foreach (destname in var_9136ef38) {
            level.var_b8d1d6b6 = (isdefined(level.var_b8d1d6b6) ? level.var_b8d1d6b6 : 0) + 1;
            level.var_16631083 = (isdefined(level.var_16631083) ? level.var_16631083 : "<dev string:x30>") + destinationlabel.targetname + "<dev string:x31>";
        }
        if (isdefined(level.var_b8d1d6b6)) {
            errormsg(level.var_b8d1d6b6 + "<dev string:x34>" + level.var_16631083);
        }
    #/
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x295fbbbc, Offset: 0xab0
// Size: 0x256
function function_b550f1d2() {
    self endoncallback(&function_582e407c, #"death");
    self endon(#"disconnect");
    assert(!isdefined(self.var_791522dd));
    self.var_791522dd = spawn(0, (0, 0, 0), "script_origin");
    var_791522dd = self.var_791522dd;
    var_791522dd.var_85707b30 = var_791522dd playloopsound("amb_height_looper_mountain_fnt");
    var_791522dd.var_6e2d2d04 = var_791522dd playloopsound("amb_height_looper_mountain_bck");
    setsoundvolumerate(var_791522dd.var_85707b30, 1);
    setsoundvolumerate(var_791522dd.var_6e2d2d04, 1);
    while (true) {
        var_ba19d073 = self.origin[2];
        if (var_ba19d073 <= 3000) {
            setsoundvolume(var_791522dd.var_85707b30, 0);
            setsoundvolume(var_791522dd.var_6e2d2d04, 0);
        } else if (var_ba19d073 <= 7500) {
            var_640326c2 = (var_ba19d073 - 3000) / 4500;
            setsoundvolume(var_791522dd.var_85707b30, var_640326c2);
            setsoundvolume(var_791522dd.var_6e2d2d04, var_640326c2);
        } else {
            setsoundvolume(var_791522dd.var_85707b30, 1);
            setsoundvolume(var_791522dd.var_6e2d2d04, 1);
        }
        waitframe(1);
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x6b5c91d6, Offset: 0xd10
// Size: 0x2e
function function_582e407c(notifyhash) {
    self.var_791522dd delete();
    self.var_791522dd = undefined;
}

