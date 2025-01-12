#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/table_shared;
#using scripts/core_common/util_shared;

#namespace zm_frontend_zm_bgb_chance;

/#

    // Namespace zm_frontend_zm_bgb_chance/frontend_zm_bgb_chance
    // Params 0, eflags: 0x0
    // Checksum 0xb5d918a0, Offset: 0x1d8
    // Size: 0x1c
    function zm_frontend_bgb_slots_logic() {
        level thread zm_frontend_bgb_devgui();
    }

    // Namespace zm_frontend_zm_bgb_chance/frontend_zm_bgb_chance
    // Params 0, eflags: 0x0
    // Checksum 0x876cd18f, Offset: 0x200
    // Size: 0x1bc
    function zm_frontend_bgb_devgui() {
        setdvar("<dev string:x28>", "<dev string:x44>");
        setdvar("<dev string:x45>", "<dev string:x44>");
        bgb_devgui_base = "<dev string:x62>";
        a_n_amounts = array(1, 5, 10, 100);
        for (i = 0; i < a_n_amounts.size; i++) {
            n_amount = a_n_amounts[i];
            adddebugcommand(bgb_devgui_base + i + "<dev string:x7c>" + n_amount + "<dev string:x84>" + n_amount + "<dev string:x95>");
        }
        adddebugcommand("<dev string:x99>" + "<dev string:xc6>" + "<dev string:x28>" + "<dev string:xca>" + 1 + "<dev string:xcc>");
        adddebugcommand("<dev string:xcf>" + "<dev string:xc6>" + "<dev string:x45>" + "<dev string:xca>" + 1 + "<dev string:xcc>");
        level thread bgb_devgui_think();
    }

    // Namespace zm_frontend_zm_bgb_chance/frontend_zm_bgb_chance
    // Params 0, eflags: 0x0
    // Checksum 0x105cce34, Offset: 0x3c8
    // Size: 0x1c0
    function bgb_devgui_think() {
        b_powerboost_toggle = 0;
        b_successfail_toggle = 0;
        for (;;) {
            n_val_powerboost = getdvarstring("<dev string:x28>");
            n_val_successfail = getdvarstring("<dev string:x45>");
            if (n_val_powerboost != "<dev string:x44>") {
                b_powerboost_toggle = !b_powerboost_toggle;
                level clientfield::set("<dev string:xfd>", b_powerboost_toggle);
                if (b_powerboost_toggle) {
                    iprintlnbold("<dev string:x118>");
                } else {
                    iprintlnbold("<dev string:x12e>");
                }
            }
            if (n_val_successfail != "<dev string:x44>") {
                b_successfail_toggle = !b_successfail_toggle;
                level clientfield::set("<dev string:x145>", b_successfail_toggle);
                if (b_successfail_toggle) {
                    iprintlnbold("<dev string:x161>");
                } else {
                    iprintlnbold("<dev string:x16e>");
                }
            }
            setdvar("<dev string:x28>", "<dev string:x44>");
            setdvar("<dev string:x45>", "<dev string:x44>");
            wait 0.5;
        }
    }

#/
