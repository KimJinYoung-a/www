<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2018 EVENT
' History : 2017.10.12 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2018/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2018/lib/classes/diary_class_B.asp" -->
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
<link rel="stylesheet" type="text/css" href="/lib/css/diary2018.css" />
<script type="text/javascript">
function jsGoUrl(scT){
	document.sFrm.cpg.value = 1;
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
	<div class="container diary2018">
		<div id="contentWrap" class="diary-event">
			<!-- #include virtual="/diarystory2018/inc/head.asp" -->
			<div class="diary-content">
			<form name="sFrm" method="get" action="/diarystory2018/event.asp#diary2018evtlist">
			<input type="hidden" name="cpg" value="<%= odibest.FCurrPage %>"/>
			<input type="hidden" name="scT" value="<%= scType %>"/>
				<div class="bnr"><a href="/diarystory2018/gift.asp"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/bnr_event.jpg" alt="사은품 배너" /></a></div>
				<div class="sorting" id="diary2018evtlist">
					<ul class="tab">
						<li <%=CHKIIF(scType="","class='current'","")%>><a href="" onclick="jsGoUrl(''); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_event_1.png" alt="전체이벤트" /></a></li>
						<li <%=CHKIIF(scType="sale","class='current'","")%>><a href="" onclick="jsGoUrl('sale'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_event_2.png" alt="할인이벤트" /></a></li>
						<li <%=CHKIIF(scType="gift","class='current'","")%>><a href="" onclick="jsGoUrl('gift'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_event_3.png" alt="사은이벤트" /></a></li>
						<li <%=CHKIIF(scType="ips","class='current'","")%>><a href="" onclick="jsGoUrl('ips'); return false;"><img src="http://fiximage.10x10.co.kr/web2017/diary2018/tab_event_4.png" alt="참여이벤트" /></a></li>
					</ul>
					<select name="selOP" onchange="jsGoPage('');" class="optSelect" title="이벤트 정렬 방식 선택">
						<option value="0" <%=chkIIF(selOp="0","selected","")%>>최근이벤트순</option>
						<option value="2" <%=chkIIF(selOp="2","selected","")%>>판매순</option>
						<option value="1" <%=chkIIF(selOp="1","selected","")%>>마감임박순</option>
					</select>
				</div>
				<%' 이벤트 리스트 %>
				<div class="event-list">
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
								<div class="thumbnail"><img src="<%=vmbannerImg%>" alt="<%= vName %>" /></div>
								<% if vIcon <> "" then %>
									<p class="pdtStTag"><%' 태그 없을경우 pdtStTag 영역 안보이게 해주세요 %>
										<%=vIcon%>
									</p>
								<% end if %>
								<p class="title">
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
								<p class="txt"><%=chrbyte( odibest.FItemList(i).FEvt_subcopyK ,70,"Y")%></p>
								<p class="date">~<%=odibest.FItemList(i).fevt_enddate %></p>
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