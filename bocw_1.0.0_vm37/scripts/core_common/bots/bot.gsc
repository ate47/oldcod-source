#using script_34e162235fb08844;
#using script_4e44ad88a2b0f559;
#using script_55b445d561c4bd83;
#using script_5e6a760c6f43dd12;
#using script_74453936abc39adf;
#using script_79b47c663155f8bd;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_orders;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\bots\bot_stance;
#using scripts\core_common\bots\bot_traversals;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\system_shared;

#namespace bot;

// Namespace bot/bot
// Params 0, eflags: 0x6
// Checksum 0x87abcc89, Offset: 0x1a8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bot", &preinit, undefined, undefined, undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x12da9ae8, Offset: 0x1f0
// Size: 0x2e4
function private preinit() {
    if (currentsessionmode() == 4 || currentsessionmode() == 2) {
        return;
    }
    level.var_fa5cacde = getgametypesetting(#"hash_77b7734750cd75e9") || is_true(level.var_fa5cacde);
    /#
        if (getdvarint(#"hash_7140b31f7170f18b", 0)) {
            setdvar(#"scr_player_ammo", "<dev string:x38>");
        }
    #/
    if (is_true(level.var_fa5cacde)) {
        callback::on_spawned(&function_abe38e0f);
        callback::on_player_killed(&function_96dddf6f);
        return;
    }
    namespace_87549638::preinit();
    bot_action::preinit();
    bot_difficulty::preinit();
    namespace_38ee089b::preinit();
    bot_orders::preinit();
    namespace_ffbf548b::preinit();
    bot_position::preinit();
    bot_stance::preinit();
    namespace_255a2b21::preinit();
    bot_traversals::preinit();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_6efb8cec1ca372dc", &function_7291a729);
    callback::add_callback(#"hash_6280ac8ed281ce3c", &function_99a2ecf5);
    callback::add_callback(#"hash_730d00ef91d71acf", &function_8481733a);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xc9452d55, Offset: 0x4e0
// Size: 0x6
function is_bot_ranked_match() {
    return false;
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0x9b3c51a5, Offset: 0x4f0
// Size: 0x15a
function add_bot(team, name = undefined, clanabbrev = undefined) {
    bot = addtestclient(name, clanabbrev);
    if (!isdefined(bot)) {
        return undefined;
    }
    bot init_bot();
    if (is_true(level.disableclassselection)) {
        bot.pers[#"class"] = level.defaultclass;
        bot.curclass = level.defaultclass;
    }
    if (level.teambased && isdefined(team) && isdefined(level.teams[team])) {
        bot.botteam = team;
    } else if (isdefined(team) && team == #"spectator") {
        bot.botteam = #"spectator";
    } else {
        bot.botteam = "autoassign";
    }
    return bot;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x54b065b, Offset: 0x658
// Size: 0x96
function add_bots(count = 1, team) {
    level endon(#"game_ended", #"remove_bot");
    for (i = 0; i < count; i++) {
        bot = add_bot(team);
        if (!isdefined(bot)) {
            return;
        }
        waitframe(1);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x5bc9c446, Offset: 0x6f8
// Size: 0x42c
function function_e4055765() {
    var_458ddbc0 = self.bot.var_458ddbc0;
    foreach (bit, val in var_458ddbc0) {
        self bottapbutton(bit);
        if (val > 1) {
            var_458ddbc0[bit] = undefined;
        }
    }
    var_852d7a5c = isprofilebuild();
    /#
        var_852d7a5c = 1;
    #/
    if (!var_852d7a5c) {
        return;
    }
    if (getdvarint(#"bot_forcefire", 0)) {
        weapon = self getcurrentweapon();
        if (weapon.firetype == #"full auto" || weapon.firetype == #"auto burst" || weapon.firetype == #"minigun" || !self attackbuttonpressed()) {
            self bottapbutton(0);
            if (weapon.dualwieldweapon != level.weaponnone) {
                self bottapbutton(11);
            }
        } else {
            self botreleasebutton(0);
            if (weapon.dualwieldweapon != level.weaponnone) {
                self botreleasebutton(11);
            }
        }
    }
    if (getdvarint(#"bot_forcemelee", 0)) {
        if (!self ismeleeing()) {
            self bottapbutton(2);
        }
    }
    if (getdvarint(#"bot_forcestand", 0)) {
        self botreleasebutton(9);
        self botreleasebutton(8);
        return;
    }
    if (getdvarint(#"bot_forcecrouch", 0)) {
        self bottapbutton(9);
        self botreleasebutton(8);
        return;
    }
    if (getdvarint(#"bot_forceprone", 0)) {
        self botreleasebutton(9);
        self bottapbutton(8);
        return;
    }
    if (getdvarint(#"hash_3049c8687f66a426", 0)) {
        self botreleasebutton(9);
        self botreleasebutton(8);
        if (self isonground() && !self jumpbuttonpressed()) {
            self bottapbutton(10);
        }
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8086e49, Offset: 0xb30
// Size: 0xb0
function remove_bots(team) {
    bots = function_b16926ea(team);
    foreach (bot in bots) {
        remove_bot(bot);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x59a12992, Offset: 0xbe8
// Size: 0x54
function remove_random_bot() {
    bots = function_b16926ea();
    bot = bots[randomint(bots.size)];
    remove_bot(bot);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xdf86e089, Offset: 0xc48
// Size: 0x6c
function remove_bot(bot) {
    if (!isbot(bot) || isautocontrolledplayer(bot)) {
        return;
    }
    level notify(#"remove_bot");
    bot botdropclient();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x5759e22f, Offset: 0xcc0
// Size: 0x4c
function private function_abe38e0f() {
    if (!isbot(self)) {
        return;
    }
    self thread fixed_spawn_override();
    waitframe(1);
    self bottakemanualcontrol();
}

// Namespace bot/bot
// Params 1, eflags: 0x4
// Checksum 0x1cb0c911, Offset: 0xd18
// Size: 0x3c
function private function_96dddf6f(*params) {
    if (!isbot(self)) {
        return;
    }
    self thread respawn();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x73d83fae, Offset: 0xd60
// Size: 0xc6
function private on_player_connect() {
    if (!isbot(self)) {
        return;
    }
    self endon(#"disconnect");
    if (!self initialized()) {
        self init_bot();
        self bot_difficulty::assign();
    }
    if (isdefined(self.var_29b433bd) && player_role::is_valid(self.var_29b433bd)) {
        player_role::set(self.var_29b433bd);
        self.var_29b433bd = undefined;
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xc588cc5c, Offset: 0xe30
// Size: 0xb4
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self.var_2925fedc = undefined;
    self setgoal(self.origin);
    self thread function_b781f1e5();
    self thread fixed_spawn_override();
    if (is_true(self.bot.var_261b9ab3)) {
        waitframe(1);
        self bottakemanualcontrol();
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x4
// Checksum 0x54f84435, Offset: 0xef0
// Size: 0x6e
function private on_player_damage(*params) {
    if (!isbot(self)) {
        return;
    }
    if (function_ffa5b184(self.enemy)) {
        self clearentitytarget();
        self.bot.var_2a98e9ea = 0;
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x4
// Checksum 0xcec1e474, Offset: 0xf68
// Size: 0x3c
function private on_player_killed(*params) {
    if (!isbot(self)) {
        return;
    }
    self thread respawn();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xc5f8912d, Offset: 0xfb0
// Size: 0xf8
function private respawn() {
    level endon(#"game_ended");
    self endon(#"disconnect", #"spawned");
    self waittilltimeout(3, #"death_delay_finished");
    wait 0.1;
    if (is_true(getgametypesetting(#"hash_2b1f40bc711c41f3"))) {
        self thread squad_spawn(0.1);
        return;
    }
    while (true) {
        self bottapbutton(3);
        wait 0.1;
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x4
// Checksum 0xd6e08ed5, Offset: 0x10b0
// Size: 0x1f2
function private squad_spawn(respawninterval) {
    level endon(#"game_ended");
    self endon(#"death", #"disconnect", #"spawned");
    while (!isdefined(self.spawn.var_e8f87696) || self.spawn.var_e8f87696 <= 0) {
        wait respawninterval;
    }
    aliveplayers = function_a1cff525(self.squad);
    var_f2cc505e = [];
    foreach (player in aliveplayers) {
        if (!isdefined(player.var_83de62a2) || player.var_83de62a2 != 0) {
            continue;
        }
        var_f2cc505e[var_f2cc505e.size] = player;
    }
    if (var_f2cc505e.size > 0) {
        targetplayer = var_f2cc505e[randomint(var_f2cc505e.size)];
        self.spawn.var_e8f87696 = 0;
        self.spawn.response = "spawnOnPlayer";
        self.var_d690fc0b = targetplayer;
        return;
    }
    self.spawn.var_e8f87696 = 0;
    self.spawn.response = "autoSpawn";
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xae8a533d, Offset: 0x12b0
// Size: 0x6c
function private function_7291a729() {
    self setgoal(self.origin);
    self init_bot();
    self bot_difficulty::assign();
    self thread function_b781f1e5();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x997338b3, Offset: 0x1328
// Size: 0x1e
function private function_99a2ecf5() {
    self notify(#"hash_6280ac8ed281ce3c");
    self.bot = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xd2cda439, Offset: 0x1350
// Size: 0x84
function private function_8481733a() {
    if (!isdefined(self.bot.difficulty) || is_true(self.bot.difficulty.var_ea800f8)) {
        self function_3ca49c4e(0.8);
        return;
    }
    self function_3ca49c4e(0.1);
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xefe70d90, Offset: 0x13e0
// Size: 0x2d0
function private function_b781f1e5() {
    self endon(#"death", #"hash_6280ac8ed281ce3c");
    level endon(#"game_ended");
    self.bot.lastenemy = undefined;
    self.bot.flashed = 0;
    self.bot.var_9d03fb75 = undefined;
    self.bot.var_fad934a1 = undefined;
    self function_1de7f01();
    self thread function_ef59c9e();
    while (game.state != #"playing") {
        waitframe(1);
    }
    while (true) {
        pixbeginevent(#"");
        /#
            self function_ef4e01f();
            self function_cf9ffac7();
            self function_f76a8ac4();
        #/
        self function_a9fd7b4b();
        self function_4fb21bb4();
        self function_7d5bb412();
        self function_47281162();
        self function_ca477c1f();
        self function_1f098eb();
        self.bot.tpoint = getclosesttacpoint(self.origin);
        self function_66749735();
        self bot_orders::think();
        self namespace_87549638::think();
        self bot_action::think();
        self bot_stance::think();
        self bot_position::think();
        self namespace_94e44221::update();
        self.bot.lastenemy = self.enemy;
        self check_stuck();
        self function_e4055765();
        profilestop();
        waitframe(1);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x4af9d5aa, Offset: 0x16b8
// Size: 0x5a
function private function_a9fd7b4b() {
    if (self getplayerresistance(1) > 0) {
        return;
    }
    self.bot.flashed = isdefined(self.flashendtime) && self.flashendtime + 1500 > gettime();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xb592c973, Offset: 0x1720
// Size: 0x426
function private function_4fb21bb4() {
    pixbeginevent(#"");
    if (self.combatstate == #"combat_state_idle" || !isdefined(self.enemy) || !isalive(self.enemy) || self.bot.flashed || self function_ce3dfcfc(self.enemy)) {
        self.bot.enemyvisible = 0;
        self.bot.var_e8c84f98 = 0;
    } else if (isplayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
        vehicle = self.enemy getvehicleoccupied();
        visible = self cansee(vehicle, 250);
        self.bot.enemyvisible = visible;
        self.bot.var_e8c84f98 = visible;
    } else if (self cansee(self.enemy, 250)) {
        self.bot.enemyvisible = 1;
        self.bot.var_e8c84f98 = 1;
    } else if (isdefined(self.enemylastseentime)) {
        self.bot.enemyvisible = 0;
        self.bot.var_e8c84f98 = self.enemylastseentime + 4500 >= gettime();
    } else {
        self.bot.enemyvisible = 0;
        self.bot.var_e8c84f98 = 0;
    }
    if (!self.bot.var_e8c84f98 || self.bot.enemyvisible || !isdefined(self.enemylastseenpos)) {
        self.bot.var_a0b6205e = undefined;
    } else if (self.bot.var_e8c84f98) {
        if (!isdefined(self.bot.var_a0b6205e) || isdefined(self.enemy) && self.bot.lastenemy !== self.enemy) {
            var_32bdb70 = self.origin - self.enemylastseenpos;
            normal = vectornormalize((var_32bdb70[0], var_32bdb70[1], 0));
            self.bot.var_a0b6205e = normal;
        }
    }
    /#
        if (self should_record(#"hash_44dd65804e74042e") && isdefined(self.bot.var_a0b6205e)) {
            function_af72dbc5(self.enemylastseenpos, (0, -96, -64), (0, 96, 64), vectortoangles(self.bot.var_a0b6205e)[1], (1, 1, 0), "<dev string:x3d>", self);
            recordcircle(self.enemylastseenpos + (0, 0, -64), 96, (1, 1, 0), "<dev string:x3d>", self);
        }
    #/
    profilestop();
}

// Namespace bot/bot
// Params 1, eflags: 0x4
// Checksum 0x26ddb99e, Offset: 0x1b50
// Size: 0x1e0
function private function_ce3dfcfc(enemy) {
    if (!isdefined(enemy.targetname)) {
        return false;
    }
    if (enemy.targetname != "uav" && enemy.targetname != "counteruav" && enemy.targetname != "recon_plane" && enemy.targetname != "chopper_gunner" && enemy.targetname != "ac130" && enemy.targetname != "hoverjet") {
        return false;
    }
    if (is_true(enemy.leaving)) {
        return true;
    }
    if (isdefined(enemy.incoming_missile) && enemy.incoming_missile > 1) {
        return true;
    }
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        if (weapon.lockontype == #"legacy single" && self getammocount(weapon) > 0) {
            return false;
        }
    }
    return true;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x220a2755, Offset: 0x1d38
// Size: 0xb2
function private function_7d5bb412() {
    if (self.bot.enemyvisible) {
        self.bot.enemydist = distance(self.origin, self.enemy.origin);
        return;
    }
    if (self.bot.var_e8c84f98) {
        self.bot.enemydist = distance(self.origin, self.enemylastseenpos);
        return;
    }
    self.bot.enemydist = 1000;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xede7d5dd, Offset: 0x1df8
// Size: 0x9e
function private function_47281162() {
    if (!isdefined(self.enemy)) {
        self.bot.var_e9ff4b76 = 0;
        return;
    }
    dir = self.enemy.origin - self.origin;
    var_dae7049a = anglestoforward(self.enemy.angles);
    self.bot.var_e9ff4b76 = vectordot(var_dae7049a, dir) > 0;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x12374c14, Offset: 0x1ea0
// Size: 0x7a
function private function_ca477c1f() {
    if (!isdefined(self.enemy)) {
        self.bot.var_faa25d47 = 0;
        return;
    }
    self.bot.var_faa25d47 = self attackedrecently(self.enemy, 10) || self.enemy attackedrecently(self, 10);
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x73189bf9, Offset: 0x1f28
// Size: 0x56
function private function_1f098eb() {
    if (self.bot.var_e8c84f98) {
        self.bot.var_494658cd = getclosesttacpoint(self.enemy.origin);
        return;
    }
    self.bot.var_494658cd = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x8e8b909e, Offset: 0x1f88
// Size: 0x3c8
function private function_66749735() {
    pixbeginevent(#"");
    if (!isdefined(level.var_934fb97)) {
        profilestop();
        return;
    }
    if (self.bot.var_e8c84f98 || self.bot.flashed || self function_e8e1d88e() > 0) {
        self.bot.var_538135ed = undefined;
        profilestop();
        return;
    }
    if (!(!isdefined(self.bot.var_fad934a1) || self.bot.var_fad934a1 <= gettime()) && (!isdefined(self.bot.var_9d03fb75) || self.bot.var_9d03fb75 <= gettime())) {
        self.bot.var_538135ed = undefined;
        profilestop();
        return;
    }
    var_23d5b7a6 = self.bot.var_538135ed;
    if (isdefined(var_23d5b7a6) && isdefined(var_23d5b7a6.gameobject) && !is_true(var_23d5b7a6.var_8d834202) && distance2dsquared(self.origin, var_23d5b7a6.origin) <= 1000000) {
        if (!isdefined(var_23d5b7a6.gameobject.canuseobject) || var_23d5b7a6.gameobject [[ var_23d5b7a6.gameobject.canuseobject ]](self)) {
            profilestop();
            return;
        }
    }
    tpoint = self.bot.tpoint;
    if (!isdefined(tpoint)) {
        self.bot.var_538135ed = undefined;
        profilestop();
        return;
    }
    pods = [];
    ents = getentitiesinradius(self.origin, 1000, 6);
    weapon = level.var_934fb97.weapon;
    foreach (ent in ents) {
        if (ent.item != weapon || is_true(ent.var_9863caa6) || !isdefined(ent.gameobject) || !ent.gameobject gameobjects::can_interact_with(self)) {
            continue;
        }
        if (isdefined(ent.gameobject.canuseobject) && !ent.gameobject [[ ent.gameobject.canuseobject ]](self)) {
            continue;
        }
        pods[pods.size] = ent;
    }
    if (pods.size <= 0) {
        self.bot.var_538135ed = undefined;
        profilestop();
        return;
    }
    self.bot.var_538135ed = pods[randomint(pods.size)];
    profilestop();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x29d95c6e, Offset: 0x2358
// Size: 0x46
function private function_1de7f01() {
    self.bot.var_4208fe0e = [];
    self.bot.var_fc10153f = 0;
    self.bot.var_ad331541 = undefined;
    self.bot.var_510b1057 = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xbbb2dc7d, Offset: 0x23a8
// Size: 0x788
function private check_stuck() {
    pixbeginevent(#"");
    movedir = self move_dir();
    if (length2dsquared(movedir) <= 0) {
        self function_1de7f01();
        profilestop();
        return;
    }
    var_4208fe0e = self.bot.var_4208fe0e;
    i = self.bot.var_fc10153f;
    var_4208fe0e[i] = self.origin;
    self.bot.var_fc10153f = (i + 1) % 10;
    if (var_4208fe0e.size < 10) {
        profilestop();
        return;
    }
    var_ed68443 = 0;
    foreach (point in var_4208fe0e) {
        distsq = distancesquared(self.origin, point);
        if (distsq > var_ed68443) {
            var_ed68443 = distsq;
        }
    }
    if (var_ed68443 > 15) {
        profilestop();
        return;
    }
    self notify(#"bot_stuck");
    /#
        record3dtext(function_9e72a96(#"stuck"), self.origin, (1, 0, 1), "<dev string:x3d>", undefined, 5);
        function_af72dbc5(self.origin, self getmaxs(), self getmins(), self.angles[1], (1, 0, 1), "<dev string:x3d>");
        function_af72dbc5(self.origin, (64, 64, 0), (64 * -1, 64 * -1, 0), 0, (1, 0, 1), "<dev string:x3d>");
        recordline(self.origin, self.origin + movedir * 128, (1, 0, 1), "<dev string:x3d>");
        foreach (point in var_4208fe0e) {
            recordstar(point, (1, 0, 1), "<dev string:x3d>", self);
        }
    #/
    ents = getentitiesinradius(self.origin, 64);
    ents = arraysortclosest(ents, self.origin);
    foreach (ent in ents) {
        if (ent == self || vectordot(ent.origin - self.origin, movedir) <= 0) {
            continue;
        }
        /#
            function_af72dbc5(ent.origin, ent getmins(), ent getmaxs(), ent.angles[1], (1, 0, 0), "<dev string:x3d>");
            if (isdefined(ent.targetname)) {
                record3dtext(ent.targetname, ent.origin, (1, 0, 0), "<dev string:x3d>");
            }
        #/
        if (isdefined(ent.targetname) && ent.targetname == #"smart_cover") {
            self.bot.var_ad331541 = ent;
            break;
        }
        if (isdefined(ent.script_noteworthy) && ent.script_noteworthy == #"care_package" && ent isusable()) {
            self.bot.var_510b1057 = ent;
            break;
        }
    }
    if (isdefined(self.bot.var_510b1057) || isdefined(self.bot.var_ad331541)) {
        profilestop();
        return;
    }
    eye = self.origin + (0, 0, self getplayerviewheight());
    if (!isdefined(self.bot.var_8e60176d)) {
        self.bot.var_8e60176d = 0;
    }
    var_c40ef0b0 = anglestoforward(self getplayerangles() + (0, self.bot.var_8e60176d, 0));
    self.bot.var_8e60176d = (self.bot.var_8e60176d + 36) % 360;
    end = eye + var_c40ef0b0 * 20;
    trace = bullettrace(eye, end, 0, self);
    surfacetype = trace[#"surfacetype"];
    if (isdefined(surfacetype) && surfacetype == #"glass" && !isdefined(trace[#"entity"])) {
        self notify(#"glass", {#position:trace[#"position"]});
    }
    profilestop();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0xb2d82e7d, Offset: 0x2b38
// Size: 0xaa
function private function_ef59c9e() {
    self endon(#"death", #"hash_6280ac8ed281ce3c");
    self.bot.glasstouch = undefined;
    while (true) {
        result = self waittill(#"glass");
        self.bot.glasstouch = result.position;
        wait 0.2;
        self.bot.glasstouch = undefined;
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xc9e18cf5, Offset: 0x2bf0
// Size: 0x122
function init_bot() {
    self.bot = {};
    self.bot.var_458ddbc0 = [];
    self.maxsightdistsqrd = 0 * 0;
    self.highlyawareradius = 96;
    self.fovcosine = fov_angle_to_cosine(179);
    self.fovcosinebusy = fov_angle_to_cosine(110);
    self botsetlooksensitivity(1, 1);
    self function_4f0b9564(7.5, 15);
    self function_3ca49c4e(1);
    self.goalradius = 512;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x35f173a4, Offset: 0x2d20
// Size: 0xc
function initialized() {
    return isdefined(self.bot);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xaa6173d7, Offset: 0x2d38
// Size: 0x42
function fov_angle_to_cosine(fovangle = 0) {
    if (fovangle >= 180) {
        return 0;
    }
    return cos(fovangle / 2);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x5ec7b6fb, Offset: 0x2d88
// Size: 0x82
function move_dir() {
    move = self getnormalizedmovement();
    fwd = anglestoforward(self.angles);
    right = anglestoright(self.angles);
    return fwd * move[0] + right * move[1];
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x5693ca69, Offset: 0x2e18
// Size: 0x112
function function_f0c35734(trigger) {
    assert(isbot(self));
    assert(isdefined(trigger));
    radius = self getpathfindingradius();
    height = self function_6a9ae71();
    heightoffset = (0, 0, height * -1 / 2);
    var_e790dc87 = (radius, radius, height / 2);
    obb = ai::function_470c0597(trigger.origin + heightoffset, trigger.maxs + var_e790dc87, trigger.angles);
    return obb;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x1b4e7ff6, Offset: 0x2f38
// Size: 0x142
function function_52947b70(trigger) {
    assert(isbot(self));
    assert(isstruct(trigger));
    radius = self getpathfindingradius();
    height = self function_6a9ae71();
    heightoffset = (0, 0, height * -1 / 2);
    var_e790dc87 = (radius, radius, height / 2);
    maxs = (trigger.script_width, trigger.script_length, trigger.script_height);
    obb = ai::function_470c0597(trigger.origin + heightoffset, maxs + var_e790dc87, trigger.angles);
    return obb;
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x25b6d66, Offset: 0x3088
// Size: 0xb0
function add_fixed_spawn_bot(team, origin, yaw, roleindex = undefined) {
    bot = add_bot(team);
    if (isdefined(bot)) {
        if (isdefined(roleindex) && roleindex >= 0) {
            bot.var_29b433bd = int(roleindex);
        }
        bot.ignoreall = 1;
        bot function_bab12815(origin, yaw);
    }
    return bot;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x52eaa0b6, Offset: 0x3140
// Size: 0x6c
function function_bab12815(origin, yaw) {
    if (!isstruct(self.bot)) {
        return;
    }
    self.pers[#"hash_63201776738fc052"] = origin;
    self.pers[#"hash_777e40938cf10f50"] = (0, yaw, 0);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x37e32415, Offset: 0x31b8
// Size: 0x3a
function function_39d30bb6(forcegoal) {
    if (!isstruct(self.bot)) {
        return;
    }
    self.bot.var_7280cc1b = forcegoal;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xef3c9855, Offset: 0x3200
// Size: 0x66
function function_bcc79b86(vehicle, seatindex = undefined) {
    if (!isstruct(self.bot)) {
        return;
    }
    self.bot.var_22989bf = vehicle;
    self.bot.var_a3d475e5 = seatindex;
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x9a2a5d39, Offset: 0x3270
// Size: 0x15c
function private fixed_spawn_override() {
    self endon(#"death", #"disconnect", #"hash_6280ac8ed281ce3c");
    waittillframeend();
    if (!isstruct(self.bot)) {
        return;
    }
    origin = self.pers[#"hash_63201776738fc052"];
    angles = self.pers[#"hash_777e40938cf10f50"];
    forcegoal = isdefined(self.bot.var_7280cc1b) ? self.bot.var_7280cc1b : 1;
    if (isdefined(origin)) {
        self.ignoreall = 1;
        self dontinterpolate();
        self setorigin(origin);
        if (isdefined(angles)) {
            self setplayerangles(angles);
        }
        self setgoal(origin, forcegoal);
    }
    self function_50c012c9();
}

// Namespace bot/bot
// Params 0, eflags: 0x4
// Checksum 0x99976c47, Offset: 0x33d8
// Size: 0x170
function private function_50c012c9() {
    if (!isstruct(self.bot)) {
        return;
    }
    vehicle = self.bot.var_22989bf;
    seatindex = self.bot.var_a3d475e5;
    if (!isvehicle(vehicle)) {
        return;
    }
    if (isint(seatindex) && !vehicle isvehicleseatoccupied(seatindex)) {
        vehicle usevehicle(self, seatindex);
        return;
    }
    for (i = 0; i < 11; i++) {
        if (vehicle function_dcef0ba1(i)) {
            var_3693c73b = vehicle function_defc91b2(i);
            if (isdefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i)) {
                vehicle usevehicle(self, i);
                break;
            }
        }
    }
}

/#

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x453cd15a, Offset: 0x3550
    // Size: 0xba
    function should_record(dvarstr) {
        if (getdvarint(#"recorder_enablerec", 0) < 1 || getdvarint(dvarstr, 0) <= 0) {
            return 0;
        }
        botnum = getdvarint(#"hash_457b3d0b71e0fd8a", 0);
        if (botnum < 0) {
            return 1;
        }
        return self getentitynumber() == botnum;
    }

    // Namespace bot/bot
    // Params 3, eflags: 0x0
    // Checksum 0xf0878645, Offset: 0x3618
    // Size: 0x64
    function record_text(text, textcolor, dvarstr) {
        if (self should_record(dvarstr)) {
            record3dtext(text, self.origin, textcolor, "<dev string:x3d>", self, 0.5);
        }
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x4
    // Checksum 0x3127455, Offset: 0x3688
    // Size: 0xdc
    function private function_ef4e01f() {
        if (!self should_record(#"hash_1919da6e381816f7")) {
            return;
        }
        if (!isdefined(self.bot.difficulty)) {
            record3dtext(function_9e72a96(#"hash_34d3ed856dad1a43"), self.origin, (1, 1, 1), "<dev string:x3d>", self, 0.5);
            return;
        }
        record3dtext(self.bot.difficulty.name, self.origin, (1, 1, 1), "<dev string:x3d>", self, 0.5);
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x4
    // Checksum 0xd516a458, Offset: 0x3770
    // Size: 0xc4
    function private function_cf9ffac7() {
        if (!self should_record(#"hash_44dd65804e74042e") && !self should_record(#"hash_15e4429f6d6deb52")) {
            return;
        }
        color = function_5d55f3c9(self.combatstate);
        record3dtext(function_9e72a96(self.combatstate), self.origin, color, "<dev string:x3d>", self, 0.5);
    }

    // Namespace bot/bot
    // Params 1, eflags: 0x4
    // Checksum 0x6d9311a4, Offset: 0x3840
    // Size: 0x90
    function private function_5d55f3c9(combatstate) {
        switch (combatstate) {
        case #"combat_state_in_combat":
            return (1, 0, 0);
        case #"combat_state_has_visible_enemy":
            return (1, 0.5, 0);
        case #"combat_state_aware_of_enemies":
            return (1, 1, 0);
        case #"combat_state_idle":
            return (0, 1, 0);
        }
        return (1, 1, 1);
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x4
    // Checksum 0x80b8b3d2, Offset: 0x38d8
    // Size: 0xdc
    function private function_f76a8ac4() {
        if (!self should_record(#"bot_recordgoal") || !isdefined(self get_revive_target())) {
            return;
        }
        target = self get_revive_target().origin;
        recordline(self.origin, target, (0, 1, 1), "<dev string:x3d>", self);
        recordcircle(target, 32, (0, 1, 1), "<dev string:x3d>", self);
    }

    // Namespace bot/bot
    // Params 3, eflags: 0x20 variadic
    // Checksum 0x8bcf4073, Offset: 0x39c0
    // Size: 0xdc
    function map_color(val, maxval, ...) {
        if (val <= 0) {
            return vararg[0];
        } else if (val >= maxval) {
            return vararg[vararg.size - 1];
        }
        var_c0dabf48 = val * vararg.size / maxval;
        var_c0dabf48 -= 1;
        colorindex = int(var_c0dabf48);
        colorfrac = var_c0dabf48 - colorindex;
        return vectorlerp(vararg[colorindex], vararg[colorindex + 1], colorfrac);
    }

#/

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xe24f2bb4, Offset: 0x3aa8
// Size: 0x32
function function_e5d7f472() {
    return isdefined(self.bot.revivetarget) && isdefined(self.bot.revivetarget.revivetrigger);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x42ec5402, Offset: 0x3ae8
// Size: 0x12
function get_revive_target() {
    return self.bot.revivetarget;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xe9855db8, Offset: 0x3b08
// Size: 0x32
function function_85bfe6d3() {
    if (isdefined(self.bot.revivetarget)) {
        return self.bot.revivetarget.revivetrigger;
    }
    return undefined;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xee3c6ed7, Offset: 0x3b48
// Size: 0x1e
function set_revive_target(target) {
    self.bot.revivetarget = target;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x7e522713, Offset: 0x3b70
// Size: 0x12
function clear_revive_target() {
    self.bot.revivetarget = undefined;
}

