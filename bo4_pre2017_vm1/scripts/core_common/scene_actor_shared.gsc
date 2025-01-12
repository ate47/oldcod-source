#using scripts/core_common/animation_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/scene_actor_shared;
#using scripts/core_common/scene_objects_shared;

#namespace scene;

// Namespace scene
// Method(s) 9 Total 73
class csceneactor : csceneobject {

    var _b_set_goal;
    var _e;
    var _o_scene;
    var _s;
    var _str_shot;
    var var_2b1650fa;

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x61c1296, Offset: 0x6f8
    // Size: 0x14
    function __destructor() {
        csceneobject::__destructor();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1b1850ed, Offset: 0x6d8
    // Size: 0x14
    function __constructor() {
        csceneobject::__constructor();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe42413d4, Offset: 0x600
    // Size: 0xcc
    function do_death_anims() {
        ent = _e;
        if (isdefined(var_2b1650fa) && !(isdefined(ent.var_100aa9aa) && ent.var_100aa9aa)) {
            ent.skipdeath = 1;
            ent animation::play(var_2b1650fa, ent, undefined, 1, 0.2, 0);
            return;
        }
        ent stopanimscripted();
        ent startragdoll();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5f18e56f, Offset: 0x568
    // Size: 0x8c
    function on_death() {
        self endon(_str_shot + "active");
        _e waittill("death");
        if (isdefined(_e) && !(isdefined(_e.skipscenedeath) && _e.skipscenedeath)) {
            self thread do_death_anims();
        }
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3bd4573d, Offset: 0x448
    // Size: 0x114
    function set_goal() {
        if (!(_e.scene_spawned === _o_scene._s.name && isdefined(_e.target))) {
            if (!isdefined(_e.script_forcecolor)) {
                if (!_e flagsys::get("anim_reach")) {
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
    // Checksum 0xbf5afd6a, Offset: 0x3e8
    // Size: 0x54
    function track_goal() {
        self endon(_str_shot + "active");
        _e endon(#"death");
        _e waittill("goal_changed");
        _b_set_goal = 0;
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdca5ec79, Offset: 0x2a0
    // Size: 0x13c
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
    // Checksum 0x9db3fd42, Offset: 0x1b0
    // Size: 0xe4
    function _prepare() {
        if (isactor(_e)) {
            thread track_goal();
            if (isdefined(_s.lookatplayer) && _s.lookatplayer) {
                _e lookatentity(level.activeplayers[0]);
            }
            if (isdefined(_s.skipdeathanim) && _s.skipdeathanim) {
                _e.var_100aa9aa = 1;
            }
        }
        thread on_death();
    }

    // Namespace csceneactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x1a0
    // Size: 0x4
    function _spawn_ent() {
        
    }

}

// Namespace scene
// Method(s) 2 Total 73
class cscenefakeactor : csceneactor, csceneobject {

    // Namespace cscenefakeactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xac37cb5d, Offset: 0x1608
    // Size: 0x14
    function __destructor() {
        csceneactor::__destructor();
    }

    // Namespace cscenefakeactor/scene_actor_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbdf18c73, Offset: 0x15e8
    // Size: 0x14
    function __constructor() {
        csceneactor::__constructor();
    }

}

