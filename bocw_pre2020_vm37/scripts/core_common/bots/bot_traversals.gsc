#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_animation;
#using scripts\core_common\callbacks_shared;

#namespace bot_traversals;

// Namespace bot_traversals/bot_traversals
// Params 0, eflags: 0x1 linked
// Checksum 0x6eaf8da3, Offset: 0xb0
// Size: 0x34
function function_70a657d8() {
    callback::add_callback(#"hash_767bb029d2dcda7c", &function_45ed4ebd);
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x46b0d7f6, Offset: 0xf0
// Size: 0x20c
function private function_45ed4ebd(eventstruct) {
    if (self isplayinganimscripted()) {
        /#
            self botprintwarning("<dev string:x38>");
        #/
        return;
    }
    level function_c8aebd21(eventstruct);
    if (isdefined(eventstruct.var_921d19f9)) {
        switch (eventstruct.var_921d19f9) {
        case 0:
            self thread function_6163524a(eventstruct);
            break;
        case 1:
            self thread function_e37036(eventstruct);
            break;
        case 2:
        case 5:
            self thread function_9bd9969f(eventstruct);
            break;
        case 4:
            self thread function_b2ff3887(eventstruct);
            break;
        case 3:
        default:
            /#
                self botprinterror("<dev string:x6b>" + eventstruct.var_921d19f9 + "<dev string:x99>" + eventstruct.start_position);
            #/
            break;
        }
        return;
    }
    if (function_5186819c(eventstruct)) {
        self thread function_342c7f77(eventstruct);
        return;
    }
    if (function_51cbae24(eventstruct)) {
        self thread function_e48afac9(eventstruct);
        return;
    }
    self thread function_6163524a(eventstruct);
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0xebabd585, Offset: 0x308
// Size: 0x34
function private function_b1528302(eventstruct) {
    self.bot.traversal = eventstruct;
    self bottakemanualcontrol();
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x53697938, Offset: 0x348
// Size: 0x44
function private function_1aaef814(*notifyhash) {
    self.bot.traversal = undefined;
    if (isbot(self)) {
        self botreleasemanualcontrol();
    }
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x3d65b324, Offset: 0x398
// Size: 0x52
function private function_5186819c(eventstruct) {
    return isdefined(eventstruct.start_node) && isdefined(eventstruct.start_node.spawnflags) && eventstruct.start_node.spawnflags & 134217728;
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x19dd9a0a, Offset: 0x3f8
// Size: 0xc4
function private function_51cbae24(eventstruct) {
    if (isdefined(eventstruct.var_a8cc518d)) {
        return false;
    }
    startpos = eventstruct.start_position;
    endpos = eventstruct.end_position;
    deltaz = endpos[2] - startpos[2];
    if (deltaz < 18) {
        return false;
    }
    result = bullettrace(startpos, endpos, 0, self);
    if (result[#"surfacetype"] == "ladder") {
        return true;
    }
    return false;
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0xcd995614, Offset: 0x4c8
// Size: 0x112
function private function_c8aebd21(eventstruct) {
    startpos = eventstruct.start_position;
    endpos = eventstruct.end_position;
    tracedist = distance2d(startpos, endpos);
    traversaldir = endpos - startpos;
    eventstruct.var_883d42a7 = checknavmeshdirection(startpos, traversaldir, tracedist, 0);
    var_695ff8a6 = startpos - endpos;
    eventstruct.var_15dca465 = checknavmeshdirection(endpos, var_695ff8a6, tracedist, 0);
    eventstruct.normal = vectornormalize((var_695ff8a6[0], var_695ff8a6[1], 0));
    eventstruct.deltaz = eventstruct.var_15dca465[2] - eventstruct.var_883d42a7[2];
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x27c53d75, Offset: 0x5e8
// Size: 0x114
function private function_6163524a(eventstruct) {
    if (isdefined(eventstruct.var_a8cc518d)) {
        self thread function_9bd9969f(eventstruct);
        return;
    }
    var_883d42a7 = eventstruct.var_883d42a7;
    var_15dca465 = eventstruct.var_15dca465;
    deltaz = eventstruct.deltaz;
    if (distance2d(var_883d42a7, var_15dca465) >= 30) {
        self thread function_adeef583(eventstruct);
        return;
    }
    if (deltaz >= 18) {
        self thread function_e37036(eventstruct);
        return;
    }
    if (deltaz < -18) {
        self thread function_b2ff3887(eventstruct);
        return;
    }
    self thread function_342c7f77(eventstruct);
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x5f396bd9, Offset: 0x708
// Size: 0x34
function private function_342c7f77(eventstruct) {
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:xa1>");
    #/
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x37f4a179, Offset: 0x748
// Size: 0x144
function private function_e48afac9(eventstruct) {
    self endon(#"disconnect", #"hash_6280ac8ed281ce3c");
    self endoncallback(&function_1aaef814, #"death", #"entering_last_stand", #"new_shot");
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:xb7>");
    #/
    self function_b1528302(eventstruct);
    self botsetmovepoint(eventstruct.end_position);
    self botsetmovemagnitude(1);
    while (!self isonladder()) {
        waitframe(1);
    }
    while (self isonladder()) {
        waitframe(1);
    }
    self function_1aaef814();
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x80991ebe, Offset: 0x898
// Size: 0x244
function private function_e37036(eventstruct) {
    self endon(#"disconnect", #"hash_6280ac8ed281ce3c");
    self endoncallback(&function_1aaef814, #"death", #"entering_last_stand", #"new_shot");
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:xcb>");
    #/
    self function_b1528302(eventstruct);
    startpos = eventstruct.start_position;
    endpos = eventstruct.end_position;
    var_bf474064 = eventstruct.var_15dca465;
    normal = eventstruct.normal;
    var_ba505720 = vectordot(self.origin - var_bf474064, normal);
    self botsetmovepoint(endpos);
    self botsetmovemagnitude(1);
    while (var_ba505720 > 38) {
        waitframe(1);
        var_ba505720 = vectordot(self.origin - var_bf474064, normal);
    }
    do {
        self bottapbutton(10);
        waitframe(1);
    } while (!self ismantling() && !self isonground() && self.origin[2] <= var_bf474064[2]);
    while (self ismantling()) {
        waitframe(1);
    }
    self function_1aaef814();
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0xc8cc7a3b, Offset: 0xae8
// Size: 0x2fc
function private function_9bd9969f(eventstruct) {
    self endon(#"disconnect", #"hash_6280ac8ed281ce3c");
    self endoncallback(&function_1aaef814, #"death", #"entering_last_stand", #"new_shot");
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:xde>");
    #/
    self function_b1528302(eventstruct);
    self botsetmovepoint(eventstruct.end_position);
    self botsetmovemagnitude(1);
    var_2166cb2 = eventstruct.var_a8cc518d;
    normal = eventstruct.normal;
    for (var_2aab82d7 = vectordot(self.origin - var_2166cb2, normal); var_2aab82d7 > 38; var_2aab82d7 = vectordot(self.origin - var_2166cb2, normal)) {
        waitframe(1);
    }
    do {
        self bottapbutton(10);
        waitframe(1);
        var_2aab82d7 = vectordot(self.origin - var_2166cb2, normal);
    } while (!self ismantling() && !self isonground() && var_2aab82d7 >= 0);
    while (self ismantling()) {
        waitframe(1);
    }
    while (var_2166cb2[2] - self.origin[2] < 18) {
        waitframe(1);
    }
    if (!self isonground()) {
        self botsetmovemagnitude(0);
        velocity = self getvelocity();
        self setvelocity((0, 0, velocity[2]));
        waitframe(1);
        while (!self isonground()) {
            waitframe(1);
        }
    }
    self function_1aaef814();
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0x729ee3f8, Offset: 0xdf0
// Size: 0x2ac
function private function_adeef583(eventstruct) {
    self endon(#"disconnect", #"hash_6280ac8ed281ce3c");
    self endoncallback(&function_1aaef814, #"death", #"entering_last_stand", #"new_shot");
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:xf1>");
    #/
    self function_b1528302(eventstruct);
    startpos = eventstruct.start_position;
    endpos = eventstruct.end_position;
    var_dab42a49 = eventstruct.var_883d42a7;
    var_b413746e = eventstruct.var_15dca465;
    normal = eventstruct.normal;
    var_6e3575aa = vectordot(self.origin - var_dab42a49, normal);
    self botsetmovepoint(endpos);
    self botsetmovemagnitude(1);
    while (var_6e3575aa > 0) {
        waitframe(1);
        var_6e3575aa = vectordot(self.origin - var_dab42a49, normal);
    }
    do {
        self bottapbutton(10);
        var_c9259e0b = vectordot(self.origin - var_b413746e, normal);
        waitframe(1);
    } while (!self ismantling() && !self isonground() && var_c9259e0b >= 15);
    while (self ismantling()) {
        waitframe(1);
    }
    self botsetmovemagnitude(0);
    while (!self isonground()) {
        waitframe(1);
    }
    self function_1aaef814();
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x5 linked
// Checksum 0xd75741f, Offset: 0x10a8
// Size: 0x1c4
function private function_b2ff3887(eventstruct) {
    self endon(#"disconnect", #"hash_6280ac8ed281ce3c");
    self endoncallback(&function_1aaef814, #"death", #"entering_last_stand", #"new_shot");
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:x103>");
    #/
    self function_b1528302(eventstruct);
    self botsetmovepoint(eventstruct.end_position);
    self botsetmovemagnitude(1);
    while (self isonground()) {
        waitframe(1);
    }
    self botsetmovemagnitude(0);
    if (!self isonground()) {
        velocity = self getvelocity();
        self setvelocity((0, 0, velocity[2]));
        waitframe(1);
    }
    while (!self isonground()) {
        waitframe(1);
    }
    self function_1aaef814(eventstruct);
}

// Namespace bot_traversals/bot_traversals
// Params 1, eflags: 0x4
// Checksum 0xa5b52165, Offset: 0x1278
// Size: 0xc6
function private function_c3452ef9(eventstruct) {
    /#
        self thread function_c20f7b00(eventstruct, "<dev string:x115>");
    #/
    self.traversestartnode = eventstruct.start_node;
    self.traversalstartpos = eventstruct.start_position;
    self.traverseendnode = eventstruct.end_node;
    self.traversalendpos = eventstruct.end_position;
    self.traversemantlenode = eventstruct.mantle_node;
    bot_animation::play_animation("parametric_traverse@traversal");
    self.traversestartnode = undefined;
    self.traversalstartpos = undefined;
    self.traverseendnode = undefined;
    self.traversalendpos = undefined;
    self.traversemantlenode = undefined;
}

/#

    // Namespace bot_traversals/bot_traversals
    // Params 2, eflags: 0x4
    // Checksum 0xc554f6f, Offset: 0x1348
    // Size: 0x496
    function private function_c20f7b00(eventstruct, str) {
        self endon(#"death", #"hash_6280ac8ed281ce3c");
        textpos = vectorlerp(eventstruct.start_position, eventstruct.end_position, 0.5);
        yaw = vectortoangles(eventstruct.normal)[1];
        do {
            if (self bot::should_record("<dev string:x127>")) {
                record3dtext(str, textpos, (1, 1, 1), "<dev string:x13e>", self, 0.5);
                recordstar(eventstruct.start_position, (0, 1, 0), "<dev string:x13e>", self);
                function_af72dbc5(eventstruct.start_position, (0, -64, 0), (0, 64, 0), yaw, (0, 1, 0), "<dev string:x13e>", self);
                recordstar(eventstruct.end_position, (1, 0, 0), "<dev string:x13e>", self);
                function_af72dbc5(eventstruct.end_position, (0, -64, 0), (0, 64, 0), yaw, (1, 0, 0), "<dev string:x13e>", self);
                if (isdefined(eventstruct.var_a8cc518d)) {
                    recordstar(eventstruct.var_a8cc518d, (1, 1, 0), "<dev string:x13e>", self);
                    function_af72dbc5(eventstruct.var_a8cc518d, (0, -64, 0), (0, 64, 128), yaw, (1, 1, 0), "<dev string:x13e>", self);
                    recordline(eventstruct.start_position, eventstruct.var_a8cc518d, (0, 1, 1), "<dev string:x13e>", self);
                    recordline(eventstruct.end_position, eventstruct.var_a8cc518d, (0, 1, 1), "<dev string:x13e>", self);
                } else {
                    recordline(eventstruct.start_position, eventstruct.end_position, (0, 1, 1), "<dev string:x13e>", self);
                }
                recordstar(eventstruct.var_883d42a7, (0, 1, 0), "<dev string:x13e>", self);
                function_af72dbc5(eventstruct.var_883d42a7, (0, -64, 0), (0, 64, 128), yaw, (0, 1, 0), "<dev string:x13e>", self);
                recordstar(eventstruct.var_15dca465, (1, 0, 0), "<dev string:x13e>", self);
                function_af72dbc5(eventstruct.var_15dca465, (0, -64, 0), (0, 64, 128), yaw, (1, 0, 0), "<dev string:x13e>", self);
                if (isdefined(eventstruct.start_node)) {
                    self function_3e781451(eventstruct.start_node, (0, 1, 0));
                }
                if (isdefined(eventstruct.end_node)) {
                    self function_3e781451(eventstruct.end_node, (1, 0, 0));
                }
                if (isdefined(eventstruct.mantle_node)) {
                    self function_3e781451(eventstruct.mantle_node, (1, 1, 0));
                }
            }
            waitframe(1);
        } while (self botundermanualcontrol() && isdefined(self.bot) && isdefined(self.bot.traversal));
    }

    // Namespace bot_traversals/bot_traversals
    // Params 2, eflags: 0x4
    // Checksum 0x12aacb98, Offset: 0x17e8
    // Size: 0xf4
    function private function_3e781451(node, color) {
        if (node.type == #"volume") {
            mins = (0, 0, 0) - node.aabb_extents;
            maxs = node.aabb_extents;
            function_af72dbc5(node.origin, mins, maxs, node.angles[1], color, "<dev string:x13e>", self);
            return;
        }
        function_af72dbc5(node.origin, (-15, -15, 0), (15, 15, 15), node.angles[1], color, "<dev string:x13e>", self);
    }

#/
