#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/oob;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/smokegrenade;

#namespace resurrect;

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x2
// Checksum 0x98f09187, Offset: 0x560
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_resurrect", &__init__, undefined, undefined);
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x3e5442fd, Offset: 0x5a0
// Size: 0x2f4
function __init__() {
    clientfield::register("allplayers", "resurrecting", 1, 1, "int");
    clientfield::register("toplayer", "resurrect_state", 1, 2, "int");
    clientfield::register("clientuimodel", "hudItems.rejack.activationWindowEntered", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.rejack.rejackActivated", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(40, &gadget_resurrect_on, &gadget_resurrect_off);
    ability_player::register_gadget_possession_callbacks(40, &gadget_resurrect_on_give, &gadget_resurrect_on_take);
    ability_player::register_gadget_flicker_callbacks(40, &gadget_resurrect_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(40, &gadget_resurrect_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(40, &gadget_resurrect_is_flickering);
    ability_player::register_gadget_primed_callbacks(40, &gadget_resurrect_is_primed);
    ability_player::register_gadget_ready_callbacks(40, &gadget_resurrect_is_ready);
    callback::on_connect(&gadget_resurrect_on_connect);
    callback::on_spawned(&gadget_resurrect_on_spawned);
    if (!isdefined(level.vsmgr_prio_visionset_resurrect)) {
        level.vsmgr_prio_visionset_resurrect = 62;
    }
    if (!isdefined(level.vsmgr_prio_visionset_resurrect_up)) {
        level.vsmgr_prio_visionset_resurrect_up = 63;
    }
    level.resurrect_override_spawn = &overridespawn;
    visionset_mgr::register_info("visionset", "resurrect", 1, level.vsmgr_prio_visionset_resurrect, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    visionset_mgr::register_info("visionset", "resurrect_up", 1, level.vsmgr_prio_visionset_resurrect_up, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x6fdb486f, Offset: 0x8a0
// Size: 0x22
function gadget_resurrect_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x537a8ff9, Offset: 0x8d0
// Size: 0x22
function gadget_resurrect_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0xa554fabc, Offset: 0x900
// Size: 0x14
function gadget_resurrect_on_flicker(slot, weapon) {
    
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0xbe27b70b, Offset: 0x920
// Size: 0x30
function gadget_resurrect_on_give(slot, weapon) {
    self.usedresurrect = 0;
    self.resurrect_weapon = weapon;
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0xf29b7e11, Offset: 0x958
// Size: 0x3a
function gadget_resurrect_on_take(slot, weapon) {
    self.overrideplayerdeadstatus = undefined;
    self.resurrect_weapon = undefined;
    self.secondarydeathcamtime = undefined;
    self notify(#"resurrect_taken");
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x2063fe5e, Offset: 0x9a0
// Size: 0x104
function gadget_resurrect_on_spawned() {
    self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 0);
    self val::reset("gadget_resurrect", "show_hud");
    self._disable_proximity_alarms = 0;
    self flagsys::clear("gadget_resurrect_ready");
    self flagsys::clear("gadget_resurrect_pending");
    if (self flagsys::get("gadget_resurrect_activated")) {
        self thread do_resurrected_on_spawned_player_fx();
        self thread resurrect_drain_power();
        self flagsys::clear("gadget_resurrect_activated");
    }
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x435ac088, Offset: 0xab0
// Size: 0xb4
function resurrect_drain_power(amount) {
    if (isdefined(self.resurrect_weapon)) {
        slot = self gadgetgetslot(self.resurrect_weapon);
        if (slot >= 0 && slot < 4) {
            if (isdefined(amount)) {
                self gadgetpowerchange(slot, amount);
                return;
            }
            self gadgetstatechange(slot, self.resurrect_weapon, 3);
        }
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xb70
// Size: 0x4
function gadget_resurrect_on_connect() {
    
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0x1e619a92, Offset: 0xb80
// Size: 0x14
function gadget_resurrect_on(slot, weapon) {
    
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x60b972cf, Offset: 0xba0
// Size: 0x190
function watch_smoke_detonate() {
    self endon(#"player_input_suicide");
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        if ((self isplayerswimming() || self isonground()) && !self iswallrunning() && !self istraversing()) {
            smoke_weapon = getweapon("gadget_resurrect_smoke_grenade");
            stat_weapon = getweapon("gadget_resurrect");
            smokeeffect = smokegrenade::smokedetonate(self, stat_weapon, smoke_weapon, self.origin, 128, 5, 4);
            smokeeffect thread watch_smoke_effect_watch_suicide(self);
            smokeeffect thread watch_smoke_effect_watch_resurrect(self);
            smokeeffect thread watch_smoke_death(self);
            return;
        }
        waitframe(1);
    }
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x75c7940f, Offset: 0xd38
// Size: 0x4c
function watch_smoke_death(player) {
    self endon(#"death");
    player waittilltimeout(5, "disconnect", "death");
    self delete();
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x5e0500ba, Offset: 0xd90
// Size: 0x3c
function watch_smoke_effect_watch_suicide(player) {
    self endon(#"death");
    player waittill("player_input_suicide");
    self delete();
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0xbd053f64, Offset: 0xdd8
// Size: 0x44
function watch_smoke_effect_watch_resurrect(player) {
    self endon(#"death");
    player waittill("player_input_revive");
    wait 0.5;
    self delete();
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0x21191166, Offset: 0xe28
// Size: 0x114
function gadget_resurrect_is_primed(slot, weapon) {
    if (isdefined(self.resurrect_not_allowed_by)) {
        return;
    }
    self startresurrectviewangletransition();
    self.lastwaterdamagetime = gettime();
    self._disable_proximity_alarms = 1;
    self thread watch_smoke_detonate();
    self val::set("gadget_resurrect", "show_hud", 0);
    visionset_mgr::activate("visionset", "resurrect", self, 1.4, 4, 0.25);
    self clientfield::set_to_player("resurrect_state", 1);
    self shellshock("resurrect", 5.4, 0);
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0x5bc5706c, Offset: 0xf48
// Size: 0x14
function gadget_resurrect_is_ready(slot, weapon) {
    
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0xd7c90958, Offset: 0xfc0
// Size: 0x4c
function gadget_resurrect_start(slot, weapon) {
    wait 0.1;
    self gadgetsetactivatetime(slot, gettime());
    self thread resurrect_delay(weapon);
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0x2af657d5, Offset: 0x1018
// Size: 0x22
function gadget_resurrect_off(slot, weapon) {
    self notify(#"gadget_resurrect_off");
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x70772d13, Offset: 0x1048
// Size: 0x4c
function resurrect_delay(weapon) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(#"death");
    self notify(#"resurrect_delay");
    self endon(#"resurrect_delay");
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0xb8fd058, Offset: 0x10a0
// Size: 0x8c
function overridespawn(ispredictedspawn) {
    if (!self flagsys::get("gadget_resurrect_ready")) {
        return false;
    }
    if (!self flagsys::get("gadget_resurrect_activated")) {
        return false;
    }
    if (!isdefined(self.resurrect_origin)) {
        self.resurrect_origin = self.origin;
        self.resurrect_angles = self.angles;
    }
    return true;
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x6bf6b424, Offset: 0x1138
// Size: 0x30
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x7d74cd02, Offset: 0x1170
// Size: 0x2e
function player_position_valid() {
    if (self clientfield::get_to_player("out_of_bounds")) {
        return false;
    }
    return true;
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x451bc8e1, Offset: 0x11a8
// Size: 0xa6
function resurrect_breadcrumbs(slot) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(#"resurrect_taken");
    self.resurrect_slot = slot;
    while (true) {
        if (isalive(self) && self player_position_valid()) {
            self.resurrect_origin = self.origin;
            self.resurrect_angles = self.angles;
        }
        wait 1;
    }
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x5f8849f5, Offset: 0x1258
// Size: 0x64
function glow_for_time(time) {
    self endon(#"disconnect");
    self clientfield::set("resurrecting", 1);
    wait time;
    self clientfield::set("resurrecting", 0);
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0xb11eb9ce, Offset: 0x12c8
// Size: 0x46
function wait_for_time(time, msg) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(msg);
    wait time;
    self notify(msg);
}

// Namespace resurrect/gadget_resurrect
// Params 1, eflags: 0x0
// Checksum 0x117504d1, Offset: 0x1318
// Size: 0x80
function wait_for_activate(msg) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(msg);
    while (true) {
        if (self offhandspecialbuttonpressed()) {
            self flagsys::set("gadget_resurrect_activated");
            self notify(msg);
        }
        waitframe(1);
    }
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0x17703093, Offset: 0x13a0
// Size: 0xbe
function bot_wait_for_activate(msg, time) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(msg);
    if (!self isbot()) {
        return;
    }
    time = int(time + 1);
    randwait = randomint(time);
    wait randwait;
    self flagsys::set("gadget_resurrect_activated");
    self notify(msg);
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xb8e61f06, Offset: 0x1468
// Size: 0xc4
function do_resurrect_hint_fx() {
    offset = (0, 0, 40);
    fxorg = spawn("script_model", self.resurrect_origin + offset);
    fxorg setmodel("tag_origin");
    fx = playfxontag("player/fx_plyr_revive", fxorg, "tag_origin");
    self waittill("resurrect_time_or_activate");
    fxorg delete();
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x6590dfc2, Offset: 0x1538
// Size: 0x7c
function do_resurrected_on_dead_body_fx() {
    if (isdefined(self.body)) {
        fx = playfx("player/fx_plyr_revive_demat", self.body.origin);
        self.body notsolid();
        self.body ghost();
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x1ef8b665, Offset: 0x15c0
// Size: 0x50
function do_resurrected_on_spawned_player_fx() {
    playsoundatposition("mpl_resurrect_npc", self.origin);
    fx = playfx("player/fx_plyr_rejack_light", self.origin);
}

// Namespace resurrect/gadget_resurrect
// Params 2, eflags: 0x0
// Checksum 0x810ec4f0, Offset: 0x1618
// Size: 0x260
function resurrect_watch_for_death(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self waittill("death");
    resurrect_time = 3;
    if (isdefined(weapon.gadget_resurrect_duration)) {
        resurrect_time = weapon.gadget_resurrect_duration / 1000;
    }
    self.usedresurrect = 0;
    self flagsys::clear("gadget_resurrect_activated");
    self flagsys::set("gadget_resurrect_pending");
    self.resurrect_available_time = gettime();
    self thread wait_for_time(resurrect_time, "resurrect_time_or_activate");
    self thread wait_for_activate("resurrect_time_or_activate");
    self thread bot_wait_for_activate("resurrect_time_or_activate", resurrect_time);
    self thread do_resurrect_hint_fx();
    self waittill("resurrect_time_or_activate");
    self flagsys::clear("gadget_resurrect_pending");
    if (self flagsys::get("gadget_resurrect_activated")) {
        self thread do_resurrected_on_dead_body_fx();
        self notify(#"end_death_delay");
        self notify(#"end_killcam");
        self.cancelkillcam = 1;
        self.usedresurrect = 1;
        self notify(#"end_death_delay");
        self notify(#"force_spawn");
        if (!(isdefined(1) && 1)) {
            self.pers["resetMomentumOnSpawn"] = 0;
        }
        if (isdefined(level.playgadgetsuccess)) {
            self [[ level.playgadgetsuccess ]](weapon, "resurrectSuccessDelay");
        }
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xa7d1c756, Offset: 0x1880
// Size: 0x2e
function gadget_resurrect_delay_updateteamstatus() {
    if (self flagsys::get("gadget_resurrect_ready")) {
        return true;
    }
    return false;
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x3924921b, Offset: 0x18b8
// Size: 0x78
function gadget_resurrect_is_player_predead() {
    should_not_be_dead = 0;
    if (self.sessionstate == "playing" && isalive(self)) {
        should_not_be_dead = 1;
    }
    if (self flagsys::get("gadget_resurrect_pending")) {
        return 1;
    }
    return should_not_be_dead;
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x25899256, Offset: 0x1938
// Size: 0xc6
function gadget_resurrect_secondary_deathcam_time() {
    if (self flagsys::get("gadget_resurrect_pending") && isdefined(self.resurrect_available_time)) {
        resurrect_time = 3000;
        weapon = self.resurrect_weapon;
        if (isdefined(weapon.gadget_resurrect_duration)) {
            resurrect_time = weapon.gadget_resurrect_duration;
        }
        time_left = resurrect_time - gettime() - self.resurrect_available_time;
        if (time_left > 0) {
            return (time_left / 1000);
        }
    }
    return 0;
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xd9173e5, Offset: 0x1a08
// Size: 0xf4
function enter_rejack_standby() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    self.rejack_activate_requested = 0;
    if (isdefined(level.resetplayerscorestreaks)) {
        [[ level.resetplayerscorestreaks ]](self);
    }
    self init_rejack_ui();
    self thread watch_rejack_activate_requested();
    self thread watch_rejack_suicide();
    wait 1.4;
    self thread watch_rejack_activate();
    self thread watch_rejack_timeout();
    self thread watch_bad_trigger_touch();
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x9b58c1c7, Offset: 0x1b08
// Size: 0x84
function rejack_suicide() {
    self notify(#"heroAbility_off");
    visionset_mgr::deactivate("visionset", "resurrect", self);
    self thread remove_rejack_ui();
    self val::reset("gadget_resurrect", "show_hud");
    player_suicide();
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xa59d9872, Offset: 0x1b98
// Size: 0x156
function watch_bad_trigger_touch() {
    self endon(#"player_input_revive");
    self endon(#"player_input_suicide");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    a_killbrushes = getentarray("trigger_hurt", "classname");
    while (true) {
        a_killbrushes = getentarray("trigger_hurt", "classname");
        for (i = 0; i < a_killbrushes.size; i++) {
            if (self istouching(a_killbrushes[i])) {
                if (!a_killbrushes[i] istriggerenabled()) {
                    continue;
                }
                self rejack_suicide();
            }
        }
        if (self oob::istouchinganyoobtrigger()) {
            self rejack_suicide();
        }
        waitframe(1);
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x98fa9f49, Offset: 0x1cf8
// Size: 0x9c
function watch_rejack_timeout() {
    self endon(#"player_input_revive");
    self endon(#"player_input_suicide");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    wait 4;
    self playsound("mpl_rejack_suicide_timeout");
    self thread resurrect_drain_power(-30);
    self rejack_suicide();
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x1a38ca53, Offset: 0x1da0
// Size: 0x104
function watch_rejack_suicide() {
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    while (self usebuttonpressed()) {
        wait 1;
    }
    if (isdefined(self.laststand) && self.laststand) {
        starttime = gettime();
        while (true) {
            if (!self usebuttonpressed()) {
                starttime = gettime();
            }
            if (starttime + 500 < gettime()) {
                self rejack_suicide();
                self playsound("mpl_rejack_suicide");
                return;
            }
            wait 0.01;
        }
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xe356149c, Offset: 0x1eb0
// Size: 0x6e
function reload_clip_on_stand() {
    weapons = self getweaponslistprimaries();
    for (i = 0; i < weapons.size; i++) {
        self reloadweaponammo(weapons[i]);
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x102d65af, Offset: 0x1f28
// Size: 0xa6
function watch_rejack_activate_requested() {
    self endon(#"player_input_suicide");
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    while (self offhandspecialbuttonpressed()) {
        waitframe(1);
    }
    self.rejack_activate_requested = 0;
    while (!self.rejack_activate_requested) {
        if (self offhandspecialbuttonpressed()) {
            self.rejack_activate_requested = 1;
        }
        waitframe(1);
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xba6fee7a, Offset: 0x1fd8
// Size: 0x1dc
function watch_rejack_activate() {
    self endon(#"player_input_suicide");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(self.laststand) && self.laststand) {
        while (true) {
            waitframe(1);
            if (isdefined(self.rejack_activate_requested) && self.rejack_activate_requested) {
                self notify(#"player_input_revive");
                if (isdefined(level.start_player_health_regen)) {
                    self thread [[ level.start_player_health_regen ]]();
                }
                self._disable_proximity_alarms = 0;
                self thread do_resurrected_on_spawned_player_fx();
                self thread resurrect_drain_power();
                self thread rejack_ui_activate();
                visionset_mgr::deactivate("visionset", "resurrect", self);
                visionset_mgr::activate("visionset", "resurrect_up", self, 0.35, 0.1, 0.2);
                self clientfield::set_to_player("resurrect_state", 2);
                self stopshellshock();
                self reload_clip_on_stand();
                level notify(#"hero_gadget_activated", {#player:self});
                self notify(#"hero_gadget_activated");
                return;
            }
        }
    }
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xf0a0fb67, Offset: 0x21c0
// Size: 0x84
function init_rejack_ui() {
    self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 1);
    self luinotifyevent(%create_rejack_timer, 1, gettime() + int(4000));
    self clientfield::set_player_uimodel("hudItems.rejack.rejackActivated", 0);
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0xb4230f7, Offset: 0x2250
// Size: 0x5c
function remove_rejack_ui() {
    self endon(#"disconnect");
    wait 1.5;
    self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 0);
    self val::reset("gadget_resurrect", "show_hud");
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x922b330a, Offset: 0x22b8
// Size: 0x3c
function rejack_ui_activate() {
    self clientfield::set_player_uimodel("hudItems.rejack.rejackActivated", 1);
    self thread remove_rejack_ui();
}

// Namespace resurrect/gadget_resurrect
// Params 0, eflags: 0x0
// Checksum 0x8904ae41, Offset: 0x2300
// Size: 0x54
function player_suicide() {
    self._disable_proximity_alarms = 0;
    self notify(#"player_input_suicide");
    self clientfield::set_to_player("resurrect_state", 0);
    self thread resurrect_drain_power(-30);
}

