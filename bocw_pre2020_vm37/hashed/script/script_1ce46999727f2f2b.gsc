#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_eccff4fb;

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0xb7825cf1, Offset: 0x160
// Size: 0x1d4
function init()
{
    level.doa.var_aeb69827 = array( 0, 0, 10, 22, 40, 80, 160, 350, 650, 1400, 3000 );
    level.doa.var_88be0b68 = 0;
    
    foreach ( item in level.doa.var_aeb69827 )
    {
        level.doa.var_88be0b68 += item;
    }
    
    level.doa.var_c3842d93 = array( 0 );
    total = 0;
    
    for ( i = 1; i <= 9 ; i++ )
    {
        next = level.doa.var_aeb69827[ i + 1 ];
        level.doa.var_c3842d93[ level.doa.var_c3842d93.size ] = total + next;
        total += next;
    }
    
    callback::on_ai_killed( &function_41ce2473 );
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 1
// Checksum 0x3d0aebe8, Offset: 0x340
// Size: 0x54
function function_4c9d8712( var_49838c63 )
{
    assert( var_49838c63 < level.doa.var_c3842d93.size );
    return level.doa.var_c3842d93[ var_49838c63 ];
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0x3a53f49f, Offset: 0x3a0
// Size: 0x280
function initplayer()
{
    profilestart();
    self.doa.score = spawnstruct();
    self.doa.score.points = 0;
    self.doa.score.var_1397c196 = 0;
    self.doa.score.kills = 0;
    self.doa.score.var_194c59ae = 1;
    self.doa.score.var_ab9c3c4b = 0;
    self.doa.score.gems = 0;
    self.doa.score.var_a928c52e = 0;
    self.doa.score.var_e49e3de7 = function_4c9d8712( self.doa.score.var_194c59ae );
    self.doa.score.var_6ec1ad9d = 0;
    self.doa.score.deaths = 0;
    self.doa.score.keys = 0;
    self.doa.score.bombs = 1;
    self.doa.score.boosts = 2;
    self.doa.score.lives = 3;
    self.doa.score.var_5eac81d0 = 150000;
    self.kills = 0;
    self.deaths = 0;
    self.headshots = 0;
    self.revives = 0;
    self.downs = 0;
    keys = self stats::get_stat( #"doastats", #"keys" );
    
    if ( keys )
    {
        if ( keys > 9 )
        {
            keys = 9;
        }
        
        self.doa.score.keys = keys;
    }
    
    profilestop();
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 1
// Checksum 0xfd1eeb1b, Offset: 0x628
// Size: 0x74
function function_cb7b5503( commit = 1 )
{
    self stats::inc_stat( #"doastats", #"hash_293184ce9f1b2938", 1 );
    
    if ( commit )
    {
        self commitstats();
    }
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 1
// Checksum 0xbdc23882, Offset: 0x6a8
// Size: 0x74
function function_3f112727( commit = 1 )
{
    self stats::inc_stat( #"doastats", #"hash_16bf05d4f1efc4eb", 1 );
    
    if ( commit )
    {
        self commitstats();
    }
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 2
// Checksum 0xb6937fb3, Offset: 0x728
// Size: 0xf4
function function_6c15a74e( amount = 1, commit = 1 )
{
    self.doa.score.keys += amount;
    assert( self.doa.score.keys <= 9, "<dev string:x38>" );
    self stats::inc_stat( #"doastats", #"keys", amount );
    
    if ( commit )
    {
        self commitstats();
    }
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 2
// Checksum 0xb6ad451d, Offset: 0x828
// Size: 0x10c
function function_849a9028( amount = 1, commit = 1 )
{
    self.doa.score.keys -= amount;
    self.downs += amount;
    assert( self.doa.score.keys >= 0, "<dev string:x4d>" );
    self stats::inc_stat( #"doastats", #"keys", amount * -1 );
    
    if ( commit )
    {
        self commitstats();
    }
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0xf902371f, Offset: 0x940
// Size: 0x21e
function commitstats()
{
    profilestart();
    self stats::inc_stat( #"doastats", #"gems", self.doa.score.gems );
    self stats::inc_stat( #"doastats", #"kills", self.doa.score.kills );
    self stats::inc_stat( #"doastats", #"deaths", self.doa.score.deaths );
    self.doa.score.gems = 0;
    self.doa.score.kills = 0;
    self.doa.score.deaths = 0;
    var_f0ac2041 = self stats::get_stat( #"doastats", #"highest_round" );
    
    if ( level.doa.roundnumber > var_f0ac2041 )
    {
        self stats::set_stat( #"doastats", #"highest_round", level.doa.roundnumber );
    }
    
    self stats::set_stat( #"doastats", #"hintmask", self.doa.score.hintmask );
    uploadstats( self );
    profilestop();
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0xe36f59c3, Offset: 0xb68
// Size: 0xa0
function function_47498d07()
{
    players = namespace_7f5aeb59::function_23e1f90f();
    
    foreach ( player in players )
    {
        player commitstats();
    }
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 2
// Checksum 0xbf2d3186, Offset: 0xc10
// Size: 0x8a
function enemykill( *type, score = 100 )
{
    if ( !isdefined( self.doa.score ) )
    {
        return;
    }
    
    self.doa.score.var_1397c196 += score * self.doa.score.var_194c59ae;
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 2
// Checksum 0xf7fe8dd8, Offset: 0xca8
// Size: 0x2c2
function function_9e8690e0( item, type )
{
    if ( !isdefined( self.doa.score ) )
    {
        return;
    }
    
    score = 0;
    gems = 0.2;
    
    switch ( type )
    {
        case 1:
            score = 2 * 3 * 3 * 3 * 25;
            gems = 1;
            break;
        case 2:
            score = 3 * 3 * 3 * 25;
            break;
        case 3:
            score = 2 * 3 * 3 * 25;
            break;
        case 5:
            score = 3 * 3 * 25;
            break;
        case 4:
            score = 3 * 25;
            break;
        case 7:
            score = 3 * 25;
            break;
        case 6:
            score = 25;
            break;
        case 8:
            gems = item.scale;
            self.doa.score.var_ab9c3c4b++;
            
            if ( item.scale > 7.5 )
            {
                self thread namespace_6e90e490::function_47e11416( 4 );
            }
            
            break;
    }
    
    self.doa.score.var_1397c196 += score * self.doa.score.var_194c59ae;
    
    if ( self.doa.score.var_1397c196 > ( 1 << 30 ) - 1 )
    {
        self.doa.score.var_1397c196 = ( 1 << 30 ) - 1;
    }
    
    self.doa.score.var_a928c52e += gems;
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0xa4a31c97, Offset: 0xf78
// Size: 0x34
function function_f6ac4585()
{
    self.doa.score.deaths++;
    self thread function_1dd66aa1();
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0x4133302e, Offset: 0xfb8
// Size: 0x50e
function function_1dd66aa1()
{
    self notify( "1653715829f7f701" );
    self endon( "1653715829f7f701" );
    self endon( #"disconnect" );
    self.doa.var_ecfd5bbd = 1;
    self.doa.score.var_a928c52e = 0;
    deathorigin = self.origin;
    var_8508d81d = int( self.doa.score.gems ) >> 2;
    
    if ( var_8508d81d > 0 )
    {
        if ( var_8508d81d > 25 )
        {
            var_8508d81d = 25;
        }
        
        var_70c7d050 = int( self.doa.score.gems / var_8508d81d );
        var_817e0b00 = function_4c9d8712( self.doa.score.var_194c59ae - 1 );
        var_6f324de4 = var_70c7d050;
        
        while ( self.doa.score.gems > 0 )
        {
            decrement = int( self.doa.score.var_194c59ae * 4 * self.doa.score.var_194c59ae / 9 ) + 1;
            self.doa.score.gems -= decrement;
            
            if ( self.doa.score.gems < 0 )
            {
                self.doa.score.gems = 0;
            }
            
            var_6f324de4 -= decrement;
            
            if ( var_6f324de4 <= 0 )
            {
                var_6f324de4 = var_70c7d050;
                level thread namespace_dfc652ee::function_b8f6a8cd( undefined, deathorigin, 1, undefined, randomfloatrange( 0.85, self.doa.score.var_194c59ae ) );
            }
            
            if ( self.doa.score.gems <= var_817e0b00 )
            {
                self.doa.score.var_194c59ae--;
                
                if ( self.doa.score.var_194c59ae < 1 )
                {
                    self.doa.score.var_194c59ae = 1;
                }
                
                if ( self namespace_1c2a96f9::function_d438e371() && self.doa.score.var_194c59ae < 2 )
                {
                    break;
                }
                
                level thread namespace_dfc652ee::function_b8f6a8cd( undefined, deathorigin, 1, undefined, randomfloatrange( 0.85, self.doa.score.var_194c59ae ) );
                self.doa.score.var_e49e3de7 = function_4c9d8712( self.doa.score.var_194c59ae );
                var_817e0b00 = function_4c9d8712( self.doa.score.var_194c59ae - 1 );
                self.doa.score.var_6ec1ad9d = var_817e0b00;
            }
            
            waitframe( 1 );
        }
    }
    
    self.doa.score.gems = 0;
    self.doa.score.var_194c59ae = self namespace_1c2a96f9::function_d438e371() ? 2 : 1;
    self.doa.score.var_e49e3de7 = function_4c9d8712( self.doa.score.var_194c59ae );
    self.doa.score.var_6ec1ad9d = 0;
    self.doa.var_ecfd5bbd = undefined;
    self notify( #"hash_4e4e55afb99d1a6b" );
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 1
// Checksum 0x814448b0, Offset: 0x14d0
// Size: 0x70
function function_41ce2473( parms )
{
    if ( isdefined( parms.eattacker ) && isplayer( parms.eattacker ) )
    {
        parms.eattacker.doa.score.kills++;
        parms.eattacker.kills++;
    }
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0xe2176ee3, Offset: 0x1548
// Size: 0x1a
function function_5ce79923()
{
    return self.doa.score.points;
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 1
// Checksum 0xc3cc0e3c, Offset: 0x1570
// Size: 0x14c, Type: bool
function function_f3b382da( me )
{
    players = namespace_7f5aeb59::function_23e1f90f();
    
    if ( players.size == 1 )
    {
        return false;
    }
    
    if ( me.doa.score.points == 0 )
    {
        return false;
    }
    
    if ( me.doa.score.points == ( 1 << 30 ) - 1 )
    {
        return true;
    }
    
    foreach ( guy in players )
    {
        if ( guy == me )
        {
            continue;
        }
        
        if ( guy.doa.score.points >= me.doa.score.points )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_eccff4fb/namespace_eccff4fb
// Params 0
// Checksum 0x79180dc1, Offset: 0x16c8
// Size: 0x50a
function function_7752515d()
{
    if ( !isdefined( self.doa ) || !isdefined( self.doa.score ) )
    {
        return;
    }
    
    if ( !is_true( self.doa.var_ecfd5bbd ) && self.doa.score.gems < self.doa.score.var_a928c52e )
    {
        delta = self.doa.score.var_a928c52e - self.doa.score.gems;
        
        if ( delta >= self.doa.score.var_194c59ae )
        {
            increment = 1;
        }
        else
        {
            increment = 0.05;
        }
        
        self.doa.score.gems += increment;
        
        if ( self.doa.score.gems > level.doa.var_88be0b68 )
        {
            self.doa.score.gems = level.doa.var_88be0b68;
        }
        
        if ( self.doa.score.gems > self.doa.score.var_e49e3de7 )
        {
            if ( self.doa.score.var_194c59ae <= 9 )
            {
                self.doa.score.var_6ec1ad9d = self.doa.score.var_e49e3de7;
                self.doa.score.var_e49e3de7 = function_4c9d8712( self.doa.score.var_194c59ae + 1 );
            }
            
            self.doa.score.var_194c59ae++;
            
            if ( self.doa.score.var_194c59ae > 9 )
            {
                self.doa.score.var_194c59ae = 9;
            }
        }
    }
    
    if ( self.doa.score.points > ( 1 << 30 ) - 1 )
    {
        self.doa.score.points = ( 1 << 30 ) - 1;
    }
    
    if ( self.doa.score.points < self.doa.score.var_1397c196 )
    {
        delta = self.doa.score.var_1397c196 - self.doa.score.points;
        frac = int( 0.025 * delta );
        frac = int( frac / 25 ) * 25;
        
        if ( frac < 25 )
        {
            frac = 25;
        }
        
        self.doa.score.points += frac;
        
        if ( self.doa.score.points > self.doa.score.var_1397c196 )
        {
            self.doa.score.points = self.doa.score.var_1397c196;
        }
        
        if ( self.doa.score.points > self.doa.score.var_5eac81d0 )
        {
            level namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_extra_life" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
            self.doa.score.var_5eac81d0 = self.doa.score.points + 150000;
        }
    }
}

