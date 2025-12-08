#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_draw;

#namespace snd;

// Namespace snd/snd_utility
// Params 1
// Checksum 0xfe023fd7, Offset: 0x430
// Size: 0x4c
function isnumber( num )
{
    var_e6fa5c22 = isfloat( num ) || isint( num );
    return var_e6fa5c22;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x8425b02b, Offset: 0x488
// Size: 0x62
function function_a18ae88f( x, y )
{
    quotient = floor( x / y );
    remainder = float( x - quotient * y );
    return remainder;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x8a23039b, Offset: 0x4f8
// Size: 0xf8
function getplayervieworigin()
{
    player = self;
    assert( isplayer( self ) );
    vieworigin = undefined;
    
    if ( isscriptfunctionptr( level._snd._callbacks[ #"player_view" ] ) )
    {
        vieworigin = player [[ level._snd._callbacks[ #"player_view" ] ]]();
    }
    else
    {
        vieworigin = player geteye();
    }
    
    assert( isvec( vieworigin ) );
    return vieworigin;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0xe58526b5, Offset: 0x5f8
// Size: 0xf8
function getplayerviewangles()
{
    player = self;
    assert( isplayer( self ) );
    viewangles = undefined;
    
    if ( isscriptfunctionptr( level._snd._callbacks[ #"player_angles" ] ) )
    {
        viewangles = player [[ level._snd._callbacks[ #"player_angles" ] ]]();
    }
    else
    {
        viewangles = player getplayerangles();
    }
    
    assert( isvec( viewangles ) );
    return viewangles;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0xf5cc1a23, Offset: 0x6f8
// Size: 0x130
function getplayerfov()
{
    player = self;
    assert( isplayer( self ) );
    fov = undefined;
    
    if ( isscriptfunctionptr( level._snd._callbacks[ #"player_fov" ] ) )
    {
        fov = player [[ level._snd._callbacks[ #"player_fov" ] ]]();
    }
    else
    {
        fov = getdvarfloat( #"cg_fov", 65 );
    }
    
    assert( isfloat( fov ) );
    assert( fov <= 180 );
    return fov;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x2d30b860, Offset: 0x830
// Size: 0x50
function function_ea2f17d1( variable, value )
{
    if ( isdefined( variable ) == 1 )
    {
        return variable;
    }
    
    assert( isdefined( value ) == 1 );
    return value;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x65bf5959, Offset: 0x888
// Size: 0x17a
function vectoraverage( v )
{
    if ( isvec( v ) == 1 )
    {
        avg = 0;
        avg += v[ 0 ];
        avg += v[ 1 ];
        avg += v[ 2 ];
        avg /= 3;
        return avg;
    }
    
    assert( isarray( v ) == 1, "<dev string:x38>" );
    avg = ( 0, 0, 0 );
    
    if ( v.size == 0 )
    {
        return avg;
    }
    else if ( v.size == 1 )
    {
        return v[ 0 ];
    }
    
    foreach ( vec in v )
    {
        avg += vec;
    }
    
    avg /= v.size;
    return avg;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xdb2e104b, Offset: 0xa10
// Size: 0x70
function function_70dbede3( angle )
{
    if ( angle >= -180 && angle <= 180 )
    {
        return angle;
    }
    
    while ( angle < -180 )
    {
        angle += 360;
    }
    
    while ( angle > 180 )
    {
        angle -= 360;
    }
    
    return angle;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x4482afd1, Offset: 0xa88
// Size: 0x5a
function getplayername( player )
{
    if ( isdefined( player ) == 1 )
    {
        if ( isdefined( player.name ) == 1 )
        {
            return player.name;
        }
        
        if ( isdefined( player.playername ) == 1 )
        {
            return player.playername;
        }
    }
    
    return undefined;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x10a329bf, Offset: 0xaf0
// Size: 0x102
function randomhelper( value )
{
    if ( isarray( value ) == 1 )
    {
        if ( value.size >= 2 )
        {
            min = value[ 0 ];
            max = value[ 1 ];
            
            if ( min > max )
            {
                temp = max;
                max = min;
                min = temp;
            }
            
            assert( max >= min );
            randomrange = randomfloatrange( min, max );
            return randomrange;
        }
        else if ( value.size == 1 )
        {
            value = value[ 0 ];
        }
    }
    
    return float( value );
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0x627f677e, Offset: 0xc00
// Size: 0xa6
function randomrangehelper( value_min, value_max, value_default )
{
    if ( isdefined( value_min ) && isdefined( value_max ) )
    {
        if ( value_min == value_max )
        {
            return value_min;
        }
        else
        {
            value = randomfloatrange( value_min, value_max );
            return value;
        }
    }
    else if ( isdefined( value_min ) == 1 && isdefined( value_max ) == 0 )
    {
        return value_min;
    }
    else if ( isdefined( value_default ) )
    {
        return value_default;
    }
    
    return undefined;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x6a33cae0, Offset: 0xcb0
// Size: 0x16a
function rangehelper( range, defaultminvalue )
{
    randomrange = undefined;
    
    if ( isarray( range ) == 1 )
    {
        if ( range.size == 0 )
        {
            return undefined;
        }
        else if ( range.size == 1 )
        {
            return float( range[ 0 ] );
        }
        else
        {
            rangemin = range[ 0 ];
            rangemax = range[ 1 ];
            randomrange = randomrangehelper( rangemin, rangemax );
            return float( randomrange );
        }
    }
    else if ( isarray( range ) == 0 && isdefined( defaultminvalue ) == 1 )
    {
        randomrange = randomrangehelper( defaultminvalue, range );
    }
    else
    {
        randomrange = range;
    }
    
    assert( isdefined( randomrange ) == 1, "<dev string:x72>" );
    return float( randomrange );
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xab4ed054, Offset: 0xe28
// Size: 0x3e
function function_31bcd153( arr )
{
    if ( arr.size == 0 )
    {
        return undefined;
    }
    else if ( arr.size == 1 )
    {
        return arr[ 0 ];
    }
    
    return arr;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xe9430505, Offset: 0xe70
// Size: 0xc8
function function_f218bff5( v )
{
    if ( !isdefined( v ) )
    {
        return array();
    }
    else if ( isdefined( v ) == 1 && function_3132f113( v ) == 0 && isarray( v ) == 1 )
    {
    }
    else
    {
        return array( v );
    }
    
    assert( isarray( v ) == 1 );
    return v;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x5ddbe432, Offset: 0xf40
// Size: 0xf6
function function_4b879845( var_7620540d, v )
{
    isarr = isarray( var_7620540d );
    isdef = isdefined( v );
    
    if ( function_81fac19d( !isdef, "snd VarrayAdd undefined entity" ) )
    {
        return var_7620540d;
    }
    
    if ( !isarr )
    {
        if ( isdefined( var_7620540d ) )
        {
            var_7620540d = array( var_7620540d, v );
        }
        else
        {
            var_7620540d = array( v );
        }
    }
    else if ( isarr )
    {
        isinarr = isinarray( var_7620540d, v );
        
        if ( !isinarr )
        {
            var_7620540d[ var_7620540d.size ] = v;
        }
    }
    
    return var_7620540d;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0xa290e3, Offset: 0x1040
// Size: 0xc8
function varrayremove( var_7620540d, v )
{
    isarr = isarray( var_7620540d );
    isdef = isdefined( v );
    
    if ( function_81fac19d( !isdef, "snd VarrayRemove undefined entity" ) )
    {
        return var_7620540d;
    }
    
    if ( !isarr )
    {
        var_7620540d = undefined;
    }
    else if ( isarr )
    {
        isinarr = isinarray( var_7620540d, v );
        
        if ( isinarr )
        {
            arrayremovevalue( var_7620540d, v );
        }
    }
    
    return var_7620540d;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x81d2838c, Offset: 0x1110
// Size: 0xd0
function function_783b69( s, wrap )
{
    s = function_ea2f17d1( s, "" );
    wrap = function_ea2f17d1( wrap, "" );
    str = "";
    
    /#
        if ( ishash( s ) )
        {
            if ( wrap != "<dev string:x95>" )
            {
                str = "<dev string:x99>";
            }
            
            s = function_9e72a96( s );
        }
    #/
    
    str += wrap + s + wrap;
    return str;
}

/#

    // Namespace snd/snd_utility
    // Params 2
    // Checksum 0xb4aa9780, Offset: 0x11e8
    // Size: 0xb8, Type: dev
    function function_8cb4e540( inputstring, var_329bae03 )
    {
        prefix = "<dev string:x95>";
        outputstring = "<dev string:x95>";
        
        if ( isstring( inputstring ) && inputstring.size > 0 && inputstring.size < var_329bae03 )
        {
            var_329bae03 -= inputstring.size;
            
            while ( var_329bae03 >= 0 )
            {
                prefix += "<dev string:x9e>";
                var_329bae03--;
            }
        }
        
        outputstring = prefix + inputstring;
        return outputstring;
    }

#/

// Namespace snd/snd_utility
// Params 1
// Checksum 0x71206693, Offset: 0x12a8
// Size: 0x13a, Type: bool
function hasnumber( s )
{
    if ( isnumber( s ) == 1 )
    {
        return true;
    }
    else if ( isstring( s ) == 1 && s[ 0 ] == "0" || s[ 0 ] == "1" || s[ 0 ] == "2" || s[ 0 ] == "3" || s[ 0 ] == "4" || s[ 0 ] == "5" || s[ 0 ] == "6" || s[ 0 ] == "7" || s[ 0 ] == "8" || s[ 0 ] == "9" || s[ 0 ] == "." )
    {
        return true;
    }
    
    return false;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0xaed470a5, Offset: 0x13f0
// Size: 0x246
function printdecimalcount( inputvalue, decimalcount )
{
    if ( isstring( inputvalue ) )
    {
        return inputvalue;
    }
    
    decimalcount = function_ea2f17d1( decimalcount, 0 );
    decimalcount = int( min( decimalcount, 6 ) );
    intvalue = int( inputvalue );
    fractional = inputvalue - intvalue;
    
    switch ( decimalcount )
    {
        case 0:
            return ( "" + intvalue );
        case 1:
            fractional = int( fractional * 10 );
            break;
        case 2:
            fractional = int( fractional * 100 );
            break;
        case 3:
            fractional = int( fractional * 1000 );
            break;
        case 4:
            fractional = int( fractional * 10000 );
            break;
        case 5:
            fractional = int( fractional * 10000 );
            break;
        case 6:
        default:
            fractional = int( fractional * 100000 );
            break;
    }
    
    outputvalue = intvalue + "." + fractional;
    return outputvalue;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xb8e320e7, Offset: 0x1640
// Size: 0xfc
function function_6afe83c4( arr )
{
    foreach ( i, item in arr )
    {
        var_4c1ba7d3 = isstring( item );
        var_e6fa5c22 = hasnumber( item );
        
        if ( var_4c1ba7d3 == 1 && var_e6fa5c22 == 1 )
        {
            arr[ i ] = int( item );
        }
    }
    
    return arr;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x3b145c9e, Offset: 0x1748
// Size: 0xfc
function function_64a5440a( arr )
{
    foreach ( i, item in arr )
    {
        var_4c1ba7d3 = isstring( item );
        var_e6fa5c22 = hasnumber( item );
        
        if ( var_4c1ba7d3 == 1 && var_e6fa5c22 == 1 )
        {
            arr[ i ] = float( item );
        }
    }
    
    return arr;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xe2522bb8, Offset: 0x1850
// Size: 0xd0
function positionhelper( thing )
{
    position = undefined;
    
    if ( function_3132f113( thing ) == 0 && isdefined( thing.origin ) )
    {
        position = thing.origin;
    }
    else if ( isvec( thing ) == 1 )
    {
        position = thing;
    }
    else
    {
        assert( 0 );
    }
    
    assert( isvec( position ) == 1, "<dev string:xa3>" );
    return position;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xdf19aa7a, Offset: 0x1928
// Size: 0xd2
function function_322e32be( array )
{
    assert( isarray( array ) == 1, "<dev string:xc8>" );
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    randomindex = randomintrange( 1, array.size );
    randomindex -= 1;
    assert( randomindex >= 0 && randomindex < array.size - 1 );
    randomelement = array[ randomindex ];
    return randomelement;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xdb888754, Offset: 0x1a08
// Size: 0x7e, Type: bool
function isstringinteger( str )
{
    intvalue = int( str );
    
    if ( intvalue > 0 )
    {
        return true;
    }
    else if ( intvalue < 0 )
    {
        return true;
    }
    else if ( intvalue == 0 && str == "0" )
    {
        return true;
    }
    
    return false;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x179b2401, Offset: 0x1a90
// Size: 0x82
function gettargetnames( target )
{
    ents = getentarray( target, "targetname" );
    structs = struct::get_array( target, "targetname" );
    targets = arraycombine( ents, structs );
    return targets;
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0xb98b1bb7, Offset: 0x1b20
// Size: 0xe6
function smoothvalue( currentvalue, var_2901828, smoothalpha )
{
    if ( smoothalpha == 0 )
    {
        return currentvalue;
    }
    else if ( smoothalpha == 1 )
    {
        /#
            text = "<dev string:xeb>";
            println( text );
            iprintlnbold( text );
        #/
        
        return var_2901828;
    }
    
    smoothalpha = math::clamp( smoothalpha, 0, 1 );
    inversealpha = 1 - smoothalpha;
    var_2901828 = currentvalue * inversealpha + var_2901828 * smoothalpha;
    return var_2901828;
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0xed8f0583, Offset: 0x1c10
// Size: 0x3a, Type: bool
function function_a5300865( value, minvalue, maxvalue )
{
    if ( value >= minvalue && value <= maxvalue )
    {
        return true;
    }
    
    return false;
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0xb19771fc, Offset: 0x1c58
// Size: 0x52
function function_6ecb085( value, midvalue, var_2c789a2 )
{
    isinrange = function_a5300865( value, midvalue - var_2c789a2, midvalue + var_2c789a2 );
    return isinrange;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x74bb13fd, Offset: 0x1cb8
// Size: 0x6e
function waittilldeleted()
{
    assert( isdefined( self ) == 1 );
    
    while ( function_3132f113( self ) == 0 )
    {
        self waittill( #"death", #"disconnect" );
    }
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0xdbefa35d, Offset: 0x1d30
// Size: 0x42e
function waittilldistance( target, range )
{
    self endon( #"death" );
    src = self;
    rmin = undefined;
    rmax = undefined;
    
    if ( isarray( range ) )
    {
        assert( range.size == 2 );
        rmin = float( range[ 0 ] );
        rmax = float( range[ 1 ] );
        assert( rmax >= rmin );
    }
    else if ( isnumber( range ) )
    {
        rmin = float( range );
    }
    
    assert( isfloat( rmin ) );
    armin = abs( rmin );
    
    while ( isdefined( src ) && isdefined( target ) )
    {
        spt = positionhelper( src );
        tpt = positionhelper( target );
        current_distance = distance( spt, tpt );
        
        if ( isfloat( rmax ) )
        {
            if ( current_distance <= rmax && current_distance >= rmin )
            {
                return;
            }
        }
        else
        {
            if ( rmin > 0 && current_distance >= rmin )
            {
                return;
            }
            
            if ( rmin <= 0 && current_distance <= armin )
            {
                return;
            }
        }
        
        /#
            if ( function_95c9af4b() > 0 )
            {
                randred = randomfloatrange( 0.72974, 1 );
                randgreen = randomfloatrange( 0.5, 1 );
                randblue = randomfloatrange( 0.5, 1 );
                randomcolor = ( randred, randgreen, randblue );
                randomcolor = vectornormalize( randomcolor );
                disttext = printdecimalcount( current_distance, 0 ) + "<dev string:x128>" + armin;
                
                if ( isfloat( rmax ) )
                {
                    disttext += "<dev string:x128>" + rmax;
                    
                    if ( rmax > 0 )
                    {
                        linesphere( tpt, rmax, randomcolor, 1, 1 );
                    }
                }
                
                if ( armin > 0 )
                {
                    linesphere( tpt, armin, randomcolor, 1, 1 );
                }
                
                print3dplus( disttext, tpt + ( 0, 0, 4 ), -0.75, "<dev string:x12f>", randomcolor, 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            }
        #/
        
        waitframe( 1 );
    }
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x338007fb, Offset: 0x2168
// Size: 0x142
function getplayerssafe( team )
{
    if ( is_true( level._snd.var_8c37ff34 ) )
    {
        players = getplayers( 0, team );
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) )
            {
                arrayremovevalue( players, player );
            }
        }
        
        return players;
    }
    
    if ( is_true( level._snd.var_2dd09170 ) )
    {
        players = getplayers( team );
        return players;
    }
    
    return array();
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xd7c198bb, Offset: 0x22b8
// Size: 0xbe
function function_a8210e43( localclientnum )
{
    players = getplayerssafe();
    
    foreach ( player in players )
    {
        if ( isdefined( player.localclientnum ) && player.localclientnum == localclientnum )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0xd5fcc8a9, Offset: 0x2380
// Size: 0x6c
function waitforplayers()
{
    while ( true )
    {
        wait_init();
        players = getplayerssafe();
        
        if ( isarray( players ) && players.size > 0 )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x316e51d2, Offset: 0x23f8
// Size: 0x42
function function_da785aa8( team )
{
    waitforplayers();
    players = getplayerssafe( team );
    return players;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x51ae8f5b, Offset: 0x2448
// Size: 0x8a
function function_869cb8c6()
{
    if ( is_true( level._snd.var_8c37ff34 ) )
    {
        return int( 60 );
    }
    
    if ( is_true( level._snd.var_2dd09170 ) )
    {
        return int( 20 );
    }
    
    return float( 20 );
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x1d37509a, Offset: 0x24e0
// Size: 0x8a
function function_6cfa7975()
{
    if ( is_true( level._snd.var_8c37ff34 ) )
    {
        return float( 0.0166667 );
    }
    
    if ( is_true( level._snd.var_2dd09170 ) )
    {
        return float( 0.05 );
    }
    
    return float( 0.05 );
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x81ee9522, Offset: 0x2578
// Size: 0xa4
function function_41df60ba( framecount, var_5bc3280a )
{
    frametime = 0.0333333 * framecount;
    
    if ( isdefined( var_5bc3280a ) == 0 )
    {
        var_5bc3280a = 0;
    }
    
    waittime = frametime + var_5bc3280a;
    
    if ( waittime <= 0 )
    {
        println( "<dev string:x134>" + waittime + "<dev string:x14e>" );
        return;
    }
    
    wait waittime;
}

// Namespace snd/snd_utility
// Params 5
// Checksum 0xea76e0c0, Offset: 0x2628
// Size: 0x5a
function scalerp( in_value, in_min, in_max, out_min, out_max )
{
    out_lerp = mapfloat( in_min, in_max, out_min, out_max, in_value );
    return out_lerp;
}

// Namespace snd/snd_utility
// Params 2, eflags: 0x4
// Checksum 0x10cfdf52, Offset: 0x2690
// Size: 0x80
function private function_e17840b5( vector, scale )
{
    assert( isvec( vector ) );
    assert( isnumber( scale ) );
    scaledvector = vector * ( scale, scale, scale );
    return scaledvector;
}

// Namespace snd/snd_utility
// Params 1, eflags: 0x4
// Checksum 0x74ebbb76, Offset: 0x2718
// Size: 0xb6
function private function_afb43113( vector )
{
    largestindex = 0;
    var_d7a0aa89 = 0;
    mult = 1;
    var_35f90ba = vector;
    
    for ( i = 0; i < 3 ; i++ )
    {
        v = vector[ i ];
        
        if ( v > var_d7a0aa89 )
        {
            largestindex = i;
            var_d7a0aa89 = v;
        }
    }
    
    mult = 1 / var_d7a0aa89;
    var_35f90ba = vectorscale( var_35f90ba, mult );
    return var_35f90ba;
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0x6c486ca2, Offset: 0x27d8
// Size: 0xf4
function vectorclamp( v, min, max )
{
    if ( isnumber( min ) )
    {
        min = ( min, min, min );
    }
    
    if ( isnumber( max ) )
    {
        max = ( max, max, max );
    }
    
    clampedvector = v;
    clampedvector = ( math::clamp( clampedvector[ 0 ], min[ 0 ], max[ 0 ] ), math::clamp( clampedvector[ 1 ], min[ 1 ], max[ 1 ] ), math::clamp( clampedvector[ 2 ], min[ 2 ], max[ 2 ] ) );
    return clampedvector;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0xea3535eb, Offset: 0x28d8
// Size: 0x4a
function vectorscalenormalize( vector, scale )
{
    scaledvector = vectorscale( vector, scale );
    normalizedvector = function_afb43113( scaledvector );
    return normalizedvector;
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x54720e41, Offset: 0x2930
// Size: 0x52
function function_2677a7e2( vector, scale )
{
    scaledvector = vectorscale( vector, scale );
    saturatedvector = vectorclamp( scaledvector, ( 0, 0, 0 ), ( 1, 1, 1 ) );
    return saturatedvector;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xf45d0c6a, Offset: 0x2990
// Size: 0x6c
function utofeet( inches )
{
    assert( isnumber( inches ) == 1, "<dev string:x158>" );
    return float( inches ) * 0.0833333;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x2bee7a73, Offset: 0x2a08
// Size: 0x6c
function utometers( inches )
{
    assert( isnumber( inches ) == 1, "<dev string:x178>" );
    return float( inches ) * 0.0254;
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0xb5e7d8f8, Offset: 0x2a80
// Size: 0x50, Type: bool
function function_c8caaab4( point, sphere_origin, radius )
{
    dist = distance( point, sphere_origin );
    
    if ( dist <= radius )
    {
        return true;
    }
    
    return false;
}

// Namespace snd/snd_utility
// Params 4
// Checksum 0x526064b4, Offset: 0x2ad8
// Size: 0x184
function orbitalposition( centerorigin, dist, var_3c67b910, elevation )
{
    if ( isdefined( dist ) == 0 || dist <= 0 )
    {
        return centerorigin;
    }
    
    var_3c67b910 = function_ea2f17d1( var_3c67b910, 0 );
    elevation = function_ea2f17d1( elevation, 0 );
    var_3c67b910 += 180;
    elevation += 270;
    posx = centerorigin[ 0 ];
    posy = centerorigin[ 1 ];
    posz = centerorigin[ 2 ];
    posx += dist * sin( elevation ) * cos( var_3c67b910 );
    posy += dist * sin( elevation ) * sin( var_3c67b910 );
    posz += dist * cos( elevation );
    position = ( posx, posy, posz );
    return position;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xb980c175, Offset: 0x2c68
// Size: 0xe8
function gettagsafe( tagstr )
{
    ent = self;
    tagname = "";
    tagorigin = undefined;
    
    if ( is_true( level._snd.var_8c37ff34 ) )
    {
        tagname = "tag_origin";
    }
    
    if ( isdefined( tagstr ) == 1 )
    {
        tagorigin = ent gettagorigin( tagstr );
    }
    
    if ( isdefined( tagorigin ) == 1 )
    {
        tagname = tolower( tagstr );
    }
    
    assert( isdefined( tagname ) == 1, "<dev string:x19a>" );
    return tagname;
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0x40885df, Offset: 0x2d58
// Size: 0x10c
function function_1666c97e( origin, angles, extents )
{
    mins = origin - extents;
    maxs = origin + extents;
    delta = maxs - mins;
    randomdelta = ( randomfloat( delta[ 0 ] ), randomfloat( delta[ 1 ] ), randomfloat( delta[ 2 ] ) );
    
    if ( angles != ( 0, 0, 0 ) )
    {
        mins = origin - rotatepoint( origin - mins, angles );
        randomdelta = rotatepoint( randomdelta, angles );
    }
    
    randompoint = mins + randomdelta;
    return randompoint;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x28a0f8e5, Offset: 0x2e70
// Size: 0x1aa
function function_827811b5()
{
    vidwidth = 1920;
    vidheight = 1080;
    
    if ( ispc() )
    {
        isfullscreen = getdvarint( #"r_fullscreen", 0 );
        
        if ( isfullscreen )
        {
            mode = getdvar( #"r_fullscreenmode", "800x600" );
            dims = strtok( mode, "x" );
            
            if ( isarray( dims ) && dims.size >= 2 )
            {
                vidwidth = int( dims[ 0 ] );
                vidheight = int( dims[ 1 ] );
            }
        }
        else
        {
            vidwidth = getdvarint( #"hash_799d70a49cc79c0f", 1920 );
            vidheight = getdvarint( #"hash_526c340ae912bbd0", 1080 );
        }
    }
    
    resolution = array( vidwidth, vidheight );
    return resolution;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x5a2892e, Offset: 0x3028
// Size: 0x46
function function_95c9af4b()
{
    /#
        if ( isdefined( level._snd._debug.debuglevel ) )
        {
            return level._snd._debug.debuglevel;
        }
    #/
    
    return 0;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x2cdf1fee, Offset: 0x3078
// Size: 0x28, Type: bool
function function_d78e3644()
{
    /#
        if ( function_95c9af4b() > 0 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0xc58a4b92, Offset: 0x30a8
// Size: 0x2a, Type: bool
function function_f984063f()
{
    /#
        if ( function_95c9af4b() > 2 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0x3335ef9c, Offset: 0x30e0
// Size: 0x4f6
function function_15ba1770()
{
    usernames = [ "jgosselin", "mdenis", "ntremblay", "plgrondines", "prenaud", "vleroux", "cbello", "csakanai", "imika", "jdrelick", "tbader", "carya", "cegert", "cstaples", "cchristensen", "dnatale", "dprior", "drowe", "smiller", "sprovine", "tleeamies", "tstasica", "abayless", "abrown", "bkreimeier", "dblondin", "jharley", "jsypult", "jtennies", "kkozlowski", "ndamato", "rsmsnjmiller", "jmiller", "vnuniyants", "dveca", "dswenson", "elopez", "flabarthe", "kchau", "mcaisley", "mgrimm", "midavies", "rmcsweeney", "bbitonti", "btuey", "cayers", "cdinkel", "hplunkard", "jmccawley", "ksherwood", "lstaples", "rgarigliano", "seckert", "sjimmerson", "wcornell" ];
    players = getplayerssafe();
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            playername = getplayername( player );
            
            if ( isdefined( playername ) )
            {
                foreach ( username in usernames )
                {
                    if ( issubstr( playername, username ) )
                    {
                        setdvar( #"hash_7bf92664f192f2a2", "1" );
                        return;
                    }
                }
            }
        }
    }
}

// Namespace snd/snd_utility
// Params 2
// Checksum 0x8cd6447b, Offset: 0x35e0
// Size: 0x58
function function_81fac19d( condition, alerttext )
{
    /#
        if ( condition )
        {
            if ( function_d78e3644() == 1 )
            {
                function_3ba3cecb( alerttext );
            }
        }
    #/
    
    return condition;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xdefa200c, Offset: 0x3640
// Size: 0x74
function function_7b45efc6( volume )
{
    var_aaa0f6d6 = log( float( volume ) ) / log( 10 );
    var_13be1590 = 20 * var_aaa0f6d6;
    return var_13be1590;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x7d200438, Offset: 0x36c0
// Size: 0x52
function function_359f7bac( var_13be1590 )
{
    volume = pow( 10, float( var_13be1590 ) / 20 );
    return volume;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xf8a616e7, Offset: 0x3720
// Size: 0x52
function function_d8b24901( semitone )
{
    pitchscale = pow( 2, float( semitone ) / 12 );
    return pitchscale;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x80dcc520, Offset: 0x3780
// Size: 0x74
function function_9bf57bf0( pitch )
{
    pitchlog2 = log( float( pitch ) ) / log( 2 );
    semitone = 12 * pitchlog2;
    return semitone;
}

// Namespace snd/snd_utility
// Params 4
// Checksum 0xa92b7d0f, Offset: 0x3800
// Size: 0xb4
function rvplayanimation( animname, animtree, notifyname, rate )
{
    if ( isdefined( level.var_31efd858 ) == 0 )
    {
        function_81fac19d( isdefined( level.var_31efd858 ) == 0, "rvPlayAnimation was not initialized!" );
        return;
    }
    
    if ( isdefined( notifyname ) == 0 )
    {
        notifyname = "animnotetrack";
    }
    
    if ( isdefined( rate ) == 0 )
    {
        rate = 1;
    }
    
    self thread [[ level.var_31efd858 ]]( animname, animtree, notifyname, rate );
}

// Namespace snd/snd_utility
// Params 0
// Checksum 0xd3c5b1b3, Offset: 0x38c0
// Size: 0x18
function dvar_shutdown()
{
    level notify( #"dvar_stop" );
}

// Namespace snd/snd_utility
// Params 0, eflags: 0x4
// Checksum 0x9c583c3, Offset: 0x38e0
// Size: 0x244
function private function_225d1cb8()
{
    level notify( #"dvar_stop" );
    level endon( #"dvar_stop" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( dvar in level.var_ebd8d6b1 )
        {
            callback = dvar.callback;
            key = dvar.key;
            value = getdvar( key );
            
            if ( isdefined( callback ) && isdefined( key ) && isdefined( value ) && dvar.value != value )
            {
                returnvalue = [[ callback ]]( key, value );
                
                if ( isdefined( returnvalue ) )
                {
                    setdvar( key, returnvalue );
                    dvar.value = returnvalue;
                    continue;
                }
                
                dvar.value = value;
            }
        }
        
        waitframe( 1 );
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            level waittill( #"host_migration_end" );
            
            foreach ( dvar in level.var_ebd8d6b1 )
            {
                function_b7598ee( dvar.key, dvar.value );
            }
        }
    }
}

// Namespace snd/snd_utility
// Params 0, eflags: 0x4
// Checksum 0xcc192eab, Offset: 0x3b30
// Size: 0x4c
function private function_d517905b()
{
    if ( isdefined( level.var_ebd8d6b1 ) == 0 )
    {
        level.var_ebd8d6b1 = array();
        level thread function_225d1cb8();
    }
}

// Namespace snd/snd_utility
// Params 3, eflags: 0x4
// Checksum 0x5a1a8131, Offset: 0x3b88
// Size: 0xb4
function private function_3710d450( dvar, value, callback )
{
    dvar_free( dvar );
    level.var_ebd8d6b1[ dvar ] = spawnstruct();
    level.var_ebd8d6b1[ dvar ].callback = callback;
    level.var_ebd8d6b1[ dvar ].key = dvar;
    level.var_ebd8d6b1[ dvar ].value = value;
    function_b7598ee( dvar, value );
}

// Namespace snd/snd_utility
// Params 2, eflags: 0x4
// Checksum 0xa94de0f2, Offset: 0x3c48
// Size: 0x2c
function private function_b7598ee( dvar, value )
{
    function_5ac4dc99( dvar, value );
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xdf8d9a17, Offset: 0x3c80
// Size: 0x30
function dvar_free( dvar )
{
    if ( isdefined( level.var_ebd8d6b1[ dvar ] ) )
    {
        level.var_ebd8d6b1[ dvar ] = undefined;
    }
}

// Namespace snd/snd_utility
// Params 3
// Checksum 0x664bb64f, Offset: 0x3cb8
// Size: 0x44
function dvar( dvar, value, callback )
{
    function_d517905b();
    function_3710d450( dvar, value, callback );
}

// Namespace snd/snd_utility
// Params 10, eflags: 0x4
// Checksum 0x36b3ff5c, Offset: 0x3d08
// Size: 0x206
function private function_98a0f33( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 )
{
    assert( isdefined( self ) == 1 );
    assert( isdefined( callbackfunc ) == 1 );
    assert( isscriptfunctionptr( callbackfunc ) == 1 );
    
    if ( isdefined( arg9 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 );
    }
    
    if ( isdefined( arg8 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 );
    }
    
    if ( isdefined( arg7 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6, arg7 );
    }
    
    if ( isdefined( arg6 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6 );
    }
    
    if ( isdefined( arg5 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5 );
    }
    
    if ( isdefined( arg4 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4 );
    }
    
    if ( isdefined( arg3 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3 );
        return;
    }
    
    if ( isdefined( arg2 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2 );
        return;
    }
    
    if ( isdefined( arg1 ) )
    {
        self [[ callbackfunc ]]( arg1 );
        return;
    }
    
    self [[ callbackfunc ]]();
}

// Namespace snd/snd_utility
// Params 10, eflags: 0x4
// Checksum 0xdfe5d360, Offset: 0x3f18
// Size: 0x1fe
function private function_8a64a4ec( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 )
{
    assert( isdefined( self ) == 1 );
    assert( isdefined( callbackfunc ) == 1 );
    assert( iscodefunctionptr( callbackfunc ) == 0 );
    
    if ( isdefined( arg9 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 );
    }
    
    if ( isdefined( arg8 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 );
    }
    
    if ( isdefined( arg7 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6, arg7 );
    }
    
    if ( isdefined( arg6 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5, arg6 );
    }
    
    if ( isdefined( arg5 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4, arg5 );
    }
    
    if ( isdefined( arg4 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3, arg4 );
    }
    
    if ( isdefined( arg3 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2, arg3 );
        return;
    }
    
    if ( isdefined( arg2 ) )
    {
        self [[ callbackfunc ]]( arg1, arg2 );
        return;
    }
    
    if ( isdefined( arg1 ) )
    {
        self [[ callbackfunc ]]( arg1 );
        return;
    }
    
    self [[ callbackfunc ]]();
}

// Namespace snd/snd_utility
// Params 10
// Checksum 0x5bc21ea0, Offset: 0x4120
// Size: 0x124
function callbackfunconentity( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 )
{
    assert( isdefined( self ) == 1 );
    assert( isdefined( callbackfunc ) == 1 );
    
    if ( isscriptfunctionptr( callbackfunc ) == 1 )
    {
        self function_98a0f33( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 );
        return;
    }
    
    if ( iscodefunctionptr( callbackfunc ) == 1 )
    {
        self function_8a64a4ec( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 );
    }
}

// Namespace snd/snd_utility
// Params 10
// Checksum 0xd41bd801, Offset: 0x4250
// Size: 0x7c
function function_b3acadc6( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 )
{
    self thread callbackfunconentity( callbackfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 );
}

/#

    // Namespace snd/snd_utility
    // Params 3, eflags: 0x4
    // Checksum 0x683b76da, Offset: 0x42d8
    // Size: 0x1a8, Type: dev
    function private function_9cae113f( soundalias, column, var_46195ad8 )
    {
        if ( soundexists( soundalias ) == 0 )
        {
            return undefined;
        }
        
        aliasvalue = function_9119c373( soundalias, column );
        
        if ( isdefined( aliasvalue ) == 0 || "<dev string:x95>" + aliasvalue == "<dev string:x95>" )
        {
            return undefined;
        }
        
        minormaxvalue = float( aliasvalue );
        
        for ( secondaryalias = function_9119c373( soundalias, "<dev string:x1b9>" ); isdefined( secondaryalias ) == 1 && secondaryalias != "<dev string:x95>" ; secondaryalias = function_9119c373( secondaryalias, "<dev string:x1b9>" ) )
        {
            aliasvalue = function_9119c373( soundalias, column );
            aliasvalue = float( aliasvalue );
            
            if ( var_46195ad8 == "<dev string:x1c6>" )
            {
                minormaxvalue = min( minormaxvalue, aliasvalue );
                continue;
            }
            
            if ( var_46195ad8 == "<dev string:x1cd>" )
            {
                minormaxvalue = max( minormaxvalue, aliasvalue );
            }
        }
        
        return minormaxvalue;
    }

    // Namespace snd/snd_utility
    // Params 2
    // Checksum 0xb774ac1f, Offset: 0x4488
    // Size: 0x44, Type: dev
    function function_7139f5ae( soundalias, column )
    {
        minvalue = function_9cae113f( soundalias, column, "<dev string:x1c6>" );
        return minvalue;
    }

    // Namespace snd/snd_utility
    // Params 2
    // Checksum 0x9f039505, Offset: 0x44d8
    // Size: 0x44, Type: dev
    function function_10120598( soundalias, column )
    {
        maxvalue = function_9cae113f( soundalias, column, "<dev string:x1cd>" );
        return maxvalue;
    }

#/

// Namespace snd/snd_utility
// Params 1
// Checksum 0xda004bfb, Offset: 0x4528
// Size: 0x9a
function function_636a2037( decimal )
{
    hexarray = "0123456789ABCDEF";
    quotient = int( decimal );
    hexadecimal = "";
    
    while ( quotient != 0 )
    {
        remainder = quotient % 16;
        hexadecimal = hexarray[ remainder ] + hexadecimal;
        quotient >>= 4;
    }
    
    return hexadecimal;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x99fbb917, Offset: 0x45d0
// Size: 0x292
function function_cc1eeb91( hex )
{
    hex = string( hex );
    intvalue = int( 0 );
    
    for ( i = 0; i < hex.size ; i++ )
    {
        nib = hex[ i ];
        nibvalue = 0;
        
        switch ( nib )
        {
            case #"5":
            case #"4":
            case #"7":
            case #"6":
            case #"1":
            case #"0":
            case #"3":
            case #"2":
            case #"9":
            case #"8":
                nibvalue = int( nib );
                break;
            case #"a":
            case #"a":
                nibvalue = 10;
                break;
            case #"b":
            case #"b":
                nibvalue = 11;
                break;
            case #"c":
            case #"c":
                nibvalue = 12;
                break;
            case #"d":
            case #"d":
                nibvalue = 13;
                break;
            case #"e":
            case #"e":
                nibvalue = 14;
                break;
            case #"f":
            case #"f":
                nibvalue = 15;
                break;
        }
        
        intvalue = int( intvalue << 4 | int( nibvalue ) );
    }
    
    return intvalue;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x1a422d27, Offset: 0x4870
// Size: 0x52
function function_c65c3de8( hashvalue )
{
    intvalue = int( hashvalue );
    var_f76bdca5 = function_636a2037( intvalue );
    return var_f76bdca5;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0x1d1ab0e7, Offset: 0x48d0
// Size: 0x52
function function_35dccf3f( hex )
{
    intvalue = function_cc1eeb91( hex );
    hashvalue = hash( intvalue );
    return hashvalue;
}

// Namespace snd/snd_utility
// Params 1
// Checksum 0xe711578f, Offset: 0x4930
// Size: 0x52
function function_cc5643b5( str )
{
    hashvalue = hash( str );
    var_f76bdca5 = string( hashvalue );
    return var_f76bdca5;
}

/#

    // Namespace snd/snd_utility
    // Params 1
    // Checksum 0xeee6cb1e, Offset: 0x4990
    // Size: 0x54, Type: dev
    function function_3626f311( hex )
    {
        hashvalue = function_35dccf3f( hex );
        stringvalue = function_9e72a96( hashvalue );
        return stringvalue;
    }

#/

// Namespace snd/snd_utility
// Params 2
// Checksum 0x38494fe8, Offset: 0x49f0
// Size: 0x2f0
function function_33ccce67( scenedef, willexcludeplayers )
{
    willexcludeplayers = function_ea2f17d1( willexcludeplayers, 1 );
    instances = array();
    var_558dab14 = struct::get_array( scenedef, "scriptbundlename" );
    instances = arraycombine( var_558dab14, instances, 0, 0 );
    instances_active = scene::get_active_scenes( scenedef );
    instances = arraycombine( instances_active, instances, 0, 0 );
    instances_inactive = scene::get_inactive_scenes( scenedef );
    instances = arraycombine( instances_inactive, instances, 0, 0 );
    scenedef_ents = array();
    
    if ( isarray( instances ) && instances.size > 0 )
    {
        foreach ( i in instances )
        {
            if ( isarray( i.scene_ents ) )
            {
                scenedef_ents = arraycombine( i.scene_ents, scenedef_ents, 0, 0 );
                arrayremovevalue( scenedef_ents, undefined, 0 );
                
                if ( willexcludeplayers )
                {
                    foreach ( e in scenedef_ents )
                    {
                        if ( isentity( e ) && isplayer( e ) )
                        {
                            arrayremovevalue( scenedef_ents, e, 0 );
                        }
                    }
                }
            }
        }
    }
    
    return scenedef_ents;
}

