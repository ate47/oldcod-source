#using scripts\core_common\postfx_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\water_surface;

#namespace waterfall;

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x799d3604, Offset: 0xf0
// Size: 0xc0
function waterfalloverlay(localclientnum) {
    triggers = getentarray(localclientnum, "waterfall", "targetname");
    foreach (trigger in triggers) {
        trigger thread setupwaterfall(localclientnum);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0xaf48947c, Offset: 0x1b8
// Size: 0xc0
function waterfallmistoverlay(localclientnum) {
    triggers = getentarray(localclientnum, "waterfall_mist", "targetname");
    foreach (trigger in triggers) {
        trigger thread setupwaterfallmist(localclientnum);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x3de5e6e0, Offset: 0x280
// Size: 0x3e
function waterfallmistoverlayreset(localclientnum) {
    localplayer = function_5c10bd79(localclientnum);
    localplayer.rainopacity = 0;
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0xeeba0a98, Offset: 0x2c8
// Size: 0x118
function setupwaterfallmist(localclientnum) {
    level notify("setupWaterfallmist_waterfall_csc" + localclientnum);
    level endon("setupWaterfallmist_waterfall_csc" + localclientnum);
    trigger = self;
    for (;;) {
        waitresult = trigger waittill(#"trigger");
        trigplayer = waitresult.activator;
        if (!trigplayer function_21c0fa55()) {
            continue;
        }
        localclientnum = trigplayer getlocalclientnumber();
        if (isdefined(localclientnum)) {
            localplayer = function_5c10bd79(localclientnum);
        } else {
            localplayer = trigplayer;
        }
        trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall_mist, &trig_leave_waterfall_mist);
    }
}

// Namespace waterfall/waterfall
// Params 2, eflags: 0x0
// Checksum 0xae4e0fe7, Offset: 0x3e8
// Size: 0x140
function setupwaterfall(localclientnum, *localowner) {
    level notify(#"setupwaterfall_waterfall_csc" + string(localowner));
    level endon(#"setupwaterfall_waterfall_csc" + string(localowner));
    trigger = self;
    for (;;) {
        waitresult = trigger waittill(#"trigger");
        trigplayer = waitresult.activator;
        if (!trigplayer function_21c0fa55()) {
            continue;
        }
        localowner = trigplayer getlocalclientnumber();
        if (isdefined(localowner)) {
            localplayer = function_5c10bd79(localowner);
        } else {
            localplayer = trigplayer;
        }
        trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall, &trig_leave_waterfall);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x2b9cd2eb, Offset: 0x530
// Size: 0xb8
function trig_enter_waterfall(localplayer) {
    trigger = self;
    localclientnum = localplayer.localclientnum;
    localplayer thread postfx::playpostfxbundle(#"pstfx_waterfall");
    playsound(0, #"amb_waterfall_hit", (0, 0, 0));
    while (trigger istouching(localplayer)) {
        localplayer playrumbleonentity(localclientnum, "waterfall_rumble");
        wait 0.1;
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x5707e7b2, Offset: 0x5f0
// Size: 0x7c
function trig_leave_waterfall(localplayer) {
    trigger = self;
    localclientnum = localplayer.localclientnum;
    localplayer postfx::stoppostfxbundle("pstfx_waterfall");
    if (isunderwater(localclientnum) == 0) {
        localplayer thread water_surface::startwatersheeting();
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0xbf754ed7, Offset: 0x678
// Size: 0xf4
function trig_enter_waterfall_mist(localplayer) {
    localplayer endon(#"death");
    trigger = self;
    if (!isdefined(localplayer.rainopacity)) {
        localplayer.rainopacity = 0;
    }
    while (trigger istouching(localplayer)) {
        localclientnum = trigger.localclientnum;
        if (!isdefined(localclientnum)) {
            localclientnum = localplayer getlocalclientnumber();
        }
        if (isunderwater(localclientnum)) {
            break;
        }
        localplayer.rainopacity += 0.003;
        if (localplayer.rainopacity > 1) {
            localplayer.rainopacity = 1;
        }
        waitframe(1);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0xf675188c, Offset: 0x778
// Size: 0xda
function trig_leave_waterfall_mist(localplayer) {
    localplayer endon(#"death");
    trigger = self;
    if (isdefined(localplayer.rainopacity)) {
        while (!trigger istouching(localplayer) && localplayer.rainopacity > 0) {
            localclientnum = trigger.localclientnum;
            if (isunderwater(localclientnum)) {
                break;
            }
            localplayer.rainopacity -= 0.005;
            waitframe(1);
        }
    }
    localplayer.rainopacity = 0;
}

