#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_sprint_boost;

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x2
// Checksum 0x347dc69a, Offset: 0x318
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_sprint_boost", &__init__, undefined, undefined);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0x2ceb1f4b, Offset: 0x358
// Size: 0x194
function __init__() {
    ability_player::register_gadget_activation_callbacks(53, &gadget_sprint_boost_on, &gadget_sprint_boost_off);
    ability_player::register_gadget_possession_callbacks(53, &gadget_sprint_boost_on_give, &gadget_sprint_boost_on_take);
    ability_player::register_gadget_flicker_callbacks(53, &gadget_sprint_boost_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(53, &gadget_sprint_boost_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(53, &gadget_sprint_boost_is_flickering);
    clientfield::register("scriptmover", "sprint_boost_aoe_fx", 1, 1, "int");
    clientfield::register("allplayers", "sprint_boost", 1, 1, "int");
    clientfield::register("toplayer", "gadget_sprint_boost_on", 1, 1, "int");
    callback::on_connect(&gadget_sprint_boost_on_connect);
    callback::on_spawned(&gadget_sprint_boost_on_player_spawn);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0xe4d82198, Offset: 0x4f8
// Size: 0x2a
function gadget_sprint_boost_is_inuse(slot) {
    return self flagsys::get("gadget_sprint_boost_on");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x70f04f56, Offset: 0x530
// Size: 0x22
function gadget_sprint_boost_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xa90c2ac1, Offset: 0x560
// Size: 0x34
function gadget_sprint_boost_on_flicker(slot, weapon) {
    self thread gadget_sprint_boost_flicker(slot, weapon);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x9f6500bb, Offset: 0x5a0
// Size: 0x14
function gadget_sprint_boost_on_give(slot, weapon) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xf574d016, Offset: 0x5c0
// Size: 0x14
function gadget_sprint_boost_on_take(slot, weapon) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5e0
// Size: 0x4
function gadget_sprint_boost_on_connect() {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0xd398b06d, Offset: 0x5f0
// Size: 0x24
function gadget_sprint_boost_on_player_spawn() {
    self clientfield::set("sprint_boost", 0);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xf8477e65, Offset: 0x620
// Size: 0x94
function gadget_sprint_boost_on(slot, weapon) {
    self thread sprint_boost_aoe_think(slot, weapon);
    self flagsys::set("gadget_sprint_boost_on");
    self thread gadget_sprint_boost_start(slot, weapon);
    self clientfield::set_to_player("gadget_sprint_boost_on", 1);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x5f739728, Offset: 0x6c0
// Size: 0x90
function gadget_sprint_boost_off(slot, weapon) {
    wait 1.5;
    self gadget_sprint_boost_off_player(slot, weapon);
    if (isdefined(self.sprint_boost_players) && self.sprint_boost_players.size > 0) {
        gadget_sprint_boost_off_players(slot, weapon, self.sprint_boost_players);
        self.sprint_boost_players = [];
    }
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0xb1840ecf, Offset: 0x758
// Size: 0xda
function gadget_sprint_boost_off_players(slot, weapon, players) {
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isplayer(player)) {
            continue;
        }
        player clientfield::set("sprint_boost", 0);
    }
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x2ffe5c43, Offset: 0x840
// Size: 0x54
function gadget_sprint_boost_off_player(slot, weapon) {
    self flagsys::clear("gadget_sprint_boost_on");
    self clientfield::set_to_player("gadget_sprint_boost_on", 0);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x542ab431, Offset: 0x8a0
// Size: 0x3a
function gadget_sprint_boost_start(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self notify(#"gadget_sprint_boost_on");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x5a3592af, Offset: 0x8e8
// Size: 0xfc
function apply_sprint_boost(duration) {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    player notify(#"apply_sprint_boost_singleton");
    player endon(#"apply_sprint_boost_singleton");
    player setsprintboost(1);
    duration = math::clamp(isdefined(duration) ? duration : 10, 1, 1200);
    frames_to_wait = int(duration / 0.05);
    waitframe(frames_to_wait);
    player setsprintboost(0);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x549ade8, Offset: 0x9f0
// Size: 0x14
function wait_until_is_done(slot, timepulse) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x18aa45f1, Offset: 0xa10
// Size: 0x20
function gadget_sprint_boost_flicker(slot, weapon) {
    self endon(#"disconnect");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x4156ff73, Offset: 0xa38
// Size: 0x14
function set_gadget_sprint_boost_status(status, time) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x9489de1e, Offset: 0xa58
// Size: 0xae
function sprint_boost_aoe_think(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"sprint_boost_aoe_think");
    self endon(#"sprint_boost_aoe_think");
    self.heroabilityactive = 1;
    sprint_boost_aoe = sprint_boost_aoe_setup(weapon);
    self thread ability_util::aoe_friendlies(weapon, sprint_boost_aoe);
    wait 0.25;
    self.heroabilityactive = 0;
    self notify(#"sprint_boost_aoe_think_finished");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x24d318b5, Offset: 0xb10
// Size: 0x1b8
function sprint_boost_aoe_setup(weapon) {
    sprint_boost_aoe = spawnstruct();
    sprint_boost_aoe.radius = weapon.sprintboostradius;
    sprint_boost_aoe.origin = self geteye();
    sprint_boost_aoe.direction = anglestoforward(self getplayerangles());
    sprint_boost_aoe.up = anglestoup(self getplayerangles());
    sprint_boost_aoe.fxorg = sprint_boost_aoe_fx(sprint_boost_aoe.origin, sprint_boost_aoe.direction);
    sprint_boost_aoe.aoe_think_singleton_event = "sprint_boost_aoe_think";
    sprint_boost_aoe.duration = 250;
    sprint_boost_aoe.reapply_time = 500;
    sprint_boost_aoe.check_reapply_time_func = &sprint_boost_check_reapply_time;
    sprint_boost_aoe.can_apply_aoe_func = &can_apply_sprint_boost_aoe;
    sprint_boost_aoe.apply_aoe_func = &apply_sprint_boost_aoe;
    sprint_boost_aoe.try_apply_aoe_func = &try_apply_sprint_boost_aoe;
    sprint_boost_aoe.max_applies_per_frame = 1;
    return sprint_boost_aoe;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xb8059ae6, Offset: 0xcd0
// Size: 0x150
function sprint_boost_aoe_fx(origin, direction) {
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("sprint_boost_aoe_fx", 1);
    fxorg.hitsomething = 0;
    self thread sprint_boost_aoe_fx_cleanup(fxorg, direction);
    return fxorg;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x5bef88f0, Offset: 0xe28
// Size: 0x84
function sprint_boost_aoe_fx_cleanup(fxorg, direction) {
    self waittill("sprint_boost_aoe_think", "sprint_boost_aoe_think_finished");
    if (isdefined(fxorg)) {
        fxorg stoploopsound();
        fxorg clientfield::set("sprint_boost_aoe_fx", 0);
        fxorg delete();
    }
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0x69a6f55c, Offset: 0xeb8
// Size: 0x74
function sprint_boost_friendly(weapon, friendly, sprint_boost_aoe) {
    duration = weapon.sprintboostduration;
    self thread apply_sprint_boost(duration);
    self clientfield::set("sprint_boost", 1);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0x7e03e147, Offset: 0xf38
// Size: 0x46
function can_apply_sprint_boost_aoe(entity, weapon, sprint_boost_aoe) {
    if (!ability_util::aoe_trace_entity(entity, sprint_boost_aoe, 50)) {
        return false;
    }
    return true;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x47cc563e, Offset: 0xf88
// Size: 0x3e
function sprint_boost_check_reapply_time(aoe) {
    return isdefined(self.sprint_boost_applied_time) && self.sprint_boost_applied_time + aoe.reapply_time + 1 > gettime();
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0xbf635a5, Offset: 0xfd0
// Size: 0xca
function apply_sprint_boost_aoe(player, weapon, aoe) {
    player sprint_boost_friendly(weapon, aoe);
    player.sprint_boost_applied_time = gettime();
    if (!isdefined(self.sprint_boost_players)) {
        self.sprint_boost_players = [];
    } else if (!isarray(self.sprint_boost_players)) {
        self.sprint_boost_players = array(self.sprint_boost_players);
    }
    self.sprint_boost_players[self.sprint_boost_players.size] = player;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0x5ee5cbe0, Offset: 0x10a8
// Size: 0x74
function try_apply_sprint_boost_aoe(player, weapon, aoe) {
    if (player sprint_boost_check_reapply_time(aoe)) {
        return;
    }
    if (can_apply_sprint_boost_aoe(player, weapon, aoe)) {
        apply_sprint_boost_aoe(player, weapon, aoe);
    }
}

