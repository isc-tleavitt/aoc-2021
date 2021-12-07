Class isc.tleavitt.aoc2021.Day5 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(careAboutDiagonals As %Boolean = 0) As %Integer
{
    do ..GetInputArray(.array)
    set map = "" // Make code quality happy. (It's wrong though, initializing with $increment is totally safe.)
    for i=1:1:array {
        set $listbuild(x1,y1) = $listfromstring($Piece(array(i)," "))
        set $listbuild(x2,y2) = $listfromstring($piece(array(i)," ",3))
        if (x1 = x2) {
            set inc = $Select(y2>=y1:1,1:-1)
            for j=y1:inc:y2 {
                do $increment(map(x1,j))
            }
        } elseif (y1 = y2) {
            set inc = $Select(x2>=x1:1,1:-1)
            for j=x1:inc:x2 {
                do $increment(map(j,y1))
            }
        } elseif (careAboutDiagonals) {
            // Diagonal! Who'd have seen it coming?
            set incX = $Select(x2>=x1:1,1:-1)
            set incY = $select(y2>=y1:1,1:-1)
            set k=y1
            for j=x1:incX:x2 {
                do $increment(map(j,k))
                set k=k+incY
            }
        }
    }
    set points = 0
    set k1 = ""
    for {
        set k1 = $order(map(k1))
        quit:k1=""
        set k2 = ""
        for {
            set k2 = $order(map(k1,k2),1,count)
            quit:k2=""
            if (count >= 2) {
                do $increment(points)
            }
        }
    }
    return points
}

ClassMethod Run2() As %Integer
{
    quit ..Run(1)
}

}
