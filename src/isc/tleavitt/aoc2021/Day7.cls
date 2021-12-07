Class isc.tleavitt.aoc2021.Day7 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run() As %Integer
{
    do ..GetInputArray(.array)
    set input = $ListFromString(array(1))
    set pointer = 0
    if $listnext(input,pointer,crabPosition) {
        set crabs($i(crabs)) = crabPosition
        set minPosition = crabPosition
        set maxPosition = crabPosition
    }
    while $listnext(input,pointer,crabPosition) { // That's kind of fun.
        set crabs($i(crabs)) = crabPosition
        if (crabPosition < minPosition) {
            set minPosition = crabPosition
        }
        if (crabPosition > maxPosition) {
            set maxPosition = crabPosition
        }
    }
    set minFuel = ""
    for i=minPosition:1:maxPosition {
        set sumFuel = 0
        for j=1:1:crabs {
            set sumFuel = sumFuel + $zabs(crabs(j) - i)
        }
        if (sumFuel < minFuel) || (minFuel = "") {
            set minFuel = sumFuel
        }
    }
    quit minFuel
}

ClassMethod Run2() As %Integer
{
    do ..GetInputArray(.array)
    set input = $ListFromString(array(1))
    set pointer = 0
    if $listnext(input,pointer,crabPosition) {
        set crabs($i(crabs)) = crabPosition
        set minPosition = crabPosition
        set maxPosition = crabPosition
    }
    while $listnext(input,pointer,crabPosition) { // That's kind of fun.
        set crabs($i(crabs)) = crabPosition
        if (crabPosition < minPosition) {
            set minPosition = crabPosition
        }
        if (crabPosition > maxPosition) {
            set maxPosition = crabPosition
        }
    }
    set minFuel = ""
    for i=minPosition:1:maxPosition {
        set sumFuel = 0
        for j=1:1:crabs {
            set distance = $zabs(crabs(j) - i)
            set sumFuel = sumFuel + (distance * (distance + 1)/2)
        }
        if (sumFuel < minFuel) || (minFuel = "") {
            set minFuel = sumFuel
        }
    }
    quit minFuel
}

}
