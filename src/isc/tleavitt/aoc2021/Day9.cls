Class isc.tleavitt.aoc2021.Day9 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(ByRef array, ByRef lowPoints) As %Integer
{
    do ..GetInputArray(.array)
    set sum = 0
    set yMax = array
    set xMax = $length(array(1))
    for i=1:1:yMax {
        for j=1:1:xMax {
            set point = $extract(array(i),j)
            set isMinimum = 1
            for y=-1,1 {
                set yAdj = i + y
                set xAdj = j
                if (yAdj > 0) && (yAdj <= yMax) && (point >= $extract(array(yAdj),xAdj)) {
                    set isMinimum = 0
                    quit
                }
            }
            continue:'isMinimum
            for x=-1,1 {
                set yAdj = i
                set xAdj = j + x
                if (xAdj > 0) && (xAdj <= xMax) && (point >= $extract(array(yAdj),xAdj)) {
                    set isMinimum = 0
                    quit
                }
            }
            continue:'isMinimum
            set sum = sum + 1 + point

            // Map both ways (index -> point, point -> index)
            set lowPoints(0,$i(lowPoints)) = $lb(i,j)
            set lowPoints(1,$lb(i,j)) = lowPoints
        }
    }
    quit sum
}

ClassMethod Run2() As %Integer
{
    do ..Run(.array,.lowPoints)
    set yMax = array
    set xMax = $length(array(1))
    for y=1:1:yMax {
        for x=1:1:xMax {
            do ..GetBasin(x, y, .array, .lowPoints, .knownBasins)
        }
    }

    // At this point, we have:
    // lowPoints(2,index) = count
    set max(1) = 0
    set max(2) = 0
    set max(3) = 0

    for i=1:1:lowPoints {
        set size = lowPoints(2,i)
        if (size > max(3)) {
            set max(3) = size
            if (max(3) > max(2)) {
                set max(3) = max(2)
                set max(2) = size
                if (max(2) > max(1)) {
                    set max(2) = max(1)
                    set max(1) = size
                }
            }
        }
    }
    quit max(1) * max(2) * max(3)
}

ClassMethod GetBasin(x As %Integer, y As %Integer, ByRef array, ByRef lowPoints, ByRef knownBasins) As %Integer
{
    if $data(knownBasins(x,y),basin)#2 {
        quit basin
    }
    if $data(lowPoints(1,$listbuild(y,x)),index)#2 {
        set basin = index
    } else {
        set yMax = array
        set xMax = $length(array(1))
        set xLower = x
        set yLower = y
        set point = $extract(array(y),x)
        if (point = 9) {
            quit 0 // Not part of any basin
        }
        set found = 0
        for dy=-1,1 {
            set yAdj = y + dy
            set xAdj = x
            if (yAdj > 0) && (yAdj <= yMax) && (point > $extract(array(yAdj),xAdj)) {
                set yLower = yAdj
                set found = 1
            }
        }
        if ('found) {
            for dx=-1,1 {
                set yAdj = y
                set xAdj = x + dx
                if (xAdj > 0) && (xAdj <= xMax) && (point > $extract(array(yAdj),xAdj)) {
                    set xLower = xAdj
                }
            }
        }
        set basin = ..GetBasin(xLower,yLower,.array,.lowPoints,.knownBasins)
    }
    set knownBasins(x,y) = basin
    if (basin '= 0) {
        do $increment(lowPoints(2,basin))
    }
    quit basin
}

}
