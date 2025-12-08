#using script_3dc93ca9902a9cda;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace snd;

/#

    // Namespace snd/snd_debug
    // Params 0
    // Checksum 0xb65be92a, Offset: 0x80
    // Size: 0x94, Type: dev
    function function_ce893a25()
    {
        level thread function_926b63ee();
        level thread function_222f3594();
        dvar( "<dev string:x38>", "<dev string:x4b>", &function_29bb1234 );
        dvar( "<dev string:x4f>", "<dev string:x65>", &function_53489ad );
    }

    // Namespace snd/snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xc648b38a, Offset: 0x120
    // Size: 0xb4, Type: dev
    function private function_1c3e68dd( linenum )
    {
        var_d63a89fd = level._snd._debug.hud_y;
        vidresolution = function_827811b5();
        vidwidth = vidresolution[ 0 ];
        vidheight = vidresolution[ 1 ];
        
        if ( var_d63a89fd < 0 )
        {
            var_d63a89fd = vidheight + var_d63a89fd;
        }
        
        posy = var_d63a89fd + 32 * linenum;
        return posy;
    }

    // Namespace snd/snd_debug
    // Params 4, eflags: 0x4
    // Checksum 0xda780c2, Offset: 0x1e0
    // Size: 0x11c, Type: dev
    function private function_d34c1a24( xoffset, linenum, text, color )
    {
        var_7ab7d2f1 = level._snd._debug.hud_x;
        vidresolution = function_827811b5();
        vidwidth = vidresolution[ 0 ];
        vidheight = vidresolution[ 1 ];
        
        if ( isdefined( color ) == 0 )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( var_7ab7d2f1 < 0 )
        {
            var_7ab7d2f1 = vidwidth + var_7ab7d2f1;
        }
        
        function_65bb0ccd( text, var_7ab7d2f1 + xoffset, function_1c3e68dd( linenum ), 1.33333, "<dev string:x6a>", color, 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0xe5e4e2f, Offset: 0x308
    // Size: 0xda, Type: dev
    function private function_43c85ce2()
    {
        origin = undefined;
        
        if ( isdefined( self.origin ) == 1 )
        {
            origin = self.origin;
        }
        
        if ( isdefined( self.v ) == 1 )
        {
            origin = self.v[ #"origin" ];
            self.origin = origin;
            self.var_3f03e75e = 1;
        }
        
        if ( function_3132f113( self ) == 1 )
        {
            return undefined;
        }
        
        assert( isvec( origin ) == 1 );
        return origin;
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x48e87736, Offset: 0x3f0
    // Size: 0xda, Type: dev
    function private function_cb457f5b()
    {
        angles = undefined;
        
        if ( isdefined( self.angles ) == 1 )
        {
            angles = self.angles;
        }
        
        if ( isdefined( self.v ) == 1 )
        {
            angles = self.v[ #"angles" ];
            self.angles = angles;
            self.var_45dbf7c9 = 1;
        }
        
        if ( function_3132f113( self ) == 1 )
        {
            return undefined;
        }
        
        assert( isvec( angles ) == 1 );
        return angles;
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x10b68c42, Offset: 0x4d8
    // Size: 0x98, Type: dev
    function private function_738e0260()
    {
        soundalias = "<dev string:x6f>";
        
        if ( isdefined( self.v ) == 1 && isdefined( self.v[ #"soundalias" ] ) == 1 )
        {
            soundalias = self.v[ #"soundalias" ];
        }
        else if ( isdefined( self.soundalias ) == 1 )
        {
            soundalias = self.soundalias;
        }
        
        return soundalias;
    }

    // Namespace snd/snd_debug
    // Params 5, eflags: 0x4
    // Checksum 0x57fa1d8a, Offset: 0x578
    // Size: 0x30c, Type: dev
    function private function_7814c6ed( player, playerview, playerangles, cosfov, maxdistance )
    {
        filterstring = level._snd._debug.filter;
        soundalias = self function_738e0260();
        origin = undefined;
        assert( isdefined( soundalias ) == 1 );
        isalias3d = function_c41f829d( soundalias );
        
        if ( isdefined( isalias3d ) && isalias3d == 0 )
        {
            return -1;
        }
        
        if ( isdefined( filterstring ) == 1 && filterstring != "<dev string:x4b>" )
        {
            if ( issubstr( soundalias, filterstring ) == 0 )
            {
                return -1;
            }
        }
        
        origin = self function_43c85ce2();
        
        if ( isdefined( origin ) == 0 )
        {
            return -1;
        }
        
        deltapos = origin - playerview;
        normal = vectornormalize( deltapos );
        playerforward = anglestoforward( playerangles );
        dot = vectordot( playerforward, normal );
        iswithinfov = dot >= cosfov;
        highlightdot = level._snd._debug.dot;
        
        if ( isdefined( player.var_6d42228d ) && player.var_6d42228d == self && isdefined( player.var_c84d8d23 ) && player.var_c84d8d23 != dot )
        {
            player.var_c84d8d23 = dot;
            player.var_6d42228d = undefined;
        }
        
        if ( dot > highlightdot && ( !isdefined( player.var_c84d8d23 ) || dot > player.var_c84d8d23 ) )
        {
            player.var_c84d8d23 = dot;
            player.var_6d42228d = self;
        }
        
        if ( iswithinfov == 0 )
        {
            return -1;
        }
        
        dist = distance( playerview, origin );
        
        if ( dist < 1 )
        {
            return -1;
        }
        
        if ( maxdistance > 0 && maxdistance < dist )
        {
            return -1;
        }
        
        return dist;
    }

    // Namespace snd/snd_debug
    // Params 7, eflags: 0x4
    // Checksum 0x34230974, Offset: 0x890
    // Size: 0x216, Type: dev
    function private function_a3b46281( visiblesndents, array, player, playerview, playerangles, *cosfov, maxdistance )
    {
        playerforward = anglestoforward( cosfov );
        playerfov = playerview getplayerfov();
        visible = [];
        assert( isarray( array ) );
        
        if ( isarray( player ) && player.size > 0 )
        {
            visible = function_ada64c98( player, playerangles, playerforward, playerfov, maxdistance );
            array = arraycombine( array, visible, 0 );
        }
        
        filterstring = level._snd._debug.filter;
        
        if ( isdefined( filterstring ) == 1 && filterstring != "<dev string:x4b>" )
        {
            foreach ( ent in array )
            {
                soundalias = ent function_738e0260();
                
                if ( issubstr( soundalias, filterstring ) )
                {
                    arrayremovevalue( array, ent );
                }
            }
        }
        
        return array;
    }

    // Namespace snd/snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x5e2269a3, Offset: 0xab0
    // Size: 0x1ec, Type: dev
    function private function_9386ad03( player, var_977d0bf3 )
    {
        maxdistance = level._snd._debug.distance_max;
        maxdistance = maxdistance <= 0 ? 262144 : maxdistance;
        visiblesndents = [];
        assert( isdefined( player ) == 1 );
        assert( isdefined( var_977d0bf3 ) == 1 );
        playerview = player getplayervieworigin();
        playerangles = player getplayerviewangles();
        fov = player getplayerfov();
        cosfov = cos( fov );
        
        if ( isdefined( level.var_b7d2deb ) == 1 && var_977d0bf3 >= 3 )
        {
            visiblesndents = function_a3b46281( visiblesndents, level.var_b7d2deb, player, playerview, playerangles, cosfov, maxdistance );
        }
        
        if ( isdefined( level._snd ) == 1 && isdefined( level._snd.var_3cc765a3 ) == 1 )
        {
            visiblesndents = function_a3b46281( visiblesndents, level._snd.var_3cc765a3, player, playerview, playerangles, cosfov, maxdistance );
        }
        
        return visiblesndents;
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x28d3ae8d, Offset: 0xca8
    // Size: 0x384, Type: dev
    function private function_bf58f58b()
    {
        origin = self function_43c85ce2();
        angles = self function_cb457f5b();
        soundalias = self function_738e0260();
        defaultradius = level._snd._debug.dist_radius;
        radius = defaultradius;
        minradiusunknown = 0;
        angle = undefined;
        
        if ( isdefined( self.angles ) == 1 )
        {
            angles = self.angles;
        }
        
        if ( soundalias != "<dev string:x6f>" )
        {
            angle = function_9119c373( soundalias, "<dev string:x7a>" );
            dist_min = function_7139f5ae( soundalias, "<dev string:x8b>" );
            
            if ( isdefined( dist_min ) == 1 && dist_min > 0 )
            {
                radius = dist_min;
            }
            else
            {
                minradiusunknown = 1;
            }
        }
        
        var_e3eb0c85 = 0;
        
        foreach ( player in getplayerssafe() )
        {
            playerview = player getplayervieworigin();
            var_e3eb0c85 = function_c8caaab4( playerview, origin, radius );
            
            if ( var_e3eb0c85 == 1 )
            {
                radius = defaultradius;
                break;
            }
        }
        
        colorscale = level._snd._debug.color_scale;
        color = vectorscale( ( 1, 1, 1 ), colorscale );
        line_alpha = 0.72974;
        
        if ( isdefined( angle ) && angle > 0 )
        {
            half_radius = radius * 0.5;
            arrow_length = 2 + radius * 2 - half_radius;
            debugarrow( origin, angles, arrow_length, half_radius, ( 1, 1, 1 ), line_alpha );
        }
        
        debugcrosshair( origin, radius * 2, angles, ( 1, 1, 1 ), line_alpha );
        
        if ( var_e3eb0c85 == 1 || minradiusunknown == 1 )
        {
            cube( origin, angles, radius, color, line_alpha, 0, 1 );
            return;
        }
        
        linesphere( origin, radius, color, line_alpha, 0, 1 );
    }

    // Namespace snd/snd_debug
    // Params 3, eflags: 0x4
    // Checksum 0x956d877c, Offset: 0x1038
    // Size: 0x1ea, Type: dev
    function private function_17547f34( player, visiblesndents, *var_977d0bf3 )
    {
        if ( isdefined( visiblesndents.var_6d42228d ) )
        {
            return visiblesndents.var_6d42228d;
        }
        
        crosshairradius = level._snd._debug.xhair_radius;
        fov = visiblesndents getplayerfov();
        playerview = visiblesndents getplayervieworigin();
        playerangles = visiblesndents getplayerviewangles();
        playerforward = anglestoforward( playerangles );
        highlightdot = level._snd._debug.dot;
        reticleentdot = 0;
        reticleent = undefined;
        visiblesndent = function_9ade037c( playerview, playerforward, var_977d0bf3 );
        
        if ( isdefined( visiblesndent ) )
        {
            origin = visiblesndent function_43c85ce2();
            deltapos = origin - playerview;
            normal = vectornormalize( deltapos );
            dot = vectordot( playerforward, normal );
            
            if ( dot > highlightdot && dot > reticleentdot )
            {
                reticleentdot = dot;
                reticleent = visiblesndent;
            }
        }
        
        return reticleent;
    }

    // Namespace snd/snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x83e12d7c, Offset: 0x1230
    // Size: 0x5e4, Type: dev
    function private function_b78b1ab1( player, *var_977d0bf3 )
    {
        audiocolor = level._snd._debug.color_3d;
        colorscale = level._snd._debug.color_scale;
        selectioncolor = function_2677a7e2( audiocolor, colorscale * 10 );
        fov = var_977d0bf3 getplayerfov();
        origin = self function_43c85ce2();
        soundalias = self function_738e0260();
        radiusmin = "<dev string:x96>";
        radiusmax = "<dev string:x96>";
        assert( isdefined( var_977d0bf3 ) == 1 );
        playerview = var_977d0bf3 getplayervieworigin();
        playerangles = var_977d0bf3 getplayerviewangles();
        playerright = anglestoright( playerangles );
        
        if ( soundalias != "<dev string:x6f>" )
        {
            dist_min = function_7139f5ae( soundalias, "<dev string:x8b>" );
            dist_max = function_10120598( soundalias, "<dev string:x9b>" );
            
            if ( isdefined( dist_min ) == 1 && dist_min > 0 )
            {
                radiusmin = dist_min;
            }
            
            if ( isdefined( dist_max ) == 1 && dist_max > 0 )
            {
                radiusmax = dist_max;
            }
        }
        
        if ( isdefined( soundalias ) == 1 )
        {
            debugscale = level._snd._debug.scale_3d;
            dist = distance( origin, playerview );
            alpha = 1;
            alphasq = alpha * alpha;
            
            if ( isnumber( radiusmin ) == 1 && radiusmin > 0 && isnumber( radiusmax ) == 1 && radiusmax > 0 )
            {
                mapfloat( radiusmin, radiusmax, 1, 0.5, dist );
            }
            
            fixeddistscalar = dist * 0.002;
            scale = debugscale * fixeddistscalar;
            print3dplus( soundalias, origin + ( 0, 0, -1.5 * scale * 24 ), scale, "<dev string:xa9>", selectioncolor, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
            detail_text = "<dev string:x4b>";
            
            if ( is_true( level._snd.var_2dd09170 ) )
            {
                detail_text = "<dev string:xb3>";
            }
            
            if ( is_true( level._snd.var_8c37ff34 ) )
            {
                detail_text = "<dev string:xbd>";
            }
            
            scale = debugscale * 0.666 * fixeddistscalar;
            detail_text += "<dev string:xc7>" + printdecimalcount( radiusmin ) + "<dev string:xd2>" + printdecimalcount( dist ) + "<dev string:xd2>" + printdecimalcount( radiusmax );
            print3dplus( detail_text, origin + ( 0, 0, -3 * scale * 24 ), scale, "<dev string:xa9>", selectioncolor, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
        }
        
        if ( isdefined( radiusmax ) == 1 && isnumber( radiusmax ) == 1 && radiusmax > 0 )
        {
            color = vectorscale( selectioncolor, 1 );
            line_alpha = 1;
            angles = self function_cb457f5b();
            debugcrosshair( origin, radiusmax * 2, angles, color, line_alpha );
            linesphere( origin, radiusmax, vectorscale( selectioncolor, 0.72974 ), line_alpha, 0, 1 );
        }
    }

    // Namespace snd/snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xe2d14f3, Offset: 0x1820
    // Size: 0x4b2, Type: dev
    function private function_c5ac5c05( var_977d0bf3 )
    {
        if ( var_977d0bf3 <= 1 )
        {
            return;
        }
        
        players = getplayerssafe();
        
        if ( !isarray( level.var_dbe59aee ) )
        {
            level.var_dbe59aee = [];
        }
        
        foreach ( player in players )
        {
            var_a9d76ab3 = [];
            var_a9d76ab3 = function_9386ad03( player, var_977d0bf3 );
            level.var_dbe59aee = arraycombine( level.var_dbe59aee, var_a9d76ab3, 0 );
        }
        
        drawlimit = level._snd._debug.draw_limit;
        var_82d451c6 = 0;
        
        if ( level.var_dbe59aee.size >= drawlimit )
        {
            allplayersviews = [];
            
            foreach ( player in players )
            {
                allplayersviews[ allplayersviews.size ] = player getplayervieworigin();
            }
            
            var_2ccfcb0e = vectoraverage( allplayersviews );
            level.var_dbe59aee = arraysortclosest( level.var_dbe59aee, var_2ccfcb0e );
            
            foreach ( ent in level.var_dbe59aee )
            {
                if ( isdefined( ent.var_3f03e75e ) == 1 )
                {
                    ent.origin = undefined;
                    ent.var_3f03e75e = undefined;
                }
            }
        }
        
        foreach ( visiblesndent in level.var_dbe59aee )
        {
            if ( drawlimit > 0 && var_82d451c6 >= drawlimit )
            {
                function_d34c1a24( 520, 2, "<dev string:xd9>" + drawlimit + "<dev string:xe0>", ( 1, 0, 0 ) );
                break;
            }
            
            visiblesndent function_bf58f58b();
            var_82d451c6 += 1;
        }
        
        var_a91b3615 = [];
        
        foreach ( player in players )
        {
            var_e70b966c = function_17547f34( player, level.var_dbe59aee, var_977d0bf3 );
            
            if ( isdefined( var_a91b3615 ) == 1 && isdefined( var_e70b966c ) == 1 )
            {
                var_e70b966c function_b78b1ab1( player, var_977d0bf3 );
                var_a91b3615[ var_a91b3615.size ] = var_e70b966c;
                var_82d451c6 += 1;
            }
        }
    }

    // Namespace snd/snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xcbd66e08, Offset: 0x1ce0
    // Size: 0x638, Type: dev
    function private function_3d58f598( var_977d0bf3 )
    {
        filterstring = level._snd._debug.filter;
        var_56ac818e = 0;
        var_da38b6bb = 0;
        sndentcount = 0;
        sndentvisiblestring = "<dev string:x4b>";
        sndentfilterstring = "<dev string:x4b>";
        sndparamcount = 0;
        
        if ( isdefined( level.var_b7d2deb ) == 1 )
        {
            assert( isdefined( level.var_c8afcee6 ) == 1 );
            assert( isdefined( level.var_eb0e2b51 ) == 1 );
            var_56ac818e = level.var_c8afcee6;
            var_da38b6bb = level.var_eb0e2b51;
        }
        
        if ( isdefined( level._snd ) == 1 && isdefined( level._snd.var_3cc765a3 ) == 1 )
        {
            sndentcount = level._snd.var_3cc765a3.size;
        }
        
        if ( isdefined( level.var_dbe59aee ) == 1 && level.var_dbe59aee.size > 0 && var_977d0bf3 >= 3 )
        {
            sndentvisiblestring += "<dev string:xef>" + level.var_dbe59aee.size + "<dev string:xf5>";
        }
        
        if ( isdefined( filterstring ) == 1 && filterstring != "<dev string:x4b>" )
        {
            sndentfilterstring += "<dev string:x102>" + filterstring + "<dev string:x102>";
        }
        
        if ( isdefined( level.var_ba9b4ed ) == 1 )
        {
            sndparamcount = level.var_ba9b4ed.size;
        }
        
        row = -4;
        
        if ( is_true( level._snd.var_2dd09170 ) )
        {
            mapname = tolower( getdvarstring( #"sv_mapname" ) );
            mapname = function_8cb4e540( mapname, 24 );
            function_d34c1a24( 0, row, mapname );
        }
        
        row = -3;
        
        if ( is_true( level._snd.var_8c37ff34 ) )
        {
            skipto = function_bdd32fcc();
            
            if ( skipto == "<dev string:x4b>" )
            {
                skipto = "<dev string:x107>";
            }
            
            skipto = function_8cb4e540( skipto, 24 );
            function_d34c1a24( 0, row, skipto );
        }
        
        row = -2;
        
        if ( is_true( level._snd.var_8c37ff34 ) )
        {
            player = getplayerssafe()[ 0 ];
            trigger = player.var_9a8a4923;
            trigger_name = function_ea2f17d1( trigger.script_ambientroom, "<dev string:x116>" );
            trigger_name = function_8cb4e540( trigger_name, 24 );
            function_d34c1a24( 0, row, trigger_name );
        }
        
        row = 0;
        
        if ( is_true( level._snd.var_2dd09170 ) )
        {
            function_d34c1a24( 0, row, "<dev string:x122>" + sndentcount );
            return;
        }
        
        row++;
        
        if ( is_true( level._snd.var_8c37ff34 ) )
        {
            function_d34c1a24( 0, row, "<dev string:x140>" + sndentcount );
        }
        
        row++;
        function_d34c1a24( 0, row, "<dev string:x15e>" + sndparamcount );
        row++;
        
        if ( var_977d0bf3 >= 3 )
        {
            function_d34c1a24( 0, row, "<dev string:x17c>" + var_56ac818e );
            row++;
            function_d34c1a24( 0, row, "<dev string:x19a>" + var_da38b6bb );
            row++;
            visiblestring = "<dev string:x4b>";
            
            if ( isdefined( level.var_dbe59aee ) == 1 && level.var_dbe59aee.size > 0 )
            {
                visiblestring += level.var_dbe59aee.size;
            }
            else
            {
                visiblestring += "<dev string:x65>";
            }
            
            if ( isdefined( filterstring ) == 1 && filterstring != "<dev string:x4b>" )
            {
                visiblestring += "<dev string:xef>" + sndentfilterstring + "<dev string:x1b8>";
            }
            
            function_d34c1a24( 0, row, "<dev string:x1bd>" + visiblestring );
            row++;
        }
    }

    // Namespace snd/snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0xa843cba, Offset: 0x2320
    // Size: 0x224, Type: dev
    function private function_94f79425( var_977d0bf3 )
    {
        if ( isdefined( var_977d0bf3 ) == 1 && var_977d0bf3 < 1 )
        {
            return;
        }
        
        if ( getdvar( #"createfx", "<dev string:x4b>" ) != "<dev string:x1db>" )
        {
            if ( isdefined( level.var_b7d2deb ) == 1 && level.var_b7d2deb.size > 0 )
            {
                return;
            }
        }
        else
        {
            while ( isdefined( level.createfx ) == 0 )
            {
                waitframe( 1 );
            }
        }
        
        while ( isdefined( level.createfxent ) == 0 )
        {
            waitframe( 1 );
        }
        
        level.var_b7d2deb = [];
        level.var_c8afcee6 = 0;
        level.var_eb0e2b51 = 0;
        
        foreach ( ent in level.createfxent )
        {
            if ( isdefined( ent.v[ #"type" ] ) == 0 )
            {
                continue;
            }
            
            if ( ent.v[ #"type" ] == "<dev string:x1e1>" )
            {
                level.var_c8afcee6++;
                level.var_b7d2deb[ level.var_b7d2deb.size ] = ent;
            }
            
            if ( ent.v[ #"type" ] == "<dev string:x1ec>" )
            {
                level.var_eb0e2b51++;
                level.var_b7d2deb[ level.var_b7d2deb.size ] = ent;
            }
        }
    }

    // Namespace snd/snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x73601598, Offset: 0x2550
    // Size: 0x5a2, Type: dev
    function private function_fcbbe789( key, value )
    {
        var_76519319 = ishash( key ) || isstring( key );
        var_9cb80f5f = isdefined( value );
        
        if ( function_81fac19d( !var_76519319, "<dev string:x200>" ) )
        {
            return;
        }
        
        if ( function_81fac19d( !var_9cb80f5f, "<dev string:x21d>" ) )
        {
            return;
        }
        
        switch ( key )
        {
            default:
                break;
            case #"hash_7bf92664f192f2a2":
            case #"hash_7bf92664f192f2a2":
                level._snd._debug.debuglevel = int( value );
                break;
            case #"hash_7f77282fd4f2f35c":
            case #"hash_7f77282fd4f2f35c":
                level._snd._debug.filter = "<dev string:x4b>" + value;
                break;
            case #"hash_52bc4ee11d186c55":
            case #"hash_52bc4ee11d186c55":
                level._snd._debug.hud_x = int( value );
                break;
            case #"hash_52bc4de11d186aa2":
            case #"hash_52bc4de11d186aa2":
                level._snd._debug.hud_y = int( value );
                break;
            case #"hash_4b427a4d65f4f4b0":
            case #"hash_4b427a4d65f4f4b0":
                level._snd._debug.dist_radius = int( value );
                break;
            case #"hash_182296346d138cf8":
            case #"hash_182296346d138cf8":
                level._snd._debug.scale_3d = float( value );
                break;
            case #"hash_3b9f89c8082a9915":
            case #"hash_3b9f89c8082a9915":
                if ( isstring( value ) )
                {
                }
                else if ( isvec( value ) )
                {
                    level._snd._debug.color_3d = value;
                }
                
                break;
            case #"hash_3944b771315157c1":
            case #"hash_3944b771315157c1":
                level._snd._debug.color_scale = float( value );
                break;
            case #"hash_28da12ba1bad355a":
            case #"hash_28da12ba1bad355a":
                level._snd._debug.var_2751db2e = int( value );
                break;
            case #"hash_7fb5d688966509c9":
            case #"hash_7fb5d688966509c9":
                level._snd._debug.distance_max = int( value );
                break;
            case #"hash_4a9b448151bd0fa9":
            case #"hash_4a9b448151bd0fa9":
                level._snd._debug.dot = float( value );
                break;
            case #"hash_579325eaa87b4d2f":
            case #"hash_579325eaa87b4d2f":
                level._snd._debug.draw_limit = int( value );
                break;
            case #"hash_35a6f662245752fa":
            case #"hash_35a6f662245752fa":
                level._snd._debug.xhair = int( value );
                break;
            case #"hash_5ba24ffba2d85322":
            case #"hash_5ba24ffba2d85322":
                level._snd._debug.xhair_alpha = float( value );
                break;
            case #"hash_3d649e7c9abdc358":
            case #"hash_3d649e7c9abdc358":
                level._snd._debug.xhair_radius = int( value );
                break;
        }
    }

    // Namespace snd/snd_debug
    // Params 1, eflags: 0x4
    // Checksum 0x4d24ac3e, Offset: 0x2b00
    // Size: 0x12c, Type: dev
    function private function_a3f5c17f( p )
    {
        var_cf07c027 = isstruct( p );
        var_76519319 = ishash( p.name ) || isstring( p.name );
        var_9cb80f5f = isdefined( p.value );
        var_aa7a0fd6 = var_cf07c027 && var_76519319 && var_9cb80f5f;
        
        if ( function_81fac19d( !var_aa7a0fd6, "<dev string:x23c>" ) )
        {
            /#
                if ( function_f984063f() )
                {
                    debugbreak();
                }
            #/
            
            return;
        }
        
        function_fcbbe789( p.name, p.value );
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0x47ce325d, Offset: 0x2c38
    // Size: 0x614, Type: dev
    function private function_926b63ee()
    {
        hudx = -480;
        hudy = -272;
        
        if ( ispc() )
        {
            hudx = -444;
            hudy = -248;
        }
        
        waitforplayers();
        level._snd._debug = spawnstruct();
        level._snd._debug.debuglevel = 0;
        level._snd._debug.filter = "<dev string:x4b>";
        level._snd._debug.hud_x = hudx;
        level._snd._debug.hud_y = hudy;
        level._snd._debug.dist_radius = 12;
        level._snd._debug.scale_3d = 0.666;
        level._snd._debug.color_3d = ( 0.5, 1, 0.666 );
        level._snd._debug.color_scale = 0.72974;
        level._snd._debug.var_2751db2e = 5;
        level._snd._debug.distance_max = 0;
        level._snd._debug.dot = 0.99;
        level._snd._debug.draw_limit = 0;
        level._snd._debug.xhair = 0;
        level._snd._debug.xhair_alpha = 0.1;
        level._snd._debug.xhair_radius = 5;
        util::init_dvar( "<dev string:x267>", level._snd._debug.debuglevel, &function_a3f5c17f );
        util::init_dvar( "<dev string:x277>", level._snd._debug.filter, &function_a3f5c17f );
        util::init_dvar( "<dev string:x28d>", level._snd._debug.hud_x, &function_a3f5c17f );
        util::init_dvar( "<dev string:x2a1>", level._snd._debug.hud_y, &function_a3f5c17f );
        util::init_dvar( "<dev string:x2b5>", level._snd._debug.dist_radius, &function_a3f5c17f );
        util::init_dvar( "<dev string:x2cb>", level._snd._debug.scale_3d, &function_a3f5c17f );
        util::init_dvar( "<dev string:x2e0>", level._snd._debug.color_3d, &function_a3f5c17f );
        util::init_dvar( "<dev string:x2f5>", level._snd._debug.color_scale, &function_a3f5c17f );
        util::init_dvar( "<dev string:x30f>", level._snd._debug.var_2751db2e, &function_a3f5c17f );
        util::init_dvar( "<dev string:x328>", level._snd._debug.distance_max, &function_a3f5c17f );
        util::init_dvar( "<dev string:x340>", level._snd._debug.dot, &function_a3f5c17f );
        util::init_dvar( "<dev string:x353>", level._snd._debug.draw_limit, &function_a3f5c17f );
        util::init_dvar( "<dev string:x36c>", level._snd._debug.xhair, &function_a3f5c17f );
        util::init_dvar( "<dev string:x385>", level._snd._debug.xhair_alpha, &function_a3f5c17f );
        util::init_dvar( "<dev string:x3a3>", level._snd._debug.xhair_radius, &function_a3f5c17f );
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0xb9a00d9a, Offset: 0x3258
    // Size: 0xa6, Type: dev
    function private function_222f3594()
    {
        level notify( #"hash_1b2711bf69eca1e2" );
        level endon( #"hash_1b2711bf69eca1e2" );
        waitforplayers();
        
        while ( true )
        {
            var_977d0bf3 = function_95c9af4b();
            
            if ( var_977d0bf3 > 0 )
            {
                function_c5ac5c05( var_977d0bf3 );
                function_3d58f598( var_977d0bf3 );
            }
            
            waitframe( 1 );
        }
    }

    // Namespace snd/snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0xb4c53e39, Offset: 0x3308
    // Size: 0x88, Type: dev
    function private function_29bb1234( *key, value )
    {
        if ( value != "<dev string:x4b>" && isstring( value ) == 1 )
        {
            function_81fac19d( 1, "<dev string:x3c2>" + value + "<dev string:x3d5>" );
            level notify( value );
        }
        
        return "<dev string:x4b>";
    }

    // Namespace snd/snd_debug
    // Params 0, eflags: 0x4
    // Checksum 0xdd7b9125, Offset: 0x3398
    // Size: 0x416, Type: dev
    function private function_fa2bfbd1()
    {
        player = self;
        player endon( #"hash_1c8039ff7519235" );
        
        while ( true )
        {
            vidsize = function_827811b5();
            var_9e35ce44 = vidsize[ 0 ] * 0.5;
            var_749dfb19 = vidsize[ 1 ] * 0.5;
            eyeorigin = player getplayervieworigin();
            eyeangles = player getplayerviewangles();
            eyeforward = anglestoforward( eyeangles );
            eyeright = anglestoright( eyeangles );
            traceend = eyeorigin + eyeforward * 262144;
            trace = bullettrace( eyeorigin, traceend, 1, player );
            
            if ( isdefined( trace ) == 1 && isdefined( trace[ #"position" ] ) == 1 && trace[ #"position" ] != eyeorigin )
            {
                pos = trace[ #"position" ];
                surfacetype = trace[ #"surfacetype" ];
                dist = distance( pos, eyeorigin );
                fontscale = 1.5;
                posstring = "<dev string:x3dc>" + pos[ 0 ] + "<dev string:x3e2>" + pos[ 1 ] + "<dev string:x3e2>" + pos[ 2 ] + "<dev string:x3e8>";
                hoffset = 1 * fontscale * 24;
                function_65bb0ccd( posstring, var_9e35ce44, var_749dfb19 + hoffset, fontscale, "<dev string:xa9>", ( 1, 1, 1 ), 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
                diststring = "<dev string:x4b>" + dist;
                hoffset = 2 * fontscale * 24;
                function_65bb0ccd( diststring, var_9e35ce44, var_749dfb19 + hoffset, fontscale, "<dev string:xa9>", ( 1, 1, 1 ), 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
                
                if ( isdefined( surfacetype ) == 1 )
                {
                    surfstring = "<dev string:x4b>" + surfacetype + "<dev string:x4b>";
                    hoffset = 3 * fontscale * 24;
                    function_65bb0ccd( surfstring, var_9e35ce44, var_749dfb19 + hoffset, fontscale, "<dev string:xa9>", ( 1, 1, 1 ), 0.854248, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
                }
                
                debugcrosshair( pos, 4, ( 0, 0, 0 ), ( 1, 1, 1 ), 1, 1 );
            }
            
            waitframe( 1 );
        }
    }

    // Namespace snd/snd_debug
    // Params 2, eflags: 0x4
    // Checksum 0x1f170035, Offset: 0x37b8
    // Size: 0x13a, Type: dev
    function private function_53489ad( *key, value )
    {
        if ( is_true( level._snd.var_8c37ff34 ) )
        {
            intvalue = int( value );
            waitforplayers();
            players = getplayerssafe();
            
            foreach ( player in players )
            {
                if ( intvalue > 0 )
                {
                    player thread function_fa2bfbd1();
                    continue;
                }
                
                player notify( #"hash_1c8039ff7519235" );
            }
        }
        
        return value;
    }

#/
