<%

function IsValidStyleCD(v)
    dim arr, i

    IsValidStyleCD = True
    if v = "" then exit function

    arr = Split(v, ",")
	For i = 0 To ubound(arr)
		if Not(isNumeric(arr(i))) then
            IsValidStyleCD = False
            exit for
        end if

        if (cint(arr(i))/10) <> CInt(cint(arr(i))/10) then
            IsValidStyleCD = False
            exit for
        end if
	Next
end function


%>
