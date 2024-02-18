<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 EVENT
' History : 2015.09.22 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2016/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
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
	PageSize = 16

	set odibest = new cdiary_list
		odibest.FPageSize = PageSize
		odibest.FCurrPage = CurrPage
		odibest.FselOp	 	= selOp			'이벤트정렬
		odibest.FSCType 	= scType    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
		odibest.FEScope =2
		odibest.FEvttype = "1,13"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent
%>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2016.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('.enjoyEvent ul').masonry({
			itemSelector: ".box",
			columnWidth:1
		});
	});
		
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
	<div class="container diarystory2016">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2016/inc/head.asp" -->
			<div class="diaryContent diaryEvent">
			<form name="sFrm" method="get" action="/diarystory2016/event.asp#diary2016evtlist">
			<input type="hidden" name="cpg" value="<%= odibest.FCurrPage %>"/>
			<input type="hidden" name="scT" value="<%= scType %>"/>
				<!--<div class="evtBnr"><a href="/diarystory2016/gift.asp"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_diary_event.jpg" alt="" /></a></div>-->
				<div class="evtBnr"><a href="/event/eventmain.asp?eventid=68410"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/bnr_diary_friends.jpg" alt="" /></a></div>

				<div class="diaryEvtWrap" id="diary2016evtlist">
					<div class="evtNav">
						<h3><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_diary_event.gif" alt="Diary Event" /></h3>
						<ul>
							<li <%=CHKIIF(scType="","class='current'","")%>><a href="" onclick="jsGoUrl(''); return false;"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_event_sort01.gif" alt="전체 이벤트" /></a></li>
							<li <%=CHKIIF(scType="sale","class='current'","")%>><a href="" onclick="jsGoUrl('sale'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_event_sort02.gif" alt="할인 이벤트" /></a></li>
							<li <%=CHKIIF(scType="gift","class='current'","")%>><a href="" onclick="jsGoUrl('gift'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_event_sort03.gif" alt="사은 이벤트" /></a></li>
							<li <%=CHKIIF(scType="ips","class='current'","")%>><a href="" onclick="jsGoUrl('ips'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_event_sort04.gif" alt="참여 이벤트" /></a></li>
						</ul>
					</div>
					<div class="diaryEvtList">
						<div class="enjoyEventWrap">
							<div class="sortingV15">
								<span class="total">total <strong> <%= odibest.Ftotalcount %></strong></span>
								<div class="option">
									<select name="selOP" onchange="jsGoPage('');" title="이벤트 정렬방식을 선택하세요" class="optSelect">
										<option value="0" <%=chkIIF(selOp="0","selected","")%>>최근이벤트순</option>
										<option value="1" <%=chkIIF(selOp="1","selected","")%>>마감임박순</option>
										<option value="2" <%=chkIIF(selOp="2","selected","")%>>판매순</option>
									</select>
								</div>
							</div>
							<div class="enjoyEvent">
							<ul>
							<%
							'################# 박스 5,6,13,14 값 셋팅 ##################
							Dim c, vClass(21), vSize(21), vLen(21), vLink, vImg, vIcon, vName
							For c = 1 To 20
								If c = 5 OR c = 14 Then
									vClass(c) = "type02"
									vSize(c) = "width=""420"" height=""420"""
									vLen(c) = 246
								ElseIf c = 6 OR c = 13 Then
									vClass(c) = "type03"
									vSize(c) = "width=""200"" height=""200"""
									vLen(c) = 102
								Else
									vClass(c) = ""
									vSize(c) = "width=""200"" height=""200"""
									vLen(c) = 86
								End If
							Next

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

									If odibest.FItemList(i).Fetc_itemimg <> "" Then
										vImg = odibest.FItemList(i).Fetc_itemimg
									Else
										vImg = odibest.FItemList(i).FImageList
									End IF

									'출력크기에 따른 이미지 사이즈 변경(Photo Sever)
'									if vClass(i+1)="type02" then
'										vImg = odibest.FItemList(i).FImageList
'									else
'										vImg = odibest.FItemList(i).Fetc_itemimg
'									end if

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
								<li class="box <%=vClass(i+1)%>" onclick="<%=vLink%>">
									<p class="pic"><img src="<%=vImg%>" <%=vSize(i+1)%> alt="" /></p>
									<div class="evtProd">
										<p class="pdtStTag">
											<%=vIcon%>
										</p>
										<p class="evtTit">
										<%	'//이벤트 명 할인이나 쿠폰시
											If odibest.FItemList(i).fissale Or odibest.FItemList(i).fiscoupon Then
												if ubound(Split(vName,"|"))> 0 Then
													If odibest.FItemList(i).fissale Or (odibest.FItemList(i).fissale And odibest.FItemList(i).fiscoupon) then
														vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <span style=color:red>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
													ElseIf odibest.FItemList(i).fiscoupon Then
														vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <span style=color:green>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
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
							</div>
						</div>
						<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(CurrPage,odibest.FTotalCount,PageSize,10,"jsGoPage") %>
						</div>
					</div>
				</div>
			</form>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set odibest = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->