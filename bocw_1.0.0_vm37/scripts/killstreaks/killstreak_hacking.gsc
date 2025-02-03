#using scripts\core_common\clientfield_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;

#namespace killstreak_hacking;

// Namespace killstreak_hacking/killstreak_hacking
// Params 3, eflags: 0x0
// Checksum 0x74b800e6, Offset: 0xb8
// Size: 0x172
function enable_hacking(*killstreakname, prehackfunction, posthackfunction) {
    killstreak = self;
    level.challenge_scorestreaksenabled = 1;
    killstreak.challenge_isscorestreak = 1;
    killstreak.killstreak_hackedcallback = &_hacked_callback;
    killstreak.killstreakprehackfunction = prehackfunction;
    killstreak.killstreakposthackfunction = posthackfunction;
    killstreak.hackertoolinnertimems = killstreak killstreak_bundles::get_hack_tool_inner_time();
    killstreak.hackertooloutertimems = killstreak killstreak_bundles::get_hack_tool_outer_time();
    killstreak.hackertoolinnerradius = killstreak killstreak_bundles::get_hack_tool_inner_radius();
    killstreak.hackertoolouterradius = killstreak killstreak_bundles::get_hack_tool_outer_radius();
    killstreak.hackertoolradius = killstreak.hackertoolouterradius;
    killstreak.killstreakhackloopfx = killstreak killstreak_bundles::get_hack_loop_fx();
    killstreak.killstreakhackfx = killstreak killstreak_bundles::get_hack_fx();
    killstreak.killstreakhackscoreevent = killstreak killstreak_bundles::get_hack_scoreevent();
    killstreak.killstreakhacklostlineofsightlimitms = killstreak killstreak_bundles::get_lost_line_of_sight_limit_msec();
    killstreak.killstreakhacklostlineofsighttimems = killstreak killstreak_bundles::get_hack_tool_no_line_of_sight_time();
    killstreak.killstreak_hackedprotection = killstreak killstreak_bundles::get_hack_protection();
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0x5fb6431b, Offset: 0x238
// Size: 0x1e
function disable_hacking() {
    killstreak = self;
    killstreak.killstreak_hackedcallback = undefined;
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0xeef4f340, Offset: 0x260
// Size: 0x5c
function hackerfx() {
    killstreak = self;
    if (isdefined(killstreak.killstreakhackfx) && killstreak.killstreakhackfx != "") {
        playfxontag(killstreak.killstreakhackfx, killstreak, "tag_origin");
    }
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0xaa2bb5e1, Offset: 0x2c8
// Size: 0x5c
function hackerloopfx() {
    killstreak = self;
    if (isdefined(killstreak.killstreakloophackfx) && killstreak.killstreakloophackfx != "") {
        playfxontag(killstreak.killstreakloophackfx, killstreak, "tag_origin");
    }
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 1, eflags: 0x4
// Checksum 0x73d5c6, Offset: 0x330
// Size: 0x19c
function private _hacked_callback(hacker) {
    killstreak = self;
    originalowner = killstreak.owner;
    if (isdefined(killstreak.killstreakhackscoreevent)) {
        scoreevents::processscoreevent(killstreak.killstreakhackscoreevent, hacker, originalowner, level.weaponhackertool);
    }
    if (isdefined(killstreak.killstreakprehackfunction)) {
        killstreak thread [[ killstreak.killstreakprehackfunction ]](hacker);
    }
    killstreak killstreaks::configure_team_internal(hacker, 1);
    killstreak clientfield::set("enemyvehicle", 2);
    if (isdefined(killstreak.killstreakhackfx)) {
        killstreak thread hackerfx();
    }
    if (isdefined(killstreak.killstreakhackloopfx)) {
        killstreak thread hackerloopfx();
    }
    if (isdefined(killstreak.killstreakposthackfunction)) {
        killstreak thread [[ killstreak.killstreakposthackfunction ]](hacker);
    }
    killstreaktype = killstreak.killstreaktype;
    if (isdefined(killstreak.hackedkillstreakref)) {
        killstreaktype = killstreak.hackedkillstreakref;
    }
    level thread popups::displaykillstreakhackedteammessagetoall(killstreaktype, hacker);
    killstreak _update_health(hacker);
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 1, eflags: 0x0
// Checksum 0x35565aa9, Offset: 0x4d8
// Size: 0x26
function override_hacked_killstreak_reference(killstreakref) {
    killstreak = self;
    killstreak.hackedkillstreakref = killstreakref;
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0x8e0a7eab, Offset: 0x508
// Size: 0x9a
function get_hacked_timeout_duration_ms() {
    killstreak = self;
    timeout = killstreak killstreak_bundles::get_hack_timeout();
    if (!isdefined(timeout) || timeout <= 0) {
        assertmsg("<dev string:x38>" + killstreak.killstreaktype + "<dev string:x63>");
        return;
    }
    return int(timeout * 1000);
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 2, eflags: 0x0
// Checksum 0xab7b19dd, Offset: 0x5b0
// Size: 0x5a
function set_vehicle_drivable_time_starting_now(killstreak, duration_ms = -1) {
    if (duration_ms == -1) {
        duration_ms = killstreak get_hacked_timeout_duration_ms();
    }
    return self vehicle::set_vehicle_drivable_time_starting_now(duration_ms);
}

// Namespace killstreak_hacking/killstreak_hacking
// Params 1, eflags: 0x0
// Checksum 0xf87d8075, Offset: 0x618
// Size: 0xdc
function _update_health(hacker) {
    killstreak = self;
    if (isdefined(killstreak.hackedhealthupdatecallback)) {
        killstreak [[ killstreak.hackedhealthupdatecallback ]](hacker);
        return;
    }
    if (issentient(killstreak)) {
        hackedhealth = killstreak_bundles::get_hacked_health(killstreak.killstreaktype);
        assert(isdefined(hackedhealth));
        if (self.health > hackedhealth) {
            self.health = hackedhealth;
        }
        return;
    }
    /#
        hacker iprintlnbold("<dev string:x9d>");
    #/
}

/#

    // Namespace killstreak_hacking/killstreak_hacking
    // Params 0, eflags: 0x0
    // Checksum 0x30a96290, Offset: 0x700
    // Size: 0x28
    function killstreak_switch_team_end() {
        killstreakentity = self;
        killstreakentity notify(#"killstreak_switch_team_end");
    }

    // Namespace killstreak_hacking/killstreak_hacking
    // Params 1, eflags: 0x0
    // Checksum 0xb6a76de4, Offset: 0x730
    // Size: 0x21a
    function killstreak_switch_team(owner) {
        killstreakentity = self;
        killstreakentity notify(#"killstreak_switch_team_singleton");
        killstreakentity endon(#"killstreak_switch_team_singleton", #"death");
        setdvar(#"scr_killstreak_switch_team", "<dev string:xc7>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint(#"scr_killstreak_switch_team", 0);
            if (devgui_int != 0) {
                team = "<dev string:xcb>";
                if (isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
                    team = [[ level.getenemyteam ]](owner.team);
                }
                if (isdefined(level.devongetormakebot)) {
                    player = [[ level.devongetormakebot ]](team);
                }
                if (!isdefined(player)) {
                    println("<dev string:xd9>");
                    wait 1;
                    continue;
                }
                if (!isdefined(killstreakentity.killstreak_hackedcallback)) {
                    /#
                        iprintlnbold("<dev string:xf6>");
                    #/
                    return;
                }
                killstreakentity notify(#"killstreak_hacked", {#hacker:player});
                killstreakentity.previouslyhacked = 1;
                killstreakentity [[ killstreakentity.killstreak_hackedcallback ]](player);
                wait 0.5;
                setdvar(#"scr_killstreak_switch_team", 0);
                return;
            }
        }
    }

#/
