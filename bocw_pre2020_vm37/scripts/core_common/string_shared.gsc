#namespace string;

/#

    // Namespace string/string_shared
    // Params 3
    // Checksum 0x10b0b037, Offset: 0x60
    // Size: 0x8e, Type: dev
    function rjust( str_input, n_length, str_fill )
    {
        if ( !isdefined( str_fill ) )
        {
            str_fill = "<dev string:x38>";
        }
        
        str_input = isdefined( str_input ) ? "<dev string:x3d>" + str_input : "<dev string:x3d>";
        n_fill_length = n_length - str_input.size;
        str_fill = fill( n_fill_length, str_fill );
        return str_fill + str_input;
    }

    // Namespace string/string_shared
    // Params 3
    // Checksum 0x68924dd, Offset: 0xf8
    // Size: 0x8e, Type: dev
    function ljust( str_input, n_length, str_fill )
    {
        if ( !isdefined( str_fill ) )
        {
            str_fill = "<dev string:x38>";
        }
        
        str_input = isdefined( str_input ) ? "<dev string:x3d>" + str_input : "<dev string:x3d>";
        n_fill_length = n_length - str_input.size;
        str_fill = fill( n_fill_length, str_fill );
        return str_input + str_fill;
    }

    // Namespace string/string_shared
    // Params 2
    // Checksum 0x8fa77260, Offset: 0x190
    // Size: 0xa6, Type: dev
    function fill( n_length, str_fill )
    {
        if ( !isdefined( str_fill ) || str_fill == "<dev string:x3d>" )
        {
            str_fill = "<dev string:x38>";
        }
        
        str_return = "<dev string:x3d>";
        
        while ( n_length > 0 )
        {
            str = getsubstr( str_fill, 0, n_length );
            n_length -= str.size;
            str_return += str;
        }
        
        return str_return;
    }

#/
