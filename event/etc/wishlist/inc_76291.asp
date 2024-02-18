<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시이벤트 - 무지개 라이브
' History : 2017-02-20 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/wisheventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim eCode, userid , iCTotCnt , gubun , vreturnurl , pagedown
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "66282"
	Else
		eCode   =  "76291"
	End If

	vreturnurl = Request.ServerVariables("url") &"?"&Request.ServerVariables("QUERY_STRING")
	gubun = requestCheckvar(request("gubun"),1)

	If gubun <> "" Then pagedown = "ON"

	If gubun = "" Then
		gubun = dategubun(Date())
	End If 

	'// 날짜 구분 없을때 구분값
	function dategubun(v)
		Select Case CStr(v)
			Case "2017-02-22"
				dategubun = "1"
			Case "2017-02-23"
				dategubun = "2"
			Case "2017-02-24"
				dategubun = "3"
			Case "2017-02-25"
				dategubun = "4"
			Case "2017-02-26"
				dategubun = "5"
			Case "2017-02-27"
				dategubun = "6"
			Case "2017-02-28"
				dategubun = "7"
			Case Else
				dategubun = "1"
		end Select
	end function

	userid = GetEncLoginUserID()

	Dim ifr, page, i, y
	page = requestCheckvar(request("page"),4)

	If page = "" Then page = 1

	set ifr = new evt_wishfolder
	ifr.FPageSize	= 10
	ifr.FCurrPage	= page
	ifr.FeCode		= eCode

	ifr.Frectuserid = userid
	ifr.Fgubun		= gubun
	ifr.evt_daily_itemselect

	iCTotCnt		= ifr.FTotalCount '리스트 총 갯수

	Dim sp, spitemid, spimg
	Dim arrCnt

	Dim strSql, todayCount
	todayCount = 0

	strSql = "Select COUNT(idx) From db_temp.dbo.tbl_event_itemwish  WHERE userid='" & userid & "' and gubun = '"& gubun &"' "
	'response.write strSql
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		todayCount = rsget(0)
	else
		todayCount = 0
	END IF
	rsget.Close
%>
<style type="text/css">
#contentWrap {padding-bottom:0;}

.rainbow {text-align:center;}
.rainbow button {background-color:transparent;}
.rainbow input::-webkit-input-placeholder {color:#9b9b9b; font-weight:normal;}
.rainbow input::-moz-placeholder {color:#9b9b9b; font-weight:normal;} /* firefox 19+ */
.rainbow input:-ms-input-placeholder {color:#9b9b9b; font-weight:normal;} /* ie */
.rainbow input:-moz-placeholder {color:#9b9b9b; font-weight:normal;}

.rainbow .topic {overflow:hidden; position:relative; height:459px; background:#645cf3 url(http://webimage.10x10.co.kr/eventIMG/2017/76291/bg_purple.jpg) no-repeat 50% 0;}
.rainbow .topic h2 {position:absolute; top:62px; left:50%; margin-left:-397px;}
.rainbow .topic  p {position:absolute; top:309px; left:50%; margin-left:-199px;}
.rainbow .topic .date {top:24px; margin-left:-570px;}
.rainbow .topic .deco {position:absolute; top:149px; left:50%; margin-left:-488px;}

.rainbow .mission {position:relative; padding:36px 0 25px; background-color:#f5f5f5;}
.rainbow .mission .deco {position:absolute; top:123px; left:50%; margin-left:331px;}
.pulse {animation:pulse 3s infinite; animation-fill-mode:both;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.9);}
	100% {transform:scale(1);}
}
.twinkle {animation:twinkle infinite 3s; animation-fill-mode:both; animation-delay:1.3s;}
@keyframes twinkle {
	0% {opacity:0;}
	50% {opacity:1;}
	100% {opacity:0;}
}

.navigator {width:707px; margin:0 auto;}
.navigator ul {overflow:hidden;}
.navigator ul li {float:left; width:79px; height:81px; padding:0 11px;}
.navigator ul li a {overflow:hidden; display:block; position:relative; width:100%; height:100%; line-height:81px; text-align:center;}
.navigator ul li a span {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76291/img_navigator_v2.png) no-repeat 0 -81px; cursor:pointer;}
.navigator ul li .coming span {background-position:0 0; cursor:default;}
.navigator ul li a.on span {background-position:0 100%;}
.navigator ul li.nav2 .coming span {background-position:-102px 0;}
.navigator ul li.nav2 a span {background-position:-102px -81px;}
.navigator ul li.nav2 a.on span {background-position:-102px 100%;}

.navigator ul li.nav3 .coming span {background-position:-203px 0;}
.navigator ul li.nav3 a span {background-position:-203px -81px;}
.navigator ul li.nav3 a.on span {background-position:-203px 100%;}

.navigator ul li.nav4 .coming span {background-position:-304px 0;}
.navigator ul li.nav4 a span {background-position:-304px -81px;}
.navigator ul li.nav4 a.on span {background-position:-304px 100%;}

.navigator ul li.nav5 .coming span {background-position:-405px 0;}
.navigator ul li.nav5 a span {background-position:-405px -81px;}
.navigator ul li.nav5 a.on span {background-position:-405px 100%;}

.navigator ul li.nav6 .coming span {background-position:-506px 0;}
.navigator ul li.nav6 a span {background-position:-506px -81px;}
.navigator ul li.nav6 a.on span {background-position:-506px 100%;}

.navigator ul li.nav7 .coming span {background-position:100% 0;}
.navigator ul li.nav7 a span {background-position:100% -81px;}
.navigator ul li.nav7 a.on span {background-position:100% 100%;}

.rainbow .mission .outer {width:1083px; margin:14px auto 0; padding-bottom:125px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76291/bg_box_01_bottom_v1.png) no-repeat 50% 100%;}
.rainbow .mission .inner {padding-top:105px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76291/bg_box_01_top_v2.png) no-repeat 50% 0;}
.rainbow .mission .inner .bg {background:url(http://webimage.10x10.co.kr/eventIMG/2017/76291/bg_box_01_middle.png) repeat-y 50% 0;}
.rainbow .mission .form {width:882px; margin:36px auto 0; padding:20px 0 21px; background-color:#f6f6f6;}
.rainbow .mission .form .fieldset {position:relative; width:434px; height:53px; margin:0 auto; border:4px solid #3c3c3c; background-color:#fff;}
.rainbow .mission .form .fieldset .itext {padding:0 123px 0 20px;}
.rainbow .mission .form .fieldset .itext input {width:100%; height:53px; line-height:53px; color:#000; font-family:'Gulim', '굴림', 'Verdana'; font-size:13px; font-weight:bold; text-align:left;}
.rainbow .mission .form .fieldset .btnCheck {position:absolute; top:8px; right:8px;}
.rainbow .mission .form + p {margin-top:69px;}
.rainbow .mission .check {padding:50px 0 30px;}
.rainbow .mission .check p {margin-top:20px; color:#3c3c3c; font-family:'Dotum', '돋움', 'Verdana'; font-size:14px; font-weight:bold;}
.rainbow .mission .check p em {overflow:hidden; display:inline-block; *display:inline; *zoom:1; width:332px; height:35px; margin-right:10px; padding:0 5px; background-color:#fff; line-height:35px; text-align:center;}
.rainbow .mission .check .btnArea {margin-top:20px; padding:0;}
.rainbow .mission .check .btnArea img {margin:0 6px; padding:0;}

.rainbow .mine {padding:78px 0 98px; background-color:#fff;}
.rainbow .mine ul {overflow:hidden; width:975px; height:155px; margin:27px auto 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76291/bg_nodata.png) repeat-x 0 0;}
.rainbow .mine ul li {float:left; margin:0 20px; width:149px; border:3px solid #f2f2f2;}

.rainbow .friends {padding:23px 0; background-color:#f5f5f5;}
.rainbow .friends .inner {width:1194px; height:791px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76291/bg_box_02.png) no-repeat 50% 0;}
.rainbow .friends .inner h3 {padding-top:128px;}
.rainbow .friends ul {overflow:hidden; width:975px; margin:-5px auto 0;}
.rainbow .friends ul li {float:left; width:155px; margin:40px 20px 0;}
.rainbow .friends ul li a:hover {text-decoration:none;}
.rainbow .friends ul li .desc {position:relative; margin-top:10px; padding-left:65px; text-align:right;}
.rainbow .friends ul li .no {position:absolute; top:0; left:0; width:62px; height:18px; background-color:#c5c5c5; color:#fff; font-weight:bold; line-height:18px; text-align:center;}
.rainbow .friends ul li .id {overflow:hidden; display:block; height:18px; color:#c5c5c5;}

.pageWrapV15 {margin-top:42px;}
.pageWrapV15 .pageMove {display:none;}

.noti {padding:35px 0; background-color:#e2e2e2; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto;}
.noti h3 {position:absolute; top:50%; left:41px; margin-top:-31px;}
.noti ul {margin-left:232px; padding-left:80px; border-left:2px solid #d8d7d7;}
.noti ul li {position:relative; margin-top:7px; padding-left:13px; color:#5c5c5c; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#5c5c5c;}
</style>
<Script>
$(function(){
	/* title animation */
	animation();
	$("#animation h2").css({"margin-top":"100px", "opacity":"0"});
	$("#animation .deco").css({"margin-top":"100px", "opacity":"0"});
	$("#animation .subcopy").css({"margin-top":"5px", "opacity":"0"});
	function animation () {
		$("#animation h2").delay(100).animate({"margin-top":"0", "opacity":"1"},1000);
		$("#animation .deco").delay(100).animate({"margin-top":"0", "opacity":"1"},1000);
		$("#animation .subcopy").delay(900).animate({"margin-top":"0", "opacity":"1",},800);
	}
	$(".mission .check").hide();

	<% if pagedown = "ON" and page = 1 then %>
	setTimeout(function(){
		$('html, body').animate({scrollTop:$(".navigator").offset().top}, 'fast');
	}, 300);
	<% end if %>
	<% if page > 1 then %>
	setTimeout(function(){
		$('html, body').animate({scrollTop:$("#friendlist").offset().top}, 'fast');
	}, 300);
	<% end if %>
});

function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% if todayCount > 4 then %>
			alert("한 ID당 하루 최대 5개의 상품을 등록하실 수 있습니다.");
			return;
		<% end if %>
		<% If Now() > #02/28/2017 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #02/22/2017 00:00:00# and Now() < #02/28/2017 23:59:59# Then %>
				var frm = document.frm;
				frm.action="/event/etc/wishlist/itemwishProc.asp";
				frm.hidM.value='I';
				frm.target = "frmgo";
				frm.submit();
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

// 상품정보 접수
function fnItemInfo() {
	<% If IsUserLoginOK() Then %>
	var iid  = document.frm.itemid.value;
	if (!iid){
		alert("상품코드를 입력해주세요");
		document.frm.itemid.focus();
		return;
	}

	$.ajax({
		type: "GET",
		url: "/common/act_iteminfo.asp?itemid="+iid,
		dataType: "xml",
		cache: false,
		async: false,
		beforeSend: function(x) {
			if(x && x.overrideMimeType) {
				x.overrideMimeType("text/xml;charset=UTF-8");
			}
		},
		success: function(xml) {
			if($(xml).find("itemInfo").find("item").length>0) {
				var rst = "<div class='thumbnail'><img src='" + $(xml).find("itemInfo").find("item").find("basicimage").text() + "' width='230' height='230' alt='"+ $(xml).find("itemInfo").find("item").find("itemname").text() +"'/></div>"
					rst += "<p><em>" + $(xml).find("itemInfo").find("item").find("itemname").text() +"</em><img src='http://webimage.10x10.co.kr/eventIMG/2017/76291/txt_check.png' alt='으로 응모하시겠어요?' /></p>"
					rst += "<div class='btnArea'><input type='image' src='http://webimage.10x10.co.kr/eventIMG/2017/76291/btn_submit_v1.png' alt='응모하기' onclick='jsSubmit()'/><button type='reset' onclick='resetitem();'><img src='http://webimage.10x10.co.kr/eventIMG/2017/76291/btn_resubmit.png' alt='다시 입력하기' /></button></div>";
				$("#lyItemInfo").fadeIn();
				$("#lyItemInfo").html(rst);
				$(".mission .check").slideDown();
			} else {
				$("#lyItemInfo").fadeOut();
			}
		},
		error: function(xhr, status, error) {
			alert("상품코드를 다시 확인 해주세요");
			document.frm.itemid.value = "";
			document.frm.itemid.focus();
			$("#lyItemInfo").fadeOut();
		}
	});
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

//reset
function resetitem(){
	$(".mission .check").hide();
	document.frm.itemid.value = "";
	$("#lyItemInfo").empty();
}
</script>
<div class="evt76291 rainbow">
	<div id="animation" class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_ranbow_live.png" alt="텐바이텐 무지개 라이브" /></h2>
		<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/txt_subcopy.png" alt="매일매일 미션에 맞는 상품을 찾아주세요!" /></p>
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/txt_date.png" alt="이벤트 기간은 2월 22일 수요일부터 2월 28일 화요일까지" /></p>
		<span class="deco twinkle"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/img_deco.png" alt="" /></span>
	</div>

	<div class="mission">
		<span class="deco pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/img_magnifying_glass.png" alt="" /></span>
		<div class="navigator">
			<ul>
				<li class="nav1">
					<% If Date() < "2017-02-22" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 22일 빨간색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=1" class="<%=chkiif(gubun = 1,"on","")%>"><span></span>2월 22일 빨간색</a>
					<% End If %>
				</li>
				<li class="nav2">
					<% If Date() < "2017-02-23" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 23일 주황색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=2" class="<%=chkiif(gubun = 2,"on","")%>"><span></span>2월 23일 주황색</a>
					<% End If %>
				</li>
				<li class="nav3">
					<% If Date() < "2017-02-24" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 22일 노랑색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=3" class="<%=chkiif(gubun = 3,"on","")%>"><span></span>2월 22일 노랑색</a>
					<% End If %>
				</li>
				<li class="nav4">
					<% If Date() < "2017-02-25" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 22일 초록색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=4" class="<%=chkiif(gubun = 4,"on","")%>"><span></span>2월 22일 초록색</a>
					<% End If %>
				</li>
				<li class="nav5">
					<% If Date() < "2017-02-26" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 22일 파랑색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=5" class="<%=chkiif(gubun = 5,"on","")%>"><span></span>2월 22일 파랑색</a>
					<% End If %>
				</li>
				<li class="nav6">
					<% If Date() < "2017-02-27" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 22일 남색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=6" class="<%=chkiif(gubun = 6,"on","")%>"><span></span>2월 22일 남색</a>
					<% End If %>
				</li>
				<li class="nav7">
					<% If Date() < "2017-02-28" Then %>
					<a href="#" class="coming" onclick="return false;"><span></span>2월 22일 보라색</a>
					<% Else %>
					<a href="/event/eventmain.asp?eventid=<%=ecode%>&gubun=7" class="<%=chkiif(gubun = 7,"on","")%>"><span></span>2월 22일 보라색</a>
					<% End If %>
				</li>
			</ul>
		</div>

		<div class="outer">
			<div class="inner">
				<div class="bg">
					<h3>
						<% If Date() <= "2017-02-22" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_01.png" alt="텐바이텐 속 빨간색을 찾아주세요!" />
						<% ElseIf Date() = "2017-02-23" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_02.png" alt="텐바이텐 속 주황색을 찾아주세요!" />
						<% ElseIf Date() = "2017-02-24" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_03.png" alt="텐바이텐 속 노랑색을 찾아주세요!" />
						<% ElseIf Date() = "2017-02-25" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_04.png" alt="텐바이텐 속 초록색을 찾아주세요!" />
						<% ElseIf Date() = "2017-02-26" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_05.png" alt="텐바이텐 속 파랑색을 찾아주세요!" />
						<% ElseIf Date() = "2017-02-27" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_06.png" alt="텐바이텐 속 남색을 찾아주세요!" />
						<% ElseIf Date() >= "2017-02-28" Then %>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_mission_07.png" alt="텐바이텐 속 보라색을 찾아주세요!" />
						<% End If %>							
					</h3>
					<div class="form">
						<form name="frm" method="post">
						<input type="hidden" name="hidM" value="I">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
							<fieldset>
								<div class="fieldset">
									<div class="itext"><input type="number" name="itemid" title="상품코드 입력" placeholder=" 상품코드를 입력해주세요 (숫자 6~7자)" value="" /></div>
									<button type="button" class="btnCheck" onclick="fnItemInfo();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/btn_check.png" alt="상품 확인" /></button>
								</div>
								<div class="check" id="lyItemInfo"></div>
							</fieldset>
						</form>
					</div>

					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/txt_mission_guide.png" alt="이벤트 참여방법 텐바이텐 사이트에서 미션 색깔에 맞는 상품을 찾아보아요 상품 상세페이지로 들어가보아요 우측 상단에 있는 상품코드를 이벤트 페이지에서 입력! 응모하기 버튼을 클릭하면 완료! 이벤트에 참여하신 고객님 중 20분을 추첨하여 텐바이텐 기프트카드 3만원권을 드립니다 이벤트 기간은 2월 22일 수요일부터 2월 28일 화요일까지며, 당첨자 발표는 3월 2일 목요일입니다." /></p>
				</div>
			</div>
		</div>
	</div>

	<% if todayCount > 0 then %>
	<div class="result mine">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_result_mine_v1.png" alt="나의 컬러별 미션수행 상품을 확인해보세요!" /></h3>
		<% if ifr.FmyTotalCount > 0 then %>
		<ul>
		<%
			if isarray(Split(ifr.Fmylist,",")) then
				arrCnt = Ubound(Split(ifr.Fmylist,","))
			else
				arrCnt=0
			end if

			If ifr.FmyTotalCount > 4 Then
				arrCnt = 5
			Else
				arrCnt = ifr.FmyTotalCount
			End If

			For y = 0 to CInt(arrCnt) - 1
				sp = Split(ifr.Fmylist,",")(y)
				spitemid = Split(sp,"|")(0)
				spimg	 = Split(sp,"|")(1)
		%>
			<li><a href="" onclick="ZoomItemInfo('<%=spitemid%>'); return false;"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" /></a></li>
		<%
			Next
		%>
		</ul>
		<% end if %>
	</div>
	<% End If %>

	<% If ifr.FResultCount > 0 Then %>
	<div class="result friends" id="friendlist">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_result_friends.png" alt="다른 친구들의 미션수행 결과는?" /></h3>
			<ul>
				<% For i = 0 to ifr.FResultCount -1 %>
				<li>
					<a href="" onclick="ZoomItemInfo('<%=ifr.FList(i).Fitemid %>'); return false;">
						<img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(ifr.FList(i).Fitemid)%>/<%=ifr.FList(i).Ficonimg%>" width="155" height="155" alt="<%=ifr.FList(i).Fitemname%>" />
						<div class="desc">
							<span class="no">No.<%=iCTotCnt-i-(10*(page-1))%></span>
							<span class="id"><b><%=printUserId(ifr.FList(i).FUserid,2,"*")%></b> 님</span>
						</div>
					</a>
				</li>
				<% Next %>							
			</ul>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(page,ifr.FTotalCount,10,10,"jsGoPage") %>
			</div>
		</div>
	</div>
	<% End If %>

	<div class="noti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76291/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>한 ID당 하루 최대 5개의 상품을 등록하실 수 있습니다.</li>
				<li><span></span>동일한 상품을 2번 이상 등록하실 수 없습니다.</li>
				<li><span></span>참여 횟수가 많을수록 당첨 확률이 올라갑니다.</li>
				<li><span></span>미션 색깔에 맞는 상품을 등록할수록 당첨확률이 높아집니다.</li>
				<li><span></span>당첨자는 3월 2일 사이트 공지사항에 게시될 예정입니다.</li>
				<li><span></span>정확한 발표를 위해 마이텐바이텐의 개인정보를 업데이트 해주세요.</li>
			</ul>
		</div>
		<iframe src="" name="frmgo" frameborder="0" width="0" height="0"></iframe>
	</div>
</div>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>"/>
	<input type="hidden" name="gubun" value="<%=gubun%>"/>
	<input type="hidden" name="page" value=""/>
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
