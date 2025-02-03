#using script_1d29de500c266470;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace player_free_fall;

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x6
// Checksum 0x5f84f593, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_free_fall", &preinit, undefined, undefined, undefined);
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x4
// Checksum 0x722539fe, Offset: 0x138
// Size: 0x134
function private preinit() {
    level.var_7abaaef1 = getdvarint(#"player_freefall", 0);
    if (is_true(level.var_7abaaef1)) {
        function_7c19fac2();
        return;
    }
    callback::add_callback(#"debug_movement", &function_a7e644f6);
    callback::add_callback(#"freefall", &function_a0950b54);
    callback::add_callback(#"parachute", &function_c75bd5cb);
    callback::add_callback(#"skydive_end", &function_f99c2453);
    /#
        level thread function_1fc427dc();
    #/
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x950067df, Offset: 0x278
// Size: 0x64
function function_a0950b54(*var_23c2e47f) {
    self val::set(#"player_free_fall", "show_weapon_hud", 0);
    self callback::function_d8abfc3d(#"death", &function_c76a70ab);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x7ef84063, Offset: 0x2e8
// Size: 0x34
function function_c75bd5cb(*var_23c2e47f) {
    self val::set(#"player_free_fall", "show_weapon_hud", 0);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x4ddaa2d3, Offset: 0x328
// Size: 0x64
function function_f99c2453(*var_23c2e47f) {
    self val::reset(#"player_free_fall", "show_weapon_hud");
    self callback::function_52ac9652(#"death", &function_c76a70ab);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0xfa5c418a, Offset: 0x398
// Size: 0x64
function function_c76a70ab(*var_23c2e47f) {
    self val::reset(#"player_free_fall", "show_weapon_hud");
    self callback::function_52ac9652(#"death", &function_c76a70ab);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x5eeb6454, Offset: 0x408
// Size: 0xc4
function allow_player_basejumping(bool) {
    if (!isdefined(self.enabledbasejumping)) {
        self.enabledbasejumping = 0;
    }
    if (bool) {
        self.enabledbasejumping++;
        self function_8b8a321a(1);
        self function_8a945c0e(1);
        return;
    }
    self.enabledbasejumping--;
    if (self.enabledbasejumping < 0) {
        self.enabledbasejumping = 0;
    }
    if (!self.enabledbasejumping) {
        self function_8b8a321a(0);
        self function_8a945c0e(0);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0xcee5ec36, Offset: 0x4d8
// Size: 0xcc
function function_2979b1be(waitsec) {
    self endon(#"death", #"disconnect");
    if (isdefined(waitsec) && waitsec > 0) {
        self function_8a945c0e(0);
        self function_8b8a321a(0);
        wait waitsec;
    }
    if (isdefined(self)) {
        if (self player_insertion::function_b9370594()) {
            return;
        }
        self function_8a945c0e(1);
        self function_8b8a321a(1);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 2, eflags: 0x0
// Checksum 0xe7423eb1, Offset: 0x5b0
// Size: 0xb4
function function_7705a7fc(fall_time, velocity) {
    if (is_true(level.var_7abaaef1)) {
        self forcefreefall(1, velocity, 1);
        return;
    }
    self function_8cf53a19();
    if (isdefined(velocity)) {
        self setvelocity(velocity);
    }
    self function_b02c52b();
    wait fall_time;
    self thread function_a1fa2219();
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x670
// Size: 0x4
function parachutemidairdeathwatcher() {
    
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0xc242bcb9, Offset: 0x680
// Size: 0xe4
function function_a1fa2219() {
    self endon(#"death", #"disconnect");
    self thread function_2979b1be(3);
    self waittill(#"skydive_deployparachute");
    self function_8a945c0e(0);
    self notify(#"freefall_complete");
    if (!is_true(level.dontshootwhileparachuting) && isdefined(level.parachuteopencb)) {
        self [[ level.parachuteopencb ]]();
    }
    self thread function_156d91ef();
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0xe5d8b714, Offset: 0x770
// Size: 0x148
function function_156d91ef() {
    self endon(#"death", #"disconnect");
    if (getdvarint(#"scr_parachute_camera_transition_mode", 1) == 1) {
        self function_41170420(0);
    }
    self waittill(#"skydive_end");
    waitframe(1);
    if (isdefined(level.parachuterestoreweaponscb)) {
        self [[ level.parachuterestoreweaponscb ]]();
    }
    if (is_true(level.dontshootwhileparachuting) && isdefined(level.parachutecompletecb)) {
        self [[ level.parachutecompletecb ]]();
    }
    self notify(#"parachute_landed");
    self function_41170420(0);
    self notify(#"parachute_complete");
    if (isdefined(level.onfirstlandcallback)) {
        self [[ level.onfirstlandcallback ]](self);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0xe3049410, Offset: 0x8c0
// Size: 0x4c
function function_5352af94() {
    player = self;
    player function_8cf53a19();
    if (isdefined(player.parachute)) {
        player.parachute delete();
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x43c5df1d, Offset: 0x918
// Size: 0xec
function private function_a7e644f6(eventstruct) {
    if (!eventstruct.debug_movement) {
        if (getdvarint(#"hash_bfa71d08f383550", 0)) {
            speed = 17.6 * getdvarint(#"hash_3d4ce3a554eac78", 100);
            velocity = anglestoforward(self getplayerangles()) * speed;
            self function_7705a7fc(getdvarint(#"hash_bfa71d08f383550", 0) == 1, velocity);
        }
    }
}

/#

    // Namespace player_free_fall/player_free_fall
    // Params 0, eflags: 0x4
    // Checksum 0xd83e6033, Offset: 0xa10
    // Size: 0x44
    function private function_1fc427dc() {
        waitframe(1);
        waitframe(1);
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x65>");
    }

#/

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x4
// Checksum 0xa5c06fd5, Offset: 0xa60
// Size: 0xac
function private function_7c19fac2() {
    callback::add_callback(#"freefall", &function_6a663396);
    callback::add_callback(#"parachute", &function_bd421742);
    callback::add_callback(#"debug_movement", &function_a7e644f6);
    /#
        level thread function_1fc427dc();
    #/
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0xaf942a4e, Offset: 0xb18
// Size: 0x52
function function_d2a1520c() {
    wingsuit = self namespace_eb06e24d::get_wingsuit();
    if (self util::is_female()) {
        return wingsuit.var_5677bd3d;
    }
    return wingsuit.var_94166112;
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0xcce62cab, Offset: 0xb78
// Size: 0x8c
function function_27f21242(freefall) {
    model = function_d2a1520c();
    if (freefall) {
        if (!self isattached(model)) {
            self attach(model);
        }
        return;
    }
    if (self isattached(model)) {
        self detach(model);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x1878c443, Offset: 0xc10
// Size: 0x184
function private function_6a663396(eventstruct) {
    if (eventstruct.freefall) {
        if (!isdefined(eventstruct.var_695a7111) || eventstruct.var_695a7111) {
            parachute = self namespace_eb06e24d::get_parachute();
            parachute_weapon = parachute.("parachute");
            if (isdefined(parachute_weapon)) {
                if (!self hasweapon(parachute_weapon)) {
                    self giveweapon(parachute_weapon);
                }
                self switchtoweaponimmediate(parachute_weapon);
                self thread function_b6e83203(0.5);
            }
        }
        return;
    }
    if (!self function_9a0edd92()) {
        parachute = self namespace_eb06e24d::get_parachute();
        parachute_weapon = parachute.("parachute");
        if (isdefined(parachute_weapon)) {
            if (self hasweapon(parachute_weapon)) {
                self takeweapon(parachute_weapon);
            }
        }
    }
    self setclientuivisibilityflag("weapon_hud_visible", 1);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x397fe5ce, Offset: 0xda0
// Size: 0x3a
function private function_6aac1790(var_dbb94a) {
    if (isdefined(var_dbb94a) && !self isattached(var_dbb94a, "tag_weapon_right")) {
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0xadf6bd9a, Offset: 0xde8
// Size: 0x8c
function private function_b6e83203(delay) {
    if (isdefined(delay)) {
        self endon(#"death", #"disconnect");
        wait delay;
    }
    parachute = self namespace_eb06e24d::get_parachute();
    var_dbb94a = parachute.("parachuteLit");
    function_6aac1790(var_dbb94a);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x496fc7d0, Offset: 0xe80
// Size: 0xcc
function private function_bd421742(eventstruct) {
    if (eventstruct.parachute) {
        self function_b6e83203();
        return;
    }
    parachute = self namespace_eb06e24d::get_parachute();
    parachute_weapon = parachute.("parachute");
    var_dbb94a = parachute.("parachuteLit");
    if (isdefined(parachute_weapon)) {
        self takeweapon(parachute_weapon);
    }
    if (isdefined(var_dbb94a)) {
    }
    self setclientuivisibilityflag("weapon_hud_visible", 1);
}

/#

    // Namespace player_free_fall/player_free_fall
    // Params 0, eflags: 0x4
    // Checksum 0x79138ed5, Offset: 0xf58
    // Size: 0x164
    function private function_a2b7e8a1() {
        mapname = util::get_map_name();
        waitframe(1);
        waitframe(1);
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x65>");
        adddebugcommand("<dev string:x9b>");
        adddebugcommand("<dev string:xc1>");
        adddebugcommand("<dev string:xe6>" + mapname + "<dev string:xf5>");
        adddebugcommand("<dev string:x12d>" + mapname + "<dev string:x13f>");
        adddebugcommand("<dev string:x12d>" + mapname + "<dev string:x176>");
        adddebugcommand("<dev string:x12d>" + mapname + "<dev string:x1b8>");
        waitframe(1);
        adddebugcommand("<dev string:x202>" + mapname + "<dev string:x213>");
    }

#/
