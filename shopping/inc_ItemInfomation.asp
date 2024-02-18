<h3 class="tMar50">상품 필수 정보 <span class="fn cGy0V15 lPad05">전자상거래 등에서의 상품정보 제공 고시에 따라 작성 되었습니다.</span></h3>
<div class="pdtInforBox tMar05">
	<div class="pdtInforList">
	<%
		If addEx.FResultCount = "" Or IsNull(addEx.FResultCount) Then
			'// 고시정보가 없을 때 (기본 정보)
			Response.Write "<span><em>재료</em> : " & oItem.Prd.FItemSource & "</span>"
			Response.Write "<span><em>크기</em> : " & oItem.Prd.FItemSize & "</span>"
			if Not(oItem.Prd.FitemWeight = "" or isNull(oItem.Prd.FitemWeight) or oItem.Prd.FitemWeight=0) then
				Response.Write "<span><em>중량</em> : " & oItem.Prd.FItemSize & "</span>"
			end if
			Response.Write "<span><em>제조사/원산지</em> : " & str2html(oItem.Prd.FMakerName) & " / " & str2html(oItem.Prd.FSourceArea) & "</span>"
		Else
			'상품정보제공 공시
			IF addEx.FResultCount > 0 THEN
				FOR i= 0 to addEx.FResultCount-1
					If addEx.FItem(i).FinfoCode = "35005" Then '기타일경우 재질 , 사이즈 추가
						If oItem.Prd.FItemSource <> "" then
						Response.Write "<span><em>재질</em> : "& str2html(oItem.Prd.FItemSource) &"</span>"
						End If
						If oItem.Prd.FItemSize <> "" then
						Response.Write "<span><em>사이즈</em> : "& (oItem.Prd.FItemSize) &"</span>"
						End If
					End If
			%>
				<span style="display:<%=chkiif(addEx.FItem(i).FInfoContent="" And addEx.FItem(i).FinfoCode ="02004" ,"none","")%>;"><em><%=str2html(chkiif(addEx.FItem(i).FInfoContent="" And addEx.FItem(i).FinfoCode ="02004" ,"",addEx.FItem(i).FInfoname))%></em> : <%=str2html(chkiif(addEx.FItem(i).FInfoContent="" And addEx.FItem(i).FinfoCode ="02004" ,"",addEx.FItem(i).FInfoContent))%></span>
			<%
				Next
			End If

			if oItem.Prd.IsSafetyYN then '안전인증대상 일때만 추가
				Response.Write "<span><em>안전인증대상</em> : " & str2html(oItem.Prd.IsSafetyDIV) & "&nbsp;" & str2html(oItem.Prd.FsafetyNum) & "</span>"
			End If
		End If
	%>
	</div>
	<%
		'해외배송 일때만 추가
		if oItem.Prd.IsAboardBeasong then
			Response.Write "<div class=""pdtInforList abroadMsg"">"
			Response.Write "	<span><em>해외배송 기준 중량</em> : " & formatNumber(oItem.Prd.FitemWeight,0) & "g(1차 포장을 포함한 중량)</span>"
			Response.Write "</div>"
		End If
	%>
</div>

<% If Safety.FResultCount > 0  Then %>
<% If Safety.FItem(0).FSafetyYN <> "N" Then %>
<h3 class="tMar50">제품 안전 인증 정보 <span class="fn fs11 cGy0V15 lPad05">본 내용은 판매자가 직접 등록한 것으로 해당 정보에 대한 책임은 판매자에게 있습니다.</span></h3>
<% If Safety.FItem(0).FSafetyYN="Y" Then %>
<% For i= 0 To Safety.FResultCount-1 %>
<% If Safety.FItem(i).FcertDiv <> "" And Not IsNull(Safety.FItem(i).FcertDiv) Then %>
<div class="pdtInforBox tMar05 safety-mark">
	<span class="ico"></span>
	<p><strong><%=fnSafetyDivCodeName(Safety.FItem(i).FsafetyDiv)%> : </strong><a href="http://www.safetykorea.kr/release/certDetail?certNum=<%=Safety.FItem(i).FcertNum%>&certUid=<%=Safety.FItem(i).FcertUid%>" target="_blank"><%=Safety.FItem(i).FcertNum%></a></p>
	<p>구매 전에 안전 인증 정보를 꼭 확인하세요.</p>
</div>
<% Else %> 
<div class="pdtInforBox tMar05 safety-mark">
	<span class="ico"></span>
	<p><strong>전기용품 – 공급자 적합성 확인 : </strong>공급자 적합성 확인 대상 품목으로 인증번호 없음</p>
	<p>구매 전에 안전 인증 정보를 꼭 확인하세요.</p>
</div>
<% End If %>
<% Next %>
<% Else %> 
<div class="pdtInforBox tMar05">
	<div class="pdtInforList">
		<span>해당 상품 인증 정보는 판매자가 등록한 상품 상세 설명을 참조하시기 바랍니다.</span>
	</div>
</div>
<% End If %>
<% End If %>
<% End If %>