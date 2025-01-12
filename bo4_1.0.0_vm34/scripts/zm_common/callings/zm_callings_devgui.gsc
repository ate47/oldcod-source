#using scripts\core_common\flag_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\zm_devgui;

#namespace zm_callings_devgui;

/#

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x316a7e0f, Offset: 0x80
    // Size: 0x208
    function function_a079185a() {
        for (var_5b4eaff4 = 0; var_5b4eaff4 <= 3; var_5b4eaff4++) {
            for (slot = 0; slot < 4; slot++) {
                var_91f3f8eb = undefined;
                if (var_5b4eaff4 == 1) {
                    if (slot == 0) {
                        var_91f3f8eb = "<dev string:x30>";
                    } else if (slot == 1) {
                        var_91f3f8eb = "<dev string:x3b>";
                    } else if (slot == 2) {
                        var_91f3f8eb = "<dev string:x49>";
                    } else if (slot >= 3) {
                        break;
                    }
                } else if (var_5b4eaff4 == 2) {
                    var_91f3f8eb = "<dev string:x57>" + slot + 1;
                } else if (var_5b4eaff4 == 3) {
                    if (slot == 0) {
                        var_91f3f8eb = "<dev string:x30>";
                    } else if (slot == 1) {
                        var_91f3f8eb = "<dev string:x65>";
                    } else if (slot >= 2) {
                        break;
                    }
                } else {
                    break;
                }
                adddebugcommand("<dev string:x74>" + var_91f3f8eb + "<dev string:xa7>");
                adddebugcommand("<dev string:xab>" + var_91f3f8eb + "<dev string:xd3>" + slot + 1 + "<dev string:xd5>");
                adddebugcommand("<dev string:xd8>" + var_91f3f8eb + "<dev string:xd3>" + slot + 1 + "<dev string:xd5>");
            }
        }
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xca1e3db8, Offset: 0x290
    // Size: 0x32e
    function function_c3c2478c(var_5b4eaff4) {
        function_a079185a();
        for (slot = 0; slot < 4; slot++) {
            var_91f3f8eb = undefined;
            if (var_5b4eaff4 == 1) {
                if (slot == 0) {
                    var_91f3f8eb = "<dev string:x30>";
                } else if (slot == 1) {
                    var_91f3f8eb = "<dev string:x3b>";
                } else if (slot == 2) {
                    var_91f3f8eb = "<dev string:x49>";
                } else if (slot >= 3) {
                    break;
                }
            } else if (var_5b4eaff4 == 2) {
                var_91f3f8eb = "<dev string:x57>" + slot + 1;
            } else if (var_5b4eaff4 == 3) {
                if (slot == 0) {
                    var_91f3f8eb = "<dev string:x30>";
                } else if (slot == 1) {
                    var_91f3f8eb = "<dev string:x65>";
                } else if (slot >= 2) {
                    break;
                }
            } else {
                break;
            }
            for (taskid = 0; taskid < level.var_29e827fa.tasklist.size; taskid++) {
                task = zm_callings::function_b6d849b8(taskid);
                taskname = makelocalizedstring(task.taskname);
                adddebugcommand("<dev string:x103>" + var_91f3f8eb + "<dev string:x133>" + taskname + "<dev string:xd3>" + taskid + 1 + "<dev string:x135>" + slot + "<dev string:x159>" + taskid + "<dev string:xd5>");
            }
            adddebugcommand("<dev string:x15b>" + var_91f3f8eb + "<dev string:xd3>" + slot + 1 + "<dev string:x180>" + slot + "<dev string:xd5>");
            adddebugcommand("<dev string:x1a1>" + var_91f3f8eb + "<dev string:xd3>" + slot + 1 + "<dev string:x1c9>" + slot + "<dev string:xd5>");
            adddebugcommand("<dev string:x1ed>" + var_91f3f8eb + "<dev string:xd3>" + slot + 1 + "<dev string:x21b>" + slot + "<dev string:xd5>");
        }
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9925324a, Offset: 0x5c8
    // Size: 0x174
    function function_8aec39bb() {
        level flag::wait_till("<dev string:x244>");
        zm_devgui::add_custom_devgui_callback(&function_692f4f83);
        if (!isdefined(level.var_29e827fa)) {
            return;
        }
        adddebugcommand("<dev string:x25d>");
        adddebugcommand("<dev string:x2ab>");
        adddebugcommand("<dev string:x301>");
        adddebugcommand("<dev string:x355>");
        foreach (p in level.players) {
            if (!isdefined(p)) {
                continue;
            }
            if (isbot(p)) {
                continue;
            }
            var_5b4eaff4 = p zm_callings::function_e0c8bbf5();
            function_c3c2478c(var_5b4eaff4);
            break;
        }
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7974e7ae, Offset: 0x748
    // Size: 0x554
    function function_72fdc8ad(cmd) {
        if (strstartswith(cmd, "<dev string:x3ad>")) {
            str = strreplace(cmd, "<dev string:x3ad>", "<dev string:x3c0>");
            arr = strtok(str, "<dev string:x159>");
            slot = arr[0];
            task = arr[1];
            self zm_callings::function_6bdfe3f9(int(slot), int(task));
            iprintln(self.name + "<dev string:x3c1>" + slot + "<dev string:x3d2>" + self zm_callings::function_cbbdaadd(int(slot)));
            return;
        }
        if (strstartswith(cmd, "<dev string:x3db>")) {
            slot = strreplace(cmd, "<dev string:x3db>", "<dev string:x3c0>");
            self zm_callings::function_1356e476(int(slot));
            iprintln(self.name + "<dev string:x3c1>" + slot + "<dev string:x3eb>");
            return;
        }
        if (strstartswith(cmd, "<dev string:x3f6>")) {
            slot = strreplace(cmd, "<dev string:x3f6>", "<dev string:x3c0>");
            self zm_callings::function_59516288(int(slot));
            if (isdefined(self zm_callings::function_8f381695(int(slot))) && self zm_callings::function_8f381695(int(slot))) {
                iprintln(self.name + "<dev string:x3c1>" + slot + "<dev string:x409>");
            } else {
                iprintln(self.name + "<dev string:x3c1>" + slot + "<dev string:x418>");
            }
            return;
        }
        if (strstartswith(cmd, "<dev string:x42b>")) {
            slot = strreplace(cmd, "<dev string:x42b>", "<dev string:x3c0>");
            progress = self zm_callings::function_a56ef669(int(slot));
            target = self zm_callings::function_2e5b79db(int(slot));
            iprintln(self.name + "<dev string:x3c1>" + slot + "<dev string:x443>" + progress + "<dev string:x133>" + target);
            return;
        }
        if (strstartswith(cmd, "<dev string:x453>")) {
            var_f1a34efb = strreplace(cmd, "<dev string:x453>", "<dev string:x3c0>");
            var_5b4eaff4 = 0;
            switch (var_f1a34efb) {
            case #"personal":
                var_5b4eaff4 = 1;
                break;
            case #"faction":
                var_5b4eaff4 = 2;
                self zm_callings::function_cbdffba5(1);
                break;
            case #"Community":
                var_5b4eaff4 = 3;
                break;
            }
            self zm_callings::function_432adbf1(var_5b4eaff4);
            var_5b4eaff4 = self zm_callings::function_e0c8bbf5();
            function_c3c2478c(var_5b4eaff4);
            iprintln(self.name + "<dev string:x460>" + var_5b4eaff4);
        }
    }

    // Namespace zm_callings_devgui/zm_callings_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x3f1d9259, Offset: 0xca8
    // Size: 0xb8
    function function_692f4f83(cmd) {
        foreach (p in level.players) {
            if (!isdefined(p)) {
                continue;
            }
            if (isbot(p)) {
                continue;
            }
            p function_72fdc8ad(cmd);
        }
    }

#/
