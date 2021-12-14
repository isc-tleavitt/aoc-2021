Class isc.tleavitt.aoc2021.Day14 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run() As %Integer
{
    do ..GetPuzzle(.polymer,.rules)
    for i=1:1:10 {
        set polymer = ..DoInsertions(polymer,.rules)
    }
    set counts = ""
    for i=1:1:$length(polymer) {
        do $increment(counts($extract(polymer,i)))
    }
    do ..FindMinAndMax(.counts,.minElement,.maxElement)
    quit maxElement - minElement
}

ClassMethod Run2() As %Integer
{
    do ..GetPuzzle(.polymer,.rules)

    // Translate polymer to its pairs
    set polymerPairs = "" // Satisfy the objectscript_Q Continuum...
    for i=1:1:$length(polymer)-1 {
        do $increment(polymerPairs($extract(polymer,i,i+1)))
    }

    for i=1:1:40 {
        do ..DoInsertionsByPair(.polymerPairs,.rules)
    }

    set counts($extract(polymer)) = 1
    set key = ""
    for {
        set key = $order(polymerPairs(key),1,count)
        quit:key=""
        do $increment(counts($extract(key,2)),count)
    }

    do ..FindMinAndMax(.counts,.minElement,.maxElement)

    quit maxElement - minElement
}

ClassMethod GetPuzzle(Output template, Output rules)
{
    kill template,rules
    do ..GetInputArray(.array)
    set template = array(1)
    for i=3:1:array {
        set pair = $piece(array(i)," -> ")
        set insert = $piece(array(i)," -> ",2)
        set rules(pair) = insert

        // For use in DoInsertionsByPair
        set rules("pair",pair) = $lb($extract(pair)_insert,insert_$extract(pair,2))
    }
}

ClassMethod DoInsertions(polymer As %String, ByRef rules) As %String
{
    set result = ""
    for i=1:1:$length(polymer)-1 {
        set chars = $extract(polymer,i,i+1)
        set result = result _ $extract(chars) _ rules(chars)
    }
    set result = result _ $extract(polymer,*)
    quit result
}

ClassMethod FindMinAndMax(ByRef array, Output minElement, Output maxElement)
{
    set key = $order(array(""),1,minElement)
    set maxElement = minElement
    for {
        set key = $order(array(key),1,value)
        quit:key=""
        if (value < minElement) {
            set minElement = value
        }
        if (value > maxElement) {
            set maxElement = value
        }
    }
}

ClassMethod DoInsertionsByPair(ByRef polymerPairs, ByRef rules)
{
    set newPairs = ""
    set key = ""
    for {
        set key = $order(polymerPairs(key),1,count)
        quit:key=""
        set $listbuild(new1,new2) = rules("pair",key)
        do $increment(newPairs(new1),count)
        do $increment(newPairs(new2),count)
    }
    kill polymerPairs
    merge polymerPairs = newPairs
}

}
