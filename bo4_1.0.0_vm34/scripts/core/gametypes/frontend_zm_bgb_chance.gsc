#using scripts\core_common\clientfield_shared;

#namespace zm_frontend_zm_bgb_chance;

/#

    // Namespace zm_frontend_zm_bgb_chance/frontend_zm_bgb_chance
    // Params 0, eflags: 0x0
    // Checksum 0x8c4b7c1b, Offset: 0x70
    // Size: 0x1c
    function zm_frontend_bgb_slots_logic() {
        level thread zm_frontend_bgb_devgui();
    }

    // Namespace zm_frontend_zm_bgb_chance/frontend_zm_bgb_chance
    // Params 0, eflags: 0x0
    // Checksum 0xe8ba427, Offset: 0x98
    // Size: 0x1c4
    function zm_frontend_bgb_devgui() {
        setdvar(#"bgb_test_power_boost_devgui", "<dev string:x30>");
        setdvar(#"bgb_test_success_fail_devgui", "<dev string:x30>");
        bgb_devgui_base = "<dev string:x31>";
        a_n_amounts = array(1, 5, 10, 100);
        for (i = 0; i < a_n_amounts.size; i++) {
            n_amount = a_n_amounts[i];
            adddebugcommand(bgb_devgui_base + i + "<dev string:x4b>" + n_amount + "<dev string:x53>" + n_amount + "<dev string:x64>");
        }
        adddebugcommand("<dev string:x68>" + "<dev string:x95>" + "<dev string:x99>" + "<dev string:xb5>" + 1 + "<dev string:xb7>");
        adddebugcommand("<dev string:xba>" + "<dev string:x95>" + "<dev string:xe8>" + "<dev string:xb5>" + 1 + "<dev string:xb7>");
        level thread bgb_devgui_think();
    }

    // Namespace zm_frontend_zm_bgb_chance/frontend_zm_bgb_chance
    // Params 0, eflags: 0x0
    // Checksum 0xc373a3ef, Offset: 0x268
    // Size: 0x1c8
    function bgb_devgui_think() {
        b_powerboost_toggle = 0;
        b_successfail_toggle = 0;
        for (;;) {
            n_val_powerboost = getdvarstring(#"bgb_test_power_boost_devgui");
            n_val_successfail = getdvarstring(#"bgb_test_success_fail_devgui");
            if (n_val_powerboost != "<dev string:x30>") {
                b_powerboost_toggle = !b_powerboost_toggle;
                level clientfield::set("<dev string:x105>", b_powerboost_toggle);
                if (b_powerboost_toggle) {
                    iprintlnbold("<dev string:x120>");
                } else {
                    iprintlnbold("<dev string:x136>");
                }
            }
            if (n_val_successfail != "<dev string:x30>") {
                b_successfail_toggle = !b_successfail_toggle;
                level clientfield::set("<dev string:x14d>", b_successfail_toggle);
                if (b_successfail_toggle) {
                    iprintlnbold("<dev string:x169>");
                } else {
                    iprintlnbold("<dev string:x176>");
                }
            }
            setdvar(#"bgb_test_power_boost_devgui", "<dev string:x30>");
            setdvar(#"bgb_test_success_fail_devgui", "<dev string:x30>");
            wait 0.5;
        }
    }

#/
