<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : PC_item_prd // cache DB경유
' History : 2018-01-17 이종화 생성
' 			2018-08-30 최종원 회원등급별 배너 노출
'  		     2019-11-21 최종원 쿠폰발급기능 추가 - 스크립트, 스타일 category_prd.asp에 있음
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList
Dim CtrlDate : CtrlDate = now()
Dim limitcnt : limitcnt = 0 '//최대 배너 갯수
DIM userLevel
userLevel = cstr(session("ssnuserlevel"))

'카테고리정보
dim vitemid	: vitemid = requestCheckVar(request("itemid"),9)
dim catecode 

poscode = 707

'//itemid 값 검사
if vitemid="" or vitemid="0" then
	Call Alert_Return("상품번호가 없습니다.")
	response.End
elseif Not(isNumeric(vitemid)) then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
else	'정수형태로 변환
	vitemid=CLng(getNumeric(vitemid))
end if

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "WPIMG_"&Cint(timer/60)
Else
	cTime = 60*5
	cTime = 1*1
	dummyName = "WPIMG"
End If

IF poscode = "" THEN
	Call Alert_Return("잘못된 접근입니다.")
	response.End
END IF

Dim topcnt : topcnt = 1

sqlStr = " EXEC [db_sitemaster].[dbo].[usp_ten_banners_get] '" & topcnt & "', '"& poscode &"', '"& vitemid &"', '" & userLevel & "', '', '' "

'Response.write sqlStr &"<br/>"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
If IsArray(arrList) Then
	If (request.Cookies("catePrdLowBanner") <> "done" or request.Cookies("catePrdLowBanner")="") Then
		Dim img , link , altname, categoryOptions, categoryArr, isTargetCategory, i, idx, bannerType, couponidx, cbText, layerId
		dim maincopy, subcopy, btnFlag, buttonCopy, buttonUrl, couponInfo, couponVal, couponMin	 

		For intI = 0 To ubound(arrlist,2)

			categoryOptions = arrlist(6,intI)		
			idx = arrlist(8,intI)

			If CDate(CtrlDate) >= CDate(arrlist(2,intI)) AND CDate(CtrlDate) <= CDate(arrlist(3,intI))  Then			
			img				= staticImgUrl & "/main/" + db2Html(arrlist(0,intI))
			link			= db2Html(arrlist(1,intI))
			altname			= db2Html(arrlist(4,intI))		
			bannerType		= arrlist(10,intI) '1: 링크배너 / 2: 쿠폰배너
			couponidx		= arrlist(12,intI)
			maincopy 		= arrlist(13,intI) '메인 카피
			subcopy 		= arrlist(14,intI) '서브 카피
			btnFlag 		= arrlist(15,intI) '버튼 유무
			buttonCopy 		= arrlist(16,intI) '버튼 카피
			buttonUrl 		= arrlist(17,intI) '버튼 렌딩
			layerId			= "lyrCoupon" & idx			
			'0 : white
			'1 : red
			'2 : vip
			'3 : vip gold
			'4 : vvip			
%>
			<script>
				// 하단 기획전 배너 (20180319)
				function bnrAni() {
					if(!$(".bnr-evtV19").hasClass("evt-toast")){
						$(".bnr-evtV19").addClass("evt-toast");
						setTimeout(function(){$(".bnr-evtV19").removeClass("evt-toast");}, 6200);
					}
				}
				$(function() {
					bnrAni();
				});
				$(window).scroll(function(){
					var nowSt = $(this).scrollTop();
					if (nowSt == 0) {
						bnrAni();
					}
				});
				function setPopupCookie( name, value, expiredays ) {
					var todayDate = new Date();
					todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
					if (todayDate > new Date() ) {
						expiredays = expiredays - 1;
					}
					todayDate.setDate( todayDate.getDate() + expiredays );
					document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
				}
				function bannerCloseToSevenDay(){	//오늘 하루 보지 않기
					setPopupCookie("catePrdLowBanner", "done", 1)
					$(".bnr-evtV19").hide();
				}
			</script>
			<div class="bnr-evtV19">
				<a href="javascript:handleClicKBanner('<%=link%>', '<%=bannerType%>', '<%=couponidx%>', '<%=layerId%>', 'click_marketing_bnr');"><img src="<%=img%>" alt="<%=altname%>"></a>
				<button class="btn-close" onclick="bannerCloseToSevenDay();">오늘 하루 보지 않기</button>
			</div>
			<div id="<%=layerId%>" class="popup-lyr">
				<div class="lyr-coupon window">
					<h2><%=maincopy%></h2>
					<button type="button" class="btn-close1" onclick="ClosePopLayer();">닫기</button>
					<%
						if bannerType = "2" then						
						couponInfo = getCouponInfo(couponidx)
							if IsArray(couponInfo) then
								for i=0 to ubound(couponInfo,2)
									couponVal = formatNumber(couponInfo(1, i), 0)
									couponMin = formatNumber(couponInfo(3, i), 0)
								next
					%>
					<div class="cpn">
						<p class="amt"><b><%=couponVal%></b>원</p>
						<% if couponMin <> "0" and couponMin <> "" then%><p class="txt1"><b><%=couponMin%></b>원 이상 구매 시 사용 가능</p><% end if %>
					</div>
					<%
							end if
						end if
					%>
					<p class="txt2"><%=subcopy%></p>
					<div class="btn-area">			
						<button type="button" class="btn-close2" onclick="ClosePopLayer();">닫기</button>
						<% if btnFlag = "1" then %><button type="button" onclick="handleClickBtn('<%=buttonUrl%>');" class="btn-down"><%=buttonCopy%></button><% end if %>
					</div>				
				</div>
			</div>						
<%
			End if
		Next
	End If
%>
<%
End If 
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->