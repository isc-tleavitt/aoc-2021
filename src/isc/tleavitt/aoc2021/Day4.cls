Class isc.tleavitt.aoc2021.Day4 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run() As %Integer
{
    do ..LoadData(.numbers,.boards)
    set pointer = 0
    while $listnext(numbers,pointer,number) {
        for board=1:1:boards {
            do ..Mark(.boards,board,number)
            if ..BoardHasWon(.boards,board) {
                return number * ..SumUnmarked(.boards,board)
            }
        }
    }
}

ClassMethod Run2() As %Integer
{
    do ..LoadData(.numbers,.boards)
    set pointer = 0
    while $listnext(numbers,pointer,number) {
        for board=1:1:boards {
            continue:'$data(boards(board))
            do ..Mark(.boards,board,number)
            if ..BoardHasWon(.boards,board) {
                if $order(boards("")) = $order(boards(""),-1) {
                    return number * ..SumUnmarked(.boards,board)
                } 
                kill boards(board)
            }
        }
    }
}

ClassMethod LoadData(Output numbers, Output boards)
{
    do ..GetInputArray(.array)
    set numbers = $listfromstring(array(1))
    set boards = array-1/6
    for i=3:1:array {
        continue:(i-2#6=0)
        set array(i) = $zstrip($replace(array(i),"  "," "),"<W") // Max 2 digits
        set line = $listfromstring(array(i)," ")
        set board = i-3\6+1
        set row = i-2#6
        for col=1:1:5 {
            set boards(board,row,col) = $listget(line,col)
            set boards(board,"idx",$listget(line,col)) = $listbuild(row,col)
        }
    }
}

ClassMethod Mark(ByRef boards, index As %Integer, number As %Integer)
{
    if $data(boards(index,"idx",number),place) {
        set $listbuild(row,col) = place
        set boards(index,row,col,"marked") = 1
    }
}

ClassMethod BoardHasWon(ByRef boards, index As %Integer) As %Boolean
{
    // Oops, no diagonals. That makes life easier.
    /*
    set diagWin(1) = 1 // top left to bottom right
    set diagWin(2) = 1 // bottom left to top right
    */
    for i=1:1:5 {
        set colWin(i) = 1
        set rowWin(i) = 1
    }
    for i=1:1:5 {
        for j=1:1:5 {
            if '$get(boards(index,i,j,"marked")) {
                kill rowWin(i)
                kill colWin(j)
            }
        }
    }
    quit $data(colWin) || $data(rowWin)
}

ClassMethod SumUnmarked(ByRef boards, index As %Integer) As %Integer
{
    set sum = 0
    for i=1:1:5 {
        for j=1:1:5 {
            if '$get(boards(index,i,j,"marked")) {
                set sum = sum + boards(index,i,j)
            }
        }
    }
    quit sum
}

}
