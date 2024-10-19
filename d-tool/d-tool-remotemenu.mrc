;; remote Script for d-tool autotrader ;;
;; load this script into mirc on the passive side if you have no d-tool loaded - only to get the commands in context-menu ;;
menu status,menubar,channel,query {
  d-tool remote
  .info:notice %dtremotenick !info $decode(%dtrmpw)
  .d-tool on:notice %dtremotenick !dton $decode(%dtrmpw)
  .d-tool off:notice %dtremotenick !dtoff $decode(%dtrmpw)
  .logintimer on/off:notice %dtremotenick !login $decode(%dtrmpw)
  .sync:notice %dtremotenick !sync $decode(%dtrmpw) $?"Sync which Site?" $?"s or t? (sources/targets)?" $?"Sites"
  .affils:notice %dtremotenick !affils $decode(%dtrmpw)
  .cpu:notice %dtremotenick !cpu
  .rushstats:notice %dtremotenick !rushstats $decode(%dtrmpw)
  .rushinfo:notice %dtremotenick !rushinfo $decode(%dtrmpw)
  .remote nick $+ $chr(58) %dtremotenick
  ..edit: set %dtremotenick $input(Add Nick,e,Remote Nick,%dtremotenick)
  .password
  ..edit:set %dtrmpw $encode($input(password?,p,Set Remote Command Password,$decode(%dtrmpw)))
}
