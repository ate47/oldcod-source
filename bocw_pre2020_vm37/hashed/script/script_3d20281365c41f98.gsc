#using script_471b31bd963b388e;
#using script_4fee90fb9fcf7e98;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\item_inventory;
#using scripts\core_common\oob;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\hawk;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreaks_shared;

#namespace hawk_wz;

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x6
// Checksum 0x66295dfa, Offset: 0x1c0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hawk_wz", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x492149c6, Offset: 0x208
// Size: 0x1ec
function private function_70a657d8() {
    var_8e2703ed = getweapon(#"eq_hawk");
    if (var_8e2703ed.name == #"none") {
        return;
    }
    level.hawk_settings = spawnstruct();
    function_d89c4cec(#"loadout");
    level.hawk_settings.weapon = var_8e2703ed;
    namespace_e579bb10::function_9b8847dd();
    if (level.hawk_settings.var_eff48ff1 == #"item_inventory") {
        callback::on_item_use(&on_item_use);
    } else if (level.hawk_settings.var_eff48ff1 == #"loadout") {
        level.hawk_settings.spawn = &spawn_hawk;
    }
    callback::on_finalize_initialization(&function_3675de8b);
    callback::on_loadout(&on_player_loadout);
    callback::on_joined_team(&on_joined_team);
    callback::on_disconnect(&on_player_disconnect);
    clientfield::register("vehicle", "hawk_range", 13000, 1, "int");
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x1 linked
// Checksum 0x39bb70a3, Offset: 0x400
// Size: 0x40
function function_3675de8b() {
    level.var_5718bd08 = isdefined(level.var_7fd6bd44) ? level.var_7fd6bd44 : level.mapcenter[2] + 1000;
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x8ac76a7b, Offset: 0x448
// Size: 0x9c
function private on_player_loadout() {
    if (level.hawk_settings.var_eff48ff1 == #"loadout") {
        if (isdefined(self.hawk.vehicle) && !self hasweapon(level.hawk_settings.weapon, 1)) {
            var_bb2c398b = 1;
            self.hawk.vehicle thread hawk::hawk_destroy(var_bb2c398b);
        }
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x3a364f86, Offset: 0x4f0
// Size: 0x54
function private on_joined_team(*params) {
    if (isdefined(self.hawk.vehicle)) {
        var_bb2c398b = 1;
        self.hawk.vehicle thread hawk::hawk_destroy(var_bb2c398b);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x989e3cdc, Offset: 0x550
// Size: 0x4c
function private on_player_disconnect() {
    if (isdefined(self.hawk.vehicle)) {
        var_bb2c398b = 1;
        self.hawk.vehicle thread hawk::hawk_destroy(var_bb2c398b);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x19939ea8, Offset: 0x5a8
// Size: 0x11a
function function_d89c4cec(var_eff48ff1) {
    assert(isdefined(level.hawk_settings), "<dev string:x38>");
    assert(ishash(var_eff48ff1), "<dev string:x73>");
    switch (var_eff48ff1) {
    case #"loadout":
    case #"hash_7d9145494a060477":
        level.hawk_settings.var_eff48ff1 = var_eff48ff1;
        break;
    default:
        assertmsg("<dev string:x94>" + (isdefined(var_eff48ff1) ? var_eff48ff1 : "<dev string:xc5>"));
        level.hawk_settings.var_eff48ff1 = #"loadout";
        break;
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x23c19377, Offset: 0x6d0
// Size: 0x11c
function private on_item_use(params) {
    self endon(#"death", #"disconnect", #"begin_grenade_tracking", #"grenade_throw_cancelled");
    if (!isdefined(params.item) || !isdefined(params.item.var_a6762160) || !isdefined(params.item.var_a6762160.weapon) || params.item.var_a6762160.weapon.name != #"eq_hawk") {
        return;
    }
    self waittill(#"grenade_fire");
    self thread spawn_hawk(params.item.id);
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x84d420c1, Offset: 0x7f8
// Size: 0x4a
function function_6ada73f(spawnpos) {
    return physicstrace(self.origin, spawnpos, (-18, -18, 0), (18, 18, 12), undefined, 16 | 2);
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x1b2a1551, Offset: 0x850
// Size: 0x2c
function private function_900bb4f5(*params) {
    if (isdefined(self)) {
        self thread hawk::hawk_destroy();
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x7611ca12, Offset: 0x888
// Size: 0x5fc
function spawn_hawk(itemid) {
    self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
    if (isdefined(self.hawk) && isdefined(self.hawk.vehicle)) {
        self.hawk.vehicle hawk::hawk_destroy(1);
    }
    self.hawk = spawnstruct();
    vehicletype = "veh_hawk_player_wz";
    playerangles = self getplayerangles();
    var_865c71c9 = (playerangles[0], playerangles[1], 0);
    var_c7588ce0 = (0, playerangles[1], 0);
    forward = anglestoforward(var_c7588ce0);
    forward *= 20;
    spawnpos = self.origin + (0, 0, 90) + forward;
    trace = self function_6ada73f(spawnpos);
    if (trace[#"fraction"] < 1) {
        spawnpos = self.origin + (0, 0, 75) + forward;
        trace = function_6ada73f(spawnpos);
    }
    if (trace[#"fraction"] < 1) {
        spawnpos = self.origin + (0, 0, 45) + forward;
        trace = function_6ada73f(spawnpos);
    }
    if (trace[#"fraction"] < 1) {
        spawnpos = self.origin + (0, 0, 75);
        trace = function_6ada73f(spawnpos);
    }
    if (trace[#"fraction"] < 1) {
        spawnpos = self.origin + (0, 0, 45);
    }
    vehicle = spawnvehicle(vehicletype, spawnpos, var_c7588ce0);
    vehicle setteam(self.team);
    vehicle.team = self.team;
    vehicle.owner = self;
    vehicle.weapon = getweapon("eq_hawk");
    vehicle.var_20c71d46 = 1;
    vehicle.overridevehicledamage = &function_b162cdbd;
    vehicle.var_c5d65381 = 1;
    vehicle.glasscollision_alt = 1;
    vehicle.is_staircase_up = &function_900bb4f5;
    vehicle.id = itemid;
    vehicle.var_bd9434ec = 1;
    if (level.hawk_settings.var_eff48ff1 == #"item_inventory") {
        level.item_vehicles[level.item_vehicles.size] = vehicle;
        vehicle thread item_inventory::function_956a8ecd();
    }
    self.hawk.vehicle = vehicle;
    bundle = level.hawk_settings.bundle;
    var_a33bcd86 = int(isdefined(bundle.var_a33bcd86) ? bundle.var_a33bcd86 : 0);
    if (isbot(self)) {
        var_a33bcd86 = 0;
    }
    if (isdefined(vehicle)) {
        if (var_a33bcd86) {
            self freezecontrolsallowlook(1);
            util::wait_network_frame(1);
            if (!isalive(vehicle)) {
                return;
            }
        }
        vehicle.can_control = 1;
        if (var_a33bcd86) {
            self.hawk.controlling = 1;
            self thread function_1b057db2();
            vehicle usevehicle(self, 0);
            self setplayerangles(var_865c71c9);
            self freezecontrolsallowlook(0);
            self util::setusingremote("hawk");
        } else {
            vehicle.var_e9f68b24 = var_865c71c9;
        }
        self thread function_1e7eecd7(vehicle, var_a33bcd86);
        self thread watch_destroyed(vehicle);
        self thread hawk_update(vehicle);
        self create_missile_hud(vehicle, var_a33bcd86);
        self thread watch_team_change(vehicle);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 15, eflags: 0x1 linked
// Checksum 0xe8286005, Offset: 0xe90
// Size: 0x118
function function_b162cdbd(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    if (gettime() - self.birthtime <= 350) {
        return 0;
    }
    startinghealth = 400;
    if (isdefined(level.hawk_settings.bundle.var_108f064f) && vsurfacenormal == getweapon(#"shock_rifle")) {
        partname = startinghealth / level.hawk_settings.bundle.var_108f064f;
    }
    return partname;
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x3433665e, Offset: 0xfb0
// Size: 0xd2
function hawk_update(vehicle) {
    self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
    vehicle endon(#"death");
    playerorigin = self.origin;
    while (true) {
        playerorigin = update_range(vehicle, playerorigin);
        if (is_true(self.isjammed)) {
            self thread function_1eddba48();
            break;
        }
        waitframe(1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0xc0120c16, Offset: 0x1090
// Size: 0x28e
function update_range(vehicle, playerorigin) {
    if (isalive(self)) {
        playerorigin = self.origin;
    }
    vehicle.var_b61d83c4 = 0;
    self.hawk.var_b61d83c4 = 0;
    distsqr = distancesquared(vehicle.origin, playerorigin);
    if (distsqr > function_a3f6cdac(level.hawk_settings.bundle.far_distance) || vehicle.origin[2] > level.var_5718bd08) {
        vehicle clientfield::set("hawk_range", 1);
        vehicle.var_b61d83c4 = 1;
        self.hawk.var_b61d83c4 = 1;
    } else {
        vehicle clientfield::set("hawk_range", 0);
    }
    if (isalive(self) && self isinvehicle() && self getvehicleoccupied() == vehicle) {
        if (distsqr > function_a3f6cdac(level.hawk_settings.bundle.max_distance)) {
            self thread function_1eddba48();
        }
        if (death_circle::is_active()) {
            if (!death_circle::function_a086017a(vehicle.origin)) {
                if (!isdefined(vehicle.var_3de57a77)) {
                    vehicle.var_3de57a77 = gettime();
                }
                var_a71a8383 = gettime() - vehicle.var_3de57a77;
                if (int(1 * 1000) <= var_a71a8383) {
                    vehicle hawk::hawk_destroy();
                }
            } else {
                vehicle.var_3de57a77 = undefined;
            }
        }
    }
    return playerorigin;
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0xb586724, Offset: 0x1328
// Size: 0x74
function watch_destroyed(vehicle) {
    self endon(#"disconnect");
    vehicle waittill(#"death");
    if (isdefined(self)) {
        if (!self util::function_63d27d4e("remote_missile")) {
            self destroy_missile_hud();
        }
    }
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x8800e226, Offset: 0x13a8
// Size: 0x1a
function private function_9e248b92() {
    return self offhandspecialbuttonpressed();
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x19cb2525, Offset: 0x13d0
// Size: 0xbe
function function_d89c1628(vehicle) {
    if (!is_true(vehicle.can_control)) {
        return false;
    }
    if (self isremotecontrolling() || self util::isusingremote()) {
        return false;
    }
    if (self.hawk.var_c1057d6c) {
        return false;
    }
    if (!self function_9e248b92()) {
        return false;
    }
    if (self function_15049d95()) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    return true;
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x4001b359, Offset: 0x1498
// Size: 0x1bc
function private function_1eddba48() {
    if (!isdefined(self) || !isdefined(self.hawk) || !isdefined(self.hawk.vehicle) || self.hawk.vehicle.var_55dded30 !== self) {
        return;
    }
    hawk = self.hawk.vehicle;
    if (hawk.var_720290e3 === 1) {
        return;
    }
    hawk.var_720290e3 = 1;
    hawk.can_control = 0;
    self.hawk.controlling = 0;
    self clientfield::set_to_player("static_postfx", 1);
    var_9e2fe80f = isdefined(level.hawk_settings.bundle.var_2f47b335) ? level.hawk_settings.bundle.var_2f47b335 : 0.5;
    wait var_9e2fe80f;
    if (isdefined(self)) {
        self clientfield::set_to_player("static_postfx", 0);
    }
    if (isdefined(self) && isdefined(hawk) && self isinvehicle() && self getvehicleoccupied() === hawk) {
        hawk usevehicle(self, 0);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0x4c1d331e, Offset: 0x1660
// Size: 0x428
function function_1e7eecd7(vehicle, var_44e9a475) {
    self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
    vehicle endon(#"death");
    if (var_44e9a475) {
        self.hawk.controlling = 1;
        vehicle.var_55dded30 = self;
        vehicle.playercontrolled = 1;
    } else {
        self.hawk.controlling = 0;
        vehicle.var_55dded30 = undefined;
        vehicle.playercontrolled = 0;
    }
    self.hawk.var_c1057d6c = 1;
    while (true) {
        if (self.hawk.controlling) {
            self thread function_c4770b46(vehicle);
            self waittill(#"exit_vehicle");
            self.hawk.controlling = 0;
            vehicle.player = self;
            vehicle.var_55dded30 = undefined;
            vehicle.playercontrolled = 0;
            vehicle setspeedimmediate(0);
            vehicle setvehvelocity((0, 0, 0));
            vehicle setphysacceleration((0, 0, 0));
            vehicle setangularvelocity((0, 0, 0));
            vehicle setneargoalnotifydist(40);
            vehicle setgoal(vehicle.origin, 1);
            vehicle function_a57c34b7(vehicle.origin, 1, 0);
            vehicle makevehicleunusable();
            self util::function_9a39538a();
            self.hawk.var_c1057d6c = 1;
            self playsoundtoplayer("gdt_hawk_pov_out", self);
            if (level.hawk_settings.var_eff48ff1 == #"item_inventory") {
                if (!is_true(vehicle.being_destroyed)) {
                    vehicle notify(#"hawk_settled");
                }
                return;
            }
            continue;
        }
        if (self function_d89c1628(vehicle)) {
            self.hawk.controlling = 1;
            self thread function_1b057db2();
            vehicle usevehicle(self, 0);
            vehicle.var_55dded30 = self;
            vehicle.playercontrolled = 1;
            self util::setusingremote("hawk");
            vehicle playsoundtoplayer("gdt_hawk_pov_in", self);
            self freezecontrolsallowlook(0);
            vehicle vehicle_ai::clearallmovement();
            vehicle function_d4c687c9();
            if (isdefined(vehicle.var_e9f68b24)) {
                self setplayerangles(vehicle.var_e9f68b24);
            }
        } else if (!self function_9e248b92()) {
            self.hawk.var_c1057d6c = 0;
        }
        waitframe(1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x1 linked
// Checksum 0xb3d88908, Offset: 0x1a90
// Size: 0x1ce
function function_1b057db2() {
    self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
    self notify("2388e017efa9e988");
    self endon("2388e017efa9e988");
    var_10a85d23 = self gestures::function_c77349d4("gestable_drone_hawk_pda");
    self stopgestureviewmodel(var_10a85d23, 0, 0);
    if (isdefined(self.var_f97921ea)) {
        var_a4137bf5 = gettime() - self.var_f97921ea;
        if (var_a4137bf5 < 850) {
            wait float(850 - var_a4137bf5) / 1000;
        }
    }
    var_37ea2019 = 0;
    while (!var_37ea2019 && isalive(self) && self.hawk.controlling) {
        if (self gestures::play_gesture(var_10a85d23, undefined, 0)) {
            var_37ea2019 = 1;
            self waittill(#"exit_vehicle", #"death");
            self.var_f97921ea = gettime();
            self stopgestureviewmodel(var_10a85d23, 0, 0);
        }
        waitframe(1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x1 linked
// Checksum 0x317ca6d0, Offset: 0x1c68
// Size: 0x4e
function function_9096c10() {
    return self usebuttonpressed() || self stancebuttonpressed() && self gamepadusedlast();
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0xa3f47d3c, Offset: 0x1cc0
// Size: 0x114
function function_c4770b46(vehicle) {
    self notify("255c61688cfe1cde");
    self endon("255c61688cfe1cde");
    vehicle endon(#"death");
    self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"exit_vehicle");
    while (self function_9096c10()) {
        waitframe(1);
    }
    while (!self function_9096c10()) {
        waitframe(1);
    }
    while (self function_9096c10()) {
        waitframe(1);
    }
    waitframe(1);
    vehicle usevehicle(self, 0);
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x416d8a69, Offset: 0x1de0
// Size: 0x90
function watch_team_change(hawk) {
    hawk endon(#"death");
    waitresult = self waittill(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist");
    if (!isdefined(hawk)) {
        return;
    }
    hawk notify(#"hawk_settled");
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0x5fffcaa1, Offset: 0x1e78
// Size: 0x4c
function create_missile_hud(vehicle, var_a33bcd86) {
    player = self;
    if (var_a33bcd86) {
        vehicle playsoundtoplayer("gdt_hawk_pov_in", self);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x1ed0
// Size: 0x4
function destroy_missile_hud() {
    
}

