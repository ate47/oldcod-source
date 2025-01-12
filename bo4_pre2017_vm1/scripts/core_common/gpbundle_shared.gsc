#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/cp_common/dialog;

#namespace gpbundle;

// Namespace gpbundle/namespace_1b5b28d4
// Params 0, eflags: 0x2
// Checksum 0x7030c190, Offset: 0x280
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gpbundle", &__init__, undefined, undefined);
}

// Namespace gpbundle/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0x129c38ca, Offset: 0x2c0
// Size: 0x54
function __init__() {
    if (!isdefined(level.var_b461f916)) {
        level.var_b461f916 = [];
    }
    /#
        setup_devgui();
        level thread function_eee6213d();
    #/
}

// Namespace gpbundle/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0x56363c32, Offset: 0x320
// Size: 0x164
function setup_devgui() {
    foreach (var_4baaa193 in level.var_b461f916) {
        var_1dcb5a55 = getscriptbundlenames("gpbundle_" + var_4baaa193);
        for (i = -1; i < var_1dcb5a55.size; i++) {
            if (i == -1) {
                var_5f634aa6 = "clear";
            } else {
                var_5f634aa6 = var_1dcb5a55[i];
            }
            adddebugcommand("devgui_cmd \"gpbundles/" + var_4baaa193 + "/" + var_5f634aa6 + "\" \"set gpbundle_" + var_4baaa193 + " " + var_5f634aa6 + "\"\n");
        }
    }
}

// Namespace gpbundle/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0x6abe34fb, Offset: 0x490
// Size: 0x23c
function function_eee6213d() {
    level flag::wait_till("all_players_spawned");
    host = util::gethostplayer();
    var_4fc647a = [];
    while (true) {
        foreach (i, var_4baaa193 in level.var_b461f916) {
            if (!isdefined(var_4fc647a[i])) {
                var_4fc647a[i] = host openluimenu("HudElementText");
                host setluimenudata(var_4fc647a[i], "x", 100);
                host setluimenudata(var_4fc647a[i], "y", 490 + i * 10);
                host setluimenudata(var_4fc647a[i], "width", 500);
            }
            str_dvar = "gpbundle_" + var_4baaa193;
            var_c222d4b0 = getdvarstring(str_dvar);
            if (var_c222d4b0 == "clear") {
                setdvar(str_dvar, "");
            }
            host setluimenudata(var_4fc647a[i], "text", var_c222d4b0);
        }
        waitframe(1);
    }
}

#namespace namespace_882b2531;

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0x267aa24, Offset: 0x6d8
// Size: 0x94
function __constructor() {
    self.m_str_type = "unknown";
    self.var_c31ba99e = [];
    self.var_5ea3c8e5 = [];
    self.var_ccf6139b = "allies";
    self.var_165c6bb8 = "axis";
    self.var_2e3180df = 0;
    self.var_5d9b0dc0 = 0;
    flag::init("paused");
    flag::init("done");
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0x976f593e, Offset: 0x778
// Size: 0x1c
function __destructor() {
    iprintlnbold("cGPBundle Destructor Called.");
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 1, eflags: 0x0
// Checksum 0x4069031f, Offset: 0x7a0
// Size: 0x58
function function_f4eeb93e(var_5d4164cc) {
    self.var_ccf6139b = var_5d4164cc;
    if (self.var_ccf6139b == "allies") {
        self.var_165c6bb8 = "axis";
        return;
    }
    self.var_165c6bb8 = "allies";
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 2, eflags: 0x0
// Checksum 0x687ea0b5, Offset: 0x800
// Size: 0x1e2
function function_8f863e42(var_585b8e6e, var_e8800af4) {
    if (!isdefined(self.var_5ea3c8e5[var_585b8e6e])) {
        self.var_5ea3c8e5[var_585b8e6e] = spawnstruct();
    }
    if (!isdefined(self.var_5ea3c8e5[var_585b8e6e].var_9a7c87f1)) {
        self.var_5ea3c8e5[var_585b8e6e].var_9a7c87f1 = 0;
    }
    if (!isdefined(self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb)) {
        self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb = [];
    }
    if (!isdefined(self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb)) {
        self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb = [];
    } else if (!isarray(self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb)) {
        self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb = array(self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb);
    }
    if (!isinarray(self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb, var_e8800af4)) {
        self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb[self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb.size] = var_e8800af4;
    }
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 5, eflags: 0x0
// Checksum 0x1e9d3df7, Offset: 0x9f0
// Size: 0x2d0
function function_81daf6da(var_585b8e6e, e_speaker, n_delay, player_or_team, var_25f64208) {
    if (!isdefined(var_25f64208)) {
        var_25f64208 = 0;
    }
    if (!isplayer(e_speaker) && !isai(e_speaker)) {
        e_speaker = level;
    }
    if (!isdefined(self.var_5ea3c8e5[var_585b8e6e])) {
        return;
    }
    if (var_25f64208) {
        var_9a7c87f1 = randomintrange(0, self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb.size);
        self.var_5ea3c8e5[var_585b8e6e].var_9a7c87f1 = var_9a7c87f1;
    } else {
        var_9a7c87f1 = self.var_5ea3c8e5[var_585b8e6e].var_9a7c87f1;
    }
    if (self.var_5ea3c8e5[var_585b8e6e].var_9a7c87f1 >= self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb.size) {
        return;
    }
    var_3e32874d = self.var_5ea3c8e5[var_585b8e6e].var_be15e6bb[var_9a7c87f1];
    wait n_delay;
    if (isplayer(player_or_team)) {
        if (!isalive(player_or_team)) {
            return;
        }
    }
    function_5cf217c3(player_or_team);
    function_c0980f44(player_or_team, 1);
    if (e_speaker == level) {
        e_speaker dialog::remote(var_3e32874d, 0, "dni", player_or_team);
    } else if (e_speaker util::function_4f5dd9d2() && isdefined(e_speaker.owner)) {
        e_speaker.owner dialog::function_fbeb77db(var_3e32874d, 0);
    } else {
        e_speaker dialog::say(var_3e32874d, 0, 1, player_or_team);
    }
    function_c0980f44(player_or_team, 0);
    var_9a7c87f1++;
    self.var_5ea3c8e5[var_585b8e6e].var_9a7c87f1 = var_9a7c87f1;
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 1, eflags: 0x0
// Checksum 0x8b5a27cd, Offset: 0xcc8
// Size: 0xe0
function function_5cf217c3(player_or_team) {
    if (isplayer(player_or_team)) {
        player = player_or_team;
        player endon(#"death");
        while (isdefined(player.var_fe1dbe3a) && player.var_fe1dbe3a) {
            waitframe(1);
        }
        return;
    }
    str_team = player_or_team;
    self endon(#"death");
    if (str_team == self.var_ccf6139b) {
        while (self.var_2e3180df) {
            waitframe(1);
        }
        return;
    }
    while (self.var_5d9b0dc0) {
        waitframe(1);
    }
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 2, eflags: 0x0
// Checksum 0xaef5cc87, Offset: 0xdb0
// Size: 0xa0
function function_c0980f44(player_or_team, b_enable) {
    if (isplayer(player_or_team)) {
        player = player_or_team;
        player.var_fe1dbe3a = b_enable;
        return;
    }
    str_team = player_or_team;
    if (str_team == self.var_ccf6139b) {
        self.var_2e3180df = b_enable;
        return;
    }
    self.var_5d9b0dc0 = b_enable;
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0xa4749311, Offset: 0xe58
// Size: 0x24
function function_250ebce8() {
    /#
        assert("<dev string:x28>");
    #/
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 3, eflags: 0x0
// Checksum 0x2a14d92a, Offset: 0xe88
// Size: 0x1a4
function run(ent, str_bundle, a_vars) {
    self endon(#"death");
    if (!isdefined(str_bundle)) {
        str_bundle = ent.scriptbundlename;
    }
    /#
        var_4baaa193 = "<dev string:x6c>" + tolower(self.m_str_type);
        /#
            assert(isinarray(getscriptbundlenames(var_4baaa193), str_bundle), "<dev string:x76>" + str_bundle + "<dev string:x78>" + var_4baaa193 + "<dev string:x8b>");
        #/
        var_c222d4b0 = getdvarstring(var_4baaa193);
        if (var_c222d4b0 != "<dev string:x8e>") {
            str_bundle = var_c222d4b0;
        }
    #/
    self.m_s_bundle = getscriptbundle(str_bundle);
    init(ent);
    flag::clear("done");
    /#
    #/
    [[ self ]]->function_250ebce8(a_vars);
    flag::set("done");
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 2, eflags: 0x0
// Checksum 0xe8b5c97a, Offset: 0x1038
// Size: 0x8c
function result(str_winning_team, str_reason) {
    if (!isdefined(str_winning_team)) {
        str_winning_team = "none";
    }
    self notify(#"result");
    level notify(self.m_str_type + "_result", {#team:str_winning_team, #reason:str_reason});
    /#
        iprintlnbold(str_reason);
    #/
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0xe42f81f5, Offset: 0x10d0
// Size: 0x56
function print() {
    /#
        self endon(#"death");
        self endon(#"done");
        while (true) {
            iprintlnbold(self.m_str_type + "<dev string:x8f>");
            wait 1;
        }
    #/
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 1, eflags: 0x0
// Checksum 0xff2613d8, Offset: 0x1130
// Size: 0x5c
function init(ent) {
    if (isdefined(ent.o_gpbundle)) {
        [[ ent.o_gpbundle ]]->delete();
    }
    self.var_9c1866c8 = ent;
    self.var_9c1866c8.o_gpbundle = self;
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 1, eflags: 0x0
// Checksum 0x302657ea, Offset: 0x1198
// Size: 0x5c
function pause(b_pause) {
    if (!isdefined(b_pause)) {
        b_pause = 1;
    }
    if (!flag::get("done")) {
        flag::set_val("paused", b_pause);
    }
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 0, eflags: 0x0
// Checksum 0x1bbcc043, Offset: 0x1200
// Size: 0xaa
function delete() {
    self notify(#"death");
    foreach (ent in self.var_c31ba99e) {
        ent sys::delete();
    }
    self.var_9c1866c8.o_gpbundle = undefined;
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 7, eflags: 0x0
// Checksum 0x63220361, Offset: 0x12b8
// Size: 0x1ee
function spawn(var_a541411b, v_origin, v_angles, n_spawnflags, n_height, n_width, n_length) {
    if (!isdefined(v_origin)) {
        v_origin = (0, 0, 0);
    }
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    spawner::global_spawn_throttle();
    e_spawned = undefined;
    if (isspawner(var_a541411b)) {
        e_spawned = var_a541411b spawner::spawn(undefined, undefined, v_origin, v_angles);
    } else if (isassetloaded("aitype", var_a541411b)) {
        e_spawned = spawnactor(var_a541411b, v_origin, v_angles);
    } else {
        e_spawned = sys::spawn(var_a541411b, v_origin, n_spawnflags, n_height, n_width, n_length);
        e_spawned.angles = v_angles;
    }
    if (!isdefined(self.var_c31ba99e)) {
        self.var_c31ba99e = [];
    } else if (!isarray(self.var_c31ba99e)) {
        self.var_c31ba99e = array(self.var_c31ba99e);
    }
    self.var_c31ba99e[self.var_c31ba99e.size] = e_spawned;
    return e_spawned;
}

// Namespace namespace_882b2531/namespace_1b5b28d4
// Params 3, eflags: 0x0
// Checksum 0x592437ad, Offset: 0x14b0
// Size: 0xde
function spawn_vehicle(str_vehicletype, v_origin, v_angles) {
    spawner::global_spawn_throttle();
    e_spawned = spawnvehicle(str_vehicletype, v_origin, v_angles);
    if (!isdefined(self.var_c31ba99e)) {
        self.var_c31ba99e = [];
    } else if (!isarray(self.var_c31ba99e)) {
        self.var_c31ba99e = array(self.var_c31ba99e);
    }
    self.var_c31ba99e[self.var_c31ba99e.size] = e_spawned;
    return e_spawned;
}

#namespace gpbundle;

// Namespace gpbundle/namespace_1b5b28d4
// Params 0, eflags: 0x6
// Checksum 0x4f0de3ee, Offset: 0x1598
// Size: 0x326
function private autoexec function_882b2531() {
    classes.var_882b2531[0] = spawnstruct();
    classes.var_882b2531[0].__vtable[554255087] = &namespace_882b2531::spawn_vehicle;
    classes.var_882b2531[0].__vtable[-1686119842] = &namespace_882b2531::spawn;
    classes.var_882b2531[0].__vtable[-594770940] = &namespace_882b2531::delete;
    classes.var_882b2531[0].__vtable[1689611997] = &namespace_882b2531::pause;
    classes.var_882b2531[0].__vtable[-1017222485] = &namespace_882b2531::init;
    classes.var_882b2531[0].__vtable[1002812482] = &namespace_882b2531::print;
    classes.var_882b2531[0].__vtable[1013039042] = &namespace_882b2531::result;
    classes.var_882b2531[0].__vtable[1328068344] = &namespace_882b2531::run;
    classes.var_882b2531[0].__vtable[621722856] = &namespace_882b2531::function_250ebce8;
    classes.var_882b2531[0].__vtable[-1063776444] = &namespace_882b2531::function_c0980f44;
    classes.var_882b2531[0].__vtable[1559369667] = &namespace_882b2531::function_5cf217c3;
    classes.var_882b2531[0].__vtable[-2116356390] = &namespace_882b2531::function_81daf6da;
    classes.var_882b2531[0].__vtable[-1887027646] = &namespace_882b2531::function_8f863e42;
    classes.var_882b2531[0].__vtable[-185681602] = &namespace_882b2531::function_f4eeb93e;
    classes.var_882b2531[0].__vtable[1606033458] = &namespace_882b2531::__destructor;
    classes.var_882b2531[0].__vtable[-1690805083] = &namespace_882b2531::__constructor;
}

// Namespace gpbundle/namespace_1b5b28d4
// Params 3, eflags: 0x20 variadic
// Checksum 0xe721d9f2, Offset: 0x18c8
// Size: 0x1b8
function start(kvp, str_bundle, ...) {
    str_key = "targetname";
    str_value = kvp;
    if (isarray(kvp)) {
        str_key = kvp[0];
        str_value = kvp[1];
    }
    ent = struct::get(str_value, str_key);
    if (!isdefined(ent)) {
        ent = getent(str_value, str_key);
        if (!isdefined(ent)) {
            /#
                assertmsg("<dev string:x9c>" + str_key + "<dev string:xaf>" + str_value + "<dev string:xb5>");
            #/
            return;
        }
        o_gpbundle = [[ level.var_8dfd1c04["gpbundle_" + ent.var_7ab31d2e] ]]();
    } else {
        s_bundle = getscriptbundle(ent.scriptbundlename);
        o_gpbundle = [[ level.var_8dfd1c04[s_bundle.type] ]]();
    }
    thread [[ o_gpbundle ]]->run(ent, str_bundle, vararg);
    return o_gpbundle;
}

