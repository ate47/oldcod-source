#namespace string;

/#

    // Namespace string/string_shared
    // Params 3, eflags: 0x0
    // Checksum 0x36ad44ad, Offset: 0x68
    // Size: 0x92
    function rjust(str_input, n_length, str_fill) {
        if (!isdefined(str_fill)) {
            str_fill = "<dev string:x30>";
        }
        str_input = isdefined(str_input) ? "<dev string:x32>" + str_input : "<dev string:x32>";
        n_fill_length = n_length - str_input.size;
        str_fill = fill(n_fill_length, str_fill);
        return str_fill + str_input;
    }

    // Namespace string/string_shared
    // Params 3, eflags: 0x0
    // Checksum 0xdbc70678, Offset: 0x108
    // Size: 0x92
    function ljust(str_input, n_length, str_fill) {
        if (!isdefined(str_fill)) {
            str_fill = "<dev string:x30>";
        }
        str_input = isdefined(str_input) ? "<dev string:x32>" + str_input : "<dev string:x32>";
        n_fill_length = n_length - str_input.size;
        str_fill = fill(n_fill_length, str_fill);
        return str_input + str_fill;
    }

    // Namespace string/string_shared
    // Params 2, eflags: 0x0
    // Checksum 0x207e5f56, Offset: 0x1a8
    // Size: 0xae
    function fill(n_length, str_fill) {
        if (!isdefined(str_fill) || str_fill == "<dev string:x32>") {
            str_fill = "<dev string:x30>";
        }
        for (str_return = "<dev string:x32>"; n_length > 0; str_return += str) {
            str = getsubstr(str_fill, 0, n_length);
            n_length -= str.size;
        }
        return str_return;
    }

#/
