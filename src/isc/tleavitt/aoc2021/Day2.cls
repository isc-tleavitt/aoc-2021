Class isc.tleavitt.aoc2021.Day2 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run() As %Integer
{
    do ..GetInputArray(.array)
    set horizontal = 0
    set depth = 0
    for i=1:1:array {
        set $lb(direction,distance) = $listfromstring(array(i)," ")
        if (direction = "forward") {
            set horizontal = horizontal + distance
        } else {
            set depth = depth + (distance * $case(direction,"up":-1,:1))
        }
    }
    quit horizontal * depth
}

ClassMethod Run2() As %Integer
{
    do ..GetInputArray(.array)
    set horizontal = 0
    set depth = 0
    set aim = 0
    for i=1:1:array {
        set $lb(direction,distance) = $listfromstring(array(i)," ")
        if (direction = "forward") {
            set horizontal = horizontal + distance
            set depth = depth + (aim * distance)
        } else {
            set aim = aim + (distance * $case(direction,"up":-1,:1))
        }
    }
    quit horizontal * depth
}

}
