Class isc.tleavitt.aoc2021.Base
{

Parameter Folder = "/irisdev/app/data/";

ClassMethod Run() As %Integer [ Abstract ]
{
    do ..GetInputArray(.array)
    quit 0
}

ClassMethod Run2() As %Integer [ Abstract ]
{
    do ..GetInputArray(.array)
    quit 0
}

ClassMethod GetInput(filename As %String) As %Stream
{
    set fn = ..#Folder_filename
    set stream = ##Class(%Stream.FileCharacter).%New()
    $$$ThrowOnError(stream.LinkToFile(fn))
    set stream.LineTerminator = $c(13,10)
    return stream
}

ClassMethod GetInputArray(ByRef array, filename As %String = {"input"_$Piece($classname(),"Day",2)_".txt"})
{
    set stream = ..GetInput(filename)
	while 'stream.AtEnd {
        set array($i(array)) = stream.ReadLine()
    }
}

ClassMethod GetInput2DArray(Output array, filename As %String = {"input"_$Piece($classname(),"Day",2)_".txt"})
{
    do ..GetInputArray(.array, filename)
    for i=1:1:array {
        for j=1:1:$length(array(i)) {
            set array(i,j) = $extract(array(i),j)
        }
        zkill array(i)
    }
}

}
