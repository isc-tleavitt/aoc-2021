Class isc.tleavitt.aoc2021.Day3 Extends isc.tleavitt.aoc2021.Base
{

ClassMethod Run(ByRef array, ByRef len) As %Integer
{
    do ..GetInputArray(.array)
    set len = $length(array(1))
    for i=1:1:array {
        for j=1:1:len {
            set count(j) = +$get(count(j)) + $extract(array(i),j)
        }
    }
    set gamma = 0
    set epsilon = 0
    for i=1:1:len {
        if (count(i) > (array/2)) {
            set gamma = gamma + (2**(len-i))
        } else {
            set epsilon = epsilon + (2**(len-i))
        }
    }
    set power = gamma * epsilon
    quit power
}

ClassMethod Run2() As %Integer [ PublicList = (o2array, co2array) ]
{
    new o2array, co2array
    do ..Run(.array, .len)
    for i=1:1:array {
        set ref = ""
        for j=1:1:len {
            set ref = ref_$listbuild($extract(array(i),j))
        }
        set ref = "o2array("_$listtostring(ref)_")"
        set @ref = ""
    }

    merge co2array = o2array
    
    set o2 = 0
    set co2 = 0
    for i=1:1:len {
        set o2bit = ..MostCommonFirstBit(.o2array)
        set co2bit = '..MostCommonFirstBit(.co2array)

        // Update arrays
        kill o2array('o2bit)
        kill co2array('co2bit)
        kill tmp
        merge tmp = o2array(o2bit)
        kill o2array
        merge o2array = tmp
        kill tmp
        merge tmp = co2array(co2bit)
        kill co2array
        merge co2array = tmp

        // Update co2/o2
        set o2 = o2bit * (2**(len-i)) + o2
        set co2 = co2bit * (2**(len-i)) + co2

        // Only hit this case for co2 array
        set co2ref = $query(@"co2array"@(""))
        set co2revref = $query(@"co2array"@(""),-1)
        if (co2ref '= "") && (co2ref = co2revref) {
            for j=1:1:$qlength(co2ref) {
                set co2 = $qsubscript(co2ref,j) * (2**(len-i-j)) + co2
            }
            kill co2array
        }
    }
    quit o2 * co2
}

ClassMethod MostCommonFirstBit(ByRef array) As %Integer [ PublicList = array ]
{
    if '$data(array) {
        // simple case; here to make ObjectScript_Q happy.
        quit 1
    }
    set ref = "array"
    set total = 0
    set count = 0
    for {
        set ref = $query(@ref)
        quit:ref=""
        set total = total + 1
        set count = count + $qsubscript(ref,1)
    }
    quit total/2 <= count
}

}
