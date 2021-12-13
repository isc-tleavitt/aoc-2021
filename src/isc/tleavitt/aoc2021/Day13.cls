Class isc.tleavitt.aoc2021.Day13 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run() As %Integer
{
    do ..GetPuzzle(.map,.folds)
    do ..Print(.map)
    do ..Fold(folds(1),.map,.newMap)
    do ..Print(.newMap,.count)
    quit count
}

ClassMethod Run2() As %Integer
{
    do ..GetPuzzle(.map,.folds)
    for i=1:1:folds {
        do ..Fold(folds(i),.map,.newMap)
        kill map
        merge map = newMap
    }
    do ..Print(.map)
    quit 0
}

ClassMethod GetPuzzle(Output map, Output folds)
{
    kill map,folds
    do ..GetInputArray(.array)
    set haveAllCoords = 0
    for i=1:1:array {
        if (array(i) = "") {
            set haveAllCoords = 1
            continue
        }
        if haveAllCoords {
            set dimension = $extract($piece(array(i),"="),*)
            set value = $piece(array(i),"=",2)
            set folds($i(folds)) = $lb(dimension,value)
        } else {
            set x = $piece(array(i),",")
            set y = $piece(array(i),",",2)
            set map(x,y) = "#"
        }
    }
}

ClassMethod Fold(fold, ByRef map, Output newMap)
{
    kill newMap
    set $lb(dimension,value) = fold
    set xMax = $order(map(""),-1)
    set yMax = ..GetYMax(.map)
    for y=0:1:yMax {
        for x=0:1:xMax {
            set exists = $data(map(x,y))
            if exists {
                if (dimension = "x") {
                    if x < value {
                        set newMap(x,y) = "#"
                    } else {
                        set newMap(2*value-x,y) = "#"
                    }
                } else {
                    if y < value {
                        set newMap(x,y) = "#"
                    } else {
                        set newMap(x,2*value-y) = "#"
                    }
                }
            }
        }
    }
}

ClassMethod Print(ByRef map, Output count)
{
    set count = 0
    set xMax = $order(map(""),-1)
    set yMax = ..GetYMax(.map)
    write !
    for y=0:1:yMax {
        for x=0:1:xMax {
            write $case($data(map(x,y)),1:"#",:".")
            set count = count + $data(map(x,y))
        }
        write !
    }
}

ClassMethod GetYMax(ByRef map)
{
    set yMax = 0
    set x = ""
    for {
        set x = $order(map(x))
        quit:x=""
        set y = $order(map(x,""),-1)
        if (y > yMax) {
            set yMax = y
        }
    }
    quit yMax
}

}
