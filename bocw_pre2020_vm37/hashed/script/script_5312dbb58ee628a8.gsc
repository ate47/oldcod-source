#using script_1cc417743d7c262d;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\remote_weapons;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace missile_turret;

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xc1c7320c, Offset: 0x4d8
// Size: 0x53c
function init_shared() {
    if (!isdefined(level.var_1b611bca)) {
        level.var_1b611bca = {};
        if (!isdefined(level.var_6964d56c)) {
            level.var_6964d56c = spawnstruct();
        }
        level.var_6964d56c.var_d67ec774 = [];
        level.var_6964d56c.var_d67ec774[#"hash_2546ffc22904360b"] = 1;
        level.var_6964d56c.var_d67ec774[#"jetfighter"] = 1;
        level.var_6964d56c.var_d67ec774[#"napalm_strike"] = 1;
        level.var_6964d56c.var_d67ec774[#"remote_missile"] = 1;
        level.var_6964d56c.var_d67ec774[#"straferun"] = 1;
        level.var_6964d56c.var_1543185c = array("ac130", "helicopter_guard", "inventory_helicopter_guard", "chopper_gunner", "hoverjet", "helicopter_comlink", "inventory_helicopter_comlink", "recon_plane", "uav", "counteruav");
        level.var_6964d56c.var_512625a1 = [#"ac130":"gunship", #"chopper_gunner":"chop_gun", #"counteruav":"cuav", #"helicopter_guard":"lgt_chop", #"inventory_helicopter_guard":"lgt_chop", #"helicopter_comlink":"lgt_chop", #"inventory_helicopter_comlink":"lgt_chop", #"hoverjet":"hover_jet", #"recon_plane":"spy_plane_alt", #"uav":"uav"];
        level.var_6964d56c.var_e321cb16 = [];
        if (!isdefined(level.var_2d90c17e)) {
            level.var_2d90c17e = [];
        } else if (!isarray(level.var_2d90c17e)) {
            level.var_2d90c17e = array(level.var_2d90c17e);
        }
        level.var_2d90c17e[level.var_2d90c17e.size] = &function_c1a68e7a;
        level.var_6964d56c.var_6eecd3fe = getscriptbundle("killstreak_missile_turret");
        clientfield::register("vehicle", "missile_turret_open", 1, 1, "int");
        clientfield::register("vehicle", "missile_turret_init", 1, 1, "int");
        clientfield::register("vehicle", "missile_turret_close", 1, 1, "int");
        clientfield::register("vehicle", "missile_turret_is_jammed_by_cuav", 1, 1, "int");
        vehicle::add_main_callback("veh_missile_turret", &initturret);
        callback::on_player_killed(&on_player_killed);
        weaponobjects::function_e6400478(#"missile_turret", &function_fdf195f2, undefined);
        level.var_4d11b106 = 0;
        deployable::register_deployable(getweapon("missile_turret"), undefined);
        callback::on_finalize_initialization(&function_1c601b99);
        if (!isdefined(level.var_c61fd5a9)) {
            level.var_c61fd5a9 = new throttle();
            [[ level.var_c61fd5a9 ]]->initialize(1, float(function_60d95f53()) / 1000);
        }
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x95bf8e3e, Offset: 0xa20
// Size: 0x214
function function_c1a68e7a(killstreakbundle) {
    if (isdefined(killstreakbundle.var_d3413870)) {
        if (isinarray(level.var_6964d56c.var_1543185c, killstreakbundle.var_d3413870)) {
            /#
                function_600ab97b("<dev string:x38>" + killstreakbundle.var_d3413870 + "<dev string:x51>" + self getentitynumber());
            #/
            if (!isdefined(level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870])) {
                level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870] = [];
            } else if (!isarray(level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870])) {
                level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870] = array(level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870]);
            }
            if (!isinarray(level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870], self)) {
                level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870][level.var_6964d56c.var_e321cb16[killstreakbundle.var_d3413870].size] = self;
            }
            level function_d464ecf7();
            return;
        }
        /#
            function_600ab97b("<dev string:x58>" + killstreakbundle.var_d3413870 + "<dev string:x51>" + self getentitynumber());
        #/
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xa6fc2045, Offset: 0xc40
// Size: 0x98
function function_d464ecf7() {
    foreach (var_ded7e023 in level.var_6964d56c.var_e321cb16) {
        arrayremovevalue(var_ded7e023, undefined);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x1291586e, Offset: 0xce0
// Size: 0x90
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon("missile_turret"), &function_bff5c062);
    }
    if (isdefined(level.var_a5dacbea)) {
        [[ level.var_a5dacbea ]](getweapon("missile_turret"), &function_127fb8f3);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 2, eflags: 0x1 linked
// Checksum 0xefdbbbcd, Offset: 0xd78
// Size: 0x9c
function function_127fb8f3(turret, attackingplayer) {
    turret turretcleartarget(0);
    if (isdefined(level.var_86e3d17a) && turret.classname == "script_vehicle") {
        if (isdefined(level.var_1794f85f)) {
            [[ level.var_1794f85f ]](attackingplayer, "disrupted_sentry");
        }
        turret clientfield::set("enemyvehicle", 0);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 2, eflags: 0x1 linked
// Checksum 0x9c99fc48, Offset: 0xe20
// Size: 0x194
function function_bff5c062(turret, attackingplayer) {
    var_f3ab6571 = turret.owner weaponobjects::function_8481fc06(turret.weapon) > 1;
    turret.owner thread globallogic_audio::function_a2cde53d(turret.weapon, var_f3ab6571);
    turret function_3a9dddac();
    if (isdefined(turret.turret)) {
        turret.owner weaponobjects::hackerremoveweapon(turret.turret);
    }
    turret.owner = attackingplayer;
    turret.team = attackingplayer.team;
    turret setowner(attackingplayer);
    turret setteam(attackingplayer.team);
    if (turret.classname == "script_vehicle") {
        turret.spawninfluencers = [];
        turret.spawninfluencers[0] = turret createturretinfluencer("turret");
        turret.spawninfluencers[1] = turret createturretinfluencer("turret_close");
    }
    turret thread turret_watch_owner_events();
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x78622ad5, Offset: 0xfc0
// Size: 0x13a
function initturret() {
    turretvehicle = self;
    turretvehicle.dontfreeme = 1;
    turretvehicle.damage_on_death = 0;
    turretvehicle.delete_on_death = undefined;
    turretvehicle.maxhealth = 2000;
    turretvehicle.damagetaken = 0;
    tablehealth = isdefined(level.var_6964d56c.var_6eecd3fe.kshealth) ? level.var_6964d56c.var_6eecd3fe.kshealth : 500;
    if (isdefined(tablehealth)) {
        turretvehicle.maxhealth = tablehealth;
    }
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle turretsetontargettolerance(0, 15);
    turretvehicle clientfield::set("enemyvehicle", 1);
    turretvehicle.soundmod = "mini_turret";
    turretvehicle.overridevehicledamage = &ondamage;
    turretvehicle.overridevehiclekilled = &ondeath;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x35a51107, Offset: 0x1108
// Size: 0x11a
function function_fdf195f2(watcher) {
    watcher.onspawn = &function_3be2d17f;
    watcher.ontimeout = &function_72f72c48;
    watcher.onfizzleout = &function_72f72c48;
    watcher.var_994b472b = &function_72f72c48;
    watcher.deleteonplayerspawn = 0;
    watcher.var_10efd558 = "switched_field_upgrade";
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    if (isdefined(watcher.weapon.customsettings)) {
        var_e6fbac16 = getscriptbundle(watcher.weapon.customsettings);
        assert(isdefined(var_e6fbac16));
        level.var_6964d56c.customsettings = var_e6fbac16;
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 2, eflags: 0x1 linked
// Checksum 0xa757cfab, Offset: 0x1230
// Size: 0x6e2
function function_3be2d17f(watcher, player) {
    player endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    slot = player gadgetgetslot(self.weapon);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self hide();
    self.canthack = 1;
    self.ignoreemp = 1;
    self.var_501460f = int((isdefined(level.var_6964d56c.customsettings.var_4c3a3d79) ? level.var_6964d56c.customsettings.var_4c3a3d79 : 1) * 1000);
    self.var_2350dc16 = isdefined(level.var_6964d56c.customsettings.var_783913b4) ? level.var_6964d56c.customsettings.var_783913b4 : 5;
    self.var_b19fe20c = self.var_2350dc16;
    self.var_83891ae2 = isdefined(level.var_6964d56c.customsettings.var_ba53d794) ? level.var_6964d56c.customsettings.var_ba53d794 : 1;
    self.var_f75c2458 = level.var_6964d56c.customsettings.var_27c4391d;
    self.var_3bfa4639 = int((isdefined(level.var_6964d56c.customsettings.var_12c45fc8) ? level.var_6964d56c.customsettings.var_12c45fc8 : 0) * 1000);
    self.var_98b4ef7e = int((isdefined(level.var_6964d56c.customsettings.var_85707b85) ? level.var_6964d56c.customsettings.var_85707b85 : 0) * 1000);
    self.var_40c696e = int((isdefined(level.var_6964d56c.customsettings.var_f1c58cd5) ? level.var_6964d56c.customsettings.var_f1c58cd5 : 0) * 1000);
    self.var_eb9e0e9c = int((isdefined(level.var_6964d56c.customsettings.var_1c3fb32f) ? level.var_6964d56c.customsettings.var_1c3fb32f : 0) * 1000);
    self.var_ddf7efa7 = function_a3f6cdac(isdefined(level.var_6964d56c.customsettings.var_b6f11437) ? level.var_6964d56c.customsettings.var_b6f11437 : 30000);
    self.var_6a629b6e = isdefined(level.var_6964d56c.customsettings.var_fe7839bf) ? level.var_6964d56c.customsettings.var_fe7839bf : 0;
    var_83ed455 = 0;
    if (var_83ed455 && isdefined(player)) {
        player val::set(#"missile_turret", "freezecontrols");
    }
    self waittill(#"stationary");
    self deployable::function_dd266e08(player);
    self.origin += (0, 0, 2);
    player onplaceturret(self);
    var_5b220756 = self.vehicle.var_5b220756;
    var_34a76f8d = player.pers[#"hash_55c15f9af76e4e68"][var_5b220756];
    if (!isdefined(var_34a76f8d) || var_34a76f8d <= 0) {
        player stats::function_e24eec31(getweapon("missile_turret"), #"used", 1);
    }
    player.pers[#"hash_55c15f9af76e4e68"][var_5b220756] = 0;
    player stats::function_e24eec31(self.weapon, #"used", 1);
    player notify(#"hash_6a3b9d0c6cd28c99", {#turret:self});
    if (var_83ed455 && isdefined(player)) {
        player val::reset(#"missile_turret", "freezecontrols");
    }
    if (isdefined(self.vehicle)) {
        self thread function_b649601a();
    }
    self ghost();
    self.vehicle.var_1f13c7f1 = getweapon(#"missile_turret").var_1f13c7f1;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0xb957d2d0, Offset: 0x1920
// Size: 0x4c
function function_72f72c48(*player) {
    if (isdefined(self.vehicle)) {
        self.vehicle thread function_450ab98d(level.var_6964d56c.var_6eecd3fe.var_8095b472);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x311abc3c, Offset: 0x1978
// Size: 0x1f4
function function_450ab98d(var_baf60e5) {
    self endon(#"death");
    if (self.var_66f1c537 === 1) {
        return;
    }
    self.var_66f1c537 = 1;
    self.canthack = 1;
    self.var_515d6dda = 0;
    self stoploopsound();
    self.scanning = 1;
    self playsound("mpl_missile_turret_exp");
    if (isdefined(var_baf60e5)) {
        e_fx = spawn("script_model", self gettagorigin("tag_turret"));
        e_fx setmodel(#"tag_origin");
        e_fx.angles = self gettagangles("tag_turret");
        playfxontag(var_baf60e5, e_fx, "tag_origin");
    }
    self hide();
    self notify(#"end_turret_scanning");
    self function_3a9dddac();
    if (isdefined(self.gameobject)) {
        self.gameobject gameobjects::destroy_object(1, undefined, 1);
    }
    wait 10;
    if (isdefined(self.turret)) {
        self.turret delete();
    }
    self delete();
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x64fbde8, Offset: 0x1b78
// Size: 0x74
function function_b649601a() {
    self.vehicle endon(#"death");
    self.vehicle clientfield::set("missile_turret_init", 1);
    wait 0.25;
    self.vehicle clientfield::set("missile_turret_open", 1);
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x650d5478, Offset: 0x1bf8
// Size: 0x900
function onplaceturret(turret) {
    player = self;
    assert(isplayer(player));
    weapon = getweapon("missile_turret");
    if (isdefined(turret.vehicle)) {
        turret.vehicle.origin = turret.origin;
        turret.vehicle.angles = turret.angles;
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle playsound(#"mpl_turret_startup");
    } else {
        turret.vehicle = spawnvehicle("veh_missile_turret", turret.origin, turret.angles, "dynamic_spawn_ai");
        turret.vehicle.owner = player;
        turret.vehicle setowner(player);
        turret.vehicle.ownerentnum = player.entnum;
        turret.vehicle.parentstruct = turret;
        turret.vehicle.controlled = 0;
        turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
        turret.vehicle.ignore_team_kills = 1;
        turret.vehicle.deal_no_crush_damage = 1;
        turret.vehicle.turret = turret;
        turret.killstreakref = "missile_turret";
        turret.vehicle.var_515d6dda = 1;
        turret.vehicle.team = player.team;
        turret.vehicle setteam(player.team);
        turret.vehicle turret::set_team(player.team, 0);
        turret.vehicle turret::set_torso_targetting(0);
        turret.vehicle turret::set_target_leading(0);
        turret.vehicle.use_non_teambased_enemy_selection = 1;
        turret.vehicle.waittill_turret_on_target_delay = 0.25;
        turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
        turret.vehicle.var_20c71d46 = 1;
        if (!isdefined(turret.vehicle.var_5b220756)) {
            turret.vehicle.var_5b220756 = 3;
        }
        var_42f0dc61 = player.pers[#"hash_38fcd8992f6cb9dc"][turret.vehicle.var_5b220756];
        if (isdefined(var_42f0dc61) && var_42f0dc61 > 0) {
            turret.vehicle dodamage(var_42f0dc61, self.origin);
            player.pers[#"hash_38fcd8992f6cb9dc"][turret.vehicle.var_5b220756] = 0;
        }
        turret.vehicle thread turret_watch_owner_events();
        turret.vehicle thread function_31477582();
        turret.vehicle.spawninfluencers = [];
        turret.vehicle.spawninfluencers[0] = turret.vehicle createturretinfluencer("turret");
        turret.vehicle.spawninfluencers[1] = turret.vehicle createturretinfluencer("turret_close");
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle.var_63d65a8d = "circle";
        turret.vehicle.var_7eb3ebd5 = [];
        turret.vehicle util::make_sentient();
        turret.vehicle function_bc7568f1();
        turret.vehicle.var_aac73d6c = 1;
        var_34a76f8d = player.pers[#"hash_55c15f9af76e4e68"][turret.vehicle.var_5b220756];
        if (!isdefined(var_34a76f8d) || var_34a76f8d <= 0) {
            player stats::function_e24eec31(weapon, #"used", 1);
        }
        turret.vehicle.maxsightdistsqrd = 1;
    }
    player deployable::function_6ec9ee30(turret.vehicle, weapon);
    player battlechatter::function_fc82b10(weapon, turret.origin, turret);
    turret.vehicle playloopsound(#"hash_69240c6db92da5bf", 0.25);
    turret.vehicle.turret_enabled = 1;
    target_set(turret.vehicle);
    turret.vehicle unlink();
    turret.vehicle vehicle::disconnect_paths(0, 0);
    trigger = spawn("trigger_radius_use", turret.origin, 0, 85, 85);
    trigger.str_hint = #"hash_2c90cbfdfac140bf";
    trigger setteamfortrigger(self.team);
    trigger setinvisibletoall();
    trigger setvisibletoplayer(self);
    trigger.var_a865c2cd = 0;
    self clientclaimtrigger(trigger);
    if (is_true(level.var_6964d56c.customsettings.var_cfb3573a)) {
        gameobject = gameobjects::create_use_object(self.team, trigger, [], (0, 0, 0));
        gameobject gameobjects::set_use_time(1);
        gameobject gameobjects::set_visible(#"hash_5ccfd7bbbf07c770");
        gameobject gameobjects::allow_use(#"hash_150a20fa4efc5c7a");
        gameobject gameobjects::set_onenduse_event();
        gameobject gameobjects::set_onuse_event(&function_ff9ee951);
        gameobject.requireslos = 1;
        gameobject.turret = turret;
        turret.vehicle.gameobject = gameobject;
    }
    turret.vehicle thread vehicle::watch_freeze_on_flash(isdefined(level.var_6964d56c.customsettings.var_85dc57d4) ? level.var_6964d56c.customsettings.var_85dc57d4 : 3);
    turret.vehicle thread turretscanning();
    player notify(#"hash_6a3b9d0c6cd28c99", {#turret:turret.vehicle});
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x7aa87fd0, Offset: 0x2500
// Size: 0xd4
function function_ff9ee951(player) {
    turret = self.turret;
    vehicle = turret.vehicle;
    assert(isdefined(vehicle));
    slot = vehicle.var_5b220756;
    if (!isdefined(slot)) {
        slot = 3;
        vehicle.var_5b220756 = slot;
    }
    player.pers[#"hash_38fcd8992f6cb9dc"][slot] = vehicle.damagetaken;
    vehicle thread function_450ab98d(level.var_6964d56c.var_6eecd3fe.var_8095b472);
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x0
// Checksum 0x6b970191, Offset: 0x25e0
// Size: 0x10c
function hackedcallbackpre(*hacker) {
    turretvehicle = self;
    turretvehicle clientfield::set("enemyvehicle", 2);
    turretvehicle.owner clientfield::set_to_player("static_postfx", 0);
    if (turretvehicle.controlled === 1) {
        visionset_mgr::deactivate("visionset", "turret_visionset", turretvehicle.owner);
    }
    turretvehicle.owner remote_weapons::removeandassignnewremotecontroltrigger(turretvehicle.usetrigger);
    turretvehicle remote_weapons::endremotecontrolweaponuse(1);
    turretvehicle.owner unlink();
    turretvehicle clientfield::set("vehicletransition", 0);
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x0
// Checksum 0x505a9f33, Offset: 0x26f8
// Size: 0x50
function hackedcallbackpost(hacker) {
    turretvehicle = self;
    hacker remote_weapons::useremoteweapon(turretvehicle, "missile_turret", 0);
    turretvehicle notify(#"watchremotecontroldeactivate_remoteweapons");
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x0
// Checksum 0x56a48d70, Offset: 0x2750
// Size: 0x4c
function play_deploy_anim_after_wait(wait_time) {
    turret = self;
    turret endon(#"death");
    wait wait_time;
    turret play_deploy_anim();
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x1f105f65, Offset: 0x27a8
// Size: 0x8c
function play_deploy_anim() {
    turret = self;
    turret clientfield::set("missile_turret_close", 0);
    turret.othermodel clientfield::set("missile_turret_close", 0);
    if (isdefined(turret.vehicle)) {
        turret.vehicle clientfield::set("missile_turret_open", 1);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 15, eflags: 0x1 linked
// Checksum 0x9cef5de5, Offset: 0x2840
// Size: 0xfa
function ondamage(*einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    var_b8d8d7ef = killstreak_bundles::function_dd7587e4(level.var_6964d56c.var_6eecd3fe, self.maxhealth, psoffsettime, vsurfacenormal, partname, damagefromunderneath, modelindex);
    if (!isdefined(var_b8d8d7ef)) {
        var_b8d8d7ef = killstreaks::get_old_damage(psoffsettime, vsurfacenormal, partname, damagefromunderneath, 1);
    }
    self.damagetaken += var_b8d8d7ef;
    return var_b8d8d7ef;
}

// Namespace missile_turret/namespace_1b611bca
// Params 8, eflags: 0x1 linked
// Checksum 0x694f090c, Offset: 0x2948
// Size: 0x224
function ondeath(*einflictor, eattacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime) {
    shitloc = self [[ level.figure_out_attacker ]](shitloc);
    if (self.owner util::isenemyplayer(shitloc)) {
        if (isdefined(level.var_6964d56c.var_6eecd3fe.var_ebd92bbc)) {
            scoreevents::processscoreevent(level.var_6964d56c.var_6eecd3fe.var_ebd92bbc, shitloc, self.owner, psoffsettime);
        }
        shitloc challenges::destroyscorestreak(psoffsettime, self.controlled, 1, 0);
        shitloc stats::function_dad108fa(#"destroy_turret", 1);
        shitloc stats::function_e24eec31(psoffsettime, #"destroy_turret", 1);
        if (isdefined(level.var_2958ac6c)) {
            self [[ level.var_2958ac6c ]](shitloc, psoffsettime);
        }
        self battlechatter::function_d2600afc(shitloc, self.owner, self.turretweapon, psoffsettime);
        var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
        self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
        killstreaks::function_e729ccee(shitloc, psoffsettime);
    }
    self thread function_450ab98d(level.var_6964d56c.var_6eecd3fe.ksexplosionfx);
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x0
// Checksum 0x3369a22f, Offset: 0x2b78
// Size: 0x7a
function enableturretafterwait(wait_time) {
    self endon(#"death");
    if (isdefined(self.owner)) {
        self.owner endon(#"disconnect", #"joined_team", #"joined_spectators");
    }
    wait wait_time;
    self.turret_enabled = 1;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x28857cfb, Offset: 0x2c00
// Size: 0xba
function createturretinfluencer(name) {
    turret = self;
    preset = getinfluencerpreset(name);
    if (!isdefined(preset)) {
        return;
    }
    projected_point = turret.origin + vectorscale(anglestoforward(turret.angles), preset[#"radius"] * 0.7);
    return influencers::create_enemy_influencer(name, turret.origin, turret.team);
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xb3c1186d, Offset: 0x2cc8
// Size: 0xaa
function function_3a9dddac() {
    if (!isdefined(self.spawninfluencers)) {
        self.spawninfluencers = [];
        return;
    }
    foreach (influencer in self.spawninfluencers) {
        self influencers::remove_influencer(influencer);
    }
    self.spawninfluencers = [];
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x4af389a9, Offset: 0x2d80
// Size: 0x122
function turret_watch_owner_events() {
    self notify(#"turret_watch_owner_events_singleton");
    self endon(#"turret_watch_owner_events_singleton", #"death");
    self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    self makevehicleusable();
    self.controlled = 0;
    if (isdefined(self.owner)) {
        self.owner unlink();
        self clientfield::set("vehicletransition", 0);
    }
    self makevehicleunusable();
    if (isdefined(self.owner)) {
        self.owner killstreaks::clear_using_remote();
    }
    self.abandoned = 1;
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x47da6209, Offset: 0x2eb0
// Size: 0x42
function function_bc7568f1() {
    self.sightlatency = 100;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.var_3413afc5 = #"standard_sight";
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xc477647e, Offset: 0x2f00
// Size: 0x96
function function_ad4037ec() {
    foreach (var_e30e452 in self.var_6a62f08) {
        if (isdefined(var_e30e452.var_dd11f4a7)) {
            var_e30e452.var_dd11f4a7 = undefined;
            var_e30e452.var_7d92eba8 = undefined;
        }
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0xf0164216, Offset: 0x2fa0
// Size: 0x116
function function_a13e4d16(e_target) {
    assert(isdefined(e_target), "<dev string:x86>");
    if (!isdefined(self.var_6a62f08)) {
        self.var_6a62f08 = [];
    }
    var_f10e8561 = e_target getentitynumber();
    if (!isdefined(self.var_6a62f08[var_f10e8561])) {
        self.var_6a62f08[var_f10e8561] = spawnstruct();
    }
    var_e30e452 = self.var_6a62f08[var_f10e8561];
    if (var_e30e452.entity === e_target) {
        var_e30e452.var_95fec340 = 0;
    } else {
        var_e30e452.entity = e_target;
        var_e30e452.var_95fec340 = 1;
        var_e30e452.var_d8796b87 = 0;
        var_e30e452.var_dd11f4a7 = undefined;
        var_e30e452.var_7d92eba8 = undefined;
        var_e30e452.var_725e2f13 = 0;
    }
    return var_e30e452;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x17e4ea04, Offset: 0x30c0
// Size: 0xa0
function function_ad8b366c(var_2d51cbbc) {
    assert(isdefined(var_2d51cbbc));
    var_93b994e6 = isinarray(level.var_6964d56c.var_1543185c, var_2d51cbbc.killstreaktype);
    /#
        if (!var_93b994e6) {
            function_600ab97b("<dev string:xb7>" + var_2d51cbbc getentitynumber() + "<dev string:xc2>", 3);
        }
    #/
    return var_93b994e6;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x4a3a1693, Offset: 0x3168
// Size: 0x88
function function_baa22b40(str_id) {
    var_2a81938c = is_true(level.var_6964d56c.var_d67ec774[str_id]);
    /#
        if (var_2a81938c) {
            if (isdefined(self)) {
                function_600ab97b(self getentitynumber() + "<dev string:xdf>", 3);
            }
        }
    #/
    return var_2a81938c;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x7373a5b0, Offset: 0x31f8
// Size: 0x98
function function_a51316b2(e_target) {
    assert(isdefined(e_target));
    var_3f7c79aa = util::function_fbce7263(self.team, e_target.team);
    /#
        if (!var_3f7c79aa) {
            function_600ab97b("<dev string:xfb>" + e_target getentitynumber() + "<dev string:x106>", 3);
        }
    #/
    return var_3f7c79aa;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x107687ae, Offset: 0x3298
// Size: 0x1dc
function function_3276039d(e_target) {
    if (is_true(e_target.isplayervehicle) && !isdefined(e_target.killstreaktype)) {
        if (!isdefined(level.var_6964d56c.var_d689d9f8)) {
            level.var_6964d56c.var_d689d9f8 = [];
        }
        if (!isdefined(level.var_6964d56c.var_d689d9f8[e_target.vehicletype])) {
            level.var_6964d56c.var_d689d9f8[e_target.vehicletype] = e_target.maxhealth / (isdefined(self.turretweapon.maxdamage) ? self.turretweapon.maxdamage : 1);
        }
        return level.var_6964d56c.var_d689d9f8[e_target.vehicletype];
    }
    if (isdefined(e_target.killstreaktype)) {
        if (!isdefined(level.var_6964d56c.var_d689d9f8)) {
            level.var_6964d56c.var_d689d9f8 = [];
        }
        if (!isdefined(level.var_6964d56c.var_d689d9f8[e_target.killstreaktype])) {
            var_918c7f60 = killstreaks::get_script_bundle(e_target.killstreaktype);
            level.var_6964d56c.var_d689d9f8[e_target.killstreaktype] = isdefined(var_918c7f60.ksrocketstokill) ? var_918c7f60.ksrocketstokill : 1;
        }
        return (level.var_6964d56c.var_d689d9f8[e_target.killstreaktype] * 2);
    }
    return 0;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0xaf9a1818, Offset: 0x3480
// Size: 0x7e
function function_2aa33bf1(e_target) {
    var_e30e452 = function_a13e4d16(e_target);
    /#
        if (var_e30e452.var_725e2f13) {
            function_600ab97b("<dev string:xfb>" + e_target getentitynumber() + "<dev string:x123>", 3);
        }
    #/
    return var_e30e452.var_725e2f13;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0xe37dc4c9, Offset: 0x3508
// Size: 0x1a8
function function_b70b3595(e_target) {
    assert(isdefined(e_target));
    var_e30e452 = function_a13e4d16(e_target);
    var_a1eca4f3 = function_3276039d(e_target);
    should_fire = var_a1eca4f3 - var_e30e452.var_d8796b87 > 0;
    if (!should_fire) {
        var_2d9acc03 = gettime() - (isdefined(var_e30e452.var_fdb2d6c1) ? var_e30e452.var_fdb2d6c1 : gettime());
        if (var_2d9acc03 >= self.turret.var_eb9e0e9c) {
            var_e30e452.var_d8796b87 = 0;
            return 1;
        }
        /#
            function_600ab97b(e_target getentitynumber() + "<dev string:x152>" + var_a1eca4f3 + "<dev string:x15d>" + var_e30e452.var_d8796b87, 3);
            function_600ab97b("<dev string:x182>" + e_target getentitynumber() + "<dev string:x1a0>" + float(self.turret.var_eb9e0e9c - var_2d9acc03) / 1000, 3);
        #/
    }
    return should_fire;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x53a0dc69, Offset: 0x36b8
// Size: 0x1b6
function function_4359e9e(e_target) {
    v_target_position = e_target getcentroid();
    if (distance2dsquared(self.origin, v_target_position) <= self.turret.var_ddf7efa7) {
        a_trace = bullettrace(self.origin, v_target_position, 0, self);
        if (a_trace[#"entity"] === e_target) {
            return true;
        } else {
            /#
                function_600ab97b("<dev string:x1ac>" + e_target getentitynumber(), 3);
                if (getdvarint(#"hash_7a06f4366ad184cb", 0) >= 1) {
                    line(self.origin, v_target_position, (1, 0.75, 0));
                }
            #/
        }
    } else {
        /#
            function_600ab97b("<dev string:xfb>" + e_target getentitynumber() + "<dev string:x1c1>" + distance2d(self.origin, v_target_position) + "<dev string:x1d7>" + sqrt(self.turret.var_ddf7efa7), 3);
        #/
    }
    return false;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x4568444f, Offset: 0x3878
// Size: 0x134
function function_8e56c5e3(vehicle) {
    return isdefined(vehicle) && vehicle != self && is_true(vehicle.isplayervehicle) && !isdefined(vehicle.killstreaktype) && isalive(vehicle) && !vehicle function_baa22b40(vehicle.vehicletype) && util::function_fbce7263(self.team, vehicle.team) && isairborne(vehicle) && vehicle getvehoccupants().size > 0 && !function_2aa33bf1(vehicle) && function_b70b3595(vehicle) && function_4359e9e(vehicle);
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x8a0038a3, Offset: 0x39b8
// Size: 0xb4
function function_cb172aba(var_2d51cbbc) {
    return isdefined(var_2d51cbbc) && var_2d51cbbc != self && function_ad8b366c(var_2d51cbbc) && !var_2d51cbbc function_baa22b40(var_2d51cbbc.killstreaktype) && function_a51316b2(var_2d51cbbc) && !function_2aa33bf1(var_2d51cbbc) && function_b70b3595(var_2d51cbbc) && function_4359e9e(var_2d51cbbc);
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x88862229, Offset: 0x3a78
// Size: 0x3c
function is_valid_target(e_target) {
    return function_8e56c5e3(e_target) || function_cb172aba(e_target);
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xd5c26e41, Offset: 0x3ac0
// Size: 0x296
function function_145804c6() {
    foreach (vehicle in getvehiclearray()) {
        if (function_8e56c5e3(vehicle)) {
            return vehicle;
        }
    }
    level function_d464ecf7();
    foreach (var_f53a01d1 in level.var_6964d56c.var_1543185c) {
        var_b05b2ec7 = level.var_6964d56c.var_e321cb16[var_f53a01d1];
        if (isarray(var_b05b2ec7)) {
            var_4a3aec68 = [];
            foreach (var_2d51cbbc in var_b05b2ec7) {
                var_c5f39004 = distance2dsquared(var_2d51cbbc getcentroid(), self.origin);
                if (function_cb172aba(var_2d51cbbc)) {
                    if (var_4a3aec68.size == 0 || var_4a3aec68[1] < var_c5f39004) {
                        var_4a3aec68 = [var_2d51cbbc, var_c5f39004];
                    }
                }
            }
            if (var_4a3aec68.size != 0) {
                return var_4a3aec68[0];
            }
        }
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xc9e81a3c, Offset: 0x3d60
// Size: 0x76
function function_846f866d() {
    /#
        function_600ab97b("<dev string:x1de>");
    #/
    var_e30e452 = function_a13e4d16(self.var_c27dadc8);
    var_e30e452.var_7d92eba8 = undefined;
    self.var_c27dadc8 = undefined;
    self.scanning = 0;
    self notify(#"hash_1f6056bfa3098e59");
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xac8cb8b, Offset: 0x3de0
// Size: 0x1e
function function_422fb6dd() {
    self.e_current_target = undefined;
    self notify(#"hash_1f6056bfa3098e59");
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x7c8f25cd, Offset: 0x3e08
// Size: 0x16e
function function_42bacd5b() {
    assert(isdefined(self.var_c27dadc8), "<dev string:x1ed>");
    /#
        function_600ab97b("<dev string:x23b>" + self.var_c27dadc8 getentitynumber());
    #/
    var_f10e8561 = self.var_c27dadc8 getentitynumber();
    var_e30e452 = function_a13e4d16(self.var_c27dadc8);
    if (!isdefined(var_e30e452.var_dd11f4a7)) {
        function_ad4037ec();
        var_e30e452.var_dd11f4a7 = gettime();
    }
    var_e30e452.var_7d92eba8 = gettime();
    self notify(#"missile_turret_potential_target_acquired");
    self thread aim_at_target(self.var_c27dadc8);
    if (!isdefined(self.var_ec2f1ab4) || self.var_ec2f1ab4 + 5000 < gettime()) {
        self stoploopsound();
        self playloopsound(#"hash_4296223bbff4e0d9");
        self.var_ec2f1ab4 = gettime();
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xb58c0ac7, Offset: 0x3f80
// Size: 0x3b4
function function_d103a3d0() {
    if (isdefined(self.e_current_target)) {
        function_422fb6dd();
    }
    if (!isdefined(self.scanning) || self.scanning == 0) {
        self stoploopsound();
        self.scanning = 1;
        self playloopsound(#"hash_7f63867c7aa494d8");
    }
    if (isdefined(self.var_c27dadc8)) {
        var_e30e452 = function_a13e4d16(self.var_c27dadc8);
        if (var_e30e452.var_95fec340) {
            function_846f866d();
            return;
        }
        var_c84cbe10 = gettime() - var_e30e452.var_dd11f4a7;
        if (var_c84cbe10 >= self.turret.var_40c696e) {
            var_e30e452.var_725e2f13 = 1;
            function_846f866d();
            return;
        }
        var_2c65be01 = gettime() - var_e30e452.var_7d92eba8;
        if (var_2c65be01 < self.turret.var_3bfa4639) {
            var_48ec1599 = function_145804c6();
            if (!isdefined(var_48ec1599)) {
                function_846f866d();
            } else if (var_48ec1599 != self.var_c27dadc8) {
                self.var_c27dadc8 = var_48ec1599;
                function_42bacd5b();
            } else {
                /#
                    function_600ab97b("<dev string:x251>" + self.var_c27dadc8 getentitynumber() + "<dev string:x272>" + float(self.turret.var_3bfa4639 - var_2c65be01) / 1000);
                #/
            }
        } else if (is_valid_target(self.var_c27dadc8)) {
            var_943e73d7 = var_2c65be01 - self.turret.var_3bfa4639;
            /#
                function_600ab97b("<dev string:x278>" + self.var_c27dadc8 getentitynumber() + "<dev string:x272>" + float(self.turret.var_98b4ef7e - var_943e73d7) / 1000);
            #/
            function_db0ce567(self.var_c27dadc8);
            if (var_943e73d7 >= self.turret.var_98b4ef7e) {
                self.e_current_target = self.var_c27dadc8;
                self.var_c27dadc8 = undefined;
                var_e30e452.var_dd11f4a7 = undefined;
                var_e30e452.var_7d92eba8 = undefined;
                return;
            }
        } else {
            function_846f866d();
        }
        return;
    }
    self.var_c27dadc8 = function_145804c6();
    if (isdefined(self.var_c27dadc8)) {
        function_42bacd5b();
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x9d1a32a8, Offset: 0x4340
// Size: 0x74
function function_ebf4ce2c() {
    if (isdefined(self.turret.var_f75c2458)) {
        var_38034e25 = (self.turret.var_2350dc16 - self.turret.var_b19fe20c) % self.turret.var_f75c2458.size;
        return self.turret.var_f75c2458[var_38034e25].var_5ae4e41;
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xc9377d6b, Offset: 0x43c0
// Size: 0x37c
function function_16ccb771() {
    var_2d9acc03 = gettime() - (isdefined(self.var_428dfd67) ? self.var_428dfd67 : 0);
    /#
        function_600ab97b("<dev string:x299>" + float(self.turret.var_501460f - var_2d9acc03) / 1000);
    #/
    if (var_2d9acc03 >= self.turret.var_501460f) {
        var_b48dd15a = function_ebf4ce2c();
        if (isdefined(var_b48dd15a)) {
            var_ea411dd7 = level.var_6964d56c.customsettings.var_59802432;
            if (isdefined(var_ea411dd7)) {
                playfxontag(var_ea411dd7, self, var_b48dd15a);
            }
            var_e389c550 = level.var_6964d56c.customsettings.var_33b48768;
            if (isdefined(var_e389c550)) {
                self playsoundontag(var_e389c550, var_b48dd15a);
            }
        }
        wait self.turret.var_6a629b6e;
        if (isdefined(var_b48dd15a)) {
            self hidepart(var_b48dd15a);
        }
        self vehicle_ai::fire_for_rounds(self.turret.var_83891ae2, 0, self.e_current_target);
        var_e30e452 = function_a13e4d16(self.e_current_target);
        var_e30e452.var_d8796b87 += 1;
        var_e30e452.var_fdb2d6c1 = gettime();
        /#
            var_f10e8561 = self.e_current_target getentitynumber();
            function_600ab97b("<dev string:x2b8>" + var_f10e8561);
            function_600ab97b("<dev string:x2ce>" + var_f10e8561 + "<dev string:x272>" + var_e30e452.var_d8796b87);
            function_600ab97b("<dev string:x2e5>" + function_3276039d(self.e_current_target) - var_e30e452.var_d8796b87);
            function_600ab97b("<dev string:x308>" + self.turret.var_b19fe20c - 1);
        #/
        if (var_e30e452.var_d8796b87 >= function_3276039d(self.e_current_target)) {
            function_422fb6dd();
        }
        self.var_428dfd67 = var_e30e452.var_fdb2d6c1;
        self.scanning = 0;
        self.turret.var_b19fe20c--;
        if (self.turret.var_b19fe20c <= 0) {
            self thread function_450ab98d(level.var_6964d56c.var_6eecd3fe.var_8095b472);
        }
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xc6c1b114, Offset: 0x4748
// Size: 0x1fe
function function_71eb999() {
    if (self.isjammed === 1 || self.isstunned === 1) {
        return true;
    }
    if (isdefined(level.var_69f91847)) {
        level function_d464ecf7();
        if (isdefined(level.var_6964d56c.var_e321cb16[#"counteruav"])) {
            foreach (var_d5ef711 in level.var_6964d56c.var_e321cb16[#"counteruav"]) {
                if (util::function_fbce7263(self.team, var_d5ef711.team)) {
                    if (var_d5ef711 [[ level.var_69f91847 ]](self)) {
                        if (!self flag::get("is_jammed_by_cuav")) {
                            self flag::set("is_jammed_by_cuav");
                            clientfield::set("missile_turret_is_jammed_by_cuav", 1);
                        }
                        return true;
                    }
                }
            }
        }
        if (self flag::get("is_jammed_by_cuav")) {
            self flag::clear("is_jammed_by_cuav");
            clientfield::set("missile_turret_is_jammed_by_cuav", 0);
        }
    }
    return false;
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0xe5d4b80c, Offset: 0x4950
// Size: 0xee
function aim_at_target(e_target) {
    self notify("4798db9bc5575438");
    self endon("4798db9bc5575438");
    self endon(#"death", #"end_turret_scanning", #"hash_1f6056bfa3098e59");
    while (isdefined(self) && isdefined(e_target) && !is_true(self.isstunned) && !function_71eb999()) {
        self turretsettarget(0, e_target getcentroid());
        wait 0.1;
    }
    self notify(#"hash_1f6056bfa3098e59");
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0xe8a97bf0, Offset: 0x4a48
// Size: 0x1ae
function function_9d831b2f() {
    self endon(#"death", #"end_turret_scanning");
    for (;;) {
        if (function_71eb999()) {
            waitframe(1);
            continue;
        }
        if (self.var_942bf052 === "left") {
            self turretsettargetangles(0, (-10, 180, 0));
            self.var_942bf052 = "left2";
        } else if (self.var_942bf052 === "left2") {
            self turretsettargetangles(0, (-10, 360, 0));
            self.var_942bf052 = "right";
        } else if (self.var_942bf052 === "right") {
            self turretsettargetangles(0, (-10, -180, 0));
            self.var_942bf052 = "right2";
        } else {
            self turretsettargetangles(0, (-10, -360, 0));
            self.var_942bf052 = "left";
        }
        waitresult = self waittilltimeout(3.5, #"missile_turret_potential_target_acquired");
        if (waitresult._notify == "missile_turret_potential_target_acquired") {
            self waittill(#"hash_1f6056bfa3098e59");
        }
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x5a753d2d, Offset: 0x4c00
// Size: 0x13e
function turretscanning() {
    veh = self;
    veh endon(#"death", #"end_turret_scanning");
    wait 0.8;
    veh playsound(#"hash_5ecc6c2c01b49468");
    veh playloopsound(#"hash_40636cc7faf7855c");
    self thread function_9d831b2f();
    /#
        self thread function_bc71337c();
    #/
    for (;;) {
        [[ level.var_c61fd5a9 ]]->waitinqueue(self);
        if (function_71eb999()) {
            waitframe(1);
            continue;
        }
        if (is_valid_target(self.e_current_target)) {
            function_16ccb771();
        } else {
            function_d103a3d0();
        }
        waitframe(1);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x25a60916, Offset: 0x4d48
// Size: 0x1c4
function function_31477582() {
    self endon(#"death");
    waitframe(1);
    var_463c449d = 386.089 * float(function_60d95f53()) / 1000;
    max_delta = 1;
    while (true) {
        if (!isdefined(self.turret)) {
            wait 1;
            continue;
        }
        trace = physicstrace(self.origin + (0, 0, 15), self.origin + (0, 0, -10), (-3, -3, -1), (3, 3, 1), self.turret, 1 | 16);
        if (trace[#"fraction"] > 0) {
            new_origin = trace[#"position"];
            self.origin = (new_origin[0], new_origin[1], self.origin[2] - min(max_delta, self.origin[2] - new_origin[2]));
            max_delta += var_463c449d;
            waitframe(1);
            continue;
        }
        max_delta = 1;
        wait 1;
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x1 linked
// Checksum 0x79ed4c5a, Offset: 0x4f18
// Size: 0x200
function on_player_killed() {
    if (!isdefined(self.var_6ef09a14)) {
        return;
    }
    var_f60ab10f = [];
    foreach (var_69501900 in self.var_6ef09a14) {
        if (!isdefined(var_69501900)) {
            continue;
        }
        if (!isdefined(var_69501900.owner)) {
            continue;
        }
        if (!isdefined(self.var_e78602fc)) {
            continue;
        }
        if (self.var_e78602fc.vehicletype === #"missile_turret") {
            continue;
        }
        if (var_69501900.vehicletype === #"missile_turret") {
            if (!isdefined(var_f60ab10f)) {
                var_f60ab10f = [];
            } else if (!isarray(var_f60ab10f)) {
                var_f60ab10f = array(var_f60ab10f);
            }
            if (!isinarray(var_f60ab10f, var_69501900.owner)) {
                var_f60ab10f[var_f60ab10f.size] = var_69501900.owner;
            }
        }
    }
    foreach (player in var_f60ab10f) {
        player playsoundtoplayer(#"hash_37ffaa04e3f898fa", player);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 1, eflags: 0x1 linked
// Checksum 0x8c084eb0, Offset: 0x5120
// Size: 0x1a2
function function_db0ce567(e_target) {
    if (!is_true(e_target.var_be429d49) && isdefined(e_target.killstreaktype)) {
        player = e_target.owner;
        var_e7f63b12 = level.var_6964d56c.var_512625a1[e_target.killstreaktype];
        if (isdefined(player) && isdefined(var_e7f63b12)) {
            var_b8ed7d21 = player.pers[level.var_bc01f047];
            if (isdefined(var_b8ed7d21)) {
                if (var_b8ed7d21 == "blops_taacom") {
                    var_649cb645 = #"hash_a7f1fe227eab438";
                } else if (var_b8ed7d21 == "cdp_taacom") {
                    var_649cb645 = #"hash_161500023c0563cd";
                } else {
                    return;
                }
                var_6000f19a = var_649cb645 + "ss_missile_trrt_trgt_" + var_e7f63b12;
                var_af476040 = player;
                if (player isinvehicle()) {
                    vehicle = player getvehicleoccupied();
                    var_af476040 = isdefined(vehicle) ? vehicle : player;
                }
                var_af476040 playsoundtoplayer(var_6000f19a, player);
                e_target.var_be429d49 = 1;
            }
        }
    }
}

/#

    // Namespace missile_turret/namespace_1b611bca
    // Params 2, eflags: 0x0
    // Checksum 0xf9fddb21, Offset: 0x52d0
    // Size: 0xac
    function function_600ab97b(str_text, var_3f1d5c63) {
        if (!isdefined(var_3f1d5c63)) {
            var_3f1d5c63 = 2;
        }
        assert(var_3f1d5c63 >= 2);
        if (getdvarint(#"hash_7a06f4366ad184cb", 0) >= var_3f1d5c63) {
            println("<dev string:x31e>" + self getentitynumber() + "<dev string:x272>" + str_text);
        }
    }

    // Namespace missile_turret/namespace_1b611bca
    // Params 0, eflags: 0x0
    // Checksum 0x5a00f23b, Offset: 0x5388
    // Size: 0x192
    function function_bc71337c() {
        self endon(#"death", #"end_turret_scanning");
        if (getdvarint(#"hash_7a06f4366ad184cb", 0) >= 1) {
            var_4c7bb5d2 = 20;
            for (var_d6f7b785 = 0; ; var_d6f7b785++) {
                if (var_d6f7b785 % var_4c7bb5d2 == 0) {
                    util::drawcylinder(self.origin, sqrt(self.turret.var_ddf7efa7), 100000, float(function_60d95f53()) / 1000 * var_4c7bb5d2, undefined, (1, 0.85, 0));
                }
                if (isdefined(self.var_c27dadc8)) {
                    line(self.origin, self.var_c27dadc8 getcentroid(), (1, 0, 0));
                }
                if (isdefined(self.e_current_target)) {
                    line(self.origin, self.e_current_target getcentroid(), (0, 1, 0));
                }
                waitframe(1);
            }
        }
    }

#/
