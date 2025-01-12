#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_role;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ability_player;

// Namespace ability_player/ability_player
// Params 0, eflags: 0x2
// Checksum 0xc14ad8d4, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ability_player", &__init__, undefined, undefined);
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x8c724ac, Offset: 0x1b8
// Size: 0xcc
function __init__() {
    level callback::add_callback(#"on_end_game", &on_end_game);
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    if (!isdefined(level._gadgets_level)) {
        level._gadgets_level = [];
    }
    /#
        level thread abilities_devgui_init();
    #/
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0xbc7350d6, Offset: 0x290
// Size: 0x104
function on_player_connect() {
    if (!isdefined(self._gadgets_player)) {
        self._gadgets_player = [];
    }
    if (!isdefined(self.var_5d9fd314)) {
        self.var_5d9fd314 = [];
    }
    if (!isdefined(self.pers[#"herogadgetnotified"])) {
        self.pers[#"herogadgetnotified"] = [];
    }
    for (slot = 0; slot < 3; slot++) {
        self.pers[#"herogadgetnotified"][slot] = 0;
    }
    self callback::on_death(&function_7d4b4f7b);
    /#
        if (self getentnum() < 10) {
            self thread abilities_devgui_player_connect();
        }
    #/
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0xf19eea4, Offset: 0x3a0
// Size: 0x27e
function on_player_spawned() {
    var_3bde8abe = self getweaponslist();
    foreach (weapon in var_3bde8abe) {
        if (isdefined(weapon.gadget_power_reset_on_spawn) ? weapon.gadget_power_reset_on_spawn : 0) {
            slot = self gadgetgetslot(weapon);
            isfirstspawn = isdefined(self.firstspawn) ? self.firstspawn : 1;
            self gadgetpowerreset(slot, isfirstspawn);
        }
    }
    if ((isdefined(self.var_d28d8eb) ? self.var_d28d8eb : 1) && game.state == "playing") {
        self.var_d28d8eb = 0;
        for (slot = 0; slot < 3; slot++) {
            if (isdefined(self._gadgets_player[slot])) {
                gadgetweapon = self._gadgets_player[slot];
                if (isdefined(gadgetweapon.var_610bb62a) ? gadgetweapon.var_610bb62a : 0) {
                    self gadgetpowerset(slot, isdefined(gadgetweapon.var_7ba5675b) ? gadgetweapon.var_7ba5675b : 100);
                }
            }
        }
    } else if (game.state != "playing") {
        self.var_d28d8eb = 0;
    }
    self.pers[#"held_gadgets_power"] = [];
    self.pers[#"hash_7a954c017d693f69"] = [];
    self.pers[#"hash_68cdf8807cfaabff"] = [];
    self.heroabilityactivatetime = undefined;
    self.heroabilitydectivatetime = undefined;
    self.heroabilityactive = undefined;
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x1fb25ffc, Offset: 0x628
// Size: 0x1c
function on_player_disconnect() {
    /#
        self thread abilities_devgui_player_disconnect();
    #/
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x7f60c79b, Offset: 0x650
// Size: 0x68
function is_using_any_gadget() {
    if (!isplayer(self)) {
        return false;
    }
    for (i = 0; i < 3; i++) {
        if (self util::gadget_is_in_use(i)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0xfd16372b, Offset: 0x6c0
// Size: 0x192
function gadgets_save_power(game_ended) {
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        gadgetweapon = self._gadgets_player[slot];
        powerleft = self gadgetpowerchange(slot, 0);
        var_a90a1713 = self function_bdbaf1fa(slot);
        deployed = self function_49de461b(slot);
        if (game_ended && util::gadget_is_in_use(slot)) {
            if (gadgetweapon.gadget_power_round_end_active_penalty > 0) {
                powerleft -= gadgetweapon.gadget_power_round_end_active_penalty;
                powerleft = max(0, powerleft);
            }
        }
        self.pers[#"held_gadgets_power"][gadgetweapon] = powerleft;
        self.pers[#"hash_7a954c017d693f69"][gadgetweapon] = var_a90a1713;
        self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon] = deployed;
    }
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x4acfe411, Offset: 0x860
// Size: 0x5e
function function_f9ff1eac() {
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        self function_1d590050(slot, 0);
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x812a9f76, Offset: 0x8c8
// Size: 0x7c
function function_184edba5(weapon, var_ef31a667 = 0) {
    slot = self gadgetgetslot(weapon);
    self gadgetdeactivate(slot, weapon, var_ef31a667);
    self function_c4526e40(slot, weapon);
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x9faf4d70, Offset: 0x950
// Size: 0x1a4
function function_281eba9f(weapon, var_ef31a667 = 0) {
    if (isalive(self)) {
        slot = self gadgetgetslot(weapon);
        self function_d5703bc4(slot, var_ef31a667);
        return;
    }
    if (!isdefined(self.var_a96858f0)) {
        self.var_a96858f0 = [];
        self.var_15097b6f = [];
    }
    if (!isdefined(self.var_a96858f0)) {
        self.var_a96858f0 = [];
    } else if (!isarray(self.var_a96858f0)) {
        self.var_a96858f0 = array(self.var_a96858f0);
    }
    self.var_a96858f0[self.var_a96858f0.size] = weapon;
    if (!isdefined(self.var_15097b6f)) {
        self.var_15097b6f = [];
    } else if (!isarray(self.var_15097b6f)) {
        self.var_15097b6f = array(self.var_15097b6f);
    }
    self.var_15097b6f[self.var_15097b6f.size] = var_ef31a667;
    callback::function_1dea870d(#"on_player_spawned", &function_2b730346);
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x5cc1d5de, Offset: 0xb00
// Size: 0xcc
function function_2b730346(params) {
    if (isdefined(self.var_a96858f0)) {
        for (i = 0; i < self.var_a96858f0.size; i++) {
            slot = self gadgetgetslot(self.var_a96858f0[i]);
            self function_d5703bc4(slot, self.var_15097b6f[i]);
        }
    }
    self.var_a96858f0 = undefined;
    self.var_15097b6f = undefined;
    callback::function_1f42556c(#"on_player_spawned", &function_2b730346);
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x6e5ae743, Offset: 0xbd8
// Size: 0x84
function function_d5703bc4(slot, var_ef31a667 = 0) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    self.pers[#"hash_68cdf8807cfaabff"][self._gadgets_player[slot]] = 0;
    self function_68b8ba6e(slot, self._gadgets_player[slot], var_ef31a667);
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x4deba930, Offset: 0xc68
// Size: 0x3e
function function_6b37db83() {
    for (slot = 0; slot < 3; slot++) {
        self function_d5703bc4(slot);
    }
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0xbc606527, Offset: 0xcb0
// Size: 0x4c
function function_7d4b4f7b(params) {
    if (game.state != "playing") {
        return;
    }
    if (!isdefined(self._gadgets_player)) {
        return;
    }
    self gadgets_save_power(0);
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x70f1f6ce, Offset: 0xd08
// Size: 0xc8
function on_end_game() {
    players = getplayers();
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(player._gadgets_player)) {
            continue;
        }
        player gadgets_save_power(1);
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xa61fbbb2, Offset: 0xdd8
// Size: 0x24
function script_set_cclass(cclass, save = 1) {
    
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x8cb06b91, Offset: 0xe08
// Size: 0x82
function register_gadget(type) {
    if (!isdefined(level._gadgets_level)) {
        level._gadgets_level = [];
    }
    if (!isdefined(level._gadgets_level[type])) {
        level._gadgets_level[type] = spawnstruct();
        level._gadgets_level[type].should_notify = 1;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xbf258fbe, Offset: 0xe98
// Size: 0x52
function register_gadget_should_notify(type, should_notify) {
    register_gadget(type);
    if (isdefined(should_notify)) {
        level._gadgets_level[type].should_notify = should_notify;
    }
}

// Namespace ability_player/ability_player
// Params 3, eflags: 0x0
// Checksum 0x904f2c5f, Offset: 0xef8
// Size: 0x252
function register_gadget_possession_callbacks(type, on_give, on_take) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_give)) {
        level._gadgets_level[type].on_give = [];
    }
    if (!isdefined(level._gadgets_level[type].on_take)) {
        level._gadgets_level[type].on_take = [];
    }
    if (isdefined(on_give)) {
        if (!isdefined(level._gadgets_level[type].on_give)) {
            level._gadgets_level[type].on_give = [];
        } else if (!isarray(level._gadgets_level[type].on_give)) {
            level._gadgets_level[type].on_give = array(level._gadgets_level[type].on_give);
        }
        level._gadgets_level[type].on_give[level._gadgets_level[type].on_give.size] = on_give;
    }
    if (isdefined(on_take)) {
        if (!isdefined(level._gadgets_level[type].on_take)) {
            level._gadgets_level[type].on_take = [];
        } else if (!isarray(level._gadgets_level[type].on_take)) {
            level._gadgets_level[type].on_take = array(level._gadgets_level[type].on_take);
        }
        level._gadgets_level[type].on_take[level._gadgets_level[type].on_take.size] = on_take;
    }
}

// Namespace ability_player/ability_player
// Params 3, eflags: 0x0
// Checksum 0xb4643489, Offset: 0x1158
// Size: 0x252
function register_gadget_activation_callbacks(type, turn_on, turn_off) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].turn_on)) {
        level._gadgets_level[type].turn_on = [];
    }
    if (!isdefined(level._gadgets_level[type].turn_off)) {
        level._gadgets_level[type].turn_off = [];
    }
    if (isdefined(turn_on)) {
        if (!isdefined(level._gadgets_level[type].turn_on)) {
            level._gadgets_level[type].turn_on = [];
        } else if (!isarray(level._gadgets_level[type].turn_on)) {
            level._gadgets_level[type].turn_on = array(level._gadgets_level[type].turn_on);
        }
        level._gadgets_level[type].turn_on[level._gadgets_level[type].turn_on.size] = turn_on;
    }
    if (isdefined(turn_off)) {
        if (!isdefined(level._gadgets_level[type].turn_off)) {
            level._gadgets_level[type].turn_off = [];
        } else if (!isarray(level._gadgets_level[type].turn_off)) {
            level._gadgets_level[type].turn_off = array(level._gadgets_level[type].turn_off);
        }
        level._gadgets_level[type].turn_off[level._gadgets_level[type].turn_off.size] = turn_off;
    }
}

// Namespace ability_player/ability_player
// Params 3, eflags: 0x0
// Checksum 0x4b7d9efd, Offset: 0x13b8
// Size: 0x252
function function_642003d3(type, deployed_on, deployed_off) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].deployed_on)) {
        level._gadgets_level[type].deployed_on = [];
    }
    if (!isdefined(level._gadgets_level[type].deployed_off)) {
        level._gadgets_level[type].deployed_off = [];
    }
    if (isdefined(deployed_on)) {
        if (!isdefined(level._gadgets_level[type].deployed_on)) {
            level._gadgets_level[type].deployed_on = [];
        } else if (!isarray(level._gadgets_level[type].deployed_on)) {
            level._gadgets_level[type].deployed_on = array(level._gadgets_level[type].deployed_on);
        }
        level._gadgets_level[type].deployed_on[level._gadgets_level[type].deployed_on.size] = deployed_on;
    }
    if (isdefined(deployed_off)) {
        if (!isdefined(level._gadgets_level[type].deployed_off)) {
            level._gadgets_level[type].deployed_off = [];
        } else if (!isarray(level._gadgets_level[type].deployed_off)) {
            level._gadgets_level[type].deployed_off = array(level._gadgets_level[type].deployed_off);
        }
        level._gadgets_level[type].deployed_off[level._gadgets_level[type].deployed_off.size] = deployed_off;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x5171df2a, Offset: 0x1618
// Size: 0x13a
function register_gadget_flicker_callbacks(type, on_flicker) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_flicker)) {
        level._gadgets_level[type].on_flicker = [];
    }
    if (isdefined(on_flicker)) {
        if (!isdefined(level._gadgets_level[type].on_flicker)) {
            level._gadgets_level[type].on_flicker = [];
        } else if (!isarray(level._gadgets_level[type].on_flicker)) {
            level._gadgets_level[type].on_flicker = array(level._gadgets_level[type].on_flicker);
        }
        level._gadgets_level[type].on_flicker[level._gadgets_level[type].on_flicker.size] = on_flicker;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xa5f06159, Offset: 0x1760
// Size: 0x13a
function register_gadget_ready_callbacks(type, ready_func) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_ready)) {
        level._gadgets_level[type].on_ready = [];
    }
    if (isdefined(ready_func)) {
        if (!isdefined(level._gadgets_level[type].on_ready)) {
            level._gadgets_level[type].on_ready = [];
        } else if (!isarray(level._gadgets_level[type].on_ready)) {
            level._gadgets_level[type].on_ready = array(level._gadgets_level[type].on_ready);
        }
        level._gadgets_level[type].on_ready[level._gadgets_level[type].on_ready.size] = ready_func;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x7b0d6297, Offset: 0x18a8
// Size: 0x13a
function register_gadget_primed_callbacks(type, primed_func) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_primed)) {
        level._gadgets_level[type].on_primed = [];
    }
    if (isdefined(primed_func)) {
        if (!isdefined(level._gadgets_level[type].on_primed)) {
            level._gadgets_level[type].on_primed = [];
        } else if (!isarray(level._gadgets_level[type].on_primed)) {
            level._gadgets_level[type].on_primed = array(level._gadgets_level[type].on_primed);
        }
        level._gadgets_level[type].on_primed[level._gadgets_level[type].on_primed.size] = primed_func;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x40c7b65b, Offset: 0x19f0
// Size: 0x52
function register_gadget_is_inuse_callbacks(type, inuse_func) {
    register_gadget(type);
    if (isdefined(inuse_func)) {
        level._gadgets_level[type].isinuse = inuse_func;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x172a68e6, Offset: 0x1a50
// Size: 0x52
function register_gadget_is_flickering_callbacks(type, flickering_func) {
    register_gadget(type);
    if (isdefined(flickering_func)) {
        level._gadgets_level[type].isflickering = flickering_func;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xb06a1516, Offset: 0x1ab0
// Size: 0x13a
function register_gadget_failed_activate_callback(type, failed_activate) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].failed_activate)) {
        level._gadgets_level[type].failed_activate = [];
    }
    if (isdefined(failed_activate)) {
        if (!isdefined(level._gadgets_level[type].failed_activate)) {
            level._gadgets_level[type].failed_activate = [];
        } else if (!isarray(level._gadgets_level[type].failed_activate)) {
            level._gadgets_level[type].failed_activate = array(level._gadgets_level[type].failed_activate);
        }
        level._gadgets_level[type].failed_activate[level._gadgets_level[type].failed_activate.size] = failed_activate;
    }
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x78567a41, Offset: 0x1bf8
// Size: 0x7e
function gadget_is_flickering(slot) {
    if (!isdefined(self._gadgets_player[slot])) {
        return 0;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering)) {
        return 0;
    }
    return self [[ level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering ]](slot);
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x673961ba, Offset: 0x1c80
// Size: 0x27a
function give_gadget(slot, weapon) {
    if (isdefined(self._gadgets_player[slot])) {
        if (self._gadgets_player[slot] != weapon) {
            self.pers[#"hash_68cdf8807cfaabff"][self._gadgets_player[slot]] = 0;
        }
        self take_gadget(slot, self._gadgets_player[slot]);
    }
    for (eslot = 0; eslot < 3; eslot++) {
        existinggadget = self._gadgets_player[eslot];
        if (isdefined(existinggadget) && existinggadget == weapon) {
            self take_gadget(eslot, existinggadget);
        }
    }
    self._gadgets_player[slot] = weapon;
    if (!isdefined(self.var_5d9fd314[slot])) {
        self.var_5d9fd314[slot] = 0;
    }
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give)) {
            foreach (on_give in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give) {
                self thread [[ on_give ]](slot, weapon);
            }
        }
    }
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self.heroabilityname = isdefined(weapon) ? weapon.name : undefined;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xbf68f584, Offset: 0x1f08
// Size: 0x114
function take_gadget(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take)) {
            foreach (on_take in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take) {
                self thread [[ on_take ]](slot, weapon);
            }
        }
    }
    self._gadgets_player[slot] = undefined;
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x3fc347f8, Offset: 0x2028
// Size: 0x5cc
function turn_gadget_on(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (weapon != self._gadgets_player[slot]) {
        return;
    }
    self.var_5d9fd314[slot] = 0;
    self gadgetsetactivatetime(slot, gettime());
    self.playedgadgetsuccess = 0;
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on)) {
            self function_c483008(weapon);
            var_19235ac1 = self function_2fd1a0e3();
            players = util::get_active_players(self.team);
            clientnum = self getentitynumber();
            foreach (player in players) {
                player luinotifyevent(#"ability_callout", 2, var_19235ac1, clientnum);
            }
            foreach (turn_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on) {
                self thread [[ turn_on ]](slot, weapon);
            }
        }
    }
    if (sessionmodeismultiplayergame()) {
        if (weapon.name == #"gadget_health_regen") {
            var_5bc3670c = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
            if (isdefined(var_5bc3670c)) {
                self match_record::inc_stat(#"lives", var_5bc3670c, #"hash_2380fc76594e930d", 1);
            }
        } else {
            self function_b7d9e0d1(game.timepassed, weapon.name);
        }
    } else {
        self function_b7d9e0d1(game.timepassed, weapon.name);
    }
    level notify(#"hero_gadget_activated", {#player:self, #weapon:weapon});
    self notify(#"hero_gadget_activated", {#weapon:weapon});
    if (isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_on)) {
        self thread [[ level.cybercom._ability_turn_on ]](slot, weapon);
    }
    self.pers[#"herogadgetnotified"][slot] = 0;
    xuid = self getxuid();
    mpheropowerevents = {#spawnid:getplayerspawnid(self), #gametime:function_25e96038(), #name:self._gadgets_player[slot].name, #powerstate:"activated", #playername:self.name, #xuid:xuid};
    function_b1f6086c(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
    if (isdefined(level.playgadgetactivate)) {
        self thread [[ level.playgadgetactivate ]](weapon);
    }
    if (weapon.gadget_type != 11) {
        if (isdefined(self.isneardeath) && self.isneardeath == 1) {
            if (isdefined(level.heroabilityactivateneardeath)) {
                self thread [[ level.heroabilityactivateneardeath ]]();
            }
        }
        self.heroabilityactivatetime = gettime();
        self.heroabilityactive = 1;
        self.heroability = weapon;
    }
    self thread ability_power::power_consume_timer_think(slot, weapon);
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xb5034d28, Offset: 0x2600
// Size: 0x464
function turn_gadget_off(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    self.var_5d9fd314[slot] = 0;
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off)) {
        self function_910bc61f(0);
        foreach (turn_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off) {
            self thread [[ turn_off ]](slot, weapon);
            self globallogic_score::function_691c588f(weapon);
        }
    }
    if (isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_off)) {
        self thread [[ level.cybercom._ability_turn_off ]](slot, weapon);
    }
    if (weapon.gadget_type != 11) {
        if (self isempjammed() == 1) {
            self gadgettargetresult(0);
            if (isdefined(level.var_3b36608e)) {
                if (isdefined(weapon.gadget_turnoff_onempjammed) && weapon.gadget_turnoff_onempjammed == 1) {
                    self thread [[ level.var_3b36608e ]]();
                }
            }
        }
        self.heroabilitydectivatetime = gettime();
        self.heroabilityactive = undefined;
        self.heroability = weapon;
    }
    dead = self.health <= 0;
    if (sessionmodeismultiplayergame()) {
        if (weapon.name != #"gadget_health_regen") {
            self function_9fbd3a87(game.timepassed, weapon.name, dead, self.heavyweaponshots, self.heavyweaponhits);
        }
    } else {
        self function_9fbd3a87(game.timepassed, weapon.name, dead, self.heavyweaponshots, self.heavyweaponhits);
    }
    self notify(#"heroability_off", {#weapon:weapon});
    xuid = self getxuid();
    mpheropowerevents = {#spawnid:getplayerspawnid(self), #gametime:function_25e96038(), #name:self._gadgets_player[slot].name, #powerstate:"expired", #playername:self.name, #xuid:xuid};
    function_b1f6086c(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
    if (isdefined(level.oldschool) && level.oldschool) {
        self takeweapon(weapon);
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x63df84e1, Offset: 0x2a70
// Size: 0x144
function function_eec487e0(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    self.var_5d9fd314[slot] = 0;
    self gadgetsetactivatetime(slot, gettime());
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_on)) {
        self function_910bc61f(0);
        foreach (deployed_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_on) {
            self thread [[ deployed_on ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x4441b5c2, Offset: 0x2bc0
// Size: 0x12c
function function_5af5ab8e(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    self.var_5d9fd314[slot] = 0;
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_off)) {
        self function_910bc61f(0);
        foreach (deployed_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].deployed_off) {
            self thread [[ deployed_off ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0xe6cd60e, Offset: 0x2cf8
// Size: 0x286
function gadget_checkheroabilitykill(attacker) {
    heroabilitystat = 0;
    if (isdefined(attacker.heroability)) {
        switch (attacker.heroability.name) {
        case #"gadget_clone":
        case #"gadget_heat_wave":
        case #"gadget_armor":
        case #"gadget_speed_burst":
            if (isdefined(attacker.heroabilityactive) || isdefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > gettime() - 100) {
                heroabilitystat = 1;
            }
            break;
        case #"gadget_resurrect":
        case #"gadget_camo":
            if (isdefined(attacker.heroabilityactive) || isdefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > gettime() - 6000) {
                heroabilitystat = 1;
            }
            break;
        case #"gadget_vision_pulse":
            if (isdefined(attacker.visionpulsespottedenemytime)) {
                timecutoff = gettime();
                if (attacker.visionpulsespottedenemytime + 10000 > timecutoff) {
                    for (i = 0; i < attacker.visionpulsespottedenemy.size; i++) {
                        spottedenemy = attacker.visionpulsespottedenemy[i];
                        if (spottedenemy == self) {
                            if (self.lastspawntime < attacker.visionpulsespottedenemytime) {
                                heroabilitystat = 1;
                                break;
                            }
                        }
                    }
                }
            }
        case #"gadget_combat_efficiency":
            if (isdefined(attacker._gadget_combat_efficiency) && attacker._gadget_combat_efficiency == 1) {
                heroabilitystat = 1;
                break;
            } else if (isdefined(attacker.combatefficiencylastontime) && attacker.combatefficiencylastontime > gettime() - 100) {
                heroabilitystat = 1;
                break;
            }
            break;
        }
    }
    return heroabilitystat;
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x8ce5bd7e, Offset: 0x2f88
// Size: 0x104
function gadget_flicker(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker)) {
        foreach (on_flicker in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker) {
            self thread [[ on_flicker ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x17d6815f, Offset: 0x3098
// Size: 0x4d4
function gadget_ready(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) && level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) {
        gadget_index = getitemindexfromref(self._gadgets_player[slot].name);
        if (gadget_index > 0) {
            iteminfo = getunlockableiteminfofromindex(gadget_index, 1);
            if (iteminfo.itemgroupname === "killstreak") {
                return;
            }
            if (isdefined(iteminfo)) {
                loadoutslotname = iteminfo.loadoutslotname;
                if (isdefined(loadoutslotname) && loadoutslotname == "herogadget") {
                    self luinotifyevent(#"hero_weapon_received", 1, gadget_index);
                    self luinotifyeventtospectators(#"hero_weapon_received", 1, gadget_index);
                }
            }
        }
        if (!isdefined(level.gameended) || !level.gameended) {
            if (!self.pers[#"herogadgetnotified"][slot]) {
                self.pers[#"herogadgetnotified"][slot] = 1;
                if (isdefined(level.playgadgetready)) {
                    self thread [[ level.playgadgetready ]](weapon);
                }
            }
        }
    }
    if (sessionmodeismultiplayergame()) {
        if (weapon.name == #"gadget_health_regen") {
            var_5bc3670c = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
            if (isdefined(var_5bc3670c)) {
                self match_record::inc_stat(#"lives", var_5bc3670c, #"hash_656f3981134db095", 1);
            }
        } else {
            self function_b6cb647d(game.timepassed, weapon.name);
        }
    } else {
        self function_b6cb647d(game.timepassed, weapon.name);
    }
    xuid = self getxuid();
    mpheropowerevents = {#spawnid:getplayerspawnid(self), #gametime:function_25e96038(), #name:self._gadgets_player[slot].name, #powerstate:"ready", #playername:self.name, #xuid:xuid};
    function_b1f6086c(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready)) {
        foreach (on_ready in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready) {
            self thread [[ on_ready ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xf441c697, Offset: 0x3578
// Size: 0x104
function gadget_primed(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed)) {
        foreach (on_primed in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed) {
            self thread [[ on_primed ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 3, eflags: 0x0
// Checksum 0x91056d20, Offset: 0x3688
// Size: 0xfe
function tutorial_timer(weapon, var_513c16df, var_38490530) {
    assert(isdefined(var_513c16df) && isstring(var_513c16df));
    if (isdefined(var_38490530)) {
        tutorial_init(weapon);
        self.pers[#"ability_tutorial"][weapon].(var_513c16df) = gettime() + var_38490530 * 1000;
    }
    return isdefined(self.pers[#"ability_tutorial"][weapon].(var_513c16df)) && self.pers[#"ability_tutorial"][weapon].(var_513c16df) > gettime();
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x7ab807d0, Offset: 0x3790
// Size: 0x98
function tutorial_init(weapon) {
    if (!isdefined(self.pers[#"ability_tutorial"])) {
        self.pers[#"ability_tutorial"] = [];
    }
    if (!isdefined(self.pers[#"ability_tutorial"][weapon])) {
        self.pers[#"ability_tutorial"][weapon] = spawnstruct();
    }
}

// Namespace ability_player/ability_player
// Params 6, eflags: 0x0
// Checksum 0xe7211f90, Offset: 0x3830
// Size: 0x388
function tutorial_hints(slot, weapon, var_a5eb652f, var_f29c742e, var_f9a197e0, var_3ed5d4a2) {
    self notify("equip_tutorial_text_" + weapon.name);
    self endon(#"disconnect", #"death", "equip_tutorial_text_" + weapon.name);
    self tutorial_init(weapon);
    while (true) {
        if (!self hasweapon(weapon)) {
            break;
        }
        currentslot = self gadgetgetslot(weapon);
        if (currentslot != slot) {
            break;
        }
        if (!self gadgetisready(slot)) {
            break;
        }
        if (self gadgetisprimed(slot)) {
            break;
        }
        if (self util::gadget_is_in_use(slot)) {
            break;
        }
        if (self isinvehicle() || self function_52d36b7e() || self scene::is_igc_active() || self isplayinganimscripted()) {
            wait 5;
            continue;
        }
        if (self tutorial_timer(weapon, "recentlyUsed")) {
            wait 5;
            continue;
        }
        if (self tutorial_timer(weapon, "recentlyEquip")) {
            wait 5;
            continue;
        }
        if (self tutorial_timer(weapon, "recentlyReady")) {
            wait 5;
            continue;
        }
        if (!self tutorial_timer(weapon, "recentlyEquipText") && isdefined(var_f29c742e) && isdefined(var_3ed5d4a2) && self [[ var_3ed5d4a2 ]](slot, weapon)) {
            self tutorial_timer(weapon, "recentlyEquipText", 60);
            self thread [[ var_f29c742e ]](var_a5eb652f, 0, "hide_gadget_equip_hint", 7);
            /#
                self function_a6b815f6(var_a5eb652f);
            #/
        }
        if (!self tutorial_timer(weapon, "recentlyReadyVoice") && isdefined(var_f9a197e0)) {
            self tutorial_timer(weapon, "recentlyReadyVoice", 60);
            voiceevent(var_f9a197e0, self, undefined);
            /#
                self function_a6b815f6(var_f9a197e0);
            #/
        }
        wait 5;
    }
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x136dcf02, Offset: 0x3bc0
// Size: 0xbc
function function_40b227b1(var_3649f966 = 0) {
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        gadgetweapon = self._gadgets_player[slot];
        if (ability_util::is_hero_weapon(gadgetweapon)) {
            continue;
        }
        self gadgetdeactivate(slot, gadgetweapon);
    }
    self forceoffhandend();
}

/#

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x12bcfa02, Offset: 0x3c88
    // Size: 0x6c
    function function_a6b815f6(str) {
        if (ishash(str)) {
            str = function_15979fa9(str);
        }
        toprint = "<dev string:x30>" + str;
        println(toprint);
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x14d7252f, Offset: 0x3d00
    // Size: 0x3c
    function abilities_print(str) {
        toprint = "<dev string:x45>" + str;
        println(toprint);
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x3bdc49de, Offset: 0x3d48
    // Size: 0xec
    function abilities_devgui_init() {
        setdvar(#"scr_abilities_devgui_cmd", "<dev string:x58>");
        setdvar(#"scr_abilities_devgui_arg", "<dev string:x58>");
        setdvar(#"scr_abilities_devgui_player", 0);
        if (isdedicated()) {
            return;
        }
        level.abilities_devgui_base = "<dev string:x59>";
        level.abilities_devgui_player_connect = &abilities_devgui_player_connect;
        level.abilities_devgui_player_disconnect = &abilities_devgui_player_disconnect;
        level thread abilities_devgui_think();
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x75ee57ef, Offset: 0x3e40
    // Size: 0xb0
    function abilities_devgui_player_connect() {
        if (!isdefined(level.abilities_devgui_base)) {
            return;
        }
        wait 2;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] != self) {
                continue;
            }
            thread abilities_devgui_add_player_commands(level.abilities_devgui_base, players[i].playername, i + 1);
            return;
        }
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xc6cedc39, Offset: 0x3ef8
    // Size: 0x14e
    function abilities_devgui_add_player_commands(root, pname, index) {
        add_cmd_with_root = "<dev string:x6a>" + root + pname + "<dev string:x76>";
        pid = "<dev string:x58>" + index;
        menu_index = 1;
        if (isdefined(level.abilities_devgui_add_gadgets_custom)) {
            menu_index = self thread [[ level.abilities_devgui_add_gadgets_custom ]](root, pname, pid, menu_index);
            return;
        }
        util::waittill_can_add_debug_command();
        menu_index = abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index);
        util::waittill_can_add_debug_command();
        menu_index = abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
        util::waittill_can_add_debug_command();
        menu_index = function_cad495e7(add_cmd_with_root, pid, menu_index);
    }

    // Namespace ability_player/ability_player
    // Params 6, eflags: 0x0
    // Checksum 0xb01be05a, Offset: 0x4050
    // Size: 0x104
    function abilities_devgui_add_player_command(root, pid, cmdname, menu_index, cmddvar, argdvar) {
        if (!isdefined(argdvar)) {
            argdvar = "<dev string:x78>";
        }
        var_dd73aba8 = "<dev string:x80>" + "<dev string:x88>" + "<dev string:xa4>" + pid;
        var_62fe2b19 = "<dev string:xa6>" + "<dev string:xac>" + "<dev string:xa4>" + cmddvar;
        var_e47207d9 = "<dev string:xa6>" + "<dev string:xc5>" + "<dev string:xa4>" + argdvar + "<dev string:xde>";
        util::add_queued_debug_command(root + cmdname + var_dd73aba8 + var_62fe2b19 + var_e47207d9);
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x3effbe35, Offset: 0x4160
    // Size: 0x17c
    function abilities_devgui_add_power(add_cmd_with_root, pid, menu_index) {
        root = add_cmd_with_root + "<dev string:xe2>" + menu_index + "<dev string:x76>";
        abilities_devgui_add_player_command(root, pid, "<dev string:xe9>", 1, "<dev string:xf4>", "<dev string:x58>");
        abilities_devgui_add_player_command(root, pid, "<dev string:xfc>", 2, "<dev string:x10d>", "<dev string:x58>");
        for (power = 0; power <= 1; power += 0.25) {
            abilities_devgui_add_player_command(root, pid, "<dev string:x118>" + power, 2, "<dev string:x12d>", "<dev string:x58>" + power);
            abilities_devgui_add_player_command(root, pid, "<dev string:x13f>" + power, 2, "<dev string:x152>", "<dev string:x58>" + power);
        }
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x8590552e, Offset: 0x42e8
    // Size: 0x282
    function function_cad495e7(add_cmd_with_root, pid, menu_index) {
        if (sessionmodeiszombiesgame() || sessionmodeiswarzonegame()) {
            return;
        }
        root = add_cmd_with_root + "<dev string:x162>" + menu_index + "<dev string:x76>";
        session_mode = currentsessionmode();
        var_62c33e14 = getplayerroletemplatecount(session_mode);
        for (i = 1; i < var_62c33e14; i++) {
            var_fcd4f540 = getplayerrolecategory(i, session_mode);
            if (!isdefined(var_fcd4f540)) {
                continue;
            }
            var_9a112987 = getplayerrolecategoryinfo(var_fcd4f540);
            var_2134f185 = makelocalizedstring(getcharacterdisplayname(i, session_mode));
            var_2134f185 = strreplace(var_2134f185, "<dev string:x168>", "<dev string:x58>");
            if (var_2134f185 == "<dev string:x16a>") {
                var_2134f185 = "<dev string:x177>";
            }
            var_2bc575bc = function_15979fa9(function_b9650e7f(i, session_mode));
            var_c7ca38e2 = var_2134f185 + "<dev string:x184>" + (isdefined(var_2bc575bc) ? var_2bc575bc : "<dev string:x188>") + "<dev string:x18d>";
            if (!isdefined(var_9a112987.enabled) || var_9a112987.enabled == 0) {
                var_c7ca38e2 += "<dev string:x18f>";
            }
            abilities_devgui_add_player_command(root, pid, var_c7ca38e2, i, "<dev string:x19b>", i);
        }
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xbad0a5fe, Offset: 0x4578
    // Size: 0xec
    function function_3bc3613b(&a_weapons, &a_array, weaponname) {
        weapon = getweapon(weaponname);
        if (!isdefined(weapon)) {
            return;
        }
        if (!isinarray(a_weapons, weapon)) {
            return;
        }
        if (!isdefined(a_array)) {
            a_array = [];
        } else if (!isarray(a_array)) {
            a_array = array(a_array);
        }
        if (!isinarray(a_array, weapon)) {
            a_array[a_array.size] = weapon;
        }
        arrayremovevalue(a_weapons, weapon);
    }

    // Namespace ability_player/ability_player
    // Params 4, eflags: 0x0
    // Checksum 0x9639474a, Offset: 0x4670
    // Size: 0x166
    function function_4a110aa4(&a_weapons, &a_equipment, &var_ededfa3f, &a_ultimates) {
        if (sessionmodeiszombiesgame()) {
            return;
        }
        session_mode = currentsessionmode();
        var_62c33e14 = getplayerroletemplatecount(session_mode);
        for (i = 1; i < var_62c33e14; i++) {
            fields = function_34c0bf28(i, session_mode);
            if (!isdefined(fields)) {
                continue;
            }
            if (isdefined(fields.primaryequipment)) {
                function_3bc3613b(a_weapons, a_equipment, fields.primaryequipment);
            }
            if (isdefined(fields.var_4c698c3d)) {
                function_3bc3613b(a_weapons, var_ededfa3f, fields.var_4c698c3d);
            }
            if (isdefined(fields.ultimateweapon)) {
                function_3bc3613b(a_weapons, a_ultimates, fields.ultimateweapon);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 2, eflags: 0x0
    // Checksum 0x1a5ae6c3, Offset: 0x47e0
    // Size: 0xc6
    function function_8a9a9a99(&a_weapons, &var_269123c) {
        for (i = 0; i < 1024; i++) {
            iteminfo = getunlockableiteminfofromindex(i, 0);
            if (isdefined(iteminfo)) {
                reference_s = iteminfo.namehash;
                loadoutslotname = iteminfo.loadoutslotname;
                if (loadoutslotname == "<dev string:x1aa>") {
                    function_3bc3613b(a_weapons, var_269123c, reference_s);
                }
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x7aadd131, Offset: 0x48b0
    // Size: 0x5f8
    function abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index) {
        a_weapons = enumerateweapons("<dev string:x1b9>");
        a_gadgetweapons = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (isdefined(a_weapons[i]) && a_weapons[i].isgadget) {
                if (!isdefined(a_gadgetweapons)) {
                    a_gadgetweapons = [];
                } else if (!isarray(a_gadgetweapons)) {
                    a_gadgetweapons = array(a_gadgetweapons);
                }
                if (!isinarray(a_gadgetweapons, a_weapons[i])) {
                    a_gadgetweapons[a_gadgetweapons.size] = a_weapons[i];
                }
            }
        }
        a_equipment = [];
        var_ededfa3f = [];
        a_ultimates = [];
        function_4a110aa4(a_gadgetweapons, a_equipment, var_ededfa3f, a_ultimates);
        var_269123c = [];
        function_8a9a9a99(a_gadgetweapons, var_269123c);
        var_15c75e6b = [];
        var_fa976ef7 = [];
        var_d6544092 = [];
        var_b996376f = [];
        a_heal = [];
        for (i = 0; i < a_gadgetweapons.size; i++) {
            if (a_gadgetweapons[i].gadget_type == 11 && a_gadgetweapons[i].issignatureweapon) {
                if (!isdefined(var_15c75e6b)) {
                    var_15c75e6b = [];
                } else if (!isarray(var_15c75e6b)) {
                    var_15c75e6b = array(var_15c75e6b);
                }
                if (!isinarray(var_15c75e6b, a_gadgetweapons[i])) {
                    var_15c75e6b[var_15c75e6b.size] = a_gadgetweapons[i];
                }
                continue;
            }
            if (a_gadgetweapons[i].gadget_type == 11) {
                if (!isdefined(var_fa976ef7)) {
                    var_fa976ef7 = [];
                } else if (!isarray(var_fa976ef7)) {
                    var_fa976ef7 = array(var_fa976ef7);
                }
                if (!isinarray(var_fa976ef7, a_gadgetweapons[i])) {
                    var_fa976ef7[var_fa976ef7.size] = a_gadgetweapons[i];
                }
                continue;
            }
            if (a_gadgetweapons[i].isheavyweapon) {
                if (!isdefined(var_d6544092)) {
                    var_d6544092 = [];
                } else if (!isarray(var_d6544092)) {
                    var_d6544092 = array(var_d6544092);
                }
                if (!isinarray(var_d6544092, a_gadgetweapons[i])) {
                    var_d6544092[var_d6544092.size] = a_gadgetweapons[i];
                }
                continue;
            }
            if (a_gadgetweapons[i].gadget_type == 23) {
                if (!isdefined(a_heal)) {
                    a_heal = [];
                } else if (!isarray(a_heal)) {
                    a_heal = array(a_heal);
                }
                if (!isinarray(a_heal, a_gadgetweapons[i])) {
                    a_heal[a_heal.size] = a_gadgetweapons[i];
                }
                continue;
            }
            if (!isdefined(var_b996376f)) {
                var_b996376f = [];
            } else if (!isarray(var_b996376f)) {
                var_b996376f = array(var_b996376f);
            }
            if (!isinarray(var_b996376f, a_gadgetweapons[i])) {
                var_b996376f[var_b996376f.size] = a_gadgetweapons[i];
            }
        }
        function_2ebc3573(add_cmd_with_root, pid, a_equipment, "<dev string:x1c0>", menu_index);
        menu_index++;
        function_33c90c64(add_cmd_with_root, pid, a_heal, "<dev string:x1cf>", menu_index);
        menu_index++;
        function_e270d61e(add_cmd_with_root, pid, var_ededfa3f, "<dev string:x1e6>", menu_index);
        menu_index++;
        function_2ebc3573(add_cmd_with_root, pid, var_269123c, "<dev string:x1f5>", menu_index);
        menu_index++;
        function_2ebc3573(add_cmd_with_root, pid, var_b996376f, "<dev string:x207>", menu_index);
        menu_index++;
        function_e270d61e(add_cmd_with_root, pid, var_15c75e6b, "<dev string:x21f>", menu_index);
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player/ability_player
    // Params 5, eflags: 0x0
    // Checksum 0x918b11ac, Offset: 0x4eb0
    // Size: 0xbe
    function function_2ebc3573(root, pid, a_weapons, weapon_type, menu_index) {
        if (isdefined(a_weapons)) {
            player_devgui_root = root + weapon_type + "<dev string:x76>";
            for (i = 0; i < a_weapons.size; i++) {
                function_ceb82ab1(player_devgui_root, pid, getweaponname(a_weapons[i]), i + 1);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 5, eflags: 0x0
    // Checksum 0x63c4e03, Offset: 0x4f78
    // Size: 0xbe
    function function_33c90c64(root, pid, a_weapons, weapon_type, menu_index) {
        if (isdefined(a_weapons)) {
            player_devgui_root = root + weapon_type + "<dev string:x76>";
            for (i = 0; i < a_weapons.size; i++) {
                function_22365a92(player_devgui_root, pid, getweaponname(a_weapons[i]), i + 1);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 5, eflags: 0x0
    // Checksum 0x8e56c230, Offset: 0x5040
    // Size: 0xbe
    function function_e270d61e(root, pid, a_weapons, weapon_type, menu_index) {
        if (isdefined(a_weapons)) {
            player_devgui_root = root + weapon_type + "<dev string:x76>";
            for (i = 0; i < a_weapons.size; i++) {
                function_517e4464(player_devgui_root, pid, getweaponname(a_weapons[i]), i + 1);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 4, eflags: 0x0
    // Checksum 0x8937bc15, Offset: 0x5108
    // Size: 0xac
    function function_ceb82ab1(root, pid, weap_name, cmdindex) {
        util::add_queued_debug_command(root + weap_name + "<dev string:x80>" + "<dev string:x88>" + "<dev string:xa4>" + pid + "<dev string:xa6>" + "<dev string:xac>" + "<dev string:xa4>" + "<dev string:x237>" + "<dev string:xa6>" + "<dev string:xc5>" + "<dev string:xa4>" + weap_name + "<dev string:xde>");
    }

    // Namespace ability_player/ability_player
    // Params 4, eflags: 0x0
    // Checksum 0x1cc5215a, Offset: 0x51c0
    // Size: 0xac
    function function_22365a92(root, pid, weap_name, cmdindex) {
        util::add_queued_debug_command(root + weap_name + "<dev string:x80>" + "<dev string:x88>" + "<dev string:xa4>" + pid + "<dev string:xa6>" + "<dev string:xac>" + "<dev string:xa4>" + "<dev string:x251>" + "<dev string:xa6>" + "<dev string:xc5>" + "<dev string:xa4>" + weap_name + "<dev string:xde>");
    }

    // Namespace ability_player/ability_player
    // Params 4, eflags: 0x0
    // Checksum 0xe6f474d7, Offset: 0x5278
    // Size: 0xac
    function function_517e4464(root, pid, weap_name, cmdindex) {
        util::add_queued_debug_command(root + weap_name + "<dev string:x80>" + "<dev string:x88>" + "<dev string:xa4>" + pid + "<dev string:xa6>" + "<dev string:xac>" + "<dev string:xa4>" + "<dev string:x26d>" + "<dev string:xa6>" + "<dev string:xc5>" + "<dev string:xa4>" + weap_name + "<dev string:xde>");
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x57839b29, Offset: 0x5330
    // Size: 0x5c
    function abilities_devgui_player_disconnect() {
        if (!isdefined(level.abilities_devgui_base)) {
            return;
        }
        remove_cmd_with_root = "<dev string:x287>" + level.abilities_devgui_base + self.playername + "<dev string:xde>";
        util::add_queued_debug_command(remove_cmd_with_root);
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xa212be7e, Offset: 0x5398
    // Size: 0x368
    function abilities_devgui_think() {
        setdvar(#"hash_67d528f29bfc7c97", "<dev string:x58>");
        for (;;) {
            cmd = "<dev string:x19b>";
            arg = getdvarstring(#"hash_67d528f29bfc7c97", "<dev string:x58>");
            if (arg == "<dev string:x58>") {
                cmd = getdvarstring(#"scr_abilities_devgui_cmd");
                arg = getdvarstring(#"scr_abilities_devgui_arg");
            }
            if (cmd == "<dev string:x58>") {
                waitframe(1);
                continue;
            }
            switch (cmd) {
            case #"power_f":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_fill);
                break;
            case #"power_t_af":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_toggle_auto_fill);
                break;
            case #"ability_power_f":
                abilities_devgui_handle_player_command(cmd, &function_e697150d, arg);
                break;
            case #"hash_5b8a32e219f9ae64":
                abilities_devgui_handle_player_command(cmd, &function_f91adeeb, arg);
                break;
            case #"hash_2d2f6f2bb98a38b3":
                abilities_devgui_handle_player_command(cmd, &function_1cf075db, arg);
                break;
            case #"hash_5ddbad8870b98e93":
                abilities_devgui_handle_player_command(cmd, &function_a867c217, arg);
                break;
            case #"hash_5515835378aa90c8":
                abilities_devgui_handle_player_command(cmd, &function_29c4904a, arg);
                break;
            case #"hash_67d528f29bfc7c97":
                abilities_devgui_handle_player_command(cmd, &function_66631b20, arg);
                break;
            case 0:
                break;
            default:
                break;
            }
            setdvar(#"hash_67d528f29bfc7c97", "<dev string:x58>");
            setdvar(#"scr_abilities_devgui_cmd", "<dev string:x58>");
            setdvar(#"scr_abilities_devgui_player", "<dev string:x296>");
            wait 0.5;
        }
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x1d2d1540, Offset: 0x5708
    // Size: 0x114
    function function_8348f045(weapon) {
        self notify(#"gadget_devgui_give");
        self giveweapon(weapon);
        waitframe(1);
        slot = self gadgetgetslot(weapon);
        self gadgetpowerreset(slot, 1);
        self gadgetpowerset(slot, 100);
        self gadgetcharging(slot, 0);
        if (isbot(self)) {
            self bot_action::function_38c9bca9(slot);
        }
        self iprintlnbold(getweaponname(weapon));
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xb6cf768e, Offset: 0x5828
    // Size: 0xe6
    function abilities_devgui_give(weapon_name, slot, var_7a4a24fa) {
        level.devgui_giving_abilities = 1;
        if (isdefined(self._gadgets_player[slot]) && self hasweapon(self._gadgets_player[slot])) {
            self gadgetpowerreset(slot, 1);
            self takeweapon(self._gadgets_player[slot]);
        }
        weapon = getweapon(weapon_name);
        self thread function_8348f045(weapon);
        level.devgui_giving_abilities = undefined;
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x46ab3b74, Offset: 0x5918
    // Size: 0xc4
    function function_29c4904a(weapon_name) {
        if (isdefined(level.var_3edcced1) && isarray(level.var_3edcced1) && isdefined(level.var_3edcced1[weapon_name])) {
            self [[ level.var_3edcced1[weapon_name] ]](self, 2);
            return;
        }
        if (isdefined(level.var_3edcced1)) {
            self [[ level.var_3edcced1 ]](weapon_name, 2);
            return;
        }
        self abilities_devgui_give(weapon_name, 2);
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0xb5c03aa3, Offset: 0x59e8
    // Size: 0x74
    function function_a867c217(weapon_name) {
        if (isdefined(level.var_9bab9942) && isdefined(level.var_9bab9942[weapon_name])) {
            self [[ level.var_9bab9942[weapon_name] ]](self, 1);
            return;
        }
        self abilities_devgui_give(weapon_name, 1);
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x5974274e, Offset: 0x5a68
    // Size: 0x74
    function function_1cf075db(weapon_name) {
        if (isdefined(level.var_1a88b5be) && isdefined(level.var_1a88b5be[weapon_name])) {
            self [[ level.var_1a88b5be[weapon_name] ]](self, 0);
            return;
        }
        self abilities_devgui_give(weapon_name, 0);
    }

    // Namespace ability_player/ability_player
    // Params 2, eflags: 0x0
    // Checksum 0x50653400, Offset: 0x5ae8
    // Size: 0x134
    function function_19be5700(offhandslot, ability_list) {
        if (!isdefined(ability_list)) {
            ability_list = level.var_bd345605;
        }
        if (!isdefined(ability_list)) {
            return;
        }
        weapon = undefined;
        if (isdefined(self._gadgets_player[offhandslot])) {
            weapon = self._gadgets_player[offhandslot];
        }
        weapon_name = undefined;
        if (isdefined(weapon)) {
            var_24ce675 = 0;
            for (i = 0; i < ability_list.size; i++) {
                ability_name = ability_list[i];
                if (weapon.name == ability_name) {
                    var_24ce675 = i;
                    break;
                }
            }
            var_24ce675 = (var_24ce675 + 1) % ability_list.size;
            weapon_name = ability_list[var_24ce675];
        }
        if (2 == offhandslot) {
            self function_29c4904a(weapon_name);
        }
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x72c4acf6, Offset: 0x5c28
    // Size: 0xe4
    function abilities_devgui_handle_player_command(cmd, playercallback, pcb_param) {
        pid = getdvarint(#"scr_abilities_devgui_player", 0);
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(pcb_param)) {
                    player thread [[ playercallback ]](pcb_param);
                } else {
                    player thread [[ playercallback ]]();
                }
            }
            return;
        }
        array::thread_all(getplayers(), playercallback, pcb_param);
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x2ec04823, Offset: 0x5d18
    // Size: 0xae
    function abilities_devgui_power_fill() {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        for (i = 0; i < 3; i++) {
            if (isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i])) {
                self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0xb88d4e0f, Offset: 0x5dd0
    // Size: 0x9c
    function function_f91adeeb(var_74f3b59d) {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        if (isdefined(self._gadgets_player[0]) && self hasweapon(self._gadgets_player[0])) {
            self gadgetpowerset(0, self._gadgets_player[0].gadget_powermax * float(var_74f3b59d));
        }
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0xdb466ebc, Offset: 0x5e78
    // Size: 0xac
    function function_e697150d(var_74f3b59d) {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        if (isdefined(self._gadgets_player[2]) && self hasweapon(self._gadgets_player[2])) {
            self gadgetpowerset(2, self._gadgets_player[2].gadget_powermax * float(var_74f3b59d));
        }
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x1e21a2c3, Offset: 0x5f30
    // Size: 0x5c
    function abilities_devgui_power_toggle_auto_fill() {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        self.abilities_devgui_power_toggle_auto_fill = !(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill);
        self thread abilities_devgui_power_toggle_auto_fill_think();
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xd7cc0547, Offset: 0x5f98
    // Size: 0x138
    function abilities_devgui_power_toggle_auto_fill_think() {
        self endon(#"disconnect");
        self notify(#"auto_fill_think");
        self endon(#"auto_fill_think");
        for (;;) {
            if (!isdefined(self) || !isdefined(self._gadgets_player)) {
                return;
            }
            if (!(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill)) {
                return;
            }
            for (i = 0; i < 3; i++) {
                if (isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i])) {
                    if (!self util::gadget_is_in_use(i) && self gadgetcharging(i)) {
                        self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
                    }
                }
            }
            wait 1;
        }
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0xc40a0687, Offset: 0x60d8
    // Size: 0x378
    function function_66631b20(var_d2b7851e) {
        if (sessionmodeiszombiesgame()) {
            return;
        }
        if (self isinmovemode("<dev string:x299>")) {
            adddebugcommand("<dev string:x299>");
            wait 0.5;
        }
        if (self isinmovemode("<dev string:x29d>")) {
            adddebugcommand("<dev string:x29d>");
            wait 0.5;
        }
        if (var_d2b7851e == "<dev string:x2a4>") {
            startindex = self player_role::get();
            index = startindex;
            do {
                index += 1;
                if (index == startindex) {
                    return;
                }
                if (index >= getplayerroletemplatecount(currentsessionmode())) {
                    index = 0;
                }
            } while (!self player_role::is_valid(index));
        } else if (var_d2b7851e == "<dev string:x2a6>") {
            startindex = self player_role::get();
            index = startindex;
            do {
                index -= 1;
                if (index == startindex) {
                    return;
                }
                if (index == 0) {
                    index = getplayerroletemplatecount(currentsessionmode());
                }
            } while (!self player_role::is_valid(index));
        } else {
            index = int(var_d2b7851e);
        }
        self function_f9ff1eac();
        self function_6b37db83();
        self player_role::set(index);
        if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            spawnselect = level.spawnselectenabled;
            level.spawnselectenabled = 0;
            if (level.numlives) {
                self.pers[#"lives"]++;
            }
            self suicide("<dev string:x2a8>");
            waitframe(1);
            if (isdefined(self)) {
                self luinotifyevent(#"hash_2dddf8559f5b304d", 1, 1);
            }
            level.spawnselectenabled = spawnselect;
            return;
        }
        if (sessionmodeiscampaigngame()) {
            if (isdefined(level.var_19db7470)) {
                self thread [[ level.var_19db7470 ]](self.team, self.curclass);
            }
        }
    }

#/
