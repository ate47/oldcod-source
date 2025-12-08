#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
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

#namespace namespace_c85a46fe;

// Namespace namespace_c85a46fe
// Method(s) 10 Total 10
class class_6fd989ce
{

    var m_health;
    var m_name;
    var var_1ac7d2e7;
    var var_2d1aa65b;
    var var_5466886f;
    var var_85613d6b;
    var var_da2586f5;

    // Namespace class_6fd989ce/namespace_c85a46fe
    // Params 0, eflags: 0x8
    // Checksum 0x75b564f6, Offset: 0x2f8
    // Size: 0x5e
    constructor()
    {
        m_name = "";
        var_5466886f = "";
        var_2d1aa65b = 512;
        var_1ac7d2e7 = 256;
        var_da2586f5 = 15;
        var_85613d6b = [];
        m_health = 12000;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0xac6a7762, Offset: 0x5f8
    // Size: 0xa
    function function_1296c737()
    {
        return var_da2586f5;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0x40c36ef5, Offset: 0x598
    // Size: 0xa
    function getname()
    {
        return m_name;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0x9bc4590e, Offset: 0x5e0
    // Size: 0xa
    function getheight()
    {
        return var_1ac7d2e7;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0x1c88c872, Offset: 0x610
    // Size: 0xa
    function function_910a1ed9()
    {
        return var_85613d6b;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 1
    // Checksum 0xe7eb5321, Offset: 0x370
    // Size: 0x21e
    function init( var_d7dae20a )
    {
        m_name = var_d7dae20a.script_noteworthy;
        assert( isdefined( m_name ) && m_name != "<dev string:x38>", "<dev string:x3c>" );
        a_toks = strtok( var_d7dae20a.script_string, "," );
        assert( a_toks.size >= 3, "<dev string:x77>" + var_d7dae20a.script_string );
        var_5466886f = a_toks[ 0 ];
        var_2d1aa65b = int( a_toks[ 1 ] );
        var_1ac7d2e7 = int( a_toks[ 2 ] );
        
        if ( a_toks.size >= 4 )
        {
            var_da2586f5 = int( a_toks[ 3 ] );
        }
        
        if ( a_toks.size >= 5 )
        {
            m_health = int( a_toks[ 4 ] );
        }
        
        var_85613d6b = struct::get_array( var_d7dae20a.target, "targetname" );
        
        foreach ( node in var_85613d6b )
        {
            node.origin -= var_d7dae20a.origin;
        }
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0xbab1bea5, Offset: 0x5c8
    // Size: 0xa
    function getwidth()
    {
        return var_2d1aa65b;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0x93ff77da, Offset: 0x5b0
    // Size: 0xa
    function function_c1009efb()
    {
        return var_5466886f;
    }

    // Namespace namespace_6fd989ce/namespace_c85a46fe
    // Params 0
    // Checksum 0x440e0dc3, Offset: 0x628
    // Size: 0xa
    function function_de9607de()
    {
        return m_health;
    }

}

// Namespace namespace_c85a46fe
// Method(s) 35 Total 35
class class_c4926dee
{

    var ai_type;
    var generator;
    var health;
    var m_active;
    var m_context;
    var m_model;
    var m_type;
    var origin;
    var takedamage;
    var var_1d308eec;
    var var_24bb61f1;
    var var_31d445dc;
    var var_520afec4;
    var var_5eeaacc8;
    var var_6d14cf9d;
    var var_71c23335;
    var var_71fccd1d;
    var var_83cb975;
    var var_87ef4b13;
    var var_915ae41d;
    var var_a3c3a5f4;
    var var_c24010e8;
    var var_c35ec3b3;
    var var_cda957a8;
    var var_de510cda;

    // Namespace class_c4926dee/namespace_c85a46fe
    // Params 0, eflags: 0x8
    // Checksum 0x7401cc4b, Offset: 0x848
    // Size: 0x106
    constructor()
    {
        var_de510cda = undefined;
        var_a3c3a5f4 = undefined;
        m_model = undefined;
        var_915ae41d = 15;
        var_71c23335 = [];
        m_active = 0;
        var_31d445dc = [];
        m_type = undefined;
        var_1d308eec = "generic_generator_active";
        var_87ef4b13 = "generic_generator_die";
        var_5eeaacc8 = #"zmb_aat_kilowatt_explode";
        var_520afec4 = #"zmb_aat_kilowatt_explode";
        var_c24010e8 = 0;
        var_83cb975 = undefined;
        var_cda957a8 = undefined;
        var_c35ec3b3 = undefined;
        var_24bb61f1 = undefined;
        m_context = 1;
        var_71fccd1d = undefined;
    }

    // Namespace class_c4926dee/namespace_c85a46fe
    // Params 0, eflags: 0x10
    // Checksum 0xed99dfcb, Offset: 0x958
    // Size: 0x24
    destructor()
    {
        var_31d445dc = [];
        namespace_1e25ad94::debugmsg( "Generator destructor being called." );
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 4
    // Checksum 0x3b204ecc, Offset: 0x1110
    // Size: 0x66
    function function_331fc68( activefx, var_3ac6a87b, spawnfx, spawnfxdelay = 1 )
    {
        var_1d308eec = activefx;
        var_87ef4b13 = var_3ac6a87b;
        var_cda957a8 = spawnfx;
        var_24bb61f1 = spawnfxdelay;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 12
    // Checksum 0x7078dbe6, Offset: 0x1b08
    // Size: 0x330
    function function_5576668( *einflictor, eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *iboneindex, *imodelindex )
    {
        imodelindex = int( imodelindex );
        self namespace_ec06fe4a::function_2f4b0f9( health - imodelindex );
        
        if ( imodelindex >= health )
        {
            takedamage = 0;
            imodelindex = health - 1;
            
            if ( isplayer( iboneindex ) )
            {
                iboneindex namespace_eccff4fb::enemykill( self, 5000 );
            }
            
            var_a49e1d80 = [[ generator ]]->function_3e35eb73();
            
            foreach ( spawner in var_a49e1d80 )
            {
                if ( isdefined( spawner ) )
                {
                    spawner notify( #"hash_38a47f8bbc000501" );
                }
            }
            
            doa_enemy::function_f7086924( self );
            
            foreach ( ai in [[ generator ]]->function_4d5eefc7() )
            {
                if ( !isdefined( ai ) )
                {
                    continue;
                }
                
                if ( is_true( ai.var_1f2d0447 ) && gettime() - ai.birthtime < 1500 )
                {
                    ai.interdimensional_gun_kill = 1;
                    ai thread namespace_ec06fe4a::function_570729f0( 0 );
                }
            }
            
            level thread namespace_c85a46fe::function_40ec656b( self, [[ generator ]]->function_68e475d0(), [[ generator ]]->function_8370e1a3() );
        }
        
        if ( isplayer( iboneindex ) )
        {
            iboneindex namespace_eccff4fb::enemykill( self, int( imodelindex / 25 ) * 25 );
        }
        
        return imodelindex;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x608aa74e, Offset: 0x11e8
    // Size: 0xa
    function function_bf5fc68()
    {
        return var_24bb61f1;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xa7d4f615, Offset: 0xfd8
    // Size: 0xe, Type: bool
    function function_fa5c9c4()
    {
        return m_context == 0;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x1f66abc4, Offset: 0x11d0
    // Size: 0xa
    function function_3038a5ee()
    {
        return var_cda957a8;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xda212c8, Offset: 0xfa8
    // Size: 0x10, Type: bool
    function function_30a0163e()
    {
        return m_context == 2;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xf15cc494, Offset: 0x1008
    // Size: 0x12
    function getcenter()
    {
        return m_model.origin;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x7c1c8fc3, Offset: 0x1078
    // Size: 0xa
    function function_3e35eb73()
    {
        return var_31d445dc;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xd94b446f, Offset: 0x13c0
    // Size: 0x568
    function function_41157a40()
    {
        level endon( #"game_over" );
        self endon( #"destroy" );
        
        if ( function_30a0163e() )
        {
            while ( level flag::get( "dungeon_building" ) )
            {
                wait 1;
            }
        }
        
        while ( true )
        {
            if ( !isalive() )
            {
                return;
            }
            
            last = m_active;
            m_active = 0;
            players = getplayers();
            
            if ( function_30a0163e() )
            {
                room = function_7475529a();
                
                if ( !isdefined( room ) )
                {
                    return;
                }
                
                foreach ( player in players )
                {
                    if ( player.doa.var_2fb8ffeb === room )
                    {
                        m_active = 1;
                        break;
                    }
                    
                    foreach ( adjacent in room.neighbors )
                    {
                        if ( !isdefined( adjacent ) )
                        {
                            continue;
                        }
                        
                        if ( player.doa.var_2fb8ffeb === adjacent )
                        {
                            m_active = 1;
                            break;
                        }
                    }
                }
            }
            else if ( function_e55669e8() )
            {
                foreach ( player in players )
                {
                    if ( player istouching( var_a3c3a5f4 ) )
                    {
                        m_active = 1;
                        break;
                    }
                }
            }
            else if ( function_fa5c9c4() )
            {
                foreach ( player in players )
                {
                    if ( isdefined( var_a3c3a5f4 ) && player istouching( var_a3c3a5f4 ) )
                    {
                        m_active = 1;
                        break;
                    }
                    
                    m_active = 1;
                    break;
                }
            }
            
            if ( last && !m_active )
            {
                m_model namespace_83eb6304::turnofffx( function_45ee8bad() );
                m_model clientfield::set( "show_health_bar", 0 );
                m_model namespace_c85a46fe::function_a5c8be46();
                doa_enemy::function_f7086924( m_model );
            }
            else if ( !last && m_active )
            {
                m_model namespace_83eb6304::function_3ecfde67( function_45ee8bad() );
                m_model clientfield::set( "show_health_bar", 1 );
                m_model namespace_c85a46fe::showonradar();
                
                if ( isdefined( var_5eeaacc8 ) )
                {
                    m_model namespace_e32bb68::function_3a59ec34( var_5eeaacc8 );
                }
            }
            
            wait randomfloatrange( 0.25, 0.75 );
            arrayremovevalue( var_71c23335, undefined, 0 );
        }
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xe7005e98, Offset: 0x1230
    // Size: 0xa
    function function_44549c13()
    {
        return var_c35ec3b3;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x9d74faf8, Offset: 0x1200
    // Size: 0xa
    function function_45ee8bad()
    {
        return var_1d308eec;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 1
    // Checksum 0x535b3772, Offset: 0xeb0
    // Size: 0x12
    function function_4d5eefc7( *ai )
    {
        return var_71c23335;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x957d8aa7, Offset: 0x1060
    // Size: 0xa
    function gettype()
    {
        return m_type;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x1fcc02b6, Offset: 0xf78
    // Size: 0x24, Type: bool
    function isalive()
    {
        return isdefined( m_model ) && m_model.health > 0;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xfcef1e21, Offset: 0x1218
    // Size: 0xa
    function function_68e475d0()
    {
        return var_87ef4b13;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x360b294b, Offset: 0x10b8
    // Size: 0xa
    function function_7475529a()
    {
        return var_71fccd1d;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 1
    // Checksum 0x7ce4183d, Offset: 0x1090
    // Size: 0x1a
    function function_75df0623( room )
    {
        var_71fccd1d = room;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xad57f322, Offset: 0x1048
    // Size: 0xa
    function function_7fcca25d()
    {
        return var_83cb975;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x2ae4890e, Offset: 0x1260
    // Size: 0xa
    function function_8370e1a3()
    {
        return var_520afec4;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 7
    // Checksum 0x57987d12, Offset: 0x988
    // Size: 0x4ec
    function init( origin, angles, def, width, height, maxalive, context )
    {
        var_de510cda = def;
        m_context = context;
        
        if ( !isdefined( width ) )
        {
            width = [[ var_de510cda ]]->getwidth();
        }
        
        if ( !isdefined( height ) )
        {
            height = [[ var_de510cda ]]->getheight();
        }
        
        if ( !isdefined( maxalive ) )
        {
            maxalive = [[ var_de510cda ]]->function_1296c737();
        }
        
        if ( function_e55669e8() )
        {
            var_a3c3a5f4 = namespace_ec06fe4a::spawntrigger( "trigger_radius", origin + ( 0, 0, -72 ), 2 | 16, width, height );
            
            if ( !isdefined( var_a3c3a5f4 ) )
            {
                return;
            }
        }
        
        m_model = namespace_ec06fe4a::spawnmodel( origin, [[ var_de510cda ]]->function_c1009efb() );
        
        if ( !isdefined( m_model ) )
        {
            var_a3c3a5f4 delete();
            return;
        }
        
        m_model.modelname = [[ var_de510cda ]]->function_c1009efb();
        m_model.angles = angles;
        m_model.health = [[ var_de510cda ]]->function_de9607de();
        m_model.maxhealth = m_model.health;
        m_model.radius = width;
        m_model.generator = self;
        m_model.trigger = var_a3c3a5f4;
        m_model.takedamage = 1;
        m_model setcandamage( 1 );
        m_model.var_86a21346 = &function_5576668;
        m_model setteam( #"axis" );
        var_915ae41d = maxalive;
        var_83cb975 = namespace_ec06fe4a::function_7fcca25d( "Generator" + [[ var_de510cda ]]->function_c1009efb() );
        spawnnodes = [[ var_de510cda ]]->function_910a1ed9();
        
        foreach ( node in spawnnodes )
        {
            spawner = spawnstruct();
            spawner.origin = m_model.origin + rotatepoint( node.origin, m_model.angles );
            spawner.angles = node.angles + m_model.angles;
            spawner.ai_type = node.script_noteworthy;
            spawner.var_6d14cf9d = isdefined( node.script_int ) ? int( node.script_int ) : 3;
            
            if ( !isdefined( m_type ) && isdefined( spawner.ai_type ) )
            {
                m_type = spawner.ai_type;
            }
            
            spawner thread function_a2bbc139( self );
            var_31d445dc[ var_31d445dc.size ] = spawner;
        }
        
        m_model enableaimassist();
        m_model thread namespace_c85a46fe::function_ec072c1a( gettype() );
        self thread function_41157a40();
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 1
    // Checksum 0xb4e3bb4, Offset: 0x1930
    // Size: 0x1d0
    function function_a2bbc139( generator )
    {
        self endon( #"hash_38a47f8bbc000501" );
        generator endon( #"destroy" );
        level endon( #"game_over" );
        model = undefined;
        spawndef = doa_enemy::function_d7c5adee( ai_type );
        wait randomfloat( 2 );
        
        while ( [[ generator ]]->isalive() )
        {
            if ( [[ generator ]]->canspawn() )
            {
                if ( !isdefined( model ) )
                {
                    model = [[ generator ]]->getmodel();
                    spawnfx = [[ generator ]]->function_3038a5ee();
                    var_36ca64f1 = [[ generator ]]->function_44549c13();
                }
                
                if ( isdefined( model ) && isdefined( spawnfx ) )
                {
                    model namespace_83eb6304::function_3ecfde67( spawnfx );
                    
                    if ( isdefined( var_36ca64f1 ) )
                    {
                        model namespace_e32bb68::function_3a59ec34( var_36ca64f1 );
                    }
                    
                    wait [[ generator ]]->function_bf5fc68();
                    
                    if ( isdefined( model ) )
                    {
                        model namespace_83eb6304::turnofffx( spawnfx );
                    }
                }
                
                doa_enemy::function_a6b807ea( spawndef, 1, origin, 12, generator );
                wait var_6d14cf9d;
                continue;
            }
            
            wait randomfloatrange( 0.5, 2 );
        }
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 1
    // Checksum 0xafdf238f, Offset: 0x1e40
    // Size: 0xe4
    function array_removeundefined( array )
    {
        removed = array;
        arrayremovevalue( removed, undefined, 1 );
        
        foreach ( obj in removed )
        {
            if ( function_3132f113( obj ) )
            {
                arrayremovevalue( removed, obj, 1 );
            }
        }
        
        return removed;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 1
    // Checksum 0x72dc3d27, Offset: 0xe80
    // Size: 0x24
    function function_bcd1aaf5( ai )
    {
        var_71c23335[ var_71c23335.size ] = ai;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 3
    // Checksum 0x3b2b038c, Offset: 0x1180
    // Size: 0x42
    function function_c08f72c2( var_3c6b5a32, var_3ffd02d8, var_acedff5b )
    {
        var_5eeaacc8 = var_3c6b5a32;
        var_520afec4 = var_3ffd02d8;
        var_c35ec3b3 = var_acedff5b;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 1
    // Checksum 0xc194ca5, Offset: 0x10d0
    // Size: 0x34
    function enable( flag )
    {
        if ( isdefined( var_a3c3a5f4 ) )
        {
            var_a3c3a5f4 triggerenable( flag );
        }
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x658ffb1e, Offset: 0xf60
    // Size: 0xa
    function isactive()
    {
        return m_active;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xdfb84cfc, Offset: 0x1278
    // Size: 0x13e
    function destroy()
    {
        profilestart();
        doa_enemy::function_f7086924( m_model );
        var_c24010e8 = 1;
        
        foreach ( ai in var_71c23335 )
        {
            if ( !isdefined( ai ) )
            {
                continue;
            }
            
            if ( is_true( ai.var_1f2d0447 ) && gettime() - ai.birthtime < 1500 )
            {
                ai.interdimensional_gun_kill = 1;
                ai thread namespace_ec06fe4a::function_570729f0( 0 );
            }
        }
        
        level notify( var_83cb975 );
        self notify( #"destroy" );
        namespace_c85a46fe::function_320a66f9( m_model );
        profilestop();
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xc38db9c5, Offset: 0xed0
    // Size: 0xa
    function getmodel()
    {
        return m_model;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x765136b6, Offset: 0xee8
    // Size: 0x6c, Type: bool
    function canspawn()
    {
        return isactive() && isalive() && var_71c23335.size < var_915ae41d && var_c24010e8 == 0 && namespace_250e9486::function_60f6a9e();
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x1e97bf3d, Offset: 0xfc0
    // Size: 0x10, Type: bool
    function function_e55669e8()
    {
        return m_context == 1;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x50760e2d, Offset: 0x1028
    // Size: 0x12
    function getradius()
    {
        return m_model.radius;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0xfe752bb3, Offset: 0x1248
    // Size: 0xa
    function function_e96aef39()
    {
        return var_5eeaacc8;
    }

    // Namespace namespace_c4926dee/namespace_c85a46fe
    // Params 0
    // Checksum 0x5d614509, Offset: 0xff0
    // Size: 0xa
    function getcontext()
    {
        return m_context;
    }

}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 1
// Checksum 0xd204ad4a, Offset: 0x25e8
// Size: 0xa2
function function_f1ba2302( name )
{
    foreach ( var_9c185dd1 in level.doa.var_ea48c46c )
    {
        if ( name === [[ var_9c185dd1 ]]->getname() )
        {
            return var_9c185dd1;
        }
    }
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 0
// Checksum 0x248c8a37, Offset: 0x2698
// Size: 0x1b6
function init()
{
    clientfield::register( "scriptmover", "set_icon", 1, 4, "int" );
    clientfield::register( "toplayer", "generator_sonar", 1, 1, "int" );
    level.doa.var_ea48c46c = [];
    level.doa.var_8acd67ef = [];
    var_ea48c46c = struct::get_array( "generatorDef", "targetname" );
    
    foreach ( item in var_ea48c46c )
    {
        if ( isdefined( function_f1ba2302( item.script_noteworthy ) ) )
        {
            continue;
        }
        
        generatordef = new class_6fd989ce();
        [[ generatordef ]]->init( item );
        level.doa.var_ea48c46c[ level.doa.var_ea48c46c.size ] = generatordef;
    }
    
    level.doa.var_c3219b45 = [];
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 3
// Checksum 0x61a7830f, Offset: 0x2858
// Size: 0xb4
function function_40ec656b( model, var_3ac6a87b, var_c4a370ce )
{
    model namespace_83eb6304::function_3ecfde67( var_3ac6a87b );
    
    if ( mayspawnentity() && isdefined( var_c4a370ce ) && validateorigin( model.origin ) )
    {
        playsoundatposition( var_c4a370ce, model.origin );
    }
    
    util::wait_network_frame();
    function_320a66f9( model );
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 1
// Checksum 0x62174808, Offset: 0x2918
// Size: 0xc8
function function_320a66f9( model )
{
    model clientfield::set( "show_health_bar", 0 );
    model function_a5c8be46();
    model namespace_ec06fe4a::function_8c808737();
    doa_enemy::function_f7086924( model );
    arrayremovevalue( level.doa.var_8acd67ef, model.generator );
    level.doa.var_c3219b45[ level.doa.var_c3219b45.size ] = model;
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 0
// Checksum 0x3bf2693e, Offset: 0x29e8
// Size: 0x124
function function_5db81c1c()
{
    self notify( "1840c8da15abde3b" );
    self endon( "1840c8da15abde3b" );
    level endon( #"game_over" );
    
    while ( true )
    {
        util::wait_network_frame();
        
        while ( level.doa.var_c3219b45.size )
        {
            model = level.doa.var_c3219b45[ 0 ];
            arrayremoveindex( level.doa.var_c3219b45, 0 );
            
            if ( isdefined( model.trigger ) )
            {
                model.trigger delete();
            }
            
            namespace_1e25ad94::debugmsg( "Generator model delete Ent:" + model getentitynumber() );
            model delete();
        }
    }
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 1
// Checksum 0x59824d52, Offset: 0x2b18
// Size: 0x1a0
function function_782e605e( name )
{
    generators = struct::get_array( name + "_doa_generator", "targetname" );
    
    foreach ( item in generators )
    {
        if ( isdefined( item.script_parameters ) )
        {
            a_toks = strtok( item.script_parameters, "," );
            radius = int( a_toks[ 0 ] );
            
            if ( a_toks.size >= 2 )
            {
                height = int( a_toks[ 1 ] );
            }
            
            if ( a_toks.size >= 2 )
            {
                maxalive = int( a_toks[ 2 ] );
            }
        }
        
        function_4c16ce2c( item.script_noteworthy, item.origin, item.angles, radius, height, maxalive );
    }
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 1
// Checksum 0xa3fde5f2, Offset: 0x2cc0
// Size: 0x1c4
function function_edfcfa44( context = 0 )
{
    level thread function_5db81c1c();
    
    if ( context == 0 )
    {
        while ( level.doa.var_8acd67ef.size )
        {
            instance = level.doa.var_8acd67ef[ 0 ];
            
            if ( isdefined( instance ) )
            {
                [[ instance ]]->destroy();
            }
        }
        
        level.doa.var_8acd67ef = [];
    }
    else
    {
        var_29287f31 = [];
        
        foreach ( generator in level.doa.var_8acd67ef )
        {
            if ( context == [[ generator ]]->getcontext() )
            {
                var_29287f31[ var_29287f31.size ] = generator;
            }
        }
        
        while ( var_29287f31.size )
        {
            instance = var_29287f31[ 0 ];
            arrayremovevalue( var_29287f31, instance );
            
            if ( isdefined( instance ) )
            {
                [[ instance ]]->destroy();
            }
        }
    }
    
    while ( level.doa.var_c3219b45.size > 0 )
    {
        wait 1;
    }
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 7
// Checksum 0x6fb3aa58, Offset: 0x2e90
// Size: 0x1f6
function function_4c16ce2c( name, origin, angles, width = 1024, height = 128, maxalive = 25, context = 1 )
{
    var_9c185dd1 = function_f1ba2302( name );
    
    if ( isdefined( var_9c185dd1 ) )
    {
        generator = new class_c4926dee();
        [[ generator ]]->init( origin, angles, var_9c185dd1, width, height, maxalive, context );
        
        if ( name == "zombie" )
        {
            [[ generator ]]->function_331fc68( [[ generator ]]->function_45ee8bad(), "zombie_generator_die" );
        }
        else if ( name == "crawler" )
        {
            [[ generator ]]->function_331fc68( "crawler_generator_spawn", "zombie_generator_die", "crawler_generator_spawn" );
        }
        else if ( name == "skeleton" )
        {
            [[ generator ]]->function_331fc68( [[ generator ]]->function_45ee8bad(), "skeleton_generator_die" );
        }
        else if ( name == "demon" )
        {
            [[ generator ]]->function_331fc68( [[ generator ]]->function_45ee8bad(), "meat_explode" );
        }
        
        level.doa.var_8acd67ef[ level.doa.var_8acd67ef.size ] = generator;
        return generator;
    }
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 1
// Checksum 0xb9d4e3e2, Offset: 0x3090
// Size: 0x2e
function function_ec072c1a( type )
{
    self endon( #"death" );
    self.radartype = type;
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 0
// Checksum 0x5f1d66be, Offset: 0x30c8
// Size: 0x124
function showonradar()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    icon_index = undefined;
    
    switch ( self.radartype )
    {
        case #"basic_zombie":
            icon_index = 2;
            break;
        case #"skeleton":
            icon_index = 7;
            break;
        case #"brutus":
            icon_index = 3;
            break;
        case #"bat":
            icon_index = 4;
            break;
        case #"demon":
            icon_index = 5;
            break;
        case #"wolf":
            icon_index = 6;
            break;
        case #"crawler_zombie":
            icon_index = 8;
            break;
    }
    
    if ( isdefined( icon_index ) )
    {
        self clientfield::set( "set_icon", icon_index );
    }
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 0
// Checksum 0x85100e72, Offset: 0x31f8
// Size: 0x2c
function function_a5c8be46()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self clientfield::set( "set_icon", 0 );
}

// Namespace namespace_c85a46fe/namespace_c85a46fe
// Params 1
// Checksum 0x944a82a2, Offset: 0x3230
// Size: 0x64
function function_47c860ff( flag )
{
    if ( flag )
    {
        self showonradar();
    }
    else
    {
        self function_a5c8be46();
    }
    
    if ( isdefined( self.generator ) )
    {
        [[ self.generator ]]->enable( flag );
    }
}

