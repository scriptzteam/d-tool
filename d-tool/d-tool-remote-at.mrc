;; remote Script for d-tool autotrader ;;
;; written by del
on 1:notice:!info*:?: {
  if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) {
    if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) { 
      if ($timer(login)) { var %dtr = on' | writeini d-tool\d-tool.ini vars logintimers 1 } | else { var %dtr = off' | writeini d-tool\d-tool.ini vars logintimers 0 } | if ( %dtpreoff == 1 ) var %pstat = off | else var %pstat = on
      notice $nick d-tool info 14( $+ $remove($read(d-tool\d-tool.mrc,2),;,$chr(32),d-tool,.v) runs $uptime(mirc,2) ) - 14loginchk: [lm+strg] sync.target: [rm+strg] sync.source: [rm+shift]
      notice $nick status $readini(d-tool\d-tool.ini,vars,status)  $+ $chr(8226) at $replace(%dttrade,1,on,0,off)  $+ $chr(8226) affils $replace(%dtaffils,1,on,0,off)  $+ $chr(8226) precheck %pstat  $+ $chr(8226) reqs $replace(%dtreqfill,1,on,0,off)  $+ $chr(8226) tvmaze $replace($readini(d-tool\d-tool.ini,vars,tv),1,on)  $+ $chr(8226) imdb $replace($readini(d-tool\d-tool.ini,vars,imdbs),1,on)  $+ $chr(8226) incs $replace(%dtincfill,1,on,0,off)  $+ $chr(8226) login $replace(%dtr,on,3on,off,7off) ( $+ $readini(d-tool\d-tool.ini,vars,logintimer) $+ h) 
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
        if ( $readini(d-tool\inis\ $+ %wini,%w,reqfill) == 1 ) var %reqfill = - reqfiller 3on | else var %reqfill = - reqfiller 7off
        var %affilsites = $readini(d-tool\inis\ $+ %wini,%w,affsite) $readini(d-tool\inis\ $+ %wini,%w,affsite1) $readini(d-tool\inis\ $+ %wini,%w,affsite2) $readini(d-tool\inis\ $+ %wini,%w,affsite3) $readini(d-tool\inis\ $+ %wini,%w,affsite4) $readini(d-tool\inis\ $+ %wini,%w,affsite5) $readini(d-tool\inis\ $+ %wini,%w,affsite6) $readini(d-tool\inis\ $+ %wini,%w,affsite7) $readini(d-tool\inis\ $+ %wini,%w,affsite8) $readini(d-tool\inis\ $+ %wini,%w,affsite9)
        if ( $readini(d-tool\inis\ $+ %wini,%w,fillsite) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite1) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite2) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite3) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite4) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite5) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite6) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite7) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite8) ) || ( $readini(d-tool\inis\ $+ %wini,%w,fillsite9) ) { 
          notice $nick %q $+  %w $+ . $+ $chr(8226) $+ 3 $+ %fillers 7 $+ $readini(d-tool\inis\ $+ %wini,%w,fillsite) $readini(d-tool\inis\ $+ %wini,%w,fillsite1) $readini(d-tool\inis\ $+ %wini,%w,fillsite2) $readini(d-tool\inis\ $+ %wini,%w,fillsite3) $readini(d-tool\inis\ $+ %wini,%w,fillsite4) $readini(d-tool\inis\ $+ %wini,%w,fillsite5) $readini(d-tool\inis\ $+ %wini,%w,fillsite6) $readini(d-tool\inis\ $+ %wini,%w,fillsite7) $readini(d-tool\inis\ $+ %wini,%w,fillsite8) $readini(d-tool\inis\ $+ %wini,%w,fillsite9) (3 $+ $replace($readini(d-tool\inis\ $+ %wini,%w,cbsources),$chr(44),$chr(32)) /7 $replace($readini(d-tool\inis\ $+ %wini,%w,cbtargets),$chr(44),$chr(32)) $+ ) - status %msg login %msgl - affils to3  %affilsites  $+ %reqfill %desc 
        }
        else notice $nick %q $+  %w $+ . $+ $chr(8226) $+ 3 $+ %fillers none (3 $+ $replace($readini(d-tool\inis\ $+ %wini,%w,cbsources),$chr(44),$chr(32)) /7 $replace($readini(d-tool\inis\ $+ %wini,%w,cbtargets),$chr(44),$chr(32)) $+ ) - status %msg login %msgl - affils to3  %affilsites  $+ %reqfill %desc
        inc %q
      }
      unset %sitefillers* | unset %fillers
    }
  }
}
on 1:notice:!dton*:?: if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) { if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) { dton } }
on 1:notice:!dtoff*:?: if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) { if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) { dtoff } }
on 1:notice:!sync*:?: {
  if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) {
    if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) {
      dcbsync $3 $4 $5- 
    }
  }
}
on 1:notice:!affils*:?: {
  if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) {
    if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) {
      var %nr1 = 1 | while ( %nr1 <= $readini(d-tool\d-tool.ini,sites,count) ) { 
        var %asite = $readini(d-tool\d-tool.ini,sites,%nr1) | var %asiteini = %asite $+ .ini | var %nr2 = 1 
        while ( %nr2 <= $readini(d-tool\inis\ $+ %asiteini,%asite,aentrys) ) {
          if ( - isin $readini(d-tool\inis\ $+ %asiteini,affils,a $+ %nr2) ) {
            var %aentry = %aentry $readini(d-tool\inis\ $+ %asiteini,affils,a $+ %nr2)
            var %affoutput = %aentry
          }
          inc %nr2
        }
        if (%affoutput) notice $nick 15[ $+ %asite $+ ] $remove(%affoutput,-)
        unset %aentry | unset %affoutput
        inc %nr1 
      }
    }
  }
}
on 1:notice:!login*:?: if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) { if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) { dtlt } }
on 1:notice:!cpu:?: if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) { cpuload | .timer 1 4 notice $nick CPULoad: $cpuload } 
alias cpuload {
  var %a = a $+ $ticks, %b = b $+ %a
  .comopen %a WbemScripting.SWbemLocator
  if $comerr { return COM Error }
  .comclose %a $com(%a,ConnectServer,1,dispatch* %b) 
  if $com(%b) { .comclose %b $com(%b,ExecQuery,1,bstr*,$&
    SELECT loadpercentage FROM Win32_Processor,dispatch* %a) }
  if !$com(%a) { return COM Error }
  %b = $comval(%a,1,loadpercentage)
  .comclose %a
  return %b
}
on 1:notice:!rushinfo*:?: {
  if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) {
    if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) {
      var %rushcontainer = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Containers.ContainerCount)
      var %rushconn = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Containers.ConnectedSiteCount)
      var %rushtran = $dll($scriptdir\rushmirc.dll,Invoke,RushApp.Containers.TransferSiteCount)
      notice $nick 4(0Containers4) 414 %rushcontainer 4 0Connected 414 %rushconn 4 0Transfering 414 %rushtran 
    }
  }
}
on 1:notice:!rushstats*:?: {
  if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) {
    if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) {
      while ($exists(%[FRush]Dir $+ RushCfg.xml) == $false) { set %[FRush]Dir $sdir(c:\,Select your FTPRush's folder) }
      var %line = $read(%[FRush]Dir $+ rushcfg.xml,w,*<TSTATS START="*" UP="*" DN="*" FXP="*" />*)
      var %[FtpRSTS]tmpdate = $gettok(%line,2,34)
      var %[FtpRSTS]UP = $gettok(%line,4,34)
      var %[FtpRSTS]DN = $gettok(%line,6,34)
      var %[FtpRSTS]FXP = $gettok(%line,8,34)
      var %[FtpRSTS]date = $ctime($and($calc(%[FtpRSTS]tmpdate /65536),31) $+ $chr(47) $+ $and($calc(%[FtpRSTS]tmpdate /2097152),15) $+ $chr(47) $+ $left($calc(%[FtpRSTS]tmpdate /33554432 +1980),4))
      var %[FtpRSTS]days = $calc(($ctime - %[FtpRSTS]date)/86400)
      notice $nick 15uploaded:7 $bytes(%[FtpRSTS]UP,3).suf - 15downloaded:7 $bytes(%[FtpRSTS]DN,3).suf - 15FXPed:7 $bytes(%[FtpRSTS]FXP,3).suf 15 since7 $asctime(%[FtpRSTS]date,d/mm/yyyy)  15average:7 $bytes($calc(%[FtpRSTS]UP / %[FtpRSTS]days),3).suf $+ /day 15uploaded -7 $bytes($calc(%[FtpRSTS]DN / %[FtpRSTS]days),3).suf $+ /day 15downloaded -7 $bytes($calc(%[FtpRSTS]FXP / %[FtpRSTS]days),3).suf $+ /day ( $+ $left($eval($calc(($remove($bytes(%[FtpRSTS]FXP,3).suf,TB) / %[FtpRSTS]days ) * 30),3),5) $+ TB/month) 15FXPed for7 %[FtpRSTS]days 15days between currently7 $readini(d-tool\d-tool.ini,sites,count) 15Sites [d-tool]
    }
  }
}
on 1:notice:!rdtc*:?: {
  if ( $nick == $me ) || ($findtok($readini(d-tool\d-tool.ini,vars,rmaltnicks),$nick,44)) {
    if ( $2 == $decode($readini(d-tool\d-tool.ini,vars,rmpw)) ) {
      /dll d-tool\rushmirc.dll SetMircCmd /dtrcommand
      /dll d-tool\rushmirc.dll RushScript RushApp.FTP.RAW(' $+ $1 $+ ', 'site $2 $3 $4 $5 $6 $7 $8 $9 $10 $+ ', RS_LOGIN or RS_LOGOUT) 
    }
  }
}
alias dtrcommand { notice $nick 15 $1  $2 $3 $4  $5 $6 $7 $8 $9 $10 $12 $13 $14 $15 $16 $17 $18 $19 $20 $21 $22 $23 $24 $25 $26 $27 $28 $28 $29 $30 }
