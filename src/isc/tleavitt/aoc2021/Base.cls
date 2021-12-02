Class isc.tleavitt.aoc2021.Base
{

Parameter Folder = "/irisdev/app/data/";

ClassMethod GetInput(filename As %String) As %Stream
{
    set fn = ..#Folder_filename
    set stream = ##Class(%Stream.FileCharacter).%New()
    $$$ThrowOnError(stream.LinkToFile(fn))
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
