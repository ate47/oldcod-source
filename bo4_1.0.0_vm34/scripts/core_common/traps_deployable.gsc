#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\weapons\trapd;
#using scripts\weapons\weaponobjects;

#namespace traps_deployable;

// Namespace traps_deployable
// Method(s) 3 Total 3
class class_7ba2d16c {

    var j_cosmetic_cowl_lefte;
    var m_empdamage;
    var m_health;
    var m_name;
    var m_placeimmediately;
    var m_spawnsentity;
    var m_timeout;
    var m_type;
    var m_vehicle;
    var m_weapon;
    var var_16cba53b;
    var var_225ff2b0;
    var var_48eae6c;
    var var_5eb6505e;
    var var_a867507e;
    var var_bf2eadc7;
    var var_f2b86855;
    var var_fc3951f2;

    // Namespace class_7ba2d16c/traps_deployable
    // Params 0, eflags: 0x10
    // Checksum 0x5d44cb46, Offset: 0x4868
    // Size: 0x4c
    destructor() {
        /#
            if (isdefined(level.trapddebug) && level.trapddebug) {
                iprintlnbold("<dev string:x324>" + m_name);
            }
        #/
    }

    // Namespace namespace_7ba2d16c/traps_deployable
    // Params 2, eflags: 0x0
    // Checksum 0x3a686e71, Offset: 0x48c0
    // Size: 0x19e
    function function_2a20d82d(bundle, var_c59c6b7c) {
        m_type = bundle.trap_type;
        m_name = bundle.name;
        m_weapon = bundle.weapon;
        m_vehicle = bundle.vehicle;
        j_cosmetic_cowl_lefte = bundle.model;
        var_48eae6c = bundle.var_b5928ebf;
        var_f2b86855 = bundle.var_4954bdf4;
        m_spawnsentity = bundle.spawnsentity;
        var_fc3951f2 = bundle.str_pickup;
        m_timeout = bundle.timeout;
        m_health = bundle.health;
        if (isdefined(m_health)) {
            var_5eb6505e = m_health - int(m_health / 3);
        }
        m_empdamage = bundle.empdamage;
        var_a867507e = bundle.str_place;
        var_bf2eadc7 = bundle.var_5791bb8;
        m_placeimmediately = bundle.placeimmediately;
        var_16cba53b = bundle.var_9126f4a7;
        var_225ff2b0 = var_c59c6b7c;
    }

}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x2
// Checksum 0x3c4b93c7, Offset: 0x228
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"traps_deployable", &__init__, undefined, #"load");
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0xd32e985e, Offset: 0x278
// Size: 0x34
function __init__() {
    callback::on_spawned(&on_player_spawned);
    thread init_traps();
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0x154f2f7a, Offset: 0x2b8
// Size: 0x3c
function on_player_spawned() {
    if (!isdefined(level._traps_deployable)) {
        return;
    }
    player = self;
    player owner_init();
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0xbe6c6c36, Offset: 0x300
// Size: 0x6e
function owner_init() {
    owner = self;
    if (!isdefined(owner._traps_deployable)) {
        owner._traps_deployable = spawnstruct();
    }
    if (!isdefined(owner._traps_deployable.watchers_init)) {
        owner._traps_deployable.watchers_init = [];
    }
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0x5b118dd9, Offset: 0x378
// Size: 0x36
function function_b858a8ac() {
    return isdefined(self._traps_deployable) && isdefined(self._traps_deployable.var_b858a8ac) && self._traps_deployable.var_b858a8ac;
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0x299c5d37, Offset: 0x3b8
// Size: 0x2c
function init_traps() {
    function_3c957692();
    /#
        thread debug_init();
    #/
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0xc587143b, Offset: 0x3f0
// Size: 0x3a0
function function_3c957692() {
    level flag::wait_till("all_players_spawned");
    var_a9058c43 = struct::get_script_bundle_instances("traps_deployable");
    foreach (var_14719aa8 in var_a9058c43) {
        if (isdefined(var_14719aa8.scriptbundlename)) {
            var_91116198 = struct::get_script_bundle("traps_deployable", var_14719aa8.scriptbundlename);
            if (isdefined(var_91116198)) {
                var_c59c6b7c = spawnstruct();
                if (isdefined(var_14719aa8.script_team) && var_14719aa8.script_team != #"none") {
                    var_c59c6b7c.team = var_14719aa8.script_team;
                } else {
                    var_c59c6b7c.team = #"any";
                }
                var_c59c6b7c.origin = var_14719aa8.origin;
                var_c59c6b7c.angles = var_14719aa8.angles;
                var_c59c6b7c.model = var_14719aa8.model;
                gameobject = var_91116198.gameobject;
                if (isdefined(var_14719aa8.scriptbundle_gameobject_override)) {
                    gameobject = var_14719aa8.scriptbundle_gameobject_override;
                }
                var_c59c6b7c.var_88a55a79 = var_14719aa8.script_objective;
                var_c59c6b7c.var_ad2d28ea = var_14719aa8.var_f6efc3f3;
                var_c59c6b7c.gameobject = gameobject;
                if (var_c59c6b7c register_trap(var_91116198)) {
                    var_14719aa8.var_c59c6b7c = var_c59c6b7c;
                    if (!(isdefined(var_14719aa8.script_enable_on_start) && var_14719aa8.script_enable_on_start)) {
                        var_c59c6b7c gameobjects::disable_object(1);
                    }
                    if (isdefined(var_14719aa8.script_autoactivate_trap) && var_14719aa8.script_autoactivate_trap) {
                        if (isdefined(var_14719aa8.script_waittill)) {
                            var_14719aa8 thread function_e03eea30(var_c59c6b7c.mdl_gameobject.var_4eec1895);
                        }
                        var_14719aa8 thread function_92500b20(var_c59c6b7c.mdl_gameobject.var_4eec1895);
                    }
                    level function_1ca4a6bd(var_14719aa8.var_f6efc3f3);
                    /#
                        var_14719aa8 function_174fb1f0();
                    #/
                }
            } else {
                /#
                    printerror("<dev string:x30>" + var_14719aa8.scriptbundlename);
                #/
            }
            continue;
        }
        /#
            printerror("<dev string:x67>");
        #/
    }
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x1ea73f79, Offset: 0x798
// Size: 0x3b6
function register_trap(var_91116198) {
    var_c59c6b7c = self;
    if (isdefined(var_91116198) && isdefined(var_91116198.trap_type)) {
        switch (var_91116198.trap_type) {
        case #"generic":
            function_9c16f28f(var_91116198.trap_type, &function_f164c5aa, &function_61dc4801, &function_7e0ee388, &function_60a71cd, &function_6385b051, &function_120938b8, &function_f7a2ee23);
            break;
        case #"fire_bomb":
        case #"flash_disruptor":
        case #"mine":
        case #"claymore":
            function_9c16f28f(var_91116198.trap_type, &function_b53cd5c1, &function_61dc4801, &function_7e0ee388, &function_60a71cd, &function_39d36c84, &function_120938b8, &function_153e9a9d);
            break;
        case #"guardian":
        case #"turret":
            function_9c16f28f(var_91116198.trap_type, &function_4a7c8a4f, &function_61dc4801, &function_e15d911f, &function_60a71cd, &function_adf1b4e2, &function_120938b8, &function_153e9a9d);
            break;
        case #"vehicle":
            function_9c16f28f(var_91116198.trap_type, &function_e7324ebb, &function_61dc4801, &function_f2935d63, &function_f19ceb4e, &function_f90068e6, &function_120938b8, &function_153e9a9d);
            break;
        default:
            assertmsg("<dev string:x9a>" + var_91116198.trap_type);
            /#
                printerror("<dev string:xbd>");
            #/
            return;
        }
        if (var_c59c6b7c function_c60891e7(var_91116198)) {
            return 1;
        }
    }
    /#
        printerror("<dev string:xe6>");
    #/
    return 0;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x287de5c4, Offset: 0xb58
// Size: 0xde
function function_c60891e7(var_91116198) {
    var_c59c6b7c = self;
    if (isdefined(var_91116198.gameobject)) {
        var_4eec1895 = new class_7ba2d16c();
        [[ var_4eec1895 ]]->function_2a20d82d(var_91116198, var_c59c6b7c);
        var_c59c6b7c function_8ac48505(var_4eec1895, var_c59c6b7c.origin, var_c59c6b7c.angles);
        /#
            printinfo("<dev string:x11a>" + var_91116198.name);
        #/
        return true;
    }
    /#
        printerror("<dev string:x13d>");
    #/
    return false;
}

// Namespace traps_deployable/traps_deployable
// Params 4, eflags: 0x0
// Checksum 0x51aa2fb, Offset: 0xc40
// Size: 0x224
function function_8ac48505(var_4eec1895, origin, angles, var_eac0a151 = undefined) {
    var_c59c6b7c = self;
    model = var_4eec1895.j_cosmetic_cowl_lefte;
    if (isdefined(var_4eec1895.var_225ff2b0.model)) {
    }
    var_3318f93e = undefined;
    if (isdefined(model)) {
        var_3318f93e = util::spawn_model(model, origin, angles);
    }
    if (isdefined(origin) && isdefined(angles)) {
        var_c59c6b7c.origin = origin;
        var_c59c6b7c.angles = angles;
    }
    var_c59c6b7c gameobjects::init_game_objects(var_c59c6b7c.gameobject, var_c59c6b7c.team, 0, undefined, var_3318f93e);
    var_c59c6b7c gameobjects::set_onuse_event(&function_f39a3ee5);
    if (isdefined(var_c59c6b7c.mdl_gameobject.trigger) && !(isdefined(var_c59c6b7c.mdl_gameobject.trigger.var_198df85d) && var_c59c6b7c.mdl_gameobject.trigger.var_198df85d)) {
        var_c59c6b7c.mdl_gameobject gameobjects::set_use_hint_text(var_4eec1895.var_fc3951f2);
    }
    var_c59c6b7c.mdl_gameobject.trigger usetriggerrequirelookat();
    if (isdefined(var_eac0a151)) {
        var_c59c6b7c.mdl_gameobject.b_reusable = 0;
    }
    var_c59c6b7c.mdl_gameobject.var_4eec1895 = var_4eec1895;
    var_4eec1895 function_df46a340(var_c59c6b7c.mdl_gameobject);
}

// Namespace traps_deployable/traps_deployable
// Params 8, eflags: 0x0
// Checksum 0x33d59439, Offset: 0xe70
// Size: 0x144
function function_9c16f28f(type, onplacecallback, oncancelcallback, onmovecallback, var_985ca15, var_8fbb774, ondamagecallback, damagewrapper) {
    if (function_b3465089(type)) {
        return;
    }
    function_7f5b9560(type);
    function_4bd22b39(type, onplacecallback);
    function_a267285e(type, oncancelcallback);
    function_4f444287(type, onmovecallback);
    function_e86d7853(type, ondamagecallback);
    function_d7e543c2(type, var_985ca15);
    function_752b536b(type, var_8fbb774);
    function_5bdf52a1(type, damagewrapper);
    /#
        printinfo("<dev string:x164>" + type);
    #/
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x34a58bb7, Offset: 0xfc0
// Size: 0x50
function function_b3465089(type) {
    return isdefined(level._traps_deployable) && isdefined(level._traps_deployable.traptypes) && isdefined(level._traps_deployable.traptypes[type]);
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x142c2778, Offset: 0x1018
// Size: 0xa2
function function_7f5b9560(type) {
    if (!isdefined(level._traps_deployable)) {
        level._traps_deployable = spawnstruct();
    }
    if (!isdefined(level._traps_deployable.traptypes)) {
        level._traps_deployable.traptypes = [];
    }
    if (!isdefined(level._traps_deployable.traptypes[type])) {
        level._traps_deployable.traptypes[type] = spawnstruct();
    }
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0xfb3b70ac, Offset: 0x10c8
// Size: 0x70
function add_callback(type, callbackname, callbackfunc) {
    if (function_b3465089(type)) {
        if (isdefined(callbackname) && isdefined(callbackfunc)) {
            level._traps_deployable.traptypes[type].(callbackname) = callbackfunc;
        }
    }
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0x751f1601, Offset: 0x1140
// Size: 0x34
function function_4bd22b39(type, callback) {
    add_callback(type, "onPlaceCallback", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0x112762d1, Offset: 0x1180
// Size: 0x34
function function_a267285e(type, callback) {
    add_callback(type, "onCancelCallback", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0x96ac1408, Offset: 0x11c0
// Size: 0x34
function function_4f444287(type, callback) {
    add_callback(type, "onMoveCallback", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0xeb8a7b85, Offset: 0x1200
// Size: 0x34
function function_d7e543c2(type, callback) {
    add_callback(type, "onActivateTrap", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0x6a316dd2, Offset: 0x1240
// Size: 0x34
function function_752b536b(type, callback) {
    add_callback(type, "onAutoActivateTrap", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0xdb321e58, Offset: 0x1280
// Size: 0x34
function function_e86d7853(type, callback) {
    add_callback(type, "onDamageCallback", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0xcc15ab28, Offset: 0x12c0
// Size: 0x34
function function_5bdf52a1(type, callback) {
    add_callback(type, "damageWrapper", callback);
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x74caebe1, Offset: 0x1300
// Size: 0x54
function function_f39a3ee5(e_player) {
    e_gameobject = self;
    e_player thread activate_trap(e_gameobject.var_4eec1895, e_gameobject.origin, e_gameobject.angles);
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0x178cd7bb, Offset: 0x1360
// Size: 0x16a
function function_f2907c5(origin, team) {
    actorteam = team;
    if (actorteam == #"any") {
        actorteam = "all";
    }
    owners = getactorteamarray(actorteam);
    foreach (player in level.players) {
        if (player.team == team || team == #"any") {
            if (!isdefined(owners)) {
                owners = [];
            } else if (!isarray(owners)) {
                owners = array(owners);
            }
            owners[owners.size] = player;
        }
    }
    owner = arraygetclosest(origin, owners);
    return owner;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xacff94f1, Offset: 0x14d8
// Size: 0xbc
function function_29220163(team) {
    if (!isdefined(level._traps_deployable.team_owners)) {
        level._traps_deployable.team_owners = [];
    }
    if (!isdefined(level._traps_deployable.team_owners[team])) {
        level._traps_deployable.team_owners[team] = spawn("script_origin", (0, 0, 0));
    }
    level._traps_deployable.team_owners[team].team = team;
    return level._traps_deployable.team_owners[team];
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x1f85fbd3, Offset: 0x15a0
// Size: 0x134
function function_92500b20(var_4eec1895) {
    var_14719aa8 = self;
    var_14719aa8.var_c59c6b7c.mdl_gameobject endon(#"destroyed_complete", #"death");
    var_14719aa8 flag::function_6814c108();
    teamowner = undefined;
    team = util::get_team_mapping(var_14719aa8.var_c59c6b7c.team);
    if (team == #"any") {
        var_610fb12c = function_f2907c5(var_14719aa8.var_c59c6b7c.origin, team);
        team = var_610fb12c.team;
    }
    teamowner = function_29220163(team);
    var_14719aa8.var_c59c6b7c thread function_306a4812(var_4eec1895, teamowner, team);
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x228edae8, Offset: 0x16e0
// Size: 0x18c
function function_e03eea30(var_4eec1895) {
    var_14719aa8 = self;
    var_14719aa8.var_c59c6b7c.mdl_gameobject endon(#"destroyed_complete", #"death");
    waitresult = level waittill(var_14719aa8.script_waittill);
    teamowner = waitresult.owner;
    team = waitresult.team;
    if (!isdefined(teamowner) || !isplayer(teamowner)) {
        if (!isdefined(team)) {
            team = util::get_team_mapping(var_14719aa8.var_c59c6b7c.team);
        }
        if (team == #"any") {
            var_610fb12c = function_f2907c5(var_14719aa8.var_c59c6b7c.origin, team);
            team = var_610fb12c.team;
        }
        teamowner = function_29220163(team);
    }
    var_14719aa8.var_c59c6b7c thread function_306a4812(var_4eec1895, teamowner, team);
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0x8b5a2a83, Offset: 0x1878
// Size: 0x1e4
function function_306a4812(var_4eec1895, owner, team) {
    var_c59c6b7c = self;
    type = var_4eec1895.m_type;
    if (isdefined(owner)) {
        owner owner_init();
        time = gettime();
        if (isdefined(owner._traps_deployable.var_37ff9854)) {
            while (owner._traps_deployable.var_37ff9854 == time) {
                waitframe(1);
                if (!isdefined(owner)) {
                    /#
                        printerror("<dev string:x179>" + var_4eec1895.m_name + "<dev string:x18d>");
                    #/
                    return;
                }
                time = gettime();
            }
        }
        owner._traps_deployable.var_37ff9854 = time;
        if (function_b3465089(type) && isdefined(level._traps_deployable.traptypes[type].onautoactivatetrap)) {
            tracktrap = var_c59c6b7c [[ level._traps_deployable.traptypes[type].onautoactivatetrap ]](var_4eec1895, owner, team);
        }
        waitframe(1);
        if (isdefined(var_c59c6b7c.mdl_gameobject)) {
            var_c59c6b7c.mdl_gameobject thread gameobjects::check_gameobject_reenable();
        }
        return;
    }
    /#
        printerror("<dev string:x179>" + var_4eec1895.m_name + "<dev string:x1b7>");
    #/
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0xfdd1824c, Offset: 0x1a68
// Size: 0x10c
function activate_trap(var_4eec1895, origin, angles) {
    player = self;
    type = var_4eec1895.m_type;
    player owner_init();
    self._traps_deployable.var_b858a8ac = 1;
    if (function_b3465089(type) && isdefined(level._traps_deployable.traptypes[type].onactivatetrap)) {
        player [[ level._traps_deployable.traptypes[type].onactivatetrap ]](var_4eec1895, origin, angles);
        return;
    }
    /#
        printerror("<dev string:x1db>" + var_4eec1895.m_name + "<dev string:x1ea>");
    #/
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xf46a8cd1, Offset: 0x1b80
// Size: 0x16e
function track_trap(trap_instance) {
    var_4eec1895 = self;
    if (!isdefined(level._traps_deployable.trap_instances)) {
        level._traps_deployable.trap_instances = [];
    }
    if (isdefined(trap_instance)) {
        if (isdefined(var_4eec1895.var_225ff2b0.var_88a55a79)) {
            trap_instance.var_88a55a79 = var_4eec1895.var_225ff2b0.var_88a55a79;
        }
        if (isdefined(var_4eec1895.var_225ff2b0.var_ad2d28ea)) {
            trap_instance.var_ad2d28ea = var_4eec1895.var_225ff2b0.var_ad2d28ea;
        }
        if (!isdefined(level._traps_deployable.trap_instances)) {
            level._traps_deployable.trap_instances = [];
        } else if (!isarray(level._traps_deployable.trap_instances)) {
            level._traps_deployable.trap_instances = array(level._traps_deployable.trap_instances);
        }
        level._traps_deployable.trap_instances[level._traps_deployable.trap_instances.size] = trap_instance;
    }
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xdd3ca0c9, Offset: 0x1cf8
// Size: 0x16e
function function_df46a340(mdl_gameobject) {
    var_4eec1895 = self;
    if (!isdefined(level._traps_deployable.var_45e40d6f)) {
        level._traps_deployable.var_45e40d6f = [];
    }
    if (isdefined(mdl_gameobject)) {
        if (isdefined(var_4eec1895.var_225ff2b0.var_88a55a79)) {
            mdl_gameobject.var_88a55a79 = var_4eec1895.var_225ff2b0.var_88a55a79;
        }
        if (isdefined(var_4eec1895.var_225ff2b0.var_ad2d28ea)) {
            mdl_gameobject.var_ad2d28ea = var_4eec1895.var_225ff2b0.var_ad2d28ea;
        }
        if (!isdefined(level._traps_deployable.var_45e40d6f)) {
            level._traps_deployable.var_45e40d6f = [];
        } else if (!isarray(level._traps_deployable.var_45e40d6f)) {
            level._traps_deployable.var_45e40d6f = array(level._traps_deployable.var_45e40d6f);
        }
        level._traps_deployable.var_45e40d6f[level._traps_deployable.var_45e40d6f.size] = mdl_gameobject;
    }
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0x6e5996fe, Offset: 0x1e70
// Size: 0x20
function function_ddcc81b6(origin, angles, player) {
    return true;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xabd1a012, Offset: 0x1e98
// Size: 0xc
function function_33a21108(var_4eec1895) {
    
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x15cde1a8, Offset: 0x1eb0
// Size: 0xc
function function_7add3c1e(var_4eec1895) {
    
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0xcd265bd, Offset: 0x1ec8
// Size: 0x43c
function function_60a71cd(var_4eec1895, origin, angles) {
    player = self;
    type = var_4eec1895.m_type;
    if (function_b3465089(type)) {
        onmovecallback = level._traps_deployable.traptypes[type].onmovecallback;
        if (var_4eec1895.var_16cba53b === 1) {
            onmovecallback = undefined;
        }
        if (isdefined(var_4eec1895.m_weapon) && var_4eec1895.m_weapon.deployable) {
            player function_33a21108(var_4eec1895);
            placeable = player placeables::function_9f65ced6(level._traps_deployable.traptypes[type].onplacecallback, level._traps_deployable.traptypes[type].oncancelcallback, onmovecallback, level._traps_deployable.traptypes[type].onshutdowncallback, level._traps_deployable.traptypes[type].ondeathcallback, level._traps_deployable.traptypes[type].onempcallback, level._traps_deployable.traptypes[type].ondamagecallback, level._traps_deployable.traptypes[type].var_1cebc6ef, &function_ddcc81b6, var_4eec1895.m_weapon, var_4eec1895.var_fc3951f2, var_4eec1895.var_a867507e, var_4eec1895.var_bf2eadc7, var_4eec1895.m_timeout);
            placeable.var_4eec1895 = var_4eec1895;
            placeable.is_placeable = 1;
            placeable.var_ec2d3cdc = 1;
            placeable placeables::function_e5e352ad(1);
            return;
        }
        placeable = player placeables::spawnplaceable(level._traps_deployable.traptypes[type].onplacecallback, level._traps_deployable.traptypes[type].oncancelcallback, onmovecallback, level._traps_deployable.traptypes[type].onshutdowncallback, level._traps_deployable.traptypes[type].ondeathcallback, level._traps_deployable.traptypes[type].onempcallback, level._traps_deployable.traptypes[type].ondamagecallback, level._traps_deployable.traptypes[type].var_1cebc6ef, var_4eec1895.j_cosmetic_cowl_lefte, var_4eec1895.var_48eae6c, var_4eec1895.var_f2b86855, var_4eec1895.m_spawnsentity, var_4eec1895.var_fc3951f2, var_4eec1895.m_timeout, var_4eec1895.m_health, var_4eec1895.m_empdamage, var_4eec1895.var_a867507e, var_4eec1895.var_bf2eadc7, var_4eec1895.m_placeimmediately, level._traps_deployable.traptypes[type].damagewrapper);
        placeable.var_4eec1895 = var_4eec1895;
        placeable.is_placeable = 1;
        placeable.var_ec2d3cdc = 1;
        placeable placeables::function_e5e352ad(1);
        placeable notsolid();
    }
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x4f4544db, Offset: 0x2310
// Size: 0x4c
function function_f164c5aa(placeable) {
    player = self;
    var_4eec1895 = placeable.var_4eec1895;
    player function_7add3c1e(var_4eec1895);
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xf4ea3fbc, Offset: 0x2368
// Size: 0x9c
function function_61dc4801(placeable) {
    player = self;
    var_4eec1895 = placeable.var_4eec1895;
    player function_7add3c1e(var_4eec1895);
    placeable.var_4eec1895.var_225ff2b0 function_8ac48505(placeable.var_4eec1895, placeable.origin, placeable.angles, 1);
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xb8893555, Offset: 0x2410
// Size: 0x5a
function function_7e0ee388(placeable) {
    player = self;
    var_4eec1895 = placeable.var_4eec1895;
    player function_33a21108(var_4eec1895);
    placeable.cancelable = 1;
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0xfb4590a, Offset: 0x2478
// Size: 0x58
function function_6385b051(var_4eec1895, owner, team) {
    var_c59c6b7c = self;
    /#
        printerror("<dev string:x218>" + var_c59c6b7c.scriptbundlename);
    #/
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x24d8
// Size: 0x4
function function_120938b8() {
    
}

// Namespace traps_deployable/traps_deployable
// Params 4, eflags: 0x0
// Checksum 0x675ae0de, Offset: 0x24e8
// Size: 0x84
function function_f7a2ee23(damagecallback, destroyedcallback, var_f075ba56, var_ec678527) {
    placeable = self;
    placeable function_153e9a9d(damagecallback, destroyedcallback, var_f075ba56, var_ec678527);
    placeable thread function_95bde532(placeable.var_4eec1895, damagecallback, destroyedcallback, var_f075ba56, var_ec678527);
}

// Namespace traps_deployable/traps_deployable
// Params 4, eflags: 0x0
// Checksum 0xfa51813b, Offset: 0x2578
// Size: 0x94
function function_153e9a9d(damagecallback, destroyedcallback, var_f075ba56, var_ec678527) {
    waitframe(1);
    placeable = self;
    placeable.health = 9999999;
    placeable.damagetaken = 0;
    placeable function_f21cbb1a(placeable.var_4eec1895.m_health, placeable.var_4eec1895.var_5eb6505e);
}

// Namespace traps_deployable/traps_deployable
// Params 5, eflags: 0x0
// Checksum 0x162c6a2, Offset: 0x2618
// Size: 0x46e
function function_95bde532(var_4eec1895, damage_callback, destroyed_callback, emp_damage, emp_callback) {
    self endon(#"death");
    self endon(#"delete");
    assert(!isvehicle(self) || !issentient(self), "<dev string:x25e>");
    while (true) {
        weapon_damage = undefined;
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        inflictor = waitresult.inflictor;
        damage = waitresult.amount;
        type = waitresult.mod;
        weapon = waitresult.weapon;
        if (isdefined(self.invulnerable) && self.invulnerable) {
            continue;
        }
        if (!isdefined(attacker)) {
            continue;
        }
        friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
        if (!friendlyfire) {
            continue;
        }
        if (isdefined(self.owner) && attacker == self.owner) {
        }
        isvalidattacker = 1;
        if (level.teambased) {
            isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
        }
        if (isvalidattacker) {
        }
        if (weapon.isemp && type == "MOD_GRENADE_SPLASH") {
            emp_damage_to_apply = var_4eec1895.m_empdamage;
            if (!isdefined(emp_damage_to_apply)) {
                emp_damage_to_apply = isdefined(emp_damage) ? emp_damage : 1;
            }
            if (isdefined(emp_callback) && emp_damage_to_apply > 0) {
                self [[ emp_callback ]](attacker);
            }
            weapon_damage = emp_damage_to_apply;
        }
        if (isdefined(self.selfdestruct) && self.selfdestruct) {
            weapon_damage = self.maxhealth + 1;
        }
        if (!isdefined(weapon_damage)) {
            weapon_damage = damage;
        }
        if (weapon_damage > 0) {
            if (damagefeedback::dodamagefeedback(weapon, inflictor, weapon_damage, type)) {
                attacker damagefeedback::update();
            }
            self challenges::trackassists(attacker, weapon_damage, 0);
        }
        self.damagetaken += weapon_damage;
        if (!issentient(self) && weapon_damage > 0) {
            self.attacker = attacker;
        }
        if (self.damagetaken > self.maxhealth) {
            weaponstatname = "destroyed";
            switch (weapon.name) {
            case #"tow_turret":
            case #"tow_turret_drop":
            case #"auto_tow":
                weaponstatname = "kills";
                break;
            }
            if (isdefined(destroyed_callback)) {
                self thread [[ destroyed_callback ]](attacker, weapon);
            }
            return;
        }
        remaining_health = self.maxhealth - self.damagetaken;
        if (remaining_health < self.lowhealth && weapon_damage > 0) {
            self.currentstate = "damaged";
        }
    }
}

// Namespace traps_deployable/traps_deployable
// Params 2, eflags: 0x0
// Checksum 0x16f2311, Offset: 0x2a90
// Size: 0x3e
function function_f21cbb1a(max_health, low_health) {
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    self.hackedhealth = self.maxhealth;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x65fbc2d2, Offset: 0x2ad8
// Size: 0x64
function function_bc56b26e(placeable) {
    self waittill(#"death");
    if (isdefined(placeable) && isdefined(placeable.is_placeable) && placeable.is_placeable) {
        placeable placeables::forceshutdown();
    }
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x52df9591, Offset: 0x2b48
// Size: 0x210
function watcher_init(var_4eec1895) {
    owner = self;
    var_3106b3e3 = var_4eec1895.m_weapon.name;
    var_a8f81e8f = undefined;
    if (!(isdefined(owner._traps_deployable.watchers_init[var_3106b3e3]) && owner._traps_deployable.watchers_init[var_3106b3e3])) {
        type = var_4eec1895.m_type;
        if (type == "claymore") {
            var_a8f81e8f = owner weaponobjects::createwatcher(var_3106b3e3, &trapd::function_3062c270, 0);
        } else if (type == "flash_disruptor") {
            var_a8f81e8f = owner weaponobjects::createwatcher(var_3106b3e3, &trapd::function_87cb44fe, 0);
        } else if (type == "fire_bomb") {
            var_a8f81e8f = owner weaponobjects::createwatcher(var_3106b3e3, &trapd::function_99f6d728, 0);
        } else {
            var_a8f81e8f = owner weaponobjects::createwatcher(var_3106b3e3, &trapd::function_63db9c73, 0);
        }
        owner._traps_deployable.watchers_init[var_3106b3e3] = 1;
    } else {
        var_a8f81e8f = owner weaponobjects::getweaponobjectwatcher(var_3106b3e3);
    }
    if (!isplayer(owner)) {
        owner thread weaponobjects::watchweaponobjectspawn("grenade_fire", "death");
    }
    return var_a8f81e8f;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x36913abe, Offset: 0x2d60
// Size: 0x160
function function_b53cd5c1(placeable) {
    player = self;
    var_4eec1895 = placeable.var_4eec1895;
    if (isplayer(player)) {
        var_a8f81e8f = player watcher_init(var_4eec1895);
        placeable.weapon_instance = player magicgrenadeplayer(var_4eec1895.m_weapon, placeable.origin, (0, 0, -1));
        if (isdefined(placeable.weapon_instance)) {
            placeable.weapon_instance.angles = placeable.angles;
            placeable.weapon_instance.var_93ab7acc = placeable;
            trap_instance = spawnstruct();
            trap_instance.var_a8f81e8f = var_a8f81e8f;
            trap_instance.weapon_instance = placeable.weapon_instance;
            var_4eec1895 track_trap(trap_instance);
            player function_f164c5aa(placeable);
        }
    }
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0x89735717, Offset: 0x2ec8
// Size: 0x248
function function_39d36c84(var_4eec1895, owner, team) {
    var_c59c6b7c = self;
    if (isdefined(owner)) {
        weapon_instance = undefined;
        var_a8f81e8f = owner watcher_init(var_4eec1895);
        if (isplayer(owner)) {
            weapon_instance = owner magicgrenadeplayer(var_4eec1895.m_weapon, var_c59c6b7c.origin, (0, 0, -1));
        } else {
            weapon_instance = owner magicgrenadetype(var_4eec1895.m_weapon, var_c59c6b7c.origin, (0, 0, -1));
        }
        if (isdefined(weapon_instance)) {
            weapon_instance.angles = var_c59c6b7c.angles;
            trap_instance = spawnstruct();
            trap_instance.weapon_instance = weapon_instance;
            trap_instance.var_a8f81e8f = var_a8f81e8f;
            var_4eec1895 track_trap(trap_instance);
            if (!isdefined(var_c59c6b7c.var_747026d8)) {
                var_c59c6b7c.var_747026d8 = [];
            } else if (!isarray(var_c59c6b7c.var_747026d8)) {
                var_c59c6b7c.var_747026d8 = array(var_c59c6b7c.var_747026d8);
            }
            var_c59c6b7c.var_747026d8[var_c59c6b7c.var_747026d8.size] = weapon_instance;
            var_c59c6b7c.var_747026d8 = array::remove_undefined(var_c59c6b7c.var_747026d8);
        }
    } else {
        /#
            printerror("<dev string:x2d2>" + var_4eec1895.m_name + "<dev string:x1b7>");
        #/
    }
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0x25bbd952, Offset: 0x3118
// Size: 0xc0
function function_adf1b4e2(var_4eec1895, owner, team) {
    var_c59c6b7c = self;
    vehicle = turret_activate(var_4eec1895, owner, team, undefined, var_c59c6b7c.origin, var_c59c6b7c.angles, undefined);
    if (isdefined(vehicle)) {
        trap_instance = spawnstruct();
        trap_instance.var_7b06ba4b = vehicle;
        var_4eec1895 track_trap(trap_instance);
    }
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x4c312cd9, Offset: 0x31e0
// Size: 0x120
function function_4a7c8a4f(placeable) {
    player = self;
    var_4eec1895 = placeable.var_4eec1895;
    placeable.vehicle = player turret_activate(var_4eec1895, player, player.team, placeable.vehicle, placeable.origin, placeable.angles, placeable);
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle thread util::ghost_wait_show(0.05);
        trap_instance = spawnstruct();
        trap_instance.var_7b06ba4b = placeable.vehicle;
        trap_instance.var_93ab7acc = placeable;
        var_4eec1895 track_trap(trap_instance);
    }
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 7, eflags: 0x0
// Checksum 0x862bead, Offset: 0x3308
// Size: 0x448
function turret_activate(var_4eec1895, owner, team, vehicle, origin, angles, parent) {
    if (isdefined(vehicle)) {
        vehicle.origin = origin;
        vehicle.angles = angles;
        if (vehicle vehicle_ai::has_state("unaware")) {
            vehicle vehicle_ai::set_state("unaware");
        }
    } else {
        vehicle = spawnvehicle(var_4eec1895.m_vehicle, origin, angles, "dynamic_spawn_ai");
        if (isdefined(owner)) {
            ownerteam = owner.team;
            vehicle.owner = owner;
            vehicle.ownerentnum = owner.entnum;
            if (isplayer(owner)) {
                vehicle setowner(owner);
            }
        }
        if (!isdefined(team)) {
            team = ownerteam;
        }
        if (isdefined(team)) {
            vehicle.team = team;
            vehicle setteam(team);
        }
        vehicle.parentstruct = parent;
        vehicle.controlled = 0;
        vehicle.treat_owner_damage_as_friendly_fire = 1;
        vehicle.ignore_team_kills = 1;
        vehicle.deal_no_crush_damage = 1;
        if (isdefined(vehicle.parentstruct) && isdefined(vehicle.parentstruct.is_placeable) && vehicle.parentstruct.is_placeable) {
            vehicle thread function_bc56b26e(vehicle.parentstruct);
        }
    }
    if (isdefined(vehicle.settings.var_19e8b710) && vehicle.settings.var_19e8b710 && !(isdefined(vehicle.has_bad_place) && vehicle.has_bad_place)) {
        if (!isdefined(level.var_42b3ee16)) {
            level.var_42b3ee16 = 0;
        } else {
            level.var_42b3ee16 += 1;
        }
        vehicle.turret_id = string(level.var_42b3ee16);
        badplace_cylinder("turret_bad_place_" + vehicle.turret_id, 0, vehicle.origin, vehicle.settings.var_44045a4e, vehicle.settings.var_f7a7f7f5, #"axis", #"allies", #"neutral");
        vehicle.has_bad_place = 1;
    }
    vehicle unlink();
    targetoffset = (isdefined(vehicle.settings.lockon_offsetx) ? vehicle.settings.lockon_offsetx : 0, isdefined(vehicle.settings.lockon_offsety) ? vehicle.settings.lockon_offsety : 0, isdefined(vehicle.settings.lockon_offsetz) ? vehicle.settings.lockon_offsetz : 36);
    vehicle::make_targetable(vehicle, targetoffset);
    return vehicle;
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x21e5656a, Offset: 0x3758
// Size: 0x152
function function_e15d911f(placeable) {
    player = self;
    if (isdefined(placeable.vehicle)) {
        placeable.cancelable = 1;
        placeable.vehicle ghost();
        if (placeable.vehicle vehicle_ai::has_state("off")) {
            placeable.vehicle vehicle_ai::set_state("off");
        }
        placeable.vehicle linkto(placeable);
        target_remove(placeable.vehicle);
        if (isdefined(placeable.vehicle.has_bad_place) && placeable.vehicle.has_bad_place) {
            badplace_delete("turret_bad_place_" + placeable.vehicle.turret_id);
            placeable.vehicle.has_bad_place = 0;
        }
    }
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0x18da2840, Offset: 0x38b8
// Size: 0xc0
function function_f90068e6(var_4eec1895, owner, team) {
    var_c59c6b7c = self;
    vehicle = vehicle_activate(var_4eec1895, owner, team, undefined, var_c59c6b7c.origin, var_c59c6b7c.angles, undefined);
    if (isdefined(vehicle)) {
        trap_instance = spawnstruct();
        trap_instance.var_7b06ba4b = vehicle;
        var_4eec1895 track_trap(trap_instance);
    }
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0x482f188c, Offset: 0x3980
// Size: 0xe8
function function_f19ceb4e(var_4eec1895, origin, angles) {
    player = self;
    if (!isdefined(origin)) {
        origin = player.origin;
    }
    if (!isdefined(angles)) {
        angles = player.angles;
    }
    vehicle = vehicle_activate(var_4eec1895, player, player.team, undefined, origin, angles, undefined);
    if (isdefined(vehicle)) {
        trap_instance = spawnstruct();
        trap_instance.var_7b06ba4b = vehicle;
        var_4eec1895 track_trap(trap_instance);
    }
    return var_4eec1895;
}

// Namespace traps_deployable/traps_deployable
// Params 7, eflags: 0x0
// Checksum 0xdf967da8, Offset: 0x3a70
// Size: 0x2d0
function vehicle_activate(var_4eec1895, owner, team, vehicle, origin, angles, parent) {
    if (isdefined(vehicle)) {
        vehicle.origin = origin;
        vehicle.angles = angles;
    } else {
        vehicle = spawnvehicle(var_4eec1895.m_vehicle, origin, angles, "dynamic_spawn_ai");
        if (isdefined(owner)) {
            ownerteam = owner.team;
            vehicle.owner = owner;
            vehicle.ownerentnum = owner.entnum;
            if (isplayer(owner)) {
                vehicle setowner(owner);
            }
        }
        if (!isdefined(team)) {
            team = ownerteam;
        }
        if (isdefined(team)) {
            vehicle.team = team;
            vehicle setteam(team);
        }
        vehicle.parentstruct = parent;
        vehicle.controlled = 0;
        vehicle.treat_owner_damage_as_friendly_fire = 1;
        vehicle.ignore_team_kills = 1;
        vehicle.deal_no_crush_damage = 1;
        if (isdefined(vehicle.parentstruct) && isdefined(vehicle.parentstruct.is_placeable) && vehicle.parentstruct.is_placeable) {
            vehicle thread function_bc56b26e(vehicle.parentstruct);
        }
    }
    vehicle unlink();
    targetoffset = (isdefined(vehicle.settings.lockon_offsetx) ? vehicle.settings.lockon_offsetx : 0, isdefined(vehicle.settings.lockon_offsety) ? vehicle.settings.lockon_offsety : 0, isdefined(vehicle.settings.lockon_offsetz) ? vehicle.settings.lockon_offsetz : 0);
    vehicle::make_targetable(vehicle, targetoffset);
    return vehicle;
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3d48
// Size: 0x4
function function_e7324ebb() {
    
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3d58
// Size: 0x4
function function_f2935d63() {
    
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0xff442160, Offset: 0x3d68
// Size: 0xdc
function function_8d369168() {
    trap_instance = self;
    if (!isdefined(trap_instance)) {
        return;
    }
    if (isdefined(trap_instance.weapon_instance)) {
        if (isdefined(trap_instance.var_a8f81e8f)) {
            trap_instance.var_a8f81e8f weaponobjects::waitandfizzleout(trap_instance.weapon_instance, 0.1);
        } else {
            trap_instance.weapon_instance delete();
        }
    }
    if (isdefined(trap_instance.var_7b06ba4b)) {
        trap_instance.var_7b06ba4b delete();
    }
    if (isdefined(trap_instance.var_93ab7acc)) {
        trap_instance.var_93ab7acc placeables::forceshutdown();
    }
}

// Namespace traps_deployable/traps_deployable
// Params 0, eflags: 0x0
// Checksum 0xcc8a514b, Offset: 0x3e50
// Size: 0x3c
function function_d161d0f2() {
    mdl_gameobject = self;
    if (!isdefined(mdl_gameobject)) {
        return;
    }
    mdl_gameobject gameobjects::destroy_object(1, 1);
}

// Namespace traps_deployable/traps_deployable
// Params 3, eflags: 0x0
// Checksum 0xacd59f64, Offset: 0x3e98
// Size: 0x316
function clean_traps(all, skipto = undefined, flag = undefined) {
    if (all) {
        level notify(#"hash_6bd910abadea6345");
    }
    if (isdefined(skipto)) {
        players = getplayers();
        foreach (player in players) {
            if (isdefined(player._traps_deployable)) {
                player._traps_deployable.var_b858a8ac = undefined;
            }
        }
    }
    if (isdefined(level._traps_deployable) && isdefined(level._traps_deployable.trap_instances)) {
        trap_instances = level._traps_deployable.trap_instances;
        for (i = trap_instances.size - 1; i >= 0; i--) {
            if (isdefined(trap_instances[i])) {
                trap_instance = trap_instances[i];
                if (all || isdefined(skipto) && trap_instance.var_88a55a79 === skipto || isdefined(flag) && trap_instance.var_ad2d28ea === flag) {
                    trap_instance function_8d369168();
                    arrayremoveindex(trap_instances, i);
                }
            }
        }
    }
    if (isdefined(level._traps_deployable) && isdefined(level._traps_deployable.var_45e40d6f)) {
        var_bf78e715 = level._traps_deployable.var_45e40d6f;
        for (i = var_bf78e715.size - 1; i >= 0; i--) {
            if (isdefined(var_bf78e715[i])) {
                mdl_gameobject = var_bf78e715[i];
                if (all || isdefined(skipto) && mdl_gameobject.var_88a55a79 === skipto || isdefined(flag) && mdl_gameobject.var_ad2d28ea === flag) {
                    mdl_gameobject function_d161d0f2();
                    arrayremoveindex(var_bf78e715, i);
                }
            }
        }
    }
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0x25315d2c, Offset: 0x41b8
// Size: 0x9e
function function_1ca4a6bd(flags) {
    if (isdefined(flags) && flags != "") {
        var_a0c2bb7c = util::create_flags_and_return_tokens(flags);
        for (i = 0; i < var_a0c2bb7c.size; i++) {
            flag = var_a0c2bb7c[i];
            level thread function_57c82939(flag);
        }
    }
}

// Namespace traps_deployable/traps_deployable
// Params 1, eflags: 0x0
// Checksum 0xd8aacb, Offset: 0x4260
// Size: 0x8c
function function_57c82939(flag) {
    level endon(#"hash_6bd910abadea6345");
    level notify("traps_clean" + "_" + flag);
    level endon("traps_clean" + "_" + flag);
    level flag::wait_till(flag);
    clean_traps(0, undefined, flag);
}

/#

    // Namespace traps_deployable/traps_deployable
    // Params 1, eflags: 0x0
    // Checksum 0x514636d8, Offset: 0x42f8
    // Size: 0x2c
    function printerror(message) {
        println("<dev string:x2ef>", message);
    }

    // Namespace traps_deployable/traps_deployable
    // Params 1, eflags: 0x0
    // Checksum 0x161ce035, Offset: 0x4330
    // Size: 0x2c
    function printinfo(message) {
        println("<dev string:x30b>", message);
    }

    // Namespace traps_deployable/traps_deployable
    // Params 0, eflags: 0x0
    // Checksum 0x4c84b232, Offset: 0x4368
    // Size: 0x136
    function function_174fb1f0() {
        if (isdefined(level.trapddebug) && level.trapddebug) {
            var_c59c6b7c = self;
            if (!isdefined(level.var_9ceee7aa)) {
                level.var_9ceee7aa = spawnstruct();
            }
            if (!isdefined(level.var_9ceee7aa.var_a9058c43)) {
                level.var_9ceee7aa.var_a9058c43 = [];
            }
            if (!isdefined(level.var_9ceee7aa.var_a9058c43)) {
                level.var_9ceee7aa.var_a9058c43 = [];
            } else if (!isarray(level.var_9ceee7aa.var_a9058c43)) {
                level.var_9ceee7aa.var_a9058c43 = array(level.var_9ceee7aa.var_a9058c43);
            }
            level.var_9ceee7aa.var_a9058c43[level.var_9ceee7aa.var_a9058c43.size] = var_c59c6b7c;
        }
    }

    // Namespace traps_deployable/traps_deployable
    // Params 0, eflags: 0x0
    // Checksum 0x516b67fb, Offset: 0x44a8
    // Size: 0xc8
    function function_7e5c24c() {
        level.trapddebug = getdvarint(#"scr_trapd_debug", 0);
        while (true) {
            trapddebug = level.trapddebug;
            level.trapddebug = getdvarint(#"scr_trapd_debug", 0);
            if (!(trapddebug === level.trapddebug)) {
                destroy_traps();
                waitframe(1);
                function_3c957692();
            }
            wait 1;
        }
    }

    // Namespace traps_deployable/traps_deployable
    // Params 0, eflags: 0x0
    // Checksum 0xac720726, Offset: 0x4578
    // Size: 0x1bc
    function destroy_traps() {
        if (isdefined(level.var_9ceee7aa) && isdefined(level.var_9ceee7aa.var_a9058c43)) {
            var_a9058c43 = level.var_9ceee7aa.var_a9058c43;
            for (i = var_a9058c43.size - 1; i >= 0; i--) {
                if (isdefined(var_a9058c43[i])) {
                    var_14719aa8 = var_a9058c43[i];
                    if (isdefined(var_14719aa8.script_flag_true)) {
                        tokens = util::create_flags_and_return_tokens(var_14719aa8.script_flag_true);
                        for (j = 0; j < tokens.size; j++) {
                            level flag::clear(tokens[j]);
                        }
                    }
                    if (isdefined(var_14719aa8.script_flag_false)) {
                        tokens = util::create_flags_and_return_tokens(var_14719aa8.script_flag_false);
                        for (j = 0; j < tokens.size; j++) {
                            level flag::clear(tokens[j]);
                        }
                    }
                }
                arrayremoveindex(var_a9058c43, i);
            }
        }
        clean_traps(1);
    }

    // Namespace traps_deployable/traps_deployable
    // Params 0, eflags: 0x0
    // Checksum 0x765f55f5, Offset: 0x4740
    // Size: 0x10c
    function debug_init() {
        thread function_7e5c24c();
        while (true) {
            debugint = getdvarint(#"scr_trapd_int", 0);
            if (debugint) {
                switch (debugint) {
                case 1:
                    if (isdefined(level.trapddebug) && level.trapddebug) {
                        destroy_traps();
                        waitframe(1);
                        function_3c957692();
                    }
                    break;
                }
                setdvar(#"scr_trapd_int", 0);
            }
            wait 1;
        }
        thread debug_init();
    }

#/
