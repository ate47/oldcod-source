#using scripts\core_common\filter_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\water_surface;

#namespace waterfall;

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x74525893, Offset: 0x110
// Size: 0xb8
function waterfalloverlay(localclientnum) {
    triggers = getentarray(localclientnum, "waterfall", "targetname");
    foreach (trigger in triggers) {
        trigger thread setupwaterfall(localclientnum);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x2d2a613f, Offset: 0x1d0
// Size: 0xb8
function waterfallmistoverlay(localclientnum) {
    triggers = getentarray(localclientnum, "waterfall_mist", "targetname");
    foreach (trigger in triggers) {
        trigger thread setupwaterfallmist(localclientnum);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0xe522e346, Offset: 0x290
// Size: 0x42
function waterfallmistoverlayreset(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    localplayer.rainopacity = 0;
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x4b79e090, Offset: 0x2e0
// Size: 0x130
function setupwaterfallmist(localclientnum) {
    level notify("setupWaterfallmist_waterfall_csc" + localclientnum);
    level endon("setupWaterfallmist_waterfall_csc" + localclientnum);
    trigger = self;
    for (;;) {
        waitresult = trigger waittill(#"trigger");
        trigplayer = waitresult.activator;
        if (!trigplayer function_60dbc438()) {
            continue;
        }
        localclientnum = trigplayer getlocalclientnumber();
        if (isdefined(localclientnum)) {
            localplayer = function_f97e7787(localclientnum);
        } else {
            localplayer = trigplayer;
        }
        filter::init_filter_sprite_rain(localplayer);
        trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall_mist, &trig_leave_waterfall_mist);
    }
}

// Namespace waterfall/waterfall
// Params 2, eflags: 0x0
// Checksum 0x8dfb4bf9, Offset: 0x418
// Size: 0x128
function setupwaterfall(localclientnum, localowner) {
    level notify("setupWaterfall_waterfall_csc" + localclientnum);
    level endon("setupWaterfall_waterfall_csc" + localclientnum);
    trigger = self;
    for (;;) {
        waitresult = trigger waittill(#"trigger");
        trigplayer = waitresult.activator;
        if (!trigplayer function_60dbc438()) {
            continue;
        }
        localclientnum = trigplayer getlocalclientnumber();
        if (isdefined(localclientnum)) {
            localplayer = function_f97e7787(localclientnum);
        } else {
            localplayer = trigplayer;
        }
        trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall, &trig_leave_waterfall);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x2b7a549a, Offset: 0x548
// Size: 0xc0
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
// Checksum 0x727a6d41, Offset: 0x610
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
// Checksum 0x78c361c3, Offset: 0x698
// Size: 0x1ce
function trig_enter_waterfall_mist(localplayer) {
    localplayer endon(#"death");
    trigger = self;
    if (!isdefined(localplayer.rainopacity)) {
        localplayer.rainopacity = 0;
    }
    if (localplayer.rainopacity == 0) {
        filter::set_filter_sprite_rain_seed_offset(localplayer, 0, randomfloat(1));
    }
    filter::enable_filter_sprite_rain(localplayer, 0);
    while (trigger istouching(localplayer)) {
        localclientnum = trigger.localclientnum;
        if (!isdefined(localclientnum)) {
            localclientnum = localplayer getlocalclientnumber();
        }
        if (isunderwater(localclientnum)) {
            filter::disable_filter_sprite_rain(localplayer, 0);
            break;
        }
        localplayer.rainopacity += 0.003;
        if (localplayer.rainopacity > 1) {
            localplayer.rainopacity = 1;
        }
        filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
        filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
        waitframe(1);
    }
}

// Namespace waterfall/waterfall
// Params 1, eflags: 0x0
// Checksum 0x43d18f7a, Offset: 0x870
// Size: 0x164
function trig_leave_waterfall_mist(localplayer) {
    localplayer endon(#"death");
    trigger = self;
    if (isdefined(localplayer.rainopacity)) {
        while (!trigger istouching(localplayer) && localplayer.rainopacity > 0) {
            localclientnum = trigger.localclientnum;
            if (isunderwater(localclientnum)) {
                filter::disable_filter_sprite_rain(localplayer, 0);
                break;
            }
            localplayer.rainopacity -= 0.005;
            filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
            filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
            waitframe(1);
        }
    }
    localplayer.rainopacity = 0;
    filter::disable_filter_sprite_rain(localplayer, 0);
}

