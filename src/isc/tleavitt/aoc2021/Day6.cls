Class isc.tleavitt.aoc2021.Day6 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run() As %Integer
{
    do ..GetInputArray(.array)
    set input = $ListFromString(array(1))
    set pointer = 0
    while $listnext(input,pointer,fish) { // That's kind of fun.
        set school($i(school)) = fish
    }
    for day=1:1:80 {
        for fish=1:1:school {
            set school(fish) = school(fish) - 1
            if school(fish) = -1 {
                set school(fish) = 6
                set school($i(school)) = 8
            }
        }
    }
    quit school
}

ClassMethod Run2() As %Integer
{
    do ..GetInputArray(.array)
    set input = $ListFromString(array(1))
    set pointer = 0
    while $listnext(input,pointer,fish) { // That's kind of fun.
        do $increment(schoolState(fish))
    }
    for day=1:1:256 {
        set spawn = +$get(schoolState(0))
        for schoolState=1:1:8 {
            set schoolState(schoolState-1) = +$get(schoolState(schoolState))
        }
        set schoolState(8) = spawn
        set schoolState(6) = $get(schoolState(6)) + spawn
    }
    set sum = 0
    for i=0:1:8 {
        set sum = sum + $get(schoolState(i))
    }
    quit sum
}

}
