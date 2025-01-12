#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace tacticalinsertion;

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xb8bcb70b, Offset: 0x170
// Size: 0x8c
function init_shared() {
    level.weapontacticalinsertion = getweapon(#"tactical_insertion");
    level._effect[#"tacticalinsertionfizzle"] = #"_t6/misc/fx_equip_tac_insert_exp";
    clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int");
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 2, eflags: 0x0
// Checksum 0xfac1883f, Offset: 0x208
// Size: 0xd8
function istacspawntouchingcrates(origin, angles) {
    crate_ents = getentarray("care_package", "script_noteworthy");
    mins = (-17, -17, -40);
    maxs = (17, 17, 40);
    for (i = 0; i < crate_ents.size; i++) {
        if (crate_ents[i] istouchingvolume(origin + (0, 0, 40), mins, maxs)) {
            return true;
        }
    }
    return false;
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0xb3d498e7, Offset: 0x2e8
// Size: 0x148
function overridespawn(ispredictedspawn) {
    if (!isdefined(self.tacticalinsertion)) {
        return false;
    }
    origin = self.tacticalinsertion.origin;
    angles = self.tacticalinsertion.angles;
    team = self.tacticalinsertion.team;
    if (!ispredictedspawn) {
        self.tacticalinsertion destroy_tactical_insertion();
    }
    if (team != self.team) {
        return false;
    }
    if (istacspawntouchingcrates(origin)) {
        return false;
    }
    if (!ispredictedspawn) {
        self.tacticalinsertiontime = gettime();
        self spawn(origin, angles, "tactical insertion");
        self setspawnclientflag("SCDFL_DISABLE_LOGGING");
        self stats::function_4f10b697(level.weapontacticalinsertion, #"used", 1);
    }
    return true;
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0x3dec3a1f, Offset: 0x438
// Size: 0x3c
function waitanddelete(time) {
    self endon(#"death");
    waitframe(1);
    self delete();
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0x64198b90, Offset: 0x480
// Size: 0x6c
function watch(player) {
    if (isdefined(player.tacticalinsertion)) {
        player.tacticalinsertion destroy_tactical_insertion();
    }
    player thread spawntacticalinsertion();
    self waitanddelete(0.05);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 4, eflags: 0x0
// Checksum 0xeea0957f, Offset: 0x4f8
// Size: 0x1d8
function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"delete");
    while (true) {
        waitresult = trigger waittill(#"trigger");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed()) {
            if (isdefined(playersoundonuse)) {
                player playlocalsound(playersoundonuse);
            }
            if (isdefined(npcsoundonuse)) {
                player playsound(npcsoundonuse);
            }
            self thread [[ callback ]](player);
        }
    }
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xe4203577, Offset: 0x6d8
// Size: 0x4c
function watchdisconnect() {
    self.tacticalinsertion endon(#"delete");
    self waittill(#"disconnect");
    self.tacticalinsertion thread destroy_tactical_insertion();
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0x653b9bd5, Offset: 0x730
// Size: 0x234
function destroy_tactical_insertion(attacker) {
    self.owner.tacticalinsertion = undefined;
    self notify(#"delete");
    self.owner notify(#"tactical_insertion_destroyed");
    self.friendlytrigger delete();
    self.enemytrigger delete();
    if (isdefined(attacker) && isdefined(attacker.pers[#"team"]) && isdefined(self.owner) && isdefined(self.owner.pers[#"team"])) {
        if (level.teambased) {
            if (attacker.pers[#"team"] != self.owner.pers[#"team"]) {
                attacker notify(#"destroyed_explosive");
                attacker challenges::destroyedequipment();
                attacker challenges::destroyedtacticalinsert();
                scoreevents::processscoreevent(#"destroyed_tac_insert", attacker, self.owner, undefined);
            }
        } else if (attacker != self.owner) {
            attacker notify(#"destroyed_explosive");
            attacker challenges::destroyedequipment();
            attacker challenges::destroyedtacticalinsert();
            scoreevents::processscoreevent(#"destroyed_tac_insert", attacker, self.owner, undefined);
        }
    }
    self delete();
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0x67917219, Offset: 0x970
// Size: 0xec
function fizzle(attacker) {
    if (isdefined(self.fizzle) && self.fizzle) {
        return;
    }
    self.fizzle = 1;
    playfx(level._effect[#"tacticalinsertionfizzle"], self.origin);
    self playsound(#"dst_tac_insert_break");
    if (isdefined(attacker) && attacker != self.owner) {
        if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
            self.owner [[ level.globallogic_audio_dialog_on_player_override ]]("tact_destroyed", "item_destroyed");
        }
    }
    self destroy_tactical_insertion(attacker);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0xc0effd1d, Offset: 0xa68
// Size: 0x74
function pickup(attacker) {
    player = self.owner;
    self destroy_tactical_insertion();
    player giveweapon(level.weapontacticalinsertion);
    player setweaponammoclip(level.weapontacticalinsertion, 1);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xe60ed811, Offset: 0xae8
// Size: 0x7d0
function spawntacticalinsertion() {
    self endon(#"disconnect");
    self.tacticalinsertion = spawn("script_model", self.origin + (0, 0, 1));
    self.tacticalinsertion setmodel(#"t6_wpn_tac_insert_world");
    self.tacticalinsertion.origin = self.origin + (0, 0, 1);
    self.tacticalinsertion.angles = self.angles;
    self.tacticalinsertion.team = self.team;
    self.tacticalinsertion setteam(self.team);
    self.tacticalinsertion.owner = self;
    self.tacticalinsertion setowner(self);
    self.tacticalinsertion setweapon(level.weapontacticalinsertion);
    self.tacticalinsertion thread weaponobjects::setupreconeffect();
    self.tacticalinsertion endon(#"delete");
    if (isdefined(level.var_78c70625)) {
        self.tacticalinsertion [[ level.var_78c70625 ]]();
    }
    triggerheight = 64;
    triggerradius = 128;
    self.tacticalinsertion.friendlytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + (0, 0, 3));
    self.tacticalinsertion.friendlytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
    self.tacticalinsertion.friendlytrigger sethintstring(#"hash_83435f76ff5897f");
    if (level.teambased) {
        self.tacticalinsertion.friendlytrigger setteamfortrigger(self.team);
        self.tacticalinsertion.friendlytrigger.triggerteam = self.team;
    }
    self clientclaimtrigger(self.tacticalinsertion.friendlytrigger);
    self.tacticalinsertion.friendlytrigger.claimedby = self;
    self.tacticalinsertion.enemytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + (0, 0, 3));
    self.tacticalinsertion.enemytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
    self.tacticalinsertion.enemytrigger sethintstring(#"hash_225043ec880f05f");
    self.tacticalinsertion.enemytrigger setinvisibletoplayer(self);
    if (level.teambased) {
        self.tacticalinsertion.enemytrigger setexcludeteamfortrigger(self.team);
        self.tacticalinsertion.enemytrigger.triggerteamignore = self.team;
    }
    self.tacticalinsertion clientfield::set("tacticalinsertion", 1);
    self thread watchdisconnect();
    watcher = weaponobjects::getweaponobjectwatcherbyweapon(level.weapontacticalinsertion);
    self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.friendlytrigger, &pickup, watcher.pickupsoundplayer, watcher.pickupsound);
    self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.enemytrigger, &fizzle);
    if (isdefined(self.tacticalinsertioncount)) {
        self.tacticalinsertioncount++;
    } else {
        self.tacticalinsertioncount = 1;
    }
    self.tacticalinsertion setcandamage(1);
    self.tacticalinsertion.health = 1;
    while (true) {
        waitresult = self.tacticalinsertion waittill(#"damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        if (level.teambased && (!isdefined(attacker) || !isplayer(attacker) || attacker.team == self.team) && attacker != self) {
            continue;
        }
        if (attacker != self) {
            attacker challenges::destroyedequipment(weapon);
            attacker challenges::destroyedtacticalinsert();
            scoreevents::processscoreevent(#"destroyed_tac_insert", attacker, self, weapon);
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (weapon.dodamagefeedback) {
            if (level.teambased && self.tacticalinsertion.owner.team != attacker.team) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            } else if (!level.teambased && self.tacticalinsertion.owner != attacker) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            }
        }
        if (isdefined(attacker) && attacker != self) {
            if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
                self [[ level.globallogic_audio_dialog_on_player_override ]]("tact_destroyed", "item_destroyed");
            }
        }
        self.tacticalinsertion thread fizzle();
    }
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0x7cd950d9, Offset: 0x12c0
// Size: 0x10c
function cancel_button_think() {
    if (!isdefined(self.tacticalinsertion)) {
        return;
    }
    /#
        text = cancel_text_create();
    #/
    self thread cancel_button_press();
    event = self waittill(#"tactical_insertion_destroyed", #"disconnect", #"end_killcam", #"abort_killcam", #"tactical_insertion_canceled", #"spawned");
    if (event._notify == "tactical_insertion_canceled") {
        self.tacticalinsertion destroy_tactical_insertion();
    }
    /#
        if (isdefined(text)) {
            text destroy();
        }
    #/
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xc24da6a9, Offset: 0x13d8
// Size: 0x3c
function canceltackinsertionbutton() {
    if (level.console) {
        return self changeseatbuttonpressed();
    }
    return self jumpbuttonpressed();
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xc2669d08, Offset: 0x1420
// Size: 0x76
function cancel_button_press() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self endon(#"abort_killcam");
    while (true) {
        wait 0.05;
        if (self canceltackinsertionbutton()) {
            break;
        }
    }
    self notify(#"tactical_insertion_canceled");
}

/#

    // Namespace tacticalinsertion/tacticalinsertion
    // Params 0, eflags: 0x0
    // Checksum 0xa7f5f8cf, Offset: 0x14a0
    // Size: 0x160
    function cancel_text_create() {
        text = newdebughudelem(self);
        text.archived = 0;
        text.y = -100;
        text.alignx = "<dev string:x30>";
        text.aligny = "<dev string:x37>";
        text.horzalign = "<dev string:x30>";
        text.vertalign = "<dev string:x3e>";
        text.sort = 10;
        text.font = "<dev string:x45>";
        text.foreground = 1;
        text.hidewheninmenu = 1;
        if (self issplitscreen()) {
            text.y = -80;
            text.fontscale = 1.2;
        } else {
            text.fontscale = 1.6;
        }
        text settext(#"hash_e0dad145a9829f1");
        text.alpha = 1;
        return text;
    }

#/

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0x3676431e, Offset: 0x1608
// Size: 0xa0
function gettacticalinsertions() {
    tac_inserts = [];
    foreach (player in level.players) {
        if (isdefined(player.tacticalinsertion)) {
            tac_inserts[tac_inserts.size] = player.tacticalinsertion;
        }
    }
    return tac_inserts;
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 2, eflags: 0x0
// Checksum 0xc4617bff, Offset: 0x16b0
// Size: 0xec
function tacticalinsertiondestroyedbytrophysystem(attacker, trophysystem) {
    owner = self.owner;
    if (isdefined(attacker)) {
        attacker challenges::destroyedequipment(trophysystem.name);
        attacker challenges::destroyedtacticalinsert();
    }
    self thread fizzle();
    if (isdefined(owner)) {
        owner endon(#"death");
        owner endon(#"disconnect");
        waitframe(1);
        if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
            owner [[ level.globallogic_audio_dialog_on_player_override ]]("tact_destroyed", "item_destroyed");
        }
    }
}

// Namespace tacticalinsertion/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0x407049fb, Offset: 0x17a8
// Size: 0xac
function event_handler[grenade_fire] function_3c652189(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (grenade util::ishacked()) {
        return;
    }
    if (isdefined(level.weapontacticalinsertion) && weapon == level.weapontacticalinsertion) {
        grenade thread watch(self);
    }
}

