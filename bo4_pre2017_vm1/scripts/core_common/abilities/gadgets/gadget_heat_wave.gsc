#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace heat_wave;

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x2
// Checksum 0xab80bfbf, Offset: 0x490
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_heat_wave", &__init__, undefined, undefined);
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0xeb8d04da, Offset: 0x4d0
// Size: 0x268
function __init__() {
    ability_player::register_gadget_activation_callbacks(41, &function_24bfbfda, &function_ab533c93);
    ability_player::register_gadget_possession_callbacks(41, &function_b521f65e, &function_dce39d30);
    ability_player::register_gadget_flicker_callbacks(41, &function_f6aa5a13);
    ability_player::register_gadget_is_inuse_callbacks(41, &function_2b12374a);
    ability_player::register_gadget_is_flickering_callbacks(41, &function_b76301e4);
    callback::on_connect(&function_5f8c8735);
    callback::on_spawned(&function_ca582876);
    clientfield::register("scriptmover", "heatwave_fx", 1, 1, "int");
    clientfield::register("allplayers", "heatwave_victim", 1, 1, "int");
    clientfield::register("toplayer", "heatwave_activate", 1, 1, "int");
    if (!isdefined(level.var_dd084298)) {
        level.var_dd084298 = 52;
    }
    if (!isdefined(level.var_206fa944)) {
        level.var_206fa944 = 53;
    }
    visionset_mgr::register_info("visionset", "heatwave", 1, level.var_dd084298, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    visionset_mgr::register_info("visionset", "charred", 1, level.var_206fa944, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    /#
    #/
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0x63f05f1e, Offset: 0x740
// Size: 0x18
function updatedvars() {
    while (true) {
        wait 1;
    }
}

// Namespace heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0xb6f820dd, Offset: 0x760
// Size: 0x22
function function_2b12374a(slot) {
    return self gadgetisactive(slot);
}

// Namespace heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0xaf78f050, Offset: 0x790
// Size: 0x22
function function_b76301e4(slot) {
    return self gadgetflickering(slot);
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x8bb5e122, Offset: 0x7c0
// Size: 0x34
function function_f6aa5a13(slot, weapon) {
    self thread function_25f27a3(slot, weapon);
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x2aad80ed, Offset: 0x800
// Size: 0x14
function function_b521f65e(slot, weapon) {
    
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0xbba2a9f7, Offset: 0x820
// Size: 0x34
function function_dce39d30(slot, weapon) {
    self clientfield::set_to_player("heatwave_activate", 0);
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x860
// Size: 0x4
function function_5f8c8735() {
    
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0x9936d302, Offset: 0x870
// Size: 0x4c
function function_ca582876() {
    self clientfield::set("heatwave_victim", 0);
    self._heat_wave_stuned_end = 0;
    self._heat_wave_stunned_by = undefined;
    self thread function_f0e244e5();
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0xe13eadb6, Offset: 0x8c8
// Size: 0x7c
function function_f0e244e5() {
    self endon(#"disconnect");
    self waittill("death");
    if (self isremotecontrolling() == 0) {
        visionset_mgr::deactivate("visionset", "charred", self);
        visionset_mgr::deactivate("visionset", "heatwave", self);
    }
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0xf4376189, Offset: 0x950
// Size: 0xa4
function function_24bfbfda(slot, weapon) {
    self playrumbleonentity("heat_wave_activate");
    self thread function_84bc744c();
    visionset_mgr::activate("visionset", "heatwave", self, 0.01, 0.1, 1.1);
    self thread function_cd3aa110(slot, weapon);
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0x545f6dfc, Offset: 0xa00
// Size: 0x6c
function function_84bc744c() {
    self endon(#"death");
    self endon(#"disconnect");
    self clientfield::set_to_player("heatwave_activate", 1);
    util::wait_network_frame();
    self clientfield::set_to_player("heatwave_activate", 0);
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x9a3ab3a7, Offset: 0xa78
// Size: 0x14
function function_ab533c93(slot, weapon) {
    
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x13642c7a, Offset: 0xa98
// Size: 0x14
function function_25f27a3(slot, weapon) {
    
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0xf8b35874, Offset: 0xab8
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Heat Wave: " + status + timestr);
    }
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x40209407, Offset: 0xb60
// Size: 0xc6
function function_d791a8c6(entity, heatwave) {
    if (!isplayer(entity)) {
        return false;
    }
    if (self getentitynumber() == entity getentitynumber()) {
        return false;
    }
    if (!isalive(entity)) {
        return false;
    }
    if (!entity util::mayapplyscreeneffect()) {
        return false;
    }
    if (!function_f59972fb(entity, heatwave)) {
        return false;
    }
    return true;
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x17dcec90, Offset: 0xc30
// Size: 0xa8
function function_f59972fb(entity, heatwave) {
    entitypoint = entity.origin + (0, 0, 50);
    if (!bullettracepassed(heatwave.origin, entitypoint, 1, self, undefined, 0, 1)) {
        return false;
    }
    /#
        thread util::draw_debug_line(heatwave.origin, entitypoint, 1);
    #/
    return true;
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x700f5a7, Offset: 0xce0
// Size: 0xa4
function function_3c6f8127(fxorg, direction) {
    self waittill("heat_wave_think", "heat_wave_think_finished");
    if (isdefined(fxorg)) {
        fxorg stoploopsound();
        fxorg playsound("gdt_heatwave_dissipate");
        fxorg clientfield::set("heatwave_fx", 0);
        fxorg delete();
    }
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x784b11c5, Offset: 0xd90
// Size: 0x180
function function_8c8249f2(origin, direction) {
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("heatwave_fx", 1);
    fxorg playloopsound("gdt_heatwave_3p_loop");
    fxorg.soundmod = "heatwave";
    fxorg.hitsomething = 0;
    self thread function_3c6f8127(fxorg, direction);
    return fxorg;
}

// Namespace heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0xfab34e4b, Offset: 0xf18
// Size: 0x104
function function_ce104e3f(weapon) {
    heatwave = spawnstruct();
    heatwave.radius = weapon.gadget_shockfield_radius;
    heatwave.origin = self geteye();
    heatwave.direction = anglestoforward(self getplayerangles());
    heatwave.up = anglestoup(self getplayerangles());
    heatwave.fxorg = function_8c8249f2(heatwave.origin, heatwave.direction);
    return heatwave;
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0xb6be5dd4, Offset: 0x1028
// Size: 0x10e
function function_cd3aa110(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"hash_cd3aa110");
    self endon(#"hash_cd3aa110");
    self.heroabilityactive = 1;
    heatwave = function_ce104e3f(weapon);
    glassradiusdamage(heatwave.origin, heatwave.radius, 400, 400, "MOD_BURNED");
    self thread function_d43be497(weapon, heatwave);
    self thread function_73aa2b7a(weapon, heatwave);
    wait 0.25;
    self.heroabilityactive = 0;
    self notify(#"hash_3a204421");
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0xae42f79b, Offset: 0x1140
// Size: 0x260
function function_d43be497(weapon, heatwave) {
    self endon(#"disconnect");
    self endon(#"hash_cd3aa110");
    starttime = gettime();
    var_39d3934f = 0;
    while (250 + starttime > gettime()) {
        entities = getdamageableentarray(heatwave.origin, heatwave.radius, 1);
        foreach (entity in entities) {
            if (isdefined(entity.var_87ddf012) && entity.var_87ddf012 + 250 + 1 > gettime()) {
                continue;
            }
            if (function_d791a8c6(entity, heatwave)) {
                var_39d3934f |= function_fd354153(weapon, entity, heatwave);
                continue;
            }
            if (!isplayer(entity)) {
                entity dodamage(1, heatwave.origin, self, self, "none", "MOD_BURNED", 0, weapon);
                entity thread function_90c44fbc(heatwave);
            }
        }
        waitframe(1);
    }
    if (isdefined(var_39d3934f) && isalive(self) && var_39d3934f && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon, "heatwaveSuccessDelay");
    }
}

// Namespace heat_wave/gadget_heat_wave
// Params 3, eflags: 0x0
// Checksum 0x3440e4e9, Offset: 0x13a8
// Size: 0x168
function function_fd354153(weapon, entity, heatwave) {
    var_d4a4fd1f = 0;
    var_76afe39c = 1;
    var_a162499c = 1;
    if (self.team == entity.team) {
        var_a162499c = 0;
        switch (level.friendlyfire) {
        case 0:
            var_76afe39c = 0;
            break;
        case 1:
            break;
        case 2:
            var_76afe39c = 0;
            var_d4a4fd1f = 1;
            break;
        case 3:
            var_d4a4fd1f = 1;
            break;
        }
    }
    if (var_76afe39c) {
        function_17971a89(weapon, entity, heatwave);
        entity thread function_90c44fbc(heatwave);
    }
    if (var_d4a4fd1f) {
        function_17971a89(weapon, self, heatwave);
        self thread function_90c44fbc(heatwave);
    }
    return var_a162499c;
}

// Namespace heat_wave/gadget_heat_wave
// Params 2, eflags: 0x0
// Checksum 0x35288bc2, Offset: 0x1518
// Size: 0x2a0
function function_73aa2b7a(weapon, heatwave) {
    self endon(#"disconnect");
    self endon(#"hash_cd3aa110");
    owner = self;
    starttime = gettime();
    while (250 + starttime > gettime()) {
        if (level.missileentities.size < 1) {
            waitframe(1);
            continue;
        }
        for (index = 0; index < level.missileentities.size; index++) {
            waitframe(1);
            grenade = level.missileentities[index];
            if (!isdefined(grenade)) {
                continue;
            }
            if (grenade.weapon.istacticalinsertion) {
                continue;
            }
            switch (grenade.model) {
            case #"t6_wpn_grenade_supply_projectile":
                continue;
            }
            if (!isdefined(grenade.owner)) {
                grenade.owner = getmissileowner(grenade);
            }
            if (isdefined(grenade.owner)) {
                if (level.teambased) {
                    if (grenade.owner.team == owner.team) {
                        continue;
                    }
                } else if (grenade.owner == owner) {
                    continue;
                }
                grenadedistancesquared = distancesquared(grenade.origin, heatwave.origin);
                if (grenadedistancesquared < heatwave.radius * heatwave.radius) {
                    if (bullettracepassed(grenade.origin, heatwave.origin + (0, 0, 29), 0, owner, grenade, 0, 1)) {
                        owner projectileexplode(grenade, heatwave, weapon);
                        index--;
                    }
                }
            }
        }
    }
}

// Namespace heat_wave/gadget_heat_wave
// Params 3, eflags: 0x0
// Checksum 0x54c1c8a3, Offset: 0x17c0
// Size: 0xb4
function projectileexplode(projectile, heatwave, weapon) {
    projposition = projectile.origin;
    playfx(level.trophydetonationfx, projposition);
    projectile notify(#"trophy_destroyed");
    self radiusdamage(projposition, 128, 105, 10, self, "MOD_BURNED", weapon);
    projectile delete();
}

// Namespace heat_wave/gadget_heat_wave
// Params 3, eflags: 0x0
// Checksum 0xc73cd6e0, Offset: 0x1880
// Size: 0x20e
function function_17971a89(weapon, entity, heatwave) {
    damage = floor(entity.health * 0.2);
    entity dodamage(damage, self.origin + (0, 0, 30), self, heatwave.fxorg, 0, "MOD_BURNED", 0, weapon);
    entity setdoublejumpenergy(0);
    entity clientfield::set("heatwave_victim", 1);
    visionset_mgr::activate("visionset", "charred", entity, 0.01, 2, 1.5);
    entity thread function_94088ef8();
    entity resetdoublejumprechargetime();
    var_2b155dcc = 2.5;
    entity._heat_wave_stuned_end = gettime() + var_2b155dcc * 1000;
    if (!isdefined(entity._heat_wave_stunned_by)) {
        entity._heat_wave_stunned_by = [];
    }
    entity._heat_wave_stunned_by[self.clientid] = entity._heat_wave_stuned_end;
    entity shellshock("heat_wave", var_2b155dcc, 1);
    entity thread function_472efb77(var_2b155dcc);
    burned = 1;
}

// Namespace heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0x7117349f, Offset: 0x1a98
// Size: 0x4c
function function_94088ef8() {
    self endon(#"disconnect");
    self endon(#"death");
    util::wait_network_frame();
    self clientfield::set("heatwave_victim", 0);
}

// Namespace heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0xd49b2355, Offset: 0x1af0
// Size: 0x36
function function_90c44fbc(heatwave) {
    self endon(#"disconnect");
    self endon(#"death");
    self.var_87ddf012 = gettime();
    wait 250;
}

// Namespace heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0x331bd97d, Offset: 0x1b30
// Size: 0xdc
function function_472efb77(var_2b155dcc) {
    var_291ac48b = spawn("script_origin", self.origin);
    var_291ac48b linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_291ac48b playloopsound("mpl_heatwave_burn_loop");
    wait var_2b155dcc;
    if (isdefined(var_291ac48b)) {
        var_291ac48b stoploopsound(0.5);
        util::wait_network_frame();
        var_291ac48b delete();
    }
}

