;--------------------------------------------------------
;                   d-tool v.9.7
;--------------------------------------------------------
;;;;;;;;;;;;;;;;;;EVENTS
on *:text:*:%dtprechans: {
  if ( $readini(d-tool\d-tool.ini,vars,status) == on ) && ( nuke !isin $1- ) && ( *.*-* iswm $1- || *_*-* iswm $1- ) {
    if ( $nick == $readini(d-tool\d-tool.ini,vars,prebot1) ) && ( $chan == $readini(d-tool\d-tool.ini,vars,prechan1) ) var %dtpretemp = 1 | elseif ( $nick == $readini(d-tool\d-tool.ini,vars,prebot2) ) && ( $chan == $readini(d-tool\d-tool.ini,vars,prechan2) ) var %dtpretemp = 2 | elseif ( $nick == $readini(d-tool\d-tool.ini,vars,prebot3) ) && ( $chan == $readini(d-tool\d-tool.ini,vars,prechan3) ) var %dtpretemp = 3 | var %p1 = $readini(d-tool\d-tool.ini,vars,prematch $+ %dtpretemp $+ )
    if ( $readini(d-tool\d-tool.ini,vars,prematch $+ %dtpretemp $+ ) isin $strip($1-) ) {
      if ( %p1 isin $strip($1) ) || ( %p1 isin $strip($2) ) || ( %p1 isin $strip($3) ) || ( %p1 isin $strip($4) ) || ( %p1 isin $strip($5) ) { 
        var %fa = $read(d-tool\foreign.db,1) | var %fb = 1 | while ( %fb <= $numtok(%fa,32) ) { if ( $chr(46) $+  $gettok(%fa,%fb,32) $+ $chr(46) isincs $1- ) || ( $chr(46) $+  $gettok(%fa,%fb,32) $+ $chr(45) isincs $1- )  || ( $chr(95) $+  $gettok(%fa,%fb,32) $+ $chr(95) isincs $1- ) || ( $chr(95) $+  $gettok(%fa,%fb,32) $+ $chr(45) isincs $1- ) { 
            var %fr = 1 | while ( %fr <= $numtok(%dtlangt,32) ) {
              if ( $chr(46) $+ $gettok(%dtlangt,%fr,32) $+ $chr(46) isincs $1- ) || ( $chr(46) $+ $gettok(%dtlangt,%fr,32) $+ $chr(45) isincs $1- ) || ( $chr(95) $+ $gettok(%dtlangt,%fr,32) $+ $chr(95) isincs $1- ) || ( $chr(95) $+ $gettok(%dtlangt,%fr,32) $+ $chr(45) isincs $1- ) goto langskip
              inc %fr
            }
            goto prebotend
          }
          inc %fb
        }
        :langskip    
        if ( %dtpretemp == 1 ) { if (  *.*-* iswm $remove($strip($eval(%dtprerelnr1,2)),[,]) ) || ( *_*-* iswm $remove($strip($eval(%dtprerelnr1,2)),[,]) ) var %prerlsname = $remove($strip($eval(%dtprerelnr1,2)),[,]) }
        elseif ( %dtpretemp == 2 ) { if ( *.*-* iswm $remove($strip($eval(%dtprerelnr2,2)),[,]) ) || ( *_*-* iswm $remove($strip($eval(%dtprerelnr2,2)),[,]) ) var %prerlsname = $remove($strip($eval(%dtprerelnr2,2)),[,]) } 
        elseif ( %dtpretemp == 3 ) { if ( *.*-* iswm $remove($strip($eval(%dtprerelnr3,2)),[,]) ) || ( *_*-* iswm $remove($strip($eval(%dtprerelnr3,2)),[,]) ) var %prerlsname = $remove($strip($eval(%dtprerelnr3,2)),[,]) }
        if ( %dtpreoff != 1 ) {
          if ($readini(d-tool\d-tool.ini,vars,pretime1)) { 
            if ( %dtprecount1 == $null ) || ( %dtprecount1 >= 60 ) { set %dtprecount1 1 } | elseif ( %dtprecount1 == 60 ) { set %dtprecount1 1 } | else inc %dtprecount1 
            if ( *-* iswm %prerlsname ) { set %dtprenr $+ %dtprecount1 %prerlsname %dtpretemp $time | .timer 1 $readini(d-tool\d-tool.ini,vars,pretime1) unset %dtprenr $+ $calc(%dtprecount1 + 0) }
          }
          if ($readini(d-tool\d-tool.ini,vars,pretime2)) { 
            if ( %dtprecount2 == $null ) || ( %dtprecount2 >= 120 ) { set %dtprecount2 61 } | elseif ( %dtprecount2 == 120 ) { set %dtprecount2 61 } | else inc %dtprecount2
            if ( *-* iswm %prerlsname ) { set %dtprenr $+ %dtprecount2 %prerlsname %dtpretemp $time | .timer 1 $readini(d-tool\d-tool.ini,vars,pretime2) unset %dtprenr $+ $calc(%dtprecount2 + 0) }
          }
          if ($readini(d-tool\d-tool.ini,vars,pretime3)) { 
            if ( %dtprecount3 == $null ) || ( %dtprecount3 >= 180 ) { set %dtprecount3 121 } | elseif ( %dtprecount3 == 180 ) { set %dtprecount3 121 } | else inc %dtprecount3
            if ( *-* iswm %prerlsname ) { set %dtprenr $+ %dtprecount3 %prerlsname %dtpretemp $time | .timer 1 $readini(d-tool\d-tool.ini,vars,pretime3) unset %dtprenr $+ $calc(%dtprecount3 + 0) }
          }
        }
      }
      if ( $readini(d-tool\d-tool.ini,vars,imdbs) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,tv) == 1 ) {
        if ( $regex(%rls,.S[0-9][0-9]E[0-9][0-9]) == 1 || $regex(%rls,.S[0-9][0-9]) == 1 || $regex(%rls,.E[0-9][0-9]) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,tv) == 1 ) && ( german !isin %prerlsname ) { dmaze %prerlsname | dimdb %prerlsname } 
        elseif ( xvid isin %prerlsname ) || ( dvdr- isin %prerlsname ) || ( dvdr. isin %prerlsname ) || ( .x26 isin %prerlsname ) || ( .h26 isin %prerlsname ) || ( .AVC isin %prerlsname ) || ( .HEVC isin %prerlsname ) || ( Complete.Bluray isin %prerlsname ) {
          if ( $regex(%prerlsname,S[0-9]) != 1 ) && ( $regex(%prerlsname,E[0-9]) != 1 ) && ( .Doku !isin %prerlsname ) && ( .Docu !isin %prerlsname ) && ( .Staffel !isin %prerlsname ) && ( .HDTV !isin %prerlsname ) && ( .XXX !isin %prerlsname ) && ( mdvdr !isin %prerlsname ) && ( mvid !isin %prerlsname ) && ( flac !isin %prerlsname ) {
            if ( $readini(d-tool\d-tool.ini,vars,imdbs) == 1 ) dimdb %prerlsname 
          }
        }
      }
      :prebotend 
      if ($readini(d-tool\d-tool.ini,vars,trigger)) { dttrigger %prerlsname $readini(d-tool\d-tool.ini,vars,trigger) }
    }
  }  
}
on *:text:*:%dthlchans: {
  if ( $readini(d-tool\d-tool.ini,vars,status) == on ) {
    if ( NEW RACER isin $1- ) || ( NEW CD isin $1- ) || ( NEW LEADER isin $1- ) || ( LEADER isincs $1- ) || ( -ENESS isin $1- ) { goto goon }
    var %m = 1 | while ( %m <= $readini(d-tool\d-tool.ini,matches,count) ) {
      if ( $readini(d-tool\d-tool.ini,matches,%m) isincs $1- ) {
        if ( *.*-* iswm $1- ) || (  *_*-* iswm $1- ) {
          var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) {
            var %sn = $readini(d-tool\d-tool.ini,sites,%s) | var %sini = %sn $+ .ini
            if ( $nick == $readini(d-tool\inis\ $+ %sini,%sn,bot) ) && ( $readini(d-tool\inis\ $+ %sini,%sn,match) isin $strip($readini(d-tool\inis\ $+ %sini,%sn,new)) ) && ( $readini(d-tool\inis\ $+ %sini,%sn,status) == 1 ) && ( $readini(d-tool\inis\ $+ %sini,%sn,loginstatus) == 1 ) && ( *-* iswm $strip($readini(d-tool\inis\ $+ %sini,%sn,relmatch)) ) {  
              set %srcsite $readini(d-tool\inis\ $+ %sini,%sn,site) | set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite) | set %desini %dessite $+ .ini | set %srcdir $strip($readini(d-tool\inis\ $+ %sini,%sn,relsec))
              if ( /CD !isincs $1- ) && ( /DVD !isincs $1- ) && ( /Extras !isincs $1- ) && ( /(no-sample) !isin $1- ) && ( /Disk !isin $1- ) && ( /Subs !isin $1- ) && ( /Bonus !isin $1- ) && ( REQUEST !isin $1- ) && ( REQ- !isin $1- ) &&  ( /Sample !isin $1- ) && ( /Covers !isin $1- ) && ( Proof !isincs $1- ) && ( /disc !isin $1- ) { 
                if ( $readini(d-tool\d-tool.ini,vars,newspam) != 1 ) && ( $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %srcdir ) || ( music isin %srcdir ) || ( 0day isin %srcdir ) || ( 0-day isin %srcdir ) || ( flac isin %srcdir ) goto nomsg }
                if ( $readini(d-tool\d-tool.ini,vars,newwin) == 1 ) { if ( $window(d-tool_new) != $true ) window -zkbD @d-tool_new font $readini(d-tool\d-tool.ini,vars,newfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_new $timestamp 3 $readini(d-tool\inis\ $+ %sini,%sn,site)  $strip($readini(d-tool\inis\ $+ %sini,%sn,relsec))  $strip($readini(d-tool\inis\ $+ %sini,%sn,relmatch)) } 
                if ( $readini(d-tool\d-tool.ini,vars,newinatwin) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( $window(d-tool_at) != $true ) window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 3  $readini(d-tool\inis\ $+ %sini,%sn,site)  $strip($readini(d-tool\inis\ $+ %sini,%sn,relsec)) 15 $strip($readini(d-tool\inis\ $+ %sini,%sn,relmatch)) }
              }
              :nomsg
              if ( %dttrade == 1 ) {
                if ( /CD isin $strip($1-) ) || ( /dvd isin $strip($1-) ) || ( /Cover isincs $strip($1-) ) || ( uploaded in isin $strip($1-) ) || ( /Extras isincs $strip($1-) ) || ( no-nfo isin $strip($1-) ) || ( $chr(40) $+ incomplete $+ $chr(41) isin $strip($1-) ) || ( /bonus isin $strip($1-) ) || ( /sample isin $strip($1-) ) || ( /covers isin $strip($1-) ) || ( /proof isin $strip($1-) ) || ( $chr(32) $+ leader $+ $chr(32) isin $strip($1-) ) || ( $chr(32) $+ LEADER] isincs $strip($1-) ) || ( /Subs isin $strip($1-) ) || ( /multisubs isin $strip($1-) ) || ( /AC3 isin $strip($1-) ) || ( /Tool isincs $strip($1-) ) || ( /Disk isin $strip($1-) ) || ( /Disc isin $strip($1-) ) || ( /Audio isincs $strip($1-) ) || ( NUKED isincs $strip($1-) ) { goto goon }
                set %rls $remove($strip($readini(d-tool\inis\ $+ %sini,%sn,relmatch)),[,],$chr(34)) | if ( - isin $gettok(%rls,$numtok(%rls,47),47) ) set %rls $gettok(%rls,$numtok(%rls,47),47) | if ( $right(%rls,1) == . ) || ( $right(%rls,1) == $chr(41) ) set %rls $left(%rls,$calc($len(%rls) - 1))
                var %v = 1 | while ( %v <= $readini(d-tool\sections.ini,name,count) ) { 
                  if ( %srcdir == $readini(d-tool\inis\ $+ %sini,%sn,secprefix) $+ $readini(d-tool\inis\ $+ %sini,sections,dlight $+ %v ) $+ $readini(d-tool\inis\ $+ %sini,%sn,secsuffix) ) {
                    set %srcdir $readini(d-tool\inis\ $+ %sini,sections,dlight $+ %v ) | set %dtwindownr $calc($eval(%s $+ 0) + $calc($readini(d-tool\d-tool.ini,vars,winstart)))
                    :raceon
                    set %sektionnr %v | set %srcdirdir $readini(d-tool\inis\ $+ %sini,sections,dlight $+ %v $+ dir) | if ( $readini(d-tool\inis\ $+ %sini,%sn,status) == 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,status) == 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,loginstatus) == 1 ) {
                      if ( $readini(d-tool\inis\ $+ %desini,sections,dlight $+ %v) == $null ) goto others | set %desdir $eval($readini(d-tool\inis\ $+ %desini,sections,dlight $+ %v),3) | set %desdirdir $eval($readini(d-tool\inis\ $+ %desini,sections,dlight $+ %v $+ dir),3) | trade
                    }
                    :others
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite1) ) && ( %c != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite1) | set %desini %dessite $+ .ini | var %c = 1 | set %dtwindownr $calc($eval(%s $+ 1) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite2) ) && ( %d != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite2) | set %desini %dessite $+ .ini | var %d = 1 | set %dtwindownr $calc($eval(%s $+ 2) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite3) ) && ( %e != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite3) | set %desini %dessite $+ .ini | var %e = 1 | set %dtwindownr $calc($eval(%s $+ 3) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite4) ) && ( %f != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite4) | set %desini %dessite $+ .ini | var %f = 1 | set %dtwindownr $calc($eval(%s $+ 4) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite5) ) && ( %g != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite5) | set %desini %dessite $+ .ini | var %g = 1 | set %dtwindownr $calc($eval(%s $+ 5) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite6) ) && ( %h != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite6) | set %desini %dessite $+ .ini | var %h = 1 | set %dtwindownr $calc($eval(%s $+ 6) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite7) ) && ( %k != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite7) | set %desini %dessite $+ .ini | var %k = 1 | set %dtwindownr $calc($eval(%s $+ 7) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite8) ) && ( %l != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite8) | set %desini %dessite $+ .ini | var %l = 1 | set %dtwindownr $calc($eval(%s $+ 8) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    if ( $readini(d-tool\inis\ $+ %sini,%sn,fillsite9) ) && ( %m != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%sn,fillsite9) | set %desini %dessite $+ .ini | var %m = 1 | set %dtwindownr $calc($eval(%s $+ 9) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | goto raceon }
                    goto goon
                  }
                  inc %v
                }
              }
            }
            inc %s
          }
        }
      }
      inc %m 
    }
    if ( %dtaffils == 1 ) && ( AUTOWIPE !isin $1- ) && ( PRE-TRAFFIC !isin $1- ) && ( PRE-BW !isin $1- ) && ( PREBW !isin $1- ) && ( PRESENT !isincs $1- ) { 
      var %d = 1 | while ( %d <= $readini(d-tool\d-tool.ini,sites,count) ) { 
        var %a = $readini(d-tool\d-tool.ini,sites,%d) | var %sini = %a $+ .ini | if ( $readini(d-tool\inis\ $+ %sini,%a,affmatch) isincs $strip($readini(d-tool\inis\ $+ %sini,%a,affm)) ) && ( $nick == $readini(d-tool\inis\ $+ %sini,%a,bot) ) && ( $readini(d-tool\inis\ $+ %sini,%a,status) == 1 ) {
          var %i = 1 | while ( %i <= $readini(d-tool\sections.ini,name,count) ) {
            if ($readini(d-tool\inis\ $+ %sini,sections,dlight $+ %i)) && ( $readini(d-tool\inis\ $+ %sini,%a,affprefix) $+ $readini(d-tool\inis\ $+ %sini,sections,dlight $+ %i) $+ $readini(d-tool\inis\ $+ %sini,%a,affsuffix) isin $strip($eval(%dtpreprefix $+ $readini(d-tool\inis\ $+ %sini,%a,affsecnr),3)) ) { 
              set %sektionnr %i | set %srcsite %a | set %srcdir $readini(d-tool\inis\ $+ %sini,sections,dlight $+ %sektionnr) | set %srcdirdir $readini(d-tool\inis\ $+ %sini,sections,dlight $+ %sektionnr $+ dir)
              set %dessite $readini(d-tool\inis\ $+ %sini,%a,affsite) | set %desini %dessite $+ .ini | set %dtaffrls $strip($remove($eval(%dtpreprefix $+ $readini(d-tool\inis\ $+ %sini,%a,affrelnr),3),[,])) | if ( $right(%dtaffrls,1) == . ) set %dtaffrls $left(%dtaffrls,$calc($len(%dtaffrls) - 1)) | if ( *.*-* !iswm %dtaffrls ) && ( *_*-* !iswm %dtaffrls ) goto affilend | set %sektionnr %i | set %dtwindownr $calc($eval(%d $+ 0) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) 
              grpname %dtaffrls | if ( %dtgrpn != iND ) addaffil
              if ( $readini(d-tool\d-tool.ini,vars,affwin) == 1 ) { window -zkbD @d-tool_affil -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_affil $timestamp 3 %srcsite - %srcdir 14 $strip(%dtaffrls) ( $+ $chan $+ ) }
              elseif ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %srcdir ) || ( music isin %srcdir ) || ( 0day isin %srcdir ) || ( 0-day isin %srcdir ) || ( flac isin %srcdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 3 %srcsite 4AFFIL - %srcdir 14 $strip(%dtaffrls) } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp 3 %srcsite 4AFFIL - %srcdir 14 $strip(%dtaffrls) } }
              :affagain
              set %sektionnr %i | set %desini %dessite $+ .ini | set %desdir $readini(d-tool\inis\ $+ %desini,sections,dlight $+ %sektionnr) | set %desdirdir $readini(d-tool\inis\ $+ %desini,sections,dlight $+ %sektionnr $+ dir) | if (%desdir) && ( $readini(d-tool\inis\ $+ %desini,%dessite,status) == 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,loginstatus) == 1 ) { set %rls $strip(%dtaffrls) | trade affil }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite1) ) && ( %oa != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite1) | set %dtwindownr $calc($eval(%d $+ 1) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %oa = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite2) ) && ( %pa != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite2) | set %dtwindownr $calc($eval(%d $+ 2) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %pa = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite3) ) && ( %qa != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite3) | set %dtwindownr $calc($eval(%d $+ 3) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %qa = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite4) ) && ( %ra != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite4) | set %dtwindownr $calc($eval(%d $+ 4) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %ra = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite5) ) && ( %sa != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite5) | set %dtwindownr $calc($eval(%d $+ 5) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %sa = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite6) ) && ( %ta != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite6) | set %dtwindownr $calc($eval(%d $+ 6) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %ta = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite7) ) && ( %ua != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite7) | set %dtwindownr $calc($eval(%d $+ 7) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %ua = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite8) ) && ( %va != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite8) | set %dtwindownr $calc($eval(%d $+ 8) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %va = 1 | goto affagain }
              if ( $readini(d-tool\inis\ $+ %sini,%srcsite,affsite9) ) && ( %wa != 1 ) { set %dessite $readini(d-tool\inis\ $+ %sini,%srcsite,affsite9) | set %dtwindownr $calc($eval(%d $+ 9) + $calc($readini(d-tool\d-tool.ini,vars,winstart))) | var %wa = 1 | goto affagain }
              goto goon
            }
            inc %i 
          } 
        }
        inc %d 
      }
    }
    :affilend
    ;Requests
    if ( Request isin $1- ) && ( %dtreqfill == 1 ) && ( Requests !isincs $1- ) && ( *.*-*/*.*-* !iswm $1- ) && ( $chr(126) !isin $1- ) && ( reqfilled !isin $1- ) && ( NEW !isincs $1- ) { 
      if ( Please fill isin $strip($1-) ) || ( adds isincs $strip($1-) ) || ( added isincs $strip($1-) ) || ( looking for isin $strip($1-) ) || ( by isin $1- && REQUEST isincs $1- && REQUEST- !isincs $1- && REQUESTS !isincs $1- ) || ( newrequest isin $1- ) { 
        var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) {
          var %sn = $readini(d-tool\d-tool.ini,sites,%s) | var %sini = %sn $+ .ini
          if ( $nick == $readini(d-tool\inis\ $+ %sini,%sn,bot) ) && ( $readini(d-tool\inis\ $+ %sini,%sn,reqget) == 1 ) {
            var %f = 1 | while ( %f <= 20 ) {
              if ( *.*-* iswm $eval($ $+ %f,2) ) || ( *_*-* iswm $eval($ $+ %f,2) ) { set %reqrls $strip($eval($ $+ %f,2)) | if ( $right(%reqrls,1) == . ) set %reqrls $left(%reqrls,$calc($len(%reqrls) - 1)) }
              if ( by isin $eval($ $+ %f,2) ) { set %reqnick $gettok($strip($eval($ $+ $calc(%f + 1),2)),1,47) | if ( $right(%reqnick,1) == . ) set %reqnick $left(%reqnick,$calc($len(%reqnick) - 1)) }
              ;;;;;Site-Specific Line;;;
              if ( VSO isin %reqnick ) set %reqnick ViSiOn
              ;;;;
              inc %f 
            }
            if ( REQUEST-by isin %reqrls ) set %reqrls $remove(%reqrls,REQUEST-by. $+ %reqnick $+ -)
            if ($readini(d-tool\d-tool.req.db,%reqrls,reqsite)) .remini d-tool\d-tool.req.db %reqrls | if (%reqrls) writeini -n d-tool\d-tool.req.db %reqrls reqsite %sn
            if ( $readini(d-tool\inis\ $+ %sini,%sn,gl) == 1 ) && ($readini(d-tool\inis\ $+ %sini,%sn,reqpath)) && (%reqrls) { if ($readini(d-tool\inis\ $+ %sini,%sn,reqprefix)) writeini -n d-tool\d-tool.req.db %reqrls reqpath / $+ $readini(d-tool\inis\ $+ %sini,%sn,reqpath) $+ / $+ $readini(d-tool\inis\ $+ %sini,%sn,reqprefix) $+ %reqrls | else writeini -n d-tool\d-tool.req.db %reqrls reqpath / $+ $readini(d-tool\inis\ $+ %sini,%sn,reqpath) $+ /REQ- $+ %reqrls }
            elseif ( $readini(d-tool\inis\ $+ %sini,%sn,gl) != 1 ) && ($readini(d-tool\inis\ $+ %sini,%sn,reqpath)) && (%reqrls) { if (%reqnick) writeini -n d-tool\d-tool.req.db %reqrls reqpath / $+ $readini(d-tool\inis\ $+ %sini,%sn,reqpath) $+ /REQUEST-by. $+ %reqnick $+ - $+ %reqrls | else writeini -n d-tool\d-tool.req.db %reqrls reqpath / $+ $readini(d-tool\inis\ $+ %sini,%sn,reqpath) $+ /REQUEST- $+ %reqrls }
            if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,reqwinreq) == 1 ) { if ( !$window(@d-tool_req)) { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico } | aline -p @d-tool_req $date $timestamp $chan 3 Request ( $+ %reqnick $+ ):14 %reqrls }
            reqsearch %reqrls
          }
          inc %s
        }
        goto goon
      }
    }
    ;Complete.Speed
    var %rg = 1 | while ( %rg <= $numtok($readini(d-tool\d-tool.ini,vars,compflags),44) ) {
      if ( $gettok($readini(d-tool\d-tool.ini,vars,compflags),%rg,44) isincs $strip($1-) ) || ( complete isin $remove($1-,COMPLETE.,COMPLETE_,$chr(91),$chr(93)) ) {
        if ( 100% !isin $1- && % isin $1- ) goto speedend
        if ( $readini(d-tool\d-tool.ini,vars,speeds) == 1 ) {
          if  ($regex($strip($1-),[0-9][0-9]MB/s) == 1 ) || ( $regex($strip($1-),[0-9][0-9]KB/s) == 1 ) || ( $regex($strip($1-),[0-9].[0-9]MB/s) == 1 ) || ( $regex($strip($1-),[0-9].[0-9]KB/s) == 1 ) {
            if ( Nuke !isin $1- ) && ( /Sample !isin $1- ) && ( /100%/ !isin $1- ) && ( incomplete !isin $1- ) && ( /Covers !isin $1- ) && ( /Subs !isin $1- ) &&  ( /Proof !isincs $1- ) && ( imageset !isin $1- ) && ( .complete. !isin $1- && request !isin $1- ) && ( Top !isin $1- ) && ( *when*races* !iswm $1- ) && ( mp3 !isin $1- ) && ( flac !isin $1- ) && ( 0day !isin $1- ) && ( ebook !isin $1- ) {
              var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { 
                var %sn = $readini(d-tool\d-tool.ini,sites,%s) | var %snini = $readini(d-tool\d-tool.ini,sites,%s) $+ .ini | if ( $nick == $readini(d-tool\inis\ $+ %snini,%sn,bot) ) {
                  var %t = 1 | while ( %t <= 10 ) {
                    if ( *.*-* iswm $eval($ $+ %t,2) ) || ( *_*-* iswm $eval($ $+ %t,2) ) set %dtspeedrls1 $strip($eval($ $+ %t,2))
                    inc %t
                  }
                  if (%dtspeedrls1) && ( %dtspeedrls1 != %dtspeedrls ) {
                    if ( $readini(d-tool\d-tool.ini,vars,speedall) == 1 ) { window -zkbD @d-tool_speed font $readini(d-tool\d-tool.ini,vars,speedfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_speed . }
                    elseif ( $readini(d-tool\d-tool.ini,vars,speedall) == 0 && mp3 !isin $1- && 0day !isin $1- && imageset !isin $1- && FLAC !isincs $1- ) { window -zkbD @d-tool_speed font $readini(d-tool\d-tool.ini,vars,speedfsize) | aline -p @d-tool_speed . }
                    set %dtspeedrls %dtspeedrls1
                  }
                  if ( $readini(d-tool\d-tool.ini,vars,speedall) == 1 ) { window -zkbD @d-tool_speed font $readini(d-tool\d-tool.ini,vars,speedfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_speed $timestamp  $readini(d-tool\inis\ $+ %snini,%sn,site) 14( $+ $readini(d-tool\inis\ $+ %snini,%sn,location) $+ ) 14-  $1- }
                  elseif ( $readini(d-tool\d-tool.ini,vars,speedall) == 0 && mp3 !isin $1- && 0day !isin $1- && imageset !isin $1- && FLAC !isincs $1- ) { window -zkbD @d-tool_speed font $readini(d-tool\d-tool.ini,vars,speedfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_speed $timestamp  $readini(d-tool\inis\ $+ %snini,%sn,site) 14( $+ $readini(d-tool\inis\ $+ %snini,%sn,location) $+ ) 14-  $1- } 
                } 
                inc %s 
              } 
            } 
          }
        }
        goto speedend  
      }
      inc %rg
    }
    :speedend
    ;Requests.Complete
    if ( request isin $1- ) && ( !request !isin $1- ) {
      var %rh = 1 | while ( %rh <= $numtok($readini(d-tool\d-tool.ini,vars,compflags),44) ) {
        if ( $gettok($readini(d-tool\d-tool.ini,vars,compflags),%rg,44) isincs $strip($1-) ) || ( complete isin $remove($1-,COMPLETE.,COMPLETE_) ) {
          if ( /Proof !isincs $strip($1-) ) && ( /Tool !isin $strip($1-) ) && ( /Sample !isin $strip($1-) ) && ( /Disc !isin $strip($1-) ) && ( /Disk !isin $strip($1-) ) && ( /cd !isin $strip($1-) ) && ( /Subs !isin $strip($1-) ) && ( /AC3 !isin $strip($1-) ) && ( .COMPLETE !isin $strip($1-) ) {
            if ( % isin $strip($1-) ) && ( 100% !isin $strip($1-) ) goto notcomplete
            var %rc = 1 | while ( %rc <= 15 ) {
              if ( $readini(d-tool\d-tool.req.db,items,%rc) isin $1- ) {
                var %d = $readini(d-tool\d-tool.req.db,$readini(d-tool\d-tool.req.db,items,%rc),reqsite) | var %dini = %d $+ .ini | if ( $nick == $readini(d-tool\inis\ $+ %dini,%d,bot) ) { 
                  if ( $readini(d-tool\inis\ $+ %dini,%d,reqfillcmd) == 1 ) {
                    if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) raw $readini(d-tool\d-tool.req.db,$readini(d-tool\d-tool.req.db,items,%rc),reqsite) site reqfilled $readini(d-tool\d-tool.req.db,items,%rc)
                    else .timer 1 1 dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ $readini(d-tool\d-tool.req.db,$readini(d-tool\d-tool.req.db,items,%rc),reqsite) $+ ', 'site reqfilled $readini(d-tool\d-tool.req.db,items,%rc) $+ ', RS_LOGIN or RS_LOGOUT) 
                  }
                  if ( $readini(d-tool\inis\ $+ %dini,%d,reqfilled) == 1 ) { if ($readini(d-tool\inis\ $+ %dini,%d,reqchan)) msg $eval($chr(35) $+ $readini(d-tool\inis\ $+ %dini,%d,reqchan),1) !reqfilled $readini(d-tool\d-tool.req.db,items,%rc) | else msg $chan !reqfilled $readini(d-tool\d-tool.req.db,items,%rc) }
                  if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) { if (!$window(@d-tool_req)) { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico } | aline -p @d-tool_req $timestamp 3 Complete:14 $readini(d-tool\d-tool.req.db,$readini(d-tool\d-tool.req.db,items,%rc),reqsite)  $readini(d-tool\d-tool.req.db,items,%rc) }
                  .remini d-tool\d-tool.req.db $readini(d-tool\d-tool.req.db,items,%rc) | .remini d-tool\d-tool.req.db items %r | goto notcomplete
                }
              }
              inc %rc
            }
          }
        }
        inc %rh
      }
    }
    :notcomplete
    ;nukes
    if ( $me isin $1- ) && (%dtnukeitem) && ( MB/s !isin $1- ) {
      if ( $nick == $gettok(%dtnukeitem,1,32) ) && ( $chan == $gettok(%dtnukeitem,2,32) ) {
        window -zkbD @d-tool_nukes font $readini(d-tool\d-tool.ini,vars,nukefsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_nukes $date(dd) $+ . $+ $date(mm) $timestamp 14 $gettok(%dtnukeitem,2,32)  $gettok(%dtnukeitem,3-,32)
        var %c = 1 | while ( %c <= 15 ) { 
          if ( $regex($gettok($strip($1-),%c,32),[0-9]GB) == 1 ) { 
            var %dtnukeamount = $remove($gettok($strip($1-),%c,32),GB.)
          } 
          inc %c
        }
        if ( %dtnukeamount > %dtbadnuke ) && ( %dtnukefilter != 1 ) && ( unnuke !isin %dtnukeitem ) { aline -p @d-tool_nukes $date(dd) $+ . $+ $date(mm) $timestamp 14--------------3BADNUKE! $chan -  $1- | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool $date(dd) $+ . $+ $date(mm) $timestamp 14--------------3BADNUKE! $chan -  $1- | unset %dtnukefilter | unset %dtnukeitem } | elseif ( %dtnukefilter != 1 ) { aline -p @d-tool_nukes $date(dd) $+ . $+ $date(mm) $timestamp 14-------------- $chan -  $1- | unset %dtnukefilter | unset %dtnukeitem }
      }
    }
    if ( nuke isin $1- ) || ( loosers isin $1- ) || ( DENIED isincs $1- ) || ( STOP isincs $1- ) {
      if ( $readini(d-tool\d-tool.ini,vars,nukes) == 1 ) && ( /nuke !isin $1- ) && ( $me $+ |nuke !isin $1- ) && ( nuketop !isin $1- ) && ( warning !isin $1- ) && ( fairness !isin $1- ) && ( get nuked !isin $1- ) {
        if ( reason isin $1- ) || ( $regex($strip($1-),[0-9]X|[0-9]x) == 1 ) || ( $regex($strip($1-),[0-9][0-9]X|[0-9][0-9]x) == 1 ) || ( $regex($strip($1-),X[0-9]|x[0-9]) == 1 ) || ( $regex($strip($1-),X[0-9][0-9]|x[0-9][0-9]) == 1 ) || ( $regex($strip($1-),X $+ $chr(32) $+ [0-9]|x $+ $chr(32) $+ [0-9]) == 1 ) || ( $regex($strip($1-),X $+ $chr(32) $+ [0-9][0-9]|x $+ $chr(32) $+ [0-9][0-9]) == 1 ) { 
          if ( $readini(d-tool\d-tool.ini,vars,nonukeinc) == 1 ) { if ( completed isin $1- ) || ( incomplete isin $1- ) || ( inc $+ $chr(32) isin $strip($1-) ) || ( inc. isin $strip($1-) ) || ( Not completed isin $1- ) { set %dtnukefilter 1 | goto nonuke } }
          if ( $readini(d-tool\d-tool.ini,vars,norepack) == 1 ) { if ( repack isin $1- ) && ( .REPACK. !isincs $1- ) { set %dtnukefilter 1 | goto nonuke } }
          if ( $readini(d-tool\d-tool.ini,vars,noproper) == 1 ) && ( proper isin $1- ) { set %dtnukefilter 1 | goto nonuke }
          if ( $readini(d-tool\d-tool.ini,vars,scene) == 1 ) && ( 1x isin $strip($1-) || x 1 isin $strip($1-) || x1 isin $strip($1-) ) { if ( 10x !isin $strip($1-) && x10 !isin $strip($1-) ) { set %dtnukefilter 1 | goto nonuke } } 
          var %n = 1 | while ( %n <= $numtok($readini(d-tool\d-tool.ini,vars,nukefilters),32) ) { 
            if ( $gettok($readini(d-tool\d-tool.ini,vars,nukefilters),%n,32) isin $1- ) { set %dtnukefilter 1 | goto nonuke }
            if ( $chr(43) isin $readini(d-tool\d-tool.ini,vars,nukefilters) ) { if $replace($gettok($readini(d-tool\d-tool.ini,vars,nukefilters),%n,32),$chr(43),$chr(32)) isin $1- ) { set %dtnukefilter 1 | goto nonuke } }
            inc %n 
          } 
          if ( *.*-* iswm $1- ) || ( *_*-* iswm $1- ) || ( relname isin $1- ) {
            if ( $me !isin $1- ) && ( %dtnukefilter != 1 ) { set %dtnukeitem $nick $chan $1- | .timer 1 1 unset %dtnukeitem  } | elseif ( $me isin $1- ) && ( %dtnukefilter != 1 ) { window -zkbD @d-tool_nukes font $readini(d-tool\d-tool.ini,vars,nukefsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_nukes $date(dd) $+ . $+ $date(mm) $timestamp 14 $chan  $1- | unset %dtnukeitem | unset %dtnukefilter | goto nonuke } 
          }
        }
      }
      unset %dtnukefilter
    }
    :nonuke
    ;Incfiller
    var %incfillline = $1- | if ( %dtincfill == 1 ) && ( reason !isin $1- ) && ( losers !isin $1- ) && ( /Sample !isin $1- ) && ( SAMPLE !isincs $1- ) {
      if ( incomplete isin $1- ) || ( Inc isincs $1- ) || ( not completed isin $1- ) || ( empty for isin $1- )  { 
        if ( *nuke*warning* iswm $1- ) || ( WARNING isincs $1- ) || ( will be nuked isin $1- ) || ( Nuke in isincs $1- ) {
          var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) {
            var %sn = $readini(d-tool\d-tool.ini,sites,%s) | var %sini = %sn $+ .ini
            if ( $nick == $readini(d-tool\inis\ $+ %sini,%sn,bot) ) && ( $readini(d-tool\inis\ $+ %sini,%sn,incget) == 1 ) {
              var %f = 1 | while ( %f <= 10 ) {
                if ( *.*-* iswm $eval($ $+ %f,2) ) || ( *_*-* iswm $eval($ $+ %f,2) ) { set %incrls $strip($eval($ $+ %f,2)) | if ( $right(%incrls,1) == . ) set %incrls $left(%incrls,$calc($len(%incrls) - 1)) }
                inc %f 
              }
              var %f = 1 | while ( %f <= $numtok(%incrls,47) ) {
                if ( *.*-* iswm $gettok(%incrls,%f,47) ) || ( *_*-* iswm $gettok(%incrls,%f,47) ) { set %incrls $gettok(%incrls,%f,47) }
                inc %f 
              }            
              var %rt = 1 | while ( %rt <= $lines(d-tool\d-tool.race.db) ) { 
                if ( $gettok($read(d-tool\d-tool.race.db,%rt),1,32) == %sn ) && ( $gettok($read(d-tool\d-tool.race.db,%rt),2,32) == %incrls ) {
                  if ($readini(d-tool\d-tool.inc.db,%incrls,incsite)) .remini d-tool\d-tool.inc.db %incrls | writeini -n d-tool\d-tool.inc.db %incrls incsite %sn 
                  if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,incwininc) == 1 ) { if (!$window(@d-tool_inc)) window -zkbD @d-tool_inc font $readini(d-tool\d-tool.ini,vars,incfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_inc $timestamp $chan 4 Incomplete:14 %incrls | aline -p @d-tool_inc %incfillline }
                  .timer 1 1 incsearch %incrls %sn
                }
                inc %rt
              }
            }
            inc %s
          }
        }
        goto goon
      }
    }
    ;Done
    if ( $readini(d-tool\d-tool.ini,vars,done) == 1 ) {
      if ( $gettok(%dtnicks,1,32) && $gettok(%dtnicks,1,32) isin $strip($1-) ) || ( $gettok(%dtnicks,2,32) && $gettok(%dtnicks,2,32) isin $strip($1-) ) || ( $gettok(%dtnicks,3,32) && $gettok(%dtnicks,3,32) isin $strip($1-) ) || ( $gettok(%dtnicks,4,32) && $gettok(%dtnicks,4,32) isin $strip($1-) ) || ( $gettok(%dtnicks,5,32) && $gettok(%dtnicks,5,32) isin $strip($1-) ) {
        if ( mp3 isin $1- || flac isin $1- || 0day isin $1- || 0-day isin $1- || spam isin $chan || 0day isin $chan  || nuke isin $1- || nuke isin $chan || loosers isin $1- || STOP isincs $1- || DENIED isincs $1- ) && ( $readini(d-tool\d-tool.ini,vars,donespam) != 1 ) { goto goon }
        if ( invite isin $1- ) || ( nuke isin $1- ) || ( looser isin $1- ) || ( racing isincs $1- ) || ( lead isincs $1- )  || ( update isincs $1- ) || ( race $+ $chr(32) isin $strip($1-) ) || ( race in isin $strip($1-) ) || ( $me $+ , isin $strip($1-) ) || ( racer isin $1- ) || ( joining $+ $chr(32) isin $strip($1-) ) || ( slowest isin $1- ) || ( FIRST isincs $1- ) || ( halfway isin $1- ) || ( HALF isincs $1- ) || ( sfv isin $1- ) || ( .nfo isincs $1- ) || ( complete isin $1- ) goto goon
        var %c = 1 | while ( %c <= $readini(d-tool\d-tool.ini,sites,count) ) {
          var %b = $readini(d-tool\d-tool.ini,sites,%c) | var %bini = $readini(d-tool\d-tool.ini,sites,%c) $+ .ini
          if ( $nick == $readini(d-tool\inis\ $+ %bini,%b,bot) ) { if ( $readini(d-tool\d-tool.ini,vars,doneuturn) != 1 ) && ( $readini(d-tool\d-tool.ini,vars,doneuturnat) != 1 ) { window -zfkbD @d-tool_done font $readini(d-tool\d-tool.ini,vars,donefsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_done $date $timestamp $chan $nick  14-  $1- } | if ( $readini(d-tool\d-tool.ini,vars,doneuturn) == 1 ) { window -zfkbD @d-tool font $readini(d-tool\d-tool.ini,vars,searchfsize) | aline -p @d-tool $timestamp $chan $nick  14-  $1- } | if ( $readini(d-tool\d-tool.ini,vars,doneuturnat) == 1 ) { if (!$window(@d-tool_at)) window -zfkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at DONE______ $timestamp $chan  14-  $1- } }   
          inc %c
        }
      }
      :goon
    }
  }
}
on *:start: { 
  .copy -o d-tool\d-tool.ini d-tool\d-tool.bak | if ( %dtmainstart == 1 ) dt | if (%dtrushtimer) dtkill | if (%dtrushqtimer) dtqt | if ( $readini(d-tool\d-tool.ini,vars,logintimers) == 1 ) { writeini d-tool\d-tool.ini vars logintimers 0 | dtlt a } | remote on | if ( $file(d-tool\tvmaze.db).size > $calc($readini(d-tool\d-tool.ini,vars,maxdbsize) * 1000) ) .remove d-tool\tvmaze.db | .remove d-tool\d-tool.req.db | if ( $file(d-tool\d-tool.race.db).size > 1000 ) .remove d-tool\d-tool.race.db | .remove d-tool.inc.db | dtlangs | dtnicks 
  if ( %inittemp != 1 ) { 
    var %t = 1 | while ( %t <= $readini(d-tool\bncsets.ini,bncs,count) ) { 
      var %s = $readini(d-tool\bncsets.ini,bncs,%t) | if ( $readini(d-tool\bncsets.ini,%s,startup) == 1 ) {
        if ( %t = 1 ) .timer 1 %t server $readini(d-tool\bncsets.ini,%s,ip) $readini(d-tool\bncsets.ini,%s,port) $decode($readini(d-tool\bncsets.ini,%s,password)) -i $readini(d-tool\bncsets.ini,%s,ident) * $readini(d-tool\bncsets.ini,%s,user) $+ @ $readini(d-tool\bncsets.ini,%s,user)
        else .timer 1 %t server -m $readini(d-tool\bncsets.ini,%s,ip) $readini(d-tool\bncsets.ini,%s,port) $decode($readini(d-tool\bncsets.ini,%s,password)) -i $readini(d-tool\bncsets.ini,%s,ident) * $readini(d-tool\bncsets.ini,%s,user) $+ @ $readini(d-tool\bncsets.ini,%s,user) 
      } 
      inc %t 
    } 
    if (%inittemp) unset %inittemp
  }
  else unset %inittemp
  if ( %dtrushs == 1 ) { run %dtrushdir }
}
on *:exit: {
  if ($timer(login)) writeini -n d-tool\d-tool.ini vars logintimers 1 | unset %dtprenr* | unset %dtimdb* | .remove d-tool\d-tool.req.db
}
on 1:load: {
  if ($version < 6.16) { echo -ts d-tool was written for mIRC 6.16 and above, If you experience errors or else, it is maybe a version conflict }
  load -rs d-tool/d-tool.dialogs.mrc | if ( $input(Initiate first Setup?,y,First Setup) == $true ) { set -n %dtpreprefix $ | set -n %dthlchans $remove(#as,as) | set %dtmainbarX 200 | set %dtmainbarY 200 | set %dtsectionX 200 | set %dtsectionY 200 | set %dtmainbar1X 200 | set %dtmainbar1Y 200 | set %dtmainbar2X 200 | set %dtmainbar2Y 200 | set %dtrulesX 200 | set %dtrulesY 200 | set %dtincfill 0 | writeini -n d-tool\d-tool.ini vars desktop -m | writeini -n d-tool\d-tool.ini vars winstart 1 | writeini -n d-tool\d-tool.ini vars blistentry 80 | writeini -n d-tool\d-tool.ini vars wlistentry 60 | writeini -n d-tool\d-tool.ini vars speedall 0 | writeini -n d-tool\d-tool.ini vars donespam 1 | writeini -n d-tool\d-tool.ini vars atwinspam 1 | writeini -n d-tool\d-tool.ini vars windowfix 1
    writeini -n d-tool\d-tool.ini vars ratwin 5 | writeini -n d-tool\d-tool.ini vars rwin 5 | writeini -n d-tool\d-tool.ini vars attempt1 50 | writeini -n d-tool\d-tool.ini vars attempt2 100 | writeini -n d-tool\d-tool.ini vars seriesborder + | writeini -n d-tool\d-tool.ini vars seriesopc 204 | writeini -n d-tool\d-tool.ini vars searchfsize 11 | writeini -n d-tool\d-tool.ini vars speedfsize 11 | writeini -n d-tool\d-tool.ini vars newfsize 11 | writeini -n d-tool\d-tool.ini vars atfsize 11 | writeini -n d-tool\d-tool.ini vars donefsize 11 | writeini -n d-tool\d-tool.ini vars imdbfsize 11 | writeini -n d-tool\d-tool.ini vars skipfsize 11 | writeini -n d-tool\d-tool.ini vars reqfsize 11 | writeini -n d-tool\d-tool.ini vars incfsize 11 | set %dtdsize 540
    writeini -n d-tool\d-tool.ini vars aentrys 40 | writeini -n d-tool\d-tool.ini vars gblistentry 100 | writeini -n d-tool\d-tool.ini vars gwlistentry 60 | writeini -n d-tool\d-tool.ini vars completeline ([^\w]*100.0%[^\w]*)|([^\w]\sdone\s[^\w]*)|([^\w]done![^\w]*)|([^\w]*100%[^\w]*)|([^\w]*-\sCOMPLETE\s\)[^\w]*)|([^\w]*-\sCOMPLETE\s-[^\w]*)|(\.(wmv|avi|mpeg|mpg|mkv|vob)$)|(\[.*\]\s\-\s\(\s.*F\s-\sCOMPLETE\s\)\s-\s\[.*\]) | writeini -n d-tool\d-tool.ini vars doublechecktime 10 | writeini -n d-tool\d-tool.ini vars maxdbsize 500 | writeini -n d-tool\d-tool.ini vars maxgrplen 50 | mkdir d-tool\inis | writeini d-tool\d-tool.ini vars inctimes 30;60;90 | dtlangs
  }
  echo $active $remove($read(d-tool\d-tool.mrc,2),;) loaded! 14- type /dt for setup - have fun
}
on 1:unload: {
  unload -rs d-tool/d-tool.dialogs.mrc | if ( %dtunloadall != 0 ) {
    unset %dt* | unset %dsstatus* | unset %affilcount* | unset %dsound* | unset %srcsite | unset %srcdir | unset %rls | unset %dessite* | unset %desdir | unset %srcdirdir | unset %desdirdir | unset %imdb* | unset %tvmaze* | unset %dtmaze* | unset %dinv* | unset %dtcb* | unset %cb* | unset %incrls | unset %desdir
    unset %tempsearch | unset %linenumber | unset %searchsite | unset %aff* | unset %site | unset %sektion* | unset %sektionnr | unset %[FRush]Dir | unset %sn | unset %desini | unset %secname* | unset %dateformat* | unset %reqn* | unset %[FRush* | unset %dbnc* | unset %bnctemp* | unset %lang | unset %langtags
    echo $active 14 All Variables of d-tool cleared. d-tool successfully unloaded
  }
  else echo $active 14 d-tool successfully unloaded 
}
on *:invite:*: {
  if ( $readini(d-tool\d-tool.ini,vars,invblc) == 1 ) {
    var %yy = 1 | while ( %yy <= $readini(d-tool\d-tool.ini,sites,count) ) {
      var %ys = $readini(d-tool\d-tool.ini,sites, %yy) | var %ivb = %ivb $readini(d-tool\inis\ $+ %ys $+ .ini, %ys,bot)
      inc %yy
    }
    if ( $nick !isin %ivb ) { describe $nick unasked invites are an invasion of privacy, so go fuck yourself | .timer 1 1 describe $chan don't invite unasked, kthx. i apologize if i forgot to add the botname first [d-tool inviteblocker] | .timer 1 2 part $chan }

  } 
}
;AUTOIDENT
on 1:notice:*einen anderen Nick*:?:{ 
  if ($readini(d-tool/identify.ini,$server,name)) && ($readini(d-tool/identify.ini,$server,password)) msg nickserv identify $decode($readini(d-tool/identify.ini,$server,password))
}
on 1:notice:*a different nick*:?:{
  if ($readini(d-tool/identify.ini,$server,name)) && ($readini(d-tool/identify.ini,$server,password)) msg nickserv identify $decode($readini(d-tool/identify.ini,$server,password))
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;ALIASES;;;;;;;;;;;;;;;switches trade: affil,recheck,sim ;;;;Stress Outlined White Star Hex Code:&#x2729;Decimal Code:&#10025;
alias trade {
  unset %dtcbdlonly | set %secname $readini(d-tool\sections.ini,name,%sektionnr) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) set %dtwindowcount $chr(60) $+ $chr(62) | grpname %rls | if ( %dttradetrigger == 0 ) goto notrade1 | var %srcini = %srcsite $+ .ini | set %desini %dessite $+ .ini | if ( %srcdirdir == $null ) set %srcdirdir x | if ( %desdirdir == $null ) set %desdirdir x
  if ( mp3 isin %secname ) || ( flac isin %secname ) || ( mvid isin %secname ) || ( abook isin %secname ) { if ( $readini(d-tool\inis\ $+ %desini,%dessite,mp3foreign) != 1 ) && ( $1 != recheck ) foreignchkm } | if ( %dttradetrigger == 0 ) goto notrade1 | if ( $1 != recheck ) uturncheck %dessite %desdir %desini | if ( $1 != recheck ) uturncheck %dessite %desdir %desini | set %dtpre $readini(d-tool\inis\ $+ %desini,%dessite,pretime)
  ;Precheck 
  if ( %dtpreoff == 1 ) || ( $readini(d-tool\inis\ $+ %desini,sections,secpre $+ %sektionnr) == 1 ) || ( $1 == affil ) || ( $1 == recheck ) || ( $1 == sim && $2 != p ) { goto nopre }  
  if ( %dtpre == 1 ) {
    var %b = 1 | while ( %b <= 60 ) { set %dtpreentry $eval(% $+ dtprenr $+ %b,2) | if ( $gettok($eval(%dtpreentry,2),1,32) isin %rls ) { unset %dtpre | goto nopre } | inc %b }
    if ( $readini(d-tool\d-tool.ini,vars,doublecheck) == 1 ) && ( $readini(d-tool\inis\ $+ %srcini,%srcsite,nopr) != 1 ) && ( $1 != recheck ) {
      .timer 1 $readini(d-tool\d-tool.ini,vars,doublechecktime) dtrecheck %rls %sektionnr %srcsite %srcdir %srcdirdir %dessite %desini %desdir %desdirdir 1 %dtwindownr $replace(%redirect,$chr(32),$chr(43))
      if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 7Rechecking14 %srcdir  %rls from %srcsite to %dessite in $readini(d-tool\d-tool.ini,vars,doublechecktime) $+ s., got no Pre.. } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp 7Rechecking14 %srcdir  %rls from %srcsite to %dessite in $readini(d-tool\d-tool.ini,vars,doublechecktime) $+ s., got no Pre.. } } | goto notrade1
    }
    set %dlighbfmsg 4 NoPre/Backfill/Language 14 %secname  %rls 14from4 %srcsite 14to3 %dessite | bfmsg | goto notrade1  
  }
  if ( %dtpre == 2 ) {
    var %b = 61 | while ( %b <= 120 ) { set %dtpreentry $eval(% $+ dtprenr $+ %b,2) | if ( $gettok($eval(%dtpreentry,2),1,32) isin %rls ) { unset %dtpre | goto nopre } | inc %b }
    if ( $readini(d-tool\d-tool.ini,vars,doublecheck) == 1 ) && ( $readini(d-tool\inis\ $+ %srcini,%srcsite,nopr) != 1 ) && ( $1 != recheck ) {
      .timer 1 $readini(d-tool\d-tool.ini,vars,doublechecktime) dtrecheck %rls %sektionnr %srcsite %srcdir %srcdirdir %dessite %desini %desdir %desdirdir 2 %dtwindownr $replace(%redirect,$chr(32),$chr(43))
      if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 7Rechecking14 %srcdir  %rls from %srcsite to %dessite in $readini(d-tool\d-tool.ini,vars,doublechecktime) $+ s., got no Pre.. } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp 7Rechecking14 %srcdir  %rls from %srcsite to %dessite in $readini(d-tool\d-tool.ini,vars,doublechecktime) $+ s., got no Pre.. } } | goto notrade1
    }
    set %dlighbfmsg 4 NoPre/Backfill/Language 14 %secname  %rls 14from4 %srcsite 14to3 %dessite | bfmsg | goto notrade1  
  }
  if ( %dtpre == 3 ) {
    var %b = 121 | while ( %b <= 180 ) { set %dtpreentry $eval(% $+ dtprenr $+ %b,2) | if ( $gettok($eval(%dtpreentry,2),1,32) isin %rls ) { unset %dtpre | goto nopre } | inc %b }
    if ( $readini(d-tool\d-tool.ini,vars,doublecheck) == 1 ) && ( $readini(d-tool\inis\ $+ %srcini,%srcsite,nopr) != 1 ) && ( $1 != recheck ) {
      .timer 1 $readini(d-tool\d-tool.ini,vars,doublechecktime) dtrecheck %rls %sektionnr %srcsite %srcdir %srcdirdir %dessite %desini %desdir %desdirdir 3 %dtwindownr $replace(%redirect,$chr(32),$chr(43))
      if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 7Rechecking14 %srcdir  %rls from %srcsite to %dessite in $readini(d-tool\d-tool.ini,vars,doublechecktime) $+ s., got no Pre.. } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp 7Rechecking14 %srcdir  %rls from %srcsite to %dessite in $readini(d-tool\d-tool.ini,vars,doublechecktime) $+ s., got no Pre.. } } | goto notrade1
    }
    set %dlighbfmsg 4 NoPre/Backfill/Language 14 %secname  %rls 14from4 %srcsite 14to3 %dessite | bfmsg | goto notrade1 
  }
  :nopre
  if ( $readini(d-tool\inis\ $+ %desini,sections,ats $+ %sektionnr) != 1 ) || ( %dttradetrigger == 0 ) goto notrade1 
  ; DEAKTIVIERT ZUM TEST;;lassen? if ( $1 == sim ) goto preruleend 
  ;Prerulecheck
  var %g = 1 | while ( %g <= 10 ) {
    if ( $gettok($eval(% $+ dtrules $+ %g,2),1,32) == %rls ) && ( $gettok($eval(% $+ dtrules $+ %g,3),2,32) == %secname ) && ( %dessite $+ + isin $gettok($eval(% $+ dtrules $+ %g,3),3,32) ) { 
      set %dtwindowcount $chr(10025) | set %prerace 1 | if ( %srcsite $+ - isin $gettok($eval(% $+ dtrules $+ %g,3),3,32) ) { set %dtcbdlonly %srcsite | set %dtwindowcount $chr(10025) $+ >> } | elseif ( %srcsite !isin $gettok($eval(% $+ dtrules $+ %g,3),3,32) ) { set %dtsrcchk 1 | rlzchk %srcsite %srcdir %srcini $1 | unset %dtsrcchk }
      if (%dtrecheckmsg) { if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp %dtrecheckmsg } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp %dtrecheckmsg } } | unset %dtrecheckmsg } | goto norules 
    }
    elseif ( $gettok($eval(% $+ dtrules $+ %g,2),1,32) == %rls ) && ( $gettok($eval(% $+ dtrules $+ %g,3),2,32) == %secname ) && ( %dessite $+ - isin $gettok($eval(% $+ dtrules $+ %g,2),3,32) ) { 
      if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { 
        if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) { if ( mp3 isin %srcdir || day isin %srcdir || flac isin %srcdir ) { goto notrade1 } }
        if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at  $+ $timestamp 15 $chr(10025) $+ 14PreruleSkip 15halted %secname 14 %rls @7 %srcsite to3 %dessite } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14PreruleSkip 15halted %secname 14 %rls @7 %srcsite to3 %dessite } 
      } 
      goto notrade1
    }
    inc %g 
  }
  :preruleend
  ;Rulecheck 
  if (%dtrecheckmsg) { if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp %dtrecheckmsg } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp %dtrecheckmsg } } | unset %dtrecheckmsg }
  if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) && ( $1 != affil ) && ( $readini(d-tool\d-tool.ini,vars,srcchkcbftp) == 1 ) { set %dtsrcchk 1 | rlzchk %srcsite %srcdir %srcini $1 | unset %dtsrcchk | if ( %dttradetrigger == 0 ) && (%dtcbdlonly) { set %dtwindowcount >> | unset %dttradetrigger } }
  unset %dtragestatus | rlzchk %dessite %desdir %desini $1 | if ( %dttradetrigger == 0 ) goto notrade1 | if ( $readini(d-tool\d-tool.ini,vars,whitelist) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,whitelist1) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,whitelistg1) == 1 ) goto notrade1 | ruleentry +
  :norules
  if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) && ( $1 == affil ) { set %dtcbdlonly %srcsite | set %dtwindowcount p>> }
  if ( $readini(d-tool\inis\ $+ %srcini,sections,date $+ %sektionnr) == 1 ) { 
    if ( today !isin %srcdirdir ) && ( daily !isin %srcdirdir ) && ( heute !isin %srcdirdir ) && ( month !isin %srcdirdir ) { 
      if ($readini(d-tool\inis\ $+ %srcini,sections,df $+ %sektionnr)) && ( $readini(d-tool\inis\ $+ %srcini,sections,df $+ %sektionnr) !isin %srcdir ) { set %srcdirdir %srcdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %srcini,sections,df $+ %sektionnr),$chr(32)) }
      elseif ( $remove($readini(d-tool\inis\ $+ %srcini,%srcsite,dateformat),$chr(32)) !isin %srcdir ) set %srcdirdir %srcdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %srcini,%srcsite,dateformat),$chr(32)) 
    } 
  }
  if ( $readini(d-tool\inis\ $+ %desini,sections,date $+ %sektionnr) == 1 ) {
    if ( today !isin %desdirdir ) && ( daily !isin %desdirdir ) && ( heute !isin %desdirdir ) && ( month !isin %srcdirdir ) { 
      if ($readini(d-tool\inis\ $+ %desini,sections,df $+ %sektionnr)) && ( $readini(d-tool\inis\ $+ %desini,sections,df $+ %sektionnr) !isin %desdir ) { set %desdirdir %desdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %desini,sections,df $+ %sektionnr),$chr(32)) }
      elseif ( $remove($readini(d-tool\inis\ $+ %desini,%dessite,dateformat),$chr(32)) !isin %desdir ) set %desdirdir %desdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %desini,%dessite,dateformat),$chr(32)) 
    } 
  }
  if ( $1 == sim && $2 == s ) || ( $1 == sim && $3 == s ) goto norace | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) && ( $readini(d-tool\inis\ $+ %srcini,%srcsite,nocbftp) != 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,nocbftp) != 1 ) {
    if (!%redirect) && ( $readini(d-tool\inis\ $+ %srcini,sections,date $+ %sektionnr) == 1 ) && ( $readini(d-tool\inis\ $+ %desini,sections,date $+ %sektionnr) != 1 ) && ( today !isin %desdirdir ) && ( daily !isin %desdirdir ) && ( heute !isin %desdirdir ) && ( month !isin %desdirdir ) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %srcsite / $+ %srcdirdir $+ / %rls %dessite / $+ %desdirdir $+ / %rls | var %cbftp = 7° | goto norace }
    elseif (!%redirect) && ( $readini(d-tool\inis\ $+ %desini,sections,date $+ %sektionnr) == 1 ) && ( today !isin %srcdirdir ) && ( daily !isin %srcdirdir ) && ( heute !isin %srcdirdir ) && ( month !isin %srcdirdir ) && ( today !isin %desdirdir ) && ( daily !isin %desdirdir ) && ( heute !isin %desdirdir ) && ( month !isin %desdirdir ) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %srcsite / $+ %srcdirdir $+ / %rls %dessite / $+ %desdirdir $+ / %rls | var %cbftp = 7° | goto norace }
    elseif (!%redirect) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) race $readini(d-tool\sections.ini,name,%sektionnr) %rls %srcsite $+ , $+ %dessite %dtcbdlonly | var %cbftp = 7* | goto norace }
    elseif (%redirect) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %srcsite / $+ %srcdirdir $+ / %rls %dessite / $+ %desdirdir $+ / %rls | var %cbftp = 7° | goto norace }
  }
  if (!%prerace) { if ( $readini(d-tool\d-tool.ini,vars,windowfix) == 1 ) { set %dtwindowcount %dtwindownr } | else windowcount } | if ( %dtnorace == 1 ) goto norace
  if ( dvd isin %srcdir ) || ( xbox360 isin %rls ) || ( ps3 isin %rls ) || ( ps4 isin %rls ) || ( 3D isincs %rls ) || ( game isin %rls ) || ( pc isin %rls ) || ( 1080p isin %rls ) || ( *XXX*264* iswm %rls ) || ( COMPLETE.BLURAY isin %rls ) || ( wii isin %srcdir ) { dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( $+ %dtwindowcount $+ , ' $+ %srcsite $+ ', '/ $+ %srcdirdir $+ / $+ $strip(%rls) $+ ', '', ' $+ %dessite $+ ', '/ $+ %desdirdir $+ / $+ $strip(%rls) $+ ', '',RS_DIRDES or RS_DIRSRC, '', '', '', '', ' $+ $readini(d-tool\d-tool.ini,vars,completeline) $+ ', $readini(d-tool\d-tool.ini,vars,attempt2) $+ , 0, 0,RS_SORTSIZE, 0, 2, 0); }
  else dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( $+ %dtwindowcount $+ , ' $+ %srcsite $+ ', '/ $+ %srcdirdir $+ / $+ $strip(%rls) $+ /', '', ' $+ %dessite $+ ', '/ $+ %desdirdir $+ / $+ $strip(%rls) $+ ', '',RS_DIRDES or RS_DIRSRC, '', '', '', '', ' $+ $readini(d-tool\d-tool.ini,vars,completeline) $+ ', $readini(d-tool\d-tool.ini,vars,attempt1) $+ , 0, 0,RS_SORTSIZE, 0, 2, 0);
  :norace
  if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at 15 %dtwindowcount $timestamp 15 $+ %secname 7 %srcsite >3 %dessite - $strip(%rls,ruc) 14- %srcdirdir > %desdirdir %redirect %dtragestatus %cbftp } } | else { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at 15 %dtwindowcount $timestamp  $+ %secname 7 %srcsite >3 %dessite - $strip(%rls,ruc) 14- %srcdirdir > %desdirdir %redirect %dtragestatus %cbftp } }
  if ( %dtincfill == 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,incget) == 1 ) writeracedb
  :notrade1
  unset %dttradetrigger | if (%redirect) set %sektionnr $readini(d-tool\d-tool.ini,vars,sectionsave) | unset %redirect | unset %dtragestatus | unset %dtentry | unset %dtnorace | unset %prerace | unset %dtsrcchk | unset %dtcbdlonly
}
alias wtrade {
  if ( $readini(d-tool\inis\ $+ %desini,sections,ats $+ %sektionnr) != 1 ) goto notrade2 | var %srcini = %srcsite $+ .ini | ruleentry +
  if ( $readini(d-tool\inis\ $+ %srcini,sections,date $+ %sektionnr) == 1 ) { 
    if ( today !isin %srcdirdir ) && ( daily !isin %srcdirdir ) && ( heute !isin %srcdirdir ) && ( month !isin %srcdirdir ) { 
      if ($readini(d-tool\inis\ $+ %srcini,sections,df $+ %sektionnr)) && ( $readini(d-tool\inis\ $+ %srcini,sections,df $+ %sektionnr) !isin %srcdir ) { set %srcdirdir %srcdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %srcini,sections,df $+ %sektionnr),$chr(32)) }
      elseif ( $remove($readini(d-tool\inis\ $+ %srcini,%srcsite,dateformat),$chr(32)) !isin %srcdir ) set %srcdirdir %srcdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %srcini,%srcsite,dateformat),$chr(32)) 
    } 
  }
  if ( $readini(d-tool\inis\ $+ %desini,sections,date $+ %sektionnr) == 1 ) {
    if ( today !isin %desdirdir ) && ( daily !isin %desdirdir ) && ( heute !isin %desdirdir ) && ( month !isin %srcdirdir ) {
      if ($readini(d-tool\inis\ $+ %desini,sections,df $+ %sektionnr)) && ( $readini(d-tool\inis\ $+ %desini,sections,df $+ %sektionnr) !isin %desdir ) { set %desdirdir %desdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %desini,sections,df $+ %sektionnr),$chr(32)) }
      elseif ( $remove($readini(d-tool\inis\ $+ %desini,%dessite,dateformat),$chr(32)) !isin %desdir ) set %desdirdir %desdirdir $+ / $+ $remove($readini(d-tool\inis\ $+ %desini,%dessite,dateformat),$chr(32)) 
    } 
  }
  if ( $1 == sim ) goto norushmark1
  if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) && ( $readini(d-tool\inis\ $+ %srcini,%srcsite,nocbftp) != 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,nocbftp) != 1 ) {
    if (!%redirect) && ( $readini(d-tool\inis\ $+ %srcini,sections,date $+ %sektionnr) == 1 ) && ( $readini(d-tool\inis\ $+ %desini,sections,date $+ %sektionnr) != 1 ) && ( today !isin %srcdirdir ) && ( daily !isin %srcdirdir ) && ( heute !isin %srcdirdir ) && ( month !isin %srcdirdir ) && ( today !isin %desdirdir ) && ( daily !isin %desdirdir ) && ( heute !isin %desdirdir ) && ( month !isin %desdirdir ) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %srcsite / $+ %srcdirdir $+ / %rls %dessite / $+ %desdirdir $+ / %rls | var %cbftp = 7° | goto norushmark1 }
    elseif (!%redirect) && ( $readini(d-tool\inis\ $+ %desini,sections,date $+ %sektionnr) == 1 ) && ( today !isin %srcdirdir ) && ( daily !isin %srcdirdir ) && ( heute !isin %srcdirdir ) && ( month !isin %srcdirdir ) && ( today !isin %desdirdir ) && ( daily !isin %desdirdir ) && ( heute !isin %desdirdir ) && ( month !isin %desdirdir ) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %srcsite / $+ %srcdirdir $+ / %rls %dessite / $+ %desdirdir $+ / %rls | var %cbftp = 7° | goto norushmark1 }
    elseif (!%redirect) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) race $readini(d-tool\sections.ini,name,%sektionnr) %rls %srcsite $+ , $+ %dessite %dtcbdlonly | var %cbftp 7* | goto norushmark1 }
    elseif (%redirect) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %srcsite / $+ %srcdirdir $+ / %rls %dessite / $+ %desdirdir $+ / %rls | var %cbftp 7° | goto norushmark1 }
  }
  if ( $readini(d-tool\d-tool.ini,vars,windowfix) == 1 ) { set %dtwindowcount %dtwindownr } | else windowcount | if ( %dtnorace == 1 ) goto norushmark1
  if ( dvd isin %srcdir ) || ( xbox360 isin %rls ) || ( ps3 isin %rls ) || ( 3D isincs %rls ) || ( game isin %rls ) || ( pc isin %rls ) || ( 1080p isin %srcdir ) || ( *XXX*264* iswm %rls ) || ( COMPLETE.BLURAY isin %rls ) || ( wii isin %srcdir ) { dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( $+ %dtwindowcount $+ , ' $+ %srcsite $+ ', '/ $+ %srcdirdir $+ / $+ $strip(%rls) $+ ', '', ' $+ %dessite $+ ', '/ $+ %desdirdir $+ / $+ $strip(%rls) $+ ', '',RS_DIRDES or RS_DIRSRC, '', '', '', '', ' $+ $readini(d-tool\d-tool.ini,vars,completeline) $+ ', $readini(d-tool\d-tool.ini,vars,attempt2) $+ , 0, 0,RS_SORTSIZE, 0, 2, 0); }
  else dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( $+ %dtwindowcount $+ , ' $+ %srcsite $+ ', '/ $+ %srcdirdir $+ / $+ $strip(%rls) $+ ', '', ' $+ %dessite $+ ', '/ $+ %desdirdir $+ / $+ $strip(%rls) $+ ', '',RS_DIRDES or RS_DIRSRC, '', '', '', '', ' $+ $readini(d-tool\d-tool.ini,vars,completeline) $+ ', $readini(d-tool\d-tool.ini,vars,attempt1) $+ , 0, 0,RS_SORTSIZE, 0, 2, 0);
  :norushmark1
  if ( $readini(d-tool\d-tool.ini,vars,whitelistg1) == 1 )  { if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) aline -p @d-tool_at 15 %dtwindowcount $timestamp 15 $+ %secname 7 %srcsite >3 %dessite  -  $strip(%rls,ruc) 15- 3gw - %dtentry 15- %srcdirdir > %desdirdir %redirect %cbftp } | else aline -p @d-tool_at 15 %dtwindowcount $timestamp  $+ %secname 7 %srcsite >3 %dessite  -  $strip(%rls,ruc) 15- 3gw - %dtentry 14- %srcdirdir > %desdirdir %redirect %dtragestatus %cbftp } }
  elseif ( $readini(d-tool\d-tool.ini,vars,whitelist) == 1 )  { if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) aline -p @d-tool_at 15 %dtwindowcount $timestamp 15 $+ %secname 7 %srcsite >3 %dessite  -  $strip(%rls,ruc) 15- 3w+ - %dtentry 15- %srcdirdir > %desdirdir %redirect %cbftp } | else aline -p @d-tool_at 15 %dtwindowcount $timestamp  $+ %secname 7 %srcsite >3 %dessite  -  $strip(%rls,ruc) 15- 3w+ - %dtentry 14- %srcdirdir > %desdirdir %redirect %dtragestatus %cbftp } }
  else { if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | if ( mp3 isin %desdir ) || ( 0day isin %desdir ) || ( 0-day isin %desdir ) || ( flac isin %desdir ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) == 1 ) aline -p @d-tool_at 15 %dtwindowcount $timestamp 15 $+ %secname 7 %srcsite >3 %dessite - $strip(%rls,ruc) 15- 3w14 - %dtentry - %srcdirdir > %desdirdir %redirect %cbftp } | else aline -p @d-tool_at 15 %dtwindowcount $timestamp  $+ %secname 7 %srcsite >3 %dessite - $strip(%rls,ruc) 15- 3w14 - %dtentry - %srcdirdir > %desdirdir %redirect %dtragestatus %cbftp } }
  if ( %dtincfill == 1 ) && ( $readini(d-tool\inis\ $+ %desini,%dessite,incget) == 1 ) writeracedb
  if (%redirect) set %sektionnr $readini(d-tool\d-tool.ini,vars,sectionsave) | unset %redirect | unset %dtragestatus | unset %dtentry | unset %dtnorace | unset %prerace | unset %dtsrcchk | unset %dtcbdlonly
  :notrade2
}
alias rlzchk {
  if ( %dtsrcchk == 1 ) unset %dtcbdlonly | affchk $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) { set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 }  
  ecp0chk $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) { set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 } | whitechk $1 $2 $3 | if ( $readini(d-tool\d-tool.ini,vars,whitelist) == 1 ) { if ( %dtsrcchk != 1 ) && ( %prerace != 1 ) wtrade $4 | if ( %dtsrcchk == 1 ) ruleentry + s | else ruleentry + | goto notrade0 } 
  if ( mp3 !isin %srcdir ) && ( flac !isin %srcdir ) && ( mvid !isin %srcdir ) && ( nsw !isin %srcdir ) && ( xbox !isin %srcdir ) { if ( $readini(d-tool\inis\ $+ $3,sections,atf $+ %sektionnr) != 1 ) { foreignchk $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) { if (!%dtcbdlonly) set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 } } }
  if ( $readini(d-tool\inis\ $+ $3,$1,nowankers) != 1 ) && ( %dtsrcchk != 1 ) && ( $readini(d-tool\inis\ $+ $3,sections,atw $+ %sektionnr) != 1 ) { wankerchk $1 $2 $3 | if ( %dttradetrigger == 0 ) { ruleentry - | goto notrade0 } } | whitechkg1 | if ( $readini(d-tool\d-tool.ini,vars,whitelistg1) == 1 ) { if ( %dtsrcchk != 1 ) && ( %prerace != 1 )  wtrade $4 | goto notrade0 } | if ( %dtsrcchk != 1 ) { gecpchk | if ( %dttradetrigger == 0 ) { ruleentry - | goto notrade0 } } 
  if ($readini(d-tool\inis\ $+ $3,sections,y $+ %sektionnr)) { if ( 19 isin %rls ) || ( 20 isin %rls ) { yearcheck $1 $2 $3 $remove($replace(%rls,.,$chr(32),-,$chr(32)),720p,1080p) } } | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) && (!%dtcbdlonly) { set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 } | ecp2chk $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) && (!%dtcbdlonly) { set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 }
  if ( $regex(%rls,.S[0-9][0-9]E[0-9][0-9]) == 1 || $regex(%rls,.S[0-9][0-9]) == 1 || $regex(%rls,.E[0-9][0-9]) == 1 ) {  
    if ( COMPLETE.BLURAY !isin %rls ) && ($readini(d-tool\inis\ $+ $3,$1,tvengonly)) { tvmazechk $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) { if (!%dtcbdlonly) set %dtcbdlonly $1 | ruleentry - s } | else { tvragecheckmsg | unset %dtentry | ruleentry - | goto notrade0 } } } 
  }
  if ( xvid isin %secname) || ( dvdr isin %secname ) || ( x26 isin %secname ) || ( h26 isin %secname ) || ( hd isin %secname ) || ( Bluray isin %secname ) || ( AVC isin %secname ) || ( HEVC isin %secname ) {
    if ( .DOKU. !isin %rls ) && ( .DOCU. !isin %rls ) && ( MDVDR !isin %srcdir ) && ( .dtv. !isin %rls ) && ( .TS !isin %rls ) && ( .TC. !isin %rls ) && ( .LD. !isin %rls ) && ( .Telecine !isin %rls ) && ( .XXX !isin %rls ) && ( .MD. !isin %rls ) && ( screener. !isin %rls ) && ( .Telesync. !isin %rls ) && ( .Mic. !isin %rls ) && ( .CAM. !isin %rls ) {
      if ( $readini(d-tool\d-tool.ini,vars,imdbs) == 1 ) { imdbcheck $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) { if (!%dtcbdlonly) set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 } }
    } 
  }
  whitechk1 $1 $2 $3 | if ( $readini(d-tool\d-tool.ini,vars,whitelist1) == 1 ) { if ( %dtsrcchk != 1 ) && ( %prerace != 1 )  wtrade $4 | goto notrade0 } | ecp1chk $1 $2 $3 | if ( %dttradetrigger == 0 ) { if ( %dtsrcchk == 1 ) { if (!%dtcbdlonly) set %dtcbdlonly $1 | ruleentry - s } | else ruleentry - | goto notrade0 }
  :notrade0
}
alias dtrecheck {
  if ( $10 == 1 ) { var %b1 = 1 | var %b2 = 60 } | if ( $10 == 2 ) { var %b1 = 61 | var %b2 = 120 } | if ( $10 == 3 ) { var %b1 = 121 | var %b2 = 180 }
  var %aa = %b1 | while ( %aa <= %b2 ) {
    set %dtpreentry $gettok($eval(% $+ dtprenr $+ %aa,3),1,32)
    if ( $gettok($eval(%dtpreentry,2),1,32) isin $1 ) {
      set %rls $1 | set %sektionnr $2 | set %srcsite $3 | set %srcdir $4 | set %srcdirdir $5 | set %dessite $6 | set %desini $7 | set %desdir $8 | set %desdirdir $9 | set %dtpre $10 | set %dtwindownr $11 | set %redirect $replace($12,$chr(43),$chr(32))
      set %dtrecheckmsg 3 recheck-success:15 %srcdir 14 %srcsite > %dessite %rls | trade recheck | goto recheckend
    } 
    inc %aa
  }
  set %secname $readini(d-tool\sections.ini,name,$2) | set %dlighbfmsg 7(R)4 NoPre/Backfill/Language 14 %secname $1 from7 $3 14to3 $6 | bfmsg
  :recheckend
}
alias yearcheck { 
  var %year = $readini(d-tool\inis\ $+ $3,sections,y $+ %sektionnr)
  var %w = 4 | while ( %w <= 24 ) { var %x = $replace($eval($ $+ %w,2),x,0) | if ( 1920p !isin %rls ) { if ( $regex(%x,20[0-9][0-9]) == 1 ) || ( $regex(%x,19[0-9][0-9]) == 1 ) var %rlsyear = %x } | inc %w }  
  if ( %rlsyear < %year ) { set %dttradetrigger 0 | set %dtentry %year | if ( %dtsrcchk != 1 ) yearcheckmsg }
  elseif ( 199x isin %rls && %year > 1999 ) { set %dttradetrigger 0 | set %dtentry %year | if ( %dtsrcchk != 1 ) yearcheckmsg }
}
alias foreignchkm { var %fc = $read(d-tool\foreign-mp3.db,1) | var %fd = 1 | while ( %fd <= $numtok(%fc,32) ) { if ( $chr(45) $+ $gettok(%fc,%fd,32) $+ $chr(45) isin %rls ) var %foreignstatus = 0 | inc %fd } | if ( %foreignstatus == 0 ) { foreignchkmmsg | set %dttradetrigger 0 } }
alias gecpchk {
  var %i = 1 | while ( %i <= $readini(d-tool\d-tool.ini,vars,gblistentry) ) {
    if ( ! isin $readini(d-tool\d-tool.ini,vars,ecp $+ %i) ) { if ( $remove($readini(d-tool\d-tool.ini,vars,ecp $+ %i),!) iswmcs %rls ) { set %dtentry $readini(d-tool\d-tool.ini,vars,ecp $+ %i) | globalchkmsg | set %dttradetrigger 0 | goto gecpchkend } }
    if ( ~ isin $readini(d-tool\d-tool.ini,vars,ecp $+ %i) ) && ( $regex(%rls,$remove($readini(d-tool\d-tool.ini,vars,ecp $+ %i),~)) == 1 ) { set %dtentry $readini(d-tool\d-tool.ini,vars,ecp $+ %i) | globalchkmsg | set %dttradetrigger 0 | goto gecpchkend }
    if ( $readini(d-tool\d-tool.ini,vars,ecp $+ %i) iswm %rls ) { set %dtentry $readini(d-tool\d-tool.ini,vars,ecp $+ %i) | globalchkmsg | set %dttradetrigger 0 | goto gecpchkend } 
    inc %i 
  }
  :gecpchkend
}
alias ecp1chk {
  var %i = 1 | while ( %i <= $readini(d-tool\inis\ $+ $3,$1,blistentry) ) {
    var %ecpchkitem = $readini(d-tool\inis\ $+ $3,black,%i)
    if ( + !isin %ecpchkitem ) {
      ; wildcard.sec*rls isincs.sec*rls
      if ( %ecpchkitem iswm $2 $+ %rls ) || ( $gettok(%ecpchkitem,2,42) isincs %rls ) { if ( $gettok(%ecpchkitem,1,42) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecpchkitem | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end } } 
      ; isincs.rls wildcard.rls regex.rls
      if ( %ecpchkitem isincs %rls ) || ( %ecpchkitem iswm %rls ) || ( $regex(%rls,$remove(%ecpchkitem,~)) == 1 && $chr(126) isin %ecpchkitem ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecpchkitem | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
      ; sectionsskip
      if ( ^ isin %ecpchkitem ) && ( $remove(%ecpchkitem,^) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $2 | if ( %dtsrcchk != 1 ) secchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
      ; sec*entry|.. + SPORT
      if ( $chr(124) isin %ecpchkitem ) && ( $gettok(%ecpchkitem,1,42) == $2 ) {
        var %p = 1 | while ( %p <= $numtok($gettok(%ecpchkitem,2,42),124) ) {
          if ( $gettok($gettok(%ecpchkitem,2,42),%p,124) isincs %rls ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ $gettok($gettok(%ecpchkitem,2,42),%p,124) $+ $chr(124) | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
          if ( $gettok($gettok(%ecpchkitem,2,42),%p,124) == SPORT ) { 
            var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
              if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),1) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ SPORT $+ $chr(124) | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
              inc %rd
            }
          }
          inc %p 
        }  
      }
      ; sec'regex|regex
      if ( $chr(176) isin %ecpchkitem ) && ( $chr(126) isin %ecpchkitem ) && ( $remove($gettok(%ecpchkitem,1,39),~) == $2 ) {
        var %p = 1 | while ( %p <= $numtok($gettok(%ecpchkitem,2,39),176) ) {
          var %tz = $gettok($gettok(%ecpchkitem,2,39),%p,176) | if ( $regex(%rls,%tz) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(176) $+ %tz $+ $chr(176) | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
          inc %p
        }
      }
      ; sec'regex
      elseif ( $chr(126) isin %ecpchkitem ) && ( $remove($gettok(%ecpchkitem,1,39),~) == $2 ) {
        var %tz = $gettok(%ecpchkitem,2,39) | if ( $regex(%rls,%tz) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %tz | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
      }
      ; entry|..
      if ( $chr(124) isin %ecpchkitem ) && ( $chr(42) !isin %ecpchkitem ) && ( $chr(39) !isin %ecpchkitem ) {
        var %p = 1 | while ( %p <= $numtok(%ecpchkitem,124) ) {
          if ( $gettok(%ecpchkitem,%p,124) isincs %rls ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ $gettok(%ecpchkitem,%p,124) $+ $chr(124) | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
          inc %p 
        }
      }
      ; sec'sport
      if ( $gettok(%ecpchkitem,2,42) == SPORT ) && ( $gettok(%ecpchkitem,1,42) == $2 ) {
        var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
          if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),1) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecpchkitem | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
          inc %rd
        }
      }
      ; sport
      if ( %ecpchkitem == SPORT ) {
        var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
          if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),1) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecpchkitem | if ( %dtsrcchk != 1 ) ecpchkmsg } | set %dttradetrigger 0 | goto ecpchk1end }
          inc %rd
        }
      }
    } 
    inc %i 
  }
  :ecpchk1end
}
alias ecp2chk { 
  var %i = 1 | while ( %i <= $readini(d-tool\inis\ $+ $3,$1,blistentry) ) { 
    var %ecp2chkitem = $readini(d-tool\inis\ $+ $3,black,%i)
    if ( + isin %ecp2chkitem ) { 
      ; wildcard.sec*rls isincs.sec*rls
      if ( $remove(%ecp2chkitem,+) iswm $2 $+ %rls ) || ( $gettok(%ecp2chkitem,2,42) isincs %rls ) { if ( $gettok($remove(%ecp2chkitem,+),1,42) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp2chkitem | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end } }  
      ; isincs.rls wildcard.rls regex.rls
      if ( $remove(%ecp2chkitem,+) isincs %rls ) || ( $remove(%ecp2chkitem,+) iswm %rls ) || ( $regex(%rls,$remove(%ecp2chkitem,~,+)) == 1 && $chr(126) isin %ecp2chkitem ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp2chkitem | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end } 
      ; sectionsskip
      if ( ^ isin $remove(%ecp2chkitem,+) ) && ( $remove(%ecp2chkitem,^,+) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $2 | if ( %dtsrcchk != 1 ) secchkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }      
      ; sec*entry|.. + SPORT
      if ( $chr(124) isin %ecp2chkitem ) && ( $remove($gettok(%ecp2chkitem,1,42),+) == $2 ) {
        var %p = 1 | while ( %p <= $numtok($gettok(%ecp2chkitem,2,42),124) ) {
          if ( $gettok($gettok(%ecp2chkitem,2,42),%p,124) isincs %rls ) && ( $remove($gettok(%ecp2chkitem,1,42),+) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ $gettok($gettok(%ecp2chkitem,2,42),%p,124) $+ $chr(124) | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
          if ( $gettok($gettok(%ecp2chkitem,2,42),%p,124) == SPORT ) { 
            var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
              if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),1) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ SPORT $+ $chr(124) | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
              inc %rd
            }
          }
          inc %p 
        }
      }
      ; sec'regex°regex
      if ( $chr(176) isin %ecp2chkitem ) && ( $chr(126) isin %ecp2chkitem ) && ( $remove($gettok(%ecp2chkitem,1,39),~,+) == $2 ) {
        var %p = 1 | while ( %p <= $numtok($gettok(%ecp2chkitem,2,39),176) ) {
          var %tz = $gettok($gettok(%ecp2chkitem,2,39),%p,176) | if ( $regex(%rls,%tz) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(176) $+ %tz $+ $chr(176) | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
          inc %p
        }
      }
      ; sec'regex
      elseif ( $chr(126) isin %ecp2chkitem ) && ( $remove($gettok(%ecp2chkitem,1,39),~,+) == $2 ) {
        var %tz = $gettok(%ecp2chkitem,2,39) | if ( $regex(%rls,%tz) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %tz | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
      }
      ; entry|..
      if ( $chr(124) isin %ecp2chkitem ) && ( $chr(42) !isin %ecp2chkitem ) && ( $chr(39) !isin %ecp2chkitem ) {
        var %p = 1 | while ( %p <= $numtok(%ecp2chkitem,124) ) {
          if ( $remove($gettok(%ecp2chkitem,%p,124),+) isincs %rls ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ $remove($gettok(%ecp2chkitem,%p,124),+) $+ $chr(124) | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
          inc %p 
        }
      }
      ; sec*sport
      if ( $gettok(%ecp2chkitem,2,42) == SPORT ) && ( $remove($gettok(%ecp2chkitem,1,42),+) == $2 ) {
        var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
          if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32)) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp2chkitem | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
          inc %rd
        }
      }
      ; sport
      if ( $remove(%ecp2chkitem,+) == SPORT ) {
        var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
          if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),1) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp2chkitem | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
          inc %rd
        }
      }
      ; sec'!scripted
      if ( !SCRIPTED isincs $gettok(%ecp2chkitem,2,42) ) && ( $remove($gettok(%ecp2chkitem,1,42),+) == $2 ) && ( TV isin %secname ) && ( !TV !isin %secname ) {
        if (!$gettok($readini(d-tool/tvmaze.db,$replace(%dtmazeitem,$chr(32),$chr(46)),data),1,32)) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $gettok(%ecp2chkitem,1,42) $+ * !SCRIPTED $+ .notfound(imdb) | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end } | elseif ( Scripted !isin $gettok($readini(d-tool/tvmaze.db,$replace(%dtmazeitem,$chr(32),$chr(46)),data),1,32) ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp2chkitem $+ .not(imdb) | if ( %dtsrcchk != 1 ) ecp2chkmsg } | set %dttradetrigger 0 | goto ecp2chk1end }
      }
    }
    inc %i 
  }
  :ecp2chk1end
}
alias ecp0chk { 
  var %i = 1 | while ( %i <= $readini(d-tool\inis\ $+ $3,$1,blistentry) ) { 
    var %ecp0chkitem = $readini(d-tool\inis\ $+ $3,black,%i)
    if ( ! isin %ecp0chkitem ) {
      ; !sec*entry 
      if ( $gettok(%ecp0chkitem,2,42) isin %rls ) && ( $gettok($remove(%ecp0chkitem,!),1,42) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp0chkitem | ecp0chkmsg } | set %dttradetrigger 0 | goto ecp0chkend } 
      ; !entry & !*entry*entry
      if ( $remove(%ecp0chkitem,!) isin %rls || $remove(%ecp0chkitem,!) iswm %rls ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %ecp0chkitem | ecp0chkmsg } | set %dttradetrigger 0 | goto ecp0chkend } 
      ; !sec*entry|... + SPORT
      if ( $chr(124) isin %ecp0chkitem ) && ( $remove($gettok(%ecp0chkitem,1,42),!) == $2 ) {
        var %p = 1 | while ( %p <= $numtok($gettok(%ecp0chkitem,2,42),124) ) {
          if ( $gettok($gettok(%ecp0chkitem,2,42),%p,124) isincs %rls ) && ( $remove($gettok(%ecp0chkitem,1,42),!) == $2 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ $gettok($gettok(%ecp0chkitem,2,42),%p,124) $+ $chr(124) | if ( %dtsrcchk != 1 ) ecp0chkmsg } | set %dttradetrigger 0 | goto ecp0chkend }
          if ( $gettok($gettok(%ecp0chkitem,2,42),%p,124) == SPORT )   { 
            var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
              if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $left($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),1) == ~ && $regex(%rls,$remove($gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32),~)) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ SPORT $+ $chr(124) | if ( %dtsrcchk != 1 ) ecp0chkmsg } | set %dttradetrigger 0 | goto ecp0chkend }
              inc %rd
            }
          }
          inc %p 
        }
      }
      if ( $chr(124) isin %ecp0chkitem ) && ( $chr(42) !isin %ecp0chkitem ) && ( $chr(39) !isin %ecp0chkitem ) {
        var %p = 1 | while ( %p <= $numtok(%ecp0chkitem,124) ) {
          if ( $remove($gettok(%ecp0chkitem,%p,124),+) isincs %rls ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry $chr(124) $+ $remove($gettok(%ecp0chkitem,%p,124),+) $+ $chr(124) | if ( %dtsrcchk != 1 ) ecp0chkmsg } | set %dttradetrigger 0 | goto ecp0chkend }
          inc %p 
        }
      }
    }
    inc %i 
  }
  :ecp0chkend
}
alias whitechk1 {
  writeini -n d-tool\d-tool.ini vars whitelist1 0 | var %srls1 = $2 $+ %rls
  var %i = 1 | while ( %i <= $readini(d-tool\inis\ $+ $3,$1,wlistentry) ) {
    var %whiteitem2 = $readini(d-tool\inis\ $+ $3,white,w $+ %i)
    if ( + !isin %whiteitem2 ) {
      ; entry
      if ( %whiteitem2 isincs %rls ) || ( %whiteitem2 $+ * iswm %srls1 && $gettok(%whiteitem2,1,42) == $2 ) { set %dtentry %whiteitem2 | writeini d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
      ; sec'entry|...
      if ( $chr(124) isin %whiteitem2 ) && ( $gettok(%whiteitem2,1,42) == $2 ) {
        var %m = 1 | while ( %m <= $numtok($gettok(%whiteitem2,2,42),124) ) {
          ;regex
          if ( $chr(126) isin %whiteitem2 ) && ( $chr(176) isin %whiteitem2 ) {
            var %tz = $gettok($gettok(%whiteitem1,2,39),%m,176) | if ( $regex(%rls,%tz) == 1 ) { set %dtentry $chr(176) $+ %whiteitem2 $+ $chr(176) | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
          }
          ;regexend
          if ( %dtgrpn == $gettok($gettok(%whiteitem2,2,42),%m,124) ) { set %dtentry $chr(124) $+ %dtgrpn $+ $chr(124) | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
          if ( $gettok($gettok(%whiteitem2,2,42),%m,124) isincs %rls ) { set %dtentry $chr(124) $+ $gettok($gettok(%whiteitem2,2,42),%m,124) $+ $chr(124) | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
          inc %m
        }
      }
      ; sec'regex°regex
      ; if ( $chr(176) isin %whiteitem2 ) && ( $chr(126) isin %whiteitem2 ) && ( $remove($gettok(%whiteitem2,1,39),$chr(126)) == $2 ) {
      ;   var %m = 1 | while ( %m <= $numtok($gettok(%whiteitem2,2,39),176) ) {
      ;     var %tz = $gettok($gettok(%whiteitem2,2,39),%m,176) | if ( $regex(%rls,%tz) == 1 ) { set %dtentry $chr(176) $+ %tz $+ $chr(176) | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
      ;     inc %m
      ;   }
      ; }
      ; entry|..
      if ( $chr(124) isin %whiteitem2 ) && ( $chr(42) !isin %whiteitem2 ) && ( $chr(39) !isin %whiteitem2 ) {
        var %m = 1 | while ( %m <= $numtok(%whiteitem2,124) ) {
          if ( $gettok(%whiteitem2,%m,124) isin %rls ) { set %dtentry $chr(124) $+ $gettok(%whiteitem2,%m,124) $+ $chr(124) | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
          inc %m
        }
      }
      ; sec'regex
      if ( $chr(126) isin %whiteitem2 ) && ( $remove($gettok(%whiteitem2,1,39),$chr(126)) == $2 ) {
        var %tz = $gettok(%whiteitem2,2,39) | if ( $regex(%rls,%tz) == 1 ) { set %dtentry %whiteitem2 | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
      }
      ; sec'sport
      if ( $gettok(%whiteitem2,2,42) == SPORT ) && ( $gettok(%whiteitem2,1,42) == $2 ) && ( TV isin %secname ) && ( !TV !isin %secname ) {
        var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
          if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $regex(%rls,$readini(d-tool\d-tool.ini,vars,sport)) >= 1 ) { set %dtentry %whiteitem2 | writeini -n d-tool\d-tool.ini vars whitelist1 1 | goto whitechk1end }
          inc %rd
        }
      }
    }
    inc %i
  }
  :whitechk1end
}
alias whitechk {
  writeini -n d-tool\d-tool.ini vars whitelist 0 | var %srls1 = $2 $+ %rls
  var %i = 1
  while ( %i <= $readini(d-tool\inis\ $+ $3,$1,wlistentry) ) {
    var %whiteitem1 = $readini(d-tool\inis\ $+ $3,white,w $+ %i)
    if ( + isin %whiteitem1 ) { 
      ; entry
      if ( $remove(%whiteitem1,+) isincs %rls ) || ( $remove(%whiteitem1,+) iswm %srls1 && $gettok($remove(%whiteitem1,+),1,42) == $2 ) { set %dtentry %whiteitem1 | writeini d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
      ; sec'entry|..
      if ( $chr(124) isin %whiteitem1 ) && ( $remove($gettok(%whiteitem1,1,42),+) == $2 ) {
        var %m = 1 | while ( %m <= $numtok($gettok(%whiteitem1,2,42),124) ) {
          ;regex
          if ( $chr(126) isin %whiteitem1 ) && ( $chr(176) isin %whiteitem1 ) {
            var %tz = $gettok($gettok(%whiteitem1,2,39),%m,176) | if ( $regex(%rls,%tz) == 1 ) { set %dtentry $chr(176) $+ %whiteitem1 $+ $chr(176) | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
          }
          ;regexend
          if ( %dtgrpn == $gettok(%whiteitem1,%m,124) ) { set %dtentry $chr(124) $+ %dtgrpn $+ $chr(124) | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
          if ( $gettok($gettok(%whiteitem1,2,42),%m,124) isincs %rls ) { set %dtentry $chr(124) $+ $gettok($gettok(%whiteitem1,2,42),%m,124) $+ $chr(124) | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
          inc %m
        }
      }
      ; sec'regex
      elseif ( $chr(126) isin %whiteitem1 ) && ( $remove($gettok(%whiteitem1,1,39),$chr(126),+) == $2 ) {
        var %tz = $gettok(%whiteitem1,2,39) | if ( $regex(%rls,%tz) == 1 ) { set %dtentry %whiteitem1 | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
      }
      ; entry|..
      if ( $chr(124) isin %whiteitem1 ) && ( $chr(42) !isin %whiteitem1 ) {
        var %m = 1 | while ( %m <= $numtok(%whiteitem1,124) ) {
          if ( $gettok(%whiteitem1,%m,124) isin %rls ) { set %dtentry $chr(124) $+ $gettok(%whiteitem1,%m,124) $+ $chr(124) | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
          inc %m
        }
      }
      if ( $chr(126) isin %whiteitem1 ) && ( * !isin %whiteitem1 ) {
        var %tz = $remove(%whiteitem1,$chr(126),+) | if ( $regex(%rls,%tz) == 1 ) { set %dtentry %whiteitem1 | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
      }
      ;sec'sport
      if ( $gettok(%whiteitem1,2,42) == SPORT ) && ( $remove($gettok(%whiteitem1,1,42),+) == $2 ) && ( TV isin %secname ) && ( !TV !isin %secname ) {
        var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
          if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $regex(%rls,$readini(d-tool\d-tool.ini,vars,sport)) >= 1 ) { set %dtentry %whiteitem1 | writeini -n d-tool\d-tool.ini vars whitelist 1 | goto whitechkend }
          inc %rd
        }
      }
    }  
    inc %i
  }
  :whitechkend
}
alias whitechkg1 {
  writeini -n d-tool\d-tool.ini vars whitelistg1 0
  var %i = 1
  while ( %i <= $readini(d-tool\d-tool.ini,vars,gwlistentry) ) {
    if ( $chr(126) !isin $readini(d-tool\d-tool.ini,vars,gw $+ %i) ) && ( $readini(d-tool\d-tool.ini,vars,gw $+ %i) == %dtgrpn ) { set %dtentry $readini(d-tool\d-tool.ini,vars,gw $+ %i) | writeini -n d-tool\d-tool.ini vars whitelistg1 1 | goto whitechkg1end }
    if ( $chr(126) isin $readini(d-tool\d-tool.ini,vars,gw $+ %i) ) && ( $regex(%rls,$remove($readini(d-tool\d-tool.ini,vars,gw $+ %i),$chr(126))) == 1 ) { set %dtentry $readini(d-tool\d-tool.ini,vars,gw $+ %i) | writeini -n d-tool\d-tool.ini vars whitelistg1 1 | goto whitechkg1end }
    inc %i
  }
  :whitechkg1end
}
alias affchk {
  var %i = 1 | var %aentrys = $readini(d-tool\d-tool.ini,vars,aentrys)
  while ( %i <= %aentrys ) {
    var %affchkitem = $readini(d-tool\inis\ $+ $3,affils,a $+ %i)
    if ( $remove(%affchkitem,-) == %dtgrpn ) && ( - isin %affchkitem ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %affchkitem | if ( %dtsrcchk != 1 ) affchkmsg } | set %dttradetrigger 0 | goto affchkend }
    elseif ( %affchkitem isin %rls ) {
    if ( $right($remove(%rls,%affchkitem),1) == - ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { set %dtentry %affchkitem | banchkmsg } | set %dttradetrigger 0 | goto affchkend } } 
    if ( *|* iswm %affchkitem ) {
      var %m = 1 | while ( %m <= $readini(d-tool\sections.ini,name,count) ) {
        if ( %dtgrpn == $gettok(%affchkitem,%m,124) ) { set %dtentry $chr(124) $+ %dtgrpn $+ $chr(124) | banchkmsg | set %dttradetrigger 0 | goto affchkend }
        inc %m
      }
    }
    inc %i
  }
  :affchkend
}
alias foreignchk {
  if ( ENG. isincs %secname ) {  
    var %we = 1 | while ( %we <= $lines(d-tool\languages.db) ) {
      var %lang = $gettok($read(d-tool\languages.db,%we),1,32) | var %langtags = $gettok($read(d-tool\languages.db,%we),2-,32)
      var %tz = 1 | while ( %tz <= $numtok(%langtags,44) ) {
        if ( %lang $+ $chr(46) isincs %secname ) { if ( $chr(46) $+ $gettok(%langtags,%tz,44) $+ $chr(46) isincs %rls ) || ( $chr(46) $+ $gettok(%langtags,%tz,44) $+ $chr(45) isincs %rls ) || ( $chr(95) $+ $gettok(%langtags,%tz,44) $+ $chr(95) isincs %rls ) || ( $chr(95) $+ $gettok(%langtags,%tz,44) $+ $chr(45) isincs %rls ) goto engchkgo } 
        if ( %lang $+ $chr(46) !isincs %secname ) {
          if ( $chr(46) $+ $gettok(%langtags,%tz,44) $+ $chr(46) isin %rls ) || ( $chr(46) $+ $gettok(%langtags,%tz,44) $+ $chr(45) isin %rls ) || ( $chr(95) $+ $gettok(%langtags,%tz,44) $+ $chr(95) isin %rls ) || ( $chr(95) $+ $gettok(%langtags,%tz,44) $+ $chr(45) isin %rls ) { var %ftemp = 1 | set %dtwank not.ENG( $+ $gettok(%langtags,%tz,44) $+ ) }
          if ( %tz == $numtok(%langtags,44) ) && ( %ftemp == 1 ) goto foreignstop
        }
        inc %tz
      }
      var %wd = $read(d-tool\foreign.db,1) | var %we = 1 | while ( %we <= $numtok(%wd,32) ) {
        if ( $gettok(%wd,%we,32) !isincs %langtags ) {
          if ( $chr(46) $+ $gettok(%wd,%we,32) $+ $chr(46) isincs %rls ) || ( $chr(46) $+ $gettok(%wd,%we,32) $+ $chr(45) isincs %rls ) || ( $chr(95) $+ $gettok(%wd,%we,32) $+ $chr(95) isincs %rls ) || ( $chr(95) $+ $gettok(%wd,%we,32) $+ $chr(45) isincs %rls ) { set %dtwank not.ENG( $+ $gettok(%wd,%we,32) $+ ) | goto foreignstop }
        }
        inc %we 
      }
      inc %we
    }
    :engchkgo
    ; LANG/GENRE IMDB
    if ( Sport !isin %secname ) {
      if ( $regex(%rls,.S[0-9][0-9]E[0-9][0-9]) == 1 || $regex(%rls,.S[0-9][0-9]) == 1 || $regex(%rls,.E[0-9][0-9]) == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,sdtv-us) != 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,tv-us) != 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,sdtv-uk) != 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,tv-uk) != 1 ) goto foreigngo 
      if ( $readini(d-tool\inis\ $+ $3,$1,imdbeng) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,imdbdocu) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,imdbcom) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,imdbus) == 1 )  {
        if ( xvid isin %rls ) || ( dvdr- isin %rls ) || ( dvdr. isin %rls ) || ( .x26 isin %rls ) || ( .h26 isin %rls ) || ( .HEVC isin %rls )  || ( .AVC isin %rls ) || ( COMPLETE.BLURAY isincs %rls ) || ( COMPLETE.UHD.BLURAY isincs %rls ) {
          var %wr = 1 | while ( %wr <= 10 ) { 
            if ( $gettok($eval(% $+ dtimdbr $+ %wr,2),1,32) == %rls ) { var %imdbtmp = 1
              if ( $readini(d-tool\inis\ $+ $3,$1,imdbeng) == 1 ) { if ( $gettok($eval(% $+ dtimdbr $+ %wr,2),4,32) != English ) && ( $chr(32) $+ English $+ $chr(44) !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),4,32) ) { set %dtwank not.eng.lang(iMDB) | goto foreignstop } }
              if ( $readini(d-tool\inis\ $+ $3,$1,imdbus) == 1 ) { if ( $gettok($eval(% $+ dtimdbr $+ %wr,2),5,32) != UnitedStates ) && ( UnitedStates $+ $chr(44) !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),5,32) ) { set %dtwank not.us.country(iMDB) | goto foreignstop } }        
              if ( Documentary isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( $readini(d-tool\inis\ $+ $3,$1,imdbdocu) == 1 ) { set %dtwank Docu(iMDB) | goto foreignstop }
              if ( Music isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( $readini(d-tool\inis\ $+ $3,$1,imdbmc) == 1 ) { set %dtwank Music(iMDB) | goto foreignstop }
              if ( Show isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( $readini(d-tool\inis\ $+ $3,$1,imdbsw) == 1 ) { set %dtwank Show(iMDB) | goto foreignstop }
              if ( Comedy isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Action !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Adventure !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Drama !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Romance !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Crime !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Science-Fiction !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Fantasy !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Western !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( Thriller !isin $gettok($eval(% $+ dtimdbr $+ %wr,2),6,32) ) && ( $readini(d-tool\inis\ $+ $3,$1,imdbcom) == 1 ) { set %dtwank Comedy(iMDB) | goto foreignstop }
            }
            if ( %wr == 10 ) && ( %imdbtmp != 1 )  { if ( $readini(d-tool\inis\ $+ $3,$1,imdbeng) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,imdbus) == 1 ) { set %dtwank no.result(iMDB) | goto foreignstop } }       
            inc %wr 
          }
        }
      }
    }
  }
  var %we = 1 | while ( %we <= $lines(d-tool\languages.db) ) {
    var %lang = $gettok($read(d-tool\languages.db, %we),1,32) | var %langtags = $gettok($read(d-tool\languages.db, %we),2,32)
    if ( %lang $+ $chr(46) isincs %secname ) {
      var %tz = 1 | while ( %tz <= $numtok(%langtags,44) ) {
        if ( $chr(46) $+ $gettok(%langtags,%tz,44) $+ $chr(46) isincs %rls ) || ( $chr(46) $+ $gettok(%langtags,%tz,44) $+ $chr(45) isincs %rls ) || ( $chr(95) $+ $gettok(%langtags,%tz,44) $+ $chr(95) isincs %rls ) || ( $chr(95) $+ $gettok(%langtags,%tz,44) $+ $chr(45) isincs %rls ) { var %ftemp = 1 } 
        if ( %tz == $numtok(%langtags,44) ) && ( %ftemp != 1 ) && ( ENG. !isincs %secname ) { set %dtwank not. $+ %lang | goto foreignstop }
        inc %tz
      }
      var %wd = $read(d-tool\foreign.db,1) | var %we = 1 | while ( %we <= $numtok(%wd,32) ) {
        if ( $gettok(%wd,%we,32) !isincs %langtags ) { 
          if ( $chr(46) $+ $gettok(%wd,%we,32) $+ $chr(46) isincs %rls ) || ( $chr(46) $+ $gettok(%wd,%we,32) $+ $chr(45) isincs %rls ) || ( $chr(95) $+ $gettok(%wd,%we,32) $+ $chr(95) isincs %rls ) || ( $chr(95) $+ $gettok(%wd,%we,32) $+ $chr(45) isincs %rls ) { var %ftemp1 = 1 }
          if ( %we == $numtok(%langtags,44) ) && ( %ftemp1 == 1 ) && ( %lang $+ . !isin %secname ) { set %dtwank not. $+ %lang ( $+ $gettok(%wd,%we,32) $+ ) | goto foreignstop }
        }
        inc %we 
      } 
    }
    inc %we
  }
  goto foreigngo
  :foreignstop
  if ( %dtsrcchk != 1  ) { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp 14 Foreign-/IMDbCheck 15halted %srcdir > %desdir ( $+ %secname $+ )14 %rls 15@ 7 %srcsite >3 $1 14( $+ %dtwank $+ ) %redirect } | elseif ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Foreign-/IMDbCheck 15halted %srcdir > %desdir ( $+ %secname $+ )14 %rls 15@ 7 %srcsite >3 $1 14( $+ %dtwank $+ ) %redirect } } }
  set %dttradetrigger 0 | unset %dtwank*
  :foreigngo
}
alias wankerchk {
  ;VIDEO - 1=hd_in_sd//A=no_sd | 2=no_dvdr_in_dvdr//B=no_dvdr | 3=no_720p/1080p_in_264/hd//C=no_hd ( 3=no_2160p_in_265/uhd//C=no_uhd )
  if ( xvid isin %secname ) || ( sd isin %secname ) { if ( xvid !isin %rls ) && ( 264 !isin %rls ) { set %dtwanks 1 } } | if ( xvid isin %secname ) || ( sd isin %secname ) { if ( 0p isin %rls ) { set %dtwanks 1 } } | if ( xvid !isin %secname ) && ( sd !isin %secname ) set %dtwanks A
  if ( dvdr isin %secname ) && ( mdvd isin %secname ) && ( dvdrip !isin %rls ) && ( dvdrip !isin %secname ) { if ( .DVDR- !isin %rls ) && ( DVDR. !isin %rls ) && ( DVD9- !isin %rls ) { set %dtwanks %dtwanks $+ 2 } } | elseif ( dvdr !isin %secname ) set %dtwanks %dtwanks $+ B
  if ( x264 isin %secname ) || ( hd isin %secname && uhd !isin %secname ) { if ( 720 !isin %rls ) && ( 1080 !isin %rls ) set %dtwanks %dtwanks $+ 3 } | elseif ( x264 !isin %secname ) && ( hd !isin %secname ) set %dtwanks %dtwanks $+ C 
  if ( x265 isin %secname ) || ( uhd isin %secname ) || ( 2160p isin %secname ) { if ( 2160 !isin %rls ) && ( UHD !isin %rls ) { if ( $len(%dtwanks) == 2 ) set %dtwanks %dtwanks $+ 3 | else set %dtwanks $left(%dtwanks,2) $+ 3 } } | elseif ( x265 !isin %secname ) && ( uhd !isin %secname ) && ( 2160p !isin %secname ) && ( x264 !isin %secname ) && ( hd !isin %secname ) { if ( $len(%dtwanks) == 2 ) set %dtwanks %dtwanks $+ C | else set %dtwanks $left(%dtwanks,2) $+ C }
  if ( %dtwanks == A2C ) || ( %dtwanks == A23 ) || ( %dtwanks == 1BC ) || ( %dtwanks == AB3 ) || ( %dtwanks == 1B3 ) || ( %dtwanks == 12C ) { set %dtwank wrong.format | goto wankerstop } 
  if ( 1080p isin %secname ) && ( 1080 !isin %rls ) { set %dtwank no.1080p | goto wankerstop } | if ( 720p isin %secname ) && ( 720p !isin %rls ) { set %dtwank no.720p | goto wankerstop } | if ( 2160p isin %secname ) && ( 2160p !isin %rls ) { set %dtwank no.2160p | goto wankerstop }
  if ( 1080p isin %desdir ) && ( 1080 !isin %rls ) { set %dtwank no.1080p | goto wankerstop } | if ( 720p isin %desdir ) && ( 720p !isin %rls ) { set %dtwank no.720p | goto wankerstop } | if ( 2160p isin %desdir ) && ( 2160p !isin %rls ) { set %dtwank no.2160p | goto wankerstop }
  if ( HEVC isincs %secname ) && ( HEVC !isincs %rls ) { set %dtwank no.HEVC | goto wankerstop } | if ( HEVC isincs %rls ) && ( HEVC !isincs %rls ) { set %dtwank no.HEVC | goto wankerstop } | if ( AVC isincs %secname ) && ( AVC !isincs %rls ) { set %dtwank no.AVC | goto wankerstop }
  if ( COMPLETE.BLURAY isincs %rls ) && ( COMPLETE.UHD.BLURAY isincs %rls ) { if ( complete.bluray !isin %secname ) { set %dtwank no.complete.bluray.section | goto wankerstop } }
  if ( COMPLETE.BLURAY !isincs %rls ) && ( COMPLETE.UHD.BLURAY !isincs %rls ) && ( complete.bluray isin %secname )  && ( mbluray !isin %secname ) { set %dtwank no.complete.bluray | goto wankerstop }
  ;TV
  if ( doku isin %secname || docu isin %secname ) { if ( doku. !isin %rls ) && ( docu. !isin %rls ) { set %dtwank no.doku | goto wankerstop } } | if ( doku !isin %secname ) && ( docu !isin %secname ) && ( doku !isin %desdir ) && ( docu !isin %desdir ) { if ( doku. isin %rls ) || ( docu. isin %rls ) { set %dtwank doku.wrong | goto wankerstop } }
  if ( tv isin %secname && !tv !isin %secname ) {
    if ( SPORT isincs %redirect ) goto wankergo | if ( staffel isin %rls ) goto tvskip | if ( doku isin %rls ) || ( doku isin %rls ) goto tvskip
    if ( $regex(%rls,S[0-9][0-9]E[0-9][0-9]) != 1 ) && ( $regex(%rls,s[0-9][0-9]e[0-9][0-9]) != 1 ) && ( $regex(%rls,S[0-9][0-9]D[0-9][0-9]) != 1 ) && ( $regex(%rls,.S[0-9][0-9]) != 1 ) && ( $regex(%rls,.D[0-9][0-9]) != 1 ) && ( $regex(%rls,.E[0-9][0-9]) != 1 ) && ( $regex(%rls,20[1-9][0-9]-[0-2][0-9]-[0-3][0-9]) != 1 ) && ( $regex(%rls,20[0-9][0-9].[0-1][0-9].[0-3][0-9]) != 1 ) { set %dtwank no.series | goto wankerstop }
    ; if ( $regex(%rls,20[1-9][0-9]-[0-2][0-9]-[0-3][0-9]) == 1 ) || ( $regex(%rls,20[0-9][0-9].[0-1][0-9].[0-3][0-9]) == 1 ) { set %dtwank date.looks.like.show | goto wankerstop }
    :tvskip
  }
  if ( tv !isin %secname ) && ( mp3 !isin %secname ) && ( flac !isin %secname ) && ( SPORT !isincs %redirect ) { if ( $regex(%rls,S[0-9][0-9]E[0-9][0-9]) == 1 ) || ( $regex(%rls,S[0-9][0-9]D[0-9][0-9]) == 1 ) || ( $regex(%rls,.E[0-9][0-9]) == 1 )  || ( $regex(%rls,.EP[0-9][0-9]) == 1 ) { set %dtwank no.tv.section | goto wankerstop } }
  if ( Sport !isin %secname ) && ( TV isin %secname ) {
    var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) { if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) { var %sport = $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) } | inc %rd }
    if (%sport) { set %dtwank %sport $+ .is.Sport | goto wankerstop }
  }
  if ( !tv isin %secname ) {
    if ( $regex(%rls,S[0-9][0-9]E[0-9][0-9]) == 1 ) || ( $regex(%rls,S[0-9][0-9]D[0-9][0-9]) == 1 ) || ( $regex(%rls,.S[0-9]) == 1 ) || ( staffel isin %rls ) || ( $regex(%rls,.[0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9].) == 1 ) || ( $regex(%rls,.EP[0-9][0-9]) == 1 ) || ( $regex(%rls,.EP[0-9][0-9]) == 1 ) { set %dtwank no.tv.section! | goto wankerstop }
    ; if ( $regex(%rls,20[1-9][0-9]-[0-2][0-9]-[0-3][0-9]) == 1 ) || ( $regex(%rls,20[0-9][0-9].[0-1][0-9].[0-3][0-9]) == 1 ) { set %dtwank date.looks.like.show | goto wankerstop }
  }
  ;ELSE
  if ( mdvdr isin %secname ) { if ( mdvdr !isin %rls ) { set %dtwank no.mdvdr | goto wankerstop } } | if ( mdvdr !isin %secname ) && ( mdvdr isin %rls ) { set %dtwank mdvdr.section | goto wankerstop }
  if ( mbluray isin %secname ) { if ( mbluray !isin %rls ) { set %dtwank no.mbluray | goto wankerstop } } | if ( mbluray !isin %secname ) && ( mbluray isin %rls ) { set %dtwank mbluray.section | goto wankerstop }
  if ( */*/* iswm %rls ) || ( *-*/* iswm %rls ) { set %dtwank dir.fuckup | goto wankerstop } | if ( - !isin %rls ) { set %dtwank no.grp | goto wankerstop } 
  if ( / isin %rls ) || ( .nfo isin %rls && READ.NFO !isin %rls ) { set %dtwank fucked.up | goto wankerstop }
  if ( mp3 isin %secname ) || ( 0day isin %secname ) || ( flac isin %secname ) { 
    if ( xvid isin %rls ) || ( dvdr isin %rls ) || ( HDTV isin %rls ) || ( .x26 isin %rls ) || ( .h26 isin %rls ) || ( 720p isin %rls ) || ( 1080p isin %rls ) || ( 2160p isin %rls ) || ( ebook isin %rls ) { if ( paysite !isin %secname ) && ( xxx !isin %secname ) { set %dtwank no.music/0day | goto wankerstop } }
    if ( flac isin %secname ) && ( FLAC !isincs %rls ) { set %dtwank no.flac | goto wankerstop } | if ( FLAC isincs %rls ) && ( flac !isin %secname ) { set %dtwank no.flac.section | goto wankerstop } 
  }
  if ( xxx isin %secname ) && ( .xxx !isin %rls ) { set %dtwank no.porn | goto wankerstop } | if ( xxx !isin %secname ) && ( .xxx isin %rls ) && ( paysite !isin %secname ) { set %dtwank no.porn.section | goto wankerstop } 
  if ( xxx isin %secname ) && ( pay isin %secname ) { if ( DL. isincs %rls ) || ( .LD isincs %rls ) || ( .dubbed isin %rls ) || ( mic. isin %rls ) || ( .MD isincs %rls ) || ( .subbed isin %rls ) || ( *COMPLETE*BLURAY* iswmcs %rls ) || ( .HDR iswmcs %rls ) { set %dtwank not.paysite | goto wankerstop } } 
  if ( app isin %secname ) { if ( .xvid isin %rls ) || ( .x26 isin %rls ) || ( .h26 isin %rls ) || ( _WII isin %rls )  || ( .xbox isin %rls )  || ( .ps3 isin %rls ) { set %dtwank no.app | goto wankerstop } }
  if ( ebook isin %secname ) && ( eBook !isincs %rls ) { set %dtwank no.ebook | goto wankerstop } | if ( ebook !isin %secname ) && ( eBook isincs %rls ) { set %dtwank ebook.section | goto wankerstop }
  ;CONSOLE/GAME/APPS
  if ( pc isin %secname ) || ( game isin %secname ) { if ( DVDR isin %rls ) || ( x264 isin %rls ) || ( x265 isin %rls ) || ( h265 isin %rls ) || ( BDRip isin %rls ) || ( UHD isin %rls ) || ( 2160p isin %rls ) || ( 720p isin %rls ) || ( 1080p isin %rls ) || ( xvid isin %rls ) || ( XXX isin %rls ) || ( NDS isincs %rls) || ( XBOX isincs %rls ) || ( x360 isin %rls ) || ( _Wii isincs %rls ) || ( PSP isincs %rls ) || ( PS2 isincs %rls ) || ( PS3 isincs %rls ) || ( PS4 isincs %rls ) { set %dtwank no.pcgame | goto wankerstop } }
  if ( xbox360 isin %secname ) { if ( 360 !isin %rls ) { set %dtwank no.xbox | goto wankerstop } } | if ( .xbox360. isin %rls ) && ( 360 !isin %secname ) && ( xbox !isin %secname ) { set %dtwank xbox.section | goto wankerstop } 
  if ( xboxone isin %secname ) { if ( xboxone !isin %rls ) { set %dtwank no.xbox | goto wankerstop } } | if ( .xboxone. isin %rls ) && ( xboxone !isin %secname ) { set %dtwank xbox.section | goto wankerstop } 
  if ( wii isin %secname ) { if ( _wii !isin %rls ) { set %dtwank no.wii | goto wankerstop } } | if ( _wii isin %rls ) { if ( wii isin %secname ) goto wankergo | else { set %dtwank wii.section | goto wankerstop } }
  if ( ps2 isin %secname ) { if ( ps2 !isin %rls ) { set %dtwank no.ps2 | goto wankerstop } } | if ( .ps2 isin %rls ) { if ( ps2 isin %secname ) goto wankergo | else { set %dtwank ps2.section | goto wankerstop } }
  if ( ps3 isin %secname ) { if ( ps3 !isin %rls ) { set %dtwank no.ps3 | goto wankerstop } } | if ( .ps3 isin %rls ) { if ( ps3 isin %secname ) goto wankergo | else { set %dtwank ps3.section | goto wankerstop } }
  if ( ps4 isin %secname ) { if ( ps4 !isin %rls ) { set %dtwank no.ps4 | goto wankerstop } } | if ( .ps4 isin %rls ) { if ( ps4 isin %secname ) goto wankergo | else { set %dtwank ps4.section | goto wankerstop } }
  if ( psp isin %secname ) { if ( psp !isin %rls ) { set %dtwank no.psp | goto wankerstop } } | if ( -psp- isin %rls ) || ( .psp- isin %rls ) || ( _psp- isin %rls ) { if ( psp isin %secname ) goto wankergo | else { set %dtwank psp.section | goto wankerstop } }
  if ( nds isin %secname ) { if ( nds !isin %rls ) { set %dtwank no.nds | goto wankerstop } } | if ( -nds- isin %rls ) || ( .nds- isin %rls ) || ( _nds- isin %rls ) { if ( nds isin %secname ) goto wankergo | else { set %dtwank nds.section | goto wankerstop } }
  if ( nsw isin %secname ) { if ( NSW !isincs %rls ) { set %dtwank no.nsw | goto wankerstop } } | if ( NSW isincs %rls ) { if ( nsw isin %secname ) goto wankergo | else { set %dtwank nsw.section | goto wankerstop } }
  goto wankergo 
  :wankerstop
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) {
      if ( mp3 isin %secname ) || ( 0day isin %secname ) || ( flac isin %secname ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) goto nowankmsg }
      window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at $timestamp 14 Wankercheck 15halted %srcdir > %desdir ( $+ %secname $+ )14 %rls 15@ 7 %srcsite >3 $1 14( $+ %dtwank $+ ) %redirect 
    } 
    elseif ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) {
      if ( mp3 isin %secname ) || ( 0day isin %secname ) || ( flac isin %secname ) { if ( $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) goto nowankmsg }
      window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Wankercheck 15halted %srcdir > %desdir ( $+ %secname $+ )14 %rls 15@ 7 %srcsite >3 $1 14( $+ %dtwank $+ ) %redirect 
    }
  } 
  :nowankmsg
  set %dttradetrigger 0 | unset %dtwank*
  :wankergo
}
alias dtlangs {
  unset %dtlangs | unset %dtlangt | var %we = 1 | while ( %we <= $lines(d-tool\languages.db) ) {
    set %dtlangs %dtlangs $gettok($read(d-tool\languages.db,%we),1,32) | set %dtlangt %dtlangt $replace($gettok($read(d-tool\languages.db,%we),2-,32),$chr(44),$chr(32))
    inc %we
  }
  if ( $uptime > 100 ) { if (!$window(@d-tool)) dtoolwin | window -a @d-tool | aline -p @d-tool Set Languages:  | aline -p @d-tool Langtags: %dtlangs - Allowed Languages: %dtlangt }
}
alias grpname { 
  var %nx = 1 | while ( %nx <= numtok($1,45) ) {
    if ($gettok($1, %nx, 45)) var %rlsgrpc = %nx
    elseif (!$gettok($1,%nx,45)) { set %dtgrpn $gettok($1,%rlsgrpc,45) | goto grpcut }
    inc %nx
  }
  :grpcut
  if ( $len(%dtgrpn) > $readini(d-tool\d-tool.ini,vars,maxgrplen) ) { set %dttradetrigger 0 | if ( $window(d-tool_at) != $true ) && ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 )  window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | echo @d-tool 52 Groupname length triggered by %dtgrpn ( $+ $1 $+ ) - d-tool does not support this } 
}
alias addaffil {
  var %vop = 1 | while ( %vop <= $readini(d-tool\inis\ $+ %srcsite $+ .ini,%srcsite,aentrys) ) {
    if ( $remove($readini(d-tool\inis\ $+ %srcsite $+ .ini,affils,a $+ %vop),$chr(45)) == %dtgrpn ) var %noadd = 1
    var %afflist %afflist $remove($readini(d-tool\inis\ $+ %srcsite $+ .ini,affils,a $+ %vop),$chr(45)) 
    inc %vop
  }
  if ( %noadd != 1 ) {
    if ($dialog(dtool-rules)) && ( %dtsetsite == %srcsite ) { dialog -x dtool-rules | var %fgh 1 } | writeini d-tool\inis\ $+ %srcsite $+ .ini affils a $+ %vop - $+ %dtgrpn | writeini d-tool\inis\ $+ %srcsite $+ .ini %srcsite aentrys %vop | if (!$window(@d-tool)) { dtoolwin | else window -a @d-tool } | echo @d-tool $timestamp added3 %dtgrpn to %srcsite Affils! | if (%fgh) dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-rules dtool-rules 
    if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) { var %afflist %afflist %dtgrpn | dcbsync %srcsite a %afflist }
  } 
}
alias ruleentry {
  if (!%dtrulecount) set %dtrulecount 1 | else inc %dtrulecount | if ( %dtrulecount == 11 ) set %dtrulecount 1 
  var %go = 1 | while ( %go <= 10 ) {
    if ( $gettok($eval(% $+ dtrules $+ %go,2),1,32) == %rls ) && ( $gettok($eval(% $+ dtrules $+ %go,2),2,32) == %secname ) {
      if ( $2 == s ) { if ( %srcsite !isin $gettok($eval(% $+ dtrules $+ %go,2),3,32) ) set % $+ dtrules $+ %go $eval(% $+ dtrules $+ %go,2) $+ %srcsite $+ $1 }
      else { if ( %dessite !isin $gettok($eval(% $+ dtrules $+ %go,2),3,32) ) set % $+ dtrules $+ %go $eval(% $+ dtrules $+ %go,2) $+ %dessite $+ $1 } 
      var %found = 1
    }
    inc %go
  }
  if (!%found) set % $+ dtrules $+ %dtrulecount %rls %secname %dessite $+ $1
}
alias ruleentrys {
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | echo @d-tool 3 Displaying Ruleentrys... | var %lu = 1 | while ( %lu <= 10 ) {
    echo @d-tool  %lu $eval(% $+ dtrules $+ %lu,2)
    inc %lu
  } 
}
alias writeracedb { 
  if ( $lines(d-tool\d-tool.race.db) >= 300 ) {
    var %cf = 200 | while ( %cf <= 300 ) {
      write d-tool\d-tool.race.tmp $read(d-tool\d-tool.race.db,%cf)
      inc %cf
    } 
    .remove d-tool\d-tool.race.db | .rename d-tool\d-tool.race.tmp d-tool\d-tool.race.db
  }
  var %vz = $read(d-tool\d-tool.race.db, w, * $+ %dessite $+ * $+ %rls $+ *)
  if ( $gettok(%vz,1,32) == %dessite ) && ( $gettok(%vz,2,32) == %rls ) { goto noracewrite } | else write d-tool\d-tool.race.db %dessite %rls
  :noracewrite
}
alias uturncheck {
  var %i = 1 | while ( %i <= $readini(d-tool\inis\ $+ $3,redirect,count) ) {
    if ( + isin $readini(d-tool\inis\ $+ $3,redirect,%i) ) && ( $2 == $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),1,43) ) {   
      if ( ! !isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) ) {
        ;SPORT
        if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) == SPORT ) {
          var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
            if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $regex(%rls,$gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32)) == 1 ) { 
              var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) {
                if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) == $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) ) {
                  set %desdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) | set %sektionnrsave %sektionnr | set %sektionnr %z | set %secname $readini(d-tool\sections.ini,name,%z) | set %desdirdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z $+ dir) | set %redirect 3 (redirect) SPORT $+ $remove(%redirect,$chr(40) $+ redirect $+ $chr(41))
                }
                inc %z 
              }
            }
            inc %rd
          }
        }
        ;entry|entry(cs);*wild*card*|*wild*card*(cs)
        elseif ( $chr(124) isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) ) && ( $chr(126) !isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) ) {
          var %f = 1 | while ( %f <= $numtok($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),124) ) {
            if ( $gettok($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),%f,124) isincs %rls ) || ( $gettok($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),%f,124) iswmcs %rls ) {
              var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) { 
                if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),1,43) == $2 ) && ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) == $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) ) { 
                  set %desdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) | set %sektionnrsave %sektionnr | set %sektionnr %z | set %secname $readini(d-tool\sections.ini,name,%z) | set %desdirdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z $+ dir) | set %redirect 3 (redirect) $gettok($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),%f,124) $+ $remove(%redirect,$chr(40) $+ redirect $+ $chr(41))
                } 
                inc %z 
              }
            }
            inc %f
          }
        }
        ;entry(cs);*wild*card*(cs);~regex
        elseif ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) isincs %rls ) || ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) iswmcs %rls ) || ( $chr(126) isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) && $regex(%rls,$remove($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),$chr(126))) == 1 ) {
          var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) { 
            if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),1,43) == $2 ) && ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) == $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) ) { 
              set %desdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) | set %sektionnrsave %sektionnr | set %sektionnr %z | set %secname $readini(d-tool\sections.ini,name,%z) | set %desdirdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z $+ dir) | set %redirect 3 (redirect) $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) $+ $remove(%redirect,$chr(40) $+ redirect $+ $chr(41))
            } 
            inc %z 
          }
        }
      }
      elseif ( ! isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) ) {
        ;!SPORT
        if ( $remove($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),$chr(33)) == SPORT ) {
          var %rd = 1 | while ( %rd <= $numtok($readini(d-tool\d-tool.ini,vars,sport),32) ) {
            if ( $gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32) isincs %rls ) || ( $regex(%rls,$gettok($readini(d-tool\d-tool.ini,vars,sport),%rd,32)) == 1 ) {
              var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) {
                if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) == $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) ) {
                  set %desdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) | set %sektionnrsave %sektionnr | set %sektionnr %z | set %secname $readini(d-tool\sections.ini,name,%z) | set %desdirdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z $+ dir) | set %redirect 3 (redirect.forced) !SPORT $+ $remove(%redirect,$chr(40) $+ redirect $+ $chr(41))
                }
                inc %z 
              }
            }
            inc %rd
          }
        } 
        ;!entry|entry(cs);!*wild*card*|*wild*card*(cs)
        elseif ( $chr(124) isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) ) && ( $chr(126) !isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) ) {
          var %f = 1 | while ( %f <= $numtok($gettok($remove($readini(d-tool\inis\ $+ $3,redirect,%i),$chr(33)),3,43),124) ) {
            if ( $gettok($gettok($remove($readini(d-tool\inis\ $+ $3,redirect,%i),$chr(33)),3,43),%f,124) isincs %rls ) {
              var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) { 
                if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),1,43) == $2 ) && ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) == $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) ) { 
                  set %desdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) | set %sektionnrsave %sektionnr | set %sektionnr %z | set %secname $readini(d-tool\sections.ini,name,%z) | set %desdirdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z $+ dir) | set %redirect 3 (redirect.forced) $gettok($gettok($remove($readini(d-tool\inis\ $+ $3,redirect,%i),$chr(33)),3,43),%f,124) $+ $remove(%redirect,$chr(40) $+ redirect $+ $chr(41))
                } 
                inc %z 
              }
            }
            inc %f
          }
        }
        ;!entry(cs);*wild*card*(cs);!~regex
        elseif ( $remove($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),$chr(33)) isincs %rls ) || ( $remove($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),$chr(33)) iswmcs %rls ) || ( $chr(126) isin $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) && $regex(%rls,$remove($remove($gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43),$chr(33)),$chr(126))) == 1 ) {
          var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) {
            if ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) == $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) ) && ( $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),2,43) != $2 ) { 
              set %desdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z) | set %sektionnrsave %sektionnr | set %sektionnr %z | set %secname $readini(d-tool\sections.ini,name,%z) | set %desdirdir $readini(d-tool\inis\ $+ $3,sections,dlight $+ %z $+ dir) | set %redirect 3 (redirect.forced) $gettok($readini(d-tool\inis\ $+ $3,redirect,%i),3,43) $+ $remove(%redirect,$chr(40) $+ redirect $+ $chr(41))
              goto uturnend
            } 
            inc %z 
          }
        }
      }
    }
    inc %i
  }
  :uturnend
}
alias redircount {
  var %e = 1 | while ( %e <= 100 ) {
    if ($readini(d-tool\inis\ $+ %dtsiteini,redirect,%e)) writeini -n d-tool\inis\ $+ %dtsiteini redirect count %e
    inc %e
  }
}
alias tvmazechk {  
  if ( tv isin %secname && !tv !isin %secname ) {
    var %w = 2 | while ( %w <= 10 ) { 
      var %it = $gettok(%rls,%w,46)
      if ( $regex(%it,S[0-9]) == 1 ) || ( $regex(%it,E[0-9]) == 1 ) || ( %it == US ) || ( %it == UK ) || ( $regex(%it,[1-2][0-9][0-9][0-9]) == 1 ) || ( $regex($eval($gettok(%rls,$calc( %w + 1),1),46),[1-2][0-9]) == 1 ) || ( $regex($eval($gettok(%rls,$calc( %w + 2),1),46),[1-3][0-9]) == 1 ) { set %tvmaze.wort $calc(%w -1) | goto wortcheckhalt1 }
      inc %w 
    } 
    :wortcheckhalt1
    var %b = 1 | while ( %b <= %tvmaze.wort ) { var %dttvrageitemdb = %dttvrageitemdb $gettok(%rls,%b,46) | inc %b }
    if ($readini(d-tool\tvmaze.db,$replace(%dttvrageitemdb,$chr(32),.),item)) { set %ragedata1 $readini(d-tool\tvmaze.db,$replace(%dttvrageitemdb,$chr(32),.),data) | goto directdata }
    if ( doku !isin %rls ) && ( docu !isin %rls ) && ( sport !isin %secname ) {
      var %secname = $readini(d-tool\sections.ini,name,%sektionnr)
      var %z = 1 | while ( %z <= 10 ) { var %rageitem = rage $+ %z | if ($readini(d-tool\d-tool.ini,%rageitem,%rls)) set %dtrcc %z | inc %z }
      var %rageitem = rage $+ %dtrcc
      if ($readini(d-tool\d-tool.ini,%rageitem,%rls)) set %ragedata1 $readini(d-tool\d-tool.ini,%rageitem,%rls)
      :directdata
      if ( ENG. isincs %secname ) || ( us. isin %secname ) { 
        set %dtragestatus 14- tvmaze: 3
        if ( 720p isin %rls ) || ( 1080p isin %rls ) || ( 2160p isin %rls ) {
          if ( bluray !isin %secname ) && ( dvd !isin %secname ) {
            if ( $readini(d-tool\inis\ $+ $3,$1,current) == 1 ) { if ( .S0 $+ $gettok(%ragedata1,4,32) !isin %rls ) && ( .S $+ $gettok(%ragedata1,4,32) !isin %rls ) && ( Running isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dttradetrigger 0 | set %dtentry Not.Current | goto tvgo1 } | if ( Ended isincs %ragedata1 ) { set %dttradetrigger 0 | set %dtentry Not.Current | goto tvgo1 } | if ( To_Be_Determined isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry Not.Current | goto tvgo1 } | set %dtragestatus %dtragestatus $+ .cur }
            if ( $readini(d-tool\inis\ $+ $3,$1,scripted) == 1 ) var %t1 = 1 | else var %tl = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hdanim) == 1 ) var %t2 = 1 | else var %t2 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hddoc) == 1 ) var %t3 = 1 | else var %t3 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hdreal) == 1 ) var %t4 = 1 | else var %t4 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hdrom) == 1 ) var %t5 = 1 | else var %t5 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hdkid) == 1 ) var %t6 = 1 | else var %t6 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hdtalk) == 1 ) var %t7 = 1 | else var %t7 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,hdvar) == 1 ) var %t8 = 1 | else var %t8 = 0 | if ( %t1 == 1 ) || ( %t2 == 1 ) || ( %t3 == 1 ) || ( %t4 == 1 ) || ( %t5 == 1 ) || ( %t6 == 1 ) || ( %t7 == 1 ) || ( %t8 == 1 ) set %tvms 1
            if ( %t1 == 1 ) && ( scripted !isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry Not.Scripted | goto tvgo1 }
            if ( %t2 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,anim_s) == 1 ) && ( animation isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Animation | goto tvgo1 }
            if ( %t3 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,doc_s) == 1 ) && ( documentary isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Docu | goto tvgo1 } 
            if ( %t4 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,real_s) == 1 ) && ( reality isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Reality | goto tvgo1 }
            if ( %t5 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,rom_s) == 1 ) && ( romance isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Romance | goto tvgo1 }
            if ( %t6 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,kid_s) == 1 ) && ( kids isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Kiddie | goto tvgo1 }
            if ( %t7 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,talk_s) == 1 ) && ( talk_show isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.TalkShow | goto tvgo1 }
            if ( %t8 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,var_s) == 1 ) && ( Variety isincs %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Variety | goto tvgo1 }
            if ( English !isin %ragedata1 ) { if ( $readini(d-tool\inis\ $+ $3,$1,tv-us) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,tv-uk) == 1 ) { set %dttradetrigger 0 | set %dtentry Not.English | goto tvgo1 } }
            mazechecker
            :tvgo1
          }
          if ( %ragedata1 != $null ) {
            if ( US !isincs %ragedata1 ) { set %usgo 0 } | else { set %usgo 1 | set %dtragestatus %dtragestatus $+ .us } 
            if ( UK !isincs %ragedata1 ) { set %ukgo 0 } | else { set %ukgo 1 | set %dtragestatus %dtragestatus $+ .uk }
          } 
          if ( $readini(d-tool\inis\ $+ $3,$1,tv-us) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,tv-uk) == 1 ) {
            if ( %ukgo == 0 ) && ( %usgo == 0 ) { set %dttradetrigger 0 | set %dtentry Not.US/UK }
          }

          if ( $readini(d-tool\inis\ $+ $3,$1,tv-us) == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,tv-uk) != 1 ) {
            if ( %usgo == 0 ) && ( %ukgo == 1 ) { set %dttradetrigger 0 | set %dtentry Not.US }
          }
          if ( $readini(d-tool\inis\ $+ $3,$1,tv-uk) == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,tv-us) != 1 ) {
            if ( %usgo == 1 ) && ( %ukgo == 0 ) { set %dttradetrigger 0 | set %dtentry Not.UK }
          }
        }
        else {
          if ( bluray !isin %secname ) && ( dvd !isin %secname ) {
            if ( $readini(d-tool\inis\ $+ $3,$1,sdcurrent) == 1 ) { if ( S0 $+ $gettok(%ragedata1,4,32) !isin %rls ) && ( S $+ $gettok(%ragedata1,4,32) !isin %rls ) && ( Running isin %ragedata1 ) && ( %ragedata1 != $null )  { set %dttradetrigger 0 | set %dtentry Not.Current | goto tvgo2 } | else set %dtragestatus %dtragestatus $+ .cur }
            if ( $readini(d-tool\inis\ $+ $3,$1,sdscripted) == 1 ) var %t1 = 1 | else var %tl = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sdanim) == 1 ) var %t2 = 1 | else var %t2 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sddoc) == 1 ) var %t3 = 1 | else var %t3 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sdreal) == 1 ) var %t4 = 1 | else var %t4 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sdrom) == 1 ) var %t5 = 1 | else var %t5 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sdkid) == 1 ) var %t6 = 1 | else var %t6 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sdrom) == 1 ) var %t7 = 1 | else var %t7 = 0
            if ( $readini(d-tool\inis\ $+ $3,$1,sdkid) == 1 ) var %t8 = 1 | else var %t8 = 0 | if ( %t1 == 1 ) || ( %t2 == 1 ) || ( %t3 == 1 ) || ( %t4 == 1 ) || ( %t5 == 1 ) || ( %t6 == 1 ) || ( %t7 == 1 ) || ( %t8 == 1 ) set %tvms 1          
            if ( %t1 == 1 ) && ( scripted !isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry Not.Scripted | goto tvgo2 }
            if ( %t2 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,anim_s) == 1 ) && ( animation isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Animation | goto tvgo2 }
            if ( %t3 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,doc_s) == 1 ) && ( documentary isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Docu | goto tvgo2 } 
            if ( %t4 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,real_s) == 1 ) && ( reality isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Reality | goto tvgo2 }
            if ( %t5 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,rom_s) == 1 ) && ( romance isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Romance | goto tvgo2 }
            if ( %t6 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,kid_s) == 1 ) && ( kids isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Kiddie | goto tvgo2 }
            if ( %t7 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,talk_s) == 1 ) && ( Talk_Show isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.TalkShow | goto tvgo2 }
            if ( %t8 != 1 ) && ( %tvms == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,var_s) == 1 ) && ( Variety isincs %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Variety | goto tvgo2 }
            mazechecker
            :tvgo2
          }
          if ( %ragedata1 != $null ) {
            if ( US !isincs %ragedata1 ) { set %usgo 0 } | else { set %usgo 1 | set %dtragestatus %dtragestatus $+ .us } 
            if ( UK !isincs %ragedata1 ) { set %ukgo 0 } | else { set %ukgo 1 | set %dtragestatus %dtragestatus $+ .uk }
          } 
          if ( $readini(d-tool\inis\ $+ $3,$1,sdtv-us) == 1 ) || ( $readini(d-tool\inis\ $+ $3,$1,sdtv-uk) == 1 ) {
            if ( %ukgo == 0 ) && ( %usgo == 0 ) { set %dttradetrigger 0 | set %dtentry Not.US/UK }
          }

          if ( $readini(d-tool\inis\ $+ $3,$1,sdtv-us) == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,sdtv-uk) != 1 ) {
            if ( %usgo == 0 ) && ( %ukgo == 1 ) { set %dttradetrigger 0 | set %dtentry Not.US }
          }
          if ( $readini(d-tool\inis\ $+ $3,$1,sdtv-uk) == 1 ) && ( $readini(d-tool\inis\ $+ $3,$1,sdtv-us) != 1 ) {
            if ( %usgo == 1 ) && ( %ukgo == 0 ) { set %dttradetrigger 0 | set %dtentry Not.UK }
          }
        }
        if ( scripted !isin %ragedata1 ) && ( reality !isin %ragedata1 ) && ( animation !isin %ragedata1 ) && ( talk_show !isin %ragedata1 ) && ( documentary !isin %ragedata1 ) && ( game_show !isin %ragedata1 ) && ( news !isin %ragedata1 ) && ( sports !isin %ragedata1 ) && ( variety !isin %ragedata1 ) && ( award_show !isin %ragedata1 ) { set %dttradetrigger 0 | set %dtentry No.Result }
      }
    }
  }
  unset %ragedata1 | unset %ukgo | unset %usgo | unset %aa | unset %bb | unset %cc | unset %dd | unset %ee | unset %ff | unset %t1 | unset %t2 | unset %t3 | unset %t4 | unset %t5 | unset %t6 | unset %tvms | if ( $len(%dtragestatus) == 15 ) unset %dtragestatus
  if ( %dtentry == No.Result ) && ( $readini(d-tool\d-tool.ini,vars,ragerecheck) == 1 ) && ( %dtsrcchk != 1 ) .timer 1 $readini(d-tool\d-tool.ini,vars,ragerechecktime) ragerecheck %rls %sektionnr %srcsite %srcdir %srcdirdir $1 $3 $2 %desdirdir %dtwindownr
}
alias mazechecker {
  if ( %t1 == 1 ) { if ( scripted !isin %ragedata1 ) && ( %ragedata1 != $null ) set %aa 1 | elseif ( scripted isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dtragestatus %dtragestatus $+ .scr } }
  if ( %t2 == 1 ) { if ( animation !isin %ragedata1 ) && ( %ragedata1 != $null ) set %bb 1 | elseif ( animation isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dtragestatus %dtragestatus $+ .ani } }
  if ( %t3 == 1 ) { if ( documentary !isin %ragedata1 ) && ( %ragedata1 != $null ) set %cc 1 | elseif ( documentary isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dtragestatus %dtragestatus $+ .doc } }
  if ( %t4 == 1 ) { if ( reality !isin %ragedata1 ) && ( %ragedata1 != $null ) set %dd 1 | elseif ( reality isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dtragestatus %dtragestatus $+ .rlt } } 
  if ( %t5 == 1 ) { if ( romance !isin %ragedata1 ) && ( %ragedata1 != $null ) set %ee 1 | elseif ( romance isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dtragestatus %dtragestatus $+ .rom } }
  if ( %t6 == 1 ) { if ( kids !isin %ragedata1 ) && ( %ragedata1 != $null ) set %ff 1 | elseif ( kids isin %ragedata1 ) && ( %ragedata1 != $null ) { set %dtragestatus %dtragestatus $+ .kid } }
  ;1
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted }  
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Documentary }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Reality }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Romance }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Kids }
  ;2
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Reality }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Romance }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Kids }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Reality }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Romance }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Reality }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Romance }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Reality/Romance }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Reality/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Romance/Kids }
  ;3
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Reality }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Romance }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Kids }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Reality }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Romance }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Kids }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Reality/Romance }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu/Reality }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu/Romance }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu/Kids }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Reality/Romance }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Reality/Kids }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Romance/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Reality/Romance }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Reality/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Romance/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Reality/Romance/Kids }
  ;4
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .rlt !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Romance }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff != 1 ) && ( .rom !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Reality }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .rlt !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Kids }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .doc !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Reality/Romance }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .doc !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Reality/Kids }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .ani !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Reality/Romance }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .ani !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Reality/Kids }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .ani !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Romance/Kids }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .scr !isin %dtragestatus ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu/Reality/Romance }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu/Reality/Kids }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .rlt !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Docu/Romance/Kids }
  if ( %aa != 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .doc !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Animation/Reality/Romance/Kids }
  if ( %aa != 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .scr !isin %dtragestatus ) && ( .ani !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Docu/Reality/Romance/Kids }
  ;5
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff != 1 ) && ( .kid !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Reality/Romance }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee != 1 ) && ( %ff == 1 ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Reality/Kids }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd != 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .rlt !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Romance/Kids }
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc != 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .doc !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Reality/Romance/Kids }
  if ( %aa == 1 ) && ( %bb != 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff == 1 ) && ( .rom !isin %dtragestatus ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Docu/Reality/Romance/Kids }
  ;6
  if ( %aa == 1 ) && ( %bb == 1 ) && ( %cc == 1 ) && ( %dd == 1 ) && ( %ee == 1 ) && ( %ff == 1 ) { set %dttradetrigger 0 | set %dtentry Not.Scripted/Animation/Docu/Reality/Romance/Kids }
}
alias ragerecheck {  
  set %rls $1 | var %e = 1 | while ( %e <= 15 ) {
    if ( %rls == $gettok($readini(d-tool\d-tool.ini,ragerecheck,%e),1,32) ) && ( $3 == $gettok($readini(d-tool\d-tool.ini,ragerecheck,%e),2,32) ) && ( $6 == $gettok($readini(d-tool\d-tool.ini,ragerecheck,%e),3,32) ) { goto ragerecheckend }
    inc %e
  }
  var %qw = 1 | while ( %qw <= 10 ) {
    if ( $gettok($eval(% $+ dtrules $+ %qw,2),1,32) == %rls ) && ( $gettok($eval(% $+ dtrules $+ %qw,2),2,32) == %secname ) {
      if ( $6 $+ - isin $gettok($eval(% $+ dtrules $+ %qw,2),3,32) ) set % $+ dtrules $+ %qw $remove($eval(% $+ dtrules $+ %qw,2),$6 $+ -)
    }
    inc %qw
  }
  set %sektionnr $2 | set %srcsite $3 | set %srcdir $4 | set %srcdirdir $5 | set %dessite $6 | set %desini $7 | set %desdir $8 | set %desdirdir $9 | set %dtwindownr $10 | if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { window -zkbD @d-tool_at -1 -1 font 11 | aline -p @d-tool_at $timestamp 14Rechecking TVMaze for %rls from %srcsite to %dessite } | trade 
  if (!$readini(d-tool\d-tool.ini,ragerecheck,count)) writeini -n d-tool\d-tool.ini ragerecheck count 1 | if ( $readini(d-tool\d-tool.ini,ragerecheck,count) < 15 ) writeini -n d-tool\d-tool.ini ragerecheck count $calc( $readini(d-tool\d-tool.ini,ragerecheck,count) + 1 ) | elseif ( $readini(d-tool\d-tool.ini,ragerecheck,count) == 15 ) writeini -n d-tool\d-tool.ini ragerecheck count 1 | writeini -n d-tool\d-tool.ini ragerecheck $readini(d-tool\d-tool.ini,ragerecheck,count) %rls %srcsite %dessite
  :ragerecheckend
}
alias imdbcheck {
  var %bini = $1 $+ .ini
  var %db = 1 | while ( %db <= 20 ) { 
    if ( $2 == $gettok($readini(d-tool\inis\ $+ %bini,imdb,%db),1,95) ) { 
      if ($gettok($readini(d-tool\inis\ $+ %bini,imdb,%db),2,95)) set %imdballow $gettok($readini(d-tool\inis\ $+ %bini,imdb,%db),2,95)
      if ($gettok($readini(d-tool\inis\ $+ %bini,imdb,%db),3,95)) set %imdballowv $gettok($readini(d-tool\inis\ $+ %bini,imdb,%db),3,95)
      var %i = 1 | while ( %i <= 20 ) {  ; !! Wert 20 auch in Line 2301 einstellen !!
        if ( %rls == $gettok($eval(% $+ dtimdbr $+ %i,2),1,32) ) { if ( N/A !isin $gettok($eval(% $+ dtimdbr $+ %i,2),2,32) ) set %imdbrating $gettok($eval(% $+ dtimdbr $+ %i,2),2,32) | if ( N/A !isin $gettok($eval(% $+ dtimdbr $+ %i,2),2,32) ) set %imdbvotes $gettok($eval(% $+ dtimdbr $+ %i,2),3,32) }
        if (%imdbrating) && (%imdballow) {
          if ( %imdbrating >= %imdballow ) {
            if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at 15 $timestamp 3 IMDb-Rating 15 %srcsite >15 %dessite - $strip(%rls,ruc) - %imdbrating for $2 3passed15 ( $+ %imdballow $+ ) }
            goto imdbcheckend
          } 
          if ( %imdbrating < %imdballow ) {
            if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,skipinatwin) != 1 )  && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 6 IMDb-Rating 15 %srcsite >15 %dessite - $strip(%rls,ruc) 15- %imdbrating for $2 4failed15 ( $+ %imdballow $+ +) }
            elseif ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 )  && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 6 IMDb-Rating 15 %srcsite >15 %dessite - $strip(%rls,ruc) 15- %imdbrating for $2 4failed15 ( $+ %imdballow $+ +) }
            set %dttradetrigger 0 | goto imdbcheckend
          }   
        }
        if (%imdbvotes) && (%imdballowv) {
          if ( %imdbvotes >= %imdballowv ) {
            if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_at -1 -1 font $readini(d-tool\d-tool.ini,vars,atfsize) | aline -p @d-tool_at 15 $timestamp 3 IMDb-Votes 15 %srcsite >15 %dessite - $strip(%rls,ruc) - %imdbvotes for $2 3passed15 ( $+ %imdballowv $+ ) }
            goto imdbcheckend
          } 
          if ( %imdbvotes < %imdballowv ) {
            if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,skipinatwin) != 1 ) && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 6 IMDb-Votes 15 %srcsite >15 %dessite - $strip(%rls,ruc) 15- %imdbvotes for $2 4failed15 ( $+ %imdballowv $+ ) }
            if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 6 IMDb-Votes 15 %srcsite >15 %dessite - $strip(%rls,ruc) 15- %imdbvotes for $2 4failedl15 ( $+ %imdballowv $+ ) }
            set %dttradetrigger 0 | goto imdbcheckend
          }   

        } 
        inc %i 
      }
      if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,skipinatwin) != 1 ) && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 IMDb-Skip 15halted $strip(%rls,ruc) @7 %srcsite >3 %dessite -15 Not.found/rated }
      if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) && ( %dtsrcchk != 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 IMDb-Skip 15halted $strip(%rls,ruc) @7 %srcsite >3 %dessite -15 Not.found/rated }
      set %dttradetrigger 0
    } 
    inc %db
  }
  :imdbcheckend
  unset %imdbrating | unset %imdballow | unset %imdballowv | unset %imdbvotes
}
alias yearcheckmsg {
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 )  { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto yearmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 YearSkip 15halted %desdir 14 %rls @7 %srcsite >3 %dessite 14- %dtentry $+ + 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 YearSkip 15halted %srcdir 15 %rls 15@7 %srcsite >3 %dessite 14- %dtentry $+ + 7 $+ $replace(%dtsrcchk,1,$chr(176)) } } 
  :yearmsgend
}
alias tvragecheckmsg { 
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto tvragemsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Tvmaze-Skip 15halted %desdir 14 %rls @7 %srcsite >3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 TVMaze-Skip 15halted %srcdir 15 %rls 15@7 %srcsite >3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } } 
  :tvragemsgend
}
alias foreignchkmmsg {
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto foreignmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 ForeignCheck 15halted %srcdir 14 %rls @ 7 %srcsite } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 ForeignCheck 15halted %srcdir 15 %rls @ 7 %srcsite } } 
  :foreignmsgend
}
alias globalchkmsg { 
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto globalmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 GlobalBlacklist 15halted %srcdir 14 %rls @7 %srcsite to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 GlobalBlacklist 15halted %srcdir 15 %rls 15@7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } } 
  :globalmsgend
}
alias ecp2chkmsg {
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto blackerlistmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Black $+ 15er $+ 14list 15halted %srcdir ( $+ %secname $+ ) 14 %rls from7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Black $+ er $+ 14list 15halted %srcdir ( $+ %secname $+ ) 14 %rls from7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } }
  :blackerlistmsgend
}  
alias ecp0chkmsg {
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto blackestlistmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Black $+ 15est14list 15halted %srcdir ( $+ %secname $+ ) 14 %rls from 7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Black $+ 15est14list 15halted %srcdir ( $+ %secname $+ ) 15 %rls 15from7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } }
  :blackestlistmsgend
}  
alias ecpchkmsg {
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto blacklistmsgend } }  
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Blacklist 15halted %srcdir ( $+ %secname $+ ) 14 %rls from7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Blacklist 15halted %srcdir ( $+ %secname $+ ) 15 %rls from7 %srcsite 14to3 %dessite 14- %dtentry 7 $+ $replace(%dtsrcchk,1,$chr(176)) } } 
  :blacklistmsgend
}  
alias secchkmsg { 
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto secmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Sectionskip 15halted 15 %srcdir ( $+ %secname $+ ) 14 %rls from7 %srcsite 14to3 %dessite 14- %dtentry %redirect 7 $+ $replace(%dtsrcchk,1,$chr(176)) } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Sectionskip 15halted 15 %srcdir ( $+ %secname $+ ) 14 %rls 15from7 %srcsite 14to3 %dessite 14- %dtentry %redirect 7 $+ $replace(%dtsrcchk,1,$chr(176)) } }  
  :secmsgend
}
alias affchkmsg { 
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto affmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Affilskip 15halted $remove(%dtentry,-) in %secname 14 %rls from7 %srcsite  14to3 %dessite } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14 Affilskip 15halted $remove(%dtentry,-) in %secname 15 %rls 14from7 %srcsite 14to3 %dessite } }
  :affmsgend
}
alias banchkmsg { 
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto banmsgend } }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp 14 Banned.Group halted %dtentry 14 %rls from7 %srcsite 14to3 %dessite } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp 14Banned.Group halted %dtentry 15 %rls 15from7 %srcsite 15to3 %dessite } }
  :banmsgend  
}
alias bfmsg {
  if ( $readini(d-tool\d-tool.ini,vars,skipspam) == 1 ) || ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1  &&  $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) { if ( mp3 isin %secname || day isin %secname || flac isin %secname || imageset isin %secname || pay isin %secname ) { goto bfmsgend } } 
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) { window -zkbD @d-tool_at font $readini(d-tool\d-tool.ini,vars,atfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_at $timestamp %dlighbfmsg | unset %dlighbfmsg } | else { window -zkbD @d-tool_skip font $readini(d-tool\d-tool.ini,vars,skipfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_skip $timestamp %dlighbfmsg | unset %dlighbfmsg } } 
  :bfmsgend
}
alias reqsearch {
  if ( $readini(d-tool\d-tool.ini,vars,cbreqsearch) == 1 ) { set %dtreqitem $1 | set %dtcbreqsearchs 1 | set %dtreqcount 1 | dcbs all $1 }
  else {
    set %dtreqitem $1 | set %dtreqs 1 | set %dtreqcount 1
    if ( - !isin %dtreqitem ) halt
    while ( %dtreqs <= $readini(d-tool\d-tool.ini,sites,count) ) {
      if ( $readini(d-tool\d-tool.req.db,%dtreqitem,reqsite) != $readini(d-tool\d-tool.ini,sites,%dtreqs) ) {
        var %b = $readini(d-tool\d-tool.ini,sites,%dtreqs) | var %bini = $readini(d-tool\d-tool.ini,sites,%dtreqs) $+ .ini 
        if ( $readini(d-tool\inis\ $+ %bini,%b,status) == 1 ) {
          dll d-tool\rushmirc.dll SetMircCmd /req_result 
          dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ %b $+ ', ' $+ site search %dtreqitem $+ ', RS_ONE or RS_LOGIN or RS_LOGOUT) 
        }
      }
      inc %dtreqs
    }
  }
  .timer 1 6 reqfill | .timer 1 10 reqfill | .timer 1 14 reqfill | .timer 1 18 reqfill
}
alias req_result {
  if ( / $+ %dtreqitem isin $3 ) && ( $2 == 200- ) && ( nuke !isin $3 ) && ( /sample !isin $3- ) && ( no-sfv !isin $3- ) && ( /proof !isin $3- ) && ( /Subs !isin $3- ) && ( /DVD !isin $3- ) && ( /Disc !isin $3- ) && ( /Covers !isin $3- ) && ( /CD !isincs $3- ) && ( incomplete !isin $3- ) && ( ###### !isin $3- ) && ( imdb !isin $3- ) {
    if ( / $+ %dtreqitem $+ / !isin $3 ) { var %reqn = $remove($1,$chr(41),$chr(40)) | var %reqnini = %reqn $+ .ini | if ( $readini(d-tool\inis\ $+ %reqnini,%reqn,reqfill) == 1 ) && ( %reqn != $readini(d-tool\d-tool.req.db,%reqrls,reqsite)  ) { writeini -n d-tool\d-tool.req.db %dtreqitem %dtreqcount $+ site %reqn | writeini -n d-tool\d-tool.req.db %dtreqitem %dtreqcount $+ path $3 } }
    inc %dtreqcount
  }
}
alias reqfill {
  var %nr = 1 | while ( %nr <= %dtreqcount ) {
    if ( $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ site) ) && ( $readini(d-tool\d-tool.req.db,%dtreqitem,reqsite) ) && ( $readini(d-tool\d-tool.req.db,%dtreqitem,reqsite) != $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ site) ) {
      var %reqrsn = $readini(d-tool\d-tool.req.db,%dtreqitem,reqsite) | var %reqsn = $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ site)
      if ( $readini(d-tool/inis/ $+ %reqrsn $+ .ini,%reqrsn,location) != $null ) && ( $readini(d-tool/inis/ $+ %reqsn $+ .ini,%reqsn,location) != $null ) && ( $readini(d-tool/d-tool.ini,vars,reqloc) == 1 ) { 
        if ( $readini(d-tool/inis/ $+ %reqrsn $+ .ini,%reqrsn,location) != $readini(d-tool/inis/ $+ %reqsn $+ .ini,%reqsn,location) ) {
          if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) { if ( $window(@d-tool_req) ) { aline -p @d-tool_req 15 $timestamp  %reqsn is wrong location } | else { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_req 15 $timestamp  %reqsn is wrong location } } | goto nofill 
        }
      } 
      reqcount 
      var %z = 1 | while ( %z <= %dtreqcount ) { if ( $readini(d-tool\d-tool.req.db,items,%z) == %dtreqitem ) var %tmps = 1 | inc %z } | if ( %tmps != 1 ) writeini -n d-tool\d-tool.req.db items $readini(d-tool\d-tool.req.db,items,count) %dtreqitem 
      if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) {
        sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %reqsn $remove($readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ path),%dtreqitem) %dtreqitem %reqrsn $readini(d-tool\d-tool.req.db,%dtreqitem,reqpath) $+ / %dtreqitem 
        set %dtwindowcount cb | if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) { if ( $window(@d-tool_req) ) { aline -p @d-tool_req 15 %dtwindowcount  $+ $timestamp 15 Reqfill:15 %reqsn > %reqrsn  %dtreqitem  | aline -p @d-tool_req $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ path) > $readini(d-tool\d-tool.req.db,%dtreqitem,reqpath) } | else { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_req 15 %dtwindowcount  $+ $timestamp 15 Reqfill:15 %reqsn > %reqrsn  %dtreqitem  | aline -p @d-tool_req $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ path) > $readini(d-tool\d-tool.req.db,%dtreqitem,reqpath) } }
      }    
      else { var %rf = 1 | while ( %rf <= $readini(d-tool\d-tool.ini,vars,reqfillslots) ) {
          windowcount
          dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( $+ %dtwindowcount $+ , ' $+ %reqsn $+ ', ' $+ $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ path) $+ ', '', ' $+ %reqrsn $+ ', ' $+ $readini(d-tool\d-tool.req.db,%dtreqitem,reqpath) $+ / $+ %dtreqitem $+ ', '',RS_DIRDES or RS_DIRSRC, '', '', '', '', ' $+ $readini(d-tool\d-tool.ini,vars,completeline) $+ ', 200, 0, 0, 0, 0, 3, 0);       
          if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) { if ( $window(@d-tool_req) ) { aline -p @d-tool_req 15 %dtwindowcount  $+ $timestamp 15 Reqfill:15 %reqsn > %reqrsn  %dtreqitem  | aline -p @d-tool_req $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ path) > $readini(d-tool\d-tool.req.db,%dtreqitem,reqpath) } | else { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_req 15 %dtwindowcount  $+ $timestamp 15 Reqfill:15 %reqsn > %reqrsn  %dtreqitem  | aline -p @d-tool_req $readini(d-tool\d-tool.req.db,%dtreqitem,%nr $+ path) > $readini(d-tool\d-tool.req.db,%dtreqitem,reqpath) } }
          inc %rf
        }
      }
      remini d-tool\d-tool.req.db %dtreqitem %nr $+ site | remini d-tool\d-tool.req.db %dtreqitem %nr $+ path
    }
    :nofill
    inc %nr
  }
  unset %reqnick | unset %reqrls
}
alias incsearch {
  if ( $lines(d-tool/d-tool.inc.db) > 200 ) .remove d-tool/d-tool.inc.db
  if ( $readini(d-tool\d-tool.ini,vars,cbreqsearch) == 1 ) { set %dtincitem $1 | set %dtcbincsearchs 1 | set %dtinccount 1 | set %dtincsite $2 | dcbs all $1 }
  else {
    set %dtincitem $1 | set %dtincs 1 | set %dtinccount 1 | set %dtincsite $2
    if ( - isin %dtincitem ) {
      while ( %dtincs <= $readini(d-tool\d-tool.ini,sites,count) ) {
        var %b = $readini(d-tool\d-tool.ini,sites,%dtincs) | var %bini = $readini(d-tool\d-tool.ini,sites,%dtincs) $+ .ini 
        if ( $readini(d-tool\inis\ $+ %bini,%b,status) == 1 ) {
          dll d-tool\rushmirc.dll SetMircCmd /inc_result 
          dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ %b $+ ', ' $+ site search %dtincitem $+ ', RS_ONE or RS_LOGIN or RS_LOGOUT) 
        }
        inc %dtincs
      }
    }
  }
  var %rtz = 1 | while ( %rtz <= $numtok($readini(d-tool\d-tool.ini,vars,inctimes),59) ) { .timer 1 $gettok($readini(d-tool\d-tool.ini,vars,inctimes),%rtz,59) incfill | inc %rtz }
}
alias inc_result { 
  if ( / isin $3 ) && ( $2 == 200- ) && ( nuke !isin $3 ) && ( /sample !isin $3- ) && ( no-sfv !isin $3- ) && ( /proof !isin $3- ) && ( /Subs !isin $3- ) && ( /DVD !isin $3- ) && ( /Disc !isin $3- ) && ( /Covers !isin $3- ) && ( /CD !isincs $3- ) && ( incomplete !isin $3- ) && ( ###### !isin $3- ) && ( imdb !isin $3- ) { 
    var %incn = $remove($1,$chr(41),$chr(40)) | var %incnini = %incn $+ .ini 
    if ( %incn != %dtincsite ) && ( $readini(d-tool\inis\ $+ %incnini,%incn,incfill) == 1 ) { writeini -n d-tool\d-tool.inc.db %dtincitem %dtinccount $+ site %incn | writeini -n d-tool\d-tool.inc.db %dtincitem %dtinccount $+ path $3 } 
    if ( %dtincsite isin %incn ) { writeini -n d-tool\d-tool.inc.db %dtincitem incpath $3 | writeini -n d-tool\d-tool.inc.db %dtincsite incsite %dtincsite | if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) { if ( $window(@d-tool_inc) ) { aline -p @d-tool_inc $date $timestamp 7 Inc:15 %incsn > %incrsn  %dtincitem  $3 } | else { window -zkbD @d-tool_inc font $readini(d-tool\d-tool.ini,vars,incfsize) | aline -p @d-tool_inc 15 %dtwindowcount  $+ $date $timestamp 7 Inc:15 %incsn > %incrsn  %dtincitem  $3 } } }
    inc %dtinccount
  }
}
alias incfill {
  var %nr = 1 | while ( %nr <= %dtinccount ) {
    if ( $readini(d-tool\d-tool.inc.db,%dtincitem,%nr $+ site) ) && ( $readini(d-tool\d-tool.inc.db,%dtincitem,incsite) ) && ( $readini(d-tool\d-tool.inc.db,%dtincitem,incsite) != $readini(d-tool\d-tool.inc.db,%dtincitem,%nr $+ site) ) {
      var %incrsn = $readini(d-tool\d-tool.inc.db,%dtincitem,incsite) | var %incsn = $readini(d-tool\d-tool.inc.db,%dtincitem,%nr $+ site)
      if ( $readini(d-tool/inis/ $+ %incrsn $+ .ini,%incrsn,location) != $null ) && ( $readini(d-tool/inis/ $+ %incsn $+ .ini,%incsn,location) != $null ) && ( $readini(d-tool/d-tool.ini,vars,incloc) == 1 ) { 
        if ( $readini(d-tool/inis/ $+ %incrsn $+ .ini,%incrsn,location) != $readini(d-tool/inis/ $+ %incsn $+ .ini,%incsn,location) ) {
          if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) { if ( $window(@d-tool_inc) ) { aline -p @d-tool_inc 15 $timestamp  %incsn is wrong location } | else { window -zkbD @d-tool_inc font $readini(d-tool\d-tool.ini,vars,incfsize) | aline -p @d-tool_inc 15 $timestamp  %incsn is wrong location } } | goto nofill2 
        }
      } 
      inccount | var %z = 1 | while ( %z <= %dtinccount ) { if ( $readini(d-tool\d-tool.inc.db,items,%z) == %dtincitem ) var %tmps2 = 1 | inc %z } | if ( %tmps2 != 1 ) writeini -n d-tool\d-tool.inc.db items $readini(d-tool\d-tool.inc.db,items,count) %dtincitem
      if ( $readini(d-tool\d-tool.inc.db,%dtincitem,incpath) ) {
        if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) { sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %incsn $readini(d-tool\d-tool.inc.db,%dtincitem,%nr $+ path) $+ / %dtincitem %incrsn / $+ $readini(d-tool\d-tool.inc.db,%dtincitem,incpath) $+ / %dtincitem }
        else {
          windowcount
          dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( $+ %dtwindowcount $+ , ' $+ %incsn $+ ', ' $+ $readini(d-tool\d-tool.inc.db,%dtincitem,%nr $+ path) $+ ', '', ' $+ %incrsn $+ ', ' $+ $readini(d-tool\d-tool.inc.db,%dtincitem,incpath) $+ ', '',RS_DIRDES or RS_DIRSRC, '', '', '', '', ' $+ $readini(d-tool\d-tool.ini,vars,completeline) $+ ', 200, 0, 0, 0, 0, 3, 0);       
        }   
        if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) { if ($window(@d-tool_inc)) { aline -p @d-tool_inc 15 %dtwindowcount  $timestamp 7 Incfill:15 %incsn > %incrsn  %dtincitem  } | else { window -zkbD @d-tool_inc font $readini(d-tool\d-tool.ini,vars,incfsize) | aline -p @d-tool_inc 15 %dtwindowcount  $timestamp 7 Incfill:15 %incsn > %incrsn  %dtincitem } }
        remini d-tool\d-tool.inc.db %dtincitem %nr $+ site | remini d-tool\d-tool.inc.db %dtincitem %nr $+ path
      }
    }
    :nofill2
    inc %nr
  }
  ; unset %incrls
} 
alias inccount { if ( $readini(d-tool\d-tool.inc.db,items,count) < 5 ) { writeini -n d-tool\d-tool.inc.db items count $calc($readini(d-tool\d-tool.inc.db,items,count) +1) } | else writeini -n d-tool\d-tool.inc.db items count 1 }
alias reqcount { if ( $readini(d-tool\d-tool.req.db,items,count) < 15 ) { writeini -n d-tool\d-tool.req.db items count $calc($readini(d-tool\d-tool.req.db,items,count) +1) } | else writeini -n d-tool\d-tool.req.db items count 1 } 
alias windowcount { if ( %dtwindowcount == $null ) { set %dtwindowcount $readini(d-tool\d-tool.ini,vars,winstart) } | elseif ( %dtwindowcount >= $calc($readini(d-tool\d-tool.ini,vars,ratwin) + $readini(d-tool\d-tool.ini,vars,winstart) - 1) ) { set %dtwindowcount $readini(d-tool\d-tool.ini,vars,winstart) } | else { inc %dtwindowcount } }
alias dt { if ( %dtmt == $null ) || ( %dtmt == m ) { if (!$dialog(dtool-main)) dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-main dtool-main | elseif ($dialog(dtool-main)) dialog -x dtool-main dtool-main } | if ( %dtmt == s ) { if (!$dialog(dtool-small)) dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-small dtool-small | elseif ($dialog(dtool-small)) dialog -x dtool-small dtool-small } }
alias dton { if ( $readini(d-tool\d-tool.ini,vars,status) == off ) { writeini -n d-tool\d-tool.ini vars status on | echo $active 15 d-tool activated | if ( $dialog(dtool-main) ) { did -c dtool-main 3 } | if ( $dialog(dtool-small) ) { did -c dtool-small 3 } } }
alias dtoff { if ( $readini(d-tool\d-tool.ini,vars,status) == on ) { writeini -n d-tool\d-tool.ini vars status off | echo $active 15 d-tool deactivated | if ( $dialog(dtool-main) ) { did -u dtool-main 3 } | if ( $dialog(dtool-small) ) { did -u dtool-small 3 } } }
alias at { if ( %dttrade == 1 ) { unset %dttrade | echo $active 15 Autotrading deactivated | if ( $dialog(dtool-main) ) { did -u dtool-main 4 } | if ( $dialog(dtool-small) ) { did -u dtool-small 4 } } | elseif ( %dttrade == $null ) { set %dttrade 1 | echo $active 15 Autotrading activated | if ( $dialog(dtool-main) ) { did -c dtool-main 4 } | if ( $dialog(dtool-small) ) { did -c dtool-small 4 } } }
alias dtl { set %dtloadsite $remove($1,$chr(40),$chr(41)) | set %dtitem1 $2 | set %dtitem2 $eval($replace($2,/,$chr(32)),3) | dtload %dtitem2 }
alias dtload {
  if ( *.*.*-* iswm $1 || *_*_*-* iswm $1 ) { set %dtitem2 $1 } | if ( *.*.*-* iswm $2 || *_*_*-* iswm $2 ) { set %dtitem2 $2 } | if ( *.*.*-* iswm $3 || *_*_*-* iswm $3 ) { set %dtitem2 $3 } | if ( *.*.*-* iswm $4 || *_*_*-* iswm $4 ) { set %dtitem2 $4 } | if ( *.*.*-* iswm $5 || *_*_*-* iswm $5 ) { set %dtitem2 $5 } | if ( *.*.*-* iswm $6 || *_*_*-* iswm $6 ) { set %dtitem2 $6 } | if ( *.*.*-* iswm $7 || *_*_*-* iswm $7 ) { set %dtitem2 $7 }
  if ( $readini(d-tool\d-tool.ini,vars,cbftpload) == 1 ) sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) download %dtloadsite %dtitem1
  else dll d-tool\rushmirc.dll RushScript RushApp.FTP.Transfer( 0, ' $+ %dtloadsite $+ ', ' $+  %dtitem1 $+ ', '', '', ' $+ %dtdldir $+ %dtitem2 $+ ', '', RS_DOWN or RS_DIRDES or RS_DIRSRC or RS_LOGOUT, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0);
  unset %dtitem1 | unset %dtitem2 | unset %dtloadsite
}
alias dtedit run d-tool\d-tool.ini
alias dtoolwin { if ($window(@d-tool)) { window -c @d-tool | halt } | if ( $readini(d-tool\d-tool.ini,vars,dtoolwin) == d ) { window -aezfkdb $readini(d-tool\d-tool.ini,vars,seriesborder) @d-tool font $readini(d-tool\d-tool.ini,vars,searchfsize) iconfile d-tool\logo\dtool.ico } | else { window -aezfkbD $readini(d-tool\d-tool.ini,vars,seriesborder) @d-tool font $readini(d-tool\d-tool.ini,vars,searchfsize) iconfile d-tool\logo\dtool.ico } | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) @d-tool }
alias dtpres { 
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool
  var %z = 1 | while ( %z <= 180 ) {
    if ( %z == 1 ) aline -p @d-tool $timestamp Pretime 1 ( $+ $calc($readini(d-tool\d-tool.ini,vars,pretime1) / 60 ) $+ min/ $+ $readini(d-tool\d-tool.ini,vars,pretime1) $+ sec): | if ( %z == 61 ) aline -p @d-tool $timestamp Pretime 2 ( $+ $calc($readini(d-tool\d-tool.ini,vars,pretime2) / 60 ) $+ min/ $+ $readini(d-tool\d-tool.ini,vars,pretime2) $+ sec): | if ( %z == 121 ) aline -p @d-tool $timestamp Pretime 3 ( $+ $calc($readini(d-tool\d-tool.ini,vars,pretime3) / 60 ) $+ min/ $+ $readini(d-tool\d-tool.ini,vars,pretime3) $+ sec):
    if ($eval(% $+ dtprenr $+ %z,2)) {
    aline -p @d-tool $timestamp Bot $gettok($eval(% $+ dtprenr $+ %z,2),2,32) ( $+ $readini(d-tool\d-tool.ini,vars,prebot $+ $gettok($eval(% $+ dtprenr $+ %z,2),2,32) $+ ) $+ )  $gettok($eval(% $+ dtprenr $+ %z,2),1,32) $gettok($eval(% $+ dtprenr $+ %z,2),3,32) }
    inc %z
  }
}
alias dtinfo {
  if ($timer(login)) { var %dtr = on' | writeini d-tool\d-tool.ini vars logintimers 1 } | else { var %dtr = off' | writeini d-tool\d-tool.ini vars logintimers 0 } | if ( %dtpreoff == 1 ) var %pstat = off | else var %pstat = on
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool d-tool info 14( $+ $remove($read(d-tool\d-tool.mrc,2),;,$chr(32),d-tool,.v) runs $uptime(mirc,2) $+ ) - 14loginchk: [lm+strg] sync.target: [rm+strg] sync.source: [rm+shift]
  aline -p @d-tool status $readini(d-tool\d-tool.ini,vars,status)  $+ $chr(8226) at $replace(%dttrade,1,on,0,off)  $+ $chr(8226) affils $replace(%dtaffils,1,on,0,off)  $+ $chr(8226) precheck %pstat  $+ $chr(8226) reqs $replace(%dtreqfill,1,on,0,off)  $+ $chr(8226) tvmaze $replace($readini(d-tool\d-tool.ini,vars,tv),1,on)  $+ $chr(8226) imdb $replace($readini(d-tool\d-tool.ini,vars,imdbs),1,on)  $+ $chr(8226) incs $replace(%dtincfill,1,on,0,off)  $+ $chr(8226) login $replace(%dtr,on,3on,off,7off) ( $+ $readini(d-tool\d-tool.ini,vars,logintimer) $+ h) 
  var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %b = $readini(d-tool\d-tool.ini,sites,%a) | var %bini = %b $+ .ini
    var %q = 1 | while ( %q <= $readini(d-tool\d-tool.ini,sites,count) ) {
      var %w = $readini(d-tool\d-tool.ini,sites,%q) | var %wini = %w $+ .ini
      if ( $readini(d-tool\inis\ $+ %wini,%w,fillsite) == %b ) && ( %b != %w ) && ( $readini(d-tool\inis\ $+ %wini,%w,status) == 1 ) && ( $readini(d-tool\inis\ $+ %wini,%w,loginstatus) == 1 ) { set % $+ sitefillers $+ %b $eval(% $+ sitefillers $+ %b,3) %w }
      var %f = 1 | while ( %f <= 9 ) {
        if ( $readini(d-tool\inis\ $+ %wini,%w,fillsite $+ %f) == %b ) && ( %b != %w ) && ( $readini(d-tool\inis\ $+ %wini,%w,status) == 1 ) && ( $readini(d-tool\inis\ $+ %wini,%w,loginstatus) == 1 ) { set % $+ sitefillers $+ %b $eval(% $+ sitefillers $+ %b,3) %w }
        inc %f
      }
      inc %q
    }
    inc %a
  }
  var %q = 1 | while ( %q <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %w = $readini(d-tool\d-tool.ini,sites,%q) | var %wini = $readini(d-tool\d-tool.ini,sites,%q) $+ .ini | if ($readini(d-tool\inis\ $+ %wini,%w,desc)) var %desc = ( $+ $readini(d-tool\inis\ $+ %wini,%w,desc) $+ ) | else unset %desc
    if ($eval(% $+ sitefillers $+ %w,2)) var %fillers =  $eval(% $+ sitefillers $+ %w,2) / | else set %fillers  none /
    if ( $readini(d-tool\inis\ $+ %wini,%w,status) == 1 ) var %msg = 3on | else var %msg = 7off
    if ( $readini(d-tool\inis\ $+ %wini,%w,loginstatus) == 1 ) var %msgl = 3ok | else var %msgl = 7fail
    if ( $readini(d-tool\inis\ $+ %wini,%w,reqfill) == 1 ) var %reqfill = - reqfills 3on | else var %reqfill = - reqfills 7off
    if ( $readini(d-tool\inis\ $+ %wini,%w,incget) == 1 ) var %incg = - incget 3on | else var %incg = - incget 7off | if ( $readini(d-tool\inis\ $+ %wini,%w,incfill) == 1 ) var %incf = - incfill 3on | else var %incf = - incfill 7off
    var %affilsites = $readini(d-tool\inis\ $+ %wini,%w,affsite) $readini(d-tool\inis\ $+ %wini,%w,affsite1) $readini(d-tool\inis\ $+ %wini,%w,affsite2) $readini(d-tool\inis\ $+ %wini,%w,affsite3) $readini(d-tool\inis\ $+ %wini,%w,affsite4) $readini(d-tool\inis\ $+ %wini,%w,affsite5) $readini(d-tool\inis\ $+ %wini,%w,affsite6) $readini(d-tool\inis\ $+ %wini,%w,affsite7) $readini(d-tool\inis\ $+ %wini,%w,affsite8) $readini(d-tool\inis\ $+ %wini,%w,affsite9)
    if ( $readini(d-tool\inis\ $+ %wini,%w,fillsite) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite1) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite2) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite3) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite4) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite5) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite6) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite7) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite8) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite9) ) { 
      aline -p @d-tool %q $+  %w $+ . $+ $chr(8226) $+ 3 $+ %fillers 7 $+ $readini(d-tool\inis\ $+ %wini,%w,fillsite) $readini(d-tool\inis\ $+ %wini,%w,fillsite1) $readini(d-tool\inis\ $+ %wini,%w,fillsite2) $readini(d-tool\inis\ $+ %wini,%w,fillsite3) $readini(d-tool\inis\ $+ %wini,%w,fillsite4) $readini(d-tool\inis\ $+ %wini,%w,fillsite5) $readini(d-tool\inis\ $+ %wini,%w,fillsite6) $readini(d-tool\inis\ $+ %wini,%w,fillsite7) $readini(d-tool\inis\ $+ %wini,%w,fillsite8) $readini(d-tool\inis\ $+ %wini,%w,fillsite9) (3 $replace($readini(d-tool\inis\ $+ %wini,%w,cbsources),$chr(44),$chr(32)) /7 $replace($readini(d-tool\inis\ $+ %wini,%w,cbtargets),$chr(44),$chr(32)) ) - status %msg login %msgl - affils to3  %affilsites  $+ %reqfill %incg %incf %desc 
    }
    else aline -p @d-tool %q $+  %w $+ . $+ $chr(8226) $+ 3 $+ %fillers none (3 $replace($readini(d-tool\inis\ $+ %wini,%w,cbsources),$chr(44),$chr(32)) /7 $replace($readini(d-tool\inis\ $+ %wini,%w,cbtargets),$chr(44),$chr(32)) ) - status %msg login %msgl - affils to3 %affilsites  $+ %reqfill %incg %incf %desc
    inc %q
  }
  unset %sitefillers* | unset %fillers
}
alias dtm if ($dialog(dlmenu)) dialog -x dlmenu dlmenu | else dialog $readini(d-tool\d-tool.ini,vars,mdesktop) dlmenu dlmenu 
alias dtqt { if ( %dtrushqtimer ) { .timerqueue 0 $calc(%dtrushqtimer * 3600) dtq } }
alias dtlt { 
  if ( $readini(d-tool\d-tool.ini,vars,logintimers) == 1 ) && ( $1 != a ) { writeini -n d-tool\d-tool.ini vars logintimers 0 | .timerlogin off }
  elseif ( $readini(d-tool\d-tool.ini,vars,logintimers) != 1 ) || ( $1 == a ) {
    if ($readini(d-tool\d-tool.ini,vars,logintimer)) { .timerlogin 0 $calc($readini(d-tool\d-tool.ini,vars,logintimer) * 3600) dtlogin } | writeini -n d-tool\d-tool.ini vars logintimers 1
  }
}
alias dtq { if ( $dll(d-tool\rushmirc.dll,Invoke,RushApp.Containers.TransferSiteCount) == 0 ) { dll d-tool\rushmirc.dll RushScript RushApp.FTP.RemoveQueue('','','',RS_FAIL or RS_TRANSFER or RS_NORMAL or RS_WAITING); | if ($window(@d-tool)) aline -p @d-tool $timestamp 15 Queue from all Sites cleared | else { dtoolwin | aline -p @d-tool $timestamp 15 Queue from all Sites cleared } } | else .timerrushqueue 1 120 dtq }
alias ecpcheck {
  var %i = 1 | var %blentry = $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry)
  while ( %i <= %blentry ) {
    if $did(dtool-rules,%dtbutton).seltext == $readini(d-tool\inis\ $+ %dtsiteini,black,%i) { set %dttemp %i }
    inc %i
  }
}
alias whitecheck {
  var %i = 1 | var %wlistentry = $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry)
  while ( %i <= %wlistentry ) {
    if $did(dtool-rules,%dtbutton).seltext == $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %i) { set %dttemp w $+ %i }
    inc %i
  }
}
alias affcheck {
  var %i = 1 | var %aentrys = $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys)
  while ( %i <= %aentrys ) {
    if $did(dtool-rules,%dtbutton).seltext == $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %i) { set %dttemp a $+ %i }
    inc %i
  }
}
alias gblackcheck {
  var %i = 1 | var %gblistentry = $readini(d-tool\d-tool.ini,vars,gblistentry)
  while ( %i <= %gblistentry ) {
    if $did(blist,1).seltext == $readini(d-tool\d-tool.ini,vars,ecp $+ %i) { set %dttemp ecp $+ %i }
    inc %i
  }
}
alias gwhitecheck {
  var %i = 1 | var %gwlistentry = $readini(d-tool\d-tool.ini,vars,gwlistentry)
  while ( %i <= %gwlistentry ) {
    if $did(wlist,1).seltext == $readini(d-tool\d-tool.ini,vars,gw $+ %i) { set %dttemp gw $+ %i }
    inc %i
  }
}
alias siterefresh { remini d-tool\d-tool.ini sites | var %l = $lines(d-tool\d-tool.ini) | var %q = 1 | var %n = 1 | while ( %q <= %l ) { if ( [ isin $read(d-tool\d-tool.ini,%q) ) && ( = !isin $read(d-tool\d-tool.ini,%q) ) && ( [vars !isin $read(d-tool\d-tool.ini,%q) ) && ( [rage !isin $read(d-tool\d-tool.ini,%q) ) && ( [matches !isin $read(d-tool\d-tool.ini,%q) ) { writeini -n d-tool\d-tool.ini sites %n $remove($read(d-tool\d-tool.ini,%q),[,]) | inc %n } | inc %q } | writeini -n d-tool\d-tool.ini sites count $calc(%n - 1) }
alias presetrefresh { remini d-tool\presets.ini presets | var %l = $lines(d-tool\presets.ini) | var %q = 1 | var %n = 1 | while ( %q <= %l ) { if ( [ isin $read(d-tool\presets.ini,%q) ) && ( = !isin $read(d-tool\presets.ini,%q) ) { writeini -n d-tool\presets.ini presets %n $remove($read(d-tool\presets.ini,%q),[,]) | inc %n } | inc %q } | writeini -n d-tool\presets.ini presets count $calc(%n - 1) }
alias listrefresh {
  var %n = 1 | while ( %n <= 200 ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,black,%n) ) { writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite blistentry %n }
    inc %n
  }
  did -r dtool-rules 64 | did -a dtool-rules 64 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry)
  did -r dtool-rules %dtbutton | var %i = 1
  while ( %i <= $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry) ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,black,%i) ) { did -a dtool-rules %dtbutton $readini(d-tool\inis\ $+ %dtsiteini,black,%i) }
    inc %i
  }
}
alias listrefresh1 {
  var %n = 1 | while ( %n <= 200 ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %n) ) { writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite aentrys %n }
    inc %n
  }
  did -r dtool-rules 90 | did -a dtool-rules 90 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys)
  did -r dtool-rules %dtbutton | var %i = 1
  while ( %i <= $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys) ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %i) ) { did -a dtool-rules %dtbutton $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %i) }
    inc %i
  }
}
alias listrefresh2 {
  var %n = 1 | while ( %n <= 200 ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %n) ) { writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite wlistentry %n }
    inc %n
  }
  did -r dtool-rules 66 | did -a dtool-rules 66 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry)
  did -r dtool-rules %dtbutton | var %i = 1
  while ( %i <= $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry) ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %i) ) { did -a dtool-rules %dtbutton $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %i) }
    inc %i
  }
}
alias listrefresh3 {
  if ( $dialog(wlist) ) { did -r wlist 1 } | var %i = 1 | var %gwlistentry = $readini(d-tool\d-tool.ini,vars,gwlistentry)
  while ( %i <= %gwlistentry ) {
    if ( $readini(d-tool\d-tool.ini,vars,gw $+ %i) ) { did -a wlist 1 $readini(d-tool\d-tool.ini,vars,gw $+ %i) }
    inc %i
  }
}
alias listrefresh4 {
  did -r dlight 800 | set %tempsearch $remove($read(d-tool\d-tool.ini, w, [ $+ *),[,]) | if ( 1 isin %tempsearch ) || ( 2 isin %tempsearch ) || ( 3 isin %tempsearch ) || ( 4 isin %tempsearch ) || ( 5 isin %tempsearch ) || ( 6 isin %tempsearch ) || ( vars isin %tempsearch ) { goto again1 } | else did -a dlight 800 %tempsearch
  :again1
  set %linenumber $readn | set %tempsearch $remove($read(d-tool\d-tool.ini, w, [ $+ * , $calc(%linenumber + 1 )),[,]) |  if ( 1 isin %tempsearch ) || ( 2 isin %tempsearch ) || ( 3 isin %tempsearch ) || ( 4 isin %tempsearch ) || ( 5 isin %tempsearch ) || ( 6 isin %tempsearch ) || ( vars isin %tempsearch ) { goto again1 } | else did -a dlight 800 %tempsearch
  if ( $read(d-tool\d-tool.ini, w, [ $+ * , $calc(%linenumber + 1 )) == $null ) { halt } | else { goto again1 } 
}
alias listrefresh5 {
  if ( $dialog(blist) ) { did -r blist 1 } | var %i = 1 | var %gblistentry = $readini(d-tool\d-tool.ini,vars,gblistentry)
  while ( %i <= %gblistentry ) {
    if ( $readini(d-tool\d-tool.ini,vars,ecp $+ %i) ) { did -a blist 1 $readini(d-tool\d-tool.ini,vars,ecp $+ %i) }
    inc %i
  }
}
alias listrefreshsec {
  did -r dsections 1 | var %a = 1 | while ( %a <= $readini(d-tool\sections.ini,name,count) ) { if ($readini(d-tool\sections.ini,name,%a)) { if ( $len(%a) == 1 ) did -a dsections 1 0 $+ %a $readini(d-tool\sections.ini,name,%a)  | else did -a dsections 1 %a $readini(d-tool\sections.ini,name,%a) } | inc %a }
}
alias seccountrefresh {
  var %a = 1 | while ( %a <= $lines(d-tool\sections.ini) ) { 
    if ( count !isin $read(d-tool\sections.ini, %a) ) && ( name !isin $read(d-tool\sections.ini, %a) ) {
      if ( $regex($read(d-tool\sections.ini, %a),[0-9]) == 1 ) && (%b) { if ( $gettok($read(d-tool\sections.ini, %a),1,61) > %b ) var %b = $gettok($read(d-tool\sections.ini, %a),1,61) }  
      elseif ( $regex($read(d-tool\sections.ini, %a),[0-9]) == 1 ) && (!%b) { var %b = $gettok($read(d-tool\sections.ini, %a),1,61) }
    }
    inc %a
  }
  writeini -n d-tool\sections.ini name count %b
}
alias picklistrefresh {
  did -r picklist 1 | did -r picklist 10
  var %fu = 1 | while ( %fu <= $readini(d-tool\sections.ini,name,count) ) { if ($readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %fu)) && ( fake !isin $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %fu) ) did -a picklist 10 $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %fu) | inc %fu }
  var %f = 1 | while ( %f <= $lines(d-tool\picklist.db) ) { if ($read(d-tool\picklist.db, %f)) did -a picklist 1 $read(d-tool\picklist.db, %f) | inc %f }
}
alias saves { 
  set %tempsearch $remove($read(d-tool\d-tool.ini, w, [ $+ *),[,]) | if ( 1 isin %tempsearch ) || ( 2 isin %tempsearch ) || ( 3 isin %tempsearch ) || ( 4 isin %tempsearch ) || ( vars isin %tempsearch ) { goto again } | else echo $active %tempsearch
  :again
  set %linenumber $readn | set %tempsearch $remove($read(d-tool\d-tool.ini, w, [ $+ * , $calc(%linenumber + 1 )),[,]) |  if ( 1 isin %tempsearch ) || ( 2 isin %tempsearch ) || ( 3 isin %tempsearch ) || ( 4 isin %tempsearch ) || ( vars isin %tempsearch ) { goto again } | else echo $active %tempsearch
  if $read(d-tool\d-tool.ini, w, [ $+ * , $calc(%linenumber + 1 )) == $null { halt | unset %tempsearch } | else { goto again }
}
;;;;;;;;;;;;;;;;;;;;;HOTLINKS
on ^*:hotlink:>>>_/*:@:{ if ($mouse.key & 1) { clipboard $replace($1,>>>_,$chr(32)) | echo -a $replace($1,>>>_,$chr(32)) copied to clipboard } }
on ^*:hotlink:*_found*:@:{
  if ($mouse.key & 4) && ($mouse.key & 1) {
    dtgiveclipboard $replace($1,_found:_,$chr(32)) | echo -a text on clipboard: $cb
    if ( $input(Want to connect(rush)?,y,connect) == $true ) dll d-tool\rushmirc.dll RushScript RushApp.FTP.Login(' $+ $remove($gettok($1,1,95),$chr(40),$chr(41)) $+ ',' $+ $gettok($1,3-,95) $+ ',0)

  }
  elseif ($mouse.key & 1) && ($mouse.key & 2) {
    if ( $input(Want to download $replace($1,_found:_,$chr(32)) ?,y,download) == $true ) {
      if (!$readini(d-tool\d-tool.ini,vars,cbftpload)) && (!%dtdldir) set %dtdldir $sdir(/,Select Downloadfolder)
      dtl $replace($1,_found:_,$chr(32))
      aline -p @d-tool 15 Loading:3 $replace($1,_found:_,$chr(32)) 
    }
  }
} 
on ^*:hotlink:*.*-*:%dthlchans:{ 
  if ( http !isin $1- && www !isin $1- ) {
    if ($mouse.key & 1) && ($mouse.key & 2) {
      if ( $input(Search all Sites?!,y,d-tool ) == $true ) { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbs all $1 | else dsa $1 }
    }
    if ($mouse.key & 1) && ($mouse.key & 4) {
      if ( $input(Search Request?!,y,d-tool reqsearch) == $true ) { 
        if ( $right($1,1) == $chr(46) ) reqsearch $left($1,$calc( $len($1) - 1)) | else reqsearch $1 | if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,reqwinreq) == 1 ) { if ( !$window(@d-tool_req)) { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico } | aline -p @d-tool_req  manually searching $1 }
      }
    }
  }
}
on ^*:hotlink:*_*-*:%dthlchans:{ 
  if ( http !isin $1- && www !isin $1- ) {
    if ($mouse.key & 1) && ($mouse.key & 2) {
      if ( $input(Search all Sites?!,y,d-tool search) == $true ) { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbs all $1 | else dsa $1 } 
    }
    if ($mouse.key & 1) && ($mouse.key & 4) {
      if ( $input(Search Request?!,y,d-tool reqsearch) == $true ) { reqsearch $1 | if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) && ( $readini(d-tool\d-tool.ini,vars,reqwinreq) == 1 ) { if ( !$window(@d-tool_req)) { window -zkbD @d-tool_req font $readini(d-tool\d-tool.ini,vars,reqfsize) iconfile d-tool\logo\dtool.ico } | aline -p @d-tool_req  manually searching $1 }
      }
    }
  }
}
on ^*:hotlink:*_*-*:@:{ 
  if ( http !isin $1- && www !isin $1- ) {
    if ($mouse.key & 1) && ($mouse.key & 2) {
      if ( $input(Search all Sites?!,y,d-tool search) == $true ) { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbs all $1 | else dsa $1 } 
    }
  }
}
on ^*:hotlink:*.*-*:@:{ 
  if ( http !isin $1- && www !isin $1- ) {
    if ($mouse.key & 1) && ($mouse.key & 2) {
      if ( $input(Search all Sites?!,y,d-tool search) == $true ) { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbs all $1 | else dsa $1 } 
    }
    if ($mouse.key & 1) && ($mouse.key & 4) {
      if ( $input(Search Request?!,y,d-tool reqsearch) == $true ) { reqsearch $1 | aline -p @d-tool_req manually searching $1 }
    }
  }
}
on ^*:hotlink:*-*-*:@:{ 
  if ( http !isin $1- && www !isin $1- ) {
    if ($mouse.key & 1) && ($mouse.key & 2) {
      if ( $input(Search all Sites?!,y,d-tool search) == $true ) { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbs all $1 | else dsa $1 } 
    }
    if ($mouse.key & 1) && ($mouse.key & 4) {
      if ( $input(Search Request?!,y,d-tool reqsearch) == $true ) { reqsearch $1 | aline -p @d-tool_req manually searching $1 }
    }
  }
}
on ^*:hotlink:*.•*:@d-tool:{
  if ($mouse.key & 1) && ($mouse.key & 2) dtlogin $remove($1,.•) | elseif ($mouse.key & 1) dcbsite $remove($1,.•)
  if ($mouse.key & 2) && ($mouse.key & 16) && ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) { dtsitelist | var %fg = $input(Targetsites?,ev,set $remove($1,.•) targets in cbftp ,$remove(%dtslist,$remove($1,.•))) | if (%fg) dcbsync $remove($1,.•) t %fg | if (!%fg) { if ( $input(unset all?,y,Targets) == $true ) dcbsync $remove($1,.•) t } | unset %dtslist }
  if ($mouse.key & 4) && ($mouse.key & 16) && ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) { dtsitelist | var %fg = $input(Sourcesites?,ev,set $remove($1,.•) sources in cbftp ,$remove(%dtslist,$remove($1,.•))) | if (%fg) dcbsync $remove($1,.•) s %fg | if (!%fg) { if ( $input(unset all?,y,Sources) == $true ) dcbsync $remove($1,.•) s } | unset %dtslist }
}
on ^*:hotlink:*off'*:@d-tool:{
  if ($mouse.key & 1) { dtlt | dtinfo }
}
on ^*:hotlink:*on'*:@d-tool:{
  if ($mouse.key & 1) { dtlt | dtinfo }
}
alias dtsitelist {
  unset %dtslist | var %tf = 1 | while ( %tf <= $readini(d-tool\d-tool.ini,sites,count) ) {
    if (!%dtslist) set %dtslist $readini(d-tool\d-tool.ini,sites,%tf) | else set %dtslist %dtslist $readini(d-tool\d-tool.ini,sites,%tf)
    inc %tf
  }
}
alias dtgiveclipboard clipboard $2
;;;;;;;;;;;;;;;;;;;;;;;;;ELSE
on 1:input:@d-tool: { 
  if ( / !isin $1 ) { 
    if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbs all $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
    else dsa $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 
  } 
}
on 1:input:@d-tool_db:{ if ( / !isin $1 ) && ( $left($1,1) != $chr(33) ) dimdb $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 | if ( $left($1,1) == ! ) dmaze $replace($remove($1-,!),$chr(32),$chr(46)) }
on 1:input:@d-tool_sitelog:/dtlog $1
on 1:input:@d-tool_section: { 
  set %dtsimsec $1 
  set %rls %dtsimrls | set %srcsite %dtsimsrcsite | set %dessite %dtsimdessite | set %sektionnr %dtsimsec | set %srcdir $readini(d-tool\inis\ $+ %srcsite $+ .ini,sections,dlight $+ %dtsimsec) | set %srcdirdir $readini(d-tool\inis\ $+ %srcsite $+ .ini,sections,dlight $+ %dtsimsec $+ dir) | set %desdir $readini(d-tool\inis\ $+ %dessite $+ .ini,sections,dlight $+ %dtsimsec) | set %desdirdir $readini(d-tool\inis\ $+ %dessite $+ .ini,sections,dlight $+ %dtsimsec $+ dir) | set %sektionnr %dtsimsec
  var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\d-tool.ini,sites,%a) == %srcsite ) var %s = %a | inc %a }
  set %dtwindownr $calc($eval(%s $+ 0) - 9 + $calc($readini(d-tool\d-tool.ini,vars,winstart) - 1)) | window -c @d-tool_section | set %dtnorace 1 | trade sim %dtsimpre %dtsim | unset %dtsim* | if ($window(@d-tool_skip)) window -a @d-tool_skip | elseif ($window(@d-tool_at)) window -a @d-tool_at  
}
on 1:input:@d-tool_sections: { 
  set %cbfxpsrcsec $1 | set %cbfxpdessec $2
  sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) fxp %cbfxpsrcsite / $+ $readini(d-tool\inis\ $+ %cbfxpsrcsite $+ .ini,sections,dlight $+ %cbfxpsrcsec) $+ / %cbfxprls %cbfxpdessite / $+ $readini(d-tool\inis\ $+ %cbfxpdessite $+ .ini,sections,dlight $+ %cbfxpdessec) $+ / %cbfxprls
  unset %cbfxp* | window -c @d-tool_sections | echo -a d-tool sent something to cbftp
}
alias dtrace {
  unset %dtsim* | set %dtsimrls $input(Releasename?,e,Manual Race,$cb) | if (!%dtsimrls) halt | set %dtsimsrcsite $input(Source?,e,Manual Race Source,%dtsimsrcsite) | if (!%dtsimsrcsite) halt | set %dtsimdessite $input(Destination?,e,Manual Race Destination,%dtsimdessite) | if ( $input(Won't check Pre?,y,Precheck) != $true ) set %dtsimpre p | if ( $input(only simulation?,y,Simulation or send to FTP?) == $true ) set %dtsim s | if (!%dtsimdessite) halt 
  var %tn = 1 | while ( %tn <= 10 ) { if ( %dtsimrls == $gettok($eval(% $+ dtrules $+ %tn,2),1,32) ) unset $eval(% $+ dtrules $+ %tn,1) | inc %tn }
  window -aezfkdb @d-tool_section font $readini(d-tool\d-tool.ini,vars,secfsize)
  var %kz = 1 | while ( %kz <= $readini(d-tool\sections.ini,name,count) ) { aline -p @d-tool_section  %kz - $readini(d-tool\sections.ini,name,%kz) | inc %kz }
  aline -p @d-tool_section simply enter the number of the section you want to race and hit ENTER
}
alias dtfxp { 
  set %cbfxprls $input(Releasename?,e,Manual Race,$cb) | if (!%cbfxprls) halt
  set %cbfxpsrcsite $?"Sourcesite?"
  set %cbfxpdessite $?"Dessite?"
  window -aezfkdb @d-tool_sections
  var %kz = 1 | while ( %kz <= $readini(d-tool\sections.ini,name,count) ) { aline -p @d-tool_sections  %kz - $readini(d-tool\sections.ini,name,%kz) | inc %kz }
  aline -p @d-tool_sections simply enter the numbers of the sections you want to race, first sourcesite, then dessite, like 23 45 and hit ENTER (and maybe save the position of this window for simulations in the future)
}
alias dtrp {
  while ($exists(%[FRush]Dir $+ RushCfg.xml) == $false) { set %[FRush]Dir $sdir(c:\,Select FTPRush Folder) }
  var %line = $read(%[FRush]Dir $+ rushcfg.xml,w,*<TSTATS START="*" UP="*" DN="*" FXP="*" />*)
  var %[FtpRSTS]tmpdate = $gettok(%line,2,34)
  var %[FtpRSTS]UP = $gettok(%line,4,34)
  var %[FtpRSTS]DN = $gettok(%line,6,34)
  var %[FtpRSTS]FXP = $gettok(%line,8,34)
  var %[FtpRSTS]date = $ctime($and($calc(%[FtpRSTS]tmpdate /65536),31) $+ $chr(47) $+ $and($calc(%[FtpRSTS]tmpdate /2097152),15) $+ $chr(47) $+ $left($calc(%[FtpRSTS]tmpdate /33554432 +1980),4))
  var %[FtpRSTS]days = $calc(($ctime - %[FtpRSTS]date)/86400)
  echo $active 15 uploaded: $bytes(%[FtpRSTS]UP,3).suf - 15downloaded: $bytes(%[FtpRSTS]DN,3).suf - 15FXPed: $bytes(%[FtpRSTS]FXP,3).suf 15 since $asctime(%[FtpRSTS]date,d/mm/yyyy) 
  echo $active 15 this is an average of $bytes($calc(%[FtpRSTS]UP / %[FtpRSTS]days),3).suf $+ /day 15uploaded - $bytes($calc(%[FtpRSTS]DN / %[FtpRSTS]days),3).suf $+ /day 15downloaded - $bytes($calc(%[FtpRSTS]FXP / %[FtpRSTS]days),3).suf $+ /day ( $+ $left($eval($calc(($remove($bytes(%[FtpRSTS]FXP,3).suf,TB) / %[FtpRSTS]days ) * 30),3),5) $+ TB/month) 15FXPed for %[FtpRSTS]days 15days 
}
alias dtrc {
  while ($exists(%[FRush]Dir $+ RushCfg.xml) == $false) { set %[FRush]Dir $sdir(c:\,Select FTPRush Data folder) }
  var %line = $read(%[FRush]Dir $+ rushcfg.xml,w,*<TSTATS START="*" UP="*" DN="*" FXP="*" />*)
  var %[FtpRSTS]tmpdate = $gettok(%line,2,34)
  var %[FtpRSTS]UP = $gettok(%line,4,34)
  var %[FtpRSTS]DN = $gettok(%line,6,34)
  var %[FtpRSTS]FXP = $gettok(%line,8,34)
  var %[FtpRSTS]date = $ctime($and($calc(%[FtpRSTS]tmpdate /65536),31) $+ $chr(47) $+ $and($calc(%[FtpRSTS]tmpdate /2097152),15) $+ $chr(47) $+ $left($calc(%[FtpRSTS]tmpdate /33554432 +1980),4))
  var %[FtpRSTS]days = $calc(($ctime - %[FtpRSTS]date)/86400)
  me 15uploaded:7 $bytes(%[FtpRSTS]UP,3).suf - 15downloaded:7 $bytes(%[FtpRSTS]DN,3).suf - 15FXPed:7 $bytes(%[FtpRSTS]FXP,3).suf 15 since7 $asctime(%[FtpRSTS]date,d/mm/yyyy)  15average:7 $bytes($calc(%[FtpRSTS]UP / %[FtpRSTS]days),3).suf $+ /day 15uploaded -7 $bytes($calc(%[FtpRSTS]DN / %[FtpRSTS]days),3).suf $+ /day 15downloaded -7 $bytes($calc(%[FtpRSTS]FXP / %[FtpRSTS]days),3).suf $+ /day ( $+ $left($eval($calc(($remove($bytes(%[FtpRSTS]FXP,3).suf,TB) / %[FtpRSTS]days ) * 30),3),5) $+ TB/month) 15FXPed for7 %[FtpRSTS]days 15days between currently7 $readini(d-tool\d-tool.ini,sites,count) 15Sites [d-tool]
}
alias dse {
  set %dtsearchsite $1 | unset %dtsearchitem | unset %dtsearchskip
  var %dtsearchitems = $2-
  var %ti = 1 | while ( %ti <= 10 ) {
    if ( ! !isin $gettok(%dtsearchitems,%ti,32) ) set %dtsearchitem %dtsearchitem $gettok(%dtsearchitems,%ti,32)
    elseif ( $left($gettok(%dtsearchitems,%ti,32),1) == ! ) set %dtsearchskip %dtsearchskip $remove($gettok(%dtsearchitems,%ti,32),!)
    inc %ti
  }
  dll d-tool\rushmirc.dll SetMircCmd /search_result
  dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ %dtsearchsite $+ ', ' $+ site search %dtsearchitem $+ ', RS_ONE or RS_LOGIN or RS_LOGOUT)
  if (%dtsearchskip) {   if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 Searching  %dtsearchitem on %dtsearchsite without %dtsearchskip }
  else { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 Searching  %dtsearchitem on %dtsearchsite $+ ... %dtsearchskip }
}
alias dsa {
  var %dtsearchitems = $1- | unset %dtsearchitem | unset %dtsearchskip
  var %ti = 1 | while ( %ti <= 10 ) {
    if ( ! !isin $gettok(%dtsearchitems,%ti,32) ) set %dtsearchitem %dtsearchitem $gettok(%dtsearchitems,%ti,32)
    elseif ( $left($gettok(%dtsearchitems,%ti,32),1) == ! ) set %dtsearchskip %dtsearchskip $remove($gettok(%dtsearchitems,%ti,32),!)
    inc %ti
  }
  if (%dtsearchskip) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 Searching  %dtsearchitem on all Sites without %dtsearchskip }
  else { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 Searching  %dtsearchitem on all Sites... }

  var %i = 1 | while ( %i <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %sini = $readini(d-tool\d-tool.ini,sites,%i) $+ .ini | if ( $readini(d-tool\inis\ $+ %sini,$readini(d-tool\d-tool.ini,sites,%i),status) == 1 ) {
      dll d-tool\rushmirc.dll SetMircCmd /search_result 
      dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ $readini(d-tool\d-tool.ini,sites,%i) $+ ', ' $+ site search %dtsearchitem $+ ', RS_ONE or RS_LOGIN or RS_LOGOUT)
    }
    inc %i 
  }
}
alias search_result {
  if ( 200- isin $2- ) && ( / isin $3- ) && ( /sample !isin $3- ) && ( /cover !isin $3- ) && ( /proof !isin $3- ) && ( no-sfv !isin $3- ) && ( /Subs !isin $3- ) && ( /DVD !isin $3- ) && ( /Disc !isin $3- ) && ( /CD !isincs $3- ) && ( incomplete !isin $3- ) && ( ## !isin $3- ) && ( imdb !isin $3- ) { 
    if ( */*-* iswm $3 ) || ( */*-* iswm $4 ) || ( */*-* iswm $5 ) { 
      var %ti = 1 | while ( %ti <= 5 ) {
        if ( $gettok(%dtsearchskip,%ti,32) isin $3 ) || ( $gettok(%dtsearchskip,%ti,32) isin $4 ) || ( $gettok(%dtsearchskip,%ti,32) isin $5 ) { var %searchtrigger = 0 }
        inc %ti
      }
      if ( %searchtrigger != 0 ) aline -p @d-tool  $1 $+ _ $+ 15found: $+ _ $+ $3 
    }
  }
}
alias dtc {
  if ($window(@d-tool)) window -a @d-tool | else dtoolwin
  /dll d-tool\rushmirc.dll SetMircCmd /dtcommand
  /dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ $1 $+ ', 'site $2 $3 $4 $5 $6 $7 $8 $9 $10 $+ ', RS_ONE or RS_LOGIN or RS_LOGOUT) 
}
alias dtca { 
  var %k = 1 | while ( %k <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %l = $readini(d-tool\d-tool.ini,sites,%k) | .timer 1 %k dtc $readini(d-tool\d-tool.ini,%l,site) $1 $2 $3 $4 $5 
    inc %k 
  } 
}
alias dtcommand { if (!$window(@d-tool )) dtoolwin | aline -p @d-tool 15 $1  $2 $3 $4  $5 $6 $7 $8 $9 $10 $12 $13 $14 $15 $16 $17 $18 $19 $20 $21 $22 $23 $24 $25 $26 $27 $28 $28 $29 $30 } 
alias dinvite {
  var %r = 1 | while ( %r <= $readini(d-tool/d-tool.ini,sites,count) ) { var %s = $readini(d-tool/d-tool.ini,sites,%r) | var %n = $readini(d-tool/inis/ $+ %s $+ .ini,%s,ircnick) | if ( $readini(d-tool/inis/ $+ %s $+ .ini,%s,status) == 1 ) dinv %n %s | inc %r }
}
alias dinv {
  if ( $readini(d-tool/d-tool.ini,vars,cbftp) == 1 ) {
    var %c = 2 | while ( %c <= $numtok($1-,32) ) {
      sockudp -n cbftp $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport) $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) raw $replace($eval($ $+ %c,3),$chr(32),$chr(44)) site invite $1
      inc %c
    }
  }
  else {
    var %c = 2 | while ( %c <= 50 ) {
      if ( $eval($ $+ %c,3) ) {
        /dll d-tool\rushmirc.dll SetMircCmd /dinvited
        /dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ $eval($ $+ %c,3) $+ ', 'site invite $1 $+ ', RS_ONE or RS_LOGIN or RS_LOGOUT) 
      }
      inc %c
    }
  }
}
alias dinvited { if (!$window(@d-tool )) dtoolwin | aline -p @d-tool [ $1 ]  $2 $3 $4  $5 $6 $7 $8 $9 }
alias dtlogin { 
  if ( $1 ) {
    if ( $readini(d-tool/d-tool.ini,vars,cbftp) == 1 ) {
      dtcblogin $1
      .timer 1 6 dtloginoff1 $1
      if ($window(@d-tool)) aline -p @d-tool $timestamp Logincheck for $1 - takes 6 sec... | else { dtoolwin | aline -p @d-tool $timestamp Logincheck for $1 - takes 6 sec... }
    }
    elseif ( $readini(d-tool/d-tool.ini,vars,cbftp) != 1 ) {
      dll d-tool\rushmirc.dll SetMircCmd /dtlogincmd
      dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ $1 $+ ', 'site help', RS_ONE or RS_LOGIN or RS_LOGOUT)
      .timer 1 5 dtloginoff1 $1
      if ($window(@d-tool)) aline -p @d-tool $timestamp Logincheck for $1 - takes 5 sec... | else { dtoolwin | aline -p @d-tool $timestamp Logincheck for $1 - takes 5 sec... }
    }
  }
  else {
    if ( $readini(d-tool/d-tool.ini,vars,cbftp) == 1 ) {
      var %f = $readini(d-tool/d-tool.ini,sites,1) | if ( $readini(d-tool\inis\ $+ %f $+ .ini,%f,status) == 1 ) { .timer 1 1 dtcblogin %f }
      var %c = 2 | while ( %c <= $readini(d-tool/d-tool.ini,sites,count) ) {
        var %f = $readini(d-tool/d-tool.ini,sites,%c) | if ( $readini(d-tool\inis\ $+ %f $+ .ini,%f,status) == 1 ) { 
          var %r = $calc(%c - 1) | .timer 1 $calc(%r * 6) dtcblogin %f
        }
        inc %c
      }
      .timer 1 $calc($readini(d-tool/d-tool.ini,sites,count) * 6) dtloginoff
      if ($window(@d-tool)) aline -p @d-tool $timestamp Logincheck - takes $calc($readini(d-tool/d-tool.ini,sites,count) * 6) sec... | else { dtoolwin | aline -p @d-tool $timestamp Logincheck - takes $calc($readini(d-tool/d-tool.ini,sites,count) * 6) sec... }
    }
    elseif ( $readini(d-tool/d-tool.ini,vars,cbftp) != 1 ) {
      if ( $dll(d-tool/rushmirc.dll,Invoke,RushApp.Containers.TransferSiteCount) == 0 ) {
        var %c = 1 | while ( %c <= $readini(d-tool/d-tool.ini,sites,count) ) {
          var %f = $readini(d-tool/d-tool.ini,sites,%c) 
          if ( $readini(d-tool\inis\ $+ %f $+ .ini,%f,status) == 1 ) {
            .timer 1 3 dll d-tool\rushmirc.dll SetMircCmd /dtlogincmd
            .timer 1 3 dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ %f $+ ', 'site stat', RS_ONE or RS_LOGIN or RS_LOGOUT) 
          }
          inc %c
        }
        .timer 1 10 dtloginoff
        if ($window(@d-tool)) aline -p @d-tool $timestamp Logincheck - takes 10 sec... | else { dtoolwin | aline -p @d-tool $timestamp Logincheck - takes 10 sec... }
      }
      else { .timer 1 60 dtlogin | aline -p @d-tool $timestamp aborting cause of transfers, trying again in 1min }
    }
  }
}
alias dtcblogin {
  set %cbapisites $1 | sockclose apilogin
  sockopen -e apilogin $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
}
on *:sockopen:apilogin:{
  var %so = sockwrite -nt $sockname | var %cbcmd = $chr(123) $+ "command": "site stat", "sites": [" $+ $replace(%cbapisites,$chr(44)," $+ $chr(44) $+ $chr(32) $+ ") $+ "] $+ $chr(125)
  %so POST /raw HTTP/1.0
  %so Host: $readini(d-tool\d-tool.ini,vars,cbftpip)
  %so Content-Type: application/json
  %so Authorization: Basic $encode(: $+ $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) $+ ,m)
  %so User-Agent: */*
  %so Content-Length: $len(%cbcmd)
  %so $crlf $+ %cbcmd
}
on *:sockread:apilogin:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    if ( result isin %temptext ) { set %dtloginvar %dtloginvar $+ %cbapisites | sockclose apilogin }
  }
}
alias dtlogincmd {
  if ( 226- isin $1-3 ) && ( $1 !isin %dtloginvar ) set %dtloginvar %dtloginvar $+ $1
  if ( 220- isin $1-3 ) && ( $1 !isin %dtloginvar ) set %dtloginvar %dtloginvar $+ $1
}
alias dtloginoff {
  var %t = 1 | while ( %t <= $readini(d-tool/d-tool.ini,sites,count) ) {
    var %ts = $readini(d-tool/d-tool.ini,sites,%t)
    if ( $readini(d-tool\inis\ $+ %ts $+ .ini,%ts,status) == 1 ) {
      if ( %ts !isin %dtloginvar ) && ( $readini(d-tool/inis/ $+ %ts $+ .ini,%ts,loginstatus) != 0 ) { writeini -n d-tool/inis/ $+ %ts $+ .ini %ts loginstatus 0 | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool $timestamp 4 %ts is now turned OFF! can't log in (try again in 3 min) | if ( %tt != 1 ) { .timer $+ %ts 1 180 dtlogin | var %tt = 1 } }
      if ( %ts isin %dtloginvar ) && ( $readini(d-tool/inis/ $+ %ts $+ .ini,%ts,loginstatus) != 1 ) { writeini -n d-tool/inis/ $+ %ts $+ .ini %ts loginstatus 1 | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool $timestamp 3 %ts login successful }
    }
    inc %t
  }
  unset %dtloginvar*
}
alias dtloginoff1 {
  if ( $1 !isin %dtloginvar ) && ( $readini(d-tool/inis/ $+ $1 $+ .ini,$1,loginstatus) != 0 ) { writeini -n d-tool/inis/ $+ $1 $+ .ini $1 loginstatus 0 | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool $timestamp 4 $1 is now turned OFF! can't log in } 
  if ( $1 isin %dtloginvar ) && ( $readini(d-tool/inis/ $+ $1 $+ .ini,$1,loginstatus) != 1 ) { writeini -n d-tool/inis/ $+ $1 $+ .ini $1 loginstatus 1 | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool $timestamp 3 $1 login successful | .timer $+ $1 off }
  unset %dtloginvar*
}
alias dtsec {
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool  $1 SECTIONS (/ in front is added for cbftp - click to copy on clipboard): 
  var %i = 1 | while ( %i <= $readini(d-tool\sections.ini,name,count) ) {
    if ($readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %i)) {
      if ( $readini(d-tool\inis\ $+ $1 $+ .ini,sections,ats $+ %i) == $null ) var %zu = 0 | else var %zu = $readini(d-tool\inis\ $+ $1 $+ .ini,sections,ats $+ %i) 
      aline -p @d-tool  $1 Section %i $+ : $readini(d-tool\sections.ini,name, $+ %i $+ ) >>>_/ $+ $readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %i $+ dir) ( $+ $replace($readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %i ),fake,7fake) $+ ) 14(race-in $replace(%zu,1,3on,0,7off,$null,7off) $+ 14)  
    } 
    inc %i
  }
}
alias dtaffils {
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 AFFILS:
  var %nr1 = 1 | while ( %nr1 <= $readini(d-tool\d-tool.ini,sites,count) ) { 
    var %asite = $readini(d-tool\d-tool.ini,sites,%nr1) | var %asiteini = %asite $+ .ini | var %nr2 = 1 
    while ( %nr2 <= $readini(d-tool\d-tool.ini,vars,aentrys) ) {
      if ( - isin $readini(d-tool\inis\ $+ %asiteini,affils,a $+ %nr2) ) {
        var %aentry = $readini(d-tool\inis\ $+ %asiteini,affils,a $+ %nr2)
        var %affoutput %affoutput %aentry
      }
      inc %nr2
    }
    if (%affoutput) aline -p @d-tool 15[3 %asite ] $remove(%affoutput,-)
    unset %affoutput
    inc %nr1 
  }
  unset %asite
} 
alias dtaddpreset {
  var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %b = $readini(d-tool\d-tool.ini,sites,%a) | var %bini = %b $+ .ini
    if ( $readini(d-tool\inis\ $+ %bini,%b,fillsite) ) writeini -n d-tool\presets.ini $1 %b $readini(d-tool\inis\ $+ %bini,%b,fillsite)
    var %c = 1 | while ( %c <= 9 ) {
      if ( $readini(d-tool\inis\ $+ %bini,%b,fillsite $+ %c) ) writeini -n d-tool\presets.ini $1 %b $readini(d-tool\presets.ini,$1,%b) $readini(d-tool\inis\ $+ %bini,%b,fillsite $+ %c)
      inc %c
    } 
    if ($readini(d-tool\inis\ $+ %bini,%b,cbsources)) writeini -n d-tool\presets.ini $1 %b $+ .s $readini(d-tool\inis\ $+ %bini,%b,cbsources) | if ($readini(d-tool\inis\ $+ %bini,%b,cbtargets)) writeini -n d-tool\presets.ini $1 %b $+ .t $readini(d-tool\inis\ $+ %bini,%b,cbtargets)
    inc %a
  }
}
alias dtdelpreset if ( $input(Really want to delete $1 $+ ?,y,Delete Preset) == $true ) { remini d-tool\presets.ini $1 }
alias dtpresets dialog -m dtpreset dtpreset
alias dtpresetsall {
  var %t = 1 | while ( %t <= $lines(d-tool\presets.ini) ) { if ( [ isin $read(d-tool\presets.ini, %t) ) dtshowpreset $remove($read(d-tool\presets.ini, %t),[,]) | inc %t }
}
alias dtshowpreset {
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 15 Preset $1 
  var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %q = 1 | while ( %q <= $readini(d-tool\d-tool.ini,sites,count) ) {
      var %w = $readini(d-tool\d-tool.ini,sites,%q)
      if ( $readini(d-tool\d-tool.ini,sites,%a) == $gettok($readini(d-tool\presets.ini,$1,%w),1,32) ) { set % $+ sitefillers $+ $readini(d-tool\d-tool.ini,sites,%a) $eval(% $+ sitefillers $+ $readini(d-tool\d-tool.ini,sites,%a),3) %w }
      var %f = 2 | while ( %f <= 10 ) {
        if ( $readini(d-tool\d-tool.ini,sites,%a) == $gettok($readini(d-tool\presets.ini,$1,%w),%f,32) ) { set % $+ sitefillers $+ $readini(d-tool\d-tool.ini,sites,%a) $eval(% $+ sitefillers $+ $readini(d-tool\d-tool.ini,sites,%a),3) %w }
        inc %f
      }
      inc %q
    }
    if ( $readini(d-tool\presets.ini,$1,$readini(d-tool\d-tool.ini,sites,%a)) ) || ( $readini(d-tool\presets.ini,$1,$readini(d-tool\d-tool.ini,sites,%a) $+ .t) ) || ( $readini(d-tool\presets.ini,$1,$readini(d-tool\d-tool.ini,sites,%a) $+ .s) ) { aline -p @d-tool 15 $readini(d-tool\d-tool.ini,sites,%a) $+ : 3 %sitefillers $+ $eval(% $+ sitefillers $+ $readini(d-tool\d-tool.ini,sites,%a),2) /7 $readini(d-tool\presets.ini,$1,$readini(d-tool\d-tool.ini,sites,%a)) cb.sources3 $replace($readini(d-tool\presets.ini,$1,$readini(d-tool\d-tool.ini,sites,%a) $+ .s),$chr(44),$chr(32)) cb.targets7 $replace($readini(d-tool\presets.ini,$1,$readini(d-tool\d-tool.ini,sites,%a) $+ .t),$chr(44),$chr(32)) }
    unset %sitefillers*
    inc %a
  }
}
alias dtsetpreset {
  if ( $input(Really want to load $1 $+ ?,y,Set Preset) == $true ) {
    if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool Starting to 3SYNC to set $1 $+ ...takes a while
    var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) {
      var %b = $readini(d-tool\d-tool.ini,sites,%a) | var %bini = %b $+ .ini
      remini d-tool\inis\ $+ %bini %b fillsite | remini d-tool\inis\ $+ %bini %b fillsite1 | remini d-tool\inis\ $+ %bini %b fillsite2 | remini d-tool\inis\ $+ %bini %b fillsite3 | remini d-tool\inis\ $+ %bini %b fillsite4 | remini d-tool\inis\ $+ %bini %b fillsite5 | remini d-tool\inis\ $+ %bini %b fillsite6 | remini d-tool\inis\ $+ %bini %b fillsite7 | remini d-tool\inis\ $+ %bini %b fillsite8 | remini d-tool\inis\ $+ %bini %b fillsite9
      if ( $readini(d-tool\presets.ini,$1,%b) ) {  
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),1,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite $gettok($readini(d-tool\presets.ini,$1,%b),1,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),2,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite1 $gettok($readini(d-tool\presets.ini,$1,%b),2,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),3,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite2 $gettok($readini(d-tool\presets.ini,$1,%b),3,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),4,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite3 $gettok($readini(d-tool\presets.ini,$1,%b),4,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),5,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite4 $gettok($readini(d-tool\presets.ini,$1,%b),5,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),6,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite5 $gettok($readini(d-tool\presets.ini,$1,%b),6,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),7,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite6 $gettok($readini(d-tool\presets.ini,$1,%b),7,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),8,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite7 $gettok($readini(d-tool\presets.ini,$1,%b),8,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),9,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite8 $gettok($readini(d-tool\presets.ini,$1,%b),9,32)
        if ( $gettok($readini(d-tool\presets.ini,$1,%b),10,32) ) writeini -n d-tool\inis\ $+ %bini %b fillsite9 $gettok($readini(d-tool\presets.ini,$1,%b),10,32)
      }
      if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) { .timer 1 $calc(%a * 6) dcbsync %b s $replace($readini(d-tool\presets.ini,$1,%b $+ .s),$chr(44),$chr(32)) | .timer 1 $calc(%a * 6 + 3) dcbsync %b t $replace($readini(d-tool\presets.ini,$1,%b $+ .t),$chr(44),$chr(32)) }
      inc %a
    }
    .timer 1 $calc(%a * 6 + 4) echo @d-tool Preset $1 set 
  }
}
alias dtrf reqsearch $cb
alias dtlc dtcheckline $cb
alias dtdir run $scriptdir
alias dtrinfo {
  %ftpdown = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.TotalDownloadSize)
  %ftpup = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.TotalUploadSize)
  %ftpfxp = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.TotalFXPSize)
  %ftpdownc = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.CurDownloadSize)
  %ftpupc = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.CurUploadSize)
  %ftpfxpc = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.CurFXPSize)
  %ftpstart = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.StartDate)
  %ftpday = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.DayCount)
  %rushver = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Version)
  %rushpool = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.PoolInfo)
  %rushcontainer = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Containers.ContainerCount);
  %rushconn = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Containers.ConnectedSiteCount);
  %rushtran = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Containers.TransferSiteCount);
  %rushbwu = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.UploadBW);
  %rushbwd = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.DownloadBW);
  echo  %rushver
  ; echo Thread Pool: %rushpool
  echo BW_UP: %rushbwu kbps, BW_DN: %rushbwd kbps
  echo CONTAINER: %rushcontainer , Connected: %rushconn , Transfering: %rushtran
  echo from %ftpstart , total %ftpday day. I downloaded %ftpdown MB, uploaded %ftpup MB, FXPed %ftpfxp MB
  echo This Session I downloaded %ftpdownc MB, Uploaded %ftpupc MB, FXPed3 %ftpfxpc MB
}
alias dtcheckline { 
  var %a = 1 | while ( %a <= 30 )  {
    if ($eval($ $+ %a,2)) var %lcresult = %lcresult $+ $chr(32) $+ 4 %a 0,1 $eval($ $+ %a,2) $+ $chr(32)
    inc %a
  }
  echo $active 15 linecheck: %lcresult
}
alias rinfo notice $me !info $decode($readini(d-tool\d-tool.ini,vars,rmpw))
;;;;;;;;;;;;;;SPORT
alias dtes { var %a = $input(add trigger for sport (entry entry entry... or regex entrys with ~ at the start),e,$1,$readini(d-tool\d-tool.ini,vars,sport)) | if (%a) writeini -n d-tool\d-tool.ini vars sport %a }
alias dtss { echo -a  Sporttrigger (single words or regex possible, case-sensitive) | echo -a $readini(d-tool\d-tool.ini,vars,sport) }
alias dtas { writeini d-tool\d-tool.ini vars sport $readini(d-tool\d-tool.ini,vars,sport) $1 | echo -a  $1 added to Sporttriggers }
alias dtds { writeini d-tool\d-tool.ini vars sport $remove($readini(d-tool\d-tool.ini,vars,sport),$1) | echo -a deleted Sporttrigger(s): $1 | showsport }
;;;;;;;;;;;;;;
alias dtlog {
  set %siteamount 0 | var %p = 1 | while ( %p <= $gettok($readini(mirc.ini,options,n3),1,44) )  {
    var %logline = $replace($replace($line(@d-tool_done,%p),MB/s,XX),$chr(32) $+ MB,MB) | if (%logline) {
      if (!$window(@d-tool_sitelog)) window -aezfkdb @d-tool_sitelog iconfile d-tool\logo\dtool.ico
      if ( $chr(35) $+ $1 isin %logline ) { if ( MB isincs %logline ) || ( GB isincs %logline ) { if ( $chr(64) !isin $strip(%logline) )  aline -p @d-tool_sitelog $replace($replace(%logline,XX,MB/s),MB,$chr(32) $+ MB) } | else aline -p @d-tool_sitelog $replace($replace(%logline,XX,MB/s),MB,$chr(32) $+ MB)
        var %dh = 1 | while ( %dh <= $numtok($strip(%logline),32) ) {
          if ( MB isincs $remove($replace($replace($gettok($strip(%logline),%dh,32),$chr(47),$chr(32)),$chr(124),$chr(32)),[,],$chr(40),$chr(41)) ) && ( $chr(40) !isin $remove($gettok($strip(%logline),%dh,32),[,]) ) {  
            set %siteamount $calc($gettok($remove($replace($replace($gettok($strip(%logline),%dh,32),$chr(47),$chr(32)),$chr(124),$chr(32)),[,],$chr(40),$chr(41),MB),1,32) + %siteamount )  
          }
          elseif ( GB isincs $remove($replace($replace($gettok($strip(%logline),%dh,32),$chr(47),$chr(32)),$chr(124),$chr(32)),[,],$chr(40),$chr(41)) ) && ( $chr(40) !isin $remove($gettok($strip(%logline),%dh,32),[,]) ) {  
            set %siteamount $calc($gettok($remove($replace($replace($gettok($strip(%logline),%dh,32),$chr(47),$chr(32)),$chr(124),$chr(32)),[,],$chr(40),$chr(41),GB),1,32) * 1000 + %siteamount )  
          } 
          inc %dh 
        }
      }
    }
    else goto dtlogstop
    inc %p
  }
  :dtlogstop
  if ($window(@d-tool_sitelog)) aline -p @d-tool_sitelog Amount:9 $calc( %siteamount / 1000) GB
  window -a @d-tool_sitelog | unset %siteamount
}
alias affilfilter {
  var %p = 1 | while ( %p <= 10000 )  {
    var %logline = $line(@d-tool_at,%p)
    if ($line(@d-tool_at,%p)) { if ( AFFIL isincs %logline ) { window -zfkbD @d-tool_affils | aline -p @d-tool_affils 1 $+ %logline } } 
    else goto afffilterstop
    inc %p
  }
  :afffilterstop
  window -a @d-tool_affils
}
alias dttrigger { if ( %dttriggerlast != $1 ) { var %tline = $2- | var %sc = 1 | while (%sc <= $numtok(%tline,32)) { if ( $gettok(%tline,%sc,32) isin $1 ) || ( $gettok(%tline,%sc,32) iswm $1 ) dttriggermsg $1 $gettok(%tline,%sc,32) | inc %sc } } | set %dttriggerlast $1 }
alias dttriggermsg { window -zkbD @d-tool_trigger font $readini(d-tool\d-tool.ini,vars,trigfsize) iconfile d-tool\logo\dtool.ico | if ($1) aline -p @d-tool_trigger 14 $date $timestamp 15 $2  $1 | if ( %dttout == 1 ) && ($1) write %dttoutp $date $1 }
alias addtrigger { if ($readini(d-tool\d-tool.ini,vars,trigger)) { writeini d-tool\d-tool.ini vars trigger $readini(d-tool\d-tool.ini,vars,trigger) $1- } | else { writeini d-tool\d-tool.ini vars trigger $readini(d-tool\d-tool.ini,vars,trigger) $1- } | echo $active 14 Trigger $1- 14added }
alias triggers { echo $active  Active Triggers (seperate with space, wildcards possible): | echo $active $readini(d-tool\d-tool.ini,vars,trigger) }
alias edittriggers { writeini d-tool\d-tool.ini vars trigger $input(Edit triggers (seperate with space, wildcards possible, hitting X will delete all),eo,d-tool triggers,$readini(d-tool\d-tool.ini,vars,trigger)) }
alias deltrigger { if ( $1 == all ) { remini d-tool\d-tool.ini vars trigger | echo $active 14 All Triggers deleted } | else { writeini d-tool\d-tool.ini vars trigger $remtok($readini(d-tool\d-tool.ini,vars,trigger),$1,1,32) | echo $active 14 Trigger $1 14deleted } }
alias dtftl .remove %dttoutp  ; flushtriggerlist
alias dtkill { if ( %dtrushtimer ) { .timerrush 0 $calc(%dtrushtimer * 3600) rushkill } }
alias rushkill { 
  if ( $dll(d-tool\rushmirc.dll,Invoke,RushApp.Containers.TransferSiteCount) == 0 ) || ( %rushkillcount == 20 ) { run taskkill /T /F /IM FTPRush.exe | .timer 2 3 run %dtrushdir | unset %rushkillcount | if (!$window(@d-tool)) dtoolwin | aline -p @d-tool $timestamp 14 Rush Restart } | else { .timer 1 60 rushkill | if (!$window(@d-tool)) dtoolwin | aline -p @d-tool $timestamp 15 no restart cause of transfers, trying again in 2min | if (%rushkillcount) inc %rushkillcount | else set %rushkillcount 1 }
}
alias entrycheck {
  if ( %dtlist == b ) { var %tt = ecp | var %zz = Black } | elseif ( %dtlist == w ) { var %tt = gw | var %zz = White }
  var %x = $calc($readini(d-tool\d-tool.ini,vars,g $+ %dtlist $+ listentry) + 1) | while ( %x < %oldentry ) { 
    if ( $readini(d-tool\d-tool.ini,vars,%tt $+ %x) ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool %x Global %zz $+ list:15 $readini(d-tool\d-tool.ini,vars,%tt $+ %x) 15 lost! | remini d-tool\d-tool.ini vars %tt $+ %x }
    inc %x
  }
  unset %oldentry
}
alias dbm set %dtimdb $cb | imdb4me
alias dialogondesk {
  if ( d isin $readini(d-tool\d-tool.ini,vars,desktop) ) writeini -n d-tool\d-tool.ini vars desktop $remove($readini(d-tool\d-tool.ini,vars,desktop),d) | else writeini -n d-tool\d-tool.ini vars desktop $readini(d-tool\d-tool.ini,vars,desktop) $+ d | if ($dialog(dtool-sites)) { dialog -x dtool-sites | dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-sites dtool-sites } | if ($dialog(dsections)) { sectionsave | seccountrefresh | dialog -x dsections | dialog $readini(d-tool\d-tool.ini,vars,desktop) dsections dsections } | if ($dialog(picklist)) { dialog -x picklist | dialog $readini(d-tool\d-tool.ini,vars,desktop) picklist picklist }
  if ($dialog(dtool-rules)) { dialog -x dtool-rules | dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-rules dtool-rules } | if ($dialog(dtool-main)) { dialog -x dtool-main | dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-main dtool-main } | if ($dialog(dtool-small)) { dialog -x dtool-small | dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-small dtool-small } | if ($dialog(prefix)) { dialog -x prefix | dialog $readini(d-tool\d-tool.ini,vars,desktop) prefix prefix } | if ($dialog(redirect)) { dialog -x redirect | dialog $readini(d-tool\d-tool.ini,vars,desktop) redirect redirect }
}
alias dialogclose { if ($dialog(dtool-sites)) dialog -x dtool-sites | if ($dialog(dsections)) dialog -x dsections | if ($dialog(dtool-rules)) dialog -x dtool-rules | if ($dialog(dtool-main)) dialog -x dtool-main | if ($dialog(dtool-small)) dialog -x dtool-small | if ($dialog(prefix)) dialog -x prefix | if ($dialog(redirect)) dialog -x redirect }
alias dtmainsave {
  if ($did(dtool-main,16)) writeini -n d-tool\d-tool.ini vars pretime1 $calc($did(dtool-main,16) * 60) | else remini d-tool\d-tool.ini vars pretime1
  if ($did(dtool-main,51)) writeini -n d-tool\d-tool.ini vars pretime2 $calc($did(dtool-main,51) * 60) | else remini d-tool\d-tool.ini vars pretime2
  if ($did(dtool-main,50)) writeini -n d-tool\d-tool.ini vars pretime3 $calc($did(dtool-main,50) * 60) | else remini d-tool\d-tool.ini vars pretime3
  if ($did(dtool-main,21)) writeini -n d-tool\d-tool.ini vars ratwin $did(dtool-main,21)
  if ($did(dtool-main,27)) writeini -n d-tool\d-tool.ini vars attempt1 $did(dtool-main,27)
  if ($did(dtool-main,28)) writeini -n d-tool\d-tool.ini vars attempt2 $did(dtool-main,28)
  if ($did(dtool-main,32)) writeini -n d-tool\d-tool.ini vars winstart $did(dtool-main,32)
  if ($did(dtool-main,35)) && ($did(dtool-main,35) != %dtrushtimer ) { set %dtrushtimer $did(dtool-main,35) | .timerrush off | .timerrush 1 $calc(%dtrushtimer * 3600) dtkill } | elseif ( $did(dtool-main,35) == $null ) { unset %dtrushtimer | .timerrush off }
  if ($did(dtool-main,40)) && ($did(dtool-main,40) != %dtrushqtimer ) { set %dtrushqtimer $did(dtool-main,40) | .timerqueue off | .timerqueue 1 $calc(%dtrushqtimer * 3600) dtqt } | elseif ( $did(dtool-main,40) == $null ) { unset %dtrushqtimer | .timerqueue off }
  if ($did(dtool-main,54)) writeini -n d-tool\d-tool.ini vars doublechecktime $did(dtool-main,54)
}
alias sitesave {
  if ( $did(dtool-sites,17) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite bot $did(dtool-sites,17) | if ( $did(dtool-sites,20) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite site $did(dtool-sites,20)
  if ( $did(dtool-sites,24) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite newnr $did(dtool-sites,24) | writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite new $eval(%dtpreprefix,3) $+ $did(dtool-sites,24)
  if ( $did(dtool-sites,25) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite relsecnr $did(dtool-sites,25) | writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite relsec $eval(%dtpreprefix,3) $+ $did(dtool-sites,25)
  if ( $did(dtool-sites,26) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite relmatchnr $did(dtool-sites,26) | writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite relmatch $eval(%dtpreprefix,3) $+ $did(dtool-sites,26)
  if ( $did(dtool-sites,19) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite match $did(dtool-sites,19)
  if ( $did(dtool-sites,34) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affmatch $did(dtool-sites,34) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite affmatch
  if ( $did(dtool-sites,36) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affrelnr $did(dtool-sites,36) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite affrelnr
  if ( $did(dtool-sites,37) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affsecnr $did(dtool-sites,37) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsecnr
  if ( $did(dtool-sites,64) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite ircnick $did(dtool-sites,64) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite ircnick
  if ( $did(dtool-sites,112) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affmnr $did(dtool-sites,112) | writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affm $eval(%dtpreprefix,3) $+ $did(dtool-sites,112)
  set %dtmainbar2X $dialog(dtool-sites).x | set %dtmainbar2Y $dialog(dtool-sites).y
  var %tj = 1 | while ( %tj <= $numtok($read(d-tool\foreign-mp3.db,1),32) ) { if ( $gettok($read(d-tool\foreign-mp3.db,1),%tj,32) isincs $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,desc) ) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite location $gettok($read(d-tool\foreign-mp3.db,1),%tj,32) | inc %tj }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,scripted) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,current) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,tv-us) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,tv-uk) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdscripted) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdcurrent) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtv-us) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtv-uk) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdanim) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdanim) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite tvengonly 1 | var %rga = 1 } | else var %rgb = 1
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hddoc) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sddoc) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdreal) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdreal) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdrom) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdrom) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdkid) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdkid) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdtalk) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtalk) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite tvengonly 1 | var %rga = 1 } | else var %rgb = 1
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdvar) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdvar) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,anim_s) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,doc_s) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,real_s) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,rom_s) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,kid_s) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,talk_s) == 1 ) || ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,var_s) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite tvengonly 1 | var %rga = 1 } | else var %rgb = 1
  if ( %rga != 1 ) && ( %rgb == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite tvengonly
}
alias matchsave {
  remini d-tool\d-tool.ini matches
  var %c = 1 | while ( %c <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %s = $readini(d-tool\d-tool.ini,sites,%c) | var %sini = %s $+ .ini
    var %p = 1 | while ( %p <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\d-tool.ini,matches,%p) ) var %matches = %matches $remove($readini(d-tool\d-tool.ini,matches,%p),[,]) | inc %p }
    if ($readini(d-tool\inis\ $+ %sini,%s,match)) {
      if ( $remove($readini(d-tool\inis\ $+ %sini,%s,match),[,]) !isincs %matches ) {  
        if ($readini(d-tool\d-tool.ini,matches,count)) {
          writeini -n d-tool\d-tool.ini matches count $calc($readini(d-tool\d-tool.ini,matches,count) + 1) | writeini -n d-tool\d-tool.ini matches $readini(d-tool\d-tool.ini,matches,count) $remove($readini(d-tool\inis\ $+ %sini,%s,match),[,])
        }
        else { writeini -n d-tool\d-tool.ini matches count 1 | writeini -n d-tool\d-tool.ini matches 1 $readini(d-tool\inis\ $+ %sini,%s,match) 
        }
      }
    }
    inc %c
  }
}
alias rulesave {
  if ( $did(dtool-rules,64) != $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry) ) { 
    var %x = $calc($did(dtool-rules,64) + 1) | while ( %x <= $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry) ) { 
      if ( $readini(d-tool\inis\ $+ %dtsiteini,black,%x) ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool  Blacklist:15 %dtsetsite  $readini(d-tool\inis\ $+ %dtsiteini,black,%x) 15 sucks! }
      inc %x
    }
    writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite blistentry $did(dtool-rules,64)
  }
  if ( $did(dtool-rules,66) != $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry) ) { 
    var %x = $calc($did(dtool-rules,66) + 1) | while ( %x <= $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry) ) { 
      if ( $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %x) ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 Whitelist:15 %dtsetsite  $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %x) 15 sucks! }
      inc %x
    }
    writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite wlistentry $did(dtool-rules,66)
  }
  if ( $did(dtool-rules,90) != $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys) ) { 
    var %x = $calc($did(dtool-rules,90) + 1) | while ( %x <= $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys) ) { 
      if ( $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %x) ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 Affillist:15 %dtsetsite  $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %x) 15 sucks! }
      inc %x
    }
    writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite aentrys $did(dtool-rules,90)
  }
  set %dtdsize $did(dtool-rules,17) | if ( %dtdsize < 100 ) set %dtdsize 100 | elseif ( %dtdsize > 1200 ) set %dtdsize 1200
  set %dtrulesX $dialog(dtool-rules).x | set %dtrulesY $dialog(dtool-rules).y
}
alias sectionsave {
  var %gini = %dtsetsite $+ .ini
  set %dtsectionX $dialog(dsections).x | set %dtsectionY $dialog(dsections).y
  if ($did(dsections,6)) writeini -n d-tool\inis\ $+ %gini sections dlight $+ %dtsdnr $did(dsections,6) | elseif ( %dtsdstat == 1 )  remini d-tool\inis\ $+ %gini sections dlight $+ %dtsdnr
  if ($did(dsections,9)) writeini -n d-tool\inis\ $+ %gini sections dlight $+ %dtsdnr $+ dir $did(dsections,9) | elseif ( %dtsdstat == 1 ) remini d-tool\inis\ $+ %gini sections dlight $+ %dtsdnr $+ dir
  if ($did(dsections,10)) writeini -n d-tool\inis\ $+ %gini %dtsetsite y $+ %dtsdnr $did(dsections,10) | elseif ( %dtsdstat == 1 ) remini d-tool\inis\ $+ %gini %dtsetsite y $+ %dtsdnr
  if ($did(dsections,22)) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite secprefix $did(dsections,22) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite secprefix
  if ($did(dsections,29)) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite secsuffix $did(dsections,29) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite secsuffix
  if ($did(dsections,25)) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affprefix $did(dsections,25) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite affprefix
  if ($did(dsections,28)) writeini -n d-tool\inis\ $+ %dtsiteini %dtsetsite affsuffix $did(dsections,28) | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsuffix
}
alias serverlist3 {
  var %ei = 1 | while ( %ei <= $readini(d-tool\d-tool.ini,sites,count) ) {
    if ( $1 == begin ) && ( %ei == 1 ) return -
    if ( $1 == %ei ) && ( %ei < $readini(d-tool\d-tool.ini,sites,count) ) return $readini(d-tool\d-tool.ini,sites,%ei) :dtlogin $readini(d-tool\d-tool.ini,sites,$1)
    if ( $1 == end ) && ( %ei == $readini(d-tool\d-tool.ini,sites,count) ) return $readini(d-tool\d-tool.ini,sites,%ei) :dtlogin $readini(d-tool\d-tool.ini,sites,$readini(d-tool\d-tool.ini,sites,count))
    inc %ei
  }
}
alias saveprebot {
  if ( $did(dprebot,1) ) { writeini -n d-tool\d-tool.ini vars prebot $+ $1 $did(dprebot,1) } | elseif ( $did(dprebot,1) == $null ) { remini d-tool\d-tool.ini vars prebot $+ $1 }
  if ( $did(dprebot,4) ) { writeini -n d-tool\d-tool.ini vars prematch $+ $1 $did(dprebot,4) } | elseif ( $did(dprebot,4) == $null ) { remini d-tool\d-tool.ini vars prematch $+ $1 }
  if ( $did(dprebot,8) ) { writeini -n d-tool\d-tool.ini vars prechan $+ $1 $did(dprebot,8) } | elseif ( $did(dprebot,8) == $null ) { remini d-tool\d-tool.ini vars prechan $+ $1 }  
  unset %dtprechans | if ($readini(d-tool\d-tool.ini,vars,prechan1)) set %dtprechans $readini(d-tool\d-tool.ini,vars,prechan1) | if ($readini(d-tool\d-tool.ini,vars,prechan2)) set %dtprechans %dtprechans $+ , $+ $readini(d-tool\d-tool.ini,vars,prechan2) | if ($readini(d-tool\d-tool.ini,vars,prechan3)) set %dtprechans %dtprechans $+ , $+ $readini(d-tool\d-tool.ini,vars,prechan3)
  if ( $did(dprebot,6) ) { set %dtprerelnrshow $+ $1 $did(dprebot,6) | set %dtprerelnr $+ $1 %dtpreprefix $+ $did(dprebot,6) } | elseif ( $did(dprebot,6) == $null ) { unset %dtprerelnrshow $+ $1 | unset %dtprerelnr $+ $1 }
}
alias dtusage { 
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool usage for $readini(d-tool\sections.ini,name,$1) $+ :
  var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %asn = $readini(d-tool\d-tool.ini,sites,%a) | var %asni = $readini(d-tool\d-tool.ini,sites,%a) $+ .ini
    if ($readini(d-tool\inis\ $+ %asni,sections,dlight $+ $1)) { aline -p @d-tool  %asn - $readini(d-tool\inis\ $+ %asni,sections,dlight $+ $1) $readini(d-tool\inis\ $+ %asni,sections,dlight $+ $1 $+ dir) }
    inc %a
  }
}
alias dtfta { 
  var %fta1 = $1 | var %fta2 = $1 $+ .ini
  if ($readini(d-tool\inis\ $+ %fta2,%fta1,fillsite)) writeini -n d-tool\inis\ $+ %fta2 %fta1 affsite $readini(d-tool\inis\ $+ %fta2,%fta1,fillsite)
  elseif (!$readini(d-tool\inis\ $+ %fta2,%fta1,fillsite)) remini d-tool\inis\ $+ %fta2 %fta1 affsite 
  var %hlc = 1 | while ( %hlc <= 9 ) {
    if ($readini(d-tool\inis\ $+ %fta2,%fta1,fillsite $+ %hlc)) writeini -n d-tool\inis\ $+ %fta2 %fta1 affsite $+ %hlc $readini(d-tool\inis\ $+ %fta2,%fta1,fillsite $+ %hlc)
    elseif (!$readini(d-tool\inis\ $+ %fta2,%fta1,fillsite $+ %hlc)) remini d-tool\inis\ $+ %fta2 %fta1 affsite $+ %hlc
    inc %hlc
  }
}
alias dtnicks { if (%dtnicks) unset %dtnicks | var %zhg = 1 | while ( %zhg <= $readini(d-tool\d-tool.ini,sites,count) ) { var %rfc = $readini(d-tool\d-tool.ini,sites,%zhg) | if ( $readini(d-tool\inis\ $+ %rfc $+ .ini,%rfc,ircnick) !isin %dtnicks ) set %dtnicks %dtnicks $readini(d-tool\inis\ $+ %rfc $+ .ini,%rfc,ircnick) | inc %zhg } }
;;;BNC
alias dtbnc { if ( %bncdtmp == 1 ) { dialog -x bnc bnc | unset %bncdtmp } | else { dialog -m bnc bnc } }
alias bncrefresh { remini d-tool\bncsets.ini bncs | var %l = $lines(d-tool\bncsets.ini) | var %q = 1 | var %n = 1 | while ( %q <= %l ) { if ( [ isin $read(d-tool\bncsets.ini,%q) ) && ( = !isin $read(d-tool\bncsets.ini,%q) ) && ( [vars !isin $read(d-tool\bncsets.ini,%q) ) && ( bncs !isin $read(d-tool\bncsets.ini,%q) ) { writeini -p d-tool\bncsets.ini bncs %n $remove($read(d-tool\bncsets.ini,%q),[,]) | inc %n } | inc %q } | writeini -p d-tool\bncsets.ini bncs count $calc(%n - 1) }
;;;;;;;;;;;OMDBAPI
alias dimdb {
  if ( $1 == %dtimdbrls ) goto imdbstop | unset %dtimdbitem
  if ( *.*-* iswm $1 ) {
    set %dtimdbrls $1
    var %w = 2 
    while ( %w <= $numtok($1,46) ) { 
      if ( 20 isincs $gettok($1,%w,46) ) || ( 19 isincs $gettok($1,%w,46) ) || ( Rip isincs $gettok($1,%w,46) ) || ( TS isincs $gettok($1,%w,46) ) || ( LD isincs $gettok($1,%w,46) ) || ( R5 isincs $gettok($1,%w,46) ) || ( DVDSCR isincs $gettok($1,%w,46) ) { 
        set %imdb_wort $calc(%w -1) 
        if ( $regex($gettok($1,%w,46),[1-2][0-9][0-9][0-9]) == 1 ) set %dtimdbyear $gettok($1,%w,46) 
        goto wortcheckhalt1 
      }
      inc %w 
    } 
    :wortcheckhalt1
    var %b = 1 | while ( %b <= %imdb_wort ) { set %dtimdbitem %dtimdbitem $gettok($1,%b,46) | inc %b }
    set %dtimdbitem %dtimdbitem 
    dtomdb %dtimdbitem
  }
  else { set %dtimdbrls $1- | set %dtimdbitem $1- | dtomdb %dtimdbitem }
  :imdbstop
}
alias dtomdb { set %dtomdbt $replace($1-,$chr(32),+) | sockclose domdb | sockopen domdb www.omdbapi.com 80 }
on *:sockopen:domdb:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  } 
  if (!%dtimdbyear) { sockwrite -n $sockname GET /?apikey= $+ $readini(d-tool\d-tool.ini,vars,omdbapikey) $+ &t= $+ %dtomdbt $+ &r=xml HTTP/1.1
  }
  elseif (%dtimdbyear) { sockwrite -n $sockname GET /?apikey= $+ $readini(d-tool\d-tool.ini,vars,omdbapikey) $+ &t= $+ %dtomdbt $+ &y= $+ %dtimdbyear $+ &r=xml HTTP/1.1  
    unset %dtimdbyear
  }
  sockwrite -n $sockname Host: www.omdbapi.com $+ $crlf $+ $crlf
  sockwrite -n $sockname Content-Type: application/xml
}
on *:sockread:domdb:{
  if ($sockerr) {
    aline -p @d-tool_db error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    var %r = 1 | while ( %r <= 50 ) { 
      if ( root response= $+ $chr(34) $+ False $+ $chr(34) isin %temptext ) && ( Invalid API key isin %temptext ) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 15IMDb: %temptext | goto imdbend }
      if ( movie title= isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omTITLE = $gettok(%temptext,%r,34) }
      if ( year= isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omYEAR = $gettok(%temptext,%r,34) }
      if ( tt isin $gettok(%temptext,%r,34) ) && ( imdbID isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omLINK = https://www.imdb.com/title/ $+ $gettok(%temptext,%r,34) }
      if ( language= isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omLANGUAGE = $remove( $gettok(%temptext,%r,34),$chr(32)) }
      if ( country= isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omCOUNTRY = $remove( $gettok(%temptext,%r,34),$chr(32)) }
      if ( genre= isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omGENRE = $remove( $gettok(%temptext,%r,34),$chr(32)) }
      if ( imdbRating isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omRATING = $gettok(%temptext,%r,34) } 
      if ( imdbVotes isin $gettok(%temptext,$calc(%r - 1),34) ) { var %omVOTES = $gettok(%temptext,%r,34) }
      if ( type= isin $gettok(%temptext,%r,34) ) {
        if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && ( %dtimdbitem ) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 14IMDb: %dtimdbrls - %omTITLE 14Rating: %omRATING $+ /10 by %omVOTES Voters 14Language: %omLANGUAGE 14Country: %omCOUNTRY 14Genre: %omGENRE 14Year: %omYEAR 14Link: %omLINK }
        if ( %dtimdbcount == $null ) { set %dtimdbcount 1 } | elseif ( %dtimdbcount >= 10 ) { set %dtimdbcount 1 } | else { inc %dtimdbcount } 
        var %d = 1 | while ( %d <= 20 ) { ; !! Wert 20 auch in Line 1254 einstellen !!
          if ( %dtimdbrls isin $eval(% $+ dtimdbr $+ %d,2) ) goto noimdbentry
          inc %d
        }
        set % $+ dtimdbr $+ %dtimdbcount $remove(%dtimdbrls,$chr(32),_) %omRATING %omVOTES %omLANGUAGE %omCOUNTRY %omGENRE %omYEAR
        :noimdbentry
        unset %dtimdbyear
      } 
      inc %r
    }
  }
  :imdbend
}
;;;;;;;;;;;;;;;;TVMAZE
alias dmaze {
  if ( . isin $1 ) {
    var %tvisave = %dtmazeitem | unset %dtmazeitem
    set %dtmazerls $1
    var %w = 1 | while ( %w <= $numtok($1,46) ) { 
      ;Datum nicht erlaubt;;;start
      var %tmp = $gettok($1,%w,46) | if ( $regex(%tmp,S[0-9]) == 1 ) || ( %tmp == US ) || ( %tmp == UK ) || ( $regex($eval(%tmp,1),[1-2][0-9][0-9][0-9]) == 1 ) { set %tvmaze_wort $calc(%w -1) | goto wortcheckhalt3 } 
      inc %w 
    }
    ;Datum nicht erlaubt;;;ende
    :wortcheckhalt3
    var %b = 1 | while ( %b <= %tvmaze_wort ) { set %dtmazeitem %dtmazeitem $gettok($1,%b,46) | inc %b }
    var %tvs = 1 | while ( %tvs <= $numtok($1,46) ) {
      if ( %tvmaze_wort == %tvs ) { if ( $gettok($1,%tvs,46) == $gettok(%tvisave,%tvs,95) ) goto tvmazestop }
      inc %tvs 
    }
    if ( %tvisave == %dtmazeitem ) goto tvmazestop | dtgetmaze %dtmazeitem
  }
  else { set %dtmazerls $1- | set %dtmazeitem $1- | dtgetmaze %dtmazeitem }
  :tvmazestop
}
alias dtgetmaze { 
  if ( $readini(d-tool\tvmaze.db,$replace(%dtmazeitem,$chr(32),.),$replace(%dtmazeitem,$chr(32),.),item) != $replace(%dtmazeitem,$chr(32),.) ) {
    sockclose dmaze
    if ( $chr(46) isin $1- ) { set %dtmazelink /singlesearch/shows?q= $+ $replace($1-,$chr(46),-) }
    else set %dtmazelink /singlesearch/shows?q= $+ $replace($1-,$chr(32),$chr(37) $+ 20) 
    sockopen -e dmaze api.tvmaze.com +443
  }
}
on *:sockopen:dmaze:{ 
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  sockwrite -n $sockname GET %dtmazelink HTTP/1.1
  sockwrite -n $sockname Host: api.tvmaze.com $+ $crlf $+ $crlf 
}
on *:sockread:dmaze:{
  if ($sockerr) {
    aline -p @d-tool_db error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    if ( tvmaze.com/shows isin %temptext ) { 
      var %x = 1 | while ( %x <= 300 ) {
        if ( $left($right(%temptext,%x),7) == /shows/ ) { 
          set %dtmazeurl $left($right(%temptext,%x),12) | var %x 400
        }
        inc %x
      }
      set %dtmazeurl $remove(%dtmazeurl,",$chr(125),$chr(44))
      dtgetapi
    }
  }
}
alias dtgetapi { 
  sockclose dmaze1
  sockopen -e dmaze1 api.tvmaze.com +443
}
on *:sockopen:dmaze1:{ 
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  sockwrite -n $sockname GET %dtmazeurl HTTP/1.1
  sockwrite -n $sockname Host: api.tvmaze.com $+ $crlf $+ $crlf 
}
on *:sockread:dmaze1:{
  if ($sockerr) {
    aline -p @d-tool_db error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    ; echo @d-tool %temptext
    ;;Type
    set %dtmazedata $replace(%dtmazeitem,$chr(32),.)
    if ( "Scripted" isin %temptext ) { set %dtmazedata $replace(%dtmazeitem,$chr(32),.) Scripted | var %tsw = 1 } 
    if ( "Action" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Action | else { set %dtmazedata %dtmazedata Action | var %tsw = 1 } }
    if ( "Adult" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Adult | else { set %dtmazedata %dtmazedata Adult | var %tsw = 1 } }
    if ( "Mystery" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Mystery | else { set %dtmazedata %dtmazedata Mystery | var %tsw = 1 } }
    if ( "Reality" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Reality | else { set %dtmazedata %dtmazedata Reality | var %tsw = 1 } } 
    if ( "Fantasy" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Fantasy | else { set %dtmazedata %dtmazedata Fantasy | var %tsw = 1 } }
    if ( "Drama" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Drama | else { set %dtmazedata %dtmazedata Drama | var %tsw = 1 } }
    if ( "Adventure" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Adventure | else { set %dtmazedata %dtmazedata Adventure | var %tsw = 1 } }
    if ( "Romance" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Romance | else { set %dtmazedata %dtmazedata Romance | var %tsw = 1 } }
    if ( "Comedy" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Comedy | else { set %dtmazedata %dtmazedata Comedy | var %tsw = 1 } }
    if ( "Children" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Kids | else { set %dtmazedata %dtmazedata Kids | var %tsw = 1 } }
    if ( "Science-Fiction" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /SciFi | else { set %dtmazedata %dtmazedata SciFi | var %tsw = 1 } }
    if ( "Music" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Music | else { set %dtmazedata %dtmazedata Music | var %tsw = 1 } }
    if ( "Western" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Western | else { set %dtmazedata %dtmazedata Western | var %tsw = 1 } }   
    if ( "Thriller" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Thriller | else { set %dtmazedata %dtmazedata Thriller | var %tsw = 1 } }
    if ( "Crime" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Crime | else { set %dtmazedata %dtmazedata Crime | var %tsw = 1 } }    
    if ( "animation" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Animation | else { set %dtmazedata %dtmazedata Animation | var %tsw = 1 } }
    if ( "talk show" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Talk_Show | else { set %dtmazedata %dtmazedata Talk_Show | var %tsw = 1 } }
    if ( "documentary" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Documentary | else { set %dtmazedata %dtmazedata Documentary | var %tsw = 1 } }
    if ( "game show" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Game_Show | else { set %dtmazedata %dtmazedata Game_Show | var %tsw = 1 } }
    if ( "news" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /News | else { set %dtmazedata %dtmazedata News | var %tsw = 1 } }
    if ( "sports" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Sports | else { set %dtmazedata %dtmazedata Sports | var %tsw = 1 } }
    if ( "variety" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Variety | else { set %dtmazedata %dtmazedata Variety | var %tsw = 1 } }
    if ( "Award Show" isin %temptext ) { if ( %tsw == 1 ) set %dtmazedata %dtmazedata $+ /Award_Show | else { set %dtmazedata %dtmazedata Award_Show | var %tsw = 1 } }
    ;;Country/Language
    if ( "US" isincs %temptext ) && ( "language":"English" isincs %temptext ) { set %dtmazedata %dtmazedata US/English }
    elseif ( "Netflix" isincs %temptext ) && ( "language":"English" isincs %temptext ) { set %dtmazedata %dtmazedata US/English }
    elseif ( "Paramount" isincs %temptext ) && ( "language":"English" isincs %temptext ) { set %dtmazedata %dtmazedata US/English }
    elseif ( "United Kingdom" isincs %temptext ) && ( "language":"English" isincs %temptext ) set %dtmazedata %dtmazedata UK/English
    elseif ( "Australia" isincs %temptext ) && ( "language":"English" isincs %temptext ) set %dtmazedata %dtmazedata AU/English
    elseif ( "Canada" isincs %temptext ) && ( "language":"English" isincs %temptext ) set %dtmazedata %dtmazedata CA/English
    ;elseif wegen only English folgend
    elseif ( "language":"English" isincs %temptext ) set %dtmazedata %dtmazedata ?/English
    if ( "US" isincs %temptext ) && ( "language":"English" !isincs %temptext ) { set %dtmazedata %dtmazedata US }
    if ( "German" isincs %temptext ) set %dtmazedata %dtmazedata German
    if ( "Norwegian" isincs %temptext ) set %dtmazedata %dtmazedata Norwegian
    if ( "Swedish" isincs %temptext ) set %dtmazedata %dtmazedata Swedish
    if ( "Spanish" isincs %temptext ) set %dtmazedata %dtmazedata Spanish
    if ( "Bulgarian" isincs %temptext ) set %dtmazedata %dtmazedata Bulgarian
    if ( "Czech" isincs %temptext ) set %dtmazedata %dtmazedata Czech
    if ( "Chinese" isincs %temptext ) set %dtmazedata %dtmazedata Chinese
    if ( "Danish" isincs %temptext ) set %dtmazedata %dtmazedata Danish
    if ( "Dutch" isincs %temptext ) set %dtmazedata %dtmazedata Dutch
    if ( "Portuguese" isincs %temptext ) set %dtmazedata %dtmazedata Portuguese
    if ( "Finnish" isincs %temptext ) set %dtmazedata %dtmazedata Finnish
    if ( "French" isincs %temptext ) set %dtmazedata %dtmazedata French
    if ( "Irish" isincs %temptext ) set %dtmazedata %dtmazedata Irish
    if ( "Greek" isincs %temptext ) set %dtmazedata %dtmazedata Greek
    if ( "Hungarian" isincs %temptext ) set %dtmazedata %dtmazedata Hungarian
    if ( "Icelandic" isincs %temptext ) set %dtmazedata %dtmazedata Icelandic
    if ( "Italian" isincs %temptext ) set %dtmazedata %dtmazedata Italian
    if ( "Japanese" isincs %temptext ) set %dtmazedata %dtmazedata Japanese
    if ( "Vietnamese" isincs %temptext ) set %dtmazedata %dtmazedata Vietnamese
    if ( "Korean" isincs %temptext ) set %dtmazedata %dtmazedata Korean
    if ( "Mandarin" isincs %temptext ) set %dtmazedata %dtmazedata Mandarin
    if ( "Hindi" isincs %temptext ) set %dtmazedata %dtmazedata Hindi
    if ( "Arabic" isincs %temptext ) set %dtmazedata %dtmazedata Arabic
    if ( "Bengali" isincs %temptext ) set %dtmazedata %dtmazedata Bengali
    if ( "Polish" isincs %temptext ) set %dtmazedata %dtmazedata Polish
    if ( "Romanian" isincs %temptext ) set %dtmazedata %dtmazedata Romanian
    if ( "Russian" isincs %temptext ) set %dtmazedata %dtmazedata Russian
    if ( "Scots" isincs %temptext ) set %dtmazedata %dtmazedata Scots
    if ( "Slovenian" isincs %temptext ) set %dtmazedata %dtmazedata Slovenian
    if ( "Thai" isincs %temptext ) set %dtmazedata %dtmazedata Thai
    if ( "Turkish" isincs %temptext ) set %dtmazedata %dtmazedata Turkish
    if ( "Ukrainian" isincs %temptext ) set %dtmazedata %dtmazedata Ukrainian
    if ( "Urdu" isincs %temptext ) set %dtmazedata %dtmazedata Urdu
    if ( "Indonesian" isincs %temptext ) set %dtmazedata %dtmazedata Indonesian
    if ( "Nigerian" isincs %temptext ) set %dtmazedata %dtmazedata Nigerian
    if ( $gettok(%dtmazedata,3,32) == $null ) set %dtmazedata %dtmazedata NA
    ;;Status/Current
    if ( "Running" isincs %temptext ) set %dtmazedata %dtmazedata Running
    if ( "Ended" isincs %temptext ) set %dtmazedata %dtmazedata Ended
    if ( "to be determined" isin %temptext ) set %dtmazedata %dtmazedata To_Be_Determined
    if ( "in development" isin %temptext ) set %dtmazedata %dtmazedata In_Development
    ;
    if ( }}} isin %temptext ) { dtgetseason | .timer 1 1 dmazewdata2 | sockclose dmaze1 }
  }
}
alias dtgetseason { 
  sockclose dmaze2
  sockopen -e dmaze2 api.tvmaze.com +443
}
on *:sockopen:dmaze2:{ 
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  sockwrite -n $sockname GET %dtmazeurl $+ /seasons HTTP/1.1
  sockwrite -n $sockname Host: api.tvmaze.com $+ $crlf $+ $crlf
}
on *:sockread:dmaze2:{
  if ($sockerr) {
    aline -p @d-tool_db error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    var %n = 1 | while ( %n <= 60 ) {
      if ( $chr(34) $+ number $+ $chr(34) $+ $chr(58) $+ %n isin %temptext ) && ( $chr(34) $+ premiereDate $+ $chr(34) $+ $chr(58) $+ null !isin %temptext ) { set %dtmazedata $remove(%dtmazedata,$chr(32) $+ $calc(%n -1)) %n | var %rtg = 1 }
      inc %n
    }
    if ( $chr(93) isin %temptext ) || ( ] isin %temptext ) { dmazewdata | sockclose dmaze2 }
  } 
}
alias dmazewdata {
  if (%dtmazedata) writeini -n d-tool\tvmaze.db $replace($gettok(%dtmazedata,1,32),$chr(32),$chr(46)) item $replace($gettok(%dtmazedata,1,32),$chr(32),$chr(46))  
  if ($gettok(%dtmazedata,2-,32)) writeini -n d-tool\tvmaze.db $replace($gettok(%dtmazedata,1,32),$chr(32),$chr(46)) data $gettok(%dtmazedata,2-,32)
}
alias dmazewdata2 {
  if (%dtmazedata) writeini -n d-tool\tvmaze.db $replace($gettok(%dtmazedata,1,32),$chr(32),$chr(46)) item $replace($gettok(%dtmazedata,1,32),$chr(32),$chr(46))  
  if ($gettok(%dtmazedata,2-,32)) && ($gettok(%dtmazedata,1,32)) writeini -n d-tool\tvmaze.db $replace($gettok(%dtmazedata,1,32),$chr(32),$chr(46)) data $gettok(%dtmazedata,2-,32)  
  ;5:genre:country:lang:status:seasons
  if ($gettok(%dtmazedata,6,32)) {
    if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && (%dtmazedata) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 14TVMaze: $replace(%dtmazerls,$chr(35),$chr(32)) - $replace($gettok(%dtmazedata,1,32),.,$chr(32)) 14Type/Genre: $replace($gettok(%dtmazedata,2,32),_,$chr(32)) 14Country/Language: $gettok(%dtmazedata,3,32) $+ / $+ $gettok(%dtmazedata,4,32) 14Seasons: $replace($gettok(%dtmazedata,6,32),_,$chr(32)) 14Status: $replace($gettok(%dtmazedata,5,32),_,$chr(32)) 14Link: https://www.tvmaze.com $+ %dtmazeurl }
  }
  if (!$gettok(%dtmazedata,5,32)) {
    ;4:genre:country:lang:status
    if ( Running == $gettok(%dtmazedata,5,32) ) || ( Ended == $gettok(%dtmazedata,5,32) ) || ( To_Be_Determined == $gettok(%dtmazedata,5,32) ) || ( In_Development == $gettok(%dtmazedata,5,32) ) {
      if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && (%dtmazedata) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 14TVMaze: $replace(%dtmazerls,$chr(35),$chr(32)) - $replace($gettok(%dtmazedata,1,32),.,$chr(32)) 14Type/Genre: $replace($gettok(%dtmazedata,2,32),_,$chr(32)) 14Country/Language: $gettok(%dtmazedata,3,32) $+ / $+ $gettok(%dtmazedata,4,32) 14Seasons: na 14Status: $replace($gettok(%dtmazedata,5,32),_,$chr(32)) 14Link: https://www.tvmaze.com $+ %dtmazeurl }
    }
    ;4:genre:country:status:seasons
    if ( Running == $gettok(%dtmazedata,4,32) ) || ( Ended == $gettok(%dtmazedata,4,32) ) || ( To_Be_Determined == $gettok(%dtmazedata,4,32) ) || ( In_Development == $gettok(%dtmazedata,4,32) ) {
      if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && (%dtmazedata) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 14TVMaze: $replace(%dtmazerls,$chr(35),$chr(32)) - $replace($gettok(%dtmazedata,1,32),.,$chr(32)) 14Type/Genre: $replace($gettok(%dtmazedata,2,32),_,$chr(32)) 14Country/Language: $gettok(%dtmazedata,3,32) 14Seasons: na 14Status: $replace($gettok(%dtmazedata,4,32),_,$chr(32)) 14Link: https://www.tvmaze.com $+ %dtmazeurl }
    }
  }
  ;3:genre:country:status
  elseif (!$gettok(%dtmazedata,5,32)) {
    if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && (%dtmazedata) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 14TVMaze: $replace(%dtmazerls,$chr(35),$chr(32)) - $replace($gettok(%dtmazedata,1,32),.,$chr(32)) 14Type/Genre: $replace($gettok(%dtmazedata,2,32),_,$chr(32)) 14Country/Language: $gettok(%dtmazedata,3,32) 14Seasons: na 14Status: $replace($gettok(%dtmazedata,4,32),_,$chr(32)) 14Link: https://www.tvmaze.com $+ %dtmazeurl }
  }
  else { if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && (%dtmazedata) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db $timestamp 14TVMaze: $replace(%dtmazerls,$chr(35),$chr(32)) - $replace($gettok(%dtmazedata,1,32),.,$chr(32)) 14Type/Genre: $replace($gettok(%dtmazedata,2,32),_,$chr(32)) 14Country/Language: $gettok(%dtmazedata,3,32) 14Seasons: na 14Status: $replace($gettok(%dtmazedata,4,32),_,$chr(32)) 14Link: https://www.tvmaze.com $+ %dtmazeurl } }

  unset %dtmaze*
}
alias dmazedb {
  if ($1-) {
    var %1 = $readini(d-tool\tvmaze.db,$replace($1-,$chr(32),.),item)
    var %2 = $readini(d-tool\tvmaze.db,$replace($1-,$chr(32),.),data)
    if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) && (%1) { window -zkbe @d-tool_db font $readini(d-tool\d-tool.ini,vars,imdbfsize) iconfile d-tool\logo\dtool.ico | aline -p @d-tool_db TVMaze-DBSearch - %1 | aline -p @d-tool_db TVMaze-DBSearch - %2 }
    else echo -a No Entry
  }
}
;;;;;;;;;;;;;;;;CB_API
alias dcbs { set %dcbs 1 | dcb $1- }
alias dcb {
  if ( $1 != all ) && ( *-* !iswm $1 ) {
    if ( %dcbs = 1 ) set %cbapicmd search $2- | else set %cbapicmd $2- | set %cbapisites [" $+ $1 $+ "]  
    sockclose dcbapi
    sockopen -e dcbapi $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
    if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool (3 $remove(%cbapisites,",],[) ) %cbapicmd | unset %dcbs 
  } 
  elseif ( $1 == all ) || ( *-* iswm $1 ) {  
    if ( %dcbs = 1 ) && ( *-* iswm $1 ) { set %cbapicmd search $1 | else set %cbapicmd $1 | sockclose dcbapi | unset %cbapisites }  
    elseif ( %dcbs = 1 ) { set %cbapicmd search $2- | else set %cbapicmd $2- | sockclose dcbapi | unset %cbapisites }
    else  { set %cbapicmd $2- | sockclose dcbapi | unset %cbapisites }
    var %zt = 1 | while ( %zt <= $readini(d-tool\d-tool.ini,sites,count) ) {
      if (!%cbapisites) set %cbapisites " $+ $readini(d-tool\d-tool.ini,sites,%zt) $+ " | else set %cbapisites %cbapisites $+ $chr(44) " $+ $readini(d-tool\d-tool.ini,sites,%zt) $+ "
      inc %zt
    }
    set %cbapisites $replace(%cbapisites,""," $+ $chr(44) $+ ") | set %cbapisites $chr(91) $+ %cbapisites $+ $chr(93)
    sockopen -e dcbapi $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
    if ( %dtcbreqsearchs != 1 ) && ( %dtcbincsearchs != 1 ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool (3 $+ all $+ ) %cbapicmd } | unset %dcbs
  }
}
on *:sockopen:dcbapi:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  ;test curl -v --insecure -u :apipassword https://localhost:55477/sites/xxx | curl -ku :password https://localhost:55477/raw -d '{"command": "site stat", "sites": ["site"]}'
  var %so = sockwrite -nt $sockname | var %cbcmd = $chr(123) $+ "command": "site %cbapicmd $+ ", "sites": %cbapisites $+ $chr(125)
  %so POST /raw HTTP/1.1
  %so Host: $readini(d-tool\d-tool.ini,vars,cbftpip)
  %so Content-Type: application/json
  %so Authorization: Basic $encode(: $+ $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) $+ ,m)
  %so User-Agent: */*
  %so Content-Length: $len(%cbcmd)
  %so $crlf $+ %cbcmd
}
on *:sockread:dcbapi:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    if ( "name" isin %temptext ) { set %cbapisites $remove(%temptext,name,$chr(44),$chr(32),$chr(58)) | set %dtposton 1 }
    if ( result isin %temptext || * iswm %temptext ) && (%dtposton) {  
      if ( %dtposton >= 2 ) {
        var %tr = 1 | while ( %tr <= $numtok($remove(%temptext,"result":,",\n),92) ) {
          var %tz = $remove($gettok($remove(%temptext,"result":,",=,\n,$chr(62)),%tr,92),r200-,r200)
          if ( %tz != r ) {
            if ( %dtcbreqsearchs == 1 ) && ( %dtcbincsearchs != 1 ) && ( / $+ %dtreqitem isin %tz ) { 
              if ( nuke !isin %tz ) && ( /extras !isin %tz ) && ( /sample !isin %tz ) && ( no-sfv !isin %tz ) && ( /proof !isin %tz ) && ( /Subs !isin %tz ) && ( /DVD !isin %tz ) && ( /Disc !isin %tz ) && ( /Covers !isin %tz ) && ( /CD !isincs %tz ) && ( incomplete !isin %tz ) && ( imdb !isin %tz ) {
                var %og = 1 | while ( %og <= $numtok(%tz,32) ) {
                  if ( %dtreqitem isin $gettok(%tz,%og,32) ) {
                    var %reqn = $remove(%cbapisites,",],[) | var %reqnini = %reqn $+ .ini | if (%reqn) && (%dtreqitem) && (%dtreqcount) && ( $readini(d-tool\inis\ $+ %reqnini,%reqn,reqfill) == 1 ) && ( %reqn != $readini(d-tool\d-tool.req.db,%reqrls,reqsite) ) { writeini -n d-tool\d-tool.req.db %dtreqitem %dtreqcount $+ site %reqn | writeini -n d-tool\d-tool.req.db %dtreqitem %dtreqcount $+ path $gettok(%tz,%og,32) } | inc %dtreqcount 
                  }
                  inc %og
                }
                ; VERBESSERUNG BEI SUCHEN UND REQS - INCS NOCH NICHT
              }
            }
            elseif ( %dtcbincsearchs == 1 ) && ( %dtcbreqsearchs != 1 ) && ( / $+ %dtincitem isin %tz ) && ( / $+ %dtincitem $+ / !isin %tz ) {
              if  ( nuke !isin %tz ) && ( /extras !isin %tz ) && ( /sample !isin %tz ) && ( no-sfv !isin %tz ) && ( /proof !isin %tz ) && ( /Subs !isin %tz ) && ( /DVD !isin %tz ) && ( /Disc !isin %tz ) && ( /Covers !isin %tz ) && ( /CD !isincs %tz ) && ( incomplete !isin %tz ) && ( imdb !isin %tz ) {
                var %incn = $remove(%cbapisites,",],[) | var %incnini = %incn $+ .ini
                if ( %dtincsite isin %incn ) { writeini -n d-tool\d-tool.inc.db %dtincitem incpath $gettok(%tz,1,32) | writeini -n d-tool\d-tool.inc.db %dtincitem incsite %dtincsite | if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) { if ( $window(@d-tool_inc) ) { aline -p @d-tool_inc $date $timestamp 7 Inc:15 %incn %dtincitem  $gettok(%tz,1,32) } | else { window -zkbD @d-tool_inc font $readini(d-tool\d-tool.ini,vars,incfsize) | aline -p @d-tool_inc 15 %dtwindowcount  $+ $date $timestamp 7 Inc:15 %incn %dtincitem  $gettok(%tz,1,32) } } }
                if ( $readini(d-tool\inis\ $+ %incnini,%incn,incfill) == 1 ) && ( %dtincsite !isin %incn ) { writeini -n d-tool\d-tool.inc.db %dtincitem %dtinccount $+ site %incn | writeini -n d-tool\d-tool.inc.db %dtincitem %dtinccount $+ path $gettok(%tz,1,32) } 
              }
              inc %dtinccount
            }
            if ( search isin %cbapicmd ) && ( */*.*-* iswm %tz || */*_*-* iswm %tz ) {
              if ( %dtcbreqsearchs != 1 ) && ( %dtcbincsearchs != 1 ) {
                if ( /sample !isin %tz ) && (  /disc !isin %tz ) && ( /extras !isin %tz ) && ( /subs !isin %tz ) && ( /proof !isin %tz ) && ( /covers !isin %tz ) && ( $chr(62) !isin %tz ) && ( [] !isin %tz ) {
                  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool 
                  var %og = 1 | while ( %og <= $numtok(%tz,32) ) {
                    if ( */*.*-* iswm $gettok(%tz,%og,32) ) || ( */*_*-* iswm $gettok(%tz,%og,32) ) aline -p @d-tool ( $+ $remove(%cbapisites,",],[) $+ )_15found:_ $+ $gettok(%tz,%og,32)
                    inc %og
                  }
                }
              }
            }
            elseif ( search !isin %cbapicmd ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool  $+ ( $+ $remove(%cbapisites,",],[) $+ )::: $remove(%tz,226,226-) }
          }
          inc %tr
        }
      }
      inc %dtposton
      if ( $chr(93) isin %temptext ) && ( $chr(93) $+ $chr(44) !isin %temptext ) && ( $regex(%temptext,[a-z]) != 1 ) { if (%dtcbreqsearchs) unset %dtcbreqsearchs | if (%dtcbincsearchs) unset %dtcbincsearchs | unset %dtposton } 
      :dcbend
    }
  }
}
alias dcbjobs {
  set %cbapiitem /spreadjobs?status=RUNNING | set %cbapisites $1 | set %dtjs 1 | .timer 1 3 unset %dtjs
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool (3 $+ cbftp $+ ) Running Spreadjobs 
  sockclose cbapis
  sockopen -e cbapis $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
}
alias dcbinfo {
  set %cbapiitem /info | set %cbapisites $1 | set %dtcbi 1 | .timer 1 3 unset %dtcbi
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool (3 $+ cbftp $+ ) Info 
  sockclose cbapis
  sockopen -e cbapis $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
}
alias dcbsite {
  if ( $2 == s ) set %dtnm 1 | set %dtsyncsite $1
  if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) {
    set %cbapiitem /sites/ $+ $1 | set %cbapisites $1 | unset %dtcbsources | unset %dtcbtargets
    sockclose cbapis
    sockopen -e cbapis $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
  }
}
on *:sockopen:cbapis:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  var %so = sockwrite -nt $sockname
  %so GET %cbapiitem HTTP/1.1
  %so Host: $readini(d-tool\d-tool.ini,vars,cbftpip)
  %so Content-Type: application/json
  %so Authorization: Basic $encode(: $+ $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) $+ ,m)
  %so User-Agent: */*
  %so Content-Length: $len(%cbcmd)
  %so $crlf $+ %cbcmd
  unset %cbapiitem
}
on *:sockread:cbapis:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  else {
    var %temptext | sockread %temptext
    if ( %dtcbi == 1 ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool  %temptext }
    if ( $chr(123) !isin %temptext ) && ( $chr(125) !isin %temptext ) && ( $chr(93) !isin %temptext ) && ( $chr(34) isin %temptext ) {
      if ( except_source isin %temptext ) set %syncs 1 | elseif ( %syncs == 1 ) && ( except_target !isin %temptext )  && ( force_binary !isin %temptext ) { set %dtcbsources %dtcbsources $+ $remove(%temptext,$chr(32),$chr(34)) }
      if ( except_target isin %temptext ) { unset %syncs | set %synct 1 } | elseif ( %synct == 1 ) && ( force_binary !isin %temptext ) { set %dtcbtargets %dtcbtargets $+ $remove(%temptext,$chr(32),$chr(34)) } 
      if ( force_binary isin %temptext ) { unset %syncs | unset %synct | if (!%dtnm) && (!dialog(dtool-sites)) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 3 %cbapisites sources:3 $replace(%dtcbsources,$chr(44),$chr(32))  $+ $chr(8226) targets:7 $replace(%dtcbtargets,$chr(44),$chr(32)) } | else unset %dtnm | unset %dtsyncsite 
        if (%dtcbsources) writeini d-tool\inis\ $+ %cbapisites $+ .ini %cbapisites cbsources %dtcbsources | else remini d-tool\inis\ $+ %cbapisites $+ .ini %cbapisites cbsources | if (%dtcbtargets) writeini d-tool\inis\ $+ %cbapisites $+ .ini %cbapisites cbtargets %dtcbtargets | else remini d-tool\inis\ $+ %cbapisites $+ .ini %cbapisites cbtargets
      }
      elseif ( *.*-* iswm %temptext ) && ( %dtjs == 1 ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool  %temptext }
    }
  }
}
alias dcbsync { 
  ; syntax: dcbsync site s/t/a site/grp site/grp ... | curl -ku :passwd -X PATCH https://localhost:55477/sites/we -d '{"except_target_sites": ["xx", "xxx"]}' <-funzt im terminal, mit -vku sieht man was gesendet wird
  if ($3) set %cbsyncitem $chr(34) $+ $replace($3-,$chr(32), $+ $chr(34) $+ $chr(44) $chr(34)) $+ $chr(34)
  if (!$3) { 
    var %gnm = 1 | while ( %gnm <= $readini(d-tool\inis\ $+ $1 $+ .ini,$1,aentrys) ) {
      if ( $chr(124) !isin $readini(d-tool\inis\ $+ $1 $+ .ini,affils,a $+ %gnm) ) var %cbsyncline %cbsyncline $remove($readini(d-tool\inis\ $+ $1 $+ .ini,affils,a $+ %gnm),-)
      inc %gnm
    }
    set %cbsyncitem $chr(34) $+ $replace(%cbsyncline,$chr(32), $+ $chr(34) $+ $chr(44) $chr(34)) $+ $chr(34))
  }
  set %cbapisite /sites/ $+ $1 | set %cbapisites $1
  if ( $2 == t ) set %cbapicmd {"except_target_sites": [ $+ %cbsyncitem $+ ]} | if ( $2 === s ) set %cbapicmd {"except_source_sites": [ $+ %cbsyncitem $+ ]} | if ( $2 == a ) set %cbapicmd {"affils": [ $+ %cbsyncitem $+ ]}
  if ( $2 === S ) {
    write -al1 d-tool\tempsecs.txt {"sections": [ | var %rl = 1 | while ( %rl <= $readini(d-tool\sections.ini,name,count) ) {
      if ($readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %rl)) && ( fake !isin $readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %rl) ) write -al1 d-tool\tempsecs.txt {"name": " $+ $readini(d-tool\sections.ini,name,%rl) $+ ","path": "/ $+ $readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %rl $+ dir) $+ "}
      if ( %rl != $readini(d-tool\sections.ini,name,count) ) && ($readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %rl)) && ( fake !isin $readini(d-tool\inis\ $+ $1 $+ .ini,sections,dlight $+ %rl) ) write -al1 d-tool\tempsecs.txt , 
      inc %rl
    }
    if ( $right($read(d-tool\tempsecs.txt),1) == $chr(44) ) write -l1 d-tool\tempsecs.txt $left($read(d-tool\tempsecs.txt),$calc($len($read(d-tool\tempsecs.txt)) -1)) | write -al1 d-tool\tempsecs.txt ]} | set %cbapicmd $read(d-tool\tempsecs.txt) | .remove d-tool\tempsecs.txt
  } 
  if (!%dtnm) && ( $2 === S ) { aline -p @d-tool (3 $1 ) synced all sections with cbftp }
  elseif (!%dtnm) && ( $2 == a || $2 === s ) { aline -p @d-tool (3 $1 ) synced cbftp $replace($replace($replace($2,s,source),t,target),a,affil) $+ s:  $remove($replace(%cbsyncitem,$chr(44),$chr(32)),") }
  sockclose dtsync 
  sockopen -e dtsync $readini(d-tool\d-tool.ini,vars,cbftpip) $readini(d-tool\d-tool.ini,vars,cbftpport)
}
alias dlgssync { 
  if ( $did(dtool-sites,$1).seltext != -none- ) && ( $did(dtool-sites,$1).seltext !isin %dtcbtargets ) && ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) { 
    dcbsync %dtsetsite t $eval($replace(%dtcbtargets,$chr(44),$chr(32)),3) $did(dtool-sites,$1).seltext | set %dtcbtargets %dtcbtargets $+ $chr(44) $+ $did(dtool-sites,$1).seltext | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool (3 %dtsetsite ) added $did(dtool-sites,$1).seltext to cbftp targets 
  }
}
on *:sockopen:dtsync:{
  if ($sockerr) {
    aline -p @d-tool error.
    halt
  }
  var %so = sockwrite -nt $sockname
  %so PATCH %cbapisite HTTP/1.1
  %so Host: $readini(d-tool\d-tool.ini,vars,cbftpip) $+ : $+ $readini(d-tool\d-tool.ini,vars,cbftpport)
  %so Content-Type: application/json
  %so Authorization: Basic $encode(: $+ $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) $+ ,m)
  %so User-Agent: */*
  %so Content-Length: $len(%cbapicmd)
  %so $crlf $+ %cbapicmd
  unset %cbapisite | unset %cbapicmd | unset %cbsyncitem
}
;;;;;;;;;;;;;;;;;REMOTE
on 1:notice:*:*: { if ( $1 != !getmircver ) { if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) { window -ezfkbd $readini(d-tool\d-tool.ini,vars,seriesborder) @d-tool font $readini(d-tool\d-tool.ini,vars,searchfsize) | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) @d-tool | aline -p @d-tool $timestamp 15Remote cmd by $nick -  $1- } } }
;;;;;;;;;;;;;;;;;
;19/10/2024 15:59
