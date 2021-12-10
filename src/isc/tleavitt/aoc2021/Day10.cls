Class isc.tleavitt.aoc2021.Day10 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(verbose As %Boolean = 0) As %Integer
{
    do ..GetInputArray(.array)
    set score = 0
    for i=1:1:array {
        do ..ParseLine(array(i),.badSyntaxScore,.isCorrupted,verbose)
        if isCorrupted {
            set score = score + badSyntaxScore
        }
    }
    if (verbose) {
        write !
    }
    quit score
}

ClassMethod Run2(verbose As %Boolean = 0) As %Integer
{
    do ..GetInputArray(.array)
    set median = ""
    set count = 0
    for i=1:1:array {
        set completionScore = ..ParseLine(array(i),,,verbose)
        if (completionScore > 0) {
            set count = count + 1
            set scores(completionScore) = ""
        }
    }
    for i=1:1:count\2+1 {
        set median = $order(scores(median))
    }
    if (verbose) {
        write !
    }
    quit median
}

ClassMethod ParseLine(line As %String, Output badSyntaxScore As %Integer, Output isCorrupted As %Boolean, verbose As %Boolean = 0) As %Integer
{
    set badSyntaxScore = 0
    set isCorrupted = 0
    set pair("{") = "}"
    set pair("[") = "]"
    set pair("<") = ">"
    set pair("(") = ")"
    set stack = 0

    // Check validity
    for i=1:1:$length(line) {
        set char = $extract(line,i)
        if $data(pair(char),end)#2 {
            set stack($i(stack)) = end
        } else {
            // Correct closing char?
            set expectedEnd = $Get(stack(stack))
            set stack = stack-1
            if (char '= expectedEnd) {
                set isCorrupted = 1
                set badSyntaxScore = $case(char,")":3,"]":57,"}":1197,">":25137)
                if (verbose) {
                    write !,"Expected ",expectedEnd,", but found ",char," instead."
                }
                return 0
            }
        }
    }

    // Complete
    write:verbose !
    set score = 0
    for i=stack:-1:1 {
        write:verbose stack(i)
        set score = score*5 + $find(")]}>",stack(i)) - 1
    }
    write:verbose " - ",score," total points."
    quit score
}

}
