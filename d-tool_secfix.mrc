alias secfix {
  var %d = 1 | while ( %d <= $readini(d-tool\d-tool.ini,sites,count) ) { 
    var %s = $readini(d-tool\d-tool.ini,sites,%d) | var %sini = %s $+ .ini
    var %i = 1 | while ( %i <= $readini(d-tool\sections.ini,name,count) ) {
      if ($readini(d-tool\inis\ $+ %sini,%s,date $+ %i)) { writeini d-tool\inis\ $+ %sini sections date $+ %i $readini(d-tool\inis\ $+ %sini,%s,date $+ %i) | remini d-tool\inis\ $+ %sini %s date $+ %i | echo @d-tool secfix fixed date from section %i on %s }
      if ($readini(d-tool\inis\ $+ %sini,%s,y $+ %i)) { writeini d-tool\inis\ $+ %sini sections y $+ %i $readini(d-tool\inis\ $+ %sini,%s,y $+ %i) | remini d-tool\inis\ $+ %sini %s y $+ %i | echo @d-tool secfix fixed year from section %i on %s }
      ;fix df!     
      if ($readini(d-tool\inis\ $+ %sini,%s,df $+ %i)) { writeini d-tool\inis\ $+ %sini sections df $+ %i $readini(d-tool\inis\ $+ %sini,n,%s,df $+ %i) | remini d-tool\inis\ $+ %sini %s df $+ %i | echo @d-tool secfix fixed df from section %i on %s }
      inc %i
    }
    inc %d 
  }
  echo @d-tool secfix done - deleting and unloading script. thanks for your time and have a nice day :)
  remove -b $scriptdir/d-tool_secfix.mrc | unload -rs d-tool_secfix.mrc
}