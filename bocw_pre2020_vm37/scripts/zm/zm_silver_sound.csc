#using scripts\core_common\struct;

#namespace zm_silver_sound;

// Namespace zm_silver_sound/zm_silver_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xf0435fd7, Offset: 0xa8
// Size: 0x34
function init() {
    level thread startzmbspawnersoundloops();
    level thread function_91c6e82a();
}

// Namespace zm_silver_sound/zm_silver_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xbc65da4a, Offset: 0xe8
// Size: 0x16c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("spawn_location", "script_noteworthy");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                println("<dev string:x38>" + loopers.size + "<dev string:x73>");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            if (isdefined(loopers[i].script_sound)) {
                continue;
            }
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
        return;
    }
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x81>");
        }
    #/
}

// Namespace zm_silver_sound/zm_silver_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x2716d532, Offset: 0x260
// Size: 0x18a
function soundloopthink() {
    if (!isdefined(self.origin)) {
        return;
    }
    if (!isdefined(self.script_sound)) {
        self.script_sound = "zmb_spawn_walla";
    }
    notifyname = "";
    assert(isdefined(notifyname));
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    assert(isdefined(notifyname));
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundloopemitter(self.script_sound, self.origin + (0, 0, 60));
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoploopemitter(self.script_sound, self.origin + (0, 0, 60));
            } else {
                soundloopemitter(self.script_sound, self.origin + (0, 0, 60));
            }
            started = !started;
        }
    }
}

// Namespace zm_silver_sound/zm_silver_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xfaaeee7c, Offset: 0x3f8
// Size: 0x15c
function function_91c6e82a() {
    level waittill(#"power_on");
    playsound(0, #"hash_61832f7330aa03c", (524, -84, -268));
    playsound(0, #"hash_129c564608f837b6", (524, -84, -268));
    wait 0.1;
    playsound(0, #"hash_487cbd8d6e939533", (524, -84, -268));
    wait 0.4;
    playsound(0, #"hash_43dad678bc35ddb7", (524, -84, -268));
    wait 0.5;
    playsound(0, #"hash_43dad678bc35ddb7", (-744, -1392, -322));
    wait 0.5;
    playsound(0, #"hash_43dad678bc35ddb7", (1641, 970, -360));
}

