#using script_354f0cf6dd1c85c4;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\util_shared;

#namespace escort;

// Namespace escort/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x9e735f9e, Offset: 0x128
// Size: 0xbc
function event_handler[gametype_init] main(eventstruct) {
    clientfield::register("actor", "robot_state", 1, 2, "int", &function_76a7d70, 0, 1);
    clientfield::register("actor", "escort_robot_burn", 1, 1, "int", &robot_burn, 0, 0);
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x1841cfff, Offset: 0x1f0
// Size: 0xec
function on_localclient_connect(localclientnum) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusText"), #"hash_3840e31ec5ca2817");
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
    level wait_team_changed(localclientnum);
}

// Namespace escort/escort
// Params 7, eflags: 0x0
// Checksum 0x5923484c, Offset: 0x2e8
// Size: 0xb4
function robot_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self endon(#"death");
        self util::waittill_dobj(localclientnum);
        fxhandles = playtagfxset(localclientnum, "escort_robot_burn", self);
        self thread watch_fx_shutdown(localclientnum, fxhandles);
    }
}

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0x95999f20, Offset: 0x3a8
// Size: 0x90
function watch_fx_shutdown(localclientnum, fxhandles) {
    wait 3;
    foreach (fx in fxhandles) {
        stopfx(localclientnum, fx);
    }
}

// Namespace escort/escort
// Params 7, eflags: 0x0
// Checksum 0xeed338fd, Offset: 0x440
// Size: 0x17c
function function_76a7d70(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent) {
        if (!isdefined(level.escortrobots)) {
            level.escortrobots = [];
        } else if (!isarray(level.escortrobots)) {
            level.escortrobots = array(level.escortrobots);
        }
        level.escortrobots[level.escortrobots.size] = self;
        self thread update_robot_team(localclientnum);
    }
    if (newval == 1) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 1);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 0);
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0xab85ecbd, Offset: 0x5c8
// Size: 0xc4
function wait_team_changed(localclientnum) {
    while (true) {
        level waittill(#"team_changed");
        if (!isdefined(level.escortrobots)) {
            continue;
        }
        foreach (robot in level.escortrobots) {
            robot thread update_robot_team(localclientnum);
        }
    }
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x45e6de8, Offset: 0x698
// Size: 0x164
function update_robot_team(localclientnum) {
    localplayerteam = function_e4542aa3(localclientnum);
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        friend = self shoutcaster::is_friendly(localclientnum);
    } else {
        friend = self.team == localplayerteam;
    }
    if (friend) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
    } else {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 1);
    }
    self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
    localplayer = function_f97e7787(localclientnum);
    localplayer duplicate_render::update_dr_filters(localclientnum);
}

