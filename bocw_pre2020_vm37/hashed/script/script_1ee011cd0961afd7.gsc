#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1b9c0b4f8da07fee;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_83eb6304;

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 0
// Checksum 0xe7f20cfe, Offset: 0x178
// Size: 0x1a4
function init()
{
    level.doa.var_11c4dca4 = [];
    clientfield::register( "scriptmover", "play_fx", 1, 8, "int" );
    clientfield::register( "allplayers", "play_fx", 1, 8, "int" );
    clientfield::register( "actor", "play_fx", 1, 8, "int" );
    clientfield::register( "vehicle", "play_fx", 1, 8, "int" );
    clientfield::register( "scriptmover", "stop_fx", 1, 8, "int" );
    clientfield::register( "allplayers", "stop_fx", 1, 8, "int" );
    clientfield::register( "actor", "stop_fx", 1, 8, "int" );
    clientfield::register( "vehicle", "stop_fx", 1, 8, "int" );
    namespace_7e1ec234::function_10d1200d();
}

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 3
// Checksum 0xb7300628, Offset: 0x328
// Size: 0xfc
function function_4060ccb4( name, *unused, var_f80dfd0d = 0 )
{
    var_318e5b78 = level.doa.var_11c4dca4.size;
    assert( var_318e5b78 < 256, "<dev string:x38>" );
    assert( !isdefined( level.doa.var_11c4dca4[ unused ] ), "<dev string:x55>" );
    level.doa.var_11c4dca4[ unused ] = { #name:unused, #id:var_318e5b78, #clear:var_f80dfd0d };
}

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 3
// Checksum 0x70e317cf, Offset: 0x430
// Size: 0x584
function function_cbc45554( flag, off, depth = 0 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( off )
    {
        queue = self.var_be2626e9;
    }
    else
    {
        queue = self.var_93d7fb93;
    }
    
    if ( depth >= 16 )
    {
        /#
            foreach ( item in queue )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x70>" + item.name );
            }
        #/
        
        assert( 0, "<dev string:x7d>" + ( off ? "<dev string:xb6>" : "<dev string:xbe>" ) + "<dev string:xc7>" + queue[ 0 ].name + "<dev string:xda>" + queue[ 1 ].name + "<dev string:xda>" + queue[ 2 ].name + "<dev string:xda>" + queue[ 3 ].name + "<dev string:xda>" + queue[ 4 ].name + "<dev string:xda>" + queue[ 5 ].name + "<dev string:xda>" + queue[ 6 ].name + "<dev string:xda>" + queue[ 7 ].name + "<dev string:xda>" + queue[ 8 ].name + "<dev string:xda>" + queue[ 9 ].name );
        self thread function_cbc45554( flag, off );
        return;
    }
    
    if ( queue.size >= 16 )
    {
        /#
            foreach ( item in queue )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x70>" + item.name );
            }
        #/
        
        assert( 0, "<dev string:x7d>" + ( off ? "<dev string:xb6>" : "<dev string:xbe>" ) + "<dev string:xc7>" + queue[ 0 ].name + "<dev string:xda>" + queue[ 1 ].name + "<dev string:xda>" + queue[ 2 ].name + "<dev string:xda>" + queue[ 3 ].name + "<dev string:xda>" + queue[ 4 ].name + "<dev string:xda>" + queue[ 5 ].name + "<dev string:xda>" + queue[ 6 ].name + "<dev string:xda>" + queue[ 7 ].name + "<dev string:xda>" + queue[ 8 ].name + "<dev string:xda>" + queue[ 9 ].name );
    }
    
    if ( !isdefined( queue ) || queue.size == 0 )
    {
        if ( off )
        {
            self.var_be2626e9 = undefined;
        }
        else
        {
            self.var_93d7fb93 = undefined;
        }
        
        self clientfield::set( flag, 0 );
        return;
    }
    
    var_8d3272cf = queue[ 0 ];
    arrayremoveindex( queue, 0, 0 );
    
    /#
        if ( !isdefined( self.var_e65a6ff2 ) )
        {
            self.var_e65a6ff2 = [];
            self.var_c2ab10fe = 0;
        }
        
        self.var_e65a6ff2[ self.var_c2ab10fe ] = var_8d3272cf.name;
        self.var_c2ab10fe++;
        
        if ( self.var_c2ab10fe > 50 )
        {
            self.var_c2ab10fe = 0;
        }
    #/
    
    self clientfield::set( flag, var_8d3272cf.id );
    util::wait_network_frame();
    
    if ( var_8d3272cf.clear )
    {
        self clientfield::set( flag, 0 );
    }
    
    self function_cbc45554( flag, off, depth + 1 );
}

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 1
// Checksum 0x99883233, Offset: 0x9c0
// Size: 0xe0
function turnofffx( name )
{
    if ( !isdefined( name ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_be2626e9 ) )
    {
        self.var_be2626e9 = [];
        self.var_be2626e9[ self.var_be2626e9.size ] = level.doa.var_11c4dca4[ name ];
        self thread function_cbc45554( "stop_fx", 1 );
        return;
    }
    
    if ( !isinarray( self.var_be2626e9, level.doa.var_11c4dca4[ name ] ) )
    {
        self.var_be2626e9[ self.var_be2626e9.size ] = level.doa.var_11c4dca4[ name ];
    }
}

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 1
// Checksum 0x47acdb16, Offset: 0xaa8
// Size: 0xf0
function function_3ecfde67( name )
{
    if ( !isdefined( name ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_93d7fb93 ) )
    {
        self.var_93d7fb93 = [];
        self.var_93d7fb93[ self.var_93d7fb93.size ] = level.doa.var_11c4dca4[ name ];
        self.var_adb4718d = name;
        self thread function_cbc45554( "play_fx", 0 );
        return;
    }
    
    if ( !isinarray( self.var_93d7fb93, level.doa.var_11c4dca4[ name ] ) )
    {
        self.var_93d7fb93[ self.var_93d7fb93.size ] = level.doa.var_11c4dca4[ name ];
    }
}

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 0
// Checksum 0x80c20d06, Offset: 0xba0
// Size: 0x24
function function_8b4b9bdd()
{
    self callback::on_death( &function_de09b352 );
}

// Namespace namespace_83eb6304/namespace_83eb6304
// Params 1
// Checksum 0x36871bd3, Offset: 0xbd0
// Size: 0x3c
function function_de09b352( eventstruct )
{
    if ( isdefined( eventstruct.corpse ) )
    {
        eventstruct.corpse function_3ecfde67( "burn_zombie" );
    }
}

