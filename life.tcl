# life.tcl -- Conway's Game of Life in Tcl

set n 40; set m 80
set g 100

proc display {b} {
   global n m
   for {set i 0} {$i < $n} {incr i} {
      for {set j 0} {$j < $m} {incr j} {
         if {[lindex $b $i $j]} {puts -nonewline {*}} else {puts -nonewline { }}
      }
      puts {}
   }
}

proc main {} {
   global n m g

   # we want C-array like behaviour, not associative hashmaps   
   set b [lrepeat $n [lrepeat $m 0]]

   # initialization
   lset b 19 41 1
   lset b 20 40 1
   lset b 21 40 1
   lset b 22 40 1
   lset b 22 41 1
   lset b 22 42 1
   lset b 22 43 1
   lset b 19 44 1

   # end of initialization
   puts "Before:"; display $b

   set nm1 [expr {$n - 1}]
   set mm1 [expr {$m - 1}]
   for {set k 0} {$k < $g} {incr k} {
      set nextb [lrepeat $n [lrepeat $m 0]]
      for {set i 0} {$i < $n} {incr i} {
         set up   [expr {$i != 0 ? $i - 1 : $nm1}]
         set down [expr {$i != $nm1 ? $i + 1 : 0}]
         for {set j 0} {$j < $m} {incr j} {
            set left  [expr {$j != 0 ? $j - 1 : $mm1}]
            set right [expr {$j != $mm1 ? $j + 1 : 0}]
            set count [expr {     \
               [lindex $b $up $left]    + \
               [lindex $b $up $j]       + \
               [lindex $b $up $right]   + \
               [lindex $b $i $right]    + \
               [lindex $b $down $right] + \
               [lindex $b $down $j]     + \
               [lindex $b $down $left]  + \
               [lindex $b $i $left]}]
            set nextval [expr {$count == 2 && [lindex $b $i $j] == 1 || $count == 3}]
            lset nextb $i $j $nextval 
         }
      }
      set b $nextb
   }
   puts "After $g generations:"; display $b
}
main
