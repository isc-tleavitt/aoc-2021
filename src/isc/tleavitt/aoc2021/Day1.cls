Class isc.tleavitt.aoc2021.Day1 Extends isc.tleavitt.aoc2021.Base
{

Parameter InputFile = "input1.txt";

ClassMethod Run(verbose = 0) As %Integer
{
    set stream = ..GetInput(..#InputFile)
    set count = 0
    set last = stream.ReadLine()
	while 'stream.AtEnd {
		set next = stream.ReadLine()
        if (next > last) {
            set count = count + 1
        }
        set last = next
    }
    return count
}

ClassMethod Run2(verbose = 0) As %Integer
{
    do ..GetInputArray(.array)
    set count = 0
    set last = array(1) + array(2) + array(3)
    for i=4:1:array {
        set next = array(i) + array(i-1) + array(i-2)
        if (next > last) {
            set count = count + 1
        }
        set last = next
    }
    return count
}

}
