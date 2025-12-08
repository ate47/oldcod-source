#using scripts\core_common\ai\systems\weaponlist;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\save;

#namespace gamedifficulty;

// Namespace gamedifficulty/gamedifficulty
// Params 0, eflags: 0x2
// Checksum 0x72b70873, Offset: 0x220
// Size: 0x2c
function autoexec init()
{
    level.gameskill = 1;
    level.var_3426461d = &function_8ffb61a;
}

// Namespace gamedifficulty/gamedifficulty
// Params 2
// Checksum 0x7997ab4a, Offset: 0x258
// Size: 0x104
function setskill( reset, var_648a2ef0 )
{
    if ( !isdefined( level.script ) )
    {
        level.script = util::get_map_name();
    }
    
    if ( !is_true( reset ) )
    {
        if ( is_true( level.var_a26aa64a ) )
        {
            return;
        }
        
        util::set_console_status();
        
        /#
            thread function_f4a93c9c();
        #/
        
        level.var_a26aa64a = 1;
    }
    
    level thread function_57ba1474( var_648a2ef0 );
    level.var_b6db9d5a = 1;
    set_difficulty_from_locked_settings();
    level function_4ba867b();
}

// Namespace gamedifficulty/gamedifficulty
// Params 1
// Checksum 0xe0a6bc14, Offset: 0x368
// Size: 0x9a
function function_c0aae431( var_7317b1dc )
{
    level.playerhealth_regularregendelay = function_a34942a0();
    
    if ( level.var_b6db9d5a )
    {
        thread function_f80a8b13( var_7317b1dc );
    }
    
    level.longregentime = function_faea9c9e();
    level.animation.misstimeconstant = function_5ae527c5();
    level.animation.misstimedistancefactor = function_f2ec5636();
}

// Namespace gamedifficulty/gamedifficulty
// Params 1
// Checksum 0xbe761e05, Offset: 0x410
// Size: 0x92
function function_f80a8b13( *var_7317b1dc )
{
    level flag::wait_till( "all_players_connected" );
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ].threatbias = int( function_1cfd1920() );
    }
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x6450c28f, Offset: 0x4b0
// Size: 0x24
function set_difficulty_from_locked_settings()
{
    function_c0aae431( &function_66c52cbf );
}

// Namespace gamedifficulty/gamedifficulty
// Params 2
// Checksum 0x2c9bac5e, Offset: 0x4e0
// Size: 0x2e
function function_66c52cbf( msg, *ignored )
{
    return level.difficultysettings[ ignored ][ level.currentdifficulty ];
}

/#

    // Namespace gamedifficulty/gamedifficulty
    // Params 0
    // Checksum 0xcfeebd70, Offset: 0x518
    // Size: 0xd0, Type: dev
    function function_f4a93c9c()
    {
        waittillframeend();
        
        while ( true )
        {
            while ( true )
            {
                if ( getdvarint( #"scr_health_debug", 0 ) )
                {
                    break;
                }
                
                wait 0.5;
            }
            
            thread function_fe49c4b4();
            
            while ( true )
            {
                if ( !getdvarint( #"scr_health_debug", 0 ) )
                {
                    break;
                }
                
                wait 0.5;
            }
            
            level notify( #"hash_4fff5870dd60a939" );
            function_d1f1cf52();
        }
    }

    // Namespace gamedifficulty/gamedifficulty
    // Params 0
    // Checksum 0xe0fac56a, Offset: 0x5f0
    // Size: 0x616, Type: dev
    function function_fe49c4b4()
    {
        level notify( #"hash_7eabe7ecd3c67fd" );
        level endon( #"hash_7eabe7ecd3c67fd" );
        y = 40;
        level.var_60023d69 = [];
        level.var_1c9484[ 0 ] = "<dev string:x38>";
        level.var_1c9484[ 1 ] = "<dev string:x42>";
        level.var_1c9484[ 2 ] = "<dev string:x51>";
        
        if ( !isdefined( level.var_5a1abaae ) )
        {
            level.var_5a1abaae = 0;
        }
        
        if ( !isdefined( level.var_30235742 ) )
        {
            level.var_30235742 = 0;
        }
        
        for ( i = 0; i < level.var_1c9484.size ; i++ )
        {
            key = level.var_1c9484[ i ];
            textelem = newdebughudelem();
            textelem.x = 150;
            textelem.y = y;
            textelem.alignx = "<dev string:x60>";
            textelem.aligny = "<dev string:x68>";
            textelem.horzalign = "<dev string:x6f>";
            textelem.vertalign = "<dev string:x6f>";
            textelem settext( key );
            bgbar = newdebughudelem();
            bgbar.x = 150 + 79;
            bgbar.y = y + 1;
            bgbar.z = 1;
            bgbar.alignx = "<dev string:x60>";
            bgbar.aligny = "<dev string:x68>";
            bgbar.horzalign = "<dev string:x6f>";
            bgbar.vertalign = "<dev string:x6f>";
            bgbar.maxwidth = 3;
            bgbar setshader( #"white", bgbar.maxwidth, 10 );
            bgbar.color = ( 0.5, 0.5, 0.5 );
            bar = newdebughudelem();
            bar.x = 150 + 80;
            bar.y = y + 2;
            bar.alignx = "<dev string:x60>";
            bar.aligny = "<dev string:x68>";
            bar.horzalign = "<dev string:x6f>";
            bar.vertalign = "<dev string:x6f>";
            bar setshader( #"black", 1, 8 );
            bar.sort = 1;
            textelem.bar = bar;
            textelem.bgbar = bgbar;
            textelem.key = key;
            y += 10;
            level.var_60023d69[ key ] = textelem;
        }
        
        level flag::wait_till( "<dev string:x7d>" );
        
        while ( true )
        {
            waitframe( 1 );
            players = level.players;
            
            for ( i = 0; i < level.var_1c9484.size && players.size > 0 ; i++ )
            {
                key = level.var_1c9484[ i ];
                player = players[ 0 ];
                width = 0;
                
                if ( i == 0 )
                {
                    width = player.health / player.maxhealth * 300;
                    level.var_60023d69[ key ] settext( level.var_1c9484[ 0 ] + "<dev string:x94>" + player.health );
                }
                else if ( i == 1 )
                {
                    width = ( level.var_5a1abaae - gettime() ) / 1000 * 40;
                }
                else if ( i == 2 )
                {
                    width = ( level.var_30235742 - gettime() ) / 1000 * 40;
                }
                
                width = int( max( width, 1 ) );
                width = int( min( width, 300 ) );
                bar = level.var_60023d69[ key ].bar;
                bar setshader( #"black", width, 8 );
                bgbar = level.var_60023d69[ key ].bgbar;
                
                if ( width + 2 > bgbar.maxwidth )
                {
                    bgbar.maxwidth = width + 2;
                    bgbar setshader( #"white", bgbar.maxwidth, 10 );
                    bgbar.color = ( 0.5, 0.5, 0.5 );
                }
            }
        }
    }

    // Namespace gamedifficulty/gamedifficulty
    // Params 0
    // Checksum 0x39da2d77, Offset: 0xc10
    // Size: 0xec, Type: dev
    function function_d1f1cf52()
    {
        level notify( #"hash_7eabe7ecd3c67fd" );
        
        if ( !isdefined( level.var_60023d69 ) )
        {
            return;
        }
        
        for ( i = 0; i < level.var_1c9484.size ; i++ )
        {
            level.var_60023d69[ level.var_1c9484[ i ] ].bgbar destroy();
            level.var_60023d69[ level.var_1c9484[ i ] ].bar destroy();
            level.var_60023d69[ level.var_1c9484[ i ] ] destroy();
        }
    }

#/

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x407604cd, Offset: 0xd08
// Size: 0x188
function function_c6f98249()
{
    self notify( "40683872c7e5c693" );
    self endon( "40683872c7e5c693" );
    self endon( #"death" );
    
    for ( ;; )
    {
        waitresult = self waittill( #"damage" );
        
        if ( isdefined( waitresult.attacker ) && isplayer( waitresult.attacker ) && !is_true( isbot( waitresult.attacker ) ) )
        {
            continue;
        }
        
        self.damagepoint = waitresult.position;
        self.damageattacker = waitresult.attacker;
        
        if ( isdefined( waitresult.mod ) && waitresult.mod == "MOD_BURNED" )
        {
            self setburn( 0.5 );
            self playsound( #"chr_burn" );
        }
        
        level notify( #"hit_again" );
        
        if ( !isdefined( level.var_36295190 ) )
        {
            self startfadingblur( 3, 0.8 );
        }
    }
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x2db6b76d, Offset: 0xe98
// Size: 0x58
function function_2339ca92()
{
    var_9b6ba81f = function_ad49ef5b();
    
    if ( var_9b6ba81f > 0 )
    {
        self thread function_22107f87( var_9b6ba81f );
    }
    
    /#
        level.var_5a1abaae = gettime() + var_9b6ba81f * 1000;
    #/
}

// Namespace gamedifficulty/gamedifficulty
// Params 1, eflags: 0x4
// Checksum 0xeed55f39, Offset: 0xef8
// Size: 0xdc
function private function_22107f87( timer )
{
    self endon( #"death", #"disconnect" );
    
    if ( self flag::get( "player_is_invulnerable" ) )
    {
        return;
    }
    
    self flag::set( "player_is_invulnerable" );
    level notify( #"hash_245285a0c17aa5cb" );
    self thread function_ab69b983();
    
    if ( timer > 0 )
    {
        function_fef4c10f( timer, 1 );
    }
    
    self flag::clear( "player_is_invulnerable" );
}

// Namespace gamedifficulty/gamedifficulty
// Params 2
// Checksum 0xd632efb8, Offset: 0xfe0
// Size: 0xf4
function function_fef4c10f( timer, var_19c9196 = 0 )
{
    if ( var_19c9196 )
    {
        self notify( #"hash_61ab322c075ab540" );
    }
    else if ( self flag::get( "player_zero_attacker_accuracy" ) )
    {
        return;
    }
    
    self endon( #"hash_61ab322c075ab540", #"death" );
    
    if ( !isdefined( self.var_c040f22f ) )
    {
        self.var_c040f22f = self.attackeraccuracy;
    }
    else
    {
        assert( self.attackeraccuracy == 0, "<dev string:x99>" );
    }
    
    self function_f5c273fc();
    wait timer;
    self function_b9d6a17c();
}

// Namespace gamedifficulty/gamedifficulty
// Params 0, eflags: 0x4
// Checksum 0xac108fa3, Offset: 0x10e0
// Size: 0x2e
function private function_f5c273fc()
{
    self flag::set( "player_zero_attacker_accuracy" );
    self.attackeraccuracy = 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0, eflags: 0x4
// Checksum 0x81f033d5, Offset: 0x1118
// Size: 0x8a
function private function_b9d6a17c()
{
    self flag::clear( "player_zero_attacker_accuracy" );
    assert( isdefined( self.var_c040f22f ), "<dev string:xe0>" );
    assert( self.var_c040f22f != 0, "<dev string:x127>" );
    self.attackeraccuracy = self.var_c040f22f;
    self.var_c040f22f = undefined;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0, eflags: 0x4
// Checksum 0xdfb7c67f, Offset: 0x11b0
// Size: 0xbe
function private function_ab69b983()
{
    self endon( #"death" );
    self.var_2869a26a = 0;
    assert( self flag::get( "<dev string:x173>" ) );
    self flag::wait_till_clear( "player_is_invulnerable" );
    cooldowntime = function_81e40993();
    
    /#
        level.var_30235742 = gettime() + cooldowntime * 1000;
    #/
    
    wait cooldowntime;
    self.var_2869a26a = 1;
}

// Namespace gamedifficulty/gamedifficulty
// Params 1
// Checksum 0xed8d0a2e, Offset: 0x1278
// Size: 0x5aa
function function_57ba1474( var_648a2ef0 )
{
    level notify( #"hash_75a2e0ea99b6eba1" );
    level endon( #"hash_75a2e0ea99b6eba1" );
    transient = savegame::function_6440b06b( #"transient" );
    
    if ( !isdefined( transient.var_9ac9bc79 ) )
    {
        transient.var_9ac9bc79 = 9999;
    }
    
    if ( !isdefined( transient.var_a0bc0e2c ) )
    {
        transient.var_a0bc0e2c = 0;
    }
    
    if ( isdefined( transient.var_14a0c072 ) )
    {
        setlocalprofilevar( "g_gameskill", transient.var_14a0c072 );
    }
    
    var_d92990c1 = -1;
    
    while ( !isdefined( var_648a2ef0 ) )
    {
        level.gameskill = getlocalprofileint( "g_gameskill" );
        
        /#
            var_89694459 = getdvarstring( #"overridedifficulty", "<dev string:x18d>" );
            
            switch ( tolower( var_89694459 ) )
            {
                case #"recruit":
                    level.gameskill = 0;
                    break;
                case #"regular":
                    level.gameskill = 1;
                    break;
                case #"hardened":
                    level.gameskill = 2;
                    break;
                case #"veteran":
                    level.gameskill = 3;
                    break;
                case #"realistic":
                    level.gameskill = 4;
                    break;
            }
        #/
        
        if ( level.gameskill != var_d92990c1 )
        {
            if ( !isdefined( level.gameskill ) )
            {
                level.gameskill = 1;
            }
            
            switch ( level.gameskill )
            {
                case 0:
                    setdvar( #"currentdifficulty", "recruit" );
                    level.currentdifficulty = "recruit";
                    break;
                case 1:
                    setdvar( #"currentdifficulty", "regular" );
                    level.currentdifficulty = "regular";
                    break;
                case 2:
                    setdvar( #"currentdifficulty", "hardened" );
                    level.currentdifficulty = "hardened";
                    break;
                case 3:
                    setdvar( #"currentdifficulty", "veteran" );
                    level.currentdifficulty = "veteran";
                    break;
                case 4:
                    setdvar( #"currentdifficulty", "realistic" );
                    level.currentdifficulty = "realistic";
                    break;
            }
            
            println( "<dev string:x191>" + level.gameskill );
            setdvar( #"saved_gameskill", level.gameskill );
            var_d92990c1 = level.gameskill;
            setlocalprofilevar( "g_gameskill", level.gameskill );
            transient.var_14a0c072 = level.gameskill;
            
            if ( level.gameskill < transient.var_9ac9bc79 )
            {
                transient.var_9ac9bc79 = level.gameskill;
            }
            
            if ( level.gameskill > transient.var_a0bc0e2c )
            {
                transient.var_a0bc0e2c = level.gameskill;
            }
            
            foreach ( player in getplayers() )
            {
                player clientfield::set_player_uimodel( "hudItems.serverDifficulty", level.gameskill );
                player stats::set_stat( #"currentdifficulty", level.gameskill );
                uploadstats( player );
            }
        }
        
        wait 1;
    }
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xaf80798d, Offset: 0x1830
// Size: 0xe8
function function_c7551020()
{
    if ( !isdefined( level.var_21347b32 ) )
    {
        level.var_21347b32 = [];
        level.var_21347b32[ 0 ] = getscriptbundle( "gamedifficulty_recruit" );
        level.var_21347b32[ 1 ] = getscriptbundle( "gamedifficulty_regular" );
        level.var_21347b32[ 2 ] = getscriptbundle( "gamedifficulty_hardened" );
        level.var_21347b32[ 3 ] = getscriptbundle( "gamedifficulty_veteran" );
        level.var_21347b32[ 4 ] = getscriptbundle( "gamedifficulty_realistic" );
    }
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x4ea5fba5, Offset: 0x1920
// Size: 0x50
function function_1cfd1920()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].threatbias;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x983b8f4, Offset: 0x1978
// Size: 0x52
function function_8ffb61a()
{
    function_c7551020();
    var_2b9b388d = level.var_21347b32[ level.gameskill ].difficulty_xp_multiplier;
    
    if ( isdefined( var_2b9b388d ) )
    {
        return var_2b9b388d;
    }
    
    return 1;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xd8251039, Offset: 0x19d8
// Size: 0x50
function function_4a1bd46e()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].healthoverlaycutoff;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x9af93997, Offset: 0x1a30
// Size: 0x5e
function function_f6f41f76()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_ff7fb6bb;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x4a35cb6e, Offset: 0x1a98
// Size: 0x50
function function_ad49ef5b()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].player_deathinvulnerabletime;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xa42c4664, Offset: 0x1af0
// Size: 0x4c
function function_81e40993()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_40865ff8;
    return isdefined( var_b0210d64 ) ? var_b0210d64 : 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x8f61ac1f, Offset: 0x1b48
// Size: 0x50
function function_e4046aa6()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].base_enemy_accuracy;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xe7f5b78a, Offset: 0x1ba0
// Size: 0x52
function function_eb59c79()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].playerdifficultyhealth;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 100;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xbe6b4b99, Offset: 0x1c00
// Size: 0x50
function function_5ae527c5()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].misstimeconstant;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xe0839258, Offset: 0x1c58
// Size: 0x50
function function_22fc6679()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].misstimeresetdelay;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x92067d00, Offset: 0x1cb0
// Size: 0x50
function function_f2ec5636()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].misstimedistancefactor;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x41cc554e, Offset: 0x1d08
// Size: 0x50
function function_f754b1bc()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].dog_health;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xcaa463dc, Offset: 0x1d60
// Size: 0x50
function function_ad6fb6da()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_f84eb1d6;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x63e5b5f5, Offset: 0x1db8
// Size: 0x50
function function_8bf0a382()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_bd3beebd;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xae1f8f1e, Offset: 0x1e10
// Size: 0x50
function function_faea9c9e()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].longregentime;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x51db6b07, Offset: 0x1e68
// Size: 0x50
function function_a34942a0()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].playerhealth_regularregendelay;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xbf812c0a, Offset: 0x1ec0
// Size: 0x50
function function_f4052850()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].worthydamageratio;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x4811c9e1, Offset: 0x1f18
// Size: 0x54
function function_b5b7d60e()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_b768020b;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 2;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x972f496b, Offset: 0x1f78
// Size: 0x54
function function_5151f9d0()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_5657206f;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 4.5;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xbcfc5f7b, Offset: 0x1fd8
// Size: 0x54
function function_52f56aea()
{
    function_c7551020();
    var_b0210d64 = level.var_21347b32[ level.gameskill ].var_bb4e24d2;
    
    if ( isdefined( var_b0210d64 ) )
    {
        return var_b0210d64;
    }
    
    return 0.3;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x3a2ad8ed, Offset: 0x2038
// Size: 0x40
function get_general_difficulty_level()
{
    value = level.gameskill + level.players.size - 1;
    
    if ( value < 0 )
    {
        value = 0;
    }
    
    return value;
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0xcff40b50, Offset: 0x2080
// Size: 0x42
function function_7dbe6a66()
{
    player = self;
    
    if ( function_ad49ef5b() == 0 )
    {
        return 0;
    }
    
    return is_true( self.var_2869a26a );
}

// Namespace gamedifficulty/gamedifficulty
// Params 7
// Checksum 0xdbb9f166, Offset: 0x20d0
// Size: 0x122
function function_2aed7a44( player, eattacker, *einflictor, idamage, *weapon, *shitloc, var_b646048d )
{
    if ( ( var_b646048d == "MOD_MELEE" || var_b646048d == "MOD_MELEE_WEAPON_BUTT" ) && isentity( weapon ) && !isplayer( weapon ) )
    {
        if ( shitloc > 40 )
        {
            playerforward = anglestoforward( idamage.angles );
            var_246fa38a = vectornormalize( weapon.origin - idamage.origin );
            
            if ( vectordot( playerforward, var_246fa38a ) < 0.342 )
            {
                shitloc = 40;
            }
        }
    }
    
    return shitloc;
}

// Namespace gamedifficulty/gamedifficulty
// Params 7
// Checksum 0xc651c416, Offset: 0x2200
// Size: 0xe2
function function_23dcd1f6( *player, *eattacker, *einflictor, idamage, *weapon, *shitloc, *var_b646048d )
{
    var_68bc2059 = float( function_eb59c79() );
    assert( var_68bc2059 > 0 );
    var_86342214 = float( 100 ) / var_68bc2059;
    return max( var_b646048d * var_86342214, min( 1, var_b646048d ) );
}

// Namespace gamedifficulty/gamedifficulty
// Params 0
// Checksum 0x24d24dbb, Offset: 0x22f0
// Size: 0x284
function function_4ba867b()
{
    function_c7551020();
    var_938ce325 = level.var_21347b32[ level.gameskill ].player_laststandbleedouttime;
    var_4cfdf1fc = level.var_21347b32[ level.gameskill ].var_949c9924;
    var_22e7a516 = level.var_21347b32[ level.gameskill ].player_laststandsuicidedelay;
    var_33682ca0 = level.var_21347b32[ level.gameskill ].var_58500288;
    var_fd9d63a8 = level.var_21347b32[ level.gameskill ].player_respawndelay;
    var_dd639ef7 = level.var_21347b32[ level.gameskill ].var_1bc10f3a;
    var_8c4f976a = level.var_21347b32[ level.gameskill ].var_c5c20d41;
    var_88dcf868 = level.var_21347b32[ level.gameskill ].var_4ca741c2;
    var_8f59489c = level.var_21347b32[ level.gameskill ].var_e3e8d3a1;
    var_880dfe56 = level.var_21347b32[ level.gameskill ].var_7b55ea2b;
    setdvar( #"player_laststandbleedouttime", var_938ce325 );
    setdvar( #"hash_7036719f41a78d54", var_4cfdf1fc );
    setdvar( #"player_laststandsuicidedelay", var_22e7a516 );
    setdvar( #"hash_6e3f1e26256fe0b5", var_33682ca0 );
    setdvar( #"player_respawndelay", var_fd9d63a8 );
    level.var_a4107aed = var_fd9d63a8;
    level.var_cf393bff = var_dd639ef7;
    level.var_a164210a = var_8c4f976a;
    level.var_a6a26da0 = var_88dcf868;
    level.var_1cac200a = var_8f59489c;
    level.var_22895486 = var_880dfe56;
}

