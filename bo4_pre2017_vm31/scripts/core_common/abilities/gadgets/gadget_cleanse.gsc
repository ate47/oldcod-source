#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_cleanse;

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x2
// Checksum 0x147c285d, Offset: 0x2d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_cleanse", &__init__, undefined, undefined);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x9d307a21, Offset: 0x310
// Size: 0x194
function __init__() {
    ability_player::register_gadget_activation_callbacks(17, &gadget_cleanse_on, &gadget_cleanse_off);
    ability_player::register_gadget_possession_callbacks(17, &gadget_cleanse_on_give, &gadget_cleanse_on_take);
    ability_player::register_gadget_flicker_callbacks(17, &gadget_cleanse_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(17, &gadget_cleanse_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(17, &gadget_cleanse_is_flickering);
    clientfield::register("scriptmover", "cleanse_aoe_fx", 1, 1, "int");
    clientfield::register("allplayers", "cleansed", 1, 1, "int");
    clientfield::register("toplayer", "gadget_cleanse_on", 1, 1, "int");
    callback::on_connect(&gadget_cleanse_on_connect);
    callback::on_spawned(&gadget_cleanse_on_player_spawn);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0xd8d3761a, Offset: 0x4b0
// Size: 0x2a
function gadget_cleanse_is_inuse(slot) {
    return self flagsys::get("gadget_cleanse_on");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0xcaf054f6, Offset: 0x4e8
// Size: 0x22
function gadget_cleanse_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x7ff891ef, Offset: 0x518
// Size: 0x34
function gadget_cleanse_on_flicker(slot, weapon) {
    self thread gadget_cleanse_flicker(slot, weapon);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xd461dff2, Offset: 0x558
// Size: 0x14
function gadget_cleanse_on_give(slot, weapon) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x445cf394, Offset: 0x578
// Size: 0x14
function gadget_cleanse_on_take(slot, weapon) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x598
// Size: 0x4
function gadget_cleanse_on_connect() {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x1a374923, Offset: 0x5a8
// Size: 0x24
function gadget_cleanse_on_player_spawn() {
    self clientfield::set("cleansed", 0);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x2b78c0a4, Offset: 0x5d8
// Size: 0x94
function gadget_cleanse_on(slot, weapon) {
    self thread cleanse_aoe_think(slot, weapon);
    self flagsys::set("gadget_cleanse_on");
    self thread gadget_cleanse_start(slot, weapon);
    self clientfield::set_to_player("gadget_cleanse_on", 1);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xf5480f16, Offset: 0x678
// Size: 0x90
function gadget_cleanse_off(slot, weapon) {
    wait 1.5;
    self gadget_cleanse_off_player(slot, weapon);
    if (isdefined(self.cleansed_players) && self.cleansed_players.size > 0) {
        gadget_cleanse_off_players(slot, weapon, self.cleansed_players);
        self.cleansed_players = [];
    }
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0x922a0ad3, Offset: 0x710
// Size: 0xda
function gadget_cleanse_off_players(slot, weapon, players) {
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isplayer(player)) {
            continue;
        }
        player clientfield::set("cleansed", 0);
    }
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xbddc524, Offset: 0x7f8
// Size: 0x54
function gadget_cleanse_off_player(slot, weapon) {
    self flagsys::clear("gadget_cleanse_on");
    self clientfield::set_to_player("gadget_cleanse_on", 0);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x52a567ee, Offset: 0x858
// Size: 0x3a
function gadget_cleanse_start(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self notify(#"gadget_cleanse_on");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0xbf68c570, Offset: 0x8a0
// Size: 0x74
function apply_cleanse() {
    self setempjammed(0);
    self setnormalhealth(self.maxhealth);
    self setdoublejumpenergy(1);
    self stopshellshock();
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x16f5cf0, Offset: 0x920
// Size: 0x14
function wait_until_is_done(slot, timepulse) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xdd9d6f54, Offset: 0x940
// Size: 0x20
function gadget_cleanse_flicker(slot, weapon) {
    self endon(#"disconnect");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x5712532b, Offset: 0x968
// Size: 0x14
function set_gadget_cleanse_status(status, time) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x876b775a, Offset: 0x988
// Size: 0xae
function cleanse_aoe_think(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"cleanse_aoe_think");
    self endon(#"cleanse_aoe_think");
    self.heroabilityactive = 1;
    cleanse_aoe = cleanse_aoe_setup(weapon);
    self thread ability_util::aoe_friendlies(weapon, cleanse_aoe);
    wait 0.25;
    self.heroabilityactive = 0;
    self notify(#"cleanse_aoe_think_finished");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x121f7428, Offset: 0xa40
// Size: 0x1b8
function cleanse_aoe_setup(weapon) {
    cleanse_aoe = spawnstruct();
    cleanse_aoe.radius = weapon.gadget_cleanse_radius;
    cleanse_aoe.origin = self geteye();
    cleanse_aoe.direction = anglestoforward(self getplayerangles());
    cleanse_aoe.up = anglestoup(self getplayerangles());
    cleanse_aoe.fxorg = cleanse_aoe_fx(cleanse_aoe.origin, cleanse_aoe.direction);
    cleanse_aoe.aoe_think_singleton_event = "cleanse_aoe_think";
    cleanse_aoe.duration = 250;
    cleanse_aoe.reapply_time = 500;
    cleanse_aoe.check_reapply_time_func = &cleanse_check_reapply_time;
    cleanse_aoe.can_apply_aoe_func = &can_apply_cleanse_aoe;
    cleanse_aoe.apply_aoe_func = &apply_cleanse_aoe;
    cleanse_aoe.try_apply_aoe_func = &try_apply_cleanse_aoe;
    cleanse_aoe.max_applies_per_frame = 1;
    return cleanse_aoe;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x9373f108, Offset: 0xc00
// Size: 0x150
function cleanse_aoe_fx(origin, direction) {
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("cleanse_aoe_fx", 1);
    fxorg.hitsomething = 0;
    self thread cleanse_aoe_fx_cleanup(fxorg, direction);
    return fxorg;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xbb7a09a7, Offset: 0xd58
// Size: 0x84
function cleanse_aoe_fx_cleanup(fxorg, direction) {
    self waittill("cleanse_aoe_think", "cleanse_aoe_think_finished");
    if (isdefined(fxorg)) {
        fxorg stoploopsound();
        fxorg clientfield::set("cleanse_aoe_fx", 0);
        fxorg delete();
    }
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0x24371960, Offset: 0xde8
// Size: 0x54
function cleanse_friendly(weapon, friendly, cleanse_aoe) {
    self apply_cleanse();
    self clientfield::set("cleansed", 1);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0xc34bc026, Offset: 0xe48
// Size: 0x46
function can_apply_cleanse_aoe(entity, weapon, cleanse_aoe) {
    if (!ability_util::aoe_trace_entity(entity, cleanse_aoe, 50)) {
        return false;
    }
    return true;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x742231d9, Offset: 0xe98
// Size: 0x3e
function cleanse_check_reapply_time(aoe) {
    return isdefined(self.cleanse_applied_time) && self.cleanse_applied_time + aoe.reapply_time + 1 > gettime();
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0xb3fa9101, Offset: 0xee0
// Size: 0xca
function apply_cleanse_aoe(player, weapon, aoe) {
    player cleanse_friendly(weapon, aoe);
    player.cleanse_applied_time = gettime();
    if (!isdefined(self.cleansed_players)) {
        self.cleansed_players = [];
    } else if (!isarray(self.cleansed_players)) {
        self.cleansed_players = array(self.cleansed_players);
    }
    self.cleansed_players[self.cleansed_players.size] = player;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0xf5710da8, Offset: 0xfb8
// Size: 0x74
function try_apply_cleanse_aoe(player, weapon, aoe) {
    if (player cleanse_check_reapply_time(aoe)) {
        return;
    }
    if (can_apply_cleanse_aoe(player, weapon, aoe)) {
        apply_cleanse_aoe(player, weapon, aoe);
    }
}

