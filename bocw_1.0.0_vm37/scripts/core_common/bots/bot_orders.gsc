#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;

#namespace bot_orders;

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x0
// Checksum 0x6862b466, Offset: 0xc8
// Size: 0x2b4
function preinit() {
    level.var_156a37c8 = [];
    foreach (team in level.teams) {
        level.var_156a37c8[team] = [];
    }
    level.var_d3b9615b = function_b6e6a59b();
    level.var_4b98dc10 = [];
    level register_state(#"assault", &function_2fe359ab, &assault_start, &function_6a672c6d);
    level register_state(#"capture", &function_bcd00fa7, &capture_start, &function_423ecbc1);
    level register_state(#"chase_enemy", &function_7c479af0, &function_6790cfd3, &function_63b3aa81);
    level register_state(#"defend", &function_1ba5e803, &defend_start, &function_72084729);
    level register_state(#"patrol", &function_82c1a3e9, &patrol_start, &patrol_think);
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_6280ac8ed281ce3c", &function_99a2ecf5);
    /#
        level thread debug_intel();
    #/
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x62c12ec4, Offset: 0x388
// Size: 0x3c
function private on_player_killed(*params) {
    if (!isbot(self)) {
        return;
    }
    self clear();
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x7246e434, Offset: 0x3d0
// Size: 0x30
function private function_99a2ecf5() {
    if (isdefined(self.bot.intel)) {
        self.bot.intel.count--;
    }
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x0
// Checksum 0x195fcdcd, Offset: 0x408
// Size: 0x22e
function think() {
    pixbeginevent(#"");
    info = self function_4794d6a3();
    if (info.goalforced || self.ignoreall) {
        self clear();
        profilestop();
        return;
    }
    bot = self.bot;
    if (isdefined(bot.intel) && !bot.intel.active) {
        self clear();
    }
    if (!isdefined(bot.intel)) {
        intel = self function_9ef822a8();
        if (isdefined(intel)) {
            self function_5f1591fa(intel);
        }
    }
    if (isdefined(bot.order)) {
        state = level.var_4b98dc10[bot.order];
        if (bot.order != bot.intel.var_a1980fcb && self [[ state.ready ]](bot.intel) && self function_4b2723cf(bot.intel.var_a1980fcb, bot.intel)) {
            state = level.var_4b98dc10[bot.order];
        }
        self [[ state.think ]](bot.intel);
    }
    /#
        if (self bot::should_record(#"hash_bb5c278818b000b")) {
            self function_26b3a2f();
            self function_d966fb1c();
        }
    #/
    profilestop();
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x1feaa20f, Offset: 0x640
// Size: 0x1a2
function private function_9ef822a8() {
    var_6deb0f13 = level.var_156a37c8[self.team];
    if (var_6deb0f13.size <= 0) {
        return 0;
    }
    totalweight = 0;
    weights = [];
    foreach (intel in var_6deb0f13) {
        weight = 1;
        if (isdefined(intel.weight)) {
            weight = self [[ intel.weight ]](intel);
        }
        totalweight += weight;
        weights[weights.size] = totalweight;
    }
    var_e8351662 = randomfloat(totalweight);
    intel = undefined;
    foreach (i, weight in weights) {
        if (var_e8351662 < weight) {
            return var_6deb0f13[i];
        }
    }
    return undefined;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x4401b407, Offset: 0x7f0
// Size: 0x80
function private function_5f1591fa(intel) {
    if (!self function_4b2723cf(intel.var_a1980fcb, intel) && !self function_4b2723cf(intel.var_5e99151a, intel)) {
        return false;
    }
    self.bot.intel = intel;
    intel.count++;
    return true;
}

// Namespace bot_orders/bot_orders
// Params 2, eflags: 0x4
// Checksum 0xb15ee9ed, Offset: 0x878
// Size: 0x96
function private function_4b2723cf(order, intel) {
    if (!isdefined(order)) {
        return false;
    }
    state = level.var_4b98dc10[order];
    if (!isdefined(state)) {
        return false;
    }
    if (!self [[ state.ready ]](intel) || !self [[ state.start ]](intel)) {
        return false;
    }
    self.bot.order = order;
    return true;
}

// Namespace bot_orders/bot_orders
// Params 4, eflags: 0x4
// Checksum 0xae99f24f, Offset: 0x918
// Size: 0x88
function private register_state(order, var_47dfc5f2, var_20ef4046, var_7b441679) {
    state = {#order:order, #ready:var_47dfc5f2, #start:var_20ef4046, #think:var_7b441679};
    level.var_4b98dc10[order] = state;
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x7f9b5ca8, Offset: 0x9a8
// Size: 0xa4
function private clear() {
    if (isdefined(self.bot.intel)) {
        self.bot.intel.count--;
    }
    self.bot.intel = undefined;
    self.bot.order = undefined;
    self.bot.defendtime = undefined;
    self.bot.var_6b695775 = undefined;
    self.bot.var_3d1abfb9 = undefined;
    self.bot.var_941ba251 = undefined;
    self function_9392d2c9();
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xa6ee65cb, Offset: 0xa58
// Size: 0x38
function private function_82c1a3e9(*intel) {
    players = function_f6f34851(self.team);
    return players.size > 0;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xb246582d, Offset: 0xa98
// Size: 0x88
function private patrol_start(*intel) {
    id = self function_e559e4d5();
    if (!isdefined(id)) {
        return false;
    }
    route = self function_89751246(id);
    if (route.size <= 0) {
        return false;
    }
    self function_fd78dbc(route);
    return true;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xcdee2467, Offset: 0xb28
// Size: 0x54
function private patrol_think(*intel) {
    self function_db3a19e8();
    if (!self function_28557cd1()) {
        self clear();
    }
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0xb382dcf2, Offset: 0xb88
// Size: 0x1be
function private function_e559e4d5() {
    players = function_f6f34851(self.team);
    if (players.size <= 0) {
        return undefined;
    }
    player = players[randomint(players.size)];
    tpoint = getclosesttacpoint(player.origin);
    if (!isdefined(tpoint)) {
        return undefined;
    }
    ids = [];
    info = function_b507a336(tpoint.region);
    if (info.tacpoints.size >= 10) {
        ids[ids.size] = info.id;
    }
    foreach (id in info.neighbors) {
        info = function_b507a336(id);
        if (info.tacpoints.size < 10) {
            continue;
        }
        ids[ids.size] = id;
    }
    if (ids.size <= 0) {
        return undefined;
    }
    return ids[randomint(ids.size)];
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x4a8de499, Offset: 0xd50
// Size: 0x1a
function private function_7c479af0(*intel) {
    return self.bot.var_e8c84f98;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x2a4a3e31, Offset: 0xd78
// Size: 0x88
function private function_6790cfd3(*intel) {
    bot = self.bot;
    if (!isdefined(bot.var_494658cd)) {
        return false;
    }
    route = self function_89751246(bot.var_494658cd.region);
    if (route.size <= 0) {
        return false;
    }
    self function_fd78dbc(route);
    return true;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xd4da1888, Offset: 0xe08
// Size: 0x1b4
function private function_63b3aa81(*intel) {
    self function_db3a19e8();
    if (!self.bot.var_e8c84f98 && !self function_28557cd1()) {
        info = self function_4794d6a3();
        if (is_true(info.var_9e404264)) {
            self clear();
            return;
        }
    }
    bot = self.bot;
    if (self.bot.enemyvisible && isdefined(bot.var_494658cd) && isdefined(bot.tpoint) && bot.var_494658cd.region != bot.tpoint.region) {
        if (!self function_28557cd1() || bot.var_494658cd.region != self function_f25530e3()) {
            route = self function_89751246(bot.var_494658cd.region);
            if (route.size > 0) {
                self function_fd78dbc(route);
            }
        }
    }
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x7138b966, Offset: 0xfc8
// Size: 0x22
function private function_bcd00fa7(intel) {
    return self function_eba6d29d(intel);
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xd44d96f1, Offset: 0xff8
// Size: 0x60
function private capture_start(intel) {
    self function_9392d2c9();
    trigger = intel.object.trigger;
    self setgoal(trigger);
    return true;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xce8c0383, Offset: 0x1060
// Size: 0x44
function private function_423ecbc1(intel) {
    trigger = intel.object.trigger;
    self update_threat(intel);
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x3d1f6b9c, Offset: 0x10b0
// Size: 0x22
function private function_1ba5e803(intel) {
    return self function_eba6d29d(intel);
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x0
// Checksum 0xae66db68, Offset: 0x10e0
// Size: 0x28
function defend_start(*intel) {
    self function_9392d2c9();
    return true;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x904d14d, Offset: 0x1110
// Size: 0x3c4
function private function_72084729(intel) {
    if (!isdefined(self.bot.defendtime)) {
        self.bot.defendtime = gettime() + int(randomintrange(20, 60) * 1000);
    } else if (!isdefined(self.bot.defendtime) || self.bot.defendtime <= gettime()) {
        if (self.bot.var_e8c84f98 || is_true(intel.contested) || is_true(intel.losing)) {
            self.bot.defendtime = gettime() + int(randomintrange(20, 60) * 1000);
        } else {
            self clear();
            return;
        }
    }
    info = self function_4794d6a3();
    if (is_true(intel.contested) || is_true(intel.losing)) {
        trigger = intel.object.trigger;
        if (!isdefined(info.goalvolume) || info.goalvolume != trigger) {
            self setgoal(trigger);
            self.bot.var_6b695775 = undefined;
        }
    } else if (!isdefined(self.bot.var_6b695775) && isdefined(info.regionid) && isdefined(self.bot.tpoint) && info.regionid == self.bot.tpoint.region) {
        self.bot.var_6b695775 = gettime() + int(randomfloatrange(5, 10) * 1000);
    } else if ((!isdefined(self.bot.var_6b695775) || self.bot.var_6b695775 <= gettime()) && is_true(info.var_9e404264) && !self.bot.var_e8c84f98) {
        id = intel.var_dd2331cb[randomint(intel.var_dd2331cb.size)];
        if (isdefined(id)) {
            self setgoal(id);
            self.bot.var_6b695775 = undefined;
        }
    }
    self update_threat(intel);
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xbffec400, Offset: 0x14e0
// Size: 0x1c
function private function_2fe359ab(intel) {
    return intel.var_dd2331cb.size > 0;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x11be31da, Offset: 0x1508
// Size: 0x88
function private assault_start(intel) {
    id = intel.var_dd2331cb[randomint(intel.var_dd2331cb.size)];
    route = self function_89751246(id);
    if (route.size <= 0) {
        return false;
    }
    self function_fd78dbc(route);
    return true;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x133a2af5, Offset: 0x1598
// Size: 0x94
function private function_6a672c6d(intel) {
    self function_db3a19e8();
    if (self function_28557cd1() && !self function_eba6d29d(intel)) {
        return;
    }
    if (!self function_4b2723cf(intel.order, intel)) {
        self clear();
    }
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xd398d0a5, Offset: 0x1638
// Size: 0xbc
function private function_eba6d29d(intel) {
    tpoint = self.bot.tpoint;
    if (!isdefined(tpoint)) {
        return false;
    }
    foreach (id in intel.var_dd2331cb) {
        if (tpoint.region == id) {
            return true;
        }
    }
    return false;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xac54adf6, Offset: 0x1700
// Size: 0x104
function private function_89751246(regionid) {
    pixbeginevent(#"");
    var_66e7b0ba = self.bot.tpoint;
    if (!isdefined(var_66e7b0ba) || var_66e7b0ba.region == regionid) {
        profilestop();
        return array(regionid);
    }
    var_d3547bb1 = function_b507a336(regionid);
    var_cdea01dc = randomfloatrange(-1, 1);
    self function_ca06456b(self.origin, var_d3547bb1.origin, level.var_d3b9615b, var_cdea01dc);
    profilestop();
    return function_afd64b51(var_66e7b0ba.region, regionid);
}

// Namespace bot_orders/bot_orders
// Params 4, eflags: 0x4
// Checksum 0xd2dc3e9, Offset: 0x1810
// Size: 0x3fe
function private function_ca06456b(start, end, bounds, var_cdea01dc) {
    pixbeginevent(#"");
    directdir = end - start;
    var_8c171e74 = length(directdir);
    var_43bc5205 = vectortoangles(directdir);
    var_d62fe1dc = anglestoforward(var_43bc5205);
    var_cb764353 = anglestoright(var_43bc5205);
    if (var_cdea01dc < 0) {
        var_cb764353 = (0, 0, 0) - var_cb764353;
        var_cdea01dc = abs(var_cdea01dc);
    }
    var_c7a2a5bd = var_cb764353 * var_8c171e74 * 0.75;
    clipstart = function_24531a26(start, start + var_c7a2a5bd, bounds.absmins, bounds.absmaxs);
    var_6d229307 = vectorlerp(start, clipstart.end, var_cdea01dc);
    var_c7a484a2 = distance(start, var_6d229307);
    clipend = function_24531a26(end, end + var_c7a2a5bd, bounds.absmins, bounds.absmaxs);
    var_57a5b0 = vectorlerp(end, clipend.end, var_cdea01dc);
    var_315d734c = distance(end, var_57a5b0);
    var_acfd9e68 = var_c7a484a2 > 500;
    var_16eedbee = var_315d734c > 500;
    var_22405e9b = var_57a5b0 - var_6d229307;
    var_ccb07583 = length(var_22405e9b);
    var_f8c9ffb2 = vectortoangles(var_22405e9b);
    var_beaef07d = anglestoforward(var_f8c9ffb2);
    var_75128d22 = anglestoright(var_f8c9ffb2);
    /#
        shouldrecord = self bot::should_record(#"hash_bb5c278818b000b");
        if (shouldrecord) {
            recordline(start, var_6d229307, (1, 0, 1), "<dev string:x38>", self);
            recordline(var_6d229307, var_57a5b0, (1, 0, 1), "<dev string:x38>", self);
            recordline(var_57a5b0, end, (1, 0, 1), "<dev string:x38>", self);
        }
    #/
    points = array(start, var_6d229307, var_57a5b0, end);
    function_c36796ff(10, 0.2, 500, points, 10, 20);
    profilestop();
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0xbb3f0d5e, Offset: 0x1c18
// Size: 0x2e
function private function_fd78dbc(route) {
    self.bot.route = route;
    self.bot.var_e923c16d = 0;
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x2513e6b1, Offset: 0x1c50
// Size: 0x22
function private function_9392d2c9() {
    self.bot.route = undefined;
    self.bot.var_e923c16d = undefined;
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0xc5cd9ca8, Offset: 0x1c80
// Size: 0x14
function private function_28557cd1() {
    return isdefined(self.bot.route);
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x1ca90609, Offset: 0x1ca0
// Size: 0x3a
function private function_f25530e3() {
    route = self.bot.route;
    if (!isdefined(route)) {
        return undefined;
    }
    return route[route.size - 1];
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x2e31f0c3, Offset: 0x1ce8
// Size: 0x1b6
function private function_db3a19e8() {
    pixbeginevent(#"");
    if (self isplayinganimscripted() || self arecontrolsfrozen() || self function_5972c3cf() || self isinvehicle()) {
        profilestop();
        return;
    }
    bot = self.bot;
    if (!isarray(bot.route)) {
        profilestop();
        return;
    }
    id = bot.route[bot.var_e923c16d];
    info = self function_4794d6a3();
    if (!isdefined(info.regionid) || info.regionid != id) {
        self setgoal(id);
    } else if (isdefined(bot.tpoint) && bot.tpoint.region == id) {
        bot.var_e923c16d++;
        if (bot.var_e923c16d < bot.route.size) {
            self setgoal(bot.route[bot.var_e923c16d]);
        } else {
            self function_9392d2c9();
        }
    }
    profilestop();
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x4
// Checksum 0x4e2e30f8, Offset: 0x1ea8
// Size: 0x5e
function private function_b6e6a59b() {
    bounds = function_5ac49687();
    if (isdefined(bounds)) {
        bounds.var_f521d351 = (bounds.maxs[0], bounds.maxs[1], bounds.mins[2]);
    }
    return bounds;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x69e1a775, Offset: 0x1f10
// Size: 0x21c
function private update_threat(intel) {
    if (self.bot.var_e8c84f98) {
        self.bot.var_3d1abfb9 = undefined;
        return;
    }
    if (!(!isdefined(self.bot.var_3d1abfb9) || self.bot.var_3d1abfb9 <= gettime()) && self.bot.var_9931c7dc) {
        return;
    }
    pixbeginevent("update_threat");
    if (is_true(intel.losing) || is_true(intel.contested)) {
        point = self function_f217ace2(intel.object.trigger);
        if (isdefined(point)) {
            self.bot.var_941ba251 = point;
            self.bot.var_3d1abfb9 = gettime() + int(randomfloatrange(1.5, 3) * 1000);
        }
    } else {
        point = self function_146c03bd(intel.neighborids);
        if (isdefined(point)) {
            self.bot.var_941ba251 = point;
            self.bot.var_3d1abfb9 = gettime() + int(randomfloatrange(2, 5) * 1000);
        }
    }
    pixendevent();
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x1504eed8, Offset: 0x2138
// Size: 0xc2
function private function_146c03bd(var_dd2331cb) {
    if (var_dd2331cb.size <= 0) {
        return undefined;
    }
    id = var_dd2331cb[randomint(var_dd2331cb.size)];
    points = tacticalquery(#"hash_74b4463994f96eae", id, self);
    if (points.size <= 0) {
        return undefined;
    }
    return points[randomint(points.size)].origin + (0, 0, 50);
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x715864c4, Offset: 0x2208
// Size: 0x8a
function private function_f217ace2(volume) {
    points = tacticalquery(#"hash_eea3b34d24d4bdd", volume, self);
    if (points.size <= 0) {
        return undefined;
    }
    return points[randomint(points.size)].origin + (0, 0, 50);
}

/#

    // Namespace bot_orders/bot_orders
    // Params 0, eflags: 0x4
    // Checksum 0x239ce409, Offset: 0x22a0
    // Size: 0x5ec
    function private debug_intel() {
        level endon(#"game_ended");
        while (true) {
            waitframe(1);
            if (getdvarint(#"hash_bb5c278818b000b", 0) <= 0) {
                continue;
            }
            function_af72dbc5(level.var_d3b9615b.origin, level.var_d3b9615b.mins, level.var_d3b9615b.var_f521d351, 0, (1, 0, 0), "<dev string:x38>");
            zoffset = 0;
            var_dd2331cb = [];
            neighborids = [];
            foreach (team, var_6deb0f13 in level.var_156a37c8) {
                foreach (intel in var_6deb0f13) {
                    if (!isdefined(intel.object)) {
                        continue;
                    }
                    record3dtext(level.teams[team] + "<dev string:x42>" + intel.count + "<dev string:x48>" + function_9e72a96(intel.var_a1980fcb) + "<dev string:x4f>" + function_9e72a96(intel.var_5e99151a), intel.object.origin + (0, 0, zoffset), (0, 1, 1), "<dev string:x38>");
                    foreach (id in intel.var_dd2331cb) {
                        var_dd2331cb[id] = id;
                    }
                    foreach (id in intel.neighborids) {
                        neighborids[id] = id;
                    }
                }
                zoffset += -10;
            }
            foreach (id in var_dd2331cb) {
                info = function_b507a336(id);
                foreach (point in info.tacpoints) {
                    recordstar(point.origin, (0, 1, 1), "<dev string:x38>");
                }
                record3dtext(id, info.origin, (0, 1, 1), "<dev string:x38>");
            }
            foreach (id in neighborids) {
                info = function_b507a336(id);
                foreach (point in info.tacpoints) {
                    recordstar(point.origin, (0, 0, 1), "<dev string:x38>");
                }
                record3dtext(id, info.origin, (0, 0, 1), "<dev string:x38>");
            }
        }
    }

    // Namespace bot_orders/bot_orders
    // Params 0, eflags: 0x4
    // Checksum 0xd80e2368, Offset: 0x2898
    // Size: 0x154
    function private function_26b3a2f() {
        order = self.bot.order;
        if (!isdefined(order)) {
            record3dtext(function_9e72a96(#"hash_266967e49741306c"), self.origin, (0, 1, 1), "<dev string:x38>", self, 0.5);
        } else {
            record3dtext(function_9e72a96(#"hash_15017f84fb1a2e46") + function_9e72a96(order), self.origin, (0, 1, 1), "<dev string:x38>", self, 0.5);
        }
        intel = self.bot.intel;
        if (isdefined(intel) && isdefined(intel.object)) {
            recordline(self.origin, intel.object.origin, (0, 1, 1), "<dev string:x38>", self);
        }
    }

    // Namespace bot_orders/bot_orders
    // Params 0, eflags: 0x4
    // Checksum 0x10106448, Offset: 0x29f8
    // Size: 0x1be
    function private function_d966fb1c() {
        route = self.bot.route;
        if (!isdefined(route)) {
            return;
        }
        var_e923c16d = self.bot.var_e923c16d;
        lastorigin = undefined;
        foreach (i, id in route) {
            info = function_b507a336(id);
            color = (0, 1, 0);
            if (i > var_e923c16d) {
                color = (0, 1, 1);
            } else if (i < var_e923c16d) {
                color = (0, 0, 1);
            }
            text = id + "<dev string:x55>" + i + "<dev string:x5c>" + info.tacpoints.size;
            record3dtext(text, info.origin, color, "<dev string:x38>", self);
            if (isdefined(lastorigin)) {
                recordline(lastorigin, info.origin, color, "<dev string:x38>", self);
            }
            lastorigin = info.origin;
        }
    }

#/
