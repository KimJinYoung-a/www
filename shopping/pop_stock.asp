<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 상품상세 - 품절상품입고알림
' History : 2018-01-03 원승현
'####################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 입고 알림 신청"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%

	Dim stockItemId
	Dim oItem, ItemContent, oItemOption, oItemOptionMultiple, IsMultipleOption, i, optionSoldOutFlag, myUserInfo, oItemOptionMultipleType, j, strSql
	Dim multiOptionValue, alarmType

	stockItemId = requestCheckVar(request("itemid"),9)
	
	'// 상품정보를 가져온다.
	set oItem = new CatePrdCls
	oItem.GetItemData stockItemId

	'// 옵션정보를 가져온다.
    set oItemOption = new CItemOption
    oItemOption.FRectItemID = stockItemId
    oItemOption.FRectIsUsing = "Y"
    oItemOption.GetOptionList

	'// 사용자정보를 가져온다.
	set myUserInfo = new CUserInfo
	myUserInfo.FRectUserID = getEncLoginUserID
	if (getEncLoginUserID<>"") then
		myUserInfo.GetUserData
	end If

	alarmType = "LMS"

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
	$(function(){
		$('.scrollbarwrap').tinyscrollbar();
		$(".scrollbarwrap li input").click(function(){
			$(this).closest("li").toggleClass("on");
			if ($(this).closest("li").hasClass('on')) {
				$("#optselectconutStock").text(parseInt($("#optselectconutStock").text())+1);
			} else {
				$("#optselectconutStock").text(parseInt($("#optselectconutStock").text())-1);
			}
		});
		//팝업 리사이즈 (+20,60)
		resizeTo(700,700);
	});

	function goStockSubmit()
	{
		<% if (trim(oItem.Prd.FSellYn) = "Y") then '// 상품판매가 Y일 경우에만 옵션에 대한 선택권을 준다.%>
			<% If oItemOption.FResultCount>0 Then '// 옵션이 있으면 %>
				var tmpSelOptCode="";
				$(".scrollbarwrap li input").each(function(){
					if ($(this).closest("li").hasClass('on'))
					{
						if (tmpSelOptCode=="")
						{
							tmpSelOptCode = $(this).attr("value");
						}
						else
						{
							tmpSelOptCode = tmpSelOptCode +','+$(this).attr("value");
						}
					}
				});

				$("#selectOptCode").val(tmpSelOptCode);

				if (tmpSelOptCode=="")
				{
					alert("옵션을 선택한 뒤 입고 알림 신청을 해주세요.");
					return false;
				}
			<% end if %>
		<% end if %>

		if ($("#pushPeriod")=="")
		{
			alert("알림기간을 선택해주세요.");
			return false;
		}
		$("#pushPeriod").val($(":input:radio[name=alarmTime]:checked").val());

		var frmdata = $("#frmStock").serialize();

		$.ajax({
				type : "POST",
				url : "act_pop_stock.asp",
				cache : false,
				data : frmdata,
				success : function(Data){
					var res;
					res = Data.split("||");
					if (res[0]=="OK")
					{
						okMsg = res[1].replace(">?n", "\n");
						alert(okMsg);
						window.close();
						return false;
					}
					else
					{
						errorMsg = res[1].replace(">?n", "\n");
						alert(errorMsg);
						return false;
					}
				}
		});
	}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2017/shopping/tit_stock.png" alt="입고 알림 신청" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection stock-inform">
					<div class="items">
						<table>
							<colgroup>
								<col style="width:120px;" /> <col style="width:*;" />
							</colgroup>
							<tr>
							<th><img src="<%=oItem.Prd.FImageList%>" alt="" class="vTop" width="86px" height="86px" /></th>
							<td>
								<span class="brand"><%=oItem.Prd.FBrandName%></span>
								<p class="name"><%=oItem.Prd.FItemName%></p>
							</td>
							</tr>
						</table>
					</div>
					<div class="select-form">
						<table>
						<colgroup>
							<col style="width:140px;" /> <col style="width:*;" />
						</colgroup>
						<% If (trim(oItem.Prd.FSellYn) = "Y") Then '// 상품판매가 Y일 경우에만 옵션에 대한 선택권을 준다.%>
							<% If oItemOption.FResultCount>0 Then '// 옵션이 있으면 %>
								<%
									set oItemOptionMultiple = new CItemOption
									oItemOptionMultiple.FRectItemID = stockItemId
									oItemOptionMultiple.GetOptionMultipleList

									IsMultipleOption = (oItemOptionMultiple.FResultCount>0)
								%>
								<%' 단일옵션일경우 %>
								<% IF (Not IsMultipleOption) Then %>
									<tr>
										<th>옵션 선택(<em class="cRd0V15" id="optselectconutStock">0</em>건)</th>
										<td>
											<div class="scrollbarwrap">
												<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
												<div class="viewport">
													<div class="overview">
														<ul>
															<% 
																for i=0 to oItemOption.FResultCount-1 
															%>
																	<%' 품절만 표시 %>
																	<% If ((oitem.Prd.IsSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) Then %>
																		<li><label><input type="checkbox" name="optCode" value="<%=oItemOption.FItemList(i).FitemOption%>"/><%=oItemOption.FItemList(i).FOptionName%></label></li>
																	<% End If %>
															<% Next %>
														</ul>
													</div>
												</div>
											</div>
										</td>
									</tr>
								<% Else %>
									<%
										set oItemOptionMultipleType = new CItemOption
										oItemOptionMultipleType.FRectItemId = stockItemId
										oItemOptionMultipleType.GetOptionMultipleTypeList

										strSql = " Select top 1 "
										strSql = strSql & "	itemid, "
										strSql = strSql & "		stuff( "
										strSql = strSql & "				( "
										strSql = strSql & "					Select ','''+substring(itemoption, 1, "&oItemOptionMultipleType.FResultCount&")+'''' "
										strSql = strSql & "					From db_item.[dbo].[tbl_item_option] "
										strSql = strSql & "					Where itemid = o.itemid And optsellyn='Y' "
										strSql = strSql & "					group by itemid, substring(itemoption, 1, "&oItemOptionMultipleType.FResultCount&")  "
										strSql = strSql & "					FOR XML PATH('') "
										strSql = strSql & "				),1,1,'' "
										strSql = strSql & "			 ) as availableOpt  "
										strSql = strSql & "	From db_item.[dbo].[tbl_item_option] o Where itemid='"&stockItemId&"' And optsellyn='Y' "
										strSql = strSql & "	group by itemid "
										rsget.Open strSql, dbget, 1
										if Not rsget.Eof Then
											multiOptionValue = rsget("availableOpt")
										End If
										rsget.close
									%>
									<tr>
										<th>옵션 선택(<em class="cRd0V15" id="optselectconutStock">0</em>건)</th>
										<td>
											<div class="scrollbarwrap">
												<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
												<div class="viewport">
													<div class="overview">
														<ul>
															<% 
																strSql = " Select * From db_item.dbo.tbl_item_option Where itemid='"&stockItemId&"' And substring(itemoption, 1, "&oItemOptionMultipleType.FResultCount&") in ("&multiOptionValue&") And "
																strSql = strSql & "		case when optlimityn='N' then  "
																strSql = strSql & "			case when optsellyn='N' then 0 "
																strSql = strSql & "			else 1 end "
																strSql = strSql & "		else "
																strSql = strSql & "			Case when optsellyn='N' then 0 "
																strSql = strSql & "			else (optlimitno-optlimitsold) end "
																strSql = strSql & " 	end < 1 "
																rsget.Open strSql, dbget, 1
																if Not rsget.Eof Then
																	Do Until rsget.eof
															%>
																		<li><label><input type="checkbox" name="optCode" value="<%=rsget("itemoption")%>"/><%=rsget("optionname")%></label></li>
															<%
																	rsget.movenext
																	Loop
																End If
																rsget.close
															%>
														</ul>
													</div>
												</div>
											</div>
										</td>
									</tr>
								<% End If %>
								<%
									Set oItemOptionMultiple = Nothing
									Set oItemOptionMultipleType = Nothing
								%>
							<% End If %>
						<% End If %>
						<tr>
							<th>문자 알림 번호</th>
							<td><%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) %>-****-<%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",2) %></td>
						</tr>
						<tr>
							<th>알림 기간</th>
							<td>
								<div class="form-field">
									<input type="radio" id="period1" class="radio" name="alarmTime" value="d7" checked> <label for="period1">7일</label>
									<input type="radio" id="period2" class="radio" name="alarmTime" value="m1"> <label for="period2">1개월</label>
									<input type="radio" id="period3" class="radio" name="alarmTime" value="m3"> <label for="period3">3개월</label>
								</div>
							</td>
						</tr>
						</table>
					</div>
					<div class="noti tPad20">
						<strong class="fs12 cRd0V15">해당 상품(옵션 일부 등)은 일시품절되었습니다. 상품이 재판매 되면 문자메시지로 알려드리겠습니다.</strong>
						<ul class="list tPad05">
							<li>판매가격 또는 할인 가격은 신청하신 정보와차이가 날 수 있으며, 구매 시점에 따라 상품 품절이 발생 할 수 있습니다.</li>
							<li>휴대폰 번호 수정을 원하시면, 마이텐바이텐 &gt; 개인정보 수정 메뉴에서 수정하신 뒤 신청해주세요.</li>
						</ul>
					</div>
					<div class="btnArea ct tPad20">
						<button type="button" class="btn btnS1 btnRed" onclick="goStockSubmit();return false;">신청</button>
						<button type="button" class="btn btnS1 btnGry" onclick="window.close();">취소</button>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<form method="post" name="frmStock" id="frmStock">
			<input type="hidden" name="selectOptCode" id="selectOptCode" value="">
			<input type="hidden" name="stockItemId" id="stockItemid" value="<%=stockItemid%>">
			<input type="hidden" name="alarmType" id="alarmType" value="<%=alarmType%>">
			<input type="hidden" name="pushPeriod" id="pushPeriod" value="">
		</form>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<%
	Set oItem = Nothing
	Set oItemOption = Nothing
	Set myUserInfo = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->