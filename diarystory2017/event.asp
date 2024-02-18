<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 EVENT
' History : 2016.09.26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim odibest, i, selOp , scType, CurrPage, PageSize
	selOp		=  requestCheckVar(Request("selOP"),1) '정렬
	scType 		= requestCheckVar(Request("scT"),4) '쇼핑찬스 분류
	CurrPage 	= requestCheckVar(request("cpg"),9)
	
	IF CurrPage = "" then CurrPage = 1
	If scType ="end" then
		selOp = "1"
	ElseIf selOp = "" Then
		selOp = "0"
	End if
	PageSize = 9

	set odibest = new cdiary_list
		odibest.FPageSize = PageSize
		odibest.FCurrPage = CurrPage
		odibest.FselOp	 	= selOp	'이벤트정렬
		odibest.FSCType 	= scType    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
		odibest.FEScope =2
		odibest.FEvttype = "1,13"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
<script type="text/javascript">
function jsGoUrl(scT){
	document.sFrm.scT.value = scT;
	document.sFrm.submit();
}

function jsGoPage(iP){
	document.sFrm.cpg.value = iP;
	document.sFrm.submit();
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2017">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2017/inc/head.asp" -->
			<div class="diaryContent diaryEvent">
			<form name="sFrm" method="get" action="/diarystory2017/event.asp#diary2017evtlist">
			<input type="hidden" name="cpg" value="<%= odibest.FCurrPage %>"/>
			<input type="hidden" name="scT" value="<%= scType %>"/>
				<div class="diaryGift"><a href="/diarystory2017/gift.asp"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/bnr_gift_02.jpg" alt="2017 다이어리 구매금액별 사은품" /></a></div>
				<div class="array" id="diary2017evtlist">
					<ul class="tab">
						<!-- for dev msg : 선택시 클래스 current 넣어주세요 -->
						<li <%=CHKIIF(scType="","class='current'","")%>><a href="" onclick="jsGoUrl(''); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_all_event.png" alt="전체이벤트" /></span></p></a></li>
						<li <%=CHKIIF(scType="sale","class='current'","")%>><a href="" onclick="jsGoUrl('sale'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_sale_event.png" alt="할인이벤트" /></span></p></a></li>
						<li <%=CHKIIF(scType="gift","class='current'","")%>><a href="" onclick="jsGoUrl('gift'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_gift_event.png" alt="사은이벤트" /></span></p></a></li>
						<li <%=CHKIIF(scType="ips","class='current'","")%>><a href="" onclick="jsGoUrl('ips'); return false;"><p><span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tab_join_event.png" alt="참여이벤트" /></span></p></a></li>
					</ul>
					<div class="option">
						<select name="selOP" onchange="jsGoPage('');" class="optSelect" title="이벤트 정렬 방식 선택">
							<option value="0" <%=chkIIF(selOp="0","selected","")%>>최근이벤트순</option>
							<option value="2" <%=chkIIF(selOp="2","selected","")%>>판매순</option>
							<option value="1" <%=chkIIF(selOp="1","selected","")%>>마감임박순</option>
						</select>
					</div>
				</div>
				<%' 이벤트 리스트 %>
				<div class="eventList">
					<ul>
					<%
					Dim vLink, vImg, vIcon, vName, vmbannerImg
					If odibest.FResultCount > 0 Then
						FOR i = 0 to odibest.FResultCount -1

							IF odibest.FItemList(i).FEvt_kind = "16" Then
								IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
									vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
								ELSE
									vLink = "GoToBrandShopevent_direct('" & odibest.FItemList(i).fbrand & "','" & odibest.FItemList(i).fevt_code & "');"
								END IF
								vName = split(odibest.FItemList(i).FEvt_name,"|")(0)
							Elseif odibest.FItemList(i).FEvt_kind = "13" Then
								vLink = "TnGotoProduct('" & odibest.FItemList(i).fetc_itemid & "');"
								vName = odibest.FItemList(i).FEvt_name
							Else
								IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
									vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
								ELSE
									vLink = "TnGotoEventMain('" & odibest.FItemList(i).fevt_code & "');"
								END IF
								vName = odibest.FItemList(i).FEvt_name
							End IF

'							If odibest.FItemList(i).Fetc_itemimg <> "" Then
'								vImg = odibest.FItemList(i).Fetc_itemimg
'							Else
'								vImg = odibest.FItemList(i).FImageList
'							End IF
							
							if odibest.FItemList(i).fevt_mo_listbanner <> "" then
								vmbannerImg = odibest.FItemList(i).fevt_mo_listbanner
							else
								If odibest.FItemList(i).Fetc_itemimg <> "" Then
									vmbannerImg = odibest.FItemList(i).Fetc_itemimg
								Else
									vmbannerImg = odibest.FItemList(i).FImageList
								End IF
							end if

							vIcon = ""
							If odibest.FItemList(i).fisOnlyTen Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif"" alt=""ONLY"" /> "
							End IF
							If odibest.FItemList(i).fissale Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif"" alt=""SALE"" /> "
							End IF
							If odibest.FItemList(i).fiscoupon Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif"" alt=""쿠폰"" /> "
							End IF
							If odibest.FItemList(i).fisoneplusone Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif"" alt=""1+1"" /> "
							End IF
							If odibest.FItemList(i).fisgift Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif"" alt=""GIFT"" /> "
							End IF
							If datediff("d",odibest.FItemList(i).fevt_startdate,date)<=3 Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif"" alt=""NEW"" /> "
							End IF
							If odibest.FItemList(i).fiscomment Then
								vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_involve.gif"" alt=""참여"" /> "
							End IF
					%>
							<%' for dev msg : 이벤트 9개씩 노출됩니다 %>
							<li onclick="<%=vLink%>">
								<div class="pic"><img src="<%=vmbannerImg%>" width="330" height="160" alt="<%= vName %>" /></div>
								<div class="evtProd">
									<% if vIcon <> "" then %>
										<p class="pdtStTag"><%' 태그 없을경우 pdtStTag 영역 안보이게 해주세요 %>
											<%=vIcon%>
										</p>
									<% end if %>
									<p class="evtTit">
									<%	'//이벤트 명 할인이나 쿠폰시
										If odibest.FItemList(i).fissale Or odibest.FItemList(i).fiscoupon Then
											if ubound(Split(vName,"|"))> 0 Then
												If odibest.FItemList(i).fissale Or (odibest.FItemList(i).fissale And odibest.FItemList(i).fiscoupon) then
													vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <strong class='cRd0V15'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</strong>"
												ElseIf odibest.FItemList(i).fiscoupon Then
													vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <strong class='cGr0V15'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</strong>"
												End If 			
											end If
										End If 
									%>
										<%=chrbyte(vName,80,"Y")%>
									</p>
									<p class="evtExp"><%=chrbyte( odibest.FItemList(i).FEvt_subcopyK ,70,"Y")%></p>
									<p class="evtDate">~<%=odibest.FItemList(i).fevt_enddate %></p>
								</div>
							</li>
						<%
							Next
						End If
						%>
					</ul>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(CurrPage,odibest.FTotalCount,PageSize,10,"jsGoPage") %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set odibest = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->