<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 EVENT
' History : 2019.08.22 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
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
	PageSize = 10

	set odibest = new cdiary_list
		odibest.FPageSize = PageSize
		odibest.FCurrPage = CurrPage
		odibest.FselOp	 	= selOp	'이벤트정렬
		odibest.FSCType 	= scType    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
		odibest.FEScope     = 2
		odibest.FEvttype    = "1,13"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent

	function ampliname(v)
		select case (v)
			case "sale" 
				ampliname = "sale"
			case "gift" 
				ampliname = "gift"
			case "ips" 
				ampliname = "participation"
			case else
				ampliname = "all"
		end select 
	end function
%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
function jsGoUrl(scT){
	document.sFrm.cpg.value = 1;
	document.sFrm.scT.value = scT;
	document.sFrm.submit();
}

function jsGoPage(iP){
	fnAmplitudeEventMultiPropertiesAction('click_diary_events_menu','gubun|page_num','<%=ampliname(scType)%>|'+ iP +'');
	document.sFrm.cpg.value = iP;
	document.sFrm.submit();
}

$(function(){
	// amplitude
	fnAmplitudeEventAction("view_diaryevent","","");
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2020">
		<div id="contentWrap" class="diary-sub">
			<!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<div class="diary-content">
				<div class="sub-header">
					<div class="inner">
						<h3>오늘은 어떤 득템찬스가 있을까?</h3>
						<ul class="tab-menu">
							<li <%=CHKIIF(scType="","class='on'","")%>><a href="#all-evt" onclick="jsGoUrl('');fnAmplitudeEventAction('click_diary_events_menu','gubun','all'); return false;">전체 이벤트</a></li>
							<li <%=CHKIIF(scType="sale","class='on'","")%>><a href="#sale-evt" onclick="jsGoUrl('sale');fnAmplitudeEventAction('click_diary_events_menu','gubun','sale'); return false;">할인 이벤트</a></li>
							<li <%=CHKIIF(scType="gift","class='on'","")%>><a href="#gift-evt" onclick="jsGoUrl('gift');fnAmplitudeEventAction('click_diary_events_menu','gubun','gift'); return false;">사은 이벤트</a></li>
							<li <%=CHKIIF(scType="ips","class='on'","")%>><a href="#partici-evt" onclick="jsGoUrl('ips');fnAmplitudeEventAction('click_diary_events_menu','gubun','participation'); return false;">참여 이벤트</a></li>
						</ul>
					</div>
				</div>
				<div class="exhibition-wrap">
					<% If odibest.FResultCount > 0 Then %>
					<div class="item-list exhibition" id="diary2020evtlist">
						<ul>
						<%
							Dim vLink, vImg, vIcon, vName, vmbannerImg , vEventid , vSale , vCoupon
							
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

									IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
										vEventid = odibest.FItemList(i).feventitemid
									ELSE
										vEventid = odibest.FItemList(i).fevt_code
									END IF
									
									' if odibest.FItemList(i).fevt_mo_listbanner <> "" then
									' 	vmbannerImg = odibest.FItemList(i).fevt_mo_listbanner
									' else
										If odibest.FItemList(i).Fetc_itemimg <> "" Then
											vmbannerImg = odibest.FItemList(i).Fetc_itemimg
										Else
											vmbannerImg = odibest.FItemList(i).FImageList
										End IF
									' end if
							%>
							<%
								If odibest.FItemList(i).fissale Or odibest.FItemList(i).fiscoupon Then
									if ubound(Split(vName,"|"))> 0 Then
										If odibest.FItemList(i).fissale Or (odibest.FItemList(i).fissale And odibest.FItemList(i).fiscoupon) then
											vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0))
											vSale   = cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))
										ElseIf odibest.FItemList(i).fiscoupon Then
											vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0))
											vCoupon = cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))
										End If 			
									end If
								End If
							%>
							<li class="exh-item">
								<a href="" onclick="<%=vLink%>fnAmplitudeEventMultiPropertiesAction('click_diary_events','gubun|eventid','<%=ampliname(scType)%>|<%=vEventid%>');return false;">
									<div class="thumbnail">
										<img src="<%=vmbannerImg%>" alt="<%= vName %>">
									</div>
									<div class="desc">
										<ul>
											<li class="badge-area">
												<% if vSale <> "" then %><em class="badge-sale discount"><%=vSale%></em><% end if %>
												<% if vCoupon <> "" then %><em class="badge-coupon discount"><%=vCoupon%></em><% end if %>
												<% If odibest.FItemList(i).fisgift Then %><em class="badge-gift">GIFT</em><% end if %>
											</li>
											<li class="tit"><%=chrbyte(vName,80,"Y")%></li>
											<li class="subcopy"><%=chrbyte( odibest.FItemList(i).FEvt_subcopyK ,70,"Y")%></li>
										</ul>
									</div>
								</a>
							</li>
							<%
								Next									
							%>
						</ul>
					</div>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(CurrPage,odibest.FTotalCount,PageSize,10,"jsGoPage") %>
					</div>
					<% end if %>
				</div>
				<%'!-- 관련기획전 --%>
				<!-- #include virtual="/diarystory2020/inc/inc_etcevent.asp" -->
				<%'!--// 관련기획전 --%>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="sFrm" method="get" action="/diarystory2020/exhibition.asp#diary2020evtlist">
<input type="hidden" name="cpg" value="<%= odibest.FCurrPage %>"/>
<input type="hidden" name="scT" value="<%= scType %>"/>
</form>
</body>
</html>
<% set odibest = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->