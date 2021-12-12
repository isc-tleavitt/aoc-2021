Class isc.tleavitt.aoc2021.Day11 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(nSteps As %Integer = 100, verbose As %Boolean = 0) As %Integer
{
    do ..GetInput2DArray(.array)
    set flashes = 0
    for i=1:1:nSteps {
        do ..RunStep(.array,.stepFlashes)
        set flashes = flashes + stepFlashes
        if verbose {
            write !,"After step ",i,":"
            do ..Print(.array)
        }
    }
    quit flashes
}

ClassMethod Run2() As %Integer
{
    do ..GetInput2DArray(.array)
    for i=1:1 {
        quit:..RunStep(.array)
    }
    quit i
}

ClassMethod RunStep(ByRef array, Output flashes) As %Boolean
{
    set flashes = 0

    // Increase energy by 1 for each octopus
    for i=1:1:10 {
        for j=1:1:10 {
            set array(i,j) = array(i,j) + 1
        }
    }

    // Flash and reset to 0
    for {
        set iterFlashes = 0
        for i=1:1:10 {
            for j=1:1:10 {
                if array(i,j) = 10 {
                    set iterFlashes = iterFlashes + 1
                    set array(i,j) = 0
                    // Increase adjacent energy levels - EXCEPT where equal to 0 (meaning already flashed)
                    for k=-1:1:1 {
                        for m=-1:1:1 {
                            if (k = 0) && (m = 0) {
                                continue
                            }
                            if (i + k < 1) || (j + m < 1) || (i + k > 10) || (j + m > 10) {
                                continue
                            }
                            set current = array(i+k,j+m)
                            if (current = 0) || (current = 10) {
                                continue
                            }
                            set array(i+k,j+m) = current + 1
                        }
                    }
                }
            }
        }
        quit:'iterFlashes
        set flashes = flashes + iterFlashes
    }

    // See if all flashed
    for i=1:1:10 {
        for j=1:1:10 {
            if array(i,j) { return 0 }
        }
    }
    return 1
}

ClassMethod Print(ByRef array)
{
    write !
    for i=1:1:10 {
        for j=1:1:10 {
            write array(i,j)
        }
        write !
    }
    write !
}

}
