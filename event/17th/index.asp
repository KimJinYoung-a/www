<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'// 쇼셜서비스로 글보내기 
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 17주년]슬기로운 텐텐생활")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/17th/")
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/88938/banMoList20181004170646.JPEG")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐 17주년]슬기로운 텐텐생활"
strPageKeyword = "[텐바이텐 17주년]슬기로운 텐텐생활"
strPageDesc = "최대 25% 쿠폰과 다양한 혜택이 당신을 기다립니다!:)"
strPageUrl = "http://www.10x10.co.kr/event/17th/"
strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/88938/banMoList20181004170646.JPEG"


dim iscouponeDown, vQuery, eventCoupons
iscouponeDown = false
IF application("Svr_Info") = "Dev" THEN
	eventCoupons = "21094,21092,21090,21085,21062"	
Else
	eventCoupons = "21621,21620,21619,21618,21617"	
End If

vQuery = "select count(1) from [db_item].[dbo].[tbl_user_item_coupon] where userid = '" & getencLoginUserid() & "'"
vQuery = vQuery + " and itemcouponidx in ("&eventCoupons&") "
vQuery = vQuery + " and usedyn = 'N' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
If rsget(0) = 5 Then
	iscouponeDown = true
End IF
rsget.close
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/17th/" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

Function fnDisplayPaging_New(strCurrentPage, intTotalRecord, intRecordPerPage, intBlockPerPage, strJsFuncName)
	'변수 선언
	Dim intCurrentPage, strCurrentPath, vPageBody
	Dim intStartBlock, intEndBlock, intTotalPage
	Dim strParamName, intLoop

	'현재 페이지 설정
	intCurrentPage = strCurrentPage		'현재 페이지 값

	'해당페이지에 표시되는 시작페이지와 마지막페이지 설정
	intStartBlock = Int((intCurrentPage - 1) / intBlockPerPage) * intBlockPerPage + 1
	intEndBlock = Int((intCurrentPage - 1) / intBlockPerPage) * intBlockPerPage + intBlockPerPage

	'총 페이지 수 설정
	intTotalPage =   int((intTotalRecord-1)/intRecordPerPage) +1
	''eastone 추가
	if (intTotalPage<1) then intTotalPage=1

	vPageBody = ""
	strJsFuncName = trim(strJsFuncName)

	vPageBody = vPageBody & "<div class=""paging"">" & vbCrLf

	'## 첫 페이지
	vPageBody = vPageBody & "	<a href=""#"" title=""첫 페이지"" class=""first arrow"" onclick=""" & strJsFuncName & "(1);return false;""><span style=""cursor:pointer;"">맨 처음 페이지로 이동</span></a>" & vbCrLf

	'## 이전 페이지
	If intStartBlock > 1 Then
		vPageBody = vPageBody & "	<a href=""#"" title=""이전 페이지"" class=""prev arrow"" onclick=""" & strJsFuncName & "(" & intStartBlock-1 & ");return false;""><span style=""cursor:pointer;""><img src=""http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_prev.png"" alt=""이전페이지로 이동""></span></a>" & vbCrLf
	Else
		vPageBody = vPageBody & "	<a href=""#"" title=""이전 페이지"" class=""prev arrow"" onclick=""return false;""><span style=""cursor:pointer;""><img src=""http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_prev.png"" alt=""이전페이지로 이동""></span></a>" & vbCrLf
	End If

	'## 현재 페이지
	If intTotalPage > 1 Then
		For intLoop = intStartBlock To intEndBlock
			If intLoop > intTotalPage Then Exit For
			If Int(intLoop) = Int(intCurrentPage) Then
				vPageBody = vPageBody & "	<a href=""#"" title=""" & intLoop & " 페이지"" class=""current"" onclick=""" & strJsFuncName & "(" & intLoop & ");return false;""><span style=""cursor:pointer;"">" & intLoop & "</span></a>" & vbCrLf
			Else
				vPageBody = vPageBody & "	<a href=""#"" title=""" & intLoop & " 페이지"" onclick=""" & strJsFuncName & "(" & intLoop & ");return false;""><span style=""cursor:pointer;"">" & intLoop & "</span></a>" & vbCrLf
			End If
		Next
	Else
		vPageBody = vPageBody & "	<a href=""#"" title=""1 페이지"" class=""current"" onclick=""" & strJsFuncName & "(1);return false;""><span style=""cursor:pointer;"">1</span></a>" & vbCrLf
	End If

	'## 다음 페이지
	If Int(intEndBlock) < Int(intTotalPage) Then	'####### 다음페이지
		vPageBody = vPageBody & "	<a href=""#"" title=""다음 페이지"" class=""next arrow"" onclick=""" & strJsFuncName & "(" & intEndBlock+1 & ");return false;""><span style=""cursor:pointer;""><img src=""http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_next.png"" alt=""다음 페이지로 이동""></span></a>" & vbCrLf
	Else
		vPageBody = vPageBody & "	<a href=""#"" title=""다음 페이지"" class=""next arrow"" onclick=""return false;""><span style=""cursor:pointer;""><img src=""http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_next.png"" alt=""다음 페이지로 이동""></span></a>" & vbCrLf
	End If

	'## 마지막 페이지
	vPageBody = vPageBody & "	<a href=""#"" title=""마지막 페이지"" class=""end arrow"" onclick=""" & strJsFuncName & "(" & intTotalPage & ");return false;""><span style=""cursor:pointer;"">맨 마지막 페이지로 이동</span></a>" & vbCrLf

	vPageBody = vPageBody & "</div>" & vbCrLf

	vPageBody = vPageBody & "<div class=""pageMove"">" & vbCrLf
	vPageBody = vPageBody & "	<input type=""number"" value=""" & intCurrentPage & """ min=""1"" max=""" & intTotalPage & """ style=""width:24px;"" />/" & intTotalPage & "페이지 <a href=""#"" onclick=""fnDirPg" & strJsFuncName & "($(this).prev().val()); return false;"" class=""btn btnS2 btnGry2""><em class=""whiteArr01 fn"">이동</em></a>" & vbCrLf
	vPageBody = vPageBody & "</div>" & vbCrLf
	vPageBody = vPageBody & "<script>" & vbCrLf
	vPageBody = vPageBody & "function fnDirPg" & strJsFuncName & "(pg) {" & vbCrLf
	vPageBody = vPageBody & "	if(pg>0 && pg<=" & intTotalPage & ") " & strJsFuncName & "(pg);" & vbCrLf
	vPageBody = vPageBody & "}" & vbCrLf
	vPageBody = vPageBody & "</script>" & vbCrLf

	fnDisplayPaging_New = vPageBody
End Function    
%>
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style>
/* common */
#contentWrap {padding:0;}
.share {position:fixed; top:200px; left:50%; z-index:30; margin-left:410px; animation:bounce2 1s 100 ease-in-out;}
.share:before {display:inline-block; position:absolute; top:103px; left:0; z-index:5; width:160px; height:53px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_share_hand.png); content:' ';}
.share ul {overflow:hidden; position:absolute; top:90px; left:0; width:110px; padding:0 25px;}
.share ul li {float:left; width:50%;}
.share a {display:inline-block; position:absolute; top:90px; left:25px; z-index:7; width:53px; height:53px; text-indent:-999em;}
.share .twitter {left:80px;}

.life-main button {background-color:transparent; outline:none;}
.life-main .inner {position:relative; width:1140px; margin: 0 auto;}
.life-main .dc {position:absolute; top:0; left:50%; margin-left:0;}
.life-main .dc-group {position:absolute; top:0; left:0;}
.life-main .dc-group span {display:inline-block; position:absolute; top:0; left:0;}
.life-main .active-img {position:absolute; z-index:10;}

.life-main .evt-list {position:relative; z-index:10; height:2812px; background:#632cb6 url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/bg_ten_life_v7.jpg) no-repeat 50% 0;}
.life-main .topic {position:relative;}
.life-main .topic p,
.life-main .topic span {position:absolute; top:0; left:50%; margin-left:0;}
.life-main .topic .anniver {top:115px; margin-left:-140px; animation:bounce1 .8s forwards;}
.life-main .topic h2 span {animation:bounce1 .8s .3s forwards; opacity:0;}
.life-main .topic .t1 {top:155px; margin-left:-228px; }
.life-main .topic .t2 {top:253px; margin-left:-159px; animation-delay:.5s;}
.life-main .topic .date {top:33px; margin-left:-570px;}
.life-main .topic .sub {top:387px; margin-left:-200px; animation:fadeIn 1s .6s forwards; opacity:0;}
.life-main .topic .dc-group {top:205px; margin-left:177px; width:85px; height:60px;}
.life-main .topic .dc-group span {left:0; width:38px; height:100%; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_star.png); background-position:0 0; animation:fadeIn 1s 1s 1 forwards; opacity:0;}
.life-main .topic .dc-group .dc2 {width:27px; left:38px; background-position:-38px 0; animation-delay:1.1s;}
.life-main .topic .dc-group .dc3 {width:20px; left:65px; background-position:-65px 0;  animation-delay:1.2s;}

.life-main .pageMove {display:none;}
.life-main .scrollbarwrap {width:100%;}
.life-main .scrollbarwrap .viewport {overflow:hidden; position: relative; width:257px; height:144px; margin:0 52px 0 38px;}
.life-main .scrollbarwrap .viewport .overview p {font-size:12px;}
.life-main .scrollbarwrap .overview {color:#33241c; line-height:1.73;}
.life-main .scrollbarwrap .scrollbar {float:right; position:relative; width:10px; margin-right:24px; border-radius:4px; background-color:#f6f6f6;}
.life-main .scrollbarwrap.track {position: relative; width:10px; height:100%; background-color:#ececec;}
.life-main .scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:10px; height:24px; border-radius:4px; background-color:#f37ad5; cursor:pointer;}
.life-main .scrollbarwrap .thumb .end {overflow:hidden; width:5px; height:5px; border-radius:4px;}
.life-main .scrollbarwrap .disable {display:none;}
.life-main .cmt-list li.cmt2 .scrollbarwrap .thumb {background-color:#26fc9f;}
.life-main .cmt-list li.cmt3 .scrollbarwrap .thumb {background-color:#f3de00;}

.section {position:absolute; top:538px; left:50%; margin-left:-382px;}
.section h3 {position:absolute;}

.life-coupon {width:652px; height:523px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_planet_2.png)no-repeat 50% 50%;}
.life-coupon h3 {top:163px; left:212px; z-index:5;}
.life-coupon ol {position:absolute; top:-16px; left:505px; width:187px; height:444px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_0.png)no-repeat 0 0;}
.life-coupon ol li {position:absolute; margin-left:-50px; opacity:0; transition:all .5s;}
.life-coupon ol li.on {margin-left:0; opacity:1;}
.life-coupon ol .gage2 {top:249px; left:194px;}
.life-coupon ol .gage4 {top:133px; left:173px;}
.life-coupon ol .gage6 {top:54px; left:126px;}
.life-coupon ol .gage7 {top:8px; left:70px;}
.life-coupon .btn-coupon {position:absolute; top:295px; left:528px; z-index:25; width:147px; height:147px; background-repeat:no-repeat; background-position:0 0;}
.life-coupon .btn-coupon .how-to {display:none; position:absolute; top:-73px; left:115px;}
.life-coupon .btn-coupon:hover .how-to {display:block;}
.life-coupon .dc1 {top:93px; left:110px; animation:cursor .8s 100; }
.life-coupon .dc2 {top:3px; left:539px; z-index:20;}
.life-coupon .dc3 {top:80px; left:-10px; animation:bounce2 .8s 100 ease-in-out;}
.life-coupon .dc4 {top:-32px; left:140px; z-index:10; animation:twinkle .9s 300;}
.life-coupon .active-img {top:-40px; left:273px; z-index:1}
.layer-coupon {display:block; width:100%; height:100%;}
.layer-coupon:before {display:block; position:absolute; top:0; left:0; z-index:30; width:100%; height:100%; background-color:rgba(0,0,0,.5); content:' ';}
.layer-coupon .inner {position:fixed; top:180px; left:50%; z-index:50; width:816px; margin-left:-408px;}
.layer-coupon a {position:absolute; top:430px; left:50%; margin-left:-120px;}
.layer-coupon .btn-close {position:absolute; top:0; left:50%; margin-left:250px; width:100px; height:100px; text-indent:-999em;}
.life-mileage {top:1545px; margin-left:-570px;}
.life-mileage h3 {top:0; left:0;}
.life-mileage .active-img {top:88px; left:0;}
.life-mileage .coming {position:absolute; top:88px; left:-22px; z-index:10;}
.life-backwon {top:1130px; margin-left:66px;}
.life-backwon span {position:absolute; top:93px; left:-13px;}
.life-backwon h3 {top:-2px; left:-4px;}
.life-backwon .active-img {top:0; left:-53px;}
.life-gift {top:2177px; margin-left:-548px;}
.life-gift h3 {top:0; left:0;}
.life-gift .active-img {top:140px; left:-22px;}
.life-gift .dc {margin-left:0;}
.life-gift .dc1 {top:155px; left:43px; animation:bounce2 1.4s 100 ease-in-out;}
.life-gift .dc2 {top:97px; left:203px; animation:bounce2 1.4s .5s 100 ease-in-out;}
.life-gift .dc3 {top:98px; margin-left:43px;}
.life-diary {top:2307px; margin-left:84px;}
.life-diary i {position:absolute; top:178px; left:157px; animation:moveX .8s 300;}
.life-quiz {top:1828px; margin-left:63px;}
.life-quiz h3 {top:0; left:0;}
.life-quiz .coin {position:absolute; top:104px; left:-74px;}
.life-quiz .txt {position:absolute; top:80px; left:170px; z-index:10; animation:bounce2 .8s 100 ease-in-out;}
.life-event {top:1037px; margin-left:-444px;}
.life-event span {top:87px; left:-29px;}
.active-img.car {top:2600px; left:50%; margin-left:100px;}
.active-img.ufo {top:1761px; left:50%; margin-left:475px;}


.cmt-wrap {padding-top:78px; background:#ba4dd9 url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/bg_ten_life_v8.jpg) no-repeat 50% 0;}
.cmt-write .info {position:absolute; top:0; left:39px; text-align:left;}
.cmt-write .info h3 {margin:70px 0 22px}
.cmt-write .select-icon {position:relative; z-index:10; overflow:hidden; width:570px; margin:0 0 0 570px;}
.cmt-write .select-icon  > div {overflow:hidden; float:left; width:186px; height:353px;}
.cmt-write .select-icon input[type=radio] {visibility:hidden; position:absolute; left:0; top:0;}
.cmt-write .select-icon label {display:block; position:relative; width:186px; height:353px; margin-top:20px; cursor:pointer; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/ico_select_1.png) no-repeat 50% 0; text-indent:-999em;}
.cmt-write .select-icon input[type=radio]:checked + label {margin-top:0; background-position:50% 100%;}
.cmt-write .select-icon #select2 + label {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/ico_select_2.png)}
.cmt-write .select-icon #select3 + label {margin-left:-21px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/ico_select_3.png)}
.cmt-write .write-cont {position:absolute; bottom:25px; left:-12px; width:1181px; height:232px; text-align:left; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_input.png) no-repeat 0 0;}
.cmt-write .write-cont textarea {height:94px; width:700px; margin:60px 394px 80px 90px; padding:0; color:#888; font-size:18px; line-height:1.3; font-weight:bold; border:0; vertical-align:top; background-color:transparent;}
.cmt-write .write-cont .btn-submit {position:absolute; right:29px; top:10px; outline:none;  background-color:transparent;}
.cmt-write .caution {padding-top:273px; padding-left:88px; text-align:left; color:#9b9b9b; font-size:11px; line-height:1;}

.cmt-list {margin-top:72px; padding-bottom:80px;}
.cmt-list ul {overflow:hidden; margin:0 -25px;}
.cmt-list li {float:left; position:relative; z-index:20; width:346px; height:450px; margin:0 25px 18px; word-break:break-all; font-size:11px; text-align:left; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/bg_cmt_1.png) no-repeat 0 69px;}
.cmt-list li.et1:before,
.cmt-list li.et2:before,
.cmt-list li.et3:before {display:inline-block; position:absolute; top:3px; left:187px; z-index:10; width:64px; height:81px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_et.png); content:' '; animation:moveX .8s infinite ease-in-out;}
.cmt-list li.et2:before {animation-delay:.3s;}
.cmt-list li.et3:before {animation-delay:.5s;}
.cmt-list li .info {position:relative; padding-top:85px; margin-bottom:40px; font-weight:bold; line-height:1; color:#33241c; text-align:right; letter-spacing:-1px;}
.cmt-list li .num {display:inline-block; height:27px; padding:0 9px; margin-right:-8px; border-radius:4px; background-color:#fa7edb; font-size:12px; line-height:27px;}
.cmt-list li .writer {height:18px; margin-top:14px; margin-right:23px; font-size:13px;}
.cmt-list li .writer img {width:8px; margin-right:3px;}
.cmt-list li .date {margin-top:45px; margin-right:24px; color:#868686; font-size:13px; text-align:right;}
.cmt-list li .btn-group {margin-top:30px; margin-right:-10px; text-align:right;}
.cmt-list li .btn-group button {color:#fcfcfc; font-size:15px; margin:0 12px; outline:none;}
.cmt-list li .btn-group .delete {position:relative; display:inline-block; height:26px; width:26px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_delete.png); text-indent:-999em;}
.cmt-list li .dc-group .ico {left:20px; width:151px; height:172px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/ico_cmt_1.png) 0 0 no-repeat;}
.cmt-list li .dc-group .dc1 {top:27px; left:8px; animation: bounce2 .8s linear infinite alternate;}
.cmt-list li.et2 .dc-group dc1 {animation-delay:.3s;}
.cmt-list li.et3 .dc-group dc1 {animation-delay:.5s;}
.cmt-list li .dc-group .dc2 {top:21px; left:5px}
.cmt-list li.cmt2 {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/bg_cmt_2.png);}
.cmt-list li.cmt2 .num {background-color:#26fa9e;}
.cmt-list li.cmt2 .dc-group .ico {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/ico_cmt_2.png);}
.cmt-list li.cmt3 {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/bg_cmt_3.png?v=1.01);}
.cmt-list li.cmt3 .num {background-color:#fce700;}
.cmt-list li.cmt3 .dc-group .ico {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/ico_cmt_3.png);}

.life-main .paging {height:40px; margin-top:52px;}
.life-main .paging a {width:40px; height:40px; margin:0 9px; font-weight:bold; line-height:40px; border:0; background-color:transparent;}
.life-main .paging a span {width:40px; height:40px; padding:0; color:#fff;}
.life-main .paging a.arrow {background-color:transparent;}
.life-main .paging a.arrow span {width:41px; padding:0; text-indent:0; background-image:none;}
.life-main .paging a.current {background-color:#d1fc7d; border:0; border-radius:50%; color:#fff; font-weight:bold;}
.life-main .paging a.current span {color:#000;}
.life-main .paging a.current:hover {background-color:#d1fc7d;}
.life-main .paging a.arrow.first,
.life-main .paging a.arrow.end {display:none;}
.life-main .paging a:hover {background-color:transparent;}

.bg-gage {position:absolute; bottom:94px; left:505px; width:187px; height:444px;  background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_0.png)no-repeat 0 0; transition:all .3s;}
.bg-gage.on {opacity:1;}
.life-coupon .dc2 {top:230px; left:630px;}
.spin1 {animation:spin .8s forwards; transform-origin:-240px 22px;}
.spin2 {animation-name:spin2;}
.spin3 {animation-name:spin3;}
.spin4 {animation-name:spin4;}
.spin5 {animation-name:spin5;}
.spin6 {animation-name:spin6;}
.spin7 {animation-name:spin7;}
.spin8 {animation-name:spin8;}
.spin9 {animation-name:spin9; animation-duration:1.5s; animation-iteration-count:2; animation-timing-function:linear;}
.spin9 {animation:spin9 1.5s 1 linear forwards;}

@keyframes bounce1 {from {transform:translateY(-20px);} 50%{transform:translateY(5px)}	to {transform:translateY(0); opacity:1;}}
@keyframes bounce2 {from, to{transform:translateY(0);} 50%{transform:translateY(10px)}}
@keyframes moveX {from, to{transform:translateX(0);}	50%{transform:translateX(5px)}}
@keyframes fadeIn {from {opacity:0;}to {opacity:1;}}
@keyframes cursor {from,to {transform:translate(0, 0);} 50% {transform:translate(10px, 10px);}}
@keyframes spin {from {transform: rotate(0); }to{transform: rotate(-8deg); }}
@keyframes spin2 {from {transform: rotate(-8deg); }to{transform: rotate(-17deg); }}
@keyframes spin3 {from {transform: rotate(-17deg); }to{transform: rotate(-27deg); }}
@keyframes spin4 {from {transform: rotate(-27deg); }to{transform: rotate(-39deg); }}
@keyframes spin5 {from {transform: rotate(-39deg); }to{transform: rotate(-48deg); }}
@keyframes spin6 {from {transform: rotate(-48deg); }to{transform: rotate(-56deg); }}
@keyframes spin7 {from {transform: rotate(-56deg); }to{transform: rotate(-70deg); }}
@keyframes spin8 {from {transform: rotate(-70deg); }to{transform: rotate(-79deg); }}
@keyframes spin9 {from {transform: rotate(-79deg); }to{transform: rotate(-360deg); }}
@keyframes twinkle {from, to{opacity:1;} 50%{opacity:0;}}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	fnAmplitudeEventMultiPropertiesAction('view_17th_main','','');
	// coupon
	$('.layer-coupon').hide();
	$('.layer-coupon .btn-close').click(function (e){$('.layer-coupon').hide();});
	var count = 0;
	$('.btn-coupon').click(function () {
	<% if iscouponeDown then %>
		return false;
	<% end if %> 

	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
		return false;
	<% end if %>        		
		$('.how-to').hide();
		count += 1;
		if (count == 1) {
			$('.life-coupon .dc2').addClass('spin1');
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_1.png)','opacity':'1'});
		} else	if (count == 3) {
			$('.life-coupon .dc2').addClass('spin2');
			$('.gage2').addClass('on');
			setTimeout(function(){$('.gage2').removeClass('on');}, 700);
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_2.png)','opacity':'1'});
		} else	if (count == 4) {
			$('.life-coupon .dc2').addClass('spin3');
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_3.png)','opacity':'1'});
		} else	if (count == 5) {
			$('.life-coupon .dc2').addClass('spin4');
			$('.gage4').addClass('on');
			setTimeout(function(){$('.gage4').removeClass('on');}, 700);
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_4.png)','opacity':'1'});
		} else	if (count == 6) {
			$('.life-coupon .dc2').addClass('spin5');
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_5.png)','opacity':'1'});
		} else	if (count == 7) {
			$('.life-coupon .dc2').addClass('spin6');
			$('.gage6').addClass('on');
			setTimeout(function(){$('.gage6').removeClass('on'); }, 700);
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_6.png)','opacity':'1'});
		} else	if (count == 8) {
			$('.life-coupon .dc2').addClass('spin7');
			$('.gage7').addClass('on');
			setTimeout(function(){$('.gage7').removeClass('on');}, 700);
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_7.png)','opacity':'1'});
		} else	if (count == 9) {
			$('.life-coupon .dc2').addClass('spin8');
			setTimeout(function(){$('.gage8').addClass('on');});
			setTimeout(function(){$('.life-coupon .dc2').addClass('spin9');}, 300);
			$('.life-coupon .bg-gage').css({'background-image':'url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_gage_8.png)','opacity':'1'});			
			fnAmplitudeEventMultiPropertiesAction('click_ten17th_getcouponbtn','','');				
   			jsDownCoupon('prd,prd,prd,prd,prd','<%=eventCoupons%>')						   
		}
	});
	// scroll
	$('.scrollbarwrap').tinyscrollbar();

	// scroll animation
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		console.log(scrollTop);
		if (scrollTop > 2400 ) {
			$(".share").css({'position':'absolute','top':'2480px'});
		} else {
			$(".share").css({'position':'fixed','top':'200px'});
		}
	});
});

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
		fnAmplitudeEventMultiPropertiesAction('click_17th_main_sns','snstype','tw');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
		fnAmplitudeEventMultiPropertiesAction('click_17th_main_sns','snstype','tw');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
function jsDownCoupon(stype,idx){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>
	var imageUrl = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_coupon_comp.png"
	$.ajax({
		type: "post",
		url: "/shoppingtoday/act_couponshop_process.asp",
		data: "idx="+idx+"&stype="+stype,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				if(message.response=="Ok") {
					setTimeout(function(){$('.layer-coupon').show();}, 800);					
					$('#couponBtn').css('background-image', 'url("' + imageUrl + '")');
				} else {
					alert(message.message);
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/17th/")%>';
		return;
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 17주년이벤트 -->
						<div class="ten-life life-main">
							<div class="evt-list">
								<!-- 상단 -->
								<div class="topic">
									<p class="anniver"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_17th.png" alt="17th Anniversary" /></p>
									<h2>
										<span class="t1"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_ten_life_1.png" alt="슬기로운" /></span>
										<span class="t2"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_ten_life_2.png" alt="텐텐생활" /></span>
									</h2>
									<p class="sub"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_sub_v3.png" alt="10월, 텐바이텐을 더 즐겁게 이용하는 방법!" /></p>
									<span class="dc-group">
										<span class="dc dc1"></span>
										<span class="dc dc2"></span>
										<span class="dc dc3"></span>
									</span>
									<span class="date"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_date.png" alt="2018 10.10 - 31" /></span>
								</div>

								<!-- 공유 -->                            
								<div class="share">
									<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_share.png" alt="" /></p>
									<ul>
										<li><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_fb.png" alt="" /></li>
										<li><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_twitter.png" alt="" /></li>
									</ul>                                
									<a href="" class="fb" onclick="snschk('fb');return false;" >페이스북 공유</a>
									<a href="" class="twitter" onclick="snschk('tw');return false;" >트위터 공유</a>                                
								</div>        
								<!-- 쿠폰 -->
								<div class="section life-coupon">
									<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_coupon.png" alt="광클하고, 쿠폰 받기!" /></h3>
									<span class="active-img"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_coupon_boy.png" alt="" /></span>
									<ol>
										<li class="gage2"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_gatge_1.png" alt="" /></li>
										<li class="gage4"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_gatge_2.png" alt="" /></li>
										<li class="gage6"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_gatge_3.png" alt="" /></li>
										<li class="gage7"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_gatge_4.png" alt="" /></li>
									</ol>
									<span class="bg-gage"></span>								
									<% if iscouponeDown then %>
										<button class="btn-coupon" id="couponBtn" style="background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_coupon_comp.png)">
											<p class="how-to"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_how_to.png" alt="how to 마우스를 계속 클랙해서 게이재를 채어야 쿠폰을 받을 수 있어요!" /></p>
											<span class="dc dc1"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_hand.png" alt="" /></span>
										</button>													
									<% else %>
										<button class="btn-coupon" id="couponBtn" style="background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_coupon.png)">
											<p class="how-to"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_how_to.png" alt="how to 마우스를 계속 클랙해서 게이재를 채어야 쿠폰을 받을 수 있어요!" /></p>
											<span class="dc dc1"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_hand.png" alt="" /></span>
										</button>																
									<% end if %>
									<span class="dc dc2"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_rocket.png" alt="" /></span>
									<span class="dc dc3"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_planet_1.png" alt="" /></span>
									<span class="dc dc4">
										<% if date() = "2018-10-29" then %>
										<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_d_2.png" alt="" />
										<% end if %>
										<% if date() = "2018-10-30" then %>
										<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_d_1.png" alt="" />
										<% end if %>
										<% if date() = "2018-10-31" then %>
										<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_last_day.png" alt="" />
										<% end if %>
									</span>
								</div>

								<!-- 쿠폰 팝업 레이어 -->
								<div class="layer-coupon" style="display:none">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_pop_coupon.png" alt="쿠폰이 발급 되었습니다!" /></h4>
										<a href="/my10x10/couponbook.asp"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_go_coupon.png" alt="쿠폰함으로 가기" /></a>
										<button class="btn-close">닫기</button>
									</div>
								</div>

								<!-- 출석체크이벤트 -->
								<div class="section life-mileage">
									<a href="/event/17th/maeliage17th.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_17th_main_maeliage','','');">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_maileage_v2.png" alt="매일매일 매일리지 " /></h3>
										<span class="active-img"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_maelieage_v3.gif" alt="" /></span>
									</a>
								</div>

								<!-- 경품이벤트 -->
								<div class="section life-backwon">
									<a href="/event/17th/gacha.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_17th_main_gacha','','');">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_backwon_v3.png" alt="100원으로 인생역전 " /></h3>
										<span class="active-img"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_backwon_v3.gif" alt="날이면 날마다 오는게 아니에요!" /></span>
									</a>
								</div>

								<!-- 구매사은이벤트 -->
								<div class="section life-gift">
									<a href="/event/17th/gift.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_17th_main_gift','','');">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_gift.png" alt="잘사고 잘받자!" /></h3>
										<!-- <span class="dc dc1"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_cup_boy.png" alt="" /></span>
										<span class="dc dc2"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_cup_girl.png" alt="" /></span> -->
										<span class="dc dc3"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_cup_soldout.png" alt="" /></span>
										<span class="active-img"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_gift.png" alt="사은품이 예술이야!" /></span>
									</a>
								</div>

								<!-- 다이어리스토리 -->
								<div class="section life-diary">
									<a href="/diarystory2019/" onclick="fnAmplitudeEventMultiPropertiesAction('click_17th_main_diary','','');">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_diary_v3.png?v=1.02" alt="다이어리전" /></h3>
										<i><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_diary_v3.png" alt="" /></i>
									</a>
								</div>																				
								<!-- 참여이벤트(텐퀴이즈) -->
								<div class="section life-quiz">
									<a href="/tenquiz/index.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_17th_main_tenquiz','','');">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_quiz_v3.png" alt="도전! 텐텐벨" /></h3>
										<span class="txt">
											<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_tenquiz_coming.png?v=1.01" alt="coming Soon" />
										</span>
										<p class="coin"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_tenquiz.png" alt="텐 퀴이즈" /></p>										
									</a>
								</div>								
								<!-- 상품기획전 -->
								<div class="section life-event">
											<% If Now() < #10/14/2018 23:59:59# Then %>			
										<a href="javascript:void(0)"> <%'<!--추가예정-->%>
											<% else %>										
										<a href="/event/17th/today.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_17th_main_MDspick','','');">                                
											<% end if %>										
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_event_v2.png" alt="오늘의 특가!" /></h3>
										<span class="active-img">										
											<% If Now() < #10/14/2018 23:59:59# Then %>
											<!-- 10/15전까지 노출 --><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_md_coming.png" alt="10.15 coming soon" />
											<% else %>
											<img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_md_v3.gif" alt="가을 주역의 아이템!" />
											<% end if %>
										</span>
									</a>
								</div>
							</div>
                        <!-- #include virtual="/event/17th/inc_comment.asp" -->
						<!-- // 17주년이벤트 -->

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->