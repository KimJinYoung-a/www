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
'  		     2019-11-21 쿠폰관련 스크립트, 스타일 category_prd.asp에 있음
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

poscode = 715

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
	Dim img , link , altname, categoryOptions, categoryArr, isTargetCategory, i, idx, bannerType, couponidx, cbText, layerId
	dim maincopy, subcopy, btnFlag, buttonCopy, buttonUrl, couponInfo, couponVal, couponMin	 
	
	For intI = 0 To ubound(arrlist,2)

		categoryOptions = arrlist(6,intI)
		catecode = arrlist(7,intI)
		idx = arrlist(8,intI)		
		isTargetCategory = false

		if categoryOptions <> "" Then
			categoryArr = split(categoryOptions, ",")
			for i=0 to ubound(categoryArr) - 1
				if categoryArr(i) = catecode Then
					isTargetCategory = true
					exit for
				end if
			next
		else
			isTargetCategory = true
		end if
		
		If isTargetCategory Then
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

			'다이어리 프로모션 쿠폰 띠배너 특정 아이템만 노출
			If intI = 0 AND date() > "2019-11-12" AND date() < "2019-12-11" AND (vitemid = 2488134 OR vitemid = 2110036 OR vitemid = 2510594 OR vitemid = 2209032 OR vitemid = 2542576 OR vitemid = 2512750 OR vitemid = 2523735) Then
				Select Case vitemid
					case 2488134 '미미
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_02.jpg"					
					case 2110036 '유아
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_03.jpg"
					case 2510594 '효정
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_01.jpg"
					case 2209032 '지호
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_05.jpg"
					case 2542576 '비니
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_06.jpg"
					case 2512750 '승희
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_04.jpg"
					case 2523735 '아린
						img = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/bnr_evt_07.jpg"
				end select
				altname = "오마이걸의 픽 이벤트 참여하러 가기"
%>
		<div class="bnr" style="margin-top:10px">
			<a href="javascript:eventClicKBanner('http://www.10x10.co.kr/event/eventmain.asp?eventid=98339', 'click_event_move_bnr', '98339', 'vitemid');"><img src="<%=img%>" alt="<%=altname%>"></a>
		</div>
<%
			Else
%>
		<div class="bnr" style="margin-top:10px">
			<a href="javascript:handleClicKBanner('<%=link%>', '<%=bannerType%>', '<%=couponidx%>', '<%=layerId%>', 'click_marketing_top_bnr');"><img src="<%=img%>" alt="<%=altname%>"></a>
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
		End if
	Next
%>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->