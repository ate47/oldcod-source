#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace debug_menu;

// Namespace debug_menu/debug_menu_shared
// Params 2, eflags: 0x0
// Checksum 0x54ddf382, Offset: 0x150
// Size: 0xcc
function open(localclientnum, a_menu_items) {
    close(localclientnum);
    level flagsys::set("menu_open");
    populatescriptdebugmenu(localclientnum, a_menu_items);
    luiload("uieditor.menus.ScriptDebugMenu");
    level.scriptdebugmenu = createluimenu(localclientnum, "ScriptDebugMenu");
    openluimenu(localclientnum, level.scriptdebugmenu);
}

// Namespace debug_menu/debug_menu_shared
// Params 1, eflags: 0x0
// Checksum 0x44d216ba, Offset: 0x228
// Size: 0x66
function close(localclientnum) {
    level flagsys::clear("menu_open");
    if (isdefined(level.scriptdebugmenu)) {
        closeluimenu(localclientnum, level.scriptdebugmenu);
        level.scriptdebugmenu = undefined;
    }
}

// Namespace debug_menu/debug_menu_shared
// Params 3, eflags: 0x0
// Checksum 0xd43626e5, Offset: 0x298
// Size: 0xb4
function set_item_text(localclientnum, index, name) {
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
    model = getuimodel(parentmodel, "name");
    setuimodelvalue(model, name);
}

// Namespace debug_menu/debug_menu_shared
// Params 3, eflags: 0x0
// Checksum 0x59d82ad7, Offset: 0x358
// Size: 0x11c
function set_item_color(localclientnum, index, color) {
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
    model = getuimodel(parentmodel, "color");
    if (isvec(color)) {
        color = "" + color[0] * 255 + " " + color[1] * 255 + " " + color[2] * 255;
    }
    setuimodelvalue(model, color);
}

