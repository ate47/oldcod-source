#using scripts\core_common\flagsys_shared;

#namespace debug_menu;

// Namespace debug_menu/debug_menu_shared
// Params 2, eflags: 0x0
// Checksum 0x91ab2f83, Offset: 0xc8
// Size: 0xc4
function open(localclientnum, a_menu_items) {
    close(localclientnum);
    level flagsys::set(#"menu_open");
    populatescriptdebugmenu(localclientnum, a_menu_items);
    luiload("uieditor.menus.ScriptDebugMenu");
    level.scriptdebugmenu = createluimenu(localclientnum, "ScriptDebugMenu");
    openluimenu(localclientnum, level.scriptdebugmenu);
}

// Namespace debug_menu/debug_menu_shared
// Params 1, eflags: 0x0
// Checksum 0x44bf9e12, Offset: 0x198
// Size: 0x66
function close(localclientnum) {
    level flagsys::clear(#"menu_open");
    if (isdefined(level.scriptdebugmenu)) {
        closeluimenu(localclientnum, level.scriptdebugmenu);
        level.scriptdebugmenu = undefined;
    }
}

// Namespace debug_menu/debug_menu_shared
// Params 3, eflags: 0x0
// Checksum 0x7953d4a5, Offset: 0x208
// Size: 0xac
function set_item_text(localclientnum, index, name) {
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
    model = getuimodel(parentmodel, "name");
    setuimodelvalue(model, name);
}

// Namespace debug_menu/debug_menu_shared
// Params 3, eflags: 0x0
// Checksum 0x2cd65278, Offset: 0x2c0
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

