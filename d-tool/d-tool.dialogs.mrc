;--------------------------------------------------------
;                 d-tool.dialogs
;--------------------------------------------------------
dialog dtool-main {
  title "d-tool"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 116 540
  option pixels 
  combo 1, 8 169 80 24, vsbar drop
  button "+", 6, 91 172 15 15
  box "status", 2, 7 53 100 109
  check "on", 3, 13 85 88 17, push
  button "info", 24, 13 67 88 17
  check "at", 4, 13 103 44 17, push
  check "affils", 5, 13 121 44 17, push
  check "reqs", 42, 13 139 44 17, push
  check "tvmaze", 15, 57 103 44 17, push
  check "imdb", 26, 57 121 44 17, push
  check "incs", 45, 57 139 44 17, push
  button "blacklist", 22, 9 197 49 16
  icon 7, 7 3 100 49,$scriptdir $+ \logo\d-tool.png, 0 noborder
  box "pre", 9, 8 233 100 128
  button "whitelist", 13, 9 214 49 16
  button "presets", 48, 58 197 49 16
  check "off", 8, 13 252 35 16, push
  box "cbftp/rush", 17, 7 364 100 154
  text "win", 20, 13 400 20 15
  button "bot 1", 10, 12 275 35 16
  edit "", 16, 66 276 35 16, center
  text "1", 23, 55 276 10 17
  button "bot 2", 11, 12 294 35 16
  edit "", 51, 66 295 35 16, center
  text "2", 52, 55 295 10 17
  button "bot 3", 47, 12 314 35 16
  edit "", 50, 66 314 35 16, center
  text "3", 53, 55 314 10 17
  edit "", 54, 71 338 20 17, center
  check "recheck", 55, 13 338 52 17, push
  text "s", 56, 92 337 10 17
  button "exe", 18, 14 380 27 15
  check "startup", 19, 46 380 54 17, push
  edit "", 21, 37 400 30 15, center
  edit "", 32, 37 416 30 15, center
  edit "", 27, 63 431 33 15, center
  edit "", 28, 63 447 33 15, center
  button "?", 44, 48 446 11 16
  edit "", 35, 70 463 26 15, autohs center
  edit "", 40, 70 479 26 15, autohs center
  check "windowcycle", 46, 17 496 80 17, push
  text "regular", 29, 13 431 40 15
  text "big rls", 30, 13 447 31 15
  text "start", 31, 13 416 24 15
  text "restart all", 34, 13 463 49 15
  text "x", 38, 97 431 8 15
  text "x", 37, 97 449 8 15
  text "h", 36, 97 465 8 15
  text "h", 41, 97 481 8 15
  text "del queue", 39, 13 479 49 15
  button "windows", 14, 7 521 47 16
  button "-", 25, 57 521 15 15
  button "•", 43, 91 521 15 15
  text "times(min)", 49, 51 260 50 14
  check "d", 57, 74 521 15 15, push
  check "cbftp", 58, 68 401 32 26, push
  button "bncs", 59, 58 214 49 16
}
on 1:dialog:dtool-main:init:*: {
  dialog -s dtool-main %dtmainbarX %dtmainbarY 116 540
  siterefresh
  did -a dtool-main 16 $calc($readini(d-tool\d-tool.ini,vars,pretime1) / 60)
  did -a dtool-main 51 $calc($readini(d-tool\d-tool.ini,vars,pretime2) / 60)
  did -a dtool-main 50 $calc($readini(d-tool\d-tool.ini,vars,pretime3) / 60)
  did -a dtool-main 27 $readini(d-tool\d-tool.ini,vars,attempt1)
  did -a dtool-main 28 $readini(d-tool\d-tool.ini,vars,attempt2)
  did -a dtool-main 35 %dtrushtimer
  did -a dtool-main 40 %dtrushqtimer
  did -a dtool-main 54 $readini(d-tool\d-tool.ini,vars,doublechecktime)
  if ( %dtrushs == 1 ) { did -c dtool-main 19 }
  if ( $readini(d-tool\d-tool.ini,vars,status) == on ) { did -c dtool-main 3 }
  if ( %dttrade == 1 ) { did -c dtool-main 4 }
  if ( %dtaffils == 1 ) { did -c dtool-main 5 }
  if ( %dtpreoff == 1 ) { did -c dtool-main 8 } 
  if ( %dtreqfill == 1 ) { did -c dtool-main 42 } 
  if ( %dtincfill == 1 ) { did -c dtool-main 45 } 
  if ( $readini(d-tool\d-tool.ini,vars,windowfix) == 0 ) { did -c dtool-main 46 }
  did -a dtool-main 21 $readini(d-tool\d-tool.ini,vars,ratwin)
  did -a dtool-main 32 $readini(d-tool\d-tool.ini,vars,winstart) 
  if ( $readini(d-tool\d-tool.ini,vars,imdbs) == 1 ) { did -c dtool-main 26 }
  if ( $readini(d-tool\d-tool.ini,vars,doublecheck) == 1 ) { did -c dtool-main 55 } 
  if ( $readini(d-tool\d-tool.ini,vars,tv) == 1 ) { did -c dtool-main 15 }
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-main 1 $readini(d-tool\d-tool.ini,sites,%s) $readini(d-tool\inis\ $+ $readini(d-tool\d-tool.ini,sites,%s) $+ .ini,$readini(d-tool\d-tool.ini,sites,%s),location) | inc %s }
}
on 1:dialog:dtool-main:sclick:1: { 
  if ($dialog(dtool-sites)) { sitesave | dialog -x dtool-sites } | if ($dialog(dtool-rules)) { rulesave | var %r = 1 | dialog -x dtool-rules } | if ($dialog(dsections)) { sectionsave | unset %dtsdstat | var %ds = 1 | dialog -x dsections } |  if ($dialog(dtool-rules)) { rulesave | var %r = 1 | dialog -x dtool-rules } | if ($dialog(picklist)) { var %pl = 1 | dialog -x picklist } | if ($dialog(redirect)) { var %rd = 1 | set %dtredirX $dialog(redirect).x | set %dtredirY $dialog(redirect).y | dialog -x redirect } | if ($dialog(dialogimdb)) { var %dtimdbee = 1 | dialog -x dialogimdb } | if ($gettok($did(dtool-main,1).seltext,1,32)) set %dtsetsite $gettok($did(dtool-main,1).seltext,1,32) | else set %dtsetsite $did(dtool-main,1).seltext | set %dtsiteini %dtsetsite $+ .ini 
  dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-sites dtool-sites | if ( %ds == 1 ) || ( %dtsecz == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) dsections dsections } | if ( %r == 1 ) || ( %dtrlz == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-rules dtool-rules } | if ( %pl == 1 ) || ( %dtpick == 1 ) { if ( %dtrlz == 1 ) || ( %r == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) picklist picklist } } | if ( %rd == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) redirect redirect } | if ( %dtimdbee == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) dialogimdb dialogimdb }
}
on 1:dialog:dtool-main:sclick:3: {  if ( $readini(d-tool\d-tool.ini,vars,status) == on ) { writeini -n d-tool\d-tool.ini vars status off } | else { writeini -n d-tool\d-tool.ini vars status on } }
on 1:dialog:dtool-main:sclick:4: { if ( %dttrade == 1 ) { unset %dttrade } | else { set %dttrade 1 } }
on 1:dialog:dtool-main:sclick:5: { if ( %dtaffils == 1 ) { unset %dtaffils } | else { set %dtaffils 1 } }
on 1:dialog:dtool-main:sclick:6: { var %i = $input(Sitename?,e,Add Site) | var %nini %i $+ .ini | if ( %i ) { did -r dtool-main 1 | write d-tool\inis\ $+ %nini ### EDIT CAREFULLY ### | writeini d-tool\inis\ $+ %nini %i site %i | writeini d-tool\inis\ $+ %nini %i loginstatus 1 | writeini d-tool\inis\ $+ %nini %i dateformat $ $+ date(mm) $ $+ date(dd) | writeini d-tool\d-tool.ini %i site %i | if (!$readini(d-tool\inis\ $+ %i $+ .ini,%i,blistentry)) writeini d-tool\inis\ $+ %nini %i blistentry 0 | if (!$readini(d-tool\inis\ $+ %i $+ .ini,%i,wlistentry)) writeini d-tool\inis\ $+ %nini %i wlistentry 0 | if (!$readini(d-tool\inis\ $+ %i $+ .ini,%i,aentrys)) writeini d-tool\inis\ $+ %nini %i aentrys 0 | siterefresh | var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-main 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } } | dialog -x dtool-main | dialog -m dtool-main dtool-main }  
on 1:dialog:dtool-main:sclick:8: { if ( %dtpreoff == 1 ) { unset %dtpreoff } | else { set %dtpreoff 1 } }
on 1:dialog:dtool-main:sclick:10: { if ($dialog(dprebot)) { saveprebot %dtpretemp | dialog -x dprebot dprebot } | else { set %dtpretemp 1 | dialog -m dprebot dprebot } }
on 1:dialog:dtool-main:sclick:11: { if ($dialog(dprebot)) { saveprebot %dtpretemp | dialog -x dprebot dprebot } | else { set %dtpretemp 2 | dialog -m dprebot dprebot } }
on 1:dialog:dtool-main:sclick:47: { if ($dialog(dprebot)) { saveprebot %dtpretemp | dialog -x dprebot dprebot } | else { set %dtpretemp 3 | dialog -m dprebot dprebot } }
on 1:dialog:dtool-main:sclick:15: { if ( $readini(d-tool\d-tool.ini,vars,tv) == 1 ) { remini d-tool\d-tool.ini vars tv } | else { writeini d-tool\d-tool.ini vars tv 1 } }
on 1:dialog:dtool-main:sclick:18: { set %dtrushdir $sfile(C:\,Select ftprush.exe) | echo $active 15 ftprush.exe is located in  $remove(%dtrushdir,\ftprush.exe) }
on 1:dialog:dtool-main:sclick:19: { if ( %dtrushs == 1 ) { unset %dtrushs } | else { set %dtrushs 1 } }
on 1:dialog:dtool-main:sclick:13: { if ( $dialog(wlist) ) dialog -x wlist wlist | else dialog -m wlist wlist }
on 1:dialog:dtool-main:sclick:14: { if ( $dialog(dwindows) ) dialog -x dwindows dwindows | else dialog $readini(d-tool\d-tool.ini,vars,desktop) dwindows dwindows }
on 1:dialog:dtool-main:sclick:22: { if ( $dialog(blist) ) dialog -x blist blist | else dialog -m blist blist }
on 1:dialog:dtool-main:sclick:24: dtinfo
on 1:dialog:dtool-main:sclick:25: { dtmainsave | dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-small dtool-small | set %dtmainbarX $dialog(dtool-main).x | set %dtmainbarY $dialog(dtool-main).y | dialog -x dtool-main dtool-main | set %dtmt s }
on 1:dialog:dtool-main:sclick:26: { if ( $readini(d-tool\d-tool.ini,vars,imdbs) == 1 ) { remini d-tool\d-tool.ini vars imdbs } | else { writeini d-tool\d-tool.ini vars imdbs 1 } }
on 1:dialog:dtool-main:sclick:42: { if ( %dtreqfill == 1 ) { unset %dtreqfill } | else { set %dtreqfill 1 } }
on 1:dialog:dtool-main:sclick:43: { dtmainsave | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | echo -a 15d-tool Settings saved }
on 1:dialog:dtool-main:sclick:44: { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool 15 Man kann die Anzahl der Versuche, wie oft FTPRush versucht das Release zu racen, beliebig einstellen. Unterschieden werden dabei Regulaere und grosse Releases | aline -p @d-tool 15 Big Releases: DVDR x264.1080p PC-Games XBOX360 WII PS3 PS4 XXX-x264 COMPLETE.BLURAY 3D }
on 1:dialog:dtool-main:sclick:45: { if ( %dtincfill == 1 ) { set %dtincfill 0 } | else { set %dtincfill 1 } }
on 1:dialog:dtool-main:sclick:46: { if ( $readini(d-tool\d-tool.ini,vars,windowfix) == 1 ) { writeini d-tool\d-tool.ini vars windowfix 0 } | else { writeini d-tool\d-tool.ini vars windowfix 1 } }
on 1:dialog:dtool-main:sclick:48: { if ( $dialog(dtpreset) ) dialog -x dtpreset | else dialog -m dtpreset dtpreset }
on 1:dialog:dtool-main:sclick:55: { if ( $readini(d-tool\d-tool.ini,vars,doublecheck) == 1 ) { remini d-tool\d-tool.ini vars doublecheck } | else { writeini d-tool\d-tool.ini vars doublecheck 1 } }
on 1:dialog:dtool-main:sclick:57: dialogondesk 
on 1:dialog:dtool-main:sclick:58: { if ( $dialog(cbftp) ) dialog -x cbftp | else dialog -m cbftp cbftp | did -u dtool-main 58 }
on 1:dialog:dtool-main:sclick:59: { if ( $dialog(bnc) ) dialog -x bnc | else dialog -m bnc bnc | did -u dtool-main 59 }
on 1:dialog:dtool-main:close:*: { set %dtmainbarX $dialog(dtool-main).x | set %dtmainbarY $dialog(dtool-main).y | dtmainsave }
dialog dtool-small {
  title "d-tool"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 215 24
  option pixels
  check "on", 3, 1 4 20 17, push
  check "at", 4, 21 4 20 17, push
  check "aff", 5, 41 4 25 17, push
  button "+", 25, 198 4 16 17
  button "info", 24, 174 4 24 17
  combo 1, 93 3 78 23, vsbar drop
  button "set", 2, 66 4 24 17
}
on 1:dialog:dtool-small:init:*: {
  dialog -s dtool-small %dtmainbar1X %dtmainbar1Y 215 24
  siterefresh
  if ( $readini(d-tool\d-tool.ini,vars,status) == on ) { did -c dtool-small 3 }
  if ( %dttrade == 1 ) { did -c dtool-small 4 }
  if ( %dtaffils == 1 ) { did -c dtool-small 5 }
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-small 1 $readini(d-tool\d-tool.ini,sites,%s) $readini(d-tool\inis\ $+ $readini(d-tool\d-tool.ini,sites,%s) $+ .ini,$readini(d-tool\d-tool.ini,sites,%s),location) | inc %s }
}
on 1:dialog:dtool-small:sclick:1: {
  if ($dialog(dtool-sites)) { sitesave | dialog -x dtool-sites } | if ($dialog(dtool-rules)) { rulesave | var %r = 1 | dialog -x dtool-rules } | if ($dialog(dsections)) { sectionsave | unset %dtsdstat | var %d = 1 | dialog -x dsections } |  if ($dialog(dtool-rules)) { rulesave | var %r = 1 | dialog -x dtool-rules } | if ($dialog(picklist)) { var %pl = 1 | dialog -x picklist } | if ($dialog(redirect)) { var %rd = 1 | set %dtredirX $dialog(redirect).x | set %dtredirY $dialog(redirect).y | dialog -x redirect } | if ($dialog(dialogimdb)) { var %dtimdbee = 1 | dialog -x dialogimdb } | if ($gettok($did(dtool-small,1).seltext,1,32)) set %dtsetsite $gettok($did(dtool-small,1).seltext,1,32) | else set %dtsetsite $did(dtool-small,1).seltext | set %dtsiteini %dtsetsite $+ .ini 
  dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-sites dtool-sites | if ( %d == 1 ) || ( %dtsecz == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) dsections dsections } | if ( %r == 1 ) || ( %dtrlz == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-rules dtool-rules } | if ( %pl == 1 ) || ( %dtpick == 1 ) { if ( %dtrlz == 1 ) || ( %r == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) picklist picklist } } | if ( %rd == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) redirect redirect } | if ( %dtimdbee == 1 ) { dialog $readini(d-tool\d-tool.ini,vars,desktop) dialogimdb dialogimdb } 
}
on 1:dialog:dtool-small:sclick:2: { if ($dialog(dtpreset)) dialog -x dtpreset | else dialog -m dtpreset dtpreset }
on 1:dialog:dtool-small:sclick:3: {  if ( $readini(d-tool\d-tool.ini,vars,status) == on ) { writeini -n d-tool\d-tool.ini vars status off } | else { writeini -n d-tool\d-tool.ini vars status on } }
on 1:dialog:dtool-small:sclick:4: { if ( %dttrade == 1 ) { unset %dttrade } | else { set %dttrade 1 } }
on 1:dialog:dtool-small:sclick:5: { if ( %dtaffils == 1 ) { unset %dtaffils } | else { set %dtaffils 1 } }
on 1:dialog:dtool-small:sclick:6: { var %i = $?"Sitename?" | var %nini = %i $+ .ini  | if ( %i != $null ) { did -r dtool-small 1 | writeini d-tool\inis\ $+ %nini %i site %i | writeini d-tool\d-tool.ini %i site %i | siterefresh | var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-small 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } } }
on 1:dialog:dtool-small:sclick:24: { dtinfo }
on 1:dialog:dtool-small:sclick:25: { set %dtmainbar1X $dialog(dtool-small).x | set %dtmainbar1Y $dialog(dtool-small).y | dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-main dtool-main | dialog -x dtool-small dtool-small | set %dtmt m }
on 1:dialog:dtool-small:close:*: { set %dtmainbar1X $dialog(dtool-small).x | set %dtmainbar1Y $dialog(dtool-small).y }
dialog dtool-sites {
  title "site setup"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 172 541
  option pixels
  box "racesites", 22, 10 237 150 137
  box "tv eng only", 65, 8 138 157 74
  text "copy fillsites", 125, 80 382 60 14
  button "", 124, 142 383 12 12
  box "affilsites", 32, 9 374 152 162
  check "ON", 31, 10 7 22 16, push
  button "desc", 2, 33 7 31 16
  button "ini", 1, 64 7 19 16
  button "cbsites", 110, 83 7 40 16
  button "delete", 33, 123 7 40 16
  text "botname", 18, 8 29 44 13
  edit "", 17, 58 29 60 17, autohs center
  edit "", 20, 58 48 60 17, autohs center
  edit "", 64, 58 67 60 17, autohs center
  combo 23, 23 256 60 28, drop
  combo 44, 23 279 60 26, drop
  combo 47, 23 302 60 24, drop
  combo 56, 23 325 60 24, drop
  combo 58, 23 348 60 24, drop
  combo 48, 98 256 60 24, drop
  combo 51, 98 279 60 24, drop
  combo 53, 98 302 60 24, drop
  combo 57, 98 325 60 24, drop
  combo 59, 98 348 60 24, drop
  text "sitename", 21, 8 49 44 13
  text "trigger", 27, 11 104 35 13
  edit "", 19, 10 86 65 17, autohs center
  text "#", 28, 76 104 16 13
  edit "", 24, 75 86 25 17, center
  text "sec#", 29, 107 104 25 13
  edit "", 25, 107 86 25 17, center
  text "rls#", 30, 137 104 23 14
  edit "", 26, 137 86 25 17, center
  text "trigger", 38, 14 395 54 13
  edit "", 34, 14 409 60 17, center
  text "#", 113, 76 395 27 13
  edit "", 112, 76 409 26 17, center
  text "rel#", 40, 105 395 23 13
  edit "", 36, 104 409 26 17, center
  text "sec#", 41, 132 395 25 13
  edit "", 37, 132 409 26 17, center
  check "wanker", 45, 7 120 43 17, push
  check "dates", 76, 53 120 35 17, push
  check "nocb", 94, 91 120 35 17, push
  check "nopr", 123, 129 120 35 17, push
  combo 35, 24 430 60 17, drop
  combo 61, 24 450 60 17, drop
  combo 63, 24 470 60 17, drop
  combo 67, 24 490 60 17, drop
  combo 74, 24 510 60 17, drop
  combo 55, 98 430 60 17, drop
  combo 39, 98 450 60 17, drop
  combo 60, 98 470 60 17, drop
  combo 62, 98 490 60 17, drop
  combo 68, 98 510 60 17, drop
  button "sections", 43, 9 216 75 17
  button "rules", 70, 89 216 74 17
  radio "pre1", 3, 121 31 41 14
  radio "pre2", 4, 121 50 40 14
  radio "pre3", 15, 121 68 40 14
  text "1", 5, 14 260 8 13
  text "6", 6, 87 260 10 13
  text "7", 7, 87 283 10 13
  text "2", 8, 14 284 8 13
  text "8", 9, 87 307 10 13
  text "3", 10, 14 308 8 13
  text "9", 11, 87 329 10 13
  text "4", 12, 14 332 8 13
  text "10", 13, 85 351 12 13
  text "5", 14, 14 354 8 13
  check "", 16, 28 174 11 15, push
  check "", 86, 40 174 11 15, push
  check "", 42, 148 174 11 15, push
  check "", 85, 136 174 11 15, push
  check "", 54, 28 189 11 15, push
  check "", 87, 40 189 11 15, push
  check "", 88, 136 189 11 15, push
  check "", 89, 148 189 11 15, push
  check "", 92, 52 174 11 15, push
  check "", 93, 52 189 11 15, push
  text "username", 66, 8 68 46 13
  text "1", 69, 13 431 8 13
  text "2", 75, 13 452 8 13
  text "3", 77, 13 472 8 13
  text "4", 78, 13 493 8 13
  text "5", 79, 13 512 8 13
  text "6", 80, 86 432 8 13
  text "7", 81, 86 452 10 13
  text "8", 82, 86 472 10 13
  text "9", 83, 86 491 10 13
  text "10", 84, 84 512 12 13
  text "hd", 90, 13 175 14 15
  text "sd", 91, 13 189 14 15
  text "no", 111, 13 163 14 15
  check "", 95, 64 174 11 15, push
  check "", 96, 64 189 11 15, push
  check "", 97, 76 174 11 15, push
  check "", 98, 76 189 11 15, push
  check "", 46, 88 189 11 15, push
  check "", 49, 88 174 11 15, push
  text "cu", 50, 29 153 11 12
  text "sc", 52, 41 153 11 12
  text "an", 71, 53 153 11 12
  text "dc", 72, 66 153 11 12
  text "rl", 73, 79 153 11 12
  text "kd", 99, 101 153 11 12
  text "us", 100, 138 153 11 12
  text "uk", 101, 150 153 11 12
  check "", 102, 100 174 11 15, push
  check "", 103, 100 189 11 15, push
  text "ro", 104, 89 153 11 12
  check "", 105, 52 166 11 8, push
  check "", 106, 64 166 11 8, push
  check "", 107, 76 166 11 8, push
  check "", 108, 88 166 11 8, push
  check "", 109, 100 166 11 8, push
  text "ts", 114, 113 153 11 12
  check "", 115, 112 166 11 8, push
  check "", 116, 112 174 11 15, push
  check "", 117, 112 189 11 15, push
  text "va", 118, 125 153 11 12
  check "", 119, 124 166 11 8, push
  check "", 120, 124 174 11 15, push
  check "", 121, 124 189 11 15, push
  button "?", 122, 12 152 12 15
}
on 1:dialog:dtool-sites:init:*: {
  dialog -t dtool-sites %dtsetsite setup
  dialog -s dtool-sites %dtmainbar2X %dtmainbar2Y 172 541
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,pretime) == 1 ) { did -c dtool-sites 3 } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,pretime) == 2 ) { did -c dtool-sites 4 } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,pretime) == 3 ) { did -c dtool-sites 15 }
  if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsite %dtsetsite s 
  did -a dtool-sites 17 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,bot)
  did -a dtool-sites 20 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,site)
  did -a dtool-sites 24 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,newnr)
  did -a dtool-sites 24 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affmatchnr)
  did -a dtool-sites 25 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,relsecnr)
  did -a dtool-sites 26 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,relmatchnr)
  did -a dtool-sites 19 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,match)
  did -a dtool-sites 34 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affmatch)
  did -a dtool-sites 36 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affrelnr)
  did -a dtool-sites 37 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsecnr)
  did -a dtool-sites 112 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affmnr)
  did -a dtool-sites 64 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,ircnick)
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,status) == 1 ) { did -c dtool-sites 31 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,nowankers) != 1 ) { did -c dtool-sites 45 }
  if ( 1 isin $readini(d-tool\inis\ $+ %dtsiteini,sections,date) ) { did -c dtool-sites 76 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,scripted) == 1 ) { did -c dtool-sites 86 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,current) == 1 ) { did -c dtool-sites 16 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,tv-us) == 1 ) { did -c dtool-sites 85 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,tv-uk) == 1 ) { did -c dtool-sites 42 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdscripted) == 1 ) { did -c dtool-sites 87 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdcurrent) == 1 ) { did -c dtool-sites 54 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtv-us) == 1 ) { did -c dtool-sites 88 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtv-uk) == 1 ) { did -c dtool-sites 89 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdanim) == 1 ) { did -c dtool-sites 92 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdanim) == 1 ) { did -c dtool-sites 93 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hddoc) == 1 ) { did -c dtool-sites 95 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sddoc) == 1 ) { did -c dtool-sites 96 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdreal) == 1 ) { did -c dtool-sites 97 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdreal) == 1 ) { did -c dtool-sites 98 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdrom) == 1 ) { did -c dtool-sites 46 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdrom) == 1 ) { did -c dtool-sites 49 }  
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdkid) == 1 ) { did -c dtool-sites 102 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdkid) == 1 ) { did -c dtool-sites 103 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdtalk) == 1 ) { did -c dtool-sites 116 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtalk) == 1 ) { did -c dtool-sites 117 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdvar) == 1 ) { did -c dtool-sites 120 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdvar) == 1 ) { did -c dtool-sites 121 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,anim_s) == 1 ) { did -c dtool-sites 105 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,doc_s) == 1 ) { did -c dtool-sites 106 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,real_s) == 1 ) { did -c dtool-sites 107 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,rom_s) == 1 ) { did -c dtool-sites 108 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,kid_s) == 1 ) { did -c dtool-sites 109 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,talk_s) == 1 ) { did -c dtool-sites 115 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,var_s) == 1 ) { did -c dtool-sites 119 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,nocbftp) == 1 ) { did -c dtool-sites 94 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,nopr) == 1 ) { did -c dtool-sites 123 }
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 23 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 23 -none- | did -a dtool-sites 23 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 35 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 35 -none- | did -a dtool-sites 35 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 44 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 44 -none- | did -a dtool-sites 44 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 47 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 47 -none- | did -a dtool-sites 47 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 48 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 48 -none- | did -a dtool-sites 48 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 51 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 51 -none- | did -a dtool-sites 51 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 53 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 53 -none- | did -a dtool-sites 53 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 56 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 56 -none- | did -a dtool-sites 56 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 57 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 57 -none- | did -a dtool-sites 57 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 58 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 58 -none- | did -a dtool-sites 58 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 59 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 59 -none- | did -a dtool-sites 59 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 61 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 61 -none- | did -a dtool-sites 61 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 63 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 63 -none- | did -a dtool-sites 63 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 67 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 67 -none- | did -a dtool-sites 67 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 74 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 74 -none- | did -a dtool-sites 74 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 55 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 55 -none- | did -a dtool-sites 55 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 39 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 39 -none- | did -a dtool-sites 39 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 60 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 60 -none- | did -a dtool-sites 60 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 62 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 62 -none- | did -a dtool-sites 62 -cb.rm-
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( %dtsetsite != $readini(d-tool\d-tool.ini,sites,%s) ) did -a dtool-sites 68 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } | did -a dtool-sites 68 -none- | did -a dtool-sites 68 -cb.rm-
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite) == $did(dtool-sites,23,%g).text ) { did -c dtool-sites 23 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite1) == $did(dtool-sites,44,%g).text ) { did -c dtool-sites 44 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite2) == $did(dtool-sites,47,%g).text ) { did -c dtool-sites 47 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite3) == $did(dtool-sites,56,%g).text ) { did -c dtool-sites 56 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite4) == $did(dtool-sites,58,%g).text ) { did -c dtool-sites 58 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite5) == $did(dtool-sites,48,%g).text ) { did -c dtool-sites 48 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite6) == $did(dtool-sites,51,%g).text ) { did -c dtool-sites 51 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite7) == $did(dtool-sites,53,%g).text ) { did -c dtool-sites 53 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite8) == $did(dtool-sites,57,%g).text ) { did -c dtool-sites 57 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite9) == $did(dtool-sites,59,%g).text ) { did -c dtool-sites 59 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite) == $did(dtool-sites,35,%g).text ) { did -c dtool-sites 35 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite1) == $did(dtool-sites,61,%g).text ) { did -c dtool-sites 61 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite2) == $did(dtool-sites,63,%g).text ) { did -c dtool-sites 63 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite3) == $did(dtool-sites,67,%g).text ) { did -c dtool-sites 67 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite4) == $did(dtool-sites,74,%g).text ) { did -c dtool-sites 74 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite5) == $did(dtool-sites,55,%g).text ) { did -c dtool-sites 55 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite6) == $did(dtool-sites,39,%g).text ) { did -c dtool-sites 39 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite7) == $did(dtool-sites,60,%g).text ) { did -c dtool-sites 60 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite8) == $did(dtool-sites,62,%g).text ) { did -c dtool-sites 62 %g } | inc %g }
  var %g = 1 | while ( %g <= $readini(d-tool\d-tool.ini,sites,count) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite9) == $did(dtool-sites,68,%g).text ) { did -c dtool-sites 68 %g } | inc %g }
}
on 1:dialog:dtool-sites:sclick:1: { run d-tool\inis\ $+ %dtsiteini }
on 1:dialog:dtool-sites:sclick:2: { 
  var %t = $input(Description for the Server? (add country like FR,NL,SE maybe),e,Description,$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,desc))
  if (%t) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite desc %t 
}
on 1:dialog:dtool-sites:sclick:3:writeini d-tool\inis\ $+ %dtsiteini %dtsetsite pretime 1
on 1:dialog:dtool-sites:sclick:4:writeini d-tool\inis\ $+ %dtsiteini %dtsetsite pretime 2
on 1:dialog:dtool-sites:sclick:15:writeini d-tool\inis\ $+ %dtsiteini %dtsetsite pretime 3
on 1:dialog:dtool-sites:sclick:86: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,scripted) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite scripted | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite scripted 1 }
on 1:dialog:dtool-sites:sclick:16: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,current) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite current | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite current 1 }
on 1:dialog:dtool-sites:sclick:85: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,tv-us) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite tv-us | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite tv-us 1 }
on 1:dialog:dtool-sites:sclick:42: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,tv-uk) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite tv-uk | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite tv-uk 1 }
on 1:dialog:dtool-sites:sclick:87: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdscripted) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdscripted | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdscripted 1 }
on 1:dialog:dtool-sites:sclick:54: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdcurrent) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdcurrent | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdcurrent 1 }
on 1:dialog:dtool-sites:sclick:88: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtv-us) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdtv-us | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdtv-us 1 }
on 1:dialog:dtool-sites:sclick:89: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtv-uk) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdtv-uk | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdtv-uk 1 }
on 1:dialog:dtool-sites:sclick:92: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdanim) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hdanim | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hdanim 1 }
on 1:dialog:dtool-sites:sclick:93: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdanim) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdanim | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdanim 1 }
on 1:dialog:dtool-sites:sclick:94: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,nocbftp) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite nocbftp | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite nocbftp 1 }
on 1:dialog:dtool-sites:sclick:123: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,nopr) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite nopr | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite nopr 1 }
on 1:dialog:dtool-sites:sclick:95: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hddoc) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hddoc | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hddoc 1 }
on 1:dialog:dtool-sites:sclick:96: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sddoc) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sddoc | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sddoc 1 }
on 1:dialog:dtool-sites:sclick:97: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdreal) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hdreal | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hdreal 1 }
on 1:dialog:dtool-sites:sclick:98: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdreal) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdreal | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdreal 1 }
on 1:dialog:dtool-sites:sclick:46: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdrom) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hdrom | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hdrom 1 }
on 1:dialog:dtool-sites:sclick:49: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdrom) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdrom | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdrom 1 }
on 1:dialog:dtool-sites:sclick:102: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdkid) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hdkid | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hdkid 1 }
on 1:dialog:dtool-sites:sclick:103: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdkid) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdkid | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdkid 1 }
on 1:dialog:dtool-sites:sclick:116: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdtalk) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hdtalk | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hdtalk 1 }
on 1:dialog:dtool-sites:sclick:117: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdtalk) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdtalk | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdtalk 1 }
on 1:dialog:dtool-sites:sclick:120: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,hdvar) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite hdvar | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite hdvar 1 }
on 1:dialog:dtool-sites:sclick:121: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,sdvar) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite sdvar | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite sdvar 1 }
on 1:dialog:dtool-sites:sclick:115: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,talk_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite talk_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite talk_s 1 }
on 1:dialog:dtool-sites:sclick:119: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,var_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite var_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite var_s 1 }
on 1:dialog:dtool-sites:sclick:105: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,anim_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite anim_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite anim_s 1 }
on 1:dialog:dtool-sites:sclick:106: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,doc_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite doc_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite doc_s 1 }
on 1:dialog:dtool-sites:sclick:107: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,real_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite real_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite real_s 1 }
on 1:dialog:dtool-sites:sclick:108: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,rom_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite rom_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite rom_s 1 }
on 1:dialog:dtool-sites:sclick:109: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,kid_s) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite kid_s | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite kid_s 1 }
on 1:dialog:dtool-sites:sclick:110: if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsite %dtsetsite 
on 1:dialog:dtool-sites:sclick:122: echo -a Options: cu=current sc=scripted an=animation dc=docu rl=reality ro=romance kd=kiddie ts=talkshow va=variety us=UnitedStates uk=UnitedKingdom $chr(124) you can say only hd/sd or no ... (hd+sd)
on 1:dialog:dtool-sites:sclick:124: { dtfta %dtsetsite | sitesave | dialog -x dtool-sites | dialog -m dtool-sites dtool-sites }
on 1:dialog:dtool-sites:sclick:23: { if ( $did(dtool-sites,23).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite $did(dtool-sites,23).seltext | set %dtnm 1 | dlgssync 23 | unset %dtnm | if ( $did(dtool-sites,23).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite) == -none- )  remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite | if ( $did(dtool-sites,23).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:44: { if ( $did(dtool-sites,44).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite1) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite1 $did(dtool-sites,44).seltext | set %dtnm 1 | dlgssync 44 | unset %dtnm | if ( $did(dtool-sites,44).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite1) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite1 | if ( $did(dtool-sites,44).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite1)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite1) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite1 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:47: { if ( $did(dtool-sites,47).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite2) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite2 $did(dtool-sites,47).seltext | set %dtnm 1 | dlgssync 47 | unset %dtnm | if ( $did(dtool-sites,47).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite2) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite2 | if ( $did(dtool-sites,47).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite2)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite2) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite2 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:56: { if ( $did(dtool-sites,56).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite3) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite3 $did(dtool-sites,56).seltext | set %dtnm 1 | dlgssync 56 | unset %dtnm | if ( $did(dtool-sites,56).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite3) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite3 | if ( $did(dtool-sites,56).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite3)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite3) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite3 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:58: { if ( $did(dtool-sites,58).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite4) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite4 $did(dtool-sites,58).seltext | set %dtnm 1 | dlgssync 58 | unset %dtnm | if ( $did(dtool-sites,58).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite4) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite4 | if ( $did(dtool-sites,58).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite4)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite4) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite4 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:48: { if ( $did(dtool-sites,48).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite5) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite5 $did(dtool-sites,48).seltext | set %dtnm 1 | dlgssync 48 | unset %dtnm | if ( $did(dtool-sites,48).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite5) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite5 | if ( $did(dtool-sites,48).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite5)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite5) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite5 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:51: { if ( $did(dtool-sites,51).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite6) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite6 $did(dtool-sites,51).seltext | set %dtnm 1 | dlgssync 51 | unset %dtnm | if ( $did(dtool-sites,51).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite6) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite6 | if ( $did(dtool-sites,51).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite6)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite6) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite6 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:53: { if ( $did(dtool-sites,53).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite7) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite7 $did(dtool-sites,53).seltext | set %dtnm 1 | dlgssync 53 | unset %dtnm | if ( $did(dtool-sites,53).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite7) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite7 | if ( $did(dtool-sites,53).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite7)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite7) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite7 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:57: { if ( $did(dtool-sites,57).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite8) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite8 $did(dtool-sites,57).seltext | set %dtnm 1 | dlgssync 57 | unset %dtnm | if ( $did(dtool-sites,57).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite8) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite8 | if ( $did(dtool-sites,57).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite8)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite8) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite8 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:59: { if ( $did(dtool-sites,59).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite9) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite9 $did(dtool-sites,59).seltext | set %dtnm 1 | dlgssync 59 | unset %dtnm | if ( $did(dtool-sites,59).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite9) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite9 | if ( $did(dtool-sites,59).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite9)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite9) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite fillsite9 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:35: { if ( $did(dtool-sites,35).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite $did(dtool-sites,35).seltext | set %dtnm 1 | dlgssync 35 | unset %dtnm | if ( $did(dtool-sites,35).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite | if ( $did(dtool-sites,35).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:61: { if ( $did(dtool-sites,61).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite1) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite1 $did(dtool-sites,61).seltext | set %dtnm 1 | dlgssync 61 | unset %dtnm | if ( $did(dtool-sites,61).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite1) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite1 | if ( $did(dtool-sites,61).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite1)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite1) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite1 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:63: { if ( $did(dtool-sites,63).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite2) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite2 $did(dtool-sites,63).seltext | set %dtnm 1 | dlgssync 63 | unset %dtnm | if ( $did(dtool-sites,63).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite2) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite2 | if ( $did(dtool-sites,63).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite2)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite2) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite2 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:67: { if ( $did(dtool-sites,67).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite3) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite3 $did(dtool-sites,67).seltext | set %dtnm 1 | dlgssync 67 | unset %dtnm | if ( $did(dtool-sites,67).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite3) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite3 | if ( $did(dtool-sites,67).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite3)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite3) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite3 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:74: { if ( $did(dtool-sites,74).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite4) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite4 $did(dtool-sites,74).seltext | set %dtnm 1 | dlgssync 74 | unset %dtnm | if ( $did(dtool-sites,74).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite4) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite4 | if ( $did(dtool-sites,74).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite4)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite4) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite4 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:55: { if ( $did(dtool-sites,55).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite5) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite5 $did(dtool-sites,55).seltext | set %dtnm 1 | dlgssync 55 | unset %dtnm | if ( $did(dtool-sites,55).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite5) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite5 | if ( $did(dtool-sites,55).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite5)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite5) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite5 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:39: { if ( $did(dtool-sites,39).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite6) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite6 $did(dtool-sites,39).seltext | set %dtnm 1 | dlgssync 39 | unset %dtnm | if ( $did(dtool-sites,39).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite6) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite6 | if ( $did(dtool-sites,39).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite6)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite6) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite6 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:60: { if ( $did(dtool-sites,60).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite7) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite7 $did(dtool-sites,60).seltext | set %dtnm 1 | dlgssync 60 | unset %dtnm | if ( $did(dtool-sites,60).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite7) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite7 | if ( $did(dtool-sites,60).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite7)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite7) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite7 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:62: { if ( $did(dtool-sites,62).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite8) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite8 $did(dtool-sites,62).seltext | set %dtnm 1 | dlgssync 62 | unset %dtnm | if ( $did(dtool-sites,62).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite8) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite8 | if ( $did(dtool-sites,62).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite8)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite8) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite8 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:68: { if ( $did(dtool-sites,68).seltext != -cb.rm- ) && ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite9) != -none- ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite9 $did(dtool-sites,68).seltext | set %dtnm 1 | dlgssync 68 | unset %dtnm | if ( $did(dtool-sites,68).seltext !isin $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) ) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,cbtargets) $+ , $+ $did(dtool-sites,23).seltext } | if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite9) == -none- ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite9 | if ( $did(dtool-sites,68).seltext == -cb.rm- ) { set %dtcbtargets $remove($replace(%dtcbtargets,$chr(44),$chr(32)),$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsite9)) | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite t %dtcbtargets | aline -p @d-tool (3 %dtsetsite ) removed $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,fillsite9) from cbftp targets | remini d-tool\inis\ $+ %dtsiteini %dtsetsite affsite9 | writeini d-tool\inis\ $+ %dtsiteini %dtsetsite cbtargets %dtcbtargets | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool } }
on 1:dialog:dtool-sites:sclick:76: { if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,date) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite date 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite date 1 | if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline @d-tool  4,0 ! 0,4 i 4,0 ! 0,4 only activate this, if dated sections are announced with current date like 0501/RE.L-EASE 4,0 ! 0,4 i 4,0 !  } }
on 1:dialog:dtool-sites:sclick:55: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,gl) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite gl 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite gl 1 } }
on 1:dialog:dtool-sites:sclick:31: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,status) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite status 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite status 1 } }
on 1:dialog:dtool-sites:sclick:33: {  
  if ( $input(Really?!,y,Delete Site) == $true ) { remini d-tool\d-tool.ini %dtsetsite | siterefresh | if ( $dialog(dtool-main) ) { did -r dtool-main 1 | var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-main 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } } | if ( $dialog(dtool-small) ) { did -r dtool-small 1 | var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-small 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } }
    if ( $input(Want to keep Siterules for later use?,y,Delete Site) == $null ) { .remove d-tool\inis\ $+ %dtsiteini }
    if ( %dtmt == m ) { did -r dtool-main 1 | var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-main 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } }
    elseif ( %dtmt == s ) { did -r dtool-small 1 | var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) { did -a dtool-small 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } }
    if ($dialog(dtool-sites)) dialog -x dtool-sites dtool-sites | if ($dialog(dtool-rules)) dialog -x dtool-rules dtool-rules | if ($dialog(dsections)) dialog -x dsections dsections | if ($dialog(picklist))  dialog -x picklist picklist | if ($dialog(redirect)) dialog -x redirect redirect
  } 
}
on 1:dialog:dtool-sites:sclick:43: { if ( $dialog(dsections) ) { set %dtsectionX $dialog(dsections).x | set %dtsectionY $dialog(dsections).y | sectionsave | unset %dtsdstat | dialog -x dsections | unset %dtsecz } | else dialog $readini(d-tool\d-tool.ini,vars,desktop) dsections dsections }
on 1:dialog:dtool-sites:sclick:70: { if ( $dialog(dtool-rules) ) { set %dtrulesX $dialog(dtool-rules).x | set %dtrulesY $dialog(dtool-rules).y | rulesave | dialog -x dtool-rules dtool-rules | unset %dtrlz | if ($dialog(picklist)) dialog -x picklist } | else { dialog $readini(d-tool\d-tool.ini,vars,desktop) dtool-rules dtool-rules | if (%dtpick == 1 ) dialog $readini(d-tool\d-tool.ini,vars,desktop) picklist picklist } }
on 1:dialog:dtool-sites:sclick:45: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,nowankers) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite nowankers | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite nowankers 1 }
on 1:dialog:dtool-sites:close:*: { sitesave | matchsave | dtnicks | if ($dialog(dtool-rules)) { dialog -x dtool-rules | set %dtrlz 1 } | if ($dialog(dsections)) { sectionsave | unset %dtsdstat | dialog -x dsections | set %dtsecz 1 } | if ($dialog(picklist)) dialog -x picklist | set %dtpick 1 | if ($dialog(dialogimdb)) { dialog -x dialogimdb | set %dtimdbee 1 } | if ($dialog(redirect)) { dialog -x redirect | set %rd 1 } | if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsite %dtsetsite s } 
dialog dtool-rules {
  title "site setup"
  size -1 -1 445 %dtdsize
  icon d-tool\logo\dtool.ico
  option pixels
  list 1, 8 25 135 $calc(%dtdsize - 75), sort size hsbar
  list 2, 148 25 135 $calc(%dtdsize - 75), sort size hsbar
  list 12, 288 25 135 $calc(%dtdsize - 75), sort size hsbar
  button "add", 3, 15 $calc(%dtdsize - 45) 35 17
  button "edit", 4, 59 $calc(%dtdsize - 45) 35 17
  button "del", 5, 103 $calc(%dtdsize - 45) 35 17
  button "add", 6, 151 $calc(%dtdsize - 45) 35 17
  button "edit", 7, 198 $calc(%dtdsize - 45) 35 17
  button "del", 8, 243 $calc(%dtdsize - 45) 35 17
  button "add", 9, 292 $calc(%dtdsize - 45) 35 17
  button "edit", 10, 331 $calc(%dtdsize - 45) 35 17
  button "del", 11, 371 $calc(%dtdsize - 45) 35 17
  button "sync", 93, 409 $calc(%dtdsize - 45) 32 17
  edit "", 13, 25 $calc(%dtdsize - 24) 315 20, center autohs
  text "blacklist", 14, 10 6 55 15
  text "whitelist", 15, 150 6 60 15
  text "-affil/ban", 16, 290 6 55 15
  edit "", 64, 72 5 35 18, right
  text "entrys", 65, 110 6 34 15
  edit "", 66, 212 5 35 18, right
  text "entrys", 67, 250 6 34 15
  edit "", 90, 352 5 35 18, right
  text "entrys", 91, 390 6 34 15
  edit "", 17, 378 $calc(%dtdsize - 23) 39 17
  text "height", 18, 345 $calc(%dtdsize - 22) 32 16
  text "px.", 19, 420 $calc(%dtdsize - 22) 19 16
  text "10", 80, 428 145 15 15
  text "20", 81, 428 275 15 15
  text "30", 82, 428 405 15 15
  text "40", 83, 428 535 15 15
  text "50", 84, 428 665 15 15
  text "60", 85, 428 795 15 15
  text "70", 86, 428 925 15 15
  text "80", 87, 428 1055 15 15
  button "?", 88, 425 25 15 15
  check "e", 92, 425 40 15 15, push
  button "=", 89, 6 $calc(%dtdsize - 22) 15 15  
}
on 1:dialog:dtool-rules:init:*: {
  dialog -t dtool-rules %dtsetsite rules
  dialog -s dtool-rules %dtrulesX %dtrulesY 445 %dtdsize
  var %i = 1 | var %blistentry = $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry) | while ( %i <= %blistentry ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,black,%i) ) { did -a dtool-rules 1 $readini(d-tool\inis\ $+ %dtsiteini,black,%i) } | inc %i }
  var %i = 1 | var %wlistentry = $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry) | while ( %i <= %wlistentry ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %i) ) { did -a dtool-rules 2 $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %i) } | inc %i }
  var %i = 1 | var %aentrys = $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys) | while ( %i <= %aentrys ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %i) ) { did -a dtool-rules 12 $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %i) } | inc %i }
  did -a dtool-rules 64 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry)
  did -a dtool-rules 66 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry)
  did -a dtool-rules 90 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys)
  did -a dtool-rules 17 %dtdsize
  if ( $readini(d-tool\d-tool.ini,vars,rlzediton) == 1 ) did -c dtool-rules 92 | did -z dtool-rules 1 | did -z dtool-rules 2 | did -z dtool-rules 12
}
on 1:dialog:dtool-rules:sclick:1: { did -r dtool-rules 13 | did -a dtool-rules 13 $did(dtool-rules,1).seltext | set %dtbutton 1 | ecpcheck | unset %dtbutton | if ( $readini(d-tool\d-tool.ini,vars,rlzediton) == 1 ) .timerrlz 1 1 did -f dtool-rules 13 } 
on 1:dialog:dtool-rules:sclick:2: { did -r dtool-rules 13 | did -a dtool-rules 13 $did(dtool-rules,2).seltext | set %dtbutton 2 | whitecheck | unset %dtbutton | if ( $readini(d-tool\d-tool.ini,vars,rlzediton) == 1 ) .timerrlz 1 1 did -f dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:12: { did -r dtool-rules 13 | did -a dtool-rules 13 $did(dtool-rules,12).seltext | set %dtbutton 12 | affcheck | unset %dtbutton | if ( $readini(d-tool\d-tool.ini,vars,rlzediton) == 1 ) .timerrlz 1 1 did -f dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:3: { 
  var %i = 1 | while ( %i <= $calc($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry) + 1) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,black,%i) == $null ) && ($did(dtool-rules,13)) { 
    if ( ~ !isin $did(dtool-rules,13) ) writeini d-tool\inis\ $+ %dtsiteini black %i $replace($replace($replace($replace($did(dtool-rules,13),$chr(32),$chr(124)),$chr(44),$chr(124)),$chr(124)$chr(124),$chr(124)),||,|) | else writeini d-tool\inis\ $+ %dtsiteini black %i $did(dtool-rules,13) | set %dtbutton 1 | listrefresh | unset %dtbutton | did -r dtool-rules 13 | halt }
  elseif ( %i == $calc($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,blistentry) + 1) ) && ($did(dtool-rules,13)) { if ( ~ !isin $did(dtool-rules,13) ) writeini d-tool\inis\ $+ %dtsiteini black %i $replace($replace($did(dtool-rules,13),$chr(32),$chr(124)),$chr(44),$chr(124)) | else writeini d-tool\inis\ $+ %dtsiteini black %i $did(dtool-rules,13) | set %dtbutton 1 | listrefresh | unset %dtbutton | did -r dtool-rules 13 | halt } | inc %i }
}
on 1:dialog:dtool-rules:sclick:4: { if ( ~ !isin $did(dtool-rules,13) ) writeini d-tool\inis\ $+ %dtsiteini black %dttemp $replace($replace($did(dtool-rules,13),$chr(32),$chr(124)),$chr(44),$chr(124)) | else writeini d-tool\inis\ $+ %dtsiteini black %dttemp $did(dtool-rules,13) | set %dtlist %dtsetsite | set %dtbutton 1 | listrefresh | unset %dtbutton | unset %dtlist | did -r dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:5: { remini d-tool\inis\ $+ %dtsiteini black %dttemp | set %dtlist %dtsetsite | set %dtbutton 1 | listrefresh | unset %dtlist | unset %dtbutton | did -r dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:6: { 
  var %i = 1 | while ( %i <= $calc($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry) + 1) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,white,w $+ %i) == $null ) { if ( ~ !isin $did(dtool-rules,13) ) writeini d-tool\inis\ $+ %dtsiteini white w $+ %i $replace($replace($replace($replace($did(dtool-rules,13),$chr(32),$chr(124)),$chr(44),$chr(124)),$chr(124)$chr(124),$chr(124)),||,|) | else writeini d-tool\inis\ $+ %dtsiteini white w $+ %i $did(dtool-rules,13) | set %dtbutton 2 | listrefresh2 | unset %dtbutton | did -r dtool-rules 13 | halt }
  elseif ( %i == $calc($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,wlistentry) + 1) ) {  if ( ~ !isin $did(dtool-rules,13) ) writeini d-tool\inis\ $+ %dtsiteini white w $+ %i $replace($replace($did(dtool-rules,13),$chr(32),$chr(124)),$chr(44),$chr(124)) | else writeini d-tool\inis\ $+ %dtsiteini white w $+ %i $did(dtool-rules,13) | set %dtbutton 2 | listrefresh2 | unset %dtbutton | did -r dtool-rules 13 | halt } | inc %i }
}
on 1:dialog:dtool-rules:sclick:7: {  if ( ~ !isin $did(dtool-rules,13) ) writeini d-tool\inis\ $+ %dtsiteini white %dttemp $replace($did(dtool-rules,13),$chr(32),|) | else writeini d-tool\inis\ $+ %dtsiteini white %dttemp $did(dtool-rules,13) | set %dtlist %dtsetsite | set %dtbutton 2 | listrefresh2 | unset %dtbutton | unset %dtlist | did -r dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:8: { remini d-tool\inis\ $+ %dtsiteini white %dttemp | set %dtlist %dtsetsite | set %dtbutton 2 | listrefresh2 | unset %dtlist | unset %dtbutton | did -r dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:9: { 
  var %i = 1 | while ( %i <= $calc($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys) + 1) ) { if ( $readini(d-tool\inis\ $+ %dtsiteini,affils,a $+ %i) == $null ) { writeini d-tool\inis\ $+ %dtsiteini affils a $+ %i $replace($replace($replace($replace($did(dtool-rules,13),$chr(32),$chr(124)),$chr(44),$chr(124)),$chr(124)$chr(124),$chr(124)),||,|) | set %dtbutton 12 | listrefresh1 | unset %dtbutton | did -r dtool-rules 13 | halt } | elseif ( %i == $calc($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,aentrys) + 1) ) {  writeini d-tool\inis\ $+ %dtsiteini affils a $+ %i $replace($did(dtool-rules,13),$chr(32),|) | set %dtbutton 12 | listrefresh1 | unset %dtbutton | did -r dtool-rules 13 | halt } | inc %i }
}
on 1:dialog:dtool-rules:sclick:10: { writeini d-tool\inis\ $+ %dtsiteini affils %dttemp $did(dtool-rules,13) | set %dtlist %dtsetsite | set %dtbutton 12 | listrefresh1 | unset %dtbutton | unset %dtlist | did -r dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:11: { remini d-tool\inis\ $+ %dtsiteini affils %dttemp | set %dtlist %dtsetsite | set %dtbutton 12 | listrefresh1 | unset %dtlist | unset %dtbutton | did -r dtool-rules 13 }
on 1:dialog:dtool-rules:sclick:88: { if (!$window(@d-tool)) dtoolwin |  else window -a @d-tool
  aline -p @d-tool R U L E S:
  aline -p @d-tool Black-/Whitelist 
  aline -p @d-tool  Generell gilt Whitelist geht vor Blacklist. Man skippt mit der Blacklist bestimmte Sachen oder ganze Sektionen und sagt dann per Whitelist, lass das und das durch. Zudem kann man dann per 3+ in der Blacklist wiederum sagen, lass das trotz Whitelist nicht durch.
  aline -p @d-tool  Moeglich sind einfache Eintraege wie 3Subbed und Wildcards wie 3*dTV*-Group mit Sternchen. Die Listen sind case-sensitive bei normalen Einträgen oder Entry|Entry....
  aline -p @d-tool  Per Wildcards kann man den Eintrag auch auf Sektionen festlegen. Nutzt man damit zB 3XViD*-Group15, also eine Sektion, muss der Sektionsname exakt geschrieben vor dem ersten Stern stehen (am besten Sektion aus der Picklist wählen).
  aline -p @d-tool  Ein 3+ in der Blacklist macht den Eintrag staerker als die Whitelist, ein 3+ in der Whitelist macht den Eintrag staerker als die Blackerlist mit 3+ und die Global Blacklist.
  aline -p @d-tool  Mit staerker ist gemeint, dass der Eintrag dann bewirkt dass etwas getradet wird, obwohl etwas in der anderen Liste dagegen spricht. Man hat zB. etwas auf der Blacklist stehen und das Rls wuerde gekipped werden, laesst aber ueber die Whitelist wiederum etwas durch und will dann aber wieder etwas darueber hinaus verbieten.
  aline -p @d-tool  Zuletzt kann man dann nochmal mit einem 3! vor einem Eintrag in der Blacklist wiederum sagen, dieser Eintrag ist wieder stärker als die Whitelist, wird das ausgelöst steht als Skipeintrag Black3estlist. Dann ist aber auch Ende mit den Möglichkeiten.
  aline -p @d-tool  Moechte man nur eine Sektion in die Blacklist eintragen, dann mit 3^. Das deklariert den Eintrag als Sektion und muss genauso geschrieben werden wie der Sektionsname.
  aline -p @d-tool  Man kann in der Black-/Whitelist auch mehrere Sachen mit einem Eintrag erlauben, dann mit 3| trennen und an eine Sektion binden, zB. 3TV*Grp|Grp|Grp .
  aline -p @d-tool  Ausserdem kann man mit einem 3~ vor dem Eintrag bzw. mit einem 3+ gepaart per Regex skippen/allowen oder mit 3TV-SE*SCRIPTED und 3TV*SPORT oder 3TV*Entry|SPORT|Entry.. in der Black- sowie Whitelist Sport oder scripted Serien explizit regeln. Mit SPORT skippt/allowed man das, was man unter /dteditsport angegeben hat.
  aline -p @d-tool  Die eine Besonderheit bei Regexeinträgen ist, dass man die Sektion mit einem 3' separiert statt mit einem 3* wie sonst. Also zb. 3~TV-ENG-HD'.S[0-9][0-9]E[0-9][0-9].
  aline -p @d-tool  Die Andere ist, dass man hier auch mehrere Einträge mit einem Eintrag kombinieren kann, aber dann statt mit einem $chr(124) mit einem3 $chr(176) $+ . Also zb. 3~TV-ENG-HD'<regex> $+ $chr(176) $+ <regex> $+ $chr(176) $+ <regex>
  aline -p @d-tool  BEISPIELE FUER MOEGLICHE EINTRAEGE:
  aline -p @d-tool  Verbotene Sektion in der Blacklist:3 ^GAMES
  aline -p @d-tool  Black- oder Whitelisteintrag mit Sektion:3 GAMES*clone*-GRP,3 GAMES*German,3 +GAMES*german*clone* (Blackerlist),3 !GAMES*German (Blackestlist), 3 GAMES*Grp|Grp|Grp
  aline -p @d-tool  Einfacher Black- oder Whitelisteintrag:3 EMU,3 *720p*PsO ,3 *dTV*GERMAN* ,3 +PAL (Blackerlist),3 !PAL oder3 !*1080p*Bluray* oder3 !entry|entry.. oder3 !Games*Linux|MacOS (Blackestlist) (Beim Beispiel PsO muss am Ende kein Sternchen stehen, weil die Group am Ende vom Release steht)
  aline -p @d-tool  Sport Skip Blacklist:3 tv-de*SPORT oder 3tv-de*Entry|SPORT|Entry...
  aline -p @d-tool  Nur Scripted bei anderen Ländern als ENG:3 +tv-sp*!SCRIPTED oder3 +tv-sp*DUBBED|!SCRIPTED|... (in der Blacklist..komisch, aber ist so)
  aline -p @d-tool  Affillist
  aline -p @d-tool  Die Affilliste ist case-sensitive und kann keine Wildcards. Affils am besten mit Strich eintragen (-GRouP), so werden die Affils beim "/dtaffils"-command richtig angezeigt.
  aline -p @d-tool  Wenn man neben den Affils auch banned Groups eintragen will dann ohne Strich schreiben und mit einem $chr(124) trennen:3 grp|grp|grp
  aline -p @d-tool  Globale Blacklist:
  aline -p @d-tool  Es gehen nur Wildcards oder Regex. Anders als in den Sitelisten muessen hier die normalen Eintraege immer vorne und hinten einen Stern haben oder es sind Regex Einträge, dann mit 3~ davor. Ein 4! macht einen normalen Eintrag case-sensitive, falls man das braucht.
  aline -p @d-tool  Globale Whitelist:
  aline -p @d-tool  Es gehen nur Groupnamen und Regex mit ~ davor, keine Wildcards. In der Regel packt man auf die Gobale Whitelist nur Groups die sowieso ueberall erlaubt sind, also Majorgroups.
  aline -p @d-tool -
  aline -p @d-tool Button "e" im Rules Dialog aktiviert die automatische Aktivierung des Eingabefeldes wenn man in den Listen ist. Man hat dann 1 sec. zum Scrollen in einer Liste, ansonsten wird das Eingabefeld aktiviert
  aline -p @d-tool -
  aline -p @d-tool  ENGLISH
  aline -p @d-tool  Regex in Blacklist oder Whitelist, zB. Shows mit Datum:3 [1-2][0-9]-[0-1][0-9]-[0-3][0-9] oder3 +[1-2][0-9]-[0-1][0-9]-[0-3][0-9] oder3 ~tv'[1-2][0-9]-[0-1][0-9]-[0-3][0-9] oder3 ~tv'<regex> $+ $chr(176) $+ <regex>
  aline -p @d-tool  In general, the whitelist comes before the blacklist. You skip certain things or entire sections with the blacklist and then say with the whitelist, let this and that through. In addition, you can then say with + in the blacklist, don't let it through despite the whitelist.
  aline -p @d-tool  Simple entries such as 3Subbed15 and wildcards such as 3*dTV*-Group with an asterisk are possible. The Lists are case-sensitive while using Single Entrys or Entry|Entry....
  aline -p @d-tool  You can also set the entry to sections using wildcards. If, for example, you use 3XViD*-Group, i.e. a section, the section name must be written exactly before the first asterisk (it is best to select a section from the picklist).
  aline -p @d-tool  A 3+ in the blacklist makes the entry stronger than the whitelist, a 3+ in the whitelist makes the entry stronger than the blackerlist with 3+ and the global blacklist.
  aline -p @d-tool  By stronger it is meant that the entry then causes something to be traded, although something in the other list speaks against it. You have eg. something is on the blacklist and the rls would be dumped, but in turn lets something through via the whitelist and then wants to ban something beyond that.
  aline -p @d-tool  Finally, you can then again with a 3! in front of an entry in the blacklist say again, this entry is stronger than the whitelist again, this is triggered is the black3estlist skip entry. But then the possibilities are over.
  aline -p @d-tool  If you only want to enter one section in the blacklist, then use 3^. This declares the entry as a section and must be spelled the same as the section name.
  aline -p @d-tool  You can also allow several things with one entry in the black/white list, then with 3| separate and bind to a section, e.g. 3TV*Grp|Grp|Grp .
  aline -p @d-tool  You can also skip/allow with a 3~ in front of the entry or paired with a 3 + via regex or explicitly regulate scripted series or sport with 3TV-SE*SCRIPTED and 3TV*SPORT or 3TV*Entry|SPORT|Entry.. in the black and white list. With SPORT skip/allow what you specified under /dteditsport.
  aline -p @d-tool  One special feature of regex entries is that you separate the section with a 3' instead of the usual 3*. Eg. 3~TV-ENG-HD'.S[0-9][0-9]E[0-9][0-9].
  aline -p @d-tool  The other is that you can also combine several entries with one entry, but then instead of using a 3| with a3 $chr(176) $+ . So eg. 3~TV-ENG-HD'<regex> $+ $chr(176) $+ <regex> $+ $chr(176) $+ <regex>
  aline -p @d-tool  EXAMPLES OF POSSIBLE ENTRIES:
  aline -p @d-tool  Forbidden section in the blacklist: ^GAMES
  aline -p @d-tool  Blacklist or whitelist entry with section: 3 GAMES*clone*-GRP,3 GAMES*German,3 +GAMES*german*clone* (Blackerlist),3 !GAMES*German (Blackestlist), 3 GAMES*Grp|Grp|Grp
  aline -p @d-tool  Simple black or white list entry:3 EMU,3 *720p*PsO ,3 *dTV*GERMAN* ,3 +PAL (Blackerlist),3 !PAL or3 !*1080p*Bluray* or3 !entry|entry.. or3 !Games*Linux|MacOS (Blackestlist) (The Entry with PsO does not have to be an asterisk at the end because the group is at the end of the release)
  aline -p @d-tool  Sport Skip Blacklist: 3tv-de*SPORT or 3tv-de*Entry|SPORT|Entry...
  aline -p @d-tool  only scripted at other languages than eng:3 +tv-sp*!SCRIPTED or3 +tv-sp*DUBBED|!SCRIPTED|... (in the Blacklist, strange..but it is what it is)
  aline -p @d-tool  Affillist
  aline -p @d-tool  The affiliate list is case-sensitive and cannot accept wildcards. It is best to enter affiliates with a dash (-GRouP), so the affiliates are displayed correctly with the "/dtaffils" command.
  aline -p @d-tool  If you want to enter banned groups in addition to the affiliates, then write without a dash and with a $chr(124) separate: 3grp|grp|grp
  aline -p @d-tool  Global blacklist:
  aline -p @d-tool  Only wildcards and regex work. Unlike in the site lists, the regular entries here must always have an asterisk at the beginning and end or it is a regex entry, then with a 3~ in front. A 3! makes the entry case-sensitive if you need it.
  aline -p @d-tool  Global whitelist:
  aline -p @d-tool  Only Groupnames possible and Regex with an ~ in front, wildcards doesn't work. only groups that are allowed everywhere anyway, which means major groups.
  aline -p @d-tool -
  aline -p @d-tool Button "e" in the Rules dialog activates the automatic activation of the input field when you are in the lists. You then have 1 second to scroll in a list, otherwise the input field will be activated.
} 
on *:dialog:dtool-rules:sclick:89: { if ($dialog(picklist)) { dialog -x picklist | unset %dtpick } | else { dialog $readini(d-tool\d-tool.ini,vars,desktop) picklist picklist | set %dtpick 1 } }
on *:dialog:dtool-rules:sclick:92: { if ( $readini(d-tool\d-tool.ini,vars,rlzediton) == 1 ) remini d-tool\d-tool.ini vars rlzediton | else writeini d-tool\d-tool.ini vars rlzediton 1 }
on 1:dialog:dtool-rules:sclick:93: { if ($window(@d-tool)) window -a @d-tool | else dtoolwin | dcbsync %dtsetsite a }
on 1:dialog:dtool-rules:close:*: { rulesave | unset %dtrlz | if ($dialog(picklist)) dialog -x picklist }
dialog picklist {
  title "pick"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 223 540
  option pixels
  list 1, 115 7 101 $calc(%dtdsize - 64), sort hsbar
  button "add", 2, 11 $calc(%dtdsize - 23) 64 18
  button "edit", 3, 80 $calc(%dtdsize - 23) 64 18
  button "del", 4, 149 $calc(%dtdsize - 23) 64 18
  button "*", 5, 91 $calc(%dtdsize - 50) 20 18
  button "^", 6, 11 $calc(%dtdsize - 50) 20 18
  button "+", 7, 51 $calc(%dtdsize - 50) 20 18
  button "|", 9, 111 $calc(%dtdsize - 50) 20 18
  button "~", 13, 31 $calc(%dtdsize - 50) 20 18
  button "°", 15, 131 $calc(%dtdsize - 50) 20 18
  button "!", 14, 71 $calc(%dtdsize - 50) 20 18
  button "clear", 8, 167 $calc(%dtdsize - 50) 46 18
  list 10, 7 7 101 $calc(%dtdsize - 64), sort hsbar
  text "sections (fix)", 11, 8 $calc(%dtdsize - 72) 82 17
  text "entrys (custom)", 12, 116 $calc(%dtdsize - 72) 100 17
}
on *:dialog:picklist:init:*:{ 
  dialog -t picklist picklist
  picklistrefresh 
  set %dtrulesX $dialog(dtool-rules).x | set %dtrulesY $dialog(dtool-rules).y
  dialog -s picklist $calc( %dtrulesX - 230) %dtrulesY 223 %dtdsize | did -z picklist 1 | did -z picklist 10 
}
on *:dialog:picklist:sclick:1:{ did -a dtool-rules 13 $did(picklist,1).seltext | did -f dtool-rules 13 }
on *:dialog:picklist:dclick:1:{ did -r dtool-rules 13 | did -a dtool-rules 13 $did(picklist,1).seltext }
on *:dialog:picklist:sclick:10:{  
  if ( ^ !isin $did(dtool-rules,13) ) && ( + !isin $did(dtool-rules,13) ) && ( $did(dtool-rules,13) != ~ ) { did -r dtool-rules 13 | did -a dtool-rules 13 $did(picklist,10).seltext $+ * }
  elseif ( $left($did(dtool-rules,13),1) == + ) { did -r dtool-rules 13 | did -a dtool-rules 13 + $+ $did(picklist,10).seltext $+ * | did -f dtool-rules 13 } 
  elseif ( $did(dtool-rules,13) == ~ ) { did -r dtool-rules 13 | did -a dtool-rules 13 ~ $+ $did(picklist,10).seltext $+ ' | did -f dtool-rules 13 }
  else did -a dtool-rules 13 $did(picklist,10).seltext
  did -f dtool-rules 13  
}
on *:dialog:picklist:sclick:2:{ write d-tool\picklist.db $did(dtool-rules,13) | did -a picklist 1 $did(dtool-rules,13) }
on *:dialog:picklist:sclick:3:{ var %pickline = $read(d-tool\picklist.db, s, $did(picklist,1).seltext) | write -l $+ $readn d-tool\picklist.db $did(dtool-rules,13) | picklistrefresh } 
on *:dialog:picklist:sclick:4:{ var %pickline = $read(d-tool\picklist.db, s, $did(picklist,1).seltext) | write -dl $+ $readn d-tool\picklist.db | picklistrefresh }
on *:dialog:picklist:sclick:5:{ did -a dtool-rules 13 * | did -f dtool-rules 13 }
on *:dialog:picklist:sclick:6:{ did -r dtool-rules 13 | did -a dtool-rules 13 ^ | did -f dtool-rules 13 }
on *:dialog:picklist:sclick:7:{ if ( + !isin $did(dtool-rules,13) ) && ( ! isin $did(dtool-rules,13) ) { var %tt = $remove($did(dtool-rules,13),!) | did -r dtool-rules 13 | did -a dtool-rules 13 + $+ %tt | did -f dtool-rules 13 } | if ( + !isin $did(dtool-rules,13) ) && ( ! !isin $did(dtool-rules,13) ) { var %tt = $did(dtool-rules,13) | did -r dtool-rules 13 | did -a dtool-rules 13 + $+ %tt | did -f dtool-rules 13 } }
on *:dialog:picklist:sclick:8:{ did -r dtool-rules 13 }
on *:dialog:picklist:sclick:9:{ did -a dtool-rules 13 $chr(124) | did -f dtool-rules 13 }
on *:dialog:picklist:sclick:15:{ did -a dtool-rules 13 $chr(176) | did -f dtool-rules 13 }
on *:dialog:picklist:sclick:13:{ if ( ~ !isin $did(dtool-rules,13) ) { var %tt = $replace($replace($did(dtool-rules,13),*,'),|,$chr(176)) | did -r dtool-rules 13 | did -a dtool-rules 13 ~ $+ %tt | did -f dtool-rules 13 } }
on *:dialog:picklist:sclick:14:{ if ( ! !isin $did(dtool-rules,13) ) && ( + isin $did(dtool-rules,13) ) { var %tt = $remove($did(dtool-rules,13),+) | did -r dtool-rules 13 | did -a dtool-rules 13 ! $+ %tt | did -f dtool-rules 13 } | if ( ! !isin $did(dtool-rules,13) ) && ( + !isin $did(dtool-rules,13) ) { var %tt = $did(dtool-rules,13) | did -r dtool-rules 13 | did -a dtool-rules 13 ! $+ %tt | did -f dtool-rules 13 } }
on *:dialog:picklist:close:*: unset %dtpick 
dialog dsections {
  title "Sections"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 397 540
  option pixels
  box "section settings", 5, 183 15 207 149
  box "section management", 20, 183 421 207 112
  list 1, 8 15 170 523, hsbar vsbar sort
  check "race in this section", 2, 191 32 190 17, push
  check "disable precheck", 3, 191 53 190 17, push
  check "dated section", 4, 191 74 190 17, push
  text "name in chan", 7, 192 99 70 17
  edit "", 6, 265 96 115 20, autohs
  text "path on site", 8, 192 120 70 17
  edit "", 9, 265 117 115 20, autohs
  edit "", 10, 222 138 37 18
  text "year+", 11, 192 141 29 17
  check "wank", 36, 262 141 40 17
  check "frgn/noIMDb", 39, 306 141 77 17
  text "races:", 23, 188 179 36 17
  text "affils:", 24, 191 198 31 17
  edit "", 22, 233 179 45 20, autohs
  edit "", 29, 335 179 45 20, autohs
  edit "", 25, 233 198 45 20, autohs
  edit "", 28, 335 198 45 20, autohs
  text "<section>", 26, 281 179 51 17
  text "<section>", 27, 281 198 51 17
  button "redirections", 247, 183 226 101 19
  check "mp3 foreign", 35, 288 226 101 19, push
  button "IMDb", 258, 183 247 40 19
  button "dateformat", 260, 228 247 60 19
  button "special format", 38, 293 247 75 19
  button "?", 261, 374 247 15 19
  box "requests", 322, 183 266 207 114
  check "fill from here", 323, 190 286 110 17
  check "get requests filled", 324, 190 308 110 17
  check "glFTPd", 325, 190 353 52 17
  button "directory", 321, 246 352 52 19
  button "chan", 326, 300 352 31 19
  button "gl.prefix", 328, 333 352 50 19
  box "filled cmd", 37, 316 280 67 64
  check "site", 34, 329 298 40 17
  check "chan", 33, 329 320 40 17
  check "fill incs here", 31, 190 395 95 19, push
  check "fill from here", 32, 288 395 95 19, push
  button "edit name", 18, 192 439 90 19
  button "sync sections", 330, 290 439 90 19
  button "change ID", 17, 192 461 90 19
  button "show sections", 14, 290 461 90 19
  button "add section", 12, 192 483 90 19
  button "show usage", 19, 290 483 90 19
  button "delete section", 16, 192 505 90 19
  button "open ini", 13, 290 505 90 19
  box "prefix/suffix", 21, 183 164 207 58
  box "incompletes", 30, 183 380 207 40
}
on *:dialog:dsections:init:*: {
  dialog -t dsections %dtsetsite sections
  dialog -s dsections %dtsectionX %dtsectionY 397 540
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,incget) == 1 ) { did -c dsections 31 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,incfill) == 1 ) { did -c dsections 32 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqfilled) == 1 ) { did -c dsections 33 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqfillcmd) == 1 ) { did -c dsections 34 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,mp3foreign) == 1 ) { did -c dsections 35 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,gl) == 1 ) { did -c dsections 325 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqget) == 1 ) { did -c dsections 324 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqfill) == 1 ) { did -c dsections 323 }
  if ($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,secprefix)) did -a dsections 22 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,secprefix)
  if ($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,secsuffix)) did -a dsections 29 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,secsuffix)
  if ($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affprefix)) did -a dsections 25 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affprefix)
  if ($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsuffix)) did -a dsections 28 $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,affsuffix)
  listrefreshsec | did -z dsections 1
}
on *:dialog:dsections:sclick:1: {
  dialog -t dsections %dtsetsite sections $gettok($did(dsections,1).seltext,2-,32)
  did -u dsections 2 | did -u dsections 3 | did -u dsections 4 | did -u dsections 36 | did -u dsections 39
  sectionsave
  set %dtsdnr $gettok($did(dsections,1).seltext,1,32) | if ( $left(%dtsdnr,1) == 0 ) set %dtsdnr $right(%dtsdnr,1)
  did -r dsections 6 | did -a dsections 6 $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %dtsdnr)
  did -r dsections 9 | did -a dsections 9 $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %dtsdnr $+ dir)
  did -r dsections 10 | did -a dsections 10 $readini(d-tool\inis\ $+ %dtsiteini,sections,y $+ %dtsdnr)
  if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,ats $+ %dtsdnr) ) did -c dsections 2
  if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,atw $+ %dtsdnr) ) did -c dsections 36
  if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,atf $+ %dtsdnr) ) did -c dsections 39
  if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,secpre $+ %dtsdnr) ) did -c dsections 3
  if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,date $+ %dtsdnr) ) did -c dsections 4
  set %dtsdstat 1
}
on 1:dialog:dsections:sclick:2: { if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,ats $+ %dtsdnr) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini sections ats $+ $+ %dtsdnr 0 } | else { writeini d-tool\inis\ $+ %dtsiteini sections ats $+ $+ %dtsdnr 1 } }
on 1:dialog:dsections:sclick:3: { if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,secpre $+ %dtsdnr) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini sections secpre $+ $+ %dtsdnr 0 } | else { writeini d-tool\inis\ $+ %dtsiteini sections secpre $+ $+ %dtsdnr 1 } }
on 1:dialog:dsections:sclick:4: { if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,date $+ %dtsdnr) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite date $+ $+ %dtsdnr 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite date $+ $+ %dtsdnr 1 } }
on *:dialog:dsections:sclick:13: run d-tool\sections.ini
on *:dialog:dsections:sclick:12: {
  var %a = $input(Description? (GER.,ENG.,x264,xvid),e,New Section)
  if ($readini(d-tool\sections.ini,name,count)) { 
    var %b = 1 | while ( %b <= $readini(d-tool\sections.ini,name,count) ) {
      if (!$readini(d-tool\sections.ini,name,%b)) { writeini d-tool\sections.ini name %b %a | goto markymark }
      inc %b 
    }
    writeini d-tool\sections.ini name count $calc($readini(d-tool\sections.ini,name,count) + 1) | writeini d-tool\sections.ini name $readini(d-tool\sections.ini,name,count) %a
  }
  else {
    writeini d-tool\sections.ini name count 1 | writeini d-tool\sections.ini name 1 %a
  }
  :markymark
  listrefreshsec
}
on *:dialog:dsections:sclick:14: { dtsec %dtsetsite }
on *:dialog:dsections:sclick:16: {
  if ( $input(Really want to delete $readini(d-tool\sections.ini,name,%dtsdnr) $+ ?,y,Delete Section) == $true ) {
    remini d-tool\sections.ini name %dtsdnr
    var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) { var %asn = $readini(d-tool\d-tool.ini,sites,%a) | if ($readini(d-tool\inis\ $+ %asn $+ .ini,sections,dlight $+ %dtsdnr)) remini d-tool\inis\ $+ %asn $+ .ini sections dlight $+ %dtsdnr | if ($readini(d-tool\inis\ $+ %asn $+ .ini,sections,dlight $+ %dtsdnr $+ dir)) remini d-tool\inis\ $+ %asn $+ .ini sections dlight $+ %dtsdnr $+ dir | inc %a }
    listrefreshsec
  }
}
on *:dialog:dsections:sclick:17: {
  var %a = $?"Assign to which ID?"
  if (%a != $null ) { 
    if ($readini(d-tool\sections.ini,name,%a)) echo -a Section already exists
    else {
      writeini d-tool\sections.ini name %a $readini(d-tool\sections.ini,name,%dtsdnr) | remini d-tool\sections.ini name %dtsdnr
      var %b = 1 | while ( %b <= $readini(d-tool\d-tool.ini,sites,count) ) {
        var %abs = $readini(d-tool\d-tool.ini,sites,%b) | var %absi = $readini(d-tool\d-tool.ini,sites,%b) $+ .ini
        if ($readini(d-tool\inis\ $+ %absi,sections,dlight $+ %dtsdnr)) { 
          var %bsn = $readini(d-tool\inis\ $+ %absi,sections,dlight $+ %dtsdnr) | var %bsd = $readini(d-tool\inis\ $+ %absi,sections,dlight $+ %dtsdnr $+ dir)
          if ($readini(d-tool\inis\ $+ %absi,sections,ats $+ %dtsdnr)) var %bsat = $readini(d-tool\inis\ $+ %absi,sections,ats $+ %dtsdnr)
          if ($readini(d-tool\inis\ $+ %absi,sections,secpre $+ %dtsdnr)) var %bspre = $readini(d-tool\inis\ $+ %absi,sections,secpre $+ %dtsdnr)
          if ($readini(d-tool\inis\ $+ %absi,sections,date $+ %dtsdnr)) var %bsdate = $readini(d-tool\inis\ $+ %absi,sections,date $+ %dtsdnr)
          if ($readini(d-tool\inis\ $+ %absi,sections,y $+ %dtsdnr)) var %bsy = $readini(d-tool\inis\ $+ %absi,sections,y $+ %dtsdnr)
          if ($readini(d-tool\inis\ $+ %absi,sections,atw $+ %dtsdnr)) var %bsatw = $readini(d-tool\inis\ $+ %absi,sections,atw $+ %dtsdnr)
          if ($readini(d-tool\inis\ $+ %absi,sections,atf $+ %dtsdnr)) var %bsatf = $readini(d-tool\inis\ $+ %absi,sections,atf $+ %dtsdnr)
          if ($readini(d-tool\inis\ $+ %absi,sections,df $+ %dtsdnr)) var %bsdf = $readini(d-tool\inis\ $+ %absi,sections,df $+ %dtsdnr)
          if (%bsn) writeini d-tool\inis\ $+ %absi sections dlight $+ %a %bsn | if (%bsd) writeini d-tool\inis\ $+ %absi sections dlight $+ %a $+ dir %bsd | if (%bsat) writeini d-tool\inis\ $+ %absi sections ats $+ %a %bsat | if (%bspre) writeini d-tool\inis\ $+ %abs $+ .ini sections secpre $+ %a %bspre | if (%bsdate) writeini d-tool\inis\ $+ %abs $+ .ini %abs date $+ %a %bsdate | if (%bsy) writeini d-tool\inis\ $+ %abs $+ .ini %abs y $+ %a %bsy  | if (%bsatw) writeini d-tool\inis\ $+ %abs $+ .ini sections atw $+ %a %bsatw | if (%bsatf) writeini d-tool\inis\ $+ %abs $+ .ini sections atf $+ %a %bsatf | if (%bsdf) writeini d-tool\inis\ $+ %abs $+ .ini %abs df $+ %a %bsdf
          remini d-tool\inis\ $+ %abs $+ .ini sections dlight $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini sections dlight $+ %dtsdnr $+ dir | remini d-tool\inis\ $+ %abs $+ .ini sections ats $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini sections secpre $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini %abs date $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini %abs y $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini sections atw $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini sections atf $+ %dtsdnr | remini d-tool\inis\ $+ %abs $+ .ini %abs df $+ %dtsdnr 
        }
        inc %b
      }
      set %dtsdnr %a | if ( %a > $readini(d-tool\sections.ini,name,count) ) writeini d-tool\sections.ini name count %a | listrefreshsec
    }
  }
}
on *:dialog:dsections:sclick:18: { var %ttg = $input(New Name?,e,Sectionname,$readini(d-tool\sections.ini,name,%dtsdnr)) | if ( %ttg != $null ) { writeini d-tool\sections.ini name %dtsdnr %ttg | listrefreshsec } }
on *:dialog:dsections:sclick:19: { 
  if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool usage for $readini(d-tool\sections.ini,name,%dtsdnr) $+ :
  var %a = 1 | while ( %a <= $readini(d-tool\d-tool.ini,sites,count) ) {
    var %asn = $readini(d-tool\d-tool.ini,sites,%a) | var %asni = $readini(d-tool\d-tool.ini,sites,%a) $+ .ini
    if ($readini(d-tool\inis\ $+ %asni,sections,dlight $+ %dtsdnr)) { aline -p @d-tool  %asn - $readini(d-tool\inis\ $+ %asni,sections,dlight $+ %dtsdnr) $readini(d-tool\inis\ $+ %asni,sections,dlight $+ %dtsdnr $+ dir) }
    inc %a
  }
}
on *:dialog:dsections:sclick:31: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,incget) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite incget 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite incget 1 } }
on *:dialog:dsections:sclick:32: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,incfill) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite incfill 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite incfill 1 } }
on *:dialog:dsections:sclick:33: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqfilled) == 1 ) { remini d-tool\inis\ $+ %dtsiteini %dtsetsite reqfilled } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqfilled 1 } }
on *:dialog:dsections:sclick:34: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqfillcmd) == 1 ) { remini d-tool\inis\ $+ %dtsiteini %dtsetsite reqfillcmd } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqfillcmd 1 } }
on *:dialog:dsections:sclick:35: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,mp3foreign) == 1 ) { remini d-tool\inis\ $+ %dtsiteini %dtsetsite mp3foreign } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite mp3foreign 1 | if (!$window(@d-tool)) dtoolwin | echo -a MP3-Foreign will be raced } } 
on *:dialog:dsections:sclick:36: { if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,atw $+ %dtsdnr == 1 ) ) { remini d-tool\inis\ $+ %dtsiteini sections atw $+ %dtsdnr } | else { writeini d-tool\inis\ $+ %dtsiteini sections atw $+ %dtsdnr 1 } }
on *:dialog:dsections:sclick:39: { if ( $readini(d-tool\inis\ $+ %dtsiteini,sections,atf $+ %dtsdnr == 1 ) ) { remini d-tool\inis\ $+ %dtsiteini sections atf $+ %dtsdnr } | else { writeini d-tool\inis\ $+ %dtsiteini sections atf $+ %dtsdnr 1 } }
on *:dialog:dsections:sclick:38: { 
  var %dft = $replace($replace($replace($replace($input(Add Format (Day=dd,Month=mm,Year=yy/yyyy, x to remove),e,Dateformat),dd,$chr(32) $ $+ date(dd) $chr(32)),mm,$chr(32) $ $+ date(mm) $chr(32)),$ $+ dat,$chr(32) $+ $ $+ dat),$chr(41),$chr(41) $+ $chr(32)) | if ( %dft != $null ) set %dateformat %dft | else remini d-tool\inis\ $+ %dtsiteini %dtsetsite df $+ %dtsdnr  
  if ( yyyy isin %dateformat ) set %dateformat $replace($replace(%dateformat,yyyy,$chr(32) $ $+ date(yyyy) $chr(32)),$ $+ dat,$chr(32) $+ $ $+ dat)),$chr(41),$chr(41) $+ $chr(32))
  elseif ( yy isin %dateformat ) set %dateformat $replace($replace(%dateformat,yy,$chr(32) $ $+ date(yy) $chr(32)),$ $+ dat,$chr(32) $+ $ $+ dat)),$chr(41),$chr(41) $+ $chr(32))
  if (%dateformat) && ( %dateformat != x ) {
    writeini d-tool\inis\ $+ %dtsiteini %dtsetsite df $+ %dtsdnr %dateformat | aline -p @d-tool Date for $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %dtsdnr) on %dtsetsite set to $remove($readini(d-tool\inis\ $+ %dtsiteini,sections,df $+ %dtsdnr),$chr(32))
  }
  if ( %dateformat == x ) { remini d-tool\inis\ $+ %dtsiteini %dtsetsite df $+ %dtsdnr | aline -p @d-tool Date for $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %dtsdnr) on %dtsetsite removed }
  unset %dateformat
}
on *:dialog:dsections:sclick:323: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqfill) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqfill 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqfill 1 } }
on *:dialog:dsections:sclick:324: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqget) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqget 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqget 1 } }
on *:dialog:dsections:sclick:325: { if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,gl) == 1 ) { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite gl 0 } | else { writeini d-tool\inis\ $+ %dtsiteini %dtsetsite gl 1 } }
on *:dialog:dsections:sclick:211: { if ( $dialog(prefix) ) { dialog -x prefix } | else dialog $readini(d-tool\d-tool.ini,vars,desktop) prefix prefix }
on *:dialog:dsections:sclick:247: { if ( $dialog(redirect) ) { set %dtredirX $dialog(redirect).x | set %dtredirY $dialog(redirect).y | dialog -x redirect | unset %rd } | else dialog $readini(d-tool\d-tool.ini,vars,desktop) redirect redirect }
on *:dialog:dsections:sclick:258: { if ($dialog(dialogimdb)) dialog -x dialogimdb | else dialog $readini(d-tool\d-tool.ini,vars,desktop) dialogimdb dialogimdb }
on *:dialog:dsections:sclick:260: { 
  set %dateformat $replace($replace($replace($replace($input(Add Format (Day=dd,Month=mm,Year=yy/yyyy),e,Dateformat),dd,$chr(32) $ $+ date(dd) $chr(32)),mm,$chr(32) $ $+ date(mm) $chr(32)),$ $+ dat,$chr(32) $+ $ $+ dat),$chr(41),$chr(41) $+ $chr(32)) 
  if ( yyyy isin %dateformat ) set %dateformat $replace($replace(%dateformat,yyyy,$chr(32) $ $+ date(yyyy) $chr(32)),$ $+ dat,$chr(32) $+ $ $+ dat)),$chr(41),$chr(41) $+ $chr(32))
  elseif ( yy isin %dateformat ) set %dateformat $replace($replace(%dateformat,yy,$chr(32) $ $+ date(yy) $chr(32)),$ $+ dat,$chr(32) $+ $ $+ dat)),$chr(41),$chr(41) $+ $chr(32))
  if (%dateformat) writeini d-tool\inis\ $+ %dtsiteini %dtsetsite dateformat %dateformat
  aline -p @d-tool Date for %dtsetsite set to $remove($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,dateformat),$chr(32))
  unset %dateformat
}
on *:dialog:dsections:sclick:261: { if ($window(@d-tool)) window -a @d-tool | else dtoolwin | 
  aline -p @d-tool today's default date for  %dtsetsite is $remove($readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,dateformat),$chr(32)) 
  var %rg = 1 | while ( %rg <= $readini(d-tool\sections.ini,name,count) ) {
    if ($readini(d-tool\inis\ $+ %dtsiteini,sections,df $+ %rg)) aline -p @d-tool today's date for $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %rg) on %dtsetsite is $remove($readini(d-tool\inis\ $+ %dtsiteini,sections,df $+ %rg),$chr(32))
    inc %rg 
  }
}
on *:dialog:dsections:sclick:321: writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqpath $input(request directory?(e.g. path/to/req),e,Request Dir,$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqpath))
on *:dialog:dsections:sclick:326: { var %tt = $input(chan for !reqfilled command? (without #,leave blank if no chan has +m mode),e,!reqfilled-chan,$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqchan)) | if ( %tt == $null) remini d-tool\inis\ $+ %dtsiteini %dtsetsite reqchan | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqchan %tt }
on *:dialog:dsections:sclick:328: { var %r = $input(only for glFTPd (leave blank if prefix is REQ-),e,directory-prefix,$readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,reqprefix)) | if ( %r == %null ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite reqprefix | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite reqprefix %r }
on *:dialog:dsections:sclick:330: { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) dcbsync %dtsetsite S }
on *:dialog:dsections:close:*: { sectionsave | seccountrefresh | unset %dtsecz | unset %dtsdstat }
dialog cbftp {
  title "cbftp"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 262 90
  option pixels
  check "races", 1, 10 62 45 17
  edit "", 2, 40 6 100 20, autohs
  edit "", 3, 210 6 46 20, autohs
  edit "", 4, 40 28 100 20, pass autohs
  text "ip", 5, 6 8 10 17
  text "port", 6, 179 7 23 17
  text "pass", 7, 6 29 25 17
  check "srcchk", 8, 210 30 50 17
  box "use cbftp for", 9, 5 49 253 36
  check "reqf/incf", 10, 60 62 58 17
  check "reqs/incs", 11, 124 62 58 17
  check "download", 12, 190 62 66 17
}
on 1:dialog:cbftp:init:*: { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) did -c cbftp 1 | if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) did -c cbftp 10 | if ( $readini(d-tool\d-tool.ini,vars,cbftpload) == 1 ) did -c cbftp 12 | if ( $readini(d-tool\d-tool.ini,vars,cbreqsearch) == 1 ) did -c cbftp 11 | if ( $readini(d-tool\d-tool.ini,vars,srcchkcbftp) == 1 ) did -c cbftp 8 | if ($readini(d-tool\d-tool.ini,vars,cbftpip)) did -a cbftp 2 $readini(d-tool\d-tool.ini,vars,cbftpip) | if ($readini(d-tool\d-tool.ini,vars,cbftpport)) did -a cbftp 3 $readini(d-tool\d-tool.ini,vars,cbftpport) | if ($readini(d-tool\d-tool.ini,vars,cbftppass)) did -a cbftp 4 $decode($readini(d-tool\d-tool.ini,vars,cbftppass)) }
on 1:dialog:cbftp:sclick:1: { if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) { writeini d-tool\d-tool.ini vars cbftp 0 } | else { writeini d-tool\d-tool.ini vars cbftp 1 } }
on 1:dialog:cbftp:sclick:8: { if ( $readini(d-tool\d-tool.ini,vars,srcchkcbftp) == 1 ) { writeini d-tool\d-tool.ini vars srcchkcbftp 0 } | else { writeini d-tool\d-tool.ini vars srcchkcbftp 1 } }
on 1:dialog:cbftp:sclick:10: { if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) { writeini d-tool\d-tool.ini vars cbftpreqs 0 } | else { writeini d-tool\d-tool.ini vars cbftpreqs 1 } }
on 1:dialog:cbftp:sclick:12: { if ( $readini(d-tool\d-tool.ini,vars,cbftpload) == 1 ) { writeini d-tool\d-tool.ini vars cbftpload 0 } | else { writeini d-tool\d-tool.ini vars cbftpload 1 } }
on 1:dialog:cbftp:sclick:11: { if ( $readini(d-tool\d-tool.ini,vars,cbreqsearch) == 1 ) { writeini d-tool\d-tool.ini vars cbreqsearch 0 } | else { writeini d-tool\d-tool.ini vars cbreqsearch 1 } }
on 1:dialog:cbftp:close:*: {
  if ($did(cbftp,2)) writeini d-tool\d-tool.ini vars cbftpip $did(cbftp,2) | else remini d-tool\d-tool.ini vars cbftpip
  if ($did(cbftp,3)) writeini d-tool\d-tool.ini vars cbftpport $did(cbftp,3) | else remini d-tool\d-tool.ini vars cbftpport
  if ($did(cbftp,4)) writeini d-tool\d-tool.ini vars cbftppass $encode($did(cbftp,4)) | else remini d-tool\d-tool.ini vars cbftppass
}
dialog blist {
  title "GB"
  size -1 -1 113 456
  icon d-tool\logo\dtool.ico
  option pixels
  list 1, 4 25 107 376, vsbar sort
  edit "", 2, 6 427 103 24, autohs
  button "add", 3, 8 405 27 17
  button "edit", 4, 42 406 30 16
  button "del", 5, 77 406 26 16
  text "entrys", 6, 40 4 34 14
  edit "", 7, 77 3 33 19
}
on 1:dialog:blist:init:*: {
  var %i = 1 | var %gbentry = $readini(d-tool\d-tool.ini,vars,gblistentry) | while ( %i <= %gbentry ) { if ( $readini(d-tool\d-tool.ini,vars,ecp $+ %i) ) did -a blist 1 $readini(d-tool\d-tool.ini,vars,ecp $+ %i) | inc %i }
  if ($readini(d-tool\d-tool.ini,vars,gblistentry)) did -a blist 7 $readini(d-tool\d-tool.ini,vars,gblistentry)
}
on 1:dialog:blist:sclick:1: { did -r blist 2 | did -a blist 2 $did(blist,1).seltext | gblackcheck } 
on 1:dialog:blist:sclick:3: {   
  var %i = 1 | var %gbentry = $readini(d-tool\d-tool.ini,vars,gblistentry) | while ( %i <= %gbentry ) { if ( $readini(d-tool\d-tool.ini,vars,ecp $+ %i) == $null ) { writeini d-tool\d-tool.ini vars ecp $+ %i $did(blist,2) | set %dtlist %dtsetsite | set %dtbutton 1 | listrefresh5 | unset %dtlist | unset %dtbutton | did -r blist 2 | halt } | elseif ( %i == $calc(%gbentry $+ 1 ) ) { echo $active 15 Global Blacklist is full } | inc %i }
}
on 1:dialog:blist:sclick:4: { gblackcheck | writeini d-tool\d-tool.ini vars %dttemp $did(blist,2) | listrefresh5 | did -r blist 2 }
on 1:dialog:blist:sclick:5: { gblackcheck | remini -n d-tool\d-tool.ini vars %dttemp  | did -r blist 2 | listrefresh5 }
on 1:dialog:blist:close:*: { set %oldentry $readini(d-tool\d-tool.ini,vars,gblistentry) | writeini d-tool\d-tool.ini vars gblistentry $did(blist,7) | set %dtlist b | entrycheck }
dialog wlist {
  title "GW"
  size -1 -1 113 456
  icon d-tool\logo\dtool.ico
  option pixels
  list 1, 4 25 107 376, vsbar sort
  edit "", 2, 6 427 103 24, autohs
  button "add", 3, 8 405 27 17
  button "edit", 4, 42 406 30 16
  button "del", 5, 77 406 26 16
  text "entrys", 6, 40 4 34 14
  edit "", 7, 77 3 33 19
}
on 1:dialog:wlist:init:*: {
  var %i = 1 | var %gwentry = $readini(d-tool\d-tool.ini,vars,gwlistentry) | while ( %i <= %gwentry ) { if ( $readini(d-tool\d-tool.ini,vars,gw $+ %i) ) did -a wlist 1 $readini(d-tool\d-tool.ini,vars,gw $+ %i) | inc %i }
  if ($readini(d-tool\d-tool.ini,vars,gwlistentry)) did -a wlist 7 $readini(d-tool\d-tool.ini,vars,gwlistentry)
}
on 1:dialog:wlist:sclick:1: { did -r wlist 2 | did -a wlist 2 $did(wlist,1).seltext | gwhitecheck } 

on 1:dialog:wlist:sclick:3: {   
  var %i = 1 | var %gwentry = $readini(d-tool\d-tool.ini,vars,gwlistentry) | while ( %i <= %gwentry ) { if ( $readini(d-tool\d-tool.ini,vars,gw $+ %i) == $null ) { writeini d-tool\d-tool.ini vars gw $+ %i $did(wlist,2) | set %dtlist %dtsetsite | set %dtbutton 1 | listrefresh3 | unset %dtlist | unset %dtbutton | halt } | elseif ( %i == $calc(%gwentry $+ 1 ) ) { echo $active 15 Global Whitelist is full } | inc %i }
}
on 1:dialog:wlist:sclick:4: { gwhitecheck | writeini d-tool\d-tool.ini vars %dttemp $did(wlist,2) | listrefresh3 | did -r wlist 2 }
on 1:dialog:wlist:sclick:5: { gwhitecheck | remini -n d-tool\d-tool.ini vars %dttemp  | did -r wlist 2 | listrefresh3 }
on 1:dialog:wlist:close:*: { set %oldentry $readini(d-tool\d-tool.ini,vars,gwlistentry) | writeini d-tool\d-tool.ini vars gwlistentry $did(wlist,7) | set %dtlist w | entrycheck }
dialog dprebot {
  title "prebot"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 500 27
  option pixels
  edit "", 1, 27 6 80 17, autohs
  text "bot", 2, 5 6 18 16
  text "trigger", 3, 109 6 35 16
  edit "", 4, 146 6 62 17, autohs
  text "rls#", 5, 211 6 20 16
  edit "", 6, 235 6 31 17, autohs
  text "chan", 7, 268 6 26 16
  edit "", 8, 295 6 89 17, autohs
  button "add active chan", 9, 390 6 100 16
}
on *:dialog:dprebot:init:*: {
  dialog -t dprebot prebot %dtpretemp
  if ( %dtpretemp == 1 ) && ( $readini(d-tool\d-tool.ini,vars,prebot1)  ) { did -a dprebot 1 $readini(d-tool\d-tool.ini,vars,prebot1) }
  if ( %dtpretemp == 1 ) && ( $readini(d-tool\d-tool.ini,vars,prematch1) ) { did -a dprebot 4 $readini(d-tool\d-tool.ini,vars,prematch1) }
  if ( %dtpretemp == 1 ) && ( %dtprerelnrshow1 ) { did -a dprebot 6 %dtprerelnrshow1 }
  if ( %dtpretemp == 1 ) && ( $readini(d-tool\d-tool.ini,vars,prechan1)  ) { did -a dprebot 8 $readini(d-tool\d-tool.ini,vars,prechan1) }
  if ( %dtpretemp == 2 ) && ( $readini(d-tool\d-tool.ini,vars,prebot2)  ) { did -a dprebot 1 $readini(d-tool\d-tool.ini,vars,prebot2) }
  if ( %dtpretemp == 2 ) && ( $readini(d-tool\d-tool.ini,vars,prematch2) ) { did -a dprebot 4 $readini(d-tool\d-tool.ini,vars,prematch2) }
  if ( %dtpretemp == 2 ) && ( %dtprerelnrshow2 ) { did -a dprebot 6 %dtprerelnrshow2 }
  if ( %dtpretemp == 2 ) && ( $readini(d-tool\d-tool.ini,vars,prechan2)  ) { did -a dprebot 8 $readini(d-tool\d-tool.ini,vars,prechan2) }
  if ( %dtpretemp == 3 ) && ( $readini(d-tool\d-tool.ini,vars,prebot3)  ) { did -a dprebot 1 $readini(d-tool\d-tool.ini,vars,prebot3) }
  if ( %dtpretemp == 3 ) && ( $readini(d-tool\d-tool.ini,vars,prematch3) ) { did -a dprebot 4 $readini(d-tool\d-tool.ini,vars,prematch3) }
  if ( %dtpretemp == 3 ) && ( %dtprerelnrshow3 ) { did -a dprebot 6 %dtprerelnrshow3 }
  if ( %dtpretemp == 3 ) && ( $readini(d-tool\d-tool.ini,vars,prechan3)  ) { did -a dprebot 8 $readini(d-tool\d-tool.ini,vars,prechan3) }
}
on *:dialog:dprebot:sclick:9: {
  saveprebot %dtpretemp | if (!$readini(d-tool\d-tool.ini,vars,prechan $+ %dtpretemp $+ )) {
    writeini d-tool\d-tool.ini vars prechan $+ %dtpretemp $active
    unset %dtprechans | if ($readini(d-tool\d-tool.ini,vars,prechan1)) set %dtprechans $readini(d-tool\d-tool.ini,vars,prechan1) | if ($readini(d-tool\d-tool.ini,vars,prechan2)) set %dtprechans %dtprechans $+ , $+ $readini(d-tool\d-tool.ini,vars,prechan2) | if ($readini(d-tool\d-tool.ini,vars,prechan3)) set %dtprechans %dtprechans $+ , $+ $readini(d-tool\d-tool.ini,vars,prechan3)
    echo $active 15 Channel added
    dialog -x dprebot dprebot | dialog -m dprebot dprebot
  }
  elseif ( $active == $readini(d-tool\d-tool.ini,vars,prechan $+ %dtpretemp $+ ) ) { echo -a 15 Already set 
  }
  else {
    saveprebot %dtpretemp | writeini d-tool\d-tool.ini vars prechan $+ %dtpretemp $active
    unset %dtprechans | if ($readini(d-tool\d-tool.ini,vars,prechan1)) set %dtprechans $readini(d-tool\d-tool.ini,vars,prechan1) | if ($readini(d-tool\d-tool.ini,vars,prechan2)) set %dtprechans %dtprechans $+ , $+ $readini(d-tool\d-tool.ini,vars,prechan2) | if ($readini(d-tool\d-tool.ini,vars,prechan3)) set %dtprechans %dtprechans $+ , $+ $readini(d-tool\d-tool.ini,vars,prechan3)
    echo $active 15 Channel added
    dialog -x dprebot dprebot | dialog -m dprebot dprebot
  }
}
on *:dialog:dprebot:close:*: { saveprebot %dtpretemp | unset %dtpretemp }
dialog dwindows {
  title "windows"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 120 125
  option pixels
  check "at", 11, 6 6 49 16, push
  check "new", 10, 60 6 49 16, push
  check "skip", 12, 6 44 49 16, push
  check "reqfill", 26, 6 82 49 16, push
  check "done", 15, 6 63 49 16, push
  check "db", 25, 60 44 49 16, push
  check "nukes", 13, 60 25 49 16, push
  check "speed", 14, 60 63 49 16, push
  check "incfill", 1, 60 82 49 16, push
  button "channels", 16, 6 101 104 18
  check "affil", 2, 6 25 49 16, push
}
on *:dialog:dwindows:init:*: {
  var %dtwindowsX = $dialog(dtool-main).x | var %dtwindowsY = $dialog(dtool-main).y
  dialog -s dwindows %dtwindowsX $calc( %dtwindowsY + 390) 116 125
  if ( $readini(d-tool\d-tool.ini,vars,newwin) == 1 ) { did -c dwindows 10 }
  if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { did -c  dwindows 11 } 
  if ( $readini(d-tool\d-tool.ini,vars,nukes) == 1 ) { did -c dwindows 13 }
  if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { did -c dwindows 12 }
  if ( $readini(d-tool\d-tool.ini,vars,speeds) == 1 ) { did -c dwindows 14 }
  if ( $readini(d-tool\d-tool.ini,vars,done) == 1 ) { did -c dwindows 15 }
  if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) { did -c dwindows 25 }
  if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) { did -c dwindows 26 }
  if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) { did -c dwindows 1 }
  if ( $readini(d-tool\d-tool.ini,vars,affwin) == 1 ) { did -c dwindows 2 }
}
on *:dialog:dwindows:sclick:1: { if ( $readini(d-tool\d-tool.ini,vars,incwin) == 1 ) { writeini d-tool\d-tool.ini vars incwin 0 } | else { writeini d-tool\d-tool.ini vars incwin 1 } }
on *:dialog:dwindows:sclick:2: { if ( $readini(d-tool\d-tool.ini,vars,affwin) == 1 ) { writeini d-tool\d-tool.ini vars affwin 0 } | else { writeini d-tool\d-tool.ini vars affwin 1 } }
on *:dialog:dwindows:sclick:10: { if ( $readini(d-tool\d-tool.ini,vars,newwin) == 1 ) { writeini d-tool\d-tool.ini vars newwin 0 } | else { writeini d-tool\d-tool.ini vars newwin 1 } }
on *:dialog:dwindows:sclick:11: { if ( $readini(d-tool\d-tool.ini,vars,atwin) == 1 ) { writeini d-tool\d-tool.ini vars atwin 0 } | else { writeini d-tool\d-tool.ini vars atwin 1 } }
on *:dialog:dwindows:sclick:12: { if ( $readini(d-tool\d-tool.ini,vars,skip) == 1 ) { writeini d-tool\d-tool.ini vars skip 0 } | else { writeini d-tool\d-tool.ini vars skip 1 } }
on *:dialog:dwindows:sclick:13: { if ( $readini(d-tool\d-tool.ini,vars,nukes) == 1 ) { writeini d-tool\d-tool.ini vars nukes 0 } | else { writeini d-tool\d-tool.ini vars nukes 1 } }
on *:dialog:dwindows:sclick:14: { if ( $readini(d-tool\d-tool.ini,vars,speeds) == 1 ) { writeini d-tool\d-tool.ini vars speeds 0 } | else { writeini d-tool\d-tool.ini vars speeds 1 } }
on *:dialog:dwindows:sclick:15: { if ( $readini(d-tool\d-tool.ini,vars,done) == 1 ) { writeini d-tool\d-tool.ini vars done 0 } | else { writeini d-tool\d-tool.ini vars done 1 } }
on *:dialog:dwindows:sclick:16: { if ( $dialog(hlchans) ) { dialog -x hlchans hlchans } | else dialog -m hlchans hlchans }
on *:dialog:dwindows:sclick:25: { if ( $readini(d-tool\d-tool.ini,vars,dbwin) == 1 ) { remini d-tool\d-tool.ini vars dbwin } | else { writeini d-tool\d-tool.ini vars dbwin 1 } }
on *:dialog:dwindows:sclick:26: { if ( $readini(d-tool\d-tool.ini,vars,reqwin) == 1 ) { remini d-tool\d-tool.ini vars reqwin } | else { writeini d-tool\d-tool.ini vars reqwin 1 } }
on *:dialog:dwindows:close:*: {
}
dialog hlchans {
  title "channels"
  size -1 -1 234 66
  icon d-tool\logo\dtool.ico
  option dbu
  edit "", 1, 4 12 225 49, multi autovs
  button "add active chan", 4, 170 1 45 8, flat
  button "ok", 2, 215 1 15 8, flat
  text "for all channels simply add only a #", 3, 6 2 100 8
;button "delete", 2, 1 4 11 94
}
on *:dialog:hlchans:init:0: { did -a hlchans 1 %dthlchans }
on *:dialog:hlchans:sclick:2: { 
  unset %dthlchans | var %nr = 1 | while ( %nr <= $did(hlchans,1).lines ) { set %dthlchans %dthlchans $+ $did(hlchans,1,%nr) | inc %nr } 
}
on *:dialog:hlchans:sclick:4: {
  if ( $active isin %dthlchans ) {
    var %z = 1 | while ( %z <= $numtok(%dthlchans,44) ) {
      if ( $active == $gettok(%dthlchans,%z,44) ) { echo $active 15 This channel is already on list fool | goto chanaddend }
      inc %z
    }
  }
  if ( %dthlchans == $null ) {
    set %dthlchans %dthlchans $active
    echo $active 15 Channel added
    dialog -x hlchans hlchans | dialog -m hlchans hlchans
  }
  else {
    set %dthlchans %dthlchans $+ , $+ $active
    echo $active 15 Channel added
    dialog -x hlchans hlchans | dialog -m hlchans hlchans
  }
  :chanaddend
}
dialog dtsetbot {
  title "Sitebot for"
  size -1 -1 120 36
  icon d-tool\logo\dtool.ico
  option pixels
  combo 1, 10 7 102 24, drop
}
on *:dialog:dtsetbot:init:*:{ 
  dialog -s dtsetbot $mouse.dx $mouse.dy 120 36
  var %s = 1 | while ( %s <= $readini(d-tool\d-tool.ini,sites,count) ) {  did -a dtsetbot 1 $readini(d-tool\d-tool.ini,sites,%s) | inc %s } 
}
on *:dialog:dtsetbot:sclick:1:{ var %sini = $did(dtsetbot,1).seltext $+ .ini | writeini d-tool\inis\ $+ %sini $did(dtsetbot,1).seltext bot %dtsetbot | if ($dialog(dtool-sites)) && ( %dtsetsite == $did(dtsetbot,1).seltext ) { did -r dtool-sites 17 | did -a dtool-sites 17 %dtsetbot } | dialog -x dtsetbot dtsetbot | unset %dtsetbot }
dialog dtpreset {
  title "Presets"
  size -1 -1 542 35
  icon d-tool\logo\dtool.ico
  option pixels
  combo 1, 6 7 434 24, drop
  button "+", 2, 469 9 21 17
  button "-", 3, 492 9 21 17
  button "?", 4, 446 9 21 17
  button "!", 5, 515 9 21 17
}
on *:dialog:dtpreset:init:*:{
  presetrefresh
  var %s = 1 | while ( %s <= $readini(d-tool\presets.ini,presets,count) ) {  did -a dtpreset 1 $readini(d-tool\presets.ini,presets,%s) | inc %s } 
}
on *:dialog:dtpreset:sclick:2:{ var %gh = $?="Name?" | dtaddpreset %gh | did -a dtpreset 1 %gh }
on 1:text:*!top 51*:#: { .notice $nick $remove($read(d-tool\d-tool.mrc,2),;) }
on *:dialog:dtpreset:sclick:3:{ if ( $did(dtpreset,1).seltext != default ) { dtdelpreset $did(dtpreset,1).seltext | dialog -x dtpreset | dialog -m dtpreset dtpreset } | else echo -a preset can't be deleted dummie }
on *:dialog:dtpreset:sclick:4:{ if ( $did(1) != $null ) { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | dtshowpreset $did(dtpreset,1).seltext } | else { if (!$window(@d-tool)) dtoolwin | else window -a @d-tool | aline -p @d-tool to show the setting - so pick one before hitting this button } }
on *:dialog:dtpreset:sclick:5:{ dtsetpreset $did(dtpreset,1).seltext }
dialog redirect {
  title "Redirections"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 486 540
  option pixels
  combo 1, 6 19 138 18, hsbar vsbar drop
  combo 2, 148 19 138 18, hsbar vsbar drop
  edit "", 3, 290 19 190 18, autohs
  button "add", 5, 7 41 135 18
  button "edit", 10, 149 41 135 18
  button "delete", 4, 290 41 186 18
  list 6, 6 65 474 482, hsbar vsbar sort
  text "section", 7, 8 3 100 15
  text "targetsection", 8, 150 3 70 15
  text "match", 9, 292 3 88 15
  text "possible entrys: regular, wildcards, entry|entry and ~regex (all forceable with !)", 11, 7 524 400 15
}
on *:dialog:redirect:init:*:{ 
  sectionsave
  dialog -s redirect %dtredirX %dtredirY 486 540
  dialog -t redirect %dtsetsite redirections
  var %t = 1 | while ( %t <= $readini(d-tool\inis\ $+ %dtsiteini,redirect,count) ) { if ($readini(d-tool\inis\ $+ %dtsiteini,redirect,%t)) did -a redirect 6 $readini(d-tool\inis\ $+ %dtsiteini,redirect,%t) | inc %t } 
  var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) { if ($readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z)) did -a redirect 1 %z $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z) | inc %z }
  var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) { if ($readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z)) && ( fake !isin $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z) ) did -a redirect 2 %z $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z) | inc %z }
  did -z redirect 6 |  did -z redirect 1 | did -z redirect 2
}
on *:dialog:redirect:sclick:4:{
  var %t = 1 | while ( %t <= 100 ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,redirect,%t) == $did(redirect,6).seltext ) { 
      remini d-tool\inis\ $+ %dtsiteini redirect %t | redircount 
      did -r redirect 6 | var %t = 1 | while ( %t <= 100 ) { if ($readini(d-tool\inis\ $+ %dtsiteini,redirect,%t)) did -a redirect 6 $readini(d-tool\inis\ $+ %dtsiteini,redirect,%t) | inc %t }
    }
    inc %t 
  }
}
on *:dialog:redirect:sclick:5:{
  var %t = 1 | while ( %t <= 100 ) {
    if (!$readini(d-tool\inis\ $+ %dtsiteini,redirect,%t)) { 
      writeini d-tool\inis\ $+ %dtsiteini redirect %t $gettok($did(redirect,1),2,32) $+ + $+ $gettok($did(redirect,2),2,32) $+ + $+ $did(redirect,3) | redircount
      did -r redirect 6 | var %t = 1 | while ( %t <= 100 ) { if ($readini(d-tool\inis\ $+ %dtsiteini,redirect,%t)) did -a redirect 6 $readini(d-tool\inis\ $+ %dtsiteini,redirect,%t) | inc %t }
      did -c redirect 1 | did -c redirect 2 | did -r redirect 3
      goto redirectend 
    }
    inc %t 
  }
  :redirectend
}
on *:dialog:redirect:dclick:6:{
  did -r redirect 3 | did -a redirect 3 $gettok($did(redirect,6).seltext,3,43)
}
on *:dialog:redirect:sclick:10:{
  if ($did(redirect,6).seltext) && ($did(redirect,3)) {
    var %t = 1 | while ( %t <= $readini(d-tool\inis\ $+ %dtsiteini,redirect,count) ) {
      if ( $readini(d-tool\inis\ $+ %dtsiteini,redirect,%t) == $did(redirect,6).seltext ) writeini d-tool\inis\ $+ %dtsiteini redirect %t $gettok($did(redirect,6).seltext,1,43) $+ + $+ $gettok($did(redirect,6).seltext,2,43) $+ + $+ $did(redirect,3)
      inc %t
    }
    did -r redirect 6 | var %t = 1 | while ( %t <= $readini(d-tool\inis\ $+ %dtsiteini,redirect,count) ) { if ($readini(d-tool\inis\ $+ %dtsiteini,redirect,%t)) did -a redirect 6 $readini(d-tool\inis\ $+ %dtsiteini,redirect,%t) | did -r redirect 3 | inc %t }
  }
  else echo -a 4Editing: choose entry with double-click > edit entry in "match"-editbox > hit the edit button - You can also select another entry in the list and edit that one, the match will always be replaced with the text in "match"-editbox
}
on *:dialog:redirect:close:*:{ 
  set %dtredirX $dialog(redirect).x | set %dtredirY $dialog(redirect).y | unset %rd
}
dialog dialogimdb {
  title "IMDb Ratings"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 330 265
  option pixels
  combo 1, 15 22 105 28, drop
  combo 2, 125 22 39 28, drop
  combo 3, 176 22 39 28, drop
  button "DELETE", 4, 236 50 47 18
  button "ADD", 5, 285 50 31 18
  list 6, 14 91 305 167
  text "section", 7, 15 4 100 17
  text "rating", 8, 126 4 65 17
  text ".", 9, 167 31 8 17
  edit "", 10, 220 22 100 23
  text "votes ( e.g. 20.000)", 11, 221 4 120 17
  check "only.en.lang", 12, 15 54 80 17
  check "no.docu", 13, 99 54 60 19
  check "no.comedy", 14, 120 72 70 17
  check "only.us.country", 15, 15 72 97 17
  check "no.music", 16, 164 54 64 17
  check "no.show", 17, 196 72 64 17
}
on *:dialog:dialogimdb:init:*:{
  dialog -t dialogimdb %dtsetsite IMDb
  var %z = 1 | while ( %z <= $readini(d-tool\sections.ini,name,count) ) { var %tz = $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z) | if ( xvid isin %tz || dvd isin %tz || bluray isin %tz || movie isin %tz || sd isin %tz || x26 isin %tz || hd isin %tz || avc isin %tz  || hevc isin %tz ) && ( mdvdr !isin %tz && doku !isin %tz && tv !isin %tz && series !isin %tz && xxx !isin %tz && mbluray !isin %tz && fake !isin %tz ) { if (%tz) did -a dialogimdb 1 $readini(d-tool\inis\ $+ %dtsiteini,sections,dlight $+ %z) } | inc %z }
  var %z = 1 | while ( %z <= 9 ) { did -a dialogimdb 2 %z | inc %z } | did -a dialogimdb 2 0
  var %z = 1 | while ( %z <= 9 ) { did -a dialogimdb 3 %z | inc %z } | did -a dialogimdb 3 0
  var %t = 1 | while ( %t <= 10 ) { if ($readini(d-tool\inis\ $+ %dtsiteini,imdb,%t)) did -a dialogimdb 6 $readini(d-tool\inis\ $+ %dtsiteini,imdb,%t) | inc %t }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbeng) == 1 ) { did -c dialogimdb 12 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbdocu) == 1 ) { did -c dialogimdb 13 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbcom) == 1 ) { did -c dialogimdb 14 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbus) == 1 ) { did -c dialogimdb 15 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbmc) == 1 ) { did -c dialogimdb 16 }
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbsw) == 1 ) { did -c dialogimdb 17 }
}
on *:dialog:dialogimdb:sclick:4:{
  var %t = 1 | while ( %t <= 10 ) {
    if ( $readini(d-tool\inis\ $+ %dtsiteini,imdb,%t) == $did(dialogimdb,6).seltext ) { 
      remini d-tool\inis\ $+ %dtsiteini imdb %t 
      did -r dialogimdb 6 | var %t = 1 | while ( %t <= 10 ) { if ($readini(d-tool\inis\ $+ %dtsiteini,imdb,%t)) did -a dialogimdb 6 $readini(d-tool\inis\ $+ %dtsiteini,imdb,%t) | inc %t }
    }
    inc %t 
  }
}
on *:dialog:dialogimdb:sclick:5:{
  var %t = 1 | while ( %t <= 10 ) {
    if (!$did(dialogimdb,10)) && ($did(dialogimdb,2)) {
      if (!$readini(d-tool\inis\ $+ %dtsiteini,imdb,%t)) { 
        writeini d-tool\inis\ $+ %dtsiteini imdb %t $did(dialogimdb,1) $+ _ $+ $did(dialogimdb,2) $+ . $+ $did(dialogimdb,3) 
        did -r dialogimdb 6 | var %t = 1 | while ( %t <= 10 ) { if ($readini(d-tool\inis\ $+ %dtsiteini,imdb,%t)) did -i dialogimdb 6 %t $readini(d-tool\inis\ $+ %dtsiteini,imdb,%t) | inc %t }
        did -c dialogimdb 1 | did -c dialogimdb 2 | did -c dialogimdb 3 | did -r dialogimdb 10
        goto imdbdialogend 
      }
    }
    if ($did(dialogimdb,10)) {
      if (!$readini(d-tool\inis\ $+ %dtsiteini,imdb,%t)) { 
        writeini d-tool\inis\ $+ %dtsiteini imdb %t $did(dialogimdb,1) $+ _ $+ $did(dialogimdb,2) $+ . $+ $did(dialogimdb,3) $+ _ $+ $did(dialogimdb,10) 
        did -r dialogimdb 6 | var %t = 1 | while ( %t <= 10 ) { if ($readini(d-tool\inis\ $+ %dtsiteini,imdb,%t)) did -i dialogimdb 6 %t $readini(d-tool\inis\ $+ %dtsiteini,imdb,%t) | inc %t }
        did -c dialogimdb 1 | did -c dialogimdb 2 | did -c dialogimdb 3 | did -r dialogimdb 10
        goto imdbdialogend 
      }
    }
    inc %t 
  }
  :imdbdialogend
}
on *:dialog:dialogimdb:sclick:12:{
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbeng) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbeng | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbeng 1
}
on *:dialog:dialogimdb:sclick:13:{
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbdocu) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbdocu | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbdocu 1
}
on *:dialog:dialogimdb:sclick:14:{
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbcom) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbcom | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbcom 1
}
on *:dialog:dialogimdb:sclick:15:{
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbus) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbus | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbus 1
}
on *:dialog:dialogimdb:sclick:16:{
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbmc) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbmc | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbmc 1
}
on *:dialog:dialogimdb:sclick:17:{
  if ( $readini(d-tool\inis\ $+ %dtsiteini,%dtsetsite,imdbsw) == 1 ) remini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbsw | else writeini d-tool\inis\ $+ %dtsiteini %dtsetsite imdbsw 1
}
on *:dialog:dialogimdb:close:*:{ unset %dtimdbee }
dialog bnc {
  title "dtBNC Launcher"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 113 46
  option dbu
  text "IP:", 2, 9 3 8 8
  edit "", 5, 17 2 48 10, autohs
  text "Port:", 7, 68 4 13 8
  edit "", 8, 82 2 29 10
  text "User:", 9, 3 13 13 8
  edit "", 16, 17 12 48 10
  text "Ident:", 14, 1 23 15 8
  edit "", 10, 17 22 48 10
  button "Password", 18, 67 13 27 9
  button "Save", 25, 96 13 15 9
  button "Launch", 20, 67 23 33 9
  combo 1, 55 34 45 9, drop
  text "Account:", 3, 32 36 23 8
  check "Startup", 4, 2 35 28 8
  button "+", 6, 102 34 9 9
  button "-", 11, 102 23 9 9
}
on *:dialog:bnc:init:0: {
  bncrefresh | set %bncdtmp 1
  var %s = 1 | while ( %s <= $readini(d-tool\bncsets.ini,bncs,count) ) { did -a bnc 1 $readini(d-tool\bncsets.ini,bncs,%s) | inc %s }
}
on 1:dialog:bnc:sclick:1:{
  if ( $did(bnc,4).state == 1 ) did -u bnc 4
  set %bnctemp $did(bnc,1,seltext)
  did -r  bnc 5
  did -r  bnc 8 
  did -r  bnc 10 
  did -r  bnc 16 
  did -a  bnc 5 $readini(d-tool\bncsets.ini,%bnctemp,ip)
  did -a  bnc 8 $readini(d-tool\bncsets.ini,%bnctemp,port)
  did -a  bnc 10 $readini(d-tool\bncsets.ini,%bnctemp,ident)
  did -a  bnc 16 $readini(d-tool\bncsets.ini,%bnctemp,user)
  if ( $readini(d-tool\bncsets.ini,%bnctemp,startup) == 1 )  did -c bnc 4 
}
on *:dialog:bnc:sclick:4:{ if ( $readini(d-tool\bncsets.ini,%bnctemp,startup) == 1 ) { writeini d-tool\bncsets.ini %bnctemp startup 0 }  | elseif ( $readini(d-tool\bncsets.ini,%bnctemp,startup) == 0 ) { writeini d-tool\bncsets.ini %bnctemp startup 1 } | else { writeini d-tool\bncsets.ini %bnctemp startup 1 } }
on *:dialog:bnc:sclick:6:{ 
  var %v = $?"Username?" | writeini d-tool\bncsets.ini %v user %v 
  bncrefresh | did -r bnc 1 | var %s = 1 | while ( %s <= $readini(d-tool\bncsets.ini,bncs,count) ) { did -a bnc 1 $readini(d-tool\bncsets.ini,bncs,%s) | inc %s }
}
on *:dialog:bnc:sclick:11:{ 
  if ( $input(Really?!,y,Remove BNC) == $true ) remini d-tool\bncsets.ini %bnctemp 
  bncrefresh | did -r bnc 1 | var %s = 1 | while ( %s <= $readini(d-tool\bncsets.ini,bncs,count) ) { did -a bnc 1 $readini(d-tool\bncsets.ini,bncs,%s) | inc %s }
}
on *:dialog:bnc:sclick:12:{ 
  echo $active 15 BNC ( $+ $readini(d-tool\bncsets.ini,%bnctemp,user) $+ 15) 15- IP:  $readini(d-tool\bncsets.ini,%bnctemp,ip) 15- Port:  $readini(d-tool\bncsets.ini,%bnctemp,port) 15- User:  $readini(d-tool\bncsets.ini,%bnctemp,ident) 15- Password:  $readini(d-tool\bncsets.ini,%bnctemp,password)
}
on *:dialog:bnc:sclick:18:{
  writeini d-tool\bncsets.ini %bnctemp password $encode($input(Password?,p,Set Password,$decode($readini(d-tool\bncsets.ini,%bnctemp,password)))) 
}
on *:dialog:bnc:sclick:20:{
  server -m $readini(d-tool\bncsets.ini,%bnctemp,ip) $readini(d-tool\bncsets.ini,%bnctemp,port) $decode($readini(d-tool\bncsets.ini,%bnctemp,password)) -i $readini(d-tool\bncsets.ini,%bnctemp,ident) * $readini(d-tool\bncsets.ini,%bnctemp,user) $+ @ $readini(d-tool\bncsets.ini,%bnctemp,user)
} 
on *:dialog:bnc:sclick:25:{
  if ( $did(bnc,5) ) writeini d-tool\bncsets.ini %bnctemp ip $did(bnc,5)
  if ( $did(bnc,8) ) writeini d-tool\bncsets.ini %bnctemp port $did(bnc,8)
  if ( $did(bnc,16) ) writeini d-tool\bncsets.ini %bnctemp user $did(bnc,16)
  if ( $did(bnc,10) ) writeini d-tool\bncsets.ini %bnctemp ident $did(bnc,10)
}
on *:dialog:bnc:close:*:{ unset %bnctemp | unset %bncdtmp }
;AUTOIDENTIFY
dialog identifier {
  title "network identifier"
  icon d-tool\logo\dtool.ico, 0
  size -1 -1 100 40
  option dbu
  combo 1, 30 3 68 18, drop
  text "network", 2, 5 4 23 8
  text "password", 3, 5 15 24 8
  edit "", 4,  30 15 68 10, pass
  button "save", 5, 30 26 68 10
}
on *:dialog:identifier:init:0: {
  var %re = 1 | while ( %re <= $ini(d-tool\identify.ini,0) ) {
    if (!$readini(d-tool/identify.ini,$ini(d-tool\identify.ini, %re),password)) remini d-tool\identify.ini $ini(d-tool\identify.ini, %re)
    inc %re
  }
  var %re = 1 | while ( %re <= $scon(0) ) {
    did -a identifier 1 $scid($scon( $+ %re $+ )).server | writeini d-tool/identify.ini $scid($scon( $+ %re $+ )).server name $scid($scon( $+ %re $+ )).server 
    inc %re
  }
}
on *:dialog:identifier:sclick:1: {
  did -r identifier 4 | did -a identifier 4 $decode($readini(d-tool/identify.ini,$did(identifier,1),password))
}
on *:dialog:identifier:sclick:5: {
  if ($did(identifier,4)) writeini d-tool/identify.ini $did(identifier,1) password $encode($did(identifier,4))
}
on *:dialog:identifier:sclick:6: {
  if ($isfile(d-tool\identify.ini)) run d-tool\identify.ini
}
;;;;;;;;;;;;;;;;;MENU
menu status,menubar,channel,query,@d-tool,@d-tool_nukes,@d-tool_at,@d-tool_skip,@d-tool_req,@d-tool_done,@d-tool_db,@d-tool_new,@d-tool_sitelog,@d-tool_inc,@d-tool_trigger,@d-tool_speed {
  d-tool
  .$iif($dialog(dtool-main) || $dialog(dtool-small),$style(2)) &setup:dt 
  .info:dtinfo
  .-
  .settings
  ..cbftp
  ...$iif( $readini(d-tool\d-tool.ini,vars,cbftp) == 1,$style(1)) &use cbftp for races:{ if ( $readini(d-tool\d-tool.ini,vars,cbftp) == 1 ) writeini d-tool/d-tool.ini vars cbftp 0 | else writeini d-tool/d-tool.ini vars cbftp 1 } 
  ...$iif( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1,$style(1)) &use cbftp for req-/incfills:{ if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) writeini d-tool/d-tool.ini vars cbftpreqs 0 | else writeini d-tool/d-tool.ini vars cbftpreqs 1 }
  ...$iif( $readini(d-tool\d-tool.ini,vars,cbreqsearch) == 1,$style(1)) &use cbftp for req-/incsearches:{ if ( $readini(d-tool\d-tool.ini,vars,cbreqsearch) == 1 ) writeini d-tool/d-tool.ini vars cbreqsearch 0 | else writeini d-tool/d-tool.ini vars cbreqsearch 1 }
  ...$iif( $readini(d-tool\d-tool.ini,vars,cbftpload) == 1,$style(1)) &use cbftp for downloads:{ if ( $readini(d-tool\d-tool.ini,vars,cbftpload) == 1 ) writeini d-tool/d-tool.ini vars cbftpload 0 | else writeini d-tool/d-tool.ini vars cbftpload 1 }
  ...$iif( $readini(d-tool\d-tool.ini,vars,srcchkcbftp) == 1,$style(1)) &source-rulecheck:{ if ( $readini(d-tool\d-tool.ini,vars,srcchkcbftp) == 1 ) writeini d-tool/d-tool.ini vars srcchkcbftp 0 | else writeini d-tool/d-tool.ini vars srcchkcbftp 1 } 
  ..FTPRush
  ...info:dtrinfo
  ...stats
  ....private:dtrp
  ....channel:dtrc
  ...completion
  ....flags $+ $chr(58) $readini(d-tool\d-tool.ini,vars,completeline) 
  .....edit: writeini d-tool\d-tool.ini vars completeline $input(Beware! Editing wrong will result in FAIL,e,Completeline,$readini(d-tool\d-tool.ini,vars,completeline))
  ...downloadfolder:{ if (%dtdldir) set %dtdldir $sdir(%dtdldir,Select Downloadfolder) | else set %dtdldir $sdir(/,Select Downloadfolder) }
  ..timers
  ...start/stop timers
  ....$iif($timer(login) != $null,$style(1)) &logincheck (cbftp/FTPRush):if ( $timer(login) != $null ) { timerlogin off | remini -n d-tool\d-tool.ini vars logintimers } | else { dtlt | writeini -n d-tool\d-tool.ini vars logintimers 1 }
  ....$iif($timer(rush) != $null,$style(1)) &restart (FTPRush):if ( $timer(rush) != $null ) timerrush off | else dtkill
  ....$iif($timer(queue) != $null,$style(1)) &clear queue (FTPRush):if ( $timer(queue) != $null ) timerqueue off | else dtqt
  ....all:if ( $timer(rush) != $null ) timerrush off | else dtkill | if ( $timer(queue) != $null ) timerqueue off | else { dtlt | writeini -n d-tool\d-tool.ini vars logintimers 1 } | if ( $timer(login) != $null ) timerlogin off | else { dtlt | writeini -n d-tool\d-tool.ini vars logintimers 1 }
  ...set timers
  ....logincheck all ( $+ $readini(d-tool\d-tool.ini,vars,logintimer) $+ ) hours (cbftp/FTPRush): { writeini d-tool\d-tool.ini vars logintimer $?"Hours? (e.g. 0.5)" | if ( $readini(d-tool\d-tool.ini,vars,logintimer) == $null ) { remini d-tool\d-tool.ini vars logintimer | .timerlogin off } | if ($readini(d-tool\d-tool.ini,vars,logintimer)) { .timerlogin off | dtlt } }
  ....restart all ( $+ %dtrushtimer $+ ) hours (FTPRush):set %dtrushtimer $?"Hours?" | if ($dialog(dtool-main)) did -a dtool-main 35 %dtrushtimer | if ( %dtrushtimer == $null ) { unset %dtrushtimer | .timerrush off } | if ( %dtrushtimer ) { .timerrush off | .timerrush 0 $calc(%dtrushtimer * 3600) dtkill } 
  ....clear queue all ( $+ %dtrushqtimer $+ ) hours (FTPRush):set %dtrushqtimer $?"Hours?" | if ($dialog(dtool-main)) did -a dtool-main 40 %dtrushqtimer | if ( %dtrushqtimer == $null ) { unset %dtrushqtimer | .timerqueue off } | if ( %dtrushqtimer ) { .timerqueue off | dtqt }
  ..reqfiller
  ...$iif($readini(d-tool\d-tool.ini,vars,reqloc) == 1,$style(1)) &check location:if ( $readini(d-tool\d-tool.ini,vars,reqloc) != 1 ) writeini d-tool\d-tool.ini vars reqloc 1 | else remini d-tool\d-tool.ini vars reqloc
  ...$iif($readini(d-tool\d-tool.ini,vars,reqwin) == 1 && $readini(d-tool\d-tool.ini,vars,reqwinreq) == 1,$style(1)) &show requesting:if ( $readini(d-tool\d-tool.ini,vars,reqwin) != 1 ) writeini d-tool\d-tool.ini vars reqwin 1 | if ( $readini(d-tool\d-tool.ini,vars,reqwinreq) == 1 ) writeini d-tool\d-tool.ini vars reqwinreq 0 | elseif ( $readini(d-tool\d-tool.ini,vars,reqwinreq) == 0 ) writeini d-tool\d-tool.ini vars reqwinreq 1 | else writeini d-tool\d-tool.ini vars reqwinreq 1
  ...$iif( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1,$style(1)) &use cbftp for reqfills:{ if ( $readini(d-tool\d-tool.ini,vars,cbftpreqs) == 1 ) writeini d-tool/d-tool.ini vars cbftpreqs 0 | else writeini d-tool/d-tool.ini vars cbftpreqs 1 }
  ...use ( $+ $readini(d-tool\d-tool.ini,vars,reqfillslots) $+ ) slots for filling (FTPRush): writeini d-tool\d-tool.ini vars reqfillslots $input(add number of slots,e,Reqfillslots,$readini(d-tool\d-tool.ini,vars,reqfillslots))
  ..TVMaze
  ...$iif($readini(d-tool\d-tool.ini,vars,ragerecheck) == 1,$style(1)) &recheck
  ....$iif($readini(d-tool\d-tool.ini,vars,ragerecheck) == 1 , disable, enable) : { if ($readini(d-tool\d-tool.ini,vars,ragerecheck) == 1 ) remini d-tool\d-tool.ini vars ragerecheck | else writeini d-tool\d-tool.ini vars ragerecheck 1 }
  ....time( $+ $readini(d-tool\d-tool.ini,vars,ragerechecktime) $+ ):writeini d-tool\d-tool.ini vars ragerechecktime $input(how many seconds?,e,TVMaze Recheck,$readini(d-tool\d-tool.ini,vars,ragerechecktime))
  ...max.db.size( $+ $readini(d-tool\d-tool.ini,vars,maxdbsize) $+ kb/ $+ $calc($readini(d-tool\d-tool.ini,vars,maxdbsize) * 16) $+ db-entrys ):writeini d-tool\d-tool.ini vars maxdbsize $input(Maximum KB-Size for the TV Databank? 100KB are about 1600 entrys,e,Max db Size,$readini(d-tool\d-tool.ini,vars,maxdbsize))
  ..IMDb
  ...set API-Key: writeini d-tool\d-tool.ini vars omdbapikey $input(Input OMDb API Key (http://www.omdbapi.com/apikey.aspx - free),e,OMDbAPI,$readini(d-tool\d-tool.ini,vars,omdbapikey))
  ..nukes
  ...filters
  ....$iif($readini(d-tool\d-tool.ini,vars,nonukeinc) == 1,$style(1)) &incomplete: if ( $readini(d-tool\d-tool.ini,vars,nonukeinc) == 1 ) writeini d-tool\d-tool.ini vars nonukeinc 0 | else writeini d-tool\d-tool.ini vars nonukeinc 1
  ....$iif($readini(d-tool\d-tool.ini,vars,norepack) == 1,$style(1)) &repack: if ( $readini(d-tool\d-tool.ini,vars,norepack) == 1 ) writeini d-tool\d-tool.ini vars norepack 0 | else writeini d-tool\d-tool.ini vars norepack 1
  ....$iif($readini(d-tool\d-tool.ini,vars,noproper) == 1,$style(1)) &proper: if ( $readini(d-tool\d-tool.ini,vars,noproper) == 1 ) writeini d-tool\d-tool.ini vars noproper 0 | else writeini d-tool\d-tool.ini vars noproper 1
  ....$iif($readini(d-tool\d-tool.ini,vars,scene) == 1,$style(1)) &scenenuke(1x): if ( $readini(d-tool\d-tool.ini,vars,scene) == 1 ) writeini d-tool\d-tool.ini vars scene 0 | else writeini d-tool\d-tool.ini vars scene 1
  ....own filters
  .....ENTRYS $+ $chr(58) $readini(d-tool\d-tool.ini,vars,nukefilters) : var %j = $input(simply add words like entry entry entry.. multiple words must be separated with a + like entry+entry...,e,nukefilters,$readini(d-tool\d-tool.ini,vars,nukefilters)) | if (%j) writeini d-tool\d-tool.ini vars nukefilters %j | else writeini d-tool\d-tool.ini vars -No_Entry-
  ...set badnuke( $+ %dtbadnuke $+ GB):set %dtbadnuke $?"*BAD NUKE* for nukes with size of more GB than?" 
  ..sport
  ...show triggers in active window:showsport
  ...edit triggers:editsport
  ...add trigger(s):addsport $?"what to add? single words or regex possible, case-sensitive"
  ...del trigger(s):delsport $?"what to delete? single words or a set of following tags like saved are possible"
  ..incfiller
  ...$iif($readini(d-tool\d-tool.ini,vars,incloc) == 1,$style(1)) &check location:if ( $readini(d-tool\d-tool.ini,vars,incloc) != 1 ) writeini d-tool\d-tool.ini vars incloc 1 | else remini d-tool\d-tool.ini vars incloc
  ...$iif($readini(d-tool\d-tool.ini,vars,incwin) == 1 && $readini(d-tool\d-tool.ini,vars,incwininc) == 1,$style(1)) &show announces:if ( $readini(d-tool\d-tool.ini,vars,incwin) != 1 ) writeini d-tool\d-tool.ini vars incwin 1 | if ( $readini(d-tool\d-tool.ini,vars,incwininc) == 1 ) writeini d-tool\d-tool.ini vars incwininc 0 | elseif ( $readini(d-tool\d-tool.ini,vars,incwininc) == 0 ) writeini d-tool\d-tool.ini vars incwininc 1 | else writeini d-tool\d-tool.ini vars incwininc 1
  ...$iif($readini(d-tool\d-tool.ini,vars,inctimes) == 1,$style(1)) &times( $+ $readini(d-tool\d-tool.ini,vars,inctimes) $+ ): writeini d-tool\d-tool.ini vars inctimes $input(Enter times like 20;40;60 - first try after 20s; 2nd after 40s; 3rd after 60s,e,Incfiller Times (e.g. 15,30),$readini(d-tool\d-tool.ini,vars,inctimes))
  ..custom complete flags
  ...Flags $+ $chr(58) $readini(d-tool\d-tool.ini,vars,compflags): writeini d-tool\d-tool.ini vars compflags $input(Enter seperated with a comma,e,Custom Complete Flags,$readini(d-tool\d-tool.ini,vars,compflags))
  ..max group length
  ... $readini(d-tool\d-tool.ini,vars,maxgrplen) digits: writeini d-tool\d-tool.ini vars maxgrplen $input(Enter amount of digits,e,Maximal Groupname Length,$readini(d-tool\d-tool.ini,vars,maxgrplen))
  .commands
  ..logincheck
  ...check All:dtlogin
  ...$submenu($serverlist3($1))
  ..list
  .../dt (Setup):dt
  .../dtoff (d-tool off):dtoff
  .../dton (d-tool on):dton
  .../at (Autotrader on/off):at
  ...-
  .../dtlogin <site> (FTP Logincheck,nosite=alle):dtlogin $?"Site?"
  .../dtlt (Start/Stop Logintimer):dtlt
  .../dtss (Show Sport Trigger):dtss
  .../dtes (Edit Sport Trigger):dtes
  .../dtas <trigger(s)> (Add Sport Trigger):addsport $?"what to add? single words or regex possible, case-sensitive"
  .../dtds <trigger(s)> (Del Sport Trigger):delsport $?"what to delete? single words or a set of following tags like saved are possible"
  .../dtlangs (Update Languages):dtlangs
  .../dtrace (Manual Racefunction):dtrace
  .../dtfxp (Manual FXP-Function with cbftp):dtfxp
  ...-
  .../dtinfo (Info):dtinfo
  .../dinv <nick> <site1> <site2>.. (Siteinvite):dinv $?"nick?" $?"sites? (site1 site2 site3)"
  .../dinvite (Invite on all sites):dinvite
  .../dtsec <site> (List Sections):dtsec $?"Site?"
  .../dtusage <Number> (Show Usage of Sectionnumber):dtusage $?"Which Sectionnumber?"
  .../dtaffils (List Affils):dtaffils
  .../dtpres (List Saved Preentrys):dtpres 
  .../dtpresets (Show presets):dtpresets
  .../dtlog <chan> (Filter done-Window - part of name is enough):dtlog $?"Filter what?" 
  ...-
  .../dcb <site/all> <command> (Rawcmd cbftp):dcb $?"site? or all?" $?"Command?"
  .../dcbs <site/all> <item> (Search cbftp):dcbs $?"site? or all?" $?"Search for?"
  .../dcbsync <site> <s|t/a> <site1/grp1> <site2/grp2> .. (Sync cbftp targets|sources/affils):dcbsync $?"Site to edit?" $?"sources(s) or targets(t) or affils(a)" $?"Affils? Enter with spaces like affil affil ... or leave empty and added -Affils in Sitesettings are used"
  .../dcbsync <site> <S> (Sync sections with cbftp):dcbsync $?"Site to edit?" S
  .../dcbsite <site> (Siteinfo cbftp):dcbsite $?"site?"
  .../dcbjobs (Active Races cbftp):dcbjobs
  .../dcbinfo (cbftp build/stats/etc):dcbinfo
  ...-
  .../dse <site> <item> <item> <!notthatitem> (Sitesearch FTPRush):dse $?="site?" $?="Search for?"     
  .../dsa <item> <item> <!notthatitem> (Sitesearch All FTPRush):dsa $?"Search for?"    
  .../dtc <site> <command> (Rawcmd FTPRush):dtc $?"site?" $?"Command?"
  .../dtca <command> (Rawcmd all FTPRush):dtca $?"Command?"
  .../dtrinfo (FTPRush-Info):dtrinfo
  .../dtrp (FTPRush Stats Private):dtrp
  .../dtrc (FTPRush Stats Channel):dtrc
  ...-
  .../dtlc (Linecheck):dtlc
  .../dtedit (Open d-tool.ini):dtedit
  .../dtdir (Open d-tool Directory):dtdir
  .../dtrf (Reqfill Clipboard Text):dtrf
  ...-
  .../dimdb <> (IMDb Request):dimdb
  .../dmaze <> (TVMaze Request):drage
  .../dmazedb <> (TVMaze-DB Request):dmazedb $?"Which Series?"
  .../ruleentrys (Show Saved Rulechecks):ruleentrys  
  ...-
  .../triggers (Show Triggers):triggers
  .../addtrigger <wort> (Add Trigger):addtrigger $?"Word?" 
  .../edittriggers (Edit Triggers):edittriggers
  .../deltrigger <wort>/all (Delete Trigger):deltrigger $?"Word?"
  ...-
  .../dtbnc (BNClauncher):dtbnc
  .trigger
  ..show trigger:triggers
  ..add trigger:addtrigger $?"word?" 
  ..edit trigger:edittriggers
  ..del trigger:deltrigger $?"word? (or type 'all')"
  ..-
  ..write to file
  ...$iif( %dttout == 1,$style(1)) enable:{ if ( %dttout == 1 ) unset %dttout | else set %dttout 1 }
  ...file ( $+ %dttoutp $+ ):{ if (!%dttoutp) set %dttoutp $sfile($mircdir)="File?" | else set %dttoutp $sfile(%dttoutp)="File?" } 
  ..-
  ..$iif($window(@d-tool_trigger),$style(2)) &open trigger window:dttriggermsg
  ..close window:window -c @d-tool_trigger
  ..clear file:dtftl
  ..open file: run %dttoutp
  ..close window + clear file: { dtftl | window -c @d-tool_trigger }
  .windows
  ..$iif(%dtmainstart == 1,$style(1)) &setup on startup:if (%dtmainstart == 1) set %dtmainstart 0 | else set %dtmainstart 1
  ..$iif($readini(d-tool\d-tool.ini,vars,newinatwin) == 1,$style(1)) &show new in at-window:if ( $readini(d-tool\d-tool.ini,vars,newinatwin) == 1 ) writeini d-tool\d-tool.ini vars newinatwin 0 | else writeini d-tool\d-tool.ini vars newinatwin 1
  ..$iif($readini(d-tool\d-tool.ini,vars,skipinatwin) == 1,$style(1)) &show skip in at-window:if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) writeini d-tool\d-tool.ini vars skipinatwin 0 | else writeini d-tool\d-tool.ini vars skipinatwin 1
  ..$iif($readini(d-tool\d-tool.ini,vars,doneuturnat) == 1,$style(1)) &show done in at-window:if ( $readini(d-tool\d-tool.ini,vars,doneuturnat) == 1 ) writeini d-tool\d-tool.ini vars doneuturnat 0 | else writeini d-tool\d-tool.ini vars doneuturnat 1
  ..$iif($readini(d-tool\d-tool.ini,vars,newspam) == 1,$style(1)) &show mp3/0day in new-window:if ( $readini(d-tool\d-tool.ini,vars,newspam) != 1 ) writeini d-tool\d-tool.ini vars newspam 1 | else remini d-tool\d-tool.ini vars newspam
  ..$iif($readini(d-tool\d-tool.ini,vars,atwinspam) == 1,$style(1)) &show mp3/0day in at-window:if ( $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) writeini d-tool\d-tool.ini vars atwinspam 1 | else remini d-tool\d-tool.ini vars atwinspam
  ..$iif($readini(d-tool\d-tool.ini,vars,skipspam) != 1,$style(1)) &show mp3/0day in skip-window:if ( $readini(d-tool\d-tool.ini,vars,skipspam) != 1 ) writeini d-tool\d-tool.ini vars skipspam 1 | else remini d-tool\d-tool.ini vars skipspam
  ..$iif($readini(d-tool\d-tool.ini,vars,donespam) == 1,$style(1)) &show mp3/0day in done-window:if ( $readini(d-tool\d-tool.ini,vars,donespam) != 1 ) writeini d-tool\d-tool.ini vars donespam 1 | else remini d-tool\d-tool.ini vars donespam
  ..$iif($readini(d-tool\d-tool.ini,vars,doneuturn) == 1,$style(1)) &show done in d-tool-window: if ($readini(d-tool\d-tool.ini,vars,doneuturn) == 1) writeini d-tool\d-tool.ini vars doneuturn 0 | else writeini d-tool\d-tool.ini vars doneuturn 1
  ..$iif($window(@d-tool_trigger),$style(2)) &open trigger window:dttriggermsg
  ..$iif($readini(d-tool\d-tool.ini,vars,desktop) == -md,$style(1)) &dialogs on desktop:dialogondesk
  ..close all dialogs:dialogclose
  ..reset dialogpositions: { set %dtmainbarX 200 | set %dtmainbarY 200 | set %dtsectionX 200 | set %dtsectionY 200 | set %dtmainbar1X 200 | set %dtmainbar1Y 200 | set %dtmainbar2X 200 | set %dtmainbar2Y 200 | set %dtrulesX 200 | set  %dtrulesY 200 | set %dtredirX 200 | set  %dtredirY 200 }
  ..close+reset all dialogpositions: { dialogclose | set %dtmainbarX 200 | set %dtmainbarY 200 | set %dtsectionX 200 | set %dtsectionY 200 | set %dtmainbar1X 200 | set %dtmainbar1Y 200 | set %dtmainbar2X 200 | set %dtmainbar2Y 200 | set %dtrulesX 200 | set  %dtrulesY 200 | set %dtredirX 200 | set  %dtredirY 200 }
  .remote
  ..info:rinfo
  ..d-tool on:notice $me !dton $decode($readini(d-tool\d-tool.ini,vars,rmpw))
  ..d-tool off:notice $me !dtoff $decode($readini(d-tool\d-tool.ini,vars,rmpw))
  ..logintimer:notice $me !login $decode($readini(d-tool\d-tool.ini,vars,rmpw))
  ..sync:notice $me !sync $decode($readini(d-tool\d-tool.ini,vars,rmpw)) $?"Sync which Site?" $?"s or t? (sources/targets)?" $?"Sites"
  ..affils:notice $me !affils $decode($readini(d-tool\d-tool.ini,vars,rmpw))
  ..cpu:notice $me !cpu
  ..rushstats:notice $me !rushstats $decode($readini(d-tool\d-tool.ini,vars,rmpw))
  ..rushinfo:notice $me !rushinfo $decode($readini(d-tool\d-tool.ini,vars,rmpw)) 
  ..password
  ...edit:writeini d-tool\d-tool.ini vars rmpw $encode($input(password?,p,Set Remote Command Password,$decode($readini(d-tool\d-tool.ini,vars,rmpw))))
  ..alternative nicks $+ $chr(58) $readini(d-tool\d-tool.ini,vars,rmaltnicks)
  ...edit:{ var %tempnicks = $input(Add Nicks seperated with a comma like nick $+ $chr(44) $+ nick...,e,Alternative Rmote Nicks,$readini(d-tool\d-tool.ini,vars,rmaltnicks)) | if (%tempnicks) writeini -n d-tool\d-tool.ini vars rmaltnicks %tempnicks | else remini d-tool\d-tool.ini vars rmaltnicks }
  .network stuff
  ..$iif($dialog(bnc),$style(2)) &bnc launcher (/dtbnc):dtbnc
  ..$iif($dialog(identifier),$style(2)) &network identifier:dialog -m identifier identifier
  ..$iif($readini(d-tool\d-tool.ini,vars,invblc) == 1,$style(1)) &invite blocker
  ...$iif($readini(d-tool\d-tool.ini,vars,invblc) == 1 , disable, enable) : { if ($readini(d-tool\d-tool.ini,vars,invblc) == 1 ) remini d-tool\d-tool.ini vars invblc | else writeini d-tool\d-tool.ini vars invblc 1 }
  .script
  ..loading
  ...reload: { reload -rs d-tool\d-tool.mrc | reload -rs d-tool\d-tool.dialogs.mrc }
  ...reload (init+maintain): { set %inittemp 1 | load -rs d-tool\d-tool.mrc | load -rs d-tool\d-tool.dialogs.mrc }
  ...unload: { if ( $input(Want to keep Variables?,y,Unloading) == $true ) set %dtunloadall 0 | .unload -rs d-tool\d-tool.mrc }
  ...load ini-backup: { .copy -o d-tool\d-tool.bak d-tool\d-tool.ini | window -a @d-tool | aline -p @d-tool  ini-Backup loaded }
  ..version( $+ $replace($remove($read(d-tool\d-tool.mrc,2),;,$chr(32)),olv,ol v) $+ )
  ...received on $remove($read(d-tool\d-tool.mrc,$lines(d-tool\d-tool.mrc)),;) :var %dummie = 1
  ...post in channel:describe $chan is using $remove($read(d-tool\d-tool.mrc,2),;) from $remove($read(d-tool\d-tool.mrc,$lines(d-tool\d-tool.mrc)),;) with mIRC $version
  ..uptime mIRC $uptime(mirc,2) / System $uptime(system,2):say d-tool/mIRC Uptime: $uptime(mirc,2) - System Uptime: $uptime(system,2)
  .-
  .$iif( $readini(d-tool\d-tool.ini,vars,status) == on , disable, enable): { if ( $readini(d-tool\d-tool.ini,vars,status) == on ) { writeini -n d-tool\d-tool.ini vars status off | if ($dialog(dtool-main)) did -u dtool-main 3 | if ($dialog(dtool-small)) did -u dtool-small 3 } | else { writeini -n d-tool\d-tool.ini vars status on | if ($dialog(dtool-main)) did -c dtool-main 3 | if ($dialog(dtool-small)) did -c dtool-small 3 } } 
  . set at $iif( %dttrade == 1 , off, on)  : {  if ( %dttrade == 1 ) { unset %dttrade | if ($dialog(dtool-main)) did -u dtool-main 4 | if ($dialog(dtool-small)) did -u dtool-small 4 } | else { set %dttrade 1 | if ($dialog(dtool-main)) did -c dtool-main 4 | if ($dialog(dtool-small)) did -c dtool-small 4 } }
}
menu @d-tool {
  -
  info:dtinfo
  $iif($readini(d-tool\d-tool.ini,vars,doneuturn) == 1,$style(1)) &show done: if ($readini(d-tool\d-tool.ini,vars,doneuturn) == 1) writeini d-tool\d-tool.ini vars doneuturn 0 | else writeini d-tool\d-tool.ini vars doneuturn 1
  -
  window
  .$iif( d !isin $readini(d-tool\d-tool.ini,vars,seriesborder),$style(1)) &border:if ( d isin $readini(d-tool\d-tool.ini,vars,seriesborder) ) { writeini d-tool\d-tool.ini vars seriesborder $remove($readini(d-tool\d-tool.ini,vars,seriesborder),d,s) } | else { writeini d-tool\d-tool.ini vars seriesborder $readini(d-tool\d-tool.ini,vars,seriesborder) $+ d } | window -c @d-tool | dtoolwin 
  .$iif( s isin $readini(d-tool\d-tool.ini,vars,seriesborder),$style(1)) $iif( d !isin $readini(d-tool\d-tool.ini,vars,seriesborder),$style(2)) sizeable:if ( s isin $readini(d-tool\d-tool.ini,vars,seriesborder) ) { writeini d-tool\d-tool.ini vars seriesborder $remove($readini(d-tool\d-tool.ini,vars,seriesborder),s) } | else { writeini d-tool\d-tool.ini vars seriesborder $readini(d-tool\d-tool.ini,vars,seriesborder) $+ s } | window -c @d-tool | dtoolwin 
  .$iif($readini(d-tool\d-tool.ini,vars,dtoolwin) == d,$style(1)) &ondesktop:if ( $readini(d-tool\d-tool.ini,vars,dtoolwin) == d ) writeini d-tool\d-tool.ini vars dtoolwin x | else writeini d-tool\d-tool.ini vars dtoolwin d | window -c @d-tool | dtoolwin 
  .opacity
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 25,$style(1)) &10%:writeini d-tool\d-tool.ini vars seriesopc 25 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 50,$style(1)) &20%:writeini d-tool\d-tool.ini vars seriesopc 50 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 76,$style(1)) &30%:writeini d-tool\d-tool.ini vars seriesopc 76 |  setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 101,$style(1)) &40%:writeini d-tool\d-tool.ini vars seriesopc 101 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 127,$style(1)) &50%:writeini d-tool\d-tool.ini vars seriesopc 127 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 152,$style(1)) &60%:writeini d-tool\d-tool.ini vars seriesopc 152 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 178,$style(1)) &70%:writeini d-tool\d-tool.ini vars seriesopc 178 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 204,$style(1)) &80%:writeini d-tool\d-tool.ini vars seriesopc 204 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 229,$style(1)) &90%:writeini d-tool\d-tool.ini vars seriesopc 229 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  ..$iif($readini(d-tool\d-tool.ini,vars,seriesopc) == 255,$style(1)) &100%:writeini d-tool\d-tool.ini vars seriesopc 255 | setlayer $readini(d-tool\d-tool.ini,vars,seriesopc) $active
  .fontsize
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars searchfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars searchfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars searchfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars searchfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars searchfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars searchfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars searchfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 24,$style(1)) &24:writeini d-tool\d-tool.ini vars searchfsize 24 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  ..$iif($readini(d-tool\d-tool.ini,vars,searchfsize) == 46,$style(1)) &46:writeini d-tool\d-tool.ini vars searchfsize 46 | font $active $readini(d-tool\d-tool.ini,vars,searchfsize)
  minimize:window -n @d-tool
  close:window -c @d-tool
} 
menu nicklist {
  d-tool
  .set sitebot:{ if ($dialog(dtool-sites)) { writeini d-tool/inis/ $+ %dtsetsite $+ .ini %dtsetsite bot $$1 | did -r dtool-sites 17 | did -a dtool-sites 17 $$1 } | else { set %dtsetbot $$1 | dialog -m dtsetbot dtsetbot } }
  .set prebot
  ..1: { writeini d-tool\d-tool.ini vars prebot1 $$1 | if ($dialog(dprebot)) { did -r dprebot 1 | did -a dprebot 1 $$1 } }
  ..2: { writeini d-tool\d-tool.ini vars prebot2 $$1 | if ($dialog(dprebot)) { did -r dprebot 1 | did -a dprebot 1 $$1 } }
  ..3: { writeini d-tool\d-tool.ini vars prebot3 $$1 | if ($dialog(dprebot)) { did -r dprebot 1 | did -a dprebot 1 $$1 } }
}
menu @d-tool_new {
  -
  $iif($readini(d-tool\d-tool.ini,vars,newinatwin) == 1,$style(1)) &send new to at_window:if ( $readini(d-tool\d-tool.ini,vars,newinatwin) == 1 ) writeini d-tool\d-tool.ini vars newinatwin 0 | else writeini d-tool\d-tool.ini vars newinatwin 1
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars newfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars newfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars newfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars newfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars newfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars newfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,newfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars newfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,newfsize)
}
menu @d-tool_at {
  -
  show affils in extra window:affilfilter
  $iif($readini(d-tool\d-tool.ini,vars,atwinspam) == 1,$style(1)) &show music/0day:if ( $readini(d-tool\d-tool.ini,vars,atwinspam) != 1 ) writeini d-tool\d-tool.ini vars atwinspam 1 | else remini d-tool\d-tool.ini vars atwinspam
  $iif($readini(d-tool\d-tool.ini,vars,newinatwin) == 1,$style(1)) &show new:if ( $readini(d-tool\d-tool.ini,vars,newinatwin) == 1 ) writeini d-tool\d-tool.ini vars newinatwin 0 | else writeini d-tool\d-tool.ini vars newinatwin 1
  $iif($readini(d-tool\d-tool.ini,vars,skipinatwin) == 1,$style(1)) &show skip:if ( $readini(d-tool\d-tool.ini,vars,skipinatwin) == 1 ) writeini d-tool\d-tool.ini vars skipinatwin 0 | else writeini d-tool\d-tool.ini vars skipinatwin 1
  $iif($readini(d-tool\d-tool.ini,vars,doneuturnat) == 1,$style(1)) &show done:if ( $readini(d-tool\d-tool.ini,vars,doneuturnat) == 1 ) writeini d-tool\d-tool.ini vars doneuturnat 0 | else writeini d-tool\d-tool.ini vars doneuturnat 1
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars atfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,atfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars atfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,atfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars atfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,atfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars atfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,atfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars atfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,atfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars atfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,atfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,atfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars atfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,atfsize) 
  clear:clear @d-tool_at
  close:window -c @d-tool_at
}
menu @d-tool_done {
  -
  filter for channame with GB-amount:dtlog $?"Filter done Window for?"
  .$iif($readini(d-tool\d-tool.ini,vars,donespam) == 1,$style(1)) &music/0day:if ( $readini(d-tool\d-tool.ini,vars,donespam) != 1 ) writeini d-tool\d-tool.ini vars donespam 1 | else remini d-tool\d-tool.ini vars donespam
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars donefsize 9 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars donefsize 10 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars donefsize 11 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars donefsize 12 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars donefsize 14 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars donefsize 16 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,donefsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars donefsize 18 | font $active $readini(d-tool\d-tool.ini,vars,donefsize)
  close:window -c @d-tool_done
}
menu @d-tool_skip {
  -
  .$iif($readini(d-tool\d-tool.ini,vars,skipspam) != 1,$style(1)) &music/0day:if ( $readini(d-tool\d-tool.ini,vars,skipspam) != 1 ) writeini d-tool\d-tool.ini vars skipspam 1 | else remini d-tool\d-tool.ini vars skipspam
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars skipfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars skipfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars skipfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars skipfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars skipfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars skipfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,skipfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars skipfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,skipfsize)
  close:window -c @d-tool_skip
}
menu @d-tool_speed {
  -
  .custom complete flags
  ..Flags $+ $chr(58) $readini(d-tool\d-tool.ini,vars,compflags): writeini d-tool\d-tool.ini vars compflags $input(Enter seperated with a comma,e,Custom Complete Flags,$readini(d-tool\d-tool.ini,vars,compflags))
  $iif($readini(d-tool\d-tool.ini,vars,speedall) == 1,$style(1)) &music/0day: if ( $readini(d-tool\d-tool.ini,vars,speedall) == 1 ) writeini d-tool\d-tool.ini vars speedall 0 | else writeini d-tool\d-tool.ini vars speedall 1
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars speedfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars speedfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars speedfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars speedfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars speedfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars speedfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,speedfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars speedfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,speedfsize)
  close:window -c @d-tool_speed
}
menu @d-tool_trigger {
  -
  show trigger:triggers
  add trigger:addtrigger $?"word?" 
  edit trigger:edittriggers
  del trigger:deltrigger $?"word? (or type 'all')"
  -
  $iif( %dttout == 1,$style(1)) write to file
  .$iif( %dttout == 1,$style(1)) enable:{ if ( %dttout == 1 ) unset %dttout | else set %dttout 1 }
  .file ( $+ %dttoutp $+ ):{ if (!%dttoutp) set %dttoutp $sfile($mircdir)="File?" | else set %dttoutp $sfile(%dttoutp)="File?" }
  open file:run %dttoutp
  clear file:dtftl
  close window + clear file: { dtftl | window -c @d-tool_trigger }
  -  
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars trigfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars trigfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars trigfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars trigfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars trigfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars trigfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,trigfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars trigfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,trigfsize)
  close:window -c @d-tool_trigger
}
menu @d-tool_sitelog {
  -
  Filter for channame with GB-Amount:dtlog $?"Filter what?"
  (or simply enter the channame (or a part of it) in the editbox):dtlog $?"Filter what?"
}
menu @d-tool_db {
  -
  search IMDb:dimdb $input(Search IMDb for what?,e,IMDb Search,$cb)
  search TVMaze:dmaze $input(Search TVMaze for what?,e,TVMaze Search,$cb)
  search TVMaze DB:dmazedb $input(Search TVMaze for what?,e,TVMaze-DB Search,$cb)
  open TVMaze DB:run d-tool\tvmaze.db
  -
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars imdbfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars imdbfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars imdbfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars imdbfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars imdbfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars imdbfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,imdbfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars imdbfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,imdbfsize) 
  editboxfunction
  .enter text in editbox and search IMDb:var %dummie = 1
  .enter text with a ! at the start and search TVMaze:var %dummie = 1 
  close:window -c @d-tool_db
}
menu @d-tool_nukes {
  -
  set badnuke( $+ %dtbadnuke $+ GB):set %dtbadnuke $?"*BAD NUKE* for nukes with size of more GB than?"
  filters
  .$iif($readini(d-tool\d-tool.ini,vars,nonukeinc) == 1,$style(1)) &incomplete: if ( $readini(d-tool\d-tool.ini,vars,nonukeinc) == 1 ) writeini d-tool\d-tool.ini vars nonukeinc 0 | else writeini d-tool\d-tool.ini vars nonukeinc 1
  .$iif($readini(d-tool\d-tool.ini,vars,norepack) == 1,$style(1)) &repack: if ( $readini(d-tool\d-tool.ini,vars,norepack) == 1 ) writeini d-tool\d-tool.ini vars norepack 0 | else writeini d-tool\d-tool.ini vars norepack 1
  .$iif($readini(d-tool\d-tool.ini,vars,noproper) == 1,$style(1)) &proper: if ( $readini(d-tool\d-tool.ini,vars,noproper) == 1 ) writeini d-tool\d-tool.ini vars noproper 0 | else writeini d-tool\d-tool.ini vars noproper 1
  .$iif($readini(d-tool\d-tool.ini,vars,scene) == 1,$style(1)) &scenenuke(1x): if ( $readini(d-tool\d-tool.ini,vars,scene) == 1 ) writeini d-tool\d-tool.ini vars scene 0 | else writeini d-tool\d-tool.ini vars scene 1
  .own filters
  ..ENTRYS $+ $chr(58) $readini(d-tool\d-tool.ini,vars,nukefilters) : var %j = $input(simply add words like entry entry entry.. 2 words must be separated with a + like entry+entry,e,nukefilters,$readini(d-tool\d-tool.ini,vars,nukefilters)) | if (%j) writeini d-tool\d-tool.ini vars nukefilters %j | else writeini d-tool\d-tool.ini vars -No_Entry-
  -
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars nukefsize 9 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars nukefsize 10 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars nukefsize 11 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars nukefsize 12 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars nukefsize 14 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars nukefsize 16 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  .$iif($readini(d-tool\d-tool.ini,vars,nukefsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars nukefsize 18 | font $active $readini(d-tool\d-tool.ini,vars,nukefsize)
  close:window -c @d-tool_nukes
}
menu @d-tool_req {
  -
  ..$iif($readini(d-tool\d-tool.ini,vars,reqloc) == 1,$style(1)) &check location:if ( $readini(d-tool\d-tool.ini,vars,reqloc) != 1 ) writeini d-tool\d-tool.ini vars reqloc 1 | else remini d-tool\d-tool.ini vars reqloc
  ..$iif($readini(d-tool\d-tool.ini,vars,reqwinreq) == 1,$style(1)) &show requesting:if ( $readini(d-tool\d-tool.ini,vars,reqwinreq) == 1 ) writeini d-tool\d-tool.ini vars reqwinreq 0 | else writeini d-tool\d-tool.ini vars reqwinreq 1
  ..use ( $+ $readini(d-tool\d-tool.ini,vars,reqfillslots) $+ ) slots for filling: writeini d-tool\d-tool.ini vars reqfillslots $input(add number of slots,e,Reqfillslots,$readini(d-tool\d-tool.ini,vars,reqfillslots))
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars reqfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars reqfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars reqfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars reqfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars reqfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars reqfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,reqfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars reqfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,reqfsize)
  close:window -c @d-tool_req
}
menu @d-tool_inc {
  -
  ..$iif($readini(d-tool\d-tool.ini,vars,inctimes) == 1,$style(1)) &times( $+ $readini(d-tool\d-tool.ini,vars,inctimes) $+ ): writeini d-tool\d-tool.ini vars inctimes $input(Enter times like 20;40;60 - first try after 20s; 2nd after 40s; 3rd after 60s,e,Incfiller Times (e.g. 15,30),$readini(d-tool\d-tool.ini,vars,inctimes))
  ..$iif($readini(d-tool\d-tool.ini,vars,incloc) == 1,$style(1)) &check location:if ( $readini(d-tool\d-tool.ini,vars,incloc) != 1 ) writeini d-tool\d-tool.ini vars incloc 1 | else remini d-tool\d-tool.ini vars incloc
  ..$iif($readini(d-tool\d-tool.ini,vars,incwininc) == 1,$style(1)) &show inc.announce:if ( $readini(d-tool\d-tool.ini,vars,incwininc) == 1 ) writeini d-tool\d-tool.ini vars incwininc 0 | else writeini d-tool\d-tool.ini vars incwininc 1
  ..open db:run d-tool\d-tool.inc.db
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars incfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars incfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars incfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars incfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars incfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars incfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,incfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars incfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,incfsize)
  close:window -c @d-tool_inc
}
menu @d-tool_section {
  fontsize
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 7,$style(1)) &7:writeini d-tool\d-tool.ini vars secfsize 7 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 8,$style(1)) &8:writeini d-tool\d-tool.ini vars secfsize 8 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 9,$style(1)) &9:writeini d-tool\d-tool.ini vars secfsize 9 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 10,$style(1)) &10:writeini d-tool\d-tool.ini vars secfsize 10 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 11,$style(1)) &11:writeini d-tool\d-tool.ini vars secfsize 11 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 12,$style(1)) &12:writeini d-tool\d-tool.ini vars secfsize 12 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 14,$style(1)) &14:writeini d-tool\d-tool.ini vars secfsize 14 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 16,$style(1)) &16:writeini d-tool\d-tool.ini vars secfsize 16 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  .$iif($readini(d-tool\d-tool.ini,vars,secfsize) == 18,$style(1)) &18:writeini d-tool\d-tool.ini vars secfsize 18 | font $active $readini(d-tool\d-tool.ini,vars,secfsize)
  close:window -c @d-tool_section
}
