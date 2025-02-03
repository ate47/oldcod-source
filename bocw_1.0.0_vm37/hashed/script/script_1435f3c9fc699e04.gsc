#namespace gameobjects;

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0xb55bd8b8, Offset: 0x60
// Size: 0xa2
function function_e553e480() {
    if (!isdefined(self.users)) {
        self.users = [];
    }
    self.var_a0ff5eb8 = 0;
    self.curprogress = 0;
    self.userate = 0;
    self.claimplayer = undefined;
    self.lastclaimtime = 0;
    self.claimgraceperiod = 0;
    self.mustmaintainclaim = 0;
    self.cancontestclaim = 0;
    self function_58901d83();
    self.var_5f35f19a = #"none";
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x173ae4a0, Offset: 0x110
// Size: 0x92
function function_818d69ee(user) {
    if (!isdefined(self.users[user])) {
        self.users[user] = {};
    }
    if (!isdefined(self.users[user].touching)) {
        self.users[user].touching = {#num:0, #rate:0, #players:[]};
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x9b1408d8, Offset: 0x1b0
// Size: 0x62
function function_136c2270(user) {
    if (!isdefined(self.users[user])) {
        self.users[user] = {};
    }
    if (!isdefined(self.users[user].contributors)) {
        self.users[user].contributors = [];
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 3, eflags: 0x0
// Checksum 0x722fa477, Offset: 0x220
// Size: 0x134
function function_a1839d6b(user, player, key) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].contributors));
    if (!isdefined(self.users[user].contributors[key])) {
        contribution = {#player:player, #contribution:0};
        self.users[user].contributors[key] = contribution;
    } else {
        contribution = self.users[user].contributors[key];
    }
    if (!isdefined(contribution.player)) {
        contribution.player = player;
    }
    contribution.starttime = gettime();
    contribution.var_e22ea52b = 1;
    return self.users[user].contributors[key];
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x6fd87753, Offset: 0x360
// Size: 0x7e
function function_98aae7cf() {
    foreach (user in self.users) {
        user.contributors = undefined;
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x626adb5f, Offset: 0x3e8
// Size: 0x14c
function function_bd47b0c7() {
    function_98aae7cf();
    foreach (user_name, user in self.users) {
        if (user.touching.num > 0) {
            function_136c2270(user_name);
            foreach (var_5717fa0c, player in user.touching.players) {
                function_a1839d6b(user_name, player.player, var_5717fa0c);
            }
        }
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x9fc1e060, Offset: 0x540
// Size: 0x5c
function function_f30290b(user, key) {
    if (isdefined(self.users[user]) && isdefined(self.users[user].contributors)) {
        self.users[user].contributors[key] = undefined;
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x9b01b172, Offset: 0x5a8
// Size: 0xa8
function function_339d0e91() {
    total = 0;
    foreach (var_b2dad138 in self.users) {
        total += self.users[var_b2dad138].touching.num;
    }
    return total;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0xd6608e68, Offset: 0x658
// Size: 0xb4
function function_3a7a2963(var_77efb18) {
    total = 0;
    foreach (user_name, var_b2dad138 in self.users) {
        if (user_name == var_77efb18) {
            continue;
        }
        total += var_b2dad138.touching.num;
    }
    return total;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x213b450e, Offset: 0x718
// Size: 0xa8
function function_3a29539b(var_77efb18) {
    foreach (user_name, var_b2dad138 in self.users) {
        if (user_name == var_77efb18) {
            continue;
        }
        if (var_b2dad138.touching.num > 0) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x2ad65fc6, Offset: 0x7c8
// Size: 0x3e
function get_num_touching(user) {
    if (!isdefined(self.users[user])) {
        return 0;
    }
    return self.users[user].touching.num;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x581ba082, Offset: 0x810
// Size: 0x20
function function_4e3386a8(team) {
    user = team;
    return team;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0xb4829bf2, Offset: 0x838
// Size: 0xa
function function_167d3a40() {
    return self.ownerteam;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x5a740e7b, Offset: 0x850
// Size: 0x5a
function function_b64fb43d() {
    user = self function_167d3a40();
    if (!isdefined(self.users[user])) {
        return 0;
    }
    return self.users[user].touching.num;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x5081e269, Offset: 0x8b8
// Size: 0xa6
function function_22c9de38(user, count = 1) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.num = self.users[user].touching.num + count;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0xf13d4316, Offset: 0x968
// Size: 0xe6
function function_26237f3c(user, count = 1) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.num = self.users[user].touching.num - count;
    if (self.users[user].touching.num < 1) {
        self.users[user].touching.num = 0;
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x5016a6f5, Offset: 0xa58
// Size: 0x1a
function function_5ea37c7c(func) {
    self.var_270e1029 = func;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0xa7c5742a, Offset: 0xa80
// Size: 0x4a
function function_83eda4c0(user) {
    var_5b1365c0 = self.users[user].touching.num;
    return self function_ce47d61c(var_5b1365c0);
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x15af775d, Offset: 0xad8
// Size: 0xf4
function function_ce47d61c(var_5b1365c0 = 0) {
    assert(self.var_9288c4c0 <= self.usetime);
    if (self.maxusers > 0) {
        var_5b1365c0 = min(var_5b1365c0, self.maxusers);
    }
    if (var_5b1365c0 > 1) {
        var_b13b89f5 = (var_5b1365c0 - 1) / (self.maxusers - 1);
        var_e2f3a95a = 1 / self.var_9288c4c0 / self.usetime - 1;
        rate = 1 + var_b13b89f5 * var_e2f3a95a;
        return rate;
    }
    return var_5b1365c0;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x9b7b91b9, Offset: 0xbd8
// Size: 0x152
function function_9f894584(user) {
    if (!isdefined(self.users[user])) {
        return 0;
    }
    if (isdefined(self.var_270e1029)) {
        return self [[ self.var_270e1029 ]](user);
    }
    if (self.var_a0ff5eb8) {
        userate = 0;
        if (self.users[user].touching.players.size > 0) {
            foreach (var_142bcc32 in self.users[user].touching.players) {
                if (isdefined(var_142bcc32.rate) && var_142bcc32.rate > userate) {
                    userate = var_142bcc32.rate;
                }
            }
        }
        return userate;
    }
    return self.users[user].touching.rate;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0xcc062979, Offset: 0xd38
// Size: 0xb8
function function_a7dbb00b(var_77efb18) {
    rate = 0;
    foreach (user_name, _ in self.users) {
        if (user_name == var_77efb18) {
            continue;
        }
        rate += function_9f894584(user_name);
    }
    return rate;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x7ea13340, Offset: 0xdf8
// Size: 0x92
function function_21db7d02(numclaimants = 0, numother = 0) {
    if (numclaimants == numother || numclaimants < 0 || numother < 0) {
        return 0;
    }
    advantage = abs(numclaimants - numother);
    return self function_ce47d61c(advantage);
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0xfebe2403, Offset: 0xe98
// Size: 0x96
function function_f1342bb2(user, rate) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.rate = self.users[user].touching.rate + rate;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0xe5043f8f, Offset: 0xf38
// Size: 0xd6
function function_27b84c22(user, rate) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.rate = self.users[user].touching.rate - rate;
    if (self.users[user].touching.num < 1) {
        self.users[user].touching.rate = 0;
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 4, eflags: 0x0
// Checksum 0xb9bfa9ce, Offset: 0x1018
// Size: 0xb8
function function_fdf87288(user, player, var_8a3ae0a0, var_5717fa0c) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.players[var_5717fa0c] = {#player:player, #rate:var_8a3ae0a0, #starttime:gettime()};
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0xf8dd1193, Offset: 0x10d8
// Size: 0x78
function function_472b3c15(user, var_5717fa0c) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.players[var_5717fa0c] = undefined;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x4
// Checksum 0x2610e6d7, Offset: 0x1158
// Size: 0x9c
function private is_player_touching(var_9b6a15e9, player) {
    foreach (touching_player in var_9b6a15e9) {
        if (touching_player.player == player) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x1018c00, Offset: 0x1200
// Size: 0xb6
function function_73944efe(var_9b6a15e9, touch) {
    if (!isdefined(touch.player)) {
        return undefined;
    }
    if (!isplayer(touch.player)) {
        owner = touch.player.owner;
        if (isdefined(owner) && isplayer(owner)) {
            if (!is_player_touching(var_9b6a15e9, owner)) {
                return owner;
            }
        }
    } else {
        return touch.player;
    }
    return undefined;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x35140933, Offset: 0x12c0
// Size: 0x2c
function function_ebffa9f6(obj_id, team) {
    objective_setteam(obj_id, team);
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x1f038ded, Offset: 0x12f8
// Size: 0x24
function function_33420053(obj_id) {
    function_6da98133(obj_id);
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0xd29f3f43, Offset: 0x1328
// Size: 0x24
function function_311b7785(obj_id) {
    function_4339912c(obj_id);
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0xdc540cea, Offset: 0x1358
// Size: 0x2c
function function_e3cc1e96(obj_id, team) {
    function_29ef32ee(obj_id, team);
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x39f1a993, Offset: 0x1390
// Size: 0x2c
function function_6c27e90c(obj_id, team) {
    function_c939fac4(obj_id, team);
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0xc39468f3, Offset: 0x13c8
// Size: 0x2a
function function_58901d83() {
    self.var_5f35f19a = self.var_a4926509;
    self.var_a4926509 = #"none";
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0xbb8044e2, Offset: 0x1400
// Size: 0x28
function function_7db44d1b(user) {
    if (user != #"none") {
        return true;
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0xcffbefaf, Offset: 0x1430
// Size: 0x1a
function function_350d0352() {
    return function_7db44d1b(self.var_a4926509);
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x9893dcbc, Offset: 0x1458
// Size: 0x1a
function function_3e092344() {
    return function_7db44d1b(self.var_5f35f19a);
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x533e2d00, Offset: 0x1480
// Size: 0xa
function function_14fccbd9() {
    return self.var_a4926509;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0x6c71ff23, Offset: 0x1498
// Size: 0x34
function function_4b64b7fd(team) {
    if (!isdefined(self.var_a4926509)) {
        return false;
    }
    if (team == self.var_a4926509) {
        return true;
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x38f7af9, Offset: 0x14d8
// Size: 0x30
function function_abe3458c() {
    if (!isdefined(self.var_a4926509)) {
        return false;
    }
    if (self.ownerteam == self.var_a4926509) {
        return true;
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0xa733fb72, Offset: 0x1510
// Size: 0x42
function function_abb86400() {
    if (self.ownerteam != #"neutral" && self.ownerteam != #"none") {
        return true;
    }
    return false;
}

