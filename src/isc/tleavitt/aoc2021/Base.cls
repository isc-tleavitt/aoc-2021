Class isc.tleavitt.aoc2021.Base
{

Parameter Folder = "/irisdev/app/data/";

ClassMethod Run() As %Integer
{
    do ..GetInputArray(.array)
}

ClassMethod Run2() As %Integer
{
    do ..GetInputArray(.array)
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

}
