#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/flashgrenades;

#namespace hacker_tool;

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0x3520d1a1, Offset: 0x2b8
// Size: 0x9c
function init_shared() {
    clientfield::register("toplayer", "hacker_tool", 1, 2, "int", &player_hacking, 0, 0);
    level.hackingsoundid = [];
    level.hackingsweetspotid = [];
    level.friendlyhackingsoundid = [];
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x581ccdf8, Offset: 0x360
// Size: 0x12c
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    player = self;
    if (isdefined(level.hackingsoundid[localclientnum])) {
        player stoploopsound(level.hackingsoundid[localclientnum]);
        level.hackingsoundid[localclientnum] = undefined;
    }
    if (isdefined(level.hackingsweetspotid[localclientnum])) {
        player stoploopsound(level.hackingsweetspotid[localclientnum]);
        level.hackingsweetspotid[localclientnum] = undefined;
    }
    if (isdefined(level.friendlyhackingsoundid[localclientnum])) {
        player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
        level.friendlyhackingsoundid[localclientnum] = undefined;
    }
}

// Namespace hacker_tool/hacker_tool
// Params 7, eflags: 0x0
// Checksum 0x9d8e3e4a, Offset: 0x498
// Size: 0x4b4
function player_hacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"player_hacking_callback");
    player = self;
    if (isdefined(level.hackingsoundid[localclientnum])) {
        player stoploopsound(level.hackingsoundid[localclientnum]);
        level.hackingsoundid[localclientnum] = undefined;
    }
    if (isdefined(level.hackingsweetspotid[localclientnum])) {
        player stoploopsound(level.hackingsweetspotid[localclientnum]);
        level.hackingsweetspotid[localclientnum] = undefined;
    }
    if (isdefined(level.friendlyhackingsoundid[localclientnum])) {
        player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
        level.friendlyhackingsoundid[localclientnum] = undefined;
    }
    if (isdefined(player.targetent)) {
        player.targetent duplicate_render::set_hacker_tool_hacking(localclientnum, 0);
        player.targetent duplicate_render::set_hacker_tool_breaching(localclientnum, 0);
        player.targetent.isbreachingfirewall = 0;
        player.targetent = undefined;
    }
    if (newval == 2) {
        player thread watchhackspeed(localclientnum, 0);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 2);
        return;
    }
    if (newval == 3) {
        player thread watchhackspeed(localclientnum, 1);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 1);
        return;
    }
    if (newval == 1) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 0);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.perc"), 0);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.offsetShaderValue"), 0 + " " + 0 + " 0 0");
        self thread watchforemp(localclientnum);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.perc"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.offsetShaderValue"), 0 + " " + 0 + " 0 0");
}

// Namespace hacker_tool/hacker_tool
// Params 2, eflags: 0x0
// Checksum 0xf18d5016, Offset: 0x958
// Size: 0xb4
function watchhackspeed(localclientnum, isbreachingfirewall) {
    self endon(#"death");
    self endon(#"player_hacking_callback");
    player = self;
    for (;;) {
        targetentarray = self gettargetlockentityarray();
        if (targetentarray.size > 0) {
            targetent = targetentarray[0];
            break;
        }
        wait 0.02;
    }
    targetent watchtargethack(localclientnum, player, isbreachingfirewall);
}

// Namespace hacker_tool/hacker_tool
// Params 3, eflags: 0x0
// Checksum 0x56ee116f, Offset: 0xa18
// Size: 0x468
function watchtargethack(localclientnum, player, isbreachingfirewall) {
    self endon(#"death");
    player endon(#"death");
    self endon(#"player_hacking_callback");
    targetent = self;
    player.targetent = targetent;
    if (isbreachingfirewall) {
        targetent.isbreachingfirewall = 1;
        targetent duplicate_render::set_hacker_tool_breaching(localclientnum, 1);
    }
    targetent thread watchhackerplayershutdown(localclientnum, player, targetent);
    for (;;) {
        distancefromcenter = targetent getdistancefromscreencenter(localclientnum);
        inverse = 40 - distancefromcenter;
        ratio = inverse / 40;
        heatval = getweaponhackratio(localclientnum);
        ratio = ratio * ratio * ratio * ratio;
        if (ratio > 1 || ratio < 0.001) {
            ratio = 0;
            horizontal = 0;
        } else {
            horizontal = targetent gethorizontaloffsetfromscreencenter(localclientnum, 40);
        }
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.offsetShaderValue"), horizontal + " " + ratio + " 0 0");
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.perc"), heatval);
        if (ratio > 0.8) {
            if (!isdefined(level.hackingsweetspotid[localclientnum])) {
                level.hackingsweetspotid[localclientnum] = player playloopsound("evt_hacker_hacking_sweet");
            }
        } else {
            if (isdefined(level.hackingsweetspotid[localclientnum])) {
                player stoploopsound(level.hackingsweetspotid[localclientnum]);
                level.hackingsweetspotid[localclientnum] = undefined;
            }
            if (!isdefined(level.hackingsoundid[localclientnum])) {
                level.hackingsoundid[localclientnum] = player playloopsound("evt_hacker_hacking_loop");
            }
            if (isdefined(level.hackingsoundid[localclientnum])) {
                setsoundpitch(level.hackingsoundid[localclientnum], ratio);
            }
        }
        if (!isbreachingfirewall) {
            friendlyhacking = weaponfriendlyhacking(localclientnum);
            if (friendlyhacking && !isdefined(level.friendlyhackingsoundid[localclientnum])) {
                level.friendlyhackingsoundid[localclientnum] = player playloopsound("evt_hacker_hacking_loop_mult");
            } else if (!friendlyhacking && isdefined(level.friendlyhackingsoundid[localclientnum])) {
                player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
                level.friendlyhackingsoundid[localclientnum] = undefined;
            }
        }
        wait 0.1;
    }
}

// Namespace hacker_tool/hacker_tool
// Params 3, eflags: 0x0
// Checksum 0xd31e420b, Offset: 0xe88
// Size: 0xb4
function watchhackerplayershutdown(localclientnum, hackerplayer, targetent) {
    self endon(#"death");
    killstreakentity = self;
    hackerplayer endon(#"player_hacking_callback");
    hackerplayer waittill("death");
    if (isdefined(targetent)) {
        targetent.isbreachingfirewall = 1;
    }
    killstreakentity duplicate_render::set_hacker_tool_hacking(localclientnum, 0);
    killstreakentity duplicate_render::set_hacker_tool_breaching(localclientnum, 0);
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x4937d378, Offset: 0xf48
// Size: 0xe0
function watchforemp(localclientnum) {
    self endon(#"death");
    self endon(#"player_hacking_callback");
    while (true) {
        if (self isempjammed()) {
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 3);
        } else {
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 0);
        }
        wait 0.1;
    }
}

