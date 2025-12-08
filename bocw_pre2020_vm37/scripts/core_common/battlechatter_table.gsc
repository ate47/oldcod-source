#using scripts\core_common\array_shared;

#namespace battlechatter_table;

// Namespace battlechatter_table/battlechatter_table
// Params 2, eflags: 0x20 variadic
// Checksum 0x8d661444, Offset: 0x78
// Size: 0x148
function function_c5dda35e( category, ... )
{
    level.bctable[ category ] = [];
    
    foreach ( filename in vararg )
    {
        if ( isarray( filename ) )
        {
            foreach ( file in filename )
            {
                function_b8e1addf( category, file );
            }
            
            continue;
        }
        
        function_b8e1addf( category, filename );
    }
}

// Namespace battlechatter_table/battlechatter_table
// Params 2
// Checksum 0x423d8111, Offset: 0x1c8
// Size: 0x2ae
function function_b8e1addf( category, filename )
{
    for ( row = 0; true ; row++ )
    {
        tbltype = tablelookupcolumnforrow( filename, row, 0 );
        
        if ( !isdefined( tbltype ) )
        {
            return;
        }
        
        tbltype = tolower( tbltype );
        tblmodifier = tolower( tablelookupcolumnforrow( filename, row, 1 ) );
        var_40b9a488 = tolower( tablelookupcolumnforrow( filename, row, 2 ) );
        var_4ef5dd5c = tolower( tablelookupcolumnforrow( filename, row, 3 ) );
        var_c605de16 = [];
        
        while ( true )
        {
            alias = tablelookupcolumnforrow( filename, row, var_c605de16.size + 4 );
            
            if ( !isdefined( alias ) || alias == "" )
            {
                break;
            }
            
            var_c605de16[ var_c605de16.size ] = tolower( alias );
        }
        
        if ( tbltype == "" && tblmodifier == "" && var_c605de16.size == 0 )
        {
            break;
        }
        
        if ( tbltype == "" )
        {
            tbltype = "all";
        }
        
        if ( tblmodifier == "" )
        {
            tblmodifier = "all";
        }
        
        key = categorykey( tbltype, tblmodifier );
        level.bctable[ category ][ key ] = { #probability:float( var_40b9a488 ), #delay:float( var_4ef5dd5c ), #var_df2220dd:var_c605de16 };
    }
}

// Namespace battlechatter_table/battlechatter_table
// Params 3
// Checksum 0xa543abb8, Offset: 0x480
// Size: 0x7a
function function_4e83ff35( category, type, modifier )
{
    key = categorykey( type, modifier );
    
    if ( !exists( category, type, modifier ) )
    {
        return 0;
    }
    
    return level.bctable[ category ][ key ].probability;
}

// Namespace battlechatter_table/battlechatter_table
// Params 3
// Checksum 0xd239c839, Offset: 0x508
// Size: 0x7a
function function_2d2570e3( category, type, modifier )
{
    key = categorykey( type, modifier );
    
    if ( !exists( category, type, modifier ) )
    {
        return 0;
    }
    
    return level.bctable[ category ][ key ].delay;
}

// Namespace battlechatter_table/battlechatter_table
// Params 3
// Checksum 0x316347d5, Offset: 0x590
// Size: 0x72
function function_ac3d3b19( category, type, modifier )
{
    key = categorykey( type, modifier );
    
    if ( !exists( category, type, modifier ) )
    {
        return undefined;
    }
    
    return level.bctable[ category ][ key ].var_df2220dd;
}

// Namespace battlechatter_table/battlechatter_table
// Params 3
// Checksum 0x68ad5d18, Offset: 0x610
// Size: 0xc4, Type: bool
function exists( category, type, modifier )
{
    if ( !isdefined( level.bctable ) || !isdefined( level.bctable[ category ] ) )
    {
        return false;
    }
    
    key = categorykey( type, modifier );
    
    if ( !isstruct( level.bctable[ category ][ key ] ) )
    {
        return false;
    }
    
    if ( level.bctable[ category ][ key ].var_df2220dd.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter_table/battlechatter_table
// Params 2, eflags: 0x4
// Checksum 0xffc753c6, Offset: 0x6e0
// Size: 0x84
function private categorykey( type = "all", modifier = "all" )
{
    return tolower( "" + type ) + "_" + tolower( "" + modifier );
}

