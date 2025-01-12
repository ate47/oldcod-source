#using scripts\core_common\flag_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\zm_devgui;

#namespace zm_callings_devgui;

/#

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x474e8cdc, Offset: 0x78
    // Size: 0x1c4
    function function_9f47471() {
        level flag::wait_till("<dev string:x38>");
        zm_devgui::add_custom_devgui_callback(&function_6cbc14bb);
        if (!isdefined(level.var_314051a1)) {
            return;
        }
        var_94237d8 = array(#"hash_20deab97abbf7b12", #"hash_764a5fc3ba8820d2", #"hash_647ebc7d24425fee", #"tcmgoal");
        i = 0;
        foreach (var_acbd7392 in var_94237d8) {
            var_31e48984 = "<dev string:x54>" + function_9e72a96(var_acbd7392);
            adddebugcommand("<dev string:x77>" + function_9e72a96(var_acbd7392) + "<dev string:xac>" + i + "<dev string:xb6>" + var_31e48984 + "<dev string:xcb>");
            i += 1;
        }
        adddebugcommand("<dev string:xd1>");
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xecb838c7, Offset: 0x248
    // Size: 0x57c
    function function_1d4f22e4(cmd) {
        if (strstartswith(cmd, "<dev string:x138>")) {
            str = strreplace(cmd, "<dev string:x138>", "<dev string:x154>");
            arr = strtok(str, "<dev string:x158>");
            taskid = arr[0];
            taskid = int(taskid);
            setdvar(#"zm_active_daily_calling", taskid);
            setdvar(#"zm_active_event_calling", 0);
            setdvar(#"hash_acdd08b365cb62f", 1);
            return;
        }
        if (strstartswith(cmd, "<dev string:x54>")) {
            str = strreplace(cmd, "<dev string:x54>", "<dev string:x154>");
            var_762ca590 = hash(str);
            if (!getdvarint(#"hash_11da02ca40639de5", 0)) {
                iprintln("<dev string:x15d>" + self.name);
            } else if (!getdvarint(#"hash_66c8247d6d84d328", 0) || !getdvarint(#"hash_5341de25cb0d6f66", 0) || !getdvarint(#"hash_47067c5d4fe9075e", 0)) {
                iprintln("<dev string:x183>");
            } else if (!isdefined(self.var_96d6f6d1)) {
                iprintln(self.name + "<dev string:x1b6>");
            } else {
                var_fe8112e6 = 0;
                foreach (var_d1017f27 in self.var_96d6f6d1) {
                    if (var_d1017f27.var_30c47a21 == var_762ca590) {
                        self zm_callings::function_4368582a(var_d1017f27, var_d1017f27.var_e226ec4f);
                        var_fe8112e6 = 1;
                    }
                }
                if (!is_true(var_fe8112e6)) {
                    iprintln(self.name + "<dev string:x1dc>" + function_9e72a96(var_762ca590) + "<dev string:x1e3>");
                }
            }
            return;
        }
        if (strstartswith(cmd, "<dev string:x20c>")) {
            str = strreplace(cmd, "<dev string:x20c>", "<dev string:x154>");
            arr = strtok(str, "<dev string:x158>");
            interval = arr[0];
            interval = int(interval);
            if (!getdvarint(#"hash_11da02ca40639de5", 0)) {
                iprintln("<dev string:x15d>" + self.name);
                return;
            }
            if (!getdvarint(#"hash_66c8247d6d84d328", 0) || !getdvarint(#"hash_5341de25cb0d6f66", 0) || !getdvarint(#"hash_47067c5d4fe9075e", 0)) {
                iprintln("<dev string:x183>");
                return;
            }
            if (!isdefined(self.var_96d6f6d1)) {
                iprintln(self.name + "<dev string:x1b6>");
                return;
            }
            self thread function_8a37e046(interval);
        }
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xed43cbc2, Offset: 0x7d0
    // Size: 0x11e
    function function_8a37e046(n_interval) {
        foreach (var_d1017f27 in self.var_96d6f6d1) {
            progress = self zm_callings::function_4368582a(var_d1017f27, 0);
            if (isdefined(progress)) {
                target = var_d1017f27.var_e226ec4f;
                iprintln(self.name + "<dev string:x223>" + function_9e72a96(var_d1017f27.var_ad971622) + "<dev string:x237>" + progress + "<dev string:x24a>" + target);
            }
            wait n_interval;
        }
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x67acd5f, Offset: 0x8f8
    // Size: 0xc0
    function function_6cbc14bb(cmd) {
        foreach (p in level.players) {
            if (!isdefined(p)) {
                continue;
            }
            if (isbot(p)) {
                continue;
            }
            p function_1d4f22e4(cmd);
        }
    }

#/
