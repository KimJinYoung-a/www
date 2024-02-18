<script>
function jsGoColor(cd){
	top.location.href = "/play/playColorTrend.asp?colorcode="+cd+"";
}
</script>
<ul class="colorchipV15">
<%
	If ocolor.fresultcount > 0 Then
		For i = 0 to ocolor.fresultcount - 1
		
			If i = 0 Then
				Response.Write "<li class=""all"
				If CStr(colorcode) = "" Then
					Response.Write " selected"
				End IF
				Response.Write """ onClick=""jsGoColor('');""><p><input type=""radio"" id=""all"""
				If CStr(colorcode) = "" Then
					Response.Write " checked=""checked"""
				End IF
				Response.Write "/></p><label for=""all"">ALL</label></li>" & vbCrLf
			End If
			
			Response.Write "<li class=""" & fnColorTrendColorName(ocolor.FItemList(i).FcolorCode) & ""
			If CStr(colorcode) = CStr(ocolor.FItemList(i).FcolorCode) Then
				Response.Write " selected"
			End IF
			Response.Write """ onClick=""jsGoColor('" & ocolor.FItemList(i).FcolorCode & "');""><p><input type=""radio"" id=""" & fnColorTrendColorName(ocolor.FItemList(i).FcolorCode) & """"
			If CStr(colorcode) = CStr(ocolor.FItemList(i).FcolorCode) Then
				Response.Write " checked=""checked"""
			End IF
			Response.Write "/></p><label for=""" & fnColorTrendColorName(ocolor.FItemList(i).FcolorCode) & """>" & Replace(fnColorTrendColorName(ocolor.FItemList(i).FcolorCode),Left(fnColorTrendColorName(ocolor.FItemList(i).FcolorCode),1),UCase(Left(fnColorTrendColorName(ocolor.FItemList(i).FcolorCode),1))) & "</label></li>" & vbCrLf

		Next
	End If
Set ocolor = nothing %>
</ul>