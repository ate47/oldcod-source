#namespace gameobjects;

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0x5bce5078, Offset: 0x60
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
// Params 1, eflags: 0x1 linked
// Checksum 0x127815c0, Offset: 0x110
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa84d9e5d, Offset: 0x1b0
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
// Params 3, eflags: 0x1 linked
// Checksum 0x87334a5f, Offset: 0x220
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
// Params 0, eflags: 0x1 linked
// Checksum 0xe505d3d7, Offset: 0x360
// Size: 0x7e
function function_98aae7cf() {
    foreach (user in self.users) {
        user.contributors = undefined;
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x999875fb, Offset: 0x3e8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x1b68a307, Offset: 0x540
// Size: 0x5c
function function_f30290b(user, key) {
    if (isdefined(self.users[user]) && isdefined(self.users[user].contributors)) {
        self.users[user].contributors[key] = undefined;
    }
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x0
// Checksum 0x7a4dbbdf, Offset: 0x5a8
// Size: 0xa8
function function_339d0e91() {
    total = 0;
    foreach (var_b2dad138 in self.users) {
        total += self.users[var_b2dad138].touching.num;
    }
    return total;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x1 linked
// Checksum 0x28bb64d3, Offset: 0x658
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
// Checksum 0xc701cd5, Offset: 0x718
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
// Params 1, eflags: 0x1 linked
// Checksum 0x3323a7ab, Offset: 0x7c8
// Size: 0x3e
function get_num_touching(user) {
    if (!isdefined(self.users[user])) {
        return 0;
    }
    return self.users[user].touching.num;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x1 linked
// Checksum 0xfe225b1d, Offset: 0x810
// Size: 0x20
function function_4e3386a8(team) {
    user = team;
    return team;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0x92f96708, Offset: 0x838
// Size: 0xa
function function_167d3a40() {
    return self.ownerteam;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0x13bdb41f, Offset: 0x850
// Size: 0x5a
function function_b64fb43d() {
    user = self function_167d3a40();
    if (!isdefined(self.users[user])) {
        return 0;
    }
    return self.users[user].touching.num;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x1 linked
// Checksum 0x8f4b44d1, Offset: 0x8b8
// Size: 0xa6
function function_22c9de38(user, count = 1) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.num = self.users[user].touching.num + count;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x1 linked
// Checksum 0x91227ca9, Offset: 0x968
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
// Checksum 0x12df9e67, Offset: 0xa58
// Size: 0x1a
function function_5ea37c7c(func) {
    self.var_270e1029 = func;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x0
// Checksum 0xe8c725dc, Offset: 0xa80
// Size: 0x12c
function function_83eda4c0(user) {
    assert(self.var_9288c4c0 <= self.usetime);
    if (self.maxusers == 0) {
        var_5b1365c0 = self.users[user].touching.num;
    } else {
        var_5b1365c0 = min(self.users[user].touching.num, self.maxusers);
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa51662e2, Offset: 0xbb8
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9e39ebbd, Offset: 0xd18
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
// Params 2, eflags: 0x1 linked
// Checksum 0x9682f8b7, Offset: 0xdd8
// Size: 0x96
function function_f1342bb2(user, rate) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.rate = self.users[user].touching.rate + rate;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x1 linked
// Checksum 0xa1797ef7, Offset: 0xe78
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
// Params 4, eflags: 0x1 linked
// Checksum 0x4209a5f9, Offset: 0xf58
// Size: 0xb8
function function_fdf87288(user, player, var_8a3ae0a0, var_5717fa0c) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.players[var_5717fa0c] = {#player:player, #rate:var_8a3ae0a0, #starttime:gettime()};
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x1 linked
// Checksum 0xc19dffb8, Offset: 0x1018
// Size: 0x78
function function_472b3c15(user, var_5717fa0c) {
    assert(isdefined(self.users[user]));
    assert(isdefined(self.users[user].touching));
    self.users[user].touching.players[var_5717fa0c] = undefined;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x5 linked
// Checksum 0xaf942b62, Offset: 0x1098
// Size: 0x9c
function private is_player_touching(var_9b6a15e9, player) {
    foreach (var_233ec7cb in var_9b6a15e9) {
        if (var_233ec7cb.player == player) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x0
// Checksum 0x8049fca, Offset: 0x1140
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
// Params 2, eflags: 0x1 linked
// Checksum 0x4b2425b7, Offset: 0x1200
// Size: 0x2c
function function_ebffa9f6(obj_id, team) {
    objective_setteam(obj_id, team);
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x1 linked
// Checksum 0xba598a12, Offset: 0x1238
// Size: 0x24
function function_33420053(obj_id) {
    function_6da98133(obj_id);
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x1 linked
// Checksum 0x864db2e9, Offset: 0x1268
// Size: 0x24
function function_311b7785(obj_id) {
    function_4339912c(obj_id);
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x1 linked
// Checksum 0x33e354f2, Offset: 0x1298
// Size: 0x2c
function function_e3cc1e96(obj_id, team) {
    function_29ef32ee(obj_id, team);
}

// Namespace gameobjects/namespace_87a60c47
// Params 2, eflags: 0x1 linked
// Checksum 0x5f5c3573, Offset: 0x12d0
// Size: 0x2c
function function_6c27e90c(obj_id, team) {
    function_c939fac4(obj_id, team);
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0x830611e8, Offset: 0x1308
// Size: 0x1a
function function_58901d83() {
    self.var_a4926509 = #"none";
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x1 linked
// Checksum 0x9c5da2e3, Offset: 0x1330
// Size: 0x28
function function_bd8ba4a3(user) {
    if (user != #"none") {
        return true;
    }
    return false;
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0x465482ef, Offset: 0x1360
// Size: 0x1a
function function_350d0352() {
    return function_bd8ba4a3(self.var_a4926509);
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0x5ca9cecc, Offset: 0x1388
// Size: 0x1a
function function_3e092344() {
    return function_bd8ba4a3(self.var_5f35f19a);
}

// Namespace gameobjects/namespace_87a60c47
// Params 0, eflags: 0x1 linked
// Checksum 0xb1f74f5b, Offset: 0x13b0
// Size: 0xa
function function_14fccbd9() {
    return self.var_a4926509;
}

// Namespace gameobjects/namespace_87a60c47
// Params 1, eflags: 0x1 linked
// Checksum 0x62a8e632, Offset: 0x13c8
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
// Params 0, eflags: 0x1 linked
// Checksum 0xe0c3a11f, Offset: 0x1408
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
// Params 0, eflags: 0x1 linked
// Checksum 0x75db42e2, Offset: 0x1440
// Size: 0x42
function function_abb86400() {
    if (self.ownerteam != #"neutral" && self.ownerteam != #"none") {
        return true;
    }
    return false;
}

