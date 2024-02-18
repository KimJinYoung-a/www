<% If (Not IsTicketItem) Then '티켓아닌경우 - 일반상품 %>
<h3<%=chkIIF(vOrderBody="",""," class=""tMar50""")%>>상품 설명</h3>
<div class="tPad10">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<%
		
		'response.write "aa"
		Dim ItemContent 
		ItemContent = oItem.Prd.FItemContent

		'링크는 새창으로
		ItemContent = Replace(ItemContent,"<a ","<a target='_blank' ")
		ItemContent = Replace(ItemContent,"<A ","<A target='_blank' ")
		'높이태그 제거
		ItemContent = Replace(ItemContent,"height=","h=")
		ItemContent = Replace(ItemContent,"HEIGHT=","h=")
		'너비태그 제거
		ItemContent = Replace(ItemContent,"width=","w=")
		ItemContent = Replace(ItemContent,"WIDTH=","w=")

		'// 태그 중복 제거
		ItemContent = Replace(ItemContent,">>",">")
		ItemContent = Replace(ItemContent,"<<","<")

		'# 상품 설명
		IF oItem.Prd.FUsingHTML="Y" THEN
			Response.write "<tr><td>" & ItemContent & "</td></tr>"
		ELSEIF oItem.Prd.FUsingHTML="H" THEN
			Response.write "<tr><td>" & nl2br(ItemContent) & "</td></tr>"
		ELSE
			Response.write "<tr><td>" & nl2br(ReplaceBracket(ItemContent)) & "</td></tr>"
		END IF

		'설명 이미지(추가)
		IF oAdd.FResultCount > 0 THEN
			FOR i= 0 to oAdd.FResultCount-1
				IF oAdd.FADD(i).FAddImageType=1 AND oAdd.FADD(i).FIsExistAddimg THEN
					Response.Write "<tr><td align=""center"">"
					Response.Write "<img src=""" & oAdd.FADD(i).FAddimage & """ border=""0"" style=""max-width:1000px;"" />"
					Response.Write "</td></tr>"
				End IF
			NEXT
		END IF

		'설명 이미지(기본)
		if ImageExists(oItem.Prd.FImageMain) then
			Response.Write "<tr><td align=""center"">"
			Response.Write "<img src=""" & oItem.Prd.FImageMain & """ border=""0"" id=""filemain"" style=""max-width:1000px;"" />"
			Response.Write "</td></tr>"
		end if
		if ImageExists(oItem.Prd.FImageMain2) then
			Response.Write "<tr><td align=""center"">"
			Response.Write "<img src=""" & oItem.Prd.FImageMain2 & """ border=""0"" id=""filemain2"" style=""max-width:1000px;"" />"
			Response.Write "</td></tr>"
		end if
		if ImageExists(oItem.Prd.FImageMain3) then
			Response.Write "<tr><td align=""center"">"
			Response.Write "<img src=""" & oItem.Prd.FImageMain3 & """ border=""0"" id=""filemain3"" style=""max-width:1000px;"" />"
			Response.Write "</td></tr>"
		end If

		If Not(itemVideos.Prd.FvideoFullUrl="") Then
			Response.write "<tr><td height=30></td></tr>"
			Response.Write "<tr><td align=""center"">"
			Response.write "<iframe width='640' height='360' src='"&itemVideos.Prd.FvideoUrl&"' frameborder='0' allowfullscreen></iframe>"
			Response.Write "</td></tr>"
		End If
	%>
	</table>
</div>
<% else %>
<h3 class="tMar50">상세 설명</h3>
<div class="tPad10">
<%
	'# 공연 설명
	IF oItem.Prd.FUsingHTML="Y" THEN
		Response.write oItem.Prd.FItemContent
	ELSEIF oItem.Prd.FUsingHTML="H" THEN
		Response.write nl2br(oItem.Prd.FItemContent)
	ELSE
		Response.write nl2br(ReplaceBracket(oItem.Prd.FItemContent))
	END IF

	'설명 이미지(추가)
	IF oAdd.FResultCount > 0 THEN
		FOR i= 0 to oAdd.FResultCount-1
			IF oAdd.FADD(i).FAddImageType=1 THEN
				Response.Write "<img src=""" & oAdd.FADD(i).FAddimage & """ border=""0"" style=""max-width:1000px;"" />"
			End IF
		NEXT
	END IF

	'설명 이미지(기본)
	if ImageExists(oItem.Prd.FImageMain) then
		Response.Write "<img src=""" & oItem.Prd.FImageMain & """ border=""0"" id=""filemain"" style=""max-width:1000px;"" />"
	end if
	if ImageExists(oItem.Prd.FImageMain2) then
		Response.Write chkIIF(ImageExists(oItem.Prd.FImageMain),"<br />","")
		Response.Write "<img src=""" & oItem.Prd.FImageMain2 & """ border=""0"" id=""filemain2"" style=""max-width:1000px;"" />"
	end if
%>
</div>
<script>
	// (function(){
	// 	var $contents = $(".imgArea");
	// 	$contents.find("img").css("width","100%");
	// })(jQuery);
</script>
<% end if %>
