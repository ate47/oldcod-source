#using scripts/core_common/array_shared;

#namespace string;

/#

    // Namespace string/string_shared
    // Params 3, eflags: 0x0
    // Checksum 0xd591c12, Offset: 0xa8
    // Size: 0xa4
    function rjust(str_input, n_length, str_fill) {
        if (!isdefined(str_fill)) {
            str_fill = "<dev string:x28>";
        }
        str_input = isdefined(str_input) ? "<dev string:x2a>" + str_input : "<dev string:x2a>";
        n_fill_length = n_length - str_input.size;
        str_fill = fill(n_fill_length, str_fill);
        return str_fill + str_input;
    }

    // Namespace string/string_shared
    // Params 3, eflags: 0x0
    // Checksum 0xf90f83f7, Offset: 0x158
    // Size: 0xa4
    function ljust(str_input, n_length, str_fill) {
        if (!isdefined(str_fill)) {
            str_fill = "<dev string:x28>";
        }
        str_input = isdefined(str_input) ? "<dev string:x2a>" + str_input : "<dev string:x2a>";
        n_fill_length = n_length - str_input.size;
        str_fill = fill(n_fill_length, str_fill);
        return str_input + str_fill;
    }

    // Namespace string/string_shared
    // Params 2, eflags: 0x0
    // Checksum 0x443a357e, Offset: 0x208
    // Size: 0xb4
    function fill(n_length, str_fill) {
        if (!isdefined(str_fill) || str_fill == "<dev string:x2a>") {
            str_fill = "<dev string:x28>";
        }
        for (str_return = "<dev string:x2a>"; n_length > 0; str_return += str) {
            str = getsubstr(str_fill, 0, n_length);
            n_length -= str.size;
        }
        return str_return;
    }

#/
