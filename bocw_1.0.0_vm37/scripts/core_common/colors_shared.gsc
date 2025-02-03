#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace colors;

// Namespace colors/colors_shared
// Params 0, eflags: 0x6
// Checksum 0x4be4bf07, Offset: 0x190
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"colors", &preinit, &postinit, undefined, undefined);
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x4
// Checksum 0xc7163cf0, Offset: 0x1e8
// Size: 0xaec
function private preinit() {
    nodes = getallnodes();
    level flag::init("player_looks_away_from_spawner");
    level flag::init("friendly_spawner_locked");
    level flag::init("respawn_friendlies");
    level.arrays_of_colorcoded_nodes = [];
    level.arrays_of_colorcoded_nodes[#"axis"] = [];
    level.arrays_of_colorcoded_nodes[#"allies"] = [];
    level.arrays_of_colorcoded_nodes[#"team3"] = [];
    level.colorcoded_volumes = [];
    level.colorcoded_volumes[#"axis"] = [];
    level.colorcoded_volumes[#"allies"] = [];
    level.colorcoded_volumes[#"team3"] = [];
    volumes = getentarray("info_volume", "classname");
    for (i = 0; i < nodes.size; i++) {
        if (isdefined(nodes[i].script_color_allies)) {
            nodes[i] add_node_to_global_arrays(nodes[i].script_color_allies, #"allies");
        }
        if (isdefined(nodes[i].script_color_axis)) {
            nodes[i] add_node_to_global_arrays(nodes[i].script_color_axis, #"axis");
        }
        if (isdefined(nodes[i].script_color_team3)) {
            nodes[i] add_node_to_global_arrays(nodes[i].script_color_team3, #"team3");
        }
    }
    for (i = 0; i < volumes.size; i++) {
        if (isdefined(volumes[i].script_color_allies)) {
            volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, #"allies");
        }
        if (isdefined(volumes[i].script_color_axis)) {
            volumes[i] add_volume_to_global_arrays(volumes[i].script_color_axis, #"axis");
        }
        if (isdefined(volumes[i].script_color_team3)) {
            volumes[i] add_volume_to_global_arrays(volumes[i].script_color_team3, #"team3");
        }
    }
    /#
        level.colornodes_debug_array = [];
        level.colornodes_debug_array[#"allies"] = [];
        level.colornodes_debug_array[#"axis"] = [];
        level.colornodes_debug_array[#"team3"] = [];
    #/
    level.color_node_type_function = [];
    add_cover_node(#"bad node");
    add_cover_node(#"cover stand");
    add_cover_node(#"cover crouch");
    add_cover_node(#"cover prone");
    add_cover_node(#"cover crouch window");
    add_cover_node(#"cover right");
    add_cover_node(#"cover left");
    add_cover_node(#"hash_22a0cbc4c551a678");
    add_cover_node(#"hash_4c95cba4aba377ad");
    add_cover_node(#"cover pillar");
    add_cover_node(#"conceal stand");
    add_cover_node(#"conceal crouch");
    add_cover_node(#"conceal prone");
    add_cover_node(#"reacquire");
    add_cover_node(#"balcony");
    add_cover_node(#"scripted");
    add_cover_node(#"begin");
    add_cover_node(#"end");
    add_cover_node(#"turret");
    add_path_node(#"guard");
    add_path_node(#"exposed");
    add_path_node(#"path");
    level.colorlist = [];
    level.colorlist[level.colorlist.size] = "r";
    level.colorlist[level.colorlist.size] = "b";
    level.colorlist[level.colorlist.size] = "y";
    level.colorlist[level.colorlist.size] = "c";
    level.colorlist[level.colorlist.size] = "g";
    level.colorlist[level.colorlist.size] = "p";
    level.colorlist[level.colorlist.size] = "o";
    level.colorchecklist[#"red"] = "r";
    level.colorchecklist[#"r"] = "r";
    level.colorchecklist[#"blue"] = "b";
    level.colorchecklist[#"b"] = "b";
    level.colorchecklist[#"yellow"] = "y";
    level.colorchecklist[#"y"] = "y";
    level.colorchecklist[#"cyan"] = "c";
    level.colorchecklist[#"c"] = "c";
    level.colorchecklist[#"green"] = "g";
    level.colorchecklist[#"g"] = "g";
    level.colorchecklist[#"purple"] = "p";
    level.colorchecklist[#"p"] = "p";
    level.colorchecklist[#"orange"] = "o";
    level.colorchecklist[#"o"] = "o";
    level.currentcolorforced = [];
    level.currentcolorforced[#"allies"] = [];
    level.currentcolorforced[#"axis"] = [];
    level.currentcolorforced[#"team3"] = [];
    level.lastcolorforced = [];
    level.lastcolorforced[#"allies"] = [];
    level.lastcolorforced[#"axis"] = [];
    level.lastcolorforced[#"team3"] = [];
    for (i = 0; i < level.colorlist.size; i++) {
        level.arrays_of_colorforced_ai[#"allies"][level.colorlist[i]] = [];
        level.arrays_of_colorforced_ai[#"axis"][level.colorlist[i]] = [];
        level.arrays_of_colorforced_ai[#"team3"][level.colorlist[i]] = [];
        level.currentcolorforced[#"allies"][level.colorlist[i]] = undefined;
        level.currentcolorforced[#"axis"][level.colorlist[i]] = undefined;
        level.currentcolorforced[#"team3"][level.colorlist[i]] = undefined;
    }
    /#
        thread debugdvars();
        thread debugcolorfriendlies();
    #/
    level.var_a6112e7 = 8;
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x4
// Checksum 0x257dd006, Offset: 0xce0
// Size: 0x120
function private postinit() {
    foreach (trig in trigger::get_all()) {
        if (isdefined(trig.script_color_allies)) {
            trig thread trigger_issues_orders(trig.script_color_allies, #"allies");
        }
        if (isdefined(trig.script_color_axis)) {
            trig thread trigger_issues_orders(trig.script_color_axis, #"axis");
        }
        if (isdefined(trig.script_color_team3)) {
            trig thread trigger_issues_orders(trig.script_color_team3, #"team3");
        }
    }
}

/#

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x26d8867f, Offset: 0xe08
    // Size: 0x56
    function debugdvars() {
        while (true) {
            if (getdvar(#"debug_colornodes", 0) > 0) {
                thread debug_colornodes();
            }
            waitframe(1);
        }
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x680fceda, Offset: 0xe68
    // Size: 0x88
    function get_team_substr() {
        if (self.team == #"allies") {
            if (!isdefined(self.node.script_color_allies_old)) {
                return;
            }
            return self.node.script_color_allies_old;
        }
        if (self.team == #"axis") {
            if (!isdefined(self.node.script_color_axis_old)) {
                return;
            }
            return self.node.script_color_axis_old;
        }
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe98d9a0d, Offset: 0xef8
    // Size: 0x11c
    function try_to_draw_line_to_node() {
        if (!isdefined(self.node)) {
            return;
        }
        if (!isdefined(self.script_forcecolor)) {
            return;
        }
        substr = get_team_substr();
        if (!isdefined(substr)) {
            return;
        }
        if (!issubstr(substr, self.script_forcecolor)) {
            return;
        }
        recordline(self.origin + (0, 0, 25), self.node.origin, _get_debug_color(self.script_forcecolor), "<dev string:x38>", self);
        line(self.origin + (0, 0, 25), self.node.origin, _get_debug_color(self.script_forcecolor));
    }

    // Namespace colors/colors_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb46c3f09, Offset: 0x1020
    // Size: 0x1a2
    function _get_debug_color(str_color) {
        switch (str_color) {
        case #"red":
        case #"r":
            return (1, 0, 0);
        case #"green":
        case #"g":
            return (0, 1, 0);
        case #"b":
        case #"blue":
            return (0, 0, 1);
        case #"yellow":
        case #"y":
            return (1, 1, 0);
        case #"orange":
        case #"o":
            return (1, 0.5, 0);
        case #"c":
        case #"cyan":
            return (0, 1, 1);
        case #"purple":
        case #"p":
            return (1, 0, 1);
        default:
            println("<dev string:x42>" + str_color + "<dev string:x52>");
            return (0, 0, 0);
        }
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x44cfd0b1, Offset: 0x11d0
    // Size: 0x2a4
    function debug_colornodes() {
        array = [];
        array[#"axis"] = [];
        array[#"allies"] = [];
        array[#"team3"] = [];
        aiarray = arraycombine(getplayers(), getaiarray(), 0, 0);
        foreach (ai in aiarray) {
            if (!isdefined(ai.currentcolorcode) || !isai(ai) && !isbot(ai) || !isdefined(array[ai.team])) {
                continue;
            }
            array[ai.team][ai.currentcolorcode] = 1;
            color = (1, 1, 1);
            if (isdefined(ai.script_forcecolor)) {
                color = _get_debug_color(ai.script_forcecolor);
            }
            recordenttext(ai.currentcolorcode, ai, color, "<dev string:x38>");
            print3d(ai.origin + (0, 0, 25), ai.currentcolorcode, color, 1, 0.7);
            ai try_to_draw_line_to_node();
        }
        draw_colornodes(array, #"allies");
        draw_colornodes(array, #"axis");
        draw_colornodes(array, #"team3");
    }

    // Namespace colors/colors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x9af56441, Offset: 0x1480
    // Size: 0x2c0
    function draw_colornodes(array, team) {
        foreach (k, v in array[team]) {
            color = _get_debug_color(function_9e72a96(k)[0]);
            if (isdefined(level.colornodes_debug_array[team][k])) {
                a_team_nodes = level.colornodes_debug_array[team][k];
                for (p = 0; p < a_team_nodes.size; p++) {
                    print3d(a_team_nodes[p].origin, "<dev string:x93>" + function_9e72a96(k), color, 1, 0.7);
                    if (getdvar(#"debug_colornodes", 0) == 2 && isdefined(a_team_nodes[p].script_color_allies_old)) {
                        if (isdefined(a_team_nodes[p].color_user) && isalive(a_team_nodes[p].color_user) && isdefined(a_team_nodes[p].color_user.script_forcecolor)) {
                            print3d(a_team_nodes[p].origin + (0, 0, -5), "<dev string:x93>" + a_team_nodes[p].script_color_allies_old, _get_debug_color(a_team_nodes[p].color_user.script_forcecolor), 0.5, 0.4);
                            continue;
                        }
                        print3d(a_team_nodes[p].origin + (0, 0, -5), "<dev string:x93>" + a_team_nodes[p].script_color_allies_old, color, 0.5, 0.4);
                    }
                }
            }
        }
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x79216efd, Offset: 0x1748
    // Size: 0x60
    function debugcolorfriendlies() {
        level.debug_color_friendlies = [];
        level.debug_color_huds = [];
        level thread debugcolorfriendliestogglewatch();
        for (;;) {
            level waittill(#"updated_color_friendlies");
            draw_color_friendlies();
        }
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x79c4531a, Offset: 0x17b0
    // Size: 0xe8
    function debugcolorfriendliestogglewatch() {
        just_turned_on = 0;
        just_turned_off = 0;
        while (true) {
            if (getdvar(#"debug_colornodes", 0) == 1 && !just_turned_on) {
                just_turned_on = 1;
                just_turned_off = 0;
                draw_color_friendlies();
            }
            if (getdvar(#"debug_colornodes", 0) != 1 && !just_turned_off) {
                just_turned_off = 1;
                just_turned_on = 0;
                draw_color_friendlies();
            }
            wait 0.25;
        }
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6ad87600, Offset: 0x18a0
    // Size: 0xd6
    function get_script_palette() {
        rgb = [];
        rgb[#"r"] = (1, 0, 0);
        rgb[#"o"] = (1, 0.5, 0);
        rgb[#"y"] = (1, 1, 0);
        rgb[#"g"] = (0, 1, 0);
        rgb[#"c"] = (0, 1, 1);
        rgb[#"b"] = (0, 0, 1);
        rgb[#"p"] = (1, 0, 1);
        return rgb;
    }

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe60e0646, Offset: 0x1980
    // Size: 0x34a
    function draw_color_friendlies() {
        level endon(#"updated_color_friendlies");
        colored_friendlies = [];
        colors = [];
        colors[colors.size] = "<dev string:x99>";
        colors[colors.size] = "<dev string:x9e>";
        colors[colors.size] = "<dev string:xa3>";
        colors[colors.size] = "<dev string:xa8>";
        colors[colors.size] = "<dev string:xad>";
        colors[colors.size] = "<dev string:xb2>";
        colors[colors.size] = "<dev string:xb7>";
        rgb = get_script_palette();
        for (i = 0; i < colors.size; i++) {
            colored_friendlies[colors[i]] = 0;
        }
        foreach (color in level.debug_color_friendlies) {
            colored_friendlies[color]++;
        }
        for (i = 0; i < level.debug_color_huds.size; i++) {
            level.debug_color_huds[i] destroy();
        }
        level.debug_color_huds = [];
        if (getdvar(#"debug_colornodes", 0) != 1) {
            return;
        }
        y = 365;
        for (i = 0; i < colors.size; i++) {
            if (colored_friendlies[colors[i]] <= 0) {
                continue;
            }
            for (p = 0; p < colored_friendlies[colors[i]]; p++) {
                overlay = newdebughudelem();
                overlay.x = 15 + 25 * p;
                overlay.y = y;
                overlay setshader(#"white", 16, 16);
                overlay.alignx = "<dev string:xbc>";
                overlay.aligny = "<dev string:xc4>";
                overlay.alpha = 1;
                overlay.color = rgb[colors[i]];
                level.debug_color_huds[level.debug_color_huds.size] = overlay;
            }
            y += 25;
        }
    }

#/

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x45f10b27, Offset: 0x1cd8
// Size: 0x14
function player_init_color_grouping() {
    thread player_color_node();
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x10ccb4f3, Offset: 0x1cf8
// Size: 0x1e
function convert_color_to_short_string() {
    self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xfacb84c9, Offset: 0x1d20
// Size: 0x294
function goto_current_colorindex() {
    if (!isdefined(self.currentcolorcode)) {
        return;
    }
    nodes = level.arrays_of_colorcoded_nodes[self.team][self.currentcolorcode];
    if (!isdefined(nodes)) {
        nodes = [];
    } else if (!isarray(nodes)) {
        nodes = array(nodes);
    }
    nodes[nodes.size] = level.colorcoded_volumes[self.team][self.currentcolorcode];
    self left_color_node();
    if (!isalive(self)) {
        return;
    }
    if (!has_color()) {
        return;
    }
    selectednode = undefined;
    if (nodes.size >= 1 && isdefined(nodes[0].classname) && nodes[0].classname == "info_volume") {
        selectednode = nodes[randomint(nodes.size)];
    } else {
        for (i = 0; i < nodes.size; i++) {
            node = nodes[i];
            if (isalive(node.color_user) && !isplayer(node.color_user)) {
                continue;
            }
            selectednode = node;
            break;
        }
    }
    if (isdefined(selectednode)) {
        self thread ai_sets_goal_with_delay(selectednode);
        thread decrementcolorusers(selectednode);
        return;
    }
    /#
        if (isbot(self)) {
            println("<dev string:xce>" + self.name + "<dev string:xe0>");
            return;
        }
        println("<dev string:x11b>" + self.export + "<dev string:xe0>");
    #/
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xc6bea1f, Offset: 0x1fc0
// Size: 0x1ae
function function_4156cb7d(var_e6f7de4c, str_team) {
    color = undefined;
    foreach (color in level.colorlist) {
        if (issubstr(var_e6f7de4c, color)) {
            break;
        }
        color = undefined;
    }
    assert(isdefined(color), "<dev string:x12e>" + str_team + "<dev string:x159>");
    level.currentcolorforced[str_team][var_e6f7de4c] = undefined;
    level.lastcolorforced[str_team][var_e6f7de4c] = undefined;
    ai = level.arrays_of_colorforced_ai[str_team][var_e6f7de4c];
    foreach (guy in ai) {
        if (isdefined(guy) && isalive(guy)) {
            guy.currentcolorcode = undefined;
        }
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x1e34e732, Offset: 0x2178
// Size: 0xa2
function get_color_list() {
    colorlist = [];
    colorlist[colorlist.size] = "r";
    colorlist[colorlist.size] = "b";
    colorlist[colorlist.size] = "y";
    colorlist[colorlist.size] = "c";
    colorlist[colorlist.size] = "g";
    colorlist[colorlist.size] = "p";
    colorlist[colorlist.size] = "o";
    return colorlist;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x1e05d72e, Offset: 0x2228
// Size: 0x26c
function get_colorcodes_from_trigger(color_team, team) {
    colorcodes = strtok(color_team, " ");
    colors = [];
    colorcodesbycolorindex = [];
    usable_colorcodes = [];
    colorlist = get_color_list();
    for (i = 0; i < colorcodes.size; i++) {
        var_e28d72e9 = "";
        if (strstartswith(colorcodes[i], "pf")) {
            var_e28d72e9 = "_";
        }
        color = undefined;
        for (p = 0; p < colorlist.size; p++) {
            if (issubstr(colorcodes[i], var_e28d72e9 + colorlist[p])) {
                color = colorlist[p];
                break;
            }
        }
        if (!isdefined(level.arrays_of_colorcoded_nodes[team][colorcodes[i]]) && !isdefined(level.colorcoded_volumes[team][colorcodes[i]])) {
            continue;
        }
        assert(isdefined(color), "<dev string:x170>" + self getorigin() + "<dev string:x186>" + colorcodes[i]);
        colorcodesbycolorindex[color] = colorcodes[i];
        colors[colors.size] = color;
        usable_colorcodes[usable_colorcodes.size] = colorcodes[i];
    }
    colorcodes = usable_colorcodes;
    array = [];
    array[#"colorcodes"] = colorcodes;
    array[#"colorcodesbycolorindex"] = colorcodesbycolorindex;
    array[#"colors"] = colors;
    return array;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x55cad47d, Offset: 0x24a0
// Size: 0x140
function trigger_issues_orders(color_team, team) {
    self endon(#"death");
    array = get_colorcodes_from_trigger(color_team, team);
    colorcodes = array[#"colorcodes"];
    colorcodesbycolorindex = array[#"colorcodesbycolorindex"];
    colors = array[#"colors"];
    for (;;) {
        self waittill(#"trigger");
        if (isdefined(self.activated_color_trigger)) {
            self.activated_color_trigger = undefined;
            continue;
        }
        if (!isdefined(self.color_enabled) || isdefined(self.color_enabled) && self.color_enabled) {
            activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
        }
        waittillframeend();
        trigger_auto_disable();
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xb6abf73a, Offset: 0x25e8
// Size: 0x62
function trigger_auto_disable() {
    if (!isdefined(self.script_color_stay_on)) {
        self.script_color_stay_on = 0;
    }
    if (!isdefined(self.color_enabled)) {
        if (is_true(self.script_color_stay_on)) {
            self.color_enabled = 1;
            return;
        }
        self.color_enabled = 0;
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x232ec428, Offset: 0x2658
// Size: 0xb4
function activate_color_trigger(var_cc966c56) {
    switch (var_cc966c56) {
    case #"allies":
        str_color = self.script_color_allies;
        break;
    case #"axis":
        str_color = self.script_color_axis;
        break;
    case #"team3":
        str_color = self.script_color_team3;
        break;
    default:
        return;
    }
    self thread get_colorcodes_and_activate_trigger(str_color, var_cc966c56);
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x87346903, Offset: 0x2718
// Size: 0xac
function get_colorcodes_and_activate_trigger(color_team, team) {
    array = get_colorcodes_from_trigger(color_team, team);
    colorcodes = array[#"colorcodes"];
    colorcodesbycolorindex = array[#"colorcodesbycolorindex"];
    colors = array[#"colors"];
    activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

// Namespace colors/colors_shared
// Params 4, eflags: 0x0
// Checksum 0xa6b4e6c8, Offset: 0x27d0
// Size: 0x344
function activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex) {
    for (i = 0; i < colorcodes.size; i++) {
        if (!isdefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]])) {
            continue;
        }
        arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colorcodes[i]], undefined);
        for (p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++) {
            level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
        }
    }
    for (i = 0; i < colors.size; i++) {
        function_1eaaceab(level.arrays_of_colorforced_ai[team][colors[i]]);
        level.lastcolorforced[team][colors[i]] = level.currentcolorforced[team][colors[i]];
        level.currentcolorforced[team][colors[i]] = colorcodesbycolorindex[colors[i]];
        assert(isdefined(level.arrays_of_colorcoded_nodes[team][level.currentcolorforced[team][colors[i]]]) || isdefined(level.colorcoded_volumes[team][level.currentcolorforced[team][colors[i]]]), "<dev string:x1a3>" + colors[i] + "<dev string:x1c6>" + team + "<dev string:x1e6>");
    }
    ai_array = [];
    for (i = 0; i < colorcodes.size; i++) {
        if (same_color_code_as_last_time(team, colors[i])) {
            continue;
        }
        colorcode = colorcodes[i];
        if (!isdefined(level.arrays_of_colorcoded_ai[team][colorcode])) {
            continue;
        }
        ai_array[colorcode] = issue_leave_node_order_to_ai_and_get_ai(colorcode, colors[i], team);
    }
    for (i = 0; i < colorcodes.size; i++) {
        colorcode = colorcodes[i];
        if (!isdefined(ai_array[colorcode])) {
            continue;
        }
        if (same_color_code_as_last_time(team, colors[i])) {
            continue;
        }
        if (!isdefined(level.arrays_of_colorcoded_ai[team][colorcode])) {
            continue;
        }
        issue_color_order_to_ai(colorcode, colors[i], team, ai_array[colorcode]);
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x800876c4, Offset: 0x2b20
// Size: 0x54
function same_color_code_as_last_time(team, color) {
    if (!isdefined(level.lastcolorforced[team][color])) {
        return false;
    }
    return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0x81b11a94, Offset: 0x2b80
// Size: 0xfc
function function_f06ea88(node, var_f9350db6, var_cc966c56) {
    switch (var_cc966c56) {
    case #"allies":
        str_color = node.script_color_allies;
        break;
    case #"axis":
        str_color = node.script_color_axis;
        break;
    case #"team3":
        str_color = node.script_color_team3;
        break;
    default:
        return;
    }
    if (issubstr(str_color, var_f9350db6)) {
        self.cover_nodes_last[self.cover_nodes_last.size] = node;
        return;
    }
    self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0xae10614c, Offset: 0x2c88
// Size: 0x34
function process_cover_node(node, *var_f9350db6, *var_cc966c56) {
    self.cover_nodes_first[self.cover_nodes_first.size] = var_cc966c56;
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0x5de582f5, Offset: 0x2cc8
// Size: 0x34
function process_path_node(node, *var_f9350db6, *var_cc966c56) {
    self.path_nodes[self.path_nodes.size] = var_cc966c56;
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0xfcb36a86, Offset: 0x2d08
// Size: 0x1ba
function prioritize_colorcoded_nodes(team, colorcode, color) {
    nodes = level.arrays_of_colorcoded_nodes[team][colorcode];
    if (!isdefined(nodes)) {
        return;
    }
    ent = spawnstruct();
    ent.path_nodes = [];
    ent.cover_nodes_first = [];
    ent.cover_nodes_last = [];
    lastcolorforced_exists = isdefined(level.lastcolorforced[team][color]);
    for (i = 0; i < nodes.size; i++) {
        node = nodes[i];
        ent [[ level.color_node_type_function[node.type][lastcolorforced_exists] ]](node, level.lastcolorforced[team][color], team);
    }
    ent.cover_nodes_first = array::randomize(ent.cover_nodes_first);
    nodes = ent.cover_nodes_first;
    for (i = 0; i < ent.cover_nodes_last.size; i++) {
        nodes[nodes.size] = ent.cover_nodes_last[i];
    }
    for (i = 0; i < ent.path_nodes.size; i++) {
        nodes[nodes.size] = ent.path_nodes[i];
    }
    level.arrays_of_colorcoded_nodes[team][colorcode] = nodes;
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0x5d554843, Offset: 0x2ed0
// Size: 0xbc
function get_prioritized_colorcoded_nodes(team, colorcode, *color) {
    if (isdefined(level.arrays_of_colorcoded_nodes[colorcode][color])) {
        return level.arrays_of_colorcoded_nodes[colorcode][color];
    }
    if (isdefined(level.colorcoded_volumes[colorcode][color])) {
        if (!isarray(level.colorcoded_volumes[colorcode][color])) {
            return [level.colorcoded_volumes[colorcode][color]];
        }
        return level.colorcoded_volumes[colorcode][color];
    }
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0xce797982, Offset: 0x2f98
// Size: 0x148
function issue_leave_node_order_to_ai_and_get_ai(colorcode, color, team) {
    function_1eaaceab(level.arrays_of_colorcoded_ai[team][colorcode]);
    ai = level.arrays_of_colorcoded_ai[team][colorcode];
    ai = arraycombine(ai, level.arrays_of_colorforced_ai[team][color], 1, 0);
    newarray = [];
    for (i = 0; i < ai.size; i++) {
        if (isdefined(ai[i].currentcolorcode) && ai[i].currentcolorcode == colorcode) {
            continue;
        }
        newarray[newarray.size] = ai[i];
    }
    ai = newarray;
    if (!ai.size) {
        return;
    }
    for (i = 0; i < ai.size; i++) {
        ai[i] left_color_node();
    }
    return ai;
}

// Namespace colors/colors_shared
// Params 4, eflags: 0x0
// Checksum 0x189787bd, Offset: 0x30e8
// Size: 0x2ec
function issue_color_order_to_ai(colorcode, color, team, ai) {
    original_ai_array = ai;
    stack = isdefined(self.script_stack);
    if (!stack) {
        prioritize_colorcoded_nodes(team, colorcode, color);
    }
    nodes = get_prioritized_colorcoded_nodes(team, colorcode, color);
    if (isdefined(nodes) && nodes.size >= 1 && !ispathnode(nodes[0])) {
        for (i = 0; i < ai.size; i++) {
            ai[i] take_color_node(nodes[i % nodes.size], colorcode, self, i);
        }
        return;
    }
    /#
        level.colornodes_debug_array[team][colorcode] = nodes;
        if (nodes.size < ai.size) {
            println("<dev string:x205>" + ai.size + "<dev string:x235>" + nodes.size + "<dev string:x243>");
        }
    #/
    if (stack) {
        var_a18ec7bc = struct::get(self.target, "targetname");
        nodes = arraysort(nodes, var_a18ec7bc.origin, 1);
    }
    counter = 0;
    ai_count = ai.size;
    for (i = 0; i < nodes.size; i++) {
        node = nodes[i];
        if (isalive(node.color_user)) {
            continue;
        }
        closestai = arraysort(ai, node.origin, 1, 1)[0];
        assert(isalive(closestai));
        arrayremovevalue(ai, closestai);
        closestai take_color_node(node, colorcode, self, counter);
        counter++;
        if (!ai.size) {
            return;
        }
    }
}

// Namespace colors/colors_shared
// Params 4, eflags: 0x0
// Checksum 0xaa48bd8, Offset: 0x33e0
// Size: 0x5c
function take_color_node(node, colorcode, trigger, counter) {
    self notify(#"stop_color_move");
    self.currentcolorcode = colorcode;
    self thread process_color_order_to_ai(node, trigger, counter);
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xa5ca13ee, Offset: 0x3448
// Size: 0xb0
function player_color_node() {
    for (;;) {
        playernode = undefined;
        if (!isdefined(self.node)) {
            waitframe(1);
            continue;
        }
        olduser = self.node.color_user;
        playernode = self.node;
        playernode.color_user = self;
        for (;;) {
            if (!isdefined(self.node)) {
                break;
            }
            if (self.node != playernode) {
                break;
            }
            waitframe(1);
        }
        playernode.color_user = undefined;
        playernode color_node_finds_a_user();
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x98eaa927, Offset: 0x3500
// Size: 0xac
function color_node_finds_a_user() {
    if (isdefined(self.script_color_allies)) {
        color_node_finds_user_from_colorcodes(self.script_color_allies, #"allies");
    }
    if (isdefined(self.script_color_axis)) {
        color_node_finds_user_from_colorcodes(self.script_color_axis, #"axis");
    }
    if (isdefined(self.script_color_team3)) {
        color_node_finds_user_from_colorcodes(self.script_color_team3, #"team3");
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x53e090d7, Offset: 0x35b8
// Size: 0x6c
function color_node_finds_user_from_colorcodes(colorcodestring, team) {
    if (isdefined(self.color_user)) {
        return;
    }
    colorcodes = strtok(colorcodestring, " ");
    array::thread_all_ents(colorcodes, &color_node_finds_user_for_colorcode, team);
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xb109da9a, Offset: 0x3630
// Size: 0x136
function color_node_finds_user_for_colorcode(colorcode, team) {
    color = colorcode[0];
    assert(colorislegit(color), "<dev string:x24e>" + color + "<dev string:x258>");
    if (!isdefined(level.currentcolorforced[team][color])) {
        return;
    }
    if (level.currentcolorforced[team][color] != colorcode) {
        return;
    }
    ai = get_force_color_guys(team, color);
    if (!ai.size) {
        return;
    }
    for (i = 0; i < ai.size; i++) {
        guy = ai[i];
        if (guy occupies_colorcode(colorcode)) {
            continue;
        }
        guy take_color_node(self, colorcode);
        return;
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0xeed10ec0, Offset: 0x3770
// Size: 0x28
function occupies_colorcode(colorcode) {
    if (!isdefined(self.currentcolorcode)) {
        return false;
    }
    return self.currentcolorcode == colorcode;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0xeeeaf3b, Offset: 0x37a0
// Size: 0x64
function ai_sets_goal_with_delay(node) {
    self endon(#"death");
    delay = my_current_node_delays();
    if (delay) {
        wait delay;
    }
    ai_sets_goal(node);
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x692dde6b, Offset: 0x3810
// Size: 0x94
function ai_sets_goal(node) {
    self notify(#"stop_going_to_node");
    set_goal_and_volume(node);
    if (is_true(self.script_careful)) {
        volume = level.colorcoded_volumes[self.team][self.currentcolorcode];
        self thread function_e4e541a8(node, volume);
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x3c146086, Offset: 0x38b0
// Size: 0x172
function set_goal_and_volume(node) {
    if (isdefined(self._colors_go_line)) {
        self notify(#"colors_go_line_done");
        self._colors_go_line = undefined;
    }
    if (is_true(node.radius)) {
        self.goalradius = node.radius;
    } else if (isdefined(level.var_a6112e7)) {
        self.goalradius = level.var_a6112e7;
    }
    if (is_true(node.script_forcegoal)) {
        self thread color_force_goal(node);
    } else {
        self ai::set_goal_node(node);
    }
    volume = level.colorcoded_volumes[self.team][self.currentcolorcode];
    if (isdefined(volume)) {
        self ai::set_goal_ent(volume);
    }
    if (isdefined(node.fixednodesaferadius)) {
        self.fixednodesaferadius = node.fixednodesaferadius;
        return;
    }
    if (isdefined(level.fixednodesaferadius_default)) {
        self.fixednodesaferadius = level.fixednodesaferadius_default;
        return;
    }
    self.fixednodesaferadius = 64;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x37c378fe, Offset: 0x3a30
// Size: 0x86
function color_force_goal(node) {
    self endon(#"death");
    self thread ai::force_goal(node, 1, "stop_color_forcegoal", 1);
    self waittill(#"goal", #"stop_color_move");
    self notify(#"stop_color_forcegoal");
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xc2990ce6, Offset: 0x3ac0
// Size: 0x2a
function my_current_node_delays() {
    if (!isdefined(self.node)) {
        return 0;
    }
    return self.node util::script_delay();
}

// Namespace colors/colors_shared
// Params 3, eflags: 0x0
// Checksum 0x60ac56ee, Offset: 0x3af8
// Size: 0x218
function process_color_order_to_ai(node, trigger, counter) {
    thread decrementcolorusers(node);
    self endon(#"stop_color_move", #"death");
    if (isdefined(trigger)) {
        trigger util::script_delay();
    }
    if (isdefined(trigger)) {
        if (isdefined(trigger.script_flag_wait)) {
            level flag::wait_till(trigger.script_flag_wait);
        }
    }
    if (!my_current_node_delays()) {
        if (isdefined(counter)) {
            wait counter * randomfloatrange(0.2, 0.35);
        }
    }
    self ai_sets_goal(node);
    self.color_ordered_node_assignment = node;
    for (;;) {
        waitresult = self waittill(#"node_taken");
        if (waitresult.taker == self) {
            waitframe(1);
        }
        node = get_best_available_new_colored_node();
        if (isdefined(node)) {
            assert(!isalive(node.color_user), "<dev string:x269>");
            if (isalive(self.color_node.color_user) && self.color_node.color_user == self) {
                self.color_node.color_user = undefined;
            }
            self.color_node = node;
            node.color_user = self;
            self ai_sets_goal(node);
        }
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x4d5f4f80, Offset: 0x3d18
// Size: 0x14e
function get_best_available_colored_node() {
    assert(self.team != #"neutral");
    assert(isdefined(self.script_forcecolor), "<dev string:x11b>" + self.export + "<dev string:x289>");
    colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
    nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
    assert(nodes.size > 0, "<dev string:x2b3>" + self.export + "<dev string:x2d5>" + self.script_forcecolor + "<dev string:x2eb>");
    for (i = 0; i < nodes.size; i++) {
        if (!isalive(nodes[i].color_user)) {
            return nodes[i];
        }
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x6fdcfd02, Offset: 0x3e70
// Size: 0x16e
function get_best_available_new_colored_node() {
    assert(self.team != #"neutral");
    assert(isdefined(self.script_forcecolor), "<dev string:x11b>" + self.export + "<dev string:x289>");
    colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
    nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
    assert(nodes.size > 0, "<dev string:x2b3>" + self.export + "<dev string:x2d5>" + self.script_forcecolor + "<dev string:x2eb>");
    nodes = arraysort(nodes, self.origin);
    for (i = 0; i < nodes.size; i++) {
        if (!isalive(nodes[i].color_user)) {
            return nodes[i];
        }
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x91c24758, Offset: 0x3fe8
// Size: 0xcc
function process_stop_short_of_node(node) {
    self endon(#"stopscript", #"death");
    if (isdefined(self.node)) {
        return;
    }
    if (distancesquared(node.origin, self.origin) < 1024) {
        reached_node_but_could_not_claim_it(node);
        return;
    }
    currenttime = gettime();
    wait_for_killanimscript_or_time(1);
    newtime = gettime();
    if (newtime - currenttime >= 1000) {
        reached_node_but_could_not_claim_it(node);
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x6db8fac0, Offset: 0x40c0
// Size: 0x26
function wait_for_killanimscript_or_time(timer) {
    self endon(#"killanimscript");
    wait timer;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x399e846c, Offset: 0x40f0
// Size: 0xb6
function reached_node_but_could_not_claim_it(node) {
    ai = getaiarray();
    for (i = 0; i < ai.size; i++) {
        if (!isdefined(ai[i].node)) {
            continue;
        }
        if (ai[i].node != node) {
            continue;
        }
        ai[i] notify(#"eject_from_my_node");
        wait 1;
        self notify(#"eject_from_my_node");
        return true;
    }
    return false;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x566efc14, Offset: 0x41b0
// Size: 0x6a
function decrementcolorusers(node) {
    node.color_user = self;
    self.color_node = node;
    /#
        self.color_node_debug_val = 1;
    #/
    self endon(#"stop_color_move");
    self waittill(#"death");
    self.color_node.color_user = undefined;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x108fd84f, Offset: 0x4228
// Size: 0x52
function colorislegit(color) {
    for (i = 0; i < level.colorlist.size; i++) {
        if (color == level.colorlist[i]) {
            return true;
        }
    }
    return false;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xd6b108ec, Offset: 0x4288
// Size: 0x126
function add_volume_to_global_arrays(colorcode, team) {
    colors = strtok(colorcode, " ");
    for (p = 0; p < colors.size; p++) {
        assert(!isdefined(level.colorcoded_volumes[team][colors[p]]), "<dev string:x31c>" + colors[p]);
        level.colorcoded_volumes[team][colors[p]] = self;
        if (!isdefined(level.arrays_of_colorcoded_ai[team][colors[p]])) {
            level.arrays_of_colorcoded_ai[team][colors[p]] = [];
        }
        if (!isdefined(level.arrays_of_colorcoded_spawners[team][colors[p]])) {
            level.arrays_of_colorcoded_spawners[team][colors[p]] = [];
        }
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xab5f9910, Offset: 0x43b8
// Size: 0x1be
function add_node_to_global_arrays(colorcode, team) {
    self.color_user = undefined;
    colors = strtok(colorcode, " ");
    for (p = 0; p < colors.size; p++) {
        if (isdefined(level.arrays_of_colorcoded_nodes[team]) && isdefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
            if (!isdefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
                level.arrays_of_colorcoded_nodes[team][colors[p]] = [];
            } else if (!isarray(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
                level.arrays_of_colorcoded_nodes[team][colors[p]] = array(level.arrays_of_colorcoded_nodes[team][colors[p]]);
            }
            level.arrays_of_colorcoded_nodes[team][colors[p]][level.arrays_of_colorcoded_nodes[team][colors[p]].size] = self;
            continue;
        }
        level.arrays_of_colorcoded_nodes[team][colors[p]][0] = self;
        level.arrays_of_colorcoded_ai[team][colors[p]] = [];
        level.arrays_of_colorcoded_spawners[team][colors[p]] = [];
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xb281fd2b, Offset: 0x4580
// Size: 0x76
function left_color_node() {
    /#
        self.color_node_debug_val = undefined;
    #/
    if (!isdefined(self.color_node)) {
        return;
    }
    if (isdefined(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
    }
    self.color_node = undefined;
    self notify(#"stop_color_move");
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x1872ac3d, Offset: 0x4600
// Size: 0x114
function removespawnerfromcolornumberarray() {
    switch (self.team) {
    case #"allies":
        str_color = self.script_color_allies;
        break;
    case #"axis":
        str_color = self.script_color_axis;
        break;
    case #"team3":
        str_color = self.script_color_team3;
        break;
    default:
        return;
    }
    if (!isdefined(str_color)) {
        return;
    }
    a_str_colors = strtok(str_color, " ");
    for (i = 0; i < a_str_colors.size; i++) {
        arrayremovevalue(level.arrays_of_colorcoded_spawners[self.team][a_str_colors[i]], self);
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0xada13c6b, Offset: 0x4720
// Size: 0x4e
function add_cover_node(type) {
    level.color_node_type_function[type][1] = &function_f06ea88;
    level.color_node_type_function[type][0] = &process_cover_node;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0xfe8c1d77, Offset: 0x4778
// Size: 0x4e
function add_path_node(type) {
    level.color_node_type_function[type][1] = &process_path_node;
    level.color_node_type_function[type][0] = &process_path_node;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x727b0527, Offset: 0x47d0
// Size: 0x310
function colornode_spawn_reinforcement(classname, fromcolor) {
    level endon(#"kill_color_replacements");
    friendly_spawners_type = getclasscolorhash(classname, fromcolor);
    while (level.friendly_spawners_types[friendly_spawners_type] > 0) {
        spawn = undefined;
        for (;;) {
            if (!level flag::get("respawn_friendlies")) {
                if (!isdefined(level.friendly_respawn_vision_checker_thread)) {
                    thread friendly_spawner_vision_checker();
                }
                for (;;) {
                    level flag::wait_till_any(array("player_looks_away_from_spawner", "respawn_friendlies"));
                    level flag::wait_till_clear("friendly_spawner_locked");
                    if (level flag::get("player_looks_away_from_spawner") || level flag::get("respawn_friendlies")) {
                        break;
                    }
                }
                level flag::set("friendly_spawner_locked");
            }
            spawner = get_color_spawner(classname, fromcolor);
            spawner.count = 1;
            level.friendly_spawners_types[friendly_spawners_type] = level.friendly_spawners_types[friendly_spawners_type] - 1;
            spawner util::script_wait();
            spawn = spawner spawner::spawn();
            if (spawner::spawn_failed(spawn)) {
                thread lock_spawner_for_awhile();
                wait 1;
                continue;
            }
            level notify(#"reinforcement_spawned", {#entity:spawn});
            break;
        }
        for (;;) {
            if (!isdefined(fromcolor)) {
                break;
            }
            if (get_color_from_order(fromcolor, level.current_color_order) == "none") {
                break;
            }
            fromcolor = level.current_color_order[fromcolor];
        }
        if (isdefined(fromcolor)) {
            spawn set_force_color(fromcolor);
        }
        thread lock_spawner_for_awhile();
        if (isdefined(level.friendly_startup_thread)) {
            spawn thread [[ level.friendly_startup_thread ]]();
        }
        spawn thread colornode_replace_on_death();
    }
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x8f8042ee, Offset: 0x4ae8
// Size: 0x3da
function colornode_replace_on_death() {
    level endon(#"kill_color_replacements");
    assert(isalive(self), "<dev string:x34c>");
    self endon(#"_disable_reinforcement");
    if (self.team == #"axis") {
        return;
    }
    if (isdefined(self.replace_on_death)) {
        return;
    }
    self.replace_on_death = 1;
    assert(!isdefined(self.respawn_on_death), "<dev string:x38c>" + self.export + "<dev string:x3a0>");
    classname = self.classname;
    color = self.script_forcecolor;
    waittillframeend();
    if (isalive(self)) {
        self waittill(#"death");
    }
    color_order = level.current_color_order;
    if (!isdefined(self.script_forcecolor)) {
        return;
    }
    friendly_spawners_type = getclasscolorhash(classname, self.script_forcecolor);
    if (!isdefined(level.friendly_spawners_types) || !isdefined(level.friendly_spawners_types[friendly_spawners_type]) || level.friendly_spawners_types[friendly_spawners_type] <= 0) {
        level.friendly_spawners_types[friendly_spawners_type] = 1;
        thread colornode_spawn_reinforcement(classname, self.script_forcecolor);
    } else {
        level.friendly_spawners_types[friendly_spawners_type] = level.friendly_spawners_types[friendly_spawners_type] + 1;
    }
    if (isdefined(self) && isdefined(self.script_forcecolor)) {
        color = self.script_forcecolor;
    }
    if (isdefined(self) && isdefined(self.origin)) {
        origin = self.origin;
    }
    for (;;) {
        if (get_color_from_order(color, color_order) == "none") {
            return;
        }
        correct_colored_friendlies = get_force_color_guys(#"allies", color_order[color]);
        correct_colored_friendlies = array::filter_classname(correct_colored_friendlies, 1, classname);
        if (!correct_colored_friendlies.size) {
            wait 2;
            continue;
        }
        players = getplayers();
        correct_colored_guy = arraysort(correct_colored_friendlies, players[0].origin, 1)[0];
        assert(correct_colored_guy.script_forcecolor != color, "<dev string:x3c9>" + color + "<dev string:x3e0>");
        waittillframeend();
        if (!isalive(correct_colored_guy)) {
            continue;
        }
        correct_colored_guy set_force_color(color);
        if (isdefined(level.friendly_promotion_thread)) {
            correct_colored_guy [[ level.friendly_promotion_thread ]](color);
        }
        color = color_order[color];
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0x30dbf583, Offset: 0x4ed0
// Size: 0x4e
function get_color_from_order(color, color_order) {
    if (!isdefined(color)) {
        return "none";
    }
    if (!isdefined(color_order)) {
        return "none";
    }
    if (!isdefined(color_order[color])) {
        return "none";
    }
    return color_order[color];
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xc4dbd30b, Offset: 0x4f28
// Size: 0x208
function friendly_spawner_vision_checker() {
    level.friendly_respawn_vision_checker_thread = 1;
    successes = 0;
    for (;;) {
        level flag::wait_till_clear("respawn_friendlies");
        wait 1;
        if (!isdefined(level.respawn_spawner)) {
            continue;
        }
        spawner = level.respawn_spawner;
        players = getplayers();
        player_sees_spawner = 0;
        for (q = 0; q < players.size; q++) {
            difference_vec = players[q].origin - spawner.origin;
            if (length(difference_vec) < 200) {
                player_sees_spawner();
                player_sees_spawner = 1;
                break;
            }
            forward = anglestoforward((0, players[q] getplayerangles()[1], 0));
            difference = vectornormalize(difference_vec);
            dot = vectordot(forward, difference);
            if (dot < 0.2) {
                player_sees_spawner();
                player_sees_spawner = 1;
                break;
            }
            successes++;
            if (successes < 3) {
            }
        }
        if (player_sees_spawner) {
            continue;
        }
        level flag::set("player_looks_away_from_spawner");
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xda2ee63a, Offset: 0x5138
// Size: 0x242
function get_color_spawner(classname, fromcolor) {
    specificfromcolor = 0;
    if (isdefined(level.respawn_spawners_specific) && isdefined(level.respawn_spawners_specific[fromcolor])) {
        specificfromcolor = 1;
    }
    if (!isdefined(level.respawn_spawner)) {
        if (!isdefined(fromcolor) || !specificfromcolor) {
            assertmsg("<dev string:x406>");
        }
    }
    if (!isdefined(classname)) {
        if (isdefined(fromcolor) && specificfromcolor) {
            return level.respawn_spawners_specific[fromcolor];
        } else {
            return level.respawn_spawner;
        }
    }
    spawners = getentarray("color_spawner", "targetname");
    class_spawners = [];
    for (i = 0; i < spawners.size; i++) {
        class_spawners[spawners[i].classname] = spawners[i];
    }
    spawner = undefined;
    keys = getarraykeys(class_spawners);
    for (i = 0; i < keys.size; i++) {
        if (!issubstr(class_spawners[keys[i]].classname, classname)) {
            continue;
        }
        spawner = class_spawners[keys[i]];
        break;
    }
    if (!isdefined(spawner)) {
        if (isdefined(fromcolor) && specificfromcolor) {
            return level.respawn_spawners_specific[fromcolor];
        } else {
            return level.respawn_spawner;
        }
    }
    if (isdefined(fromcolor) && specificfromcolor) {
        spawner.origin = level.respawn_spawners_specific[fromcolor].origin;
    } else {
        spawner.origin = level.respawn_spawner.origin;
    }
    return spawner;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xba2d3e0, Offset: 0x5388
// Size: 0x46
function getclasscolorhash(classname, fromcolor) {
    classcolorhash = classname;
    if (isdefined(fromcolor)) {
        classcolorhash += "##" + fromcolor;
    }
    return classcolorhash;
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x60204267, Offset: 0x53d8
// Size: 0x44
function lock_spawner_for_awhile() {
    level flag::set("friendly_spawner_locked");
    wait 2;
    level flag::clear("friendly_spawner_locked");
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x4ea6b85d, Offset: 0x5428
// Size: 0x24
function player_sees_spawner() {
    level flag::clear("player_looks_away_from_spawner");
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x2153a400, Offset: 0x5458
// Size: 0x7c
function kill_color_replacements() {
    level flag::clear("friendly_spawner_locked");
    level notify(#"kill_color_replacements");
    level.friendly_spawners_types = undefined;
    ai = getaiarray();
    array::thread_all(ai, &remove_replace_on_death);
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x43cb0765, Offset: 0x54e0
// Size: 0xe
function remove_replace_on_death() {
    self.replace_on_death = undefined;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x53fa111c, Offset: 0x54f8
// Size: 0x26c
function set_force_color(_color) {
    color = shortencolor(_color);
    assert(colorislegit(color), "<dev string:x548>" + color);
    if (!isactor(self) && !isbot(self)) {
        set_force_color_spawner(color);
        return;
    }
    assert(isalive(self), "<dev string:x57c>");
    self.script_color_axis = undefined;
    self.script_color_allies = undefined;
    self.old_forcecolor = undefined;
    if (isdefined(self.script_forcecolor)) {
        arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
    }
    self.script_forcecolor = color;
    if (!isdefined(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor])) {
        level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = [];
    } else if (!isarray(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor])) {
        level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = array(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor]);
    }
    level.arrays_of_colorforced_ai[self.team][self.script_forcecolor][level.arrays_of_colorforced_ai[self.team][self.script_forcecolor].size] = self;
    level thread remove_colorforced_ai_when_dead(self);
    self thread new_color_being_set(color);
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x568c2fab, Offset: 0x5770
// Size: 0x74
function remove_colorforced_ai_when_dead(ai) {
    script_forcecolor = ai.script_forcecolor;
    team = ai.team;
    ai waittill(#"death");
    arrayremovevalue(level.arrays_of_colorforced_ai[team][script_forcecolor], undefined);
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x7c55c707, Offset: 0x57f0
// Size: 0x6c
function shortencolor(color) {
    assert(isdefined(level.colorchecklist[tolower(color)]), "<dev string:x548>" + color);
    return level.colorchecklist[tolower(color)];
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x47ba2eb8, Offset: 0x5868
// Size: 0x22
function set_force_color_spawner(color) {
    self.script_forcecolor = color;
    self.old_forcecolor = undefined;
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x0
// Checksum 0x4d8643a8, Offset: 0x5898
// Size: 0xd4
function new_color_being_set(*color) {
    self notify(#"new_color_being_set");
    self.new_force_color_being_set = 1;
    left_color_node();
    self endon(#"new_color_being_set", #"death");
    waittillframeend();
    waittillframeend();
    if (isdefined(self.script_forcecolor)) {
        self.currentcolorcode = level.currentcolorforced[self.team][self.script_forcecolor];
        self thread goto_current_colorindex();
    }
    self.new_force_color_being_set = undefined;
    self notify(#"done_setting_new_color");
    /#
        update_debug_friendlycolor();
    #/
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x414c83d0, Offset: 0x5978
// Size: 0x120
function update_debug_friendlycolor_on_death() {
    self notify(#"debug_color_update");
    self endon(#"debug_color_update");
    self waittill(#"death");
    /#
        foreach (n_key, v in level.debug_color_friendlies) {
            ai = getentbynum(n_key);
            if (!isalive(ai)) {
                arrayremoveindex(level.debug_color_friendlies, n_key, 1);
            }
        }
    #/
    level notify(#"updated_color_friendlies");
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xf830969a, Offset: 0x5aa0
// Size: 0x80
function update_debug_friendlycolor() {
    self thread update_debug_friendlycolor_on_death();
    if (isdefined(self.script_forcecolor)) {
        level.debug_color_friendlies[self getentitynumber()] = self.script_forcecolor;
    } else {
        level.debug_color_friendlies[self getentitynumber()] = undefined;
    }
    level notify(#"updated_color_friendlies");
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xceba89ba, Offset: 0x5b28
// Size: 0xaa
function has_color() {
    if (self.team == #"allies") {
        return (isdefined(self.script_color_allies) || isdefined(self.script_forcecolor));
    } else if (self.team == #"axis") {
        return (isdefined(self.script_color_axis) || isdefined(self.script_forcecolor));
    } else if (self.team == #"team3") {
        return (isdefined(self.script_color_team3) || isdefined(self.script_forcecolor));
    }
    return false;
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0xbd2901fa, Offset: 0x5be0
// Size: 0x1a
function get_force_color() {
    color = self.script_forcecolor;
    return color;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x0
// Checksum 0xa185698b, Offset: 0x5c08
// Size: 0xb0
function get_force_color_guys(team, color) {
    ai = getaiteamarray(team);
    guys = [];
    for (i = 0; i < ai.size; i++) {
        guy = ai[i];
        if (!isdefined(guy.script_forcecolor)) {
            continue;
        }
        if (guy.script_forcecolor != color) {
            continue;
        }
        guys[guys.size] = guy;
    }
    return guys;
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x37d02794, Offset: 0x5cc0
// Size: 0x90
function get_all_force_color_friendlies() {
    ai = getaiteamarray(#"allies");
    guys = [];
    for (i = 0; i < ai.size; i++) {
        guy = ai[i];
        if (!isdefined(guy.script_forcecolor)) {
            continue;
        }
        guys[guys.size] = guy;
    }
    return guys;
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x23e413a5, Offset: 0x5d58
// Size: 0xe4
function disable() {
    if (isdefined(self.new_force_color_being_set)) {
        self endon(#"death");
        self waittill(#"done_setting_new_color");
    }
    if (!isdefined(self.script_forcecolor)) {
        return;
    }
    assert(!isdefined(self.old_forcecolor), "<dev string:x5b6>");
    self.old_forcecolor = self.script_forcecolor;
    arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
    left_color_node();
    self.script_forcecolor = undefined;
    self.currentcolorcode = undefined;
    /#
        update_debug_friendlycolor();
    #/
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x23118bc3, Offset: 0x5e48
// Size: 0x46
function enable() {
    if (isdefined(self.script_forcecolor)) {
        return;
    }
    if (!isdefined(self.old_forcecolor)) {
        return;
    }
    set_force_color(self.old_forcecolor);
    self.old_forcecolor = undefined;
}

// Namespace colors/colors_shared
// Params 0, eflags: 0x0
// Checksum 0x66b02447, Offset: 0x5e98
// Size: 0x1a
function is_color_ai() {
    return isdefined(self.script_forcecolor) || isdefined(self.old_forcecolor);
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x4
// Checksum 0x63932f69, Offset: 0x5ec0
// Size: 0xe0
function private function_e4e541a8(node, volume) {
    self endon(#"death", #"hash_365fd8fda5a5a322", #"stop_going_to_node");
    if (!isdefined(self.var_69acdce1)) {
        self.var_69acdce1 = self.fixednode;
    }
    thread recover_from_careful_disable(node);
    for (;;) {
        wait_until_an_enemy_is_in_safe_area(node, volume);
        function_7960438b(node, volume);
        function_39d66928(node, volume);
        self.fixednode = self.var_69acdce1;
        set_goal_and_volume(node);
    }
}

// Namespace colors/colors_shared
// Params 1, eflags: 0x4
// Checksum 0x85eb7314, Offset: 0x5fa8
// Size: 0x6c
function private recover_from_careful_disable(node) {
    self endon(#"death", #"stop_going_to_node");
    self waittill(#"hash_365fd8fda5a5a322");
    self.fixednode = self.var_69acdce1;
    self.var_69acdce1 = undefined;
    set_goal_and_volume(node);
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x4
// Checksum 0xafe5d897, Offset: 0x6020
// Size: 0x72
function private function_7960438b(*node, *volume) {
    self setgoal(self.origin);
    if (isdefined(level.var_e81d9a30)) {
        self.goalradius = level.var_e81d9a30;
    } else {
        self.goalradius = 1024;
    }
    self.fixednode = 0;
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x4
// Checksum 0x888b7e22, Offset: 0x60a0
// Size: 0x3a
function private wait_until_an_enemy_is_in_safe_area(node, volume) {
    for (;;) {
        if (function_c73b2e00(node, volume)) {
            return;
        }
        wait 1;
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x4
// Checksum 0xbd28c39b, Offset: 0x60e8
// Size: 0x3a
function private function_39d66928(node, volume) {
    for (;;) {
        if (!function_c73b2e00(node, volume)) {
            return;
        }
        wait 1;
    }
}

// Namespace colors/colors_shared
// Params 2, eflags: 0x4
// Checksum 0x9d870d97, Offset: 0x6130
// Size: 0x88
function private function_c73b2e00(node, volume) {
    assert(isdefined(node));
    if (self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        return true;
    } else if (isdefined(volume) && self isknownenemyinvolume(volume)) {
        return true;
    }
    return false;
}

/#

    // Namespace colors/colors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfc7b1359, Offset: 0x61c0
    // Size: 0x6a
    function insure_player_does_not_set_forcecolor_twice_in_one_frame() {
        assert(!isdefined(self.setforcecolor), "<dev string:x618>");
        self.setforcecolor = 1;
        waittillframeend();
        if (!isalive(self)) {
            return;
        }
        self.setforcecolor = undefined;
    }

#/
