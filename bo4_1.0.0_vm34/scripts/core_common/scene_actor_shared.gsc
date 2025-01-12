#using scripts\core_common\animation_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_actor_shared;
#using scripts\core_common\scene_objects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;

#namespace scene;

// Namespace scene
// Method(s) 7 Total 120
class cscenecompanion : csceneactor, csceneobject {

    var _e;
    var _o_scene;
    var _s;
    var _str_shot;
    var _str_team;

    // Namespace cscenecompanion/scene_actor_shared
    // Params 3, eflags: 0x0
    // Checksum 0xf2c52b48, Offset: 0x4138
    // Size: 0x100
    function animation_lookup(animation, ent = self._e, b_camera = 0) {
        if (isdefined(_s.var_dbcb4dde)) {
            n_shot = csceneobject::get_shot(_str_shot);
            var_6f5dfee0 = ent.animname;
            if (isdefined(n_shot) && isdefined(_s.var_dbcb4dde[n_shot]) && isdefined(_s.var_dbcb4dde[n_shot][var_6f5dfee0])) {
                return _s.var_dbcb4dde[n_shot][var_6f5dfee0].var_121fe5f6;
            }
        }
        return animation;
    }

    // Namespace cscenecompanion/scene_actor_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd0db39bd, Offset: 0x4090
    // Size: 0x9c
    function _stop(b_dont_clear_anim) {
        if (isalive(_e)) {
            _e notify(#"scene_stop");
            if (!b_dont_clear_anim) {
                _e animation::stop(0.2);
            }
            _e thread scene::function_a0128166(_o_scene._e_root, _o_scene._s);
        }
    }

    // Namespace cscenecompanion/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x39b54a6c, Offset: 0x4008
    // Size: 0x7c
    function _cleanup() {
        if (![[ _o_scene ]]->has_next_shot(_str_shot) || _o_scene._str_mode === "single") {
            _e thread scene::function_a0128166(_o_scene._e_root, _o_scene._s);
        }
    }

    // Namespace cscenecompanion/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x425b6696, Offset: 0x3e10
    // Size: 0x1ec
    function _spawn_ent() {
        if (isspawner(_e)) {
            if (!csceneobject::error(_e.count < 1, "Trying to spawn AI for scene with spawner count < 1")) {
                _e = _e spawner::spawn(1);
            }
        } else if (isassetloaded("aitype", _s.model)) {
            _e = spawnactor(_s.model, csceneobject::function_33de018f(), csceneobject::function_df0e1071(), _s.name, 1);
        }
        if (!isdefined(_e)) {
            return;
        }
        _str_team = _e getteam();
        if (!isdefined(level.heroes)) {
            level.heroes = [];
        }
        level.heroes[_s.name] = _e;
        _s.(_s.name) = _e;
        _e.animname = _s.name;
        _e.is_hero = 1;
        _e.enableterrainik = 1;
        _e util::magic_bullet_shield();
    }

    // Namespace cscenecompanion/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5daba1a0, Offset: 0x3d48
    // Size: 0xbc
    function _spawn() {
        if (!isdefined(level.heroes)) {
            level.heroes = [];
        }
        foreach (ent in level.heroes) {
            if (!csceneobject::in_this_scene(ent)) {
                _e = ent;
                return;
            }
        }
        csceneobject::_spawn();
    }

}

// Namespace scene
// Method(s) 11 Total 120
class csceneactor : csceneobject {

    var _b_set_goal;
    var _e;
    var _o_scene;
    var _s;
    var _str_shot;
    var _str_team;
    var var_5c4adc26;
    var var_b6160c2e;

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x8
    // Checksum 0x47c0f1f2, Offset: 0x178
    // Size: 0x22
    constructor() {
        _b_set_goal = 1;
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8b9d7314, Offset: 0x8d8
    // Size: 0xd4
    function do_death_anims() {
        ent = _e;
        if (isdefined(var_b6160c2e.deathanim) && !(isdefined(ent.var_100aa9aa) && ent.var_100aa9aa)) {
            ent.skipdeath = 1;
            ent animation::play(var_b6160c2e.deathanim, ent, undefined, 1, 0.2, 0);
        } else {
            ent animation::stop();
            ent startragdoll();
        }
        csceneobject::function_2550967e();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 1, eflags: 0x0
    // Checksum 0x10fc15ed, Offset: 0x7a8
    // Size: 0x124
    function _set_values(ent = self._e) {
        if (!(isdefined(_s.takedamage) && _s.takedamage)) {
            csceneobject::set_ent_val("takedamage", 0, ent);
        }
        csceneobject::set_ent_val("ignoreme", !(isdefined(_s.attackme) && _s.attackme), ent);
        csceneobject::set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
        csceneobject::set_ent_val("take_weapons", isdefined(_s.removeweapon) && _s.removeweapon, ent);
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x28e3a835, Offset: 0x668
    // Size: 0x134
    function function_4c774cdb() {
        self notify(#"hash_74f6d3a1ddcff42");
        self endon(#"hash_74f6d3a1ddcff42");
        _o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed");
        s_waitresult = _e waittill(#"death");
        var_5c4adc26 = 1;
        _e notify(#"hash_6e7fd8207fd988c6", {#str_scene:_o_scene._str_name});
        if (isdefined(_e) && !(isdefined(_e.skipscenedeath) && _e.skipscenedeath)) {
            self thread do_death_anims();
            return;
        }
        csceneobject::function_2550967e();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x25a0e6fa, Offset: 0x550
    // Size: 0x10c
    function set_goal() {
        if (!(_e.scene_spawned === _o_scene._s.name && isdefined(_e.target))) {
            if (!isdefined(_e.script_forcecolor)) {
                if (!_e flagsys::get(#"anim_reach")) {
                    if (isdefined(_e.scenegoal)) {
                        _e setgoal(_e.scenegoal);
                        _e.scenegoal = undefined;
                        return;
                    }
                    if (_b_set_goal) {
                        _e setgoal(_e.origin);
                    }
                }
            }
        }
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7233abcc, Offset: 0x4e8
    // Size: 0x5a
    function track_goal() {
        self endon(_str_shot + "active");
        _e endon(#"death");
        _e waittill(#"goal_changed");
        _b_set_goal = 0;
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x92c95fb2, Offset: 0x3b8
    // Size: 0x124
    function _cleanup() {
        if (isactor(_e) && isalive(_e)) {
            if (isdefined(_s.delaymovementatend) && _s.delaymovementatend) {
                _e pathmode("move delayed", 1, randomfloatrange(2, 3));
            } else {
                _e pathmode("move allowed");
            }
            if (isdefined(_s.lookatplayer) && _s.lookatplayer) {
                _e lookatentity();
            }
            _e.var_100aa9aa = undefined;
            set_goal();
        }
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x70b1e62d, Offset: 0x2c0
    // Size: 0xec
    function _prepare() {
        if (isactor(_e)) {
            thread track_goal();
            if (isdefined(_s.lookatplayer) && _s.lookatplayer) {
                _e lookatentity(level.activeplayers[0]);
            }
            if (isdefined(_s.skipdeathanim) && _s.skipdeathanim) {
                _e.var_100aa9aa = 1;
            }
            _str_team = _e getteam();
        }
        csceneobject::_prepare();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa444a2d4, Offset: 0x218
    // Size: 0x9c
    function function_c911b8f7(str_model) {
        _e = spawnactor(str_model, csceneobject::function_33de018f(), csceneobject::function_df0e1071(), undefined, 1);
        if (!isdefined(_e)) {
            return;
        }
        _str_team = _e getteam();
        _e setteam(_str_team);
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc5e3f57e, Offset: 0x1a8
    // Size: 0x64
    function _spawn_ent() {
        if (isdefined(_s.model)) {
            if (isassetloaded("aitype", _s.model)) {
                function_c911b8f7(_s.model);
            }
        }
    }

}

// Namespace scene
// Method(s) 3 Total 120
class cscenefakeactor : csceneactor, csceneobject {

    var _e;
    var _s;
    var _str_team;

    // Namespace cscenefakeactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcc8b3cab, Offset: 0x21d8
    // Size: 0x294
    function _spawn_ent() {
        if (isspawner(_e)) {
            csceneactor::function_c911b8f7(_e.aitype);
            if (isdefined(_e) && !isspawner(_e)) {
                str_model = _e.aitype;
                _str_team = _e getteam();
                weapon = _e.weapon;
                _e delete();
            }
        } else if (isdefined(_s.model)) {
            if (isassetloaded("aitype", _s.model)) {
                csceneactor::function_c911b8f7(_s.model);
                if (isdefined(_e)) {
                    str_model = _e.aitype;
                    _str_team = _e getteam();
                    weapon = _e.weapon;
                    _e delete();
                }
            } else {
                str_model = _s.model;
            }
        }
        if (isdefined(str_model)) {
            _e = util::spawn_anim_model(str_model, csceneobject::function_33de018f(), csceneobject::function_df0e1071());
            _e makefakeai();
            if (!(isdefined(_s.removeweapon) && _s.removeweapon)) {
                if (isdefined(weapon)) {
                    _e animation::attach_weapon(weapon);
                    return;
                }
                _e animation::attach_weapon(getweapon(#"ar_accurate_t8"));
            }
        }
    }

}

// Namespace scene
// Method(s) 4 Total 120
class cscenesharedcompanion : cscenecompanion, csceneactor, csceneobject {

    // Namespace cscenesharedcompanion/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xca24248b, Offset: 0x5c88
    // Size: 0xac
    function _cleanup() {
        if (!isdefined(level.heroes)) {
            level.heroes = [];
        }
        foreach (ent in level.heroes) {
            ent setvisibletoall();
        }
        cscenecompanion::_cleanup();
    }

    // Namespace cscenesharedcompanion/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1db4006a, Offset: 0x5bd0
    // Size: 0xb0
    function _prepare() {
        if (!isdefined(level.heroes)) {
            level.heroes = [];
        }
        foreach (ent in level.heroes) {
            ent setinvisibletoall();
            ent setvisibletoall();
        }
    }

}

