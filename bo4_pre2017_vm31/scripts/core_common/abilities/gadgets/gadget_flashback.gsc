#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace flashback;

// Namespace flashback/gadget_flashback
// Params 0, eflags: 0x2
// Checksum 0x12b74f3c, Offset: 0x390
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_flashback", &__init__, undefined, undefined);
}

// Namespace flashback/gadget_flashback
// Params 0, eflags: 0x0
// Checksum 0xad0f5c52, Offset: 0x3d0
// Size: 0x21c
function __init__() {
    clientfield::register("scriptmover", "flashback_trail_fx", 1, 1, "int");
    clientfield::register("playercorpse", "flashback_clone", 1, 1, "int");
    clientfield::register("allplayers", "flashback_activated", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(16, &gadget_flashback_on, &gadget_flashback_off);
    ability_player::register_gadget_possession_callbacks(16, &gadget_flashback_on_give, &gadget_flashback_on_take);
    ability_player::register_gadget_flicker_callbacks(16, &gadget_flashback_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(16, &gadget_flashback_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(16, &gadget_flashback_is_flickering);
    ability_player::register_gadget_primed_callbacks(16, &gadget_flashback_is_primed);
    callback::on_connect(&gadget_flashback_on_connect);
    callback::on_spawned(&gadget_flashback_spawned);
    if (!isdefined(level.vsmgr_prio_overlay_flashback_warp)) {
        level.vsmgr_prio_overlay_flashback_warp = 27;
    }
    visionset_mgr::register_info("overlay", "flashback_warp", 1, level.vsmgr_prio_overlay_flashback_warp, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace flashback/gadget_flashback
// Params 0, eflags: 0x0
// Checksum 0x312c677b, Offset: 0x5f8
// Size: 0x24
function gadget_flashback_spawned() {
    self clientfield::set("flashback_activated", 0);
}

// Namespace flashback/gadget_flashback
// Params 1, eflags: 0x0
// Checksum 0xabc4c4dd, Offset: 0x628
// Size: 0x2a
function gadget_flashback_is_inuse(slot) {
    return self flagsys::get("gadget_flashback_on");
}

// Namespace flashback/gadget_flashback
// Params 1, eflags: 0x0
// Checksum 0x2fd63aeb, Offset: 0x660
// Size: 0x22
function gadget_flashback_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0x282fee35, Offset: 0x690
// Size: 0x14
function gadget_flashback_on_flicker(slot, weapon) {
    
}

// Namespace flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0x17144e5a, Offset: 0x6b0
// Size: 0x14
function gadget_flashback_on_give(slot, weapon) {
    
}

// Namespace flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0x55bf772a, Offset: 0x6d0
// Size: 0x14
function gadget_flashback_on_take(slot, weapon) {
    
}

// Namespace flashback/gadget_flashback
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6f0
// Size: 0x4
function gadget_flashback_on_connect() {
    
}

// Namespace flashback/gadget_flashback
// Params 0, eflags: 0x0
// Checksum 0x4b51cb7, Offset: 0x700
// Size: 0x4c
function clone_watch_death() {
    self endon(#"death");
    wait 1;
    self clientfield::set("flashback_clone", 0);
    self ghost();
}

/#

    // Namespace flashback/gadget_flashback
    // Params 3, eflags: 0x0
    // Checksum 0x8fa83d7a, Offset: 0x758
    // Size: 0x8c
    function debug_star(origin, seconds, color) {
        if (!isdefined(seconds)) {
            seconds = 1;
        }
        if (!isdefined(color)) {
            color = (1, 0, 0);
        }
        frames = int(20 * seconds);
        debugstar(origin, frames, color);
    }

#/

// Namespace flashback/gadget_flashback
// Params 1, eflags: 0x0
// Checksum 0xfec853a4, Offset: 0x7f0
// Size: 0xca
function drop_unlinked_grenades(linkedgrenades) {
    waittillframeend();
    foreach (grenade in linkedgrenades) {
        grenade launch((randomfloatrange(-5, 5), randomfloatrange(-5, 5), 5));
    }
}

// Namespace flashback/gadget_flashback
// Params 1, eflags: 0x0
// Checksum 0xd151565, Offset: 0x8c8
// Size: 0x18c
function unlink_grenades(oldpos) {
    radius = 32;
    origin = oldpos;
    grenades = getentarray("grenade", "classname");
    radiussq = radius * radius;
    linkedgrenades = [];
    foreach (grenade in grenades) {
        if (distancesquared(origin, grenade.origin) < radiussq) {
            if (isdefined(grenade.stucktoplayer) && grenade.stucktoplayer == self) {
                grenade unlink();
                linkedgrenades[linkedgrenades.size] = grenade;
            }
        }
    }
    thread drop_unlinked_grenades(linkedgrenades);
}

// Namespace flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0x825c6020, Offset: 0xa60
// Size: 0x26c
function gadget_flashback_on(slot, weapon) {
    self flagsys::set("gadget_flashback_on");
    self gadgetsetactivatetime(slot, gettime());
    visionset_mgr::activate("overlay", "flashback_warp", self, 0.8, 0.8);
    self.flashbacktime = gettime();
    self notify(#"flashback");
    clone = self createflashbackclone();
    clone thread clone_watch_death();
    clone clientfield::set("flashback_clone", 1);
    self thread watchclientfields();
    oldpos = self gettagorigin("j_spineupper");
    offset = oldpos - self.origin;
    self unlink_grenades(oldpos);
    newpos = self flashbackstart(weapon) + offset;
    self notsolid();
    if (isdefined(newpos) && isdefined(oldpos)) {
        self thread flashbacktrailfx(slot, weapon, oldpos, newpos);
        flashbacktrailimpact(newpos, oldpos, 8);
        flashbacktrailimpact(oldpos, newpos, 8);
        if (isdefined(level.playgadgetsuccess)) {
            self [[ level.playgadgetsuccess ]](weapon, "flashbackSuccessDelay");
        }
    }
    self thread deactivateflashbackwarpaftertime(0.8);
}

// Namespace flashback/gadget_flashback
// Params 0, eflags: 0x0
// Checksum 0xd0af9ed8, Offset: 0xcd8
// Size: 0x7c
function watchclientfields() {
    self endon(#"death");
    self endon(#"disconnect");
    util::wait_network_frame();
    self clientfield::set("flashback_activated", 1);
    util::wait_network_frame();
    self clientfield::set("flashback_activated", 0);
}

// Namespace flashback/gadget_flashback
// Params 3, eflags: 0x0
// Checksum 0x8d2f6edf, Offset: 0xd60
// Size: 0xfc
function flashbacktrailimpact(startpos, endpos, recursiondepth) {
    recursiondepth--;
    if (recursiondepth <= 0) {
        return;
    }
    trace = bullettrace(startpos, endpos, 0, self);
    if (trace["fraction"] < 1 && trace["normal"] != (0, 0, 0)) {
        playfx("player/fx_plyr_flashback_trail_impact", trace["position"], trace["normal"]);
        newstartpos = trace["position"] - trace["normal"];
        /#
        #/
        flashbacktrailimpact(newstartpos, endpos, recursiondepth);
    }
}

// Namespace flashback/gadget_flashback
// Params 1, eflags: 0x0
// Checksum 0x352b76c5, Offset: 0xe68
// Size: 0x4c
function deactivateflashbackwarpaftertime(time) {
    self endon(#"disconnect");
    self waittilltimeout(time, "death");
    visionset_mgr::deactivate("overlay", "flashback_warp", self);
}

// Namespace flashback/gadget_flashback
// Params 4, eflags: 0x0
// Checksum 0x3f36b2ca, Offset: 0xec0
// Size: 0x1ec
function flashbacktrailfx(slot, weapon, oldpos, newpos) {
    dirvec = newpos - oldpos;
    if (dirvec == (0, 0, 0)) {
        dirvec = (0, 0, 1);
    }
    dirvec = vectornormalize(dirvec);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", oldpos, 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("flashback_trail_fx", 1);
    util::wait_network_frame();
    tagpos = self gettagorigin("j_spineupper");
    fxorg moveto(tagpos, 0.1);
    fxorg waittill("movedone");
    wait 1;
    fxorg clientfield::set("flashback_trail_fx", 0);
    util::wait_network_frame();
    fxorg delete();
}

// Namespace flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0xb6a104a4, Offset: 0x10b8
// Size: 0x14
function gadget_flashback_is_primed(slot, weapon) {
    
}

// Namespace flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0xfac92faa, Offset: 0x10d8
// Size: 0x8c
function gadget_flashback_off(slot, weapon) {
    self flagsys::clear("gadget_flashback_on");
    self solid();
    self flashbackfinish();
    if (level.gameended) {
        self freezecontrols(1);
    }
}

