Class isc.tleavitt.aoc2021.Day8 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(ByRef decoded) As %Integer
{
    do ..GetInputArray(.array)
    set decoded = array
    for i=1:1:array {
        do ..DecodeLine(.array,i,.decoded)
    }
    set count = 0
    for i=1:1:decoded {
        set count = count + $length($translate(decoded(i),"023569"))
    }
    return count
}

ClassMethod Run2() As %Integer
{
    do ..Run(.decoded)
    set sum = 0
    for i=1:1:decoded {
        set sum = sum + decoded(i)
    }
    quit sum
}

ClassMethod DecodeLine(ByRef array, i As %Integer, ByRef decoded)
{
    set patterns = ..AlphabetizeListItems($listfromstring($piece(array(i),"|")," "))
    set output = ..AlphabetizeListItems($listfromstring($piece(array(i)," | ",2)," "))
    do ..GetNumberCodes(patterns,.codes)
    set pointer = 0
    set decoded(i) = ""
    while $listnext(output,pointer,item) {
        set decoded(i) = decoded(i) _ codes(item)
    }
}

ClassMethod AlphabetizeListItems(list As %List) As %List
{
    set newList = ""
    set pointer = 0
    while $listnext(list,pointer,item) {
        set newList = newList_$ListBuild(..Alphabetize(item))
    }
    quit newList
}

ClassMethod Alphabetize(string As %String) As %String
{
    kill array
    for i=1:1:$length(string) {
        set array($extract(string,i)) = ""
    }
    set string = ""
    set key = ""
    for {
        set key = $order(array(key))
        quit:key=""
        set string = string_key
    }
    quit string
}

ClassMethod GetNumberCodes(patterns As %List, ByRef codes)
{
    kill codes
    set freq = "" // To make ObjectScript_Q happy...

    set real(0) = "abcefg"
    set real(1) = "cf"
    set real(2) = "acdeg"
    set real(3) = "acdfg"
    set real(4) = "bcdf"
    set real(5) = "abdfg"
    set real(6) = "abdefg"
    set real(7) = "acf"
    set real(8) = "abcdefg"
    set real(9) = "abcdfg"

    // Get known values
    set pointer = 0
    while $listnext(patterns,pointer,pattern) {
        if $length(pattern) = 2 {
            set fake(1) = pattern
        } elseif $length(pattern) = 4 {
            set fake(4) = pattern
        } elseif $length(pattern) = 3 {
            set fake(7) = pattern
        } elseif $length(pattern) = 7 {
            set fake(8) = pattern
        }
        for i=1:1:$length(pattern) {
            do $increment(freq($extract(pattern,i)))
        }
    }

    // Simple approach based on frequency of segments:
    /*
        a appears in 8 (but not 1)
        b appears in 6
        c appears in 8
        d appears in 7
        e appears in 4
        f appears in 9
        g appears in 7 (but not 4)
    */
    set decoderString = ""
    set key = ""
    for {
        set key = $order(freq(key),1,count)
        quit:key=""
        if (count = 8) && (fake(1) [ key) {
            set $extract(decoderString,3) = key // c
        } elseif (count = 7) && (fake(4) [ key) {
            set $extract(decoderString,4) = key // d
        } else {
            set $extract(decoderString,$case(count,
                    8:1, // a
                    6:2, // b
                    4:5, // e
                    9:6, // f
                    7:7 // g
                )) = key
        }
    }
    for i=0:1:9 {
        set codes(..Alphabetize($translate(real(i),"abcdefg",decoderString))) = i
    }
}

}
