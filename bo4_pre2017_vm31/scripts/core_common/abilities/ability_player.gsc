#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace ability_player;

// Namespace ability_player/ability_player
// Params 0, eflags: 0x2
// Checksum 0x7b923e26, Offset: 0x3e8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("ability_player", &__init__, undefined, undefined);
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x8fb0ce11, Offset: 0x428
// Size: 0xd4
function __init__() {
    init_abilities();
    setup_clientfields();
    level thread gadgets_wait_for_game_end();
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
// Checksum 0x80f724d1, Offset: 0x508
// Size: 0x4
function init_abilities() {
    
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x518
// Size: 0x4
function setup_clientfields() {
    
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0xaccb8035, Offset: 0x528
// Size: 0x3c
function on_player_connect() {
    if (!isdefined(self._gadgets_player)) {
        self._gadgets_player = [];
    }
    /#
        self thread abilities_devgui_player_connect();
    #/
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x48ae1140, Offset: 0x570
// Size: 0x36
function on_player_spawned() {
    self thread gadgets_wait_for_death();
    self.heroabilityactivatetime = undefined;
    self.heroabilitydectivatetime = undefined;
    self.heroabilityactive = undefined;
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x9463163, Offset: 0x5b0
// Size: 0x1c
function on_player_disconnect() {
    /#
        self thread abilities_devgui_player_disconnect();
    #/
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x5d3a43c0, Offset: 0x5d8
// Size: 0x70
function is_using_any_gadget() {
    if (!isplayer(self)) {
        return false;
    }
    for (i = 0; i < 4; i++) {
        if (self gadget_is_in_use(i)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0xebdf8086, Offset: 0x650
// Size: 0x136
function gadgets_save_power(game_ended) {
    for (slot = 0; slot < 4; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        gadgetweapon = self._gadgets_player[slot];
        powerleft = self gadgetpowerchange(slot, 0);
        if (game_ended && gadget_is_in_use(slot)) {
            self gadgetdeactivate(slot, gadgetweapon);
            if (gadgetweapon.gadget_power_round_end_active_penalty > 0) {
                powerleft -= gadgetweapon.gadget_power_round_end_active_penalty;
                powerleft = max(0, powerleft);
            }
        }
        self.pers["held_gadgets_power"][gadgetweapon] = powerleft;
    }
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0x7d7741f2, Offset: 0x790
// Size: 0x5c
function gadgets_wait_for_death() {
    self endon(#"disconnect");
    self.pers["held_gadgets_power"] = [];
    self waittill("death");
    if (!isdefined(self._gadgets_player)) {
        return;
    }
    self gadgets_save_power(0);
}

// Namespace ability_player/ability_player
// Params 0, eflags: 0x0
// Checksum 0xbe3caf1, Offset: 0x7f8
// Size: 0xea
function gadgets_wait_for_game_end() {
    level waittill("game_ended");
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
// Checksum 0x7f28508c, Offset: 0x8f0
// Size: 0x28
function script_set_cclass(cclass, save) {
    if (!isdefined(save)) {
        save = 1;
    }
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x316eab9c, Offset: 0x920
// Size: 0xc
function update_gadget(weapon) {
    
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x728fadbd, Offset: 0x938
// Size: 0x88
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
// Checksum 0xc257c2e5, Offset: 0x9c8
// Size: 0x58
function register_gadget_should_notify(type, should_notify) {
    register_gadget(type);
    if (isdefined(should_notify)) {
        level._gadgets_level[type].should_notify = should_notify;
    }
}

// Namespace ability_player/ability_player
// Params 3, eflags: 0x0
// Checksum 0x634d369d, Offset: 0xa28
// Size: 0x2c6
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
// Checksum 0x32bdd8a0, Offset: 0xcf8
// Size: 0x2c6
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
// Params 2, eflags: 0x0
// Checksum 0x80a6f627, Offset: 0xfc8
// Size: 0x176
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
// Checksum 0x90deb433, Offset: 0x1148
// Size: 0x176
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
// Checksum 0xf2561468, Offset: 0x12c8
// Size: 0x176
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
// Checksum 0x557180f, Offset: 0x1448
// Size: 0x58
function register_gadget_is_inuse_callbacks(type, inuse_func) {
    register_gadget(type);
    if (isdefined(inuse_func)) {
        level._gadgets_level[type].isinuse = inuse_func;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0x6e64f235, Offset: 0x14a8
// Size: 0x58
function register_gadget_is_flickering_callbacks(type, flickering_func) {
    register_gadget(type);
    if (isdefined(flickering_func)) {
        level._gadgets_level[type].isflickering = flickering_func;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xd2dfe74c, Offset: 0x1508
// Size: 0x176
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
// Checksum 0x9dc583f9, Offset: 0x1688
// Size: 0xda
function gadget_is_in_use(slot) {
    if (isdefined(self._gadgets_player[slot])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
            if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse)) {
                return self [[ level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse ]](slot);
            }
        }
    }
    return self gadgetisactive(slot);
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0xd36f064, Offset: 0x1770
// Size: 0x9e
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
// Checksum 0xdf0e79c4, Offset: 0x1818
// Size: 0x250
function give_gadget(slot, weapon) {
    if (isdefined(self._gadgets_player[slot])) {
        self take_gadget(slot, self._gadgets_player[slot]);
    }
    for (eslot = 0; eslot < 4; eslot++) {
        existinggadget = self._gadgets_player[eslot];
        if (isdefined(existinggadget) && existinggadget == weapon) {
            self take_gadget(eslot, existinggadget);
        }
    }
    self._gadgets_player[slot] = weapon;
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give)) {
            foreach (on_give in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give) {
                self [[ on_give ]](slot, weapon);
            }
        }
    }
    if (sessionmodeismultiplayergame()) {
        self.heroabilityname = isdefined(weapon) ? weapon.name : undefined;
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xe93f3ff1, Offset: 0x1a70
// Size: 0x150
function take_gadget(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take)) {
            foreach (on_take in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take) {
                self [[ on_take ]](slot, weapon);
            }
        }
    }
    self._gadgets_player[slot] = undefined;
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xa0018b83, Offset: 0x1bc8
// Size: 0x36c
function turn_gadget_on(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    self.playedgadgetsuccess = 0;
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on)) {
            foreach (turn_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on) {
                self [[ turn_on ]](slot, weapon);
                self trackheropoweractivated(game.timepassed);
                level notify(#"hero_gadget_activated", {#player:self, #weapon:weapon});
                self notify(#"hero_gadget_activated", {#weapon:weapon});
            }
        }
    }
    if (isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_on)) {
        self [[ level.cybercom._ability_turn_on ]](slot, weapon);
    }
    self.pers["heroGadgetNotified"] = 0;
    xuid = self getxuid();
    bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "activated", self.name, xuid);
    if (isdefined(level.playgadgetactivate)) {
        self [[ level.playgadgetactivate ]](weapon);
    }
    if (weapon.gadget_type != 14) {
        if (isdefined(self.isneardeath) && self.isneardeath == 1) {
            if (isdefined(level.heroabilityactivateneardeath)) {
                [[ level.heroabilityactivateneardeath ]]();
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
// Checksum 0x49ddaadf, Offset: 0x1f40
// Size: 0x37c
function turn_gadget_off(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off)) {
        foreach (turn_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off) {
            self [[ turn_off ]](slot, weapon);
            dead = self.health <= 0;
            self trackheropowerexpired(game.timepassed, dead, self.heavyweaponshots, self.heavyweaponhits);
        }
    }
    if (isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_off)) {
        self [[ level.cybercom._ability_turn_off ]](slot, weapon);
    }
    if (weapon.gadget_type != 14) {
        if (self isempjammed() == 1) {
            self gadgettargetresult(0);
            if (isdefined(level.callbackendherospecialistemp)) {
                if (isdefined(weapon.gadget_turnoff_onempjammed) && weapon.gadget_turnoff_onempjammed == 1) {
                    self thread [[ level.callbackendherospecialistemp ]]();
                }
            }
        }
        self.heroabilitydectivatetime = gettime();
        self.heroabilityactive = undefined;
        self.heroability = weapon;
    }
    self notify(#"heroAbility_off", {#weapon:weapon});
    xuid = self getxuid();
    bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "expired", self.name, xuid);
    if (isdefined(level.oldschool) && level.oldschool) {
        self takeweapon(weapon);
    }
}

// Namespace ability_player/ability_player
// Params 1, eflags: 0x0
// Checksum 0x509a6e31, Offset: 0x22c8
// Size: 0x282
function gadget_checkheroabilitykill(attacker) {
    heroabilitystat = 0;
    if (isdefined(attacker.heroability)) {
        switch (attacker.heroability.name) {
        case #"gadget_armor":
        case #"gadget_clone":
        case #"gadget_heat_wave":
        case #"gadget_speed_burst":
            if (isdefined(attacker.heroabilitydectivatetime) && (isdefined(attacker.heroabilityactive) || attacker.heroabilitydectivatetime > gettime() - 100)) {
                heroabilitystat = 1;
            }
            break;
        case #"gadget_camo":
        case #"gadget_flashback":
        case #"gadget_resurrect":
            if (isdefined(attacker.heroabilitydectivatetime) && (isdefined(attacker.heroabilityactive) || attacker.heroabilitydectivatetime > gettime() - 6000)) {
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
// Checksum 0xb4046506, Offset: 0x2558
// Size: 0x146
function gadget_flicker(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker)) {
        foreach (on_flicker in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker) {
            self [[ on_flicker ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xdc5615d1, Offset: 0x26a8
// Size: 0x516
function gadget_ready(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) && level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) {
        if (sessionmodeismultiplayergame()) {
            gadget_index = getitemindexfromref(self._gadgets_player[slot].name);
            if (gadget_index > 0) {
                iteminfo = getunlockableiteminfofromindex(gadget_index);
                if (isdefined(iteminfo)) {
                    loadoutslotname = iteminfo.loadoutslotname;
                    if (loadoutslotname == "heroweapon" || isdefined(loadoutslotname) && loadoutslotname == "herogadget") {
                        self luinotifyevent(%hero_weapon_received, 1, gadget_index);
                        self luinotifyeventtospectators(%hero_weapon_received, 1, gadget_index);
                    }
                }
            }
        } else if (isdefined(level.statstableid)) {
            itemrow = tablelookuprownum(level.statstableid, 4, self._gadgets_player[slot].name);
            if (itemrow > -1) {
                index = int(tablelookupcolumnforrow(level.statstableid, itemrow, 0));
                if (index != 0) {
                    self luinotifyevent(%hero_weapon_received, 1, index);
                    self luinotifyeventtospectators(%hero_weapon_received, 1, index);
                }
            }
        }
        if (!isdefined(level.gameended) || !level.gameended) {
            if (!isdefined(self.pers["heroGadgetNotified"]) || !self.pers["heroGadgetNotified"]) {
                self.pers["heroGadgetNotified"] = 1;
                if (isdefined(level.playgadgetready)) {
                    self [[ level.playgadgetready ]](weapon);
                }
                self trackheropoweravailable(game.timepassed);
            }
        }
    }
    xuid = self getxuid();
    bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "ready", self.name, xuid);
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready)) {
        foreach (on_ready in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready) {
            self [[ on_ready ]](slot, weapon);
        }
    }
}

// Namespace ability_player/ability_player
// Params 2, eflags: 0x0
// Checksum 0xcdeb91a, Offset: 0x2bc8
// Size: 0x146
function gadget_primed(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed)) {
        foreach (on_primed in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed) {
            self [[ on_primed ]](slot, weapon);
        }
    }
}

/#

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x9b3fce3d, Offset: 0x2d18
    // Size: 0x44
    function abilities_print(str) {
        toprint = "<dev string:x28>" + str;
        println(toprint);
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xfe554c61, Offset: 0x2d68
    // Size: 0xd4
    function abilities_devgui_init() {
        setdvar("<dev string:x3b>", "<dev string:x54>");
        setdvar("<dev string:x55>", "<dev string:x54>");
        setdvar("<dev string:x6e>", 0);
        if (isdedicated()) {
            return;
        }
        level.abilities_devgui_base = "<dev string:x8a>";
        level.abilities_devgui_player_connect = &abilities_devgui_player_connect;
        level.abilities_devgui_player_disconnect = &abilities_devgui_player_disconnect;
        level thread abilities_devgui_think();
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x7a5209f7, Offset: 0x2e48
    // Size: 0xb8
    function abilities_devgui_player_connect() {
        if (!isdefined(level.abilities_devgui_base)) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] != self) {
                continue;
            }
            abilities_devgui_add_player_commands(level.abilities_devgui_base, players[i].playername, i + 1);
            return;
        }
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xb6a36879, Offset: 0x2f08
    // Size: 0xf0
    function abilities_devgui_add_player_commands(root, pname, index) {
        add_cmd_with_root = "<dev string:x9b>" + root + pname + "<dev string:xa7>";
        pid = "<dev string:x54>" + index;
        menu_index = 1;
        if (isdefined(level.abilities_devgui_add_gadgets_custom)) {
            menu_index = self thread [[ level.abilities_devgui_add_gadgets_custom ]](add_cmd_with_root, pid, menu_index);
        } else {
            menu_index = abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index);
        }
        menu_index = abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
    }

    // Namespace ability_player/ability_player
    // Params 6, eflags: 0x0
    // Checksum 0x676f0c27, Offset: 0x3000
    // Size: 0xd4
    function abilities_devgui_add_player_command(root, pid, cmdname, menu_index, cmddvar, argdvar) {
        if (!isdefined(argdvar)) {
            argdvar = "<dev string:xa9>";
        }
        adddebugcommand(root + cmdname + "<dev string:xb1>" + "<dev string:x6e>" + "<dev string:xb9>" + pid + "<dev string:xbb>" + "<dev string:x3b>" + "<dev string:xb9>" + cmddvar + "<dev string:xbb>" + "<dev string:x55>" + "<dev string:xb9>" + argdvar + "<dev string:xc1>");
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x26ff1a25, Offset: 0x30e0
    // Size: 0xc0
    function abilities_devgui_add_power(add_cmd_with_root, pid, menu_index) {
        root = add_cmd_with_root + "<dev string:xc5>" + menu_index + "<dev string:xa7>";
        abilities_devgui_add_player_command(root, pid, "<dev string:xcc>", 1, "<dev string:xd7>", "<dev string:x54>");
        abilities_devgui_add_player_command(root, pid, "<dev string:xdf>", 2, "<dev string:xf0>", "<dev string:x54>");
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xf53381cc, Offset: 0x31a8
    // Size: 0x170
    function abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index) {
        a_weapons = enumerateweapons("<dev string:xfb>");
        a_hero = [];
        a_abilities = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (a_weapons[i].isgadget) {
                if (a_weapons[i].isheavyweapon) {
                    arrayinsert(a_hero, a_weapons[i], 0);
                    continue;
                }
                arrayinsert(a_abilities, a_weapons[i], 0);
            }
        }
        abilities_devgui_add_player_weapons(add_cmd_with_root, pid, a_abilities, "<dev string:x102>", menu_index);
        menu_index++;
        abilities_devgui_add_player_weapons(add_cmd_with_root, pid, a_hero, "<dev string:x111>", menu_index);
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player/ability_player
    // Params 5, eflags: 0x0
    // Checksum 0xfa7e5de0, Offset: 0x3320
    // Size: 0xbe
    function abilities_devgui_add_player_weapons(root, pid, a_weapons, weapon_type, menu_index) {
        if (isdefined(a_weapons)) {
            player_devgui_root = root + weapon_type + "<dev string:xa7>";
            for (i = 0; i < a_weapons.size; i++) {
                abilities_devgui_add_player_weap_command(player_devgui_root, pid, a_weapons[i].name, i + 1);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 4, eflags: 0x0
    // Checksum 0x57882059, Offset: 0x33e8
    // Size: 0xac
    function abilities_devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
        adddebugcommand(root + weap_name + "<dev string:xb1>" + "<dev string:x6e>" + "<dev string:xb9>" + pid + "<dev string:xbb>" + "<dev string:x3b>" + "<dev string:xb9>" + "<dev string:x11e>" + "<dev string:xbb>" + "<dev string:x55>" + "<dev string:xb9>" + weap_name + "<dev string:xc1>");
    }

    // Namespace ability_player/ability_player
    // Params 4, eflags: 0x0
    // Checksum 0x92b79317, Offset: 0x34a0
    // Size: 0xac
    function abilities_devgui_add_player_weap_command_max3(root, pid, weap_name, cmdindex) {
        adddebugcommand(root + weap_name + "<dev string:xb1>" + "<dev string:x6e>" + "<dev string:xb9>" + pid + "<dev string:xbb>" + "<dev string:x3b>" + "<dev string:xb9>" + "<dev string:x12b>" + "<dev string:xbb>" + "<dev string:x55>" + "<dev string:xb9>" + weap_name + "<dev string:xc1>");
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xcfe0e423, Offset: 0x3558
    // Size: 0x6c
    function abilities_devgui_player_disconnect() {
        if (!isdefined(level.abilities_devgui_base)) {
            return;
        }
        remove_cmd_with_root = "<dev string:x13d>" + level.abilities_devgui_base + self.playername + "<dev string:xc1>";
        util::add_queued_debug_command(remove_cmd_with_root);
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x80aba716, Offset: 0x35d0
    // Size: 0x1e0
    function abilities_devgui_think() {
        for (;;) {
            cmd = getdvarstring("<dev string:x3b>");
            if (cmd == "<dev string:x54>") {
                waitframe(1);
                continue;
            }
            arg = getdvarstring("<dev string:x55>");
            switch (cmd) {
            case #"power_f":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_fill);
                break;
            case #"power_t_af":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_toggle_auto_fill);
                break;
            case #"hash_8fab0bdd":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_give, arg);
                break;
            case #"hash_2808c155":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_give_max3, arg);
                break;
            case #"hash_e14e96e9":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_give_max3, arg);
                break;
            case #"hash_7511152":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_give_max3, arg);
                break;
            case #"":
                break;
            default:
                break;
            }
            setdvar("<dev string:x3b>", "<dev string:x54>");
            wait 0.5;
        }
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x90cd7e15, Offset: 0x37b8
    // Size: 0x126
    function abilities_devgui_give(weapon_name) {
        level.devgui_giving_abilities = 1;
        weapon = getweapon(weapon_name);
        if (weapon.isheroweapon) {
            for (i = 0; i < 4; i++) {
                if (isdefined(self._gadgets_player[i]) && weapon.inventorytype == self._gadgets_player[i].inventorytype) {
                    self takeweapon(self._gadgets_player[i]);
                }
            }
        }
        self notify(#"gadget_devgui_give");
        self giveweapon(weapon);
        self abilities_devgui_bot_test(weapon);
        level.devgui_giving_abilities = undefined;
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0xe27bae28, Offset: 0x38e8
    // Size: 0x166
    function abilities_devgui_give_max3(weapon_name) {
        maxheld = min(3, 4);
        level.devgui_giving_abilities = 1;
        current_count = 0;
        for (i = 0; i < maxheld; i++) {
            if (isdefined(self._gadgets_player[i])) {
                current_count++;
            }
        }
        if (current_count == maxheld) {
            for (i = 0; i < maxheld; i++) {
                if (isdefined(self._gadgets_player[i])) {
                    self takeweapon(self._gadgets_player[i]);
                }
            }
        }
        weapon = getweapon(weapon_name);
        self notify(#"gadget_devgui_give");
        self giveweapon(weapon);
        self abilities_devgui_bot_test(weapon);
        level.devgui_giving_abilities = undefined;
    }

    // Namespace ability_player/ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x3930ee73, Offset: 0x3a58
    // Size: 0x10c
    function abilities_devgui_handle_player_command(cmd, playercallback, pcb_param) {
        pid = getdvarint("<dev string:x6e>");
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(pcb_param)) {
                    player thread [[ playercallback ]](pcb_param);
                } else {
                    player thread [[ playercallback ]]();
                }
            }
        } else {
            array::thread_all(getplayers(), playercallback, pcb_param);
        }
        setdvar("<dev string:x6e>", "<dev string:x16a>");
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x9eb0771a, Offset: 0x3b70
    // Size: 0x96
    function abilities_devgui_power_fill() {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        for (i = 0; i < 4; i++) {
            if (isdefined(self._gadgets_player[i])) {
                self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
            }
        }
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x382760c8, Offset: 0x3c10
    // Size: 0x64
    function abilities_devgui_power_toggle_auto_fill() {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        self.abilities_devgui_power_toggle_auto_fill = !(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill);
        self thread abilities_devgui_power_toggle_auto_fill_think();
    }

    // Namespace ability_player/ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xd319a0d1, Offset: 0x3c80
    // Size: 0x120
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
            for (i = 0; i < 4; i++) {
                if (isdefined(self._gadgets_player[i])) {
                    if (!self gadget_is_in_use(i) && self gadgetcharging(i)) {
                        self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
                    }
                }
            }
            wait 1;
        }
    }

    // Namespace ability_player/ability_player
    // Params 1, eflags: 0x0
    // Checksum 0xe60071a0, Offset: 0x3da8
    // Size: 0x84
    function abilities_devgui_bot_test(weapon) {
        if (self isbot()) {
            slot = self gadgetgetslot(weapon);
            self gadgetpowerset(slot, 100);
            self thread bot::activate_hero_gadget(weapon);
        }
    }

#/
