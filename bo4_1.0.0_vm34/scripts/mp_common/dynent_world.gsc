#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_world;

#namespace dynent_world;

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x2
// Checksum 0x64eea8d8, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"dynent_world", &__init__, undefined, undefined);
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x0
// Checksum 0xed081d0a, Offset: 0x108
// Size: 0xac
function __init__() {
    if (!(isdefined(getgametypesetting(#"usabledynents")) ? getgametypesetting(#"usabledynents") : 0)) {
        return;
    }
    /#
        level thread devgui_loop();
    #/
    level thread update_loop();
    callback::on_connect(&on_player_connect);
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x4
// Checksum 0xbd592022, Offset: 0x1c0
// Size: 0x74
function private on_player_connect() {
    usetrigger = create_use_trigger();
    self clientclaimtrigger(usetrigger);
    self.var_7fe3349a = usetrigger;
    /#
        if (self ishost()) {
            self thread function_805ef58d();
        }
    #/
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x4
// Checksum 0x20f7a27d, Offset: 0x240
// Size: 0x120
function private create_use_trigger() {
    usetrigger = spawn("trigger_radius_use", (0, 0, -10000), 0, 128, 64, 1);
    usetrigger triggerignoreteam();
    usetrigger setinvisibletoall();
    usetrigger setvisibletoplayer(self);
    usetrigger setteamfortrigger(#"none");
    usetrigger setcursorhint("HINT_NOICON");
    usetrigger triggerenable(0);
    usetrigger usetriggerignoreuseholdtime();
    usetrigger callback::on_trigger_once(&function_ff72f195);
    return usetrigger;
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x4
// Checksum 0x196d6a93, Offset: 0x368
// Size: 0x172
function private update_loop() {
    level endon(#"game_ended");
    updatepass = 0;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!isdefined(player.var_7fe3349a)) {
                continue;
            }
            if (player.sessionstate != "playing" || !isalive(player) || player isinvehicle() || player item_world::function_9ecda51c()) {
                player.var_7fe3349a triggerenable(0);
                continue;
            }
            if (i % 2 == updatepass) {
                player function_51d8ab2b();
            }
        }
        updatepass = (updatepass + 1) % 2;
        players = undefined;
        waitframe(1);
    }
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x4
// Checksum 0x27d102ed, Offset: 0x4e8
// Size: 0x6dc
function private function_51d8ab2b() {
    height = self getmaxs()[2];
    bounds = (50, 50, height / 2);
    boundsorigin = self getcentroid();
    /#
        debug = self ishost() && getdvarint(#"hash_23e7101285284738", 0);
        if (debug) {
            box(boundsorigin, (0, 0, 0) - bounds, bounds, 0, (0, 0, 1), 1, 0, 2);
        }
    #/
    viewheight = self getplayerviewheight();
    vieworigin = self.origin + (0, 0, viewheight);
    viewangles = self getplayerangles();
    viewforward = anglestoforward(viewangles);
    var_64a5f2cb = function_a98a552b(boundsorigin, bounds);
    var_65a798ab = undefined;
    var_f8c0473e = undefined;
    bestdot = -1;
    foreach (dynent in var_64a5f2cb) {
        centroid = function_a154aa6b(dynent);
        var_5758447a = centroid - vieworigin;
        var_5758447a = vectornormalize((var_5758447a[0], var_5758447a[1], 0));
        var_dd14ba2e = vectordot(viewforward, var_5758447a);
        /#
            if (debug) {
                sphere(dynent.origin, 9, (0, 0, 1), 1, 0, 8, 2);
            }
        #/
        if (var_dd14ba2e < 0) {
            continue;
        }
        if (isdefined(dynent.var_c0a3312b) && gettime() <= dynent.var_c0a3312b) {
            /#
                if (debug) {
                    print3d(dynent.origin, "<dev string:x30>", (1, 1, 1), 1, 0.5, 2);
                }
            #/
            continue;
        }
        stateindex = function_7f51b166(dynent);
        bundle = function_474cb3a(dynent);
        if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[stateindex]) && isdefined(bundle.dynentstates[stateindex].var_bfd09101) && bundle.dynentstates[stateindex].var_bfd09101) {
            /#
                if (debug) {
                    print3d(dynent.origin, "<dev string:x39>", (1, 1, 1), 1, 0.5, 2);
                }
            #/
            continue;
        }
        if (var_dd14ba2e > bestdot) {
            bestdot = var_dd14ba2e;
            var_65a798ab = dynent;
        }
    }
    if (!isdefined(var_65a798ab)) {
        self.var_7fe3349a triggerenable(0);
        return;
    }
    trigger = self.var_7fe3349a;
    state = function_7f51b166(var_65a798ab);
    if (trigger.var_32f9fcd6 === var_65a798ab && trigger.dynentstate === state) {
        trigger triggerenable(1);
        return;
    }
    trigger.var_32f9fcd6 = var_65a798ab;
    trigger.dynentstate = state;
    bundle = function_474cb3a(var_65a798ab);
    v_offset = (isdefined(bundle.var_e4a81ffa) ? bundle.var_e4a81ffa : 0, isdefined(bundle.var_aaa9a63) ? bundle.var_aaa9a63 : 0, isdefined(bundle.var_98a32b28) ? bundle.var_98a32b28 : 0);
    v_offset = rotatepoint(v_offset, var_65a798ab.angles);
    trigger.origin = var_65a798ab.origin + v_offset;
    usetime = isdefined(bundle.use_time) ? bundle.use_time : 0;
    if (usetime > 0) {
        function_3d250f19(trigger, usetime);
    } else {
        trigger usetriggerignoreuseholdtime();
    }
    hintstring = isdefined(bundle.dynentstates[state].hintstring) ? bundle.dynentstates[state].hintstring : #"hash_2bb32441107b5fea";
    trigger sethintstring(hintstring);
    trigger triggerenable(1);
}

// Namespace dynent_world/dynent_world
// Params 1, eflags: 0x4
// Checksum 0xbc00ddb1, Offset: 0xbd0
// Size: 0xc4
function private function_ff72f195(trigger_struct) {
    trigger = self;
    activator = trigger_struct.activator;
    dynent = trigger.var_32f9fcd6;
    if (isdefined(dynent)) {
        var_eb59d318 = use_dynent(trigger.var_32f9fcd6, activator);
        dynent.var_c0a3312b = gettime() + var_eb59d318 * 1000;
        trigger triggerenable(0);
    }
    activator thread function_366b4c25(trigger);
}

// Namespace dynent_world/dynent_world
// Params 1, eflags: 0x4
// Checksum 0x25cc7157, Offset: 0xca0
// Size: 0xa4
function private function_366b4c25(trigger) {
    self notify("79d961cf3a53dae4");
    self endon("79d961cf3a53dae4");
    level endon(#"game_ended");
    self endon(#"death", #"disconnect");
    while (self usebuttonpressed()) {
        waitframe(1);
    }
    trigger callback::on_trigger_once(&function_ff72f195);
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x0
// Checksum 0xb1ce335f, Offset: 0xd50
// Size: 0x5c
function function_ec11d882() {
    if (!isdefined(self.var_7fe3349a)) {
        return;
    }
    self.var_7fe3349a callback::remove_on_trigger_once(&function_ff72f195);
    self thread function_366b4c25(self.var_7fe3349a);
}

// Namespace dynent_world/dynent_world
// Params 2, eflags: 0x4
// Checksum 0x53565a67, Offset: 0xdb8
// Size: 0x230
function private use_dynent(dynent, activator) {
    stateindex = function_7f51b166(dynent);
    bundle = function_474cb3a(dynent);
    var_1bf03eeb = undefined;
    if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[stateindex])) {
        state = bundle.dynentstates[stateindex];
        playerfwd = anglestoforward(activator.angles);
        var_be003140 = anglestoforward(dynent.angles);
        dot = vectordot(var_be003140, playerfwd);
        if (dot > 0) {
            var_1bf03eeb = isdefined(state.var_8b390ffd) ? state.var_8b390ffd : 0;
        } else {
            var_1bf03eeb = isdefined(state.var_1fa792fd) ? state.var_1fa792fd : 0;
        }
        if (isplayer(activator) && isdefined(state.var_124c6653)) {
            activator gestures::function_42215dfa(state.var_124c6653, undefined, 0);
        }
        function_9e7b6692(dynent, var_1bf03eeb);
        if (isdefined(dynent.onuse)) {
            dynent thread [[ dynent.onuse ]](activator, stateindex, var_1bf03eeb);
        }
        return (isdefined(bundle.var_eb59d318) ? bundle.var_eb59d318 : 0);
    }
    return 0;
}

// Namespace dynent_world/event_57a8880c
// Params 1, eflags: 0x44
// Checksum 0x6ddc085a, Offset: 0xff0
// Size: 0x55c
function private event_handler[event_57a8880c] function_565a245e(eventstruct) {
    dynent = eventstruct.ent;
    var_746034 = eventstruct.state;
    bundle = function_474cb3a(dynent);
    if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[var_746034])) {
        newstate = bundle.dynentstates[var_746034];
        teleport = eventstruct.teleport;
        if (!(isdefined(bundle.var_7d21adf7) && bundle.var_7d21adf7)) {
            pos = (isdefined(newstate.pos_x) ? newstate.pos_x : 0, isdefined(newstate.pos_y) ? newstate.pos_y : 0, isdefined(newstate.pos_z) ? newstate.pos_z : 0);
            pos = rotatepoint(pos, dynent.var_ed8879d6);
            neworigin = dynent.var_4926c7e8 + pos;
            pitch = dynent.var_ed8879d6[0] + (isdefined(newstate.var_70282927) ? newstate.var_70282927 : 0);
            yaw = dynent.var_ed8879d6[1] + (isdefined(newstate.var_1e927b7c) ? newstate.var_1e927b7c : 0);
            roll = dynent.var_ed8879d6[2] + (isdefined(newstate.var_17a28ce6) ? newstate.var_17a28ce6 : 0);
            newangles = (absangleclamp360(pitch), absangleclamp360(yaw), absangleclamp360(roll));
            var_eb59d318 = isdefined(bundle.var_eb59d318) ? bundle.var_eb59d318 : 0;
            if (!teleport && var_eb59d318 > 0) {
                dynent function_f4851ef1(neworigin, var_eb59d318);
                dynent function_f8af4dff(newangles, var_eb59d318);
            } else {
                dynent.origin = neworigin;
                dynent.angles = newangles;
            }
        }
        if (isdefined(newstate.overridemodel)) {
            function_83ebb7de(dynent, newstate.overridemodel);
        }
        if (isdefined(newstate.stateanim)) {
            starttime = 0;
            rate = isdefined(newstate.animrate) ? newstate.animrate : 0;
            if (isdefined(newstate.var_e5e83c61) && newstate.var_e5e83c61) {
                gametime = gettime();
                if (isdefined(newstate.var_ce82f01a) && newstate.var_ce82f01a) {
                    gametime += abs(dynent.origin[0] + dynent.origin[1] + dynent.origin[2]);
                }
                animlength = int(getanimlength(newstate.stateanim) * 1000);
                starttime = gametime / animlength / rate;
                starttime -= int(starttime);
            } else if (teleport && !isanimlooping(newstate.stateanim)) {
                starttime = 1;
            }
            function_39a8f05b(dynent, newstate.stateanim, starttime, rate);
        } else {
            function_652b0840(dynent);
        }
        setdynentenabled(dynent, isdefined(newstate.enable) && newstate.enable);
    }
}

// Namespace dynent_world/event_4d2cc78a
// Params 1, eflags: 0x44
// Checksum 0x9aee6f7d, Offset: 0x1558
// Size: 0x10c
function private event_handler[event_4d2cc78a] function_2a36cc11(eventstruct) {
    dynent = eventstruct.ent;
    bundle = function_474cb3a(dynent);
    var_199ffd6b = isdefined(eventstruct.clientside) && eventstruct.clientside;
    if (isdefined(bundle) && isdefined(bundle.dynentstates)) {
        stateindex = isdefined(bundle.destroyed) ? bundle.destroyed : var_199ffd6b ? isdefined(bundle.vehicledestroyed) ? bundle.vehicledestroyed : 0 : 0;
        if (isdefined(bundle.dynentstates[stateindex])) {
            function_9e7b6692(dynent, stateindex);
        }
    }
}

/#

    // Namespace dynent_world/dynent_world
    // Params 0, eflags: 0x4
    // Checksum 0x9f8cba66, Offset: 0x1670
    // Size: 0x176
    function private devgui_loop() {
        level endon(#"game_ended");
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        adddebugcommand("<dev string:x4d>");
        adddebugcommand("<dev string:x72>");
        adddebugcommand("<dev string:xc3>");
        while (true) {
            wait 0.25;
            dvarstr = getdvarstring(#"hash_40f9f26f308dd924", "<dev string:x109>");
            if (dvarstr == "<dev string:x109>") {
                continue;
            }
            setdvar(#"hash_40f9f26f308dd924", "<dev string:x109>");
            args = strtok(dvarstr, "<dev string:x10a>");
            switch (args[0]) {
            case #"reset":
                function_f7cb54cd();
                break;
            }
        }
    }

    // Namespace dynent_world/dynent_world
    // Params 0, eflags: 0x4
    // Checksum 0xfdb052ca, Offset: 0x17f0
    // Size: 0x290
    function private function_805ef58d() {
        self endon(#"disconnect");
        while (true) {
            waitframe(1);
            waittillframeend();
            if (!getdvarint(#"hash_23e7101285284738", 0)) {
                continue;
            }
            trigger = self.var_8c339760;
            if (isdefined(trigger)) {
                dynent = trigger.var_32f9fcd6;
                if (isdefined(dynent)) {
                    sphere(function_a154aa6b(dynent), 8, (0, 1, 1));
                    sphere(dynent.origin, 7, (1, 0.5, 0));
                    print3d(dynent.origin, function_7f51b166(dynent), (1, 1, 1), 1, 0.5);
                }
                color = trigger istriggerenabled() ? (1, 0, 1) : (1, 0, 0);
                maxs = trigger getmaxs();
                mins = trigger getmins();
                origin = trigger.origin;
                top = origin + (0, 0, maxs[2]);
                bottom = origin + (0, 0, mins[2]);
                line(bottom, top, color);
                sphere(origin, 2, color);
                circle(bottom, maxs[0], color, 0, 1);
                circle(top, maxs[0], color, 0, 1);
            }
        }
    }

#/
