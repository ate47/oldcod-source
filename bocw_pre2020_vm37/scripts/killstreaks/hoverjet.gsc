#using script_1cc417743d7c262d;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\planemortar_shared;
#using scripts\killstreaks\remote_weapons;

#namespace hoverjet;

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x6
// Checksum 0xba405d21, Offset: 0x1d8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hoverjet", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x5 linked
// Checksum 0x61c5d6d6, Offset: 0x228
// Size: 0xcc
function private function_70a657d8() {
    remote_weapons::init_shared();
    airsupport::init_shared();
    killstreaks::register_killstreak("killstreak_hoverjet", &function_6bbdb500);
    remote_weapons::registerremoteweapon("hoverjet", #"", &function_80586c75, &function_cb79fdd4, 1);
    clientfield::register("toplayer", "sndCockpitRoom", 1, 1, "int");
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x1 linked
// Checksum 0xf3b61fe4, Offset: 0x300
// Size: 0xa2
function function_6bbdb500() {
    if (self killstreakrules::iskillstreakallowed("hoverjet", self.team) == 0) {
        return 0;
    }
    result = self function_9f969d47();
    if (is_true(result)) {
        self waittill(#"hash_3d47c62ffa8dda96", #"disconnect");
    }
    return is_true(result);
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x1 linked
// Checksum 0xf6488c7e, Offset: 0x3b0
// Size: 0x24
function function_367f37f8() {
    self beginlocationselection("map_mortar_selector");
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x1 linked
// Checksum 0x6d8fec07, Offset: 0x3e0
// Size: 0xea
function function_9f969d47() {
    self airsupport::function_9e2054b0(&function_367f37f8);
    location = self airsupport::waitforlocationselection();
    if (!isdefined(self)) {
        return 0;
    }
    if (!isdefined(location.origin)) {
        self notify(#"cancel_selection");
        return 0;
    }
    if (self killstreakrules::iskillstreakallowed("hoverjet", self.team) == 0) {
        self notify(#"cancel_selection");
        return 0;
    }
    return self airsupport::function_83904681(location, &function_3d070ab6, "hoverjet");
}

// Namespace hoverjet/hoverjet
// Params 2, eflags: 0x1 linked
// Checksum 0x97de8b88, Offset: 0x4d8
// Size: 0x60
function function_3d070ab6(location, killstreak_id) {
    team = self.team;
    yaw = location.yaw;
    self thread function_5398ca85(location.origin, yaw, team, killstreak_id);
    return true;
}

// Namespace hoverjet/hoverjet
// Params 4, eflags: 0x1 linked
// Checksum 0x81841445, Offset: 0x540
// Size: 0x23a
function function_747544ed(var_6ecb961c, var_46cd15af, var_f3828812, var_2a587e81) {
    output = spawnstruct();
    output.var_9b8c05e = isdefined(getclosestpointonnavmesh(var_6ecb961c, 10000)) ? getclosestpointonnavmesh(var_6ecb961c, 10000) : var_2a587e81;
    height = killstreaks::function_43f4782d() + 3000;
    if (var_f3828812 > 0) {
        var_a8adc1bd = height / tan(90 - var_f3828812);
    } else {
        var_a8adc1bd = -14000;
    }
    var_ca2dc0 = output.var_9b8c05e - var_2a587e81;
    var_ca2dc0 = vectornormalize((var_ca2dc0[0], var_ca2dc0[1], 0));
    start_node = helicopter::function_9d99f54c(output.var_9b8c05e, var_ca2dc0);
    if (isdefined(start_node)) {
        output.entry_start = start_node.origin;
        var_b096c883 = output.var_9b8c05e - output.entry_start;
        var_b096c883 = vectornormalize((var_b096c883[0], var_b096c883[1], 0));
        output.var_25436c16 = (0, vectortoyaw(var_b096c883), 0);
        output.var_ced649a0 = output.var_9b8c05e + (0, 0, height) + vectorscale(var_b096c883, var_a8adc1bd * -1);
    } else {
        output.entry_start = var_6ecb961c;
        output.var_ced649a0 = var_6ecb961c;
        output.var_25436c16 = (0, var_46cd15af, 0);
    }
    return output;
}

// Namespace hoverjet/hoverjet
// Params 4, eflags: 0x1 linked
// Checksum 0x21201ff3, Offset: 0x788
// Size: 0x434
function function_5398ca85(position, yaw, *team, killstreak_id) {
    self endon(#"emp_jammed", #"joined_team", #"joined_spectators", #"disconnect");
    player = self;
    assert(isplayer(player));
    playerentnum = player.entnum;
    params = killstreaks::get_script_bundle("hoverjet");
    mapcenter = isdefined(level.mapcenter) ? level.mapcenter : player.origin;
    var_da0bd6a0 = function_747544ed(yaw, team, 40, mapcenter);
    var_ea5d6a42 = spawnvehicle(params.ksvehicle, var_da0bd6a0.entry_start, var_da0bd6a0.var_25436c16, "dynamic_spawn_ai");
    var_ea5d6a42 clientfield::set("scorestreakActive", 1);
    var_ea5d6a42.var_ced649a0 = var_da0bd6a0.var_ced649a0;
    var_ea5d6a42.var_9b8c05e = var_da0bd6a0.var_9b8c05e;
    var_ea5d6a42.is_shutting_down = 0;
    var_ea5d6a42.team = player.team;
    var_ea5d6a42.health = params.kshealth;
    var_ea5d6a42.maxhealth = params.kshealth;
    var_ea5d6a42 killstreaks::configure_team("hoverjet", killstreak_id, player, "small_vehicle");
    var_ea5d6a42 clientfield::set("enemyvehicle", 1);
    var_ea5d6a42.killstreak_id = killstreak_id;
    var_ea5d6a42.hardpointtype = "hoverjet";
    var_ea5d6a42 thread killstreaks::waitfortimeout("hoverjet", 70000, &stop_remote_weapon, "remote_weapon_end", "death");
    var_ea5d6a42.do_scripted_crash = 0;
    var_ea5d6a42.delete_on_death = 1;
    var_ea5d6a42.no_free_on_death = 1;
    var_ea5d6a42.one_remote_use = 1;
    var_ea5d6a42.vehcheckforpredictedcrash = 1;
    var_ea5d6a42.predictedcollisiontime = 0.2;
    var_ea5d6a42.glasscollision_alt = 1;
    var_ea5d6a42.damagetaken = 0;
    var_ea5d6a42.var_50e3187f = 1;
    var_ea5d6a42.var_e28b2990 = 1;
    var_ea5d6a42.var_206b039a = 1;
    if (!isdefined(level.var_40225902)) {
        level.var_40225902 = [];
    } else if (!isarray(level.var_40225902)) {
        level.var_40225902 = array(level.var_40225902);
    }
    if (!isinarray(level.var_40225902, var_ea5d6a42)) {
        level.var_40225902[level.var_40225902.size] = var_ea5d6a42;
    }
    target_set(var_ea5d6a42);
    var_ea5d6a42.overridevehicledamage = &function_3588c7d8;
    var_ea5d6a42.forcewaitremotecontrol = 1;
    streamermodelhint(var_ea5d6a42.model, 2);
    player remote_weapons::useremoteweapon(var_ea5d6a42, "hoverjet", 1, 1, 1);
}

// Namespace hoverjet/hoverjet
// Params 15, eflags: 0x1 linked
// Checksum 0xe1f74b5, Offset: 0xbc8
// Size: 0xda
function function_3588c7d8(*einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    damagefromunderneath = self killstreaks::ondamageperweapon("hoverjet", psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    return damagefromunderneath;
}

// Namespace hoverjet/hoverjet
// Params 2, eflags: 0x1 linked
// Checksum 0x64f2cadd, Offset: 0xcb0
// Size: 0x2c
function stop_remote_weapon(*attacker, *weapon) {
    self thread remote_weapons::endremotecontrolweaponuse(0);
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x1 linked
// Checksum 0x6fc64658, Offset: 0xce8
// Size: 0x110
function function_5f298069() {
    self endon(#"death");
    weapon = self seatgetweapon(0);
    wait 3 - 0.7;
    self playsound(#"hash_77edf24307397c1e");
    for (i = 0; i < weapon.burstcount && isdefined(self); i++) {
        self turretsettarget(0, self.var_9b8c05e);
        self turretsettarget(1, self.var_9b8c05e);
        self fireweapon(0);
        self fireweapon(1);
        wait weapon.firetime;
    }
}

// Namespace hoverjet/hoverjet
// Params 1, eflags: 0x1 linked
// Checksum 0xa340a585, Offset: 0xe00
// Size: 0x2d4
function function_80586c75(var_ea5d6a42) {
    player = self;
    assert(isplayer(player));
    if (!var_ea5d6a42.is_shutting_down) {
        var_f3443f81 = 40;
        var_ea5d6a42.angles = (var_f3443f81, vectortoyaw(var_ea5d6a42.var_ced649a0 - var_ea5d6a42.origin), 0);
        var_ea5d6a42 usevehicle(player, 0);
        player clientfield::set_to_player("sndCockpitRoom", 1);
        player setplayerangles((var_f3443f81, vectortoyaw(var_ea5d6a42.var_ced649a0 - var_ea5d6a42.origin), 0));
        if (isdefined(var_ea5d6a42.var_ced649a0)) {
            mover = spawn("script_model", var_ea5d6a42.origin);
            mover.angles = var_ea5d6a42.angles;
            var_ea5d6a42 takeplayercontrol();
            player val::set(#"hash_8110844715cf5ff", "freezecontrols");
            var_ea5d6a42 linkto(mover);
            mover moveto(var_ea5d6a42.var_ced649a0, 3, 0, 1);
            var_ea5d6a42 thread function_5f298069();
            mover waittill(#"movedone");
            if (isdefined(player)) {
                player val::reset(#"hash_8110844715cf5ff", "freezecontrols");
            }
            if (isdefined(var_ea5d6a42)) {
                var_ea5d6a42 unlink();
                var_ea5d6a42 returnplayercontrol();
                var_ea5d6a42 setheliheightcap(1);
                var_ea5d6a42.var_206b039a = undefined;
            }
            mover delete();
        }
        if (isdefined(player)) {
            player vehicle::set_vehicle_drivable_time_starting_now(70000);
        }
    }
}

// Namespace hoverjet/hoverjet
// Params 2, eflags: 0x1 linked
// Checksum 0xee7bb3ae, Offset: 0x10e0
// Size: 0x2c
function function_cb79fdd4(var_ea5d6a42, *exitrequestedbyowner) {
    exitrequestedbyowner thread function_c85eb0a9();
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x1 linked
// Checksum 0x65c12a35, Offset: 0x1118
// Size: 0x12c
function function_c85eb0a9() {
    var_ea5d6a42 = self;
    owner = var_ea5d6a42.owner;
    if (isdefined(var_ea5d6a42) && var_ea5d6a42.is_shutting_down == 1) {
        return;
    }
    var_ea5d6a42.is_shutting_down = 1;
    var_ea5d6a42 vehicle::lights_off();
    var_ea5d6a42 hide();
    killstreakrules::killstreakstop("hoverjet", var_ea5d6a42.originalteam, var_ea5d6a42.killstreak_id);
    if (isalive(var_ea5d6a42)) {
        var_ea5d6a42 notify(#"death");
    }
    if (isdefined(owner)) {
        owner clientfield::set_to_player("sndCockpitRoom", 0);
        owner notify(#"hash_3d47c62ffa8dda96");
    }
    if (isdefined(var_ea5d6a42)) {
        var_ea5d6a42 waitthendelete(0.2);
    }
}

// Namespace hoverjet/hoverjet
// Params 1, eflags: 0x1 linked
// Checksum 0xb8a407f8, Offset: 0x1250
// Size: 0x4c
function waitthendelete(waittime) {
    self endon(#"delete", #"death");
    wait waittime;
    self delete();
}

