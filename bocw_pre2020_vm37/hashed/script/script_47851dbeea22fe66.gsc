#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_34e46b51ae28401d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
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

#namespace namespace_e32bb68;

// Namespace namespace_e32bb68/namespace_e32bb68
// Params 0
// Checksum 0x970fb94, Offset: 0x170
// Size: 0x1a4
function init()
{
    level.doa.var_9e132ad0 = [];
    clientfield::register( "scriptmover", "play_sfx", 1, 8, "int" );
    clientfield::register( "allplayers", "play_sfx", 1, 8, "int" );
    clientfield::register( "actor", "play_sfx", 1, 8, "int" );
    clientfield::register( "vehicle", "play_sfx", 1, 8, "int" );
    clientfield::register( "scriptmover", "stop_sfx", 1, 8, "int" );
    clientfield::register( "allplayers", "stop_sfx", 1, 8, "int" );
    clientfield::register( "actor", "stop_sfx", 1, 8, "int" );
    clientfield::register( "vehicle", "stop_sfx", 1, 8, "int" );
    namespace_9bef0a98::function_fd4107e4();
}

// Namespace namespace_e32bb68/namespace_e32bb68
// Params 4
// Checksum 0x2413d7a7, Offset: 0x320
// Size: 0x12c
function function_c1e0cc87( name, *unused1, *unused2, var_f80dfd0d = 0 )
{
    if ( !isdefined( level.doa.var_9e132ad0 ) )
    {
        level.doa.var_9e132ad0 = [];
    }
    
    var_318e5b78 = level.doa.var_9e132ad0.size + 1;
    assert( var_318e5b78 < 256, "<dev string:x38>" );
    assert( !isdefined( level.doa.var_9e132ad0[ unused2 ] ), "<dev string:x5a>" );
    level.doa.var_9e132ad0[ unused2 ] = { #name:unused2, #id:var_318e5b78, #clear:var_f80dfd0d };
}

// Namespace namespace_e32bb68/namespace_e32bb68
// Params 3
// Checksum 0x52c8f13d, Offset: 0x458
// Size: 0x584
function function_30a7327c( flag, off, depth = 0 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( off )
    {
        queue = self.var_a045580f;
    }
    else
    {
        queue = self.var_74e53693;
    }
    
    if ( depth >= 16 )
    {
        /#
            foreach ( item in queue )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x8e>" + item.name );
            }
        #/
        
        assert( 0, "<dev string:x9c>" + ( off ? "<dev string:xd6>" : "<dev string:xde>" ) + "<dev string:xe7>" + queue[ 0 ].name + "<dev string:xfa>" + queue[ 1 ].name + "<dev string:xfa>" + queue[ 2 ].name + "<dev string:xfa>" + queue[ 3 ].name + "<dev string:xfa>" + queue[ 4 ].name + "<dev string:xfa>" + queue[ 5 ].name + "<dev string:xfa>" + queue[ 6 ].name + "<dev string:xfa>" + queue[ 7 ].name + "<dev string:xfa>" + queue[ 8 ].name + "<dev string:xfa>" + queue[ 9 ].name );
        self thread function_30a7327c( flag, off );
        return;
    }
    
    if ( queue.size >= 16 )
    {
        /#
            foreach ( item in queue )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x8e>" + item.name );
            }
        #/
        
        assert( 0, "<dev string:x9c>" + ( off ? "<dev string:xd6>" : "<dev string:xde>" ) + "<dev string:xe7>" + queue[ 0 ].name + "<dev string:xfa>" + queue[ 1 ].name + "<dev string:xfa>" + queue[ 2 ].name + "<dev string:xfa>" + queue[ 3 ].name + "<dev string:xfa>" + queue[ 4 ].name + "<dev string:xfa>" + queue[ 5 ].name + "<dev string:xfa>" + queue[ 6 ].name + "<dev string:xfa>" + queue[ 7 ].name + "<dev string:xfa>" + queue[ 8 ].name + "<dev string:xfa>" + queue[ 9 ].name );
    }
    
    if ( !isdefined( queue ) || queue.size == 0 )
    {
        if ( off )
        {
            self.var_a045580f = undefined;
        }
        else
        {
            self.var_74e53693 = undefined;
        }
        
        self clientfield::set( flag, 0 );
        return;
    }
    
    var_8541bfed = queue[ 0 ];
    arrayremoveindex( queue, 0, 0 );
    
    /#
        if ( !isdefined( self.var_1d44972e ) )
        {
            self.var_1d44972e = [];
            self.var_16d2ec97 = 0;
        }
        
        self.var_1d44972e[ self.var_16d2ec97 ] = var_8541bfed.name;
        self.var_16d2ec97++;
        
        if ( self.var_16d2ec97 > 50 )
        {
            self.var_16d2ec97 = 0;
        }
    #/
    
    self clientfield::set( flag, var_8541bfed.id );
    util::wait_network_frame();
    
    if ( var_8541bfed.clear )
    {
        self clientfield::set( flag, 0 );
    }
    
    self function_30a7327c( flag, off, depth + 1 );
}

// Namespace namespace_e32bb68/namespace_e32bb68
// Params 1
// Checksum 0xa509540b, Offset: 0x9e8
// Size: 0xe0
function function_ae271c0b( name )
{
    if ( !isdefined( name ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_a045580f ) )
    {
        self.var_a045580f = [];
        self.var_a045580f[ self.var_a045580f.size ] = level.doa.var_9e132ad0[ name ];
        self thread function_30a7327c( "stop_sfx", 1 );
        return;
    }
    
    if ( !isinarray( self.var_a045580f, level.doa.var_9e132ad0[ name ] ) )
    {
        self.var_a045580f[ self.var_a045580f.size ] = level.doa.var_9e132ad0[ name ];
    }
}

// Namespace namespace_e32bb68/namespace_e32bb68
// Params 1
// Checksum 0x228c6e42, Offset: 0xad0
// Size: 0xe0
function function_3a59ec34( name )
{
    if ( !isdefined( name ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_74e53693 ) )
    {
        self.var_74e53693 = [];
        self.var_74e53693[ self.var_74e53693.size ] = level.doa.var_9e132ad0[ name ];
        self thread function_30a7327c( "play_sfx", 0 );
        return;
    }
    
    if ( !isinarray( self.var_74e53693, level.doa.var_9e132ad0[ name ] ) )
    {
        self.var_74e53693[ self.var_74e53693.size ] = level.doa.var_9e132ad0[ name ];
    }
}

