Class isc.tleavitt.aoc2021.Day12 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(maxSmallCaveVisits As %Integer = 1) As %Integer
{
    do ..GetInputArray(.array)
    for i=1:1:array {
        set v1 = $Piece(array(i),"-")
        set v2 = $Piece(array(i),"-",2)
        set adjacent(v1,v2) = ""
        set adjacent(v2,v1) = ""
    }
    do ..FindPaths(.adjacent,.paths,maxSmallCaveVisits)
    quit paths
}

ClassMethod FindPaths(ByRef adjacent, ByRef paths, maxSmallCaveVisits = 1, current As %String = "start", path As %List = {$listbuild("start")})
{
    set key = ""
    for {
        set key = $order(adjacent(current,key))
        quit:key=""
        set nextMaxSmallCaveVisits = maxSmallCaveVisits
        set firstPosition = $listfind(path,key)
        if (key = $zconvert(key,"L")) && firstPosition {
            if (maxSmallCaveVisits = 2) && (key '= "start") {
                set nextMaxSmallCaveVisits = 1
            } else {
                continue
            }
        }
        set nextPath = path_$listbuild(key)
        if (key = "end") {
            set paths($i(paths)) = nextPath
        } else {
            do ..FindPaths(.adjacent,.paths,nextMaxSmallCaveVisits,key,nextPath)
        }
    }
}

ClassMethod Run2() As %Integer
{
    quit ..Run(2)
}

}
