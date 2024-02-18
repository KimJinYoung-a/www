<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 설문조사
' History : 2017-01-20 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/coffeeCls.asp" -->
<%
dim eCode, userid, currenttime, page, i
IF application("Svr_Info") = "Dev" THEN
	eCode = "66399"
Else
	eCode = "79272"
End If

page=requestcheckvar(request("page"),5)
If page="" Then  page=1
currenttime = now()
userid = GetEncLoginUserID()

Dim cEvtFan
set cEvtFan = new CEvtElectricFan
cEvtFan.FECode = eCode	'이벤트 코드
cEvtFan.FCurrPage = page
cEvtFan.FPageSize = 9
cEvtFan.GetElectricFanList

Dim myCom
set myCom = new CEvtCoffee
myCom.Frectuserid=userid
myCom.FECode = eCode	'이벤트 코드
myCom.GetMyComment
%>
<style type="text/css">
.coffeeHead {position:relative; height:800px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_head.png) repeat 50% 0;}
.coffeeHead h2 {position:absolute; top:421px; left:50%; width:810px; height:143px; margin-left:-405px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_bar.png) no-repeat 50% 50%;}
.coffeeHead h2 span {display:block; position:absolute; top:0; left:50%; width:126px; height:143px;}
.coffeeHead h2 span.t1 {margin-left:-416px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_co.png) no-repeat 50% 0;}
.coffeeHead h2 span.t2 {margin-left:275px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_ffee.png) no-repeat 50% 0;}
.coffeeHead > p {position:absolute; left:50%;}
.coffeeHead .tentenPrj {top:120px; margin-left:-115px;}
.coffeeHead .mainImg {top:0; margin-left:-345px;}
.coffeeHead .subcopy {top:285px; margin-left:-414px; }
.coffeeHead .evntDate {top:268px; margin-left:293px;}

.howToEnter {position:relative; height:425px; margin-top:-15px; padding-top:94px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_wave.png) repeat 50% 0;}
.enter {position:relative; width:884px; margin:50px auto 20px;}
.enter div {width:714px; height:110px; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_box_lt.png) no-repeat 0 0; text-align:right;}
.enter textarea {width:92%; padding:12px; font-size:15px; font-weight:bold; border:none; vertical-align:middle;}
.enter textarea::-input-placeholder {color:#bbb;}
.enter textarea::-webkit-input-placeholder {color:#bbb;}
.enter textarea::-moz-placeholder {color:#bbb;}
.enter textarea:-ms-input-placeholder {color:#bbb;}
.enter textarea:-moz-placeholder {color:#bbb;}
.enter button {position:absolute; right:0; top:0; background-color:transparent;}
.myCheck {position:relative; height:260px; padding-top:65px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_mycheck.png) repeat 50% 0;}
.myCheck .enter div {width:884px; height:110px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_box.png) no-repeat 0 0; text-align:left;}
.myCheck .enter textarea {width:81%; height:70px; padding:20px; margin-left:4%; text-align:left; line-height:20px;}
.myCheck .enter button {right:20px; top:20px;}

.enteredList {height:1000px; /*padding:66px 0 95px;*/ background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_cmt.png) repeat 50% 0;}
.enteredList ul {overflow:hidden; width:1110px; margin:0 auto; padding-top:90px;}
.enteredList ul li {position:relative; float:left; margin:20px; width:270px; height:106px; padding:64px 30px 30px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_cmt_box.png) no-repeat 50% 0; font-size:14px; line-height:26px; color:#333; text-align:left;}
.enteredList ul li .num, .enteredList ul li .wirter {position:absolute; top:30px; color:#590f00; font-size:13px; line-height:12px; vertical-align:middle;}
.enteredList ul li .wirter {left:30px; text-align:left; font-weight:bold;}
.enteredList ul li .wirter img {margin-right:5px;}
.enteredList ul li .num {right:30px; text-align:right; font-weight:normal;}
.enteredList .paging {height:30px; padding:5px 0; margin-top:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_round_green.png) no-repeat 50% 0;}
.enteredList .paging a{width:29px; height:30px; background-color:transparent; border:none;}
.enteredList .paging a.current:hover {background-color:transparent; }
.enteredList .paging a span {width:100%; height:100%; color:#fff; padding:4px 0 0;}
.enteredList .paging a.current span {color:#ffe955;}
.enteredList .paging a.arrow {width:30px;}
.enteredList .paging a.arrow span {width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/img_arrow.png) no-repeat 0 0;}
.enteredList .paging a.prev span {background-position:-33px 0;}
.enteredList .paging a.next {margin-left:5px;}
.enteredList .paging a.next span {background-position:-400px 0;}
.enteredList .paging a.end span {background-position:100% 0;}

.evntNoti {position:relative; height:240px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/bg_noti.png) repeat 50% 0;}
.evntNoti div {display:table; width:885px; margin:0 auto; padding:55px 0;}
.evntNoti h3 {display:table-cell; width:275px; text-align:left; vertical-align:middle;}
.evntNoti ul {display:table-cell; overflow:hidden; width:868px;}
.evntNoti ul li {color:#fff; text-align:left; font-size:12px; line-height:26px;}
</style>
<script type="text/javascript">
$(function(){
	titleAnimation()
	$(".coffeeHead h2 .t1").css({"margin-left":"-100px", "opacity":"0"});
	$(".coffeeHead h2 .t2").css({"margin-left":"100px", "opacity":"0"});
	function titleAnimation() {
		$(".coffeeHead h2 .t1").delay(120).animate({"margin-left":"-416px", "opacity":"1"},400);
		$(".coffeeHead h2 .t2").delay(120).animate({"margin-left":"275px", "opacity":"1"},400);
	}
});

function chkevt(){
	<% If not(IsUserLoginOK()) Then %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% else %>
	var frm =  document.frm;
	if (GetByteLength(frm.comment.value) > 200){
		alert("100자 까지 작성 가능합니다.");
		frm.comment.focus();
		return false;
	}
	if (frm.comment.value==""){
		alert("빈칸을 정확하게 모두 채워 주세요.");
		frm.comment.focus();
		return false;
	}
	jsEventSubmit();
	<% End IF %>
}

function jsEventSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If now() > #07/28/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/doEventSubscript79272.asp",
				data: $("#frm").serialize(),
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			console.log(str);
			if (str1[0] == "01"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "02"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "03"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "05"){
				alert(str1[1]);
				location.reload();
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function TnDelComment(){
	<% If IsUserLoginOK() Then %>
		var str = $.ajax({
			type: "POST",
			url: "/event/etc/doEventSubscript79272.asp",
			data: $("#frmcom").serialize(),
			dataType: "text",
			async: false
		}).responseText;
		var str1 = str.split("||")
		console.log(str);
		if (str1[0] == "01"){
			alert(str1[1]);
			return false;
		}else if (str1[0] == "02"){
			alert(str1[1]);
			return false;
		}else if (str1[0] == "03"){
			alert(str1[1]);
			return false;
		}else if (str1[0] == "05"){
			alert(str1[1]);
			location.reload();
			return false;
		}else{
			alert('오류가 발생했습니다.');
			return false;
		}
	<% Else %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsGoComPage(iP){
	document.frmcom.page.value = iP;
	location.href="/event/eventmain.asp?eventid=<%=eCode%>&page="+iP + "#enteredList"
}
</script>
<div class="evt79272">
<form name="frm" id="frm" method="post" onsubmit="return false;">
	<div class="coffeeHead">
		<h2>
			<span class="t1"></span>
			<span class="t2"></span>
		</h2>
		<p class="tentenPrj"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_10x10_project.png" alt="10X10 = 100프로젝트" /></p>
		<p class="mainImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/img_coffee.png" alt="" /></p>
		<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_giftcard.png" alt="텐바이텐이 커피 기프트 카드 100만원권을 쏩니다!" /></p>
		<p class="evntDate"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_date.png" alt="이벤트 기간은 07월 24일부터 07월 28일 입니다. 당첨자 발표는 08월 2일 수요일입니다." /></p>
	</div>
	<div class="howToEnter">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_howto.png" alt="" /></h3>

		<!-- 응모하기 -->
		<div class="enter">
			<div><textarea name="comment" id="comment" placeholder="100자 이내로 입력해주세요!" rows="5"></textarea></div>
			<button class="btnEnter" onclick="chkevt();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/btn_entry.png" alt="응모하기" /></button>
		</div>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_onece.png" alt="* 한 ID당 1회 신청 가능합니다" /></p>
	</div>
	<% If myCom.Fcomment <> "" Then %>
	<div class="myCheck">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_mycheck.png" alt="나의 신청 내역" /></h3>
		<div class="enter">
			<div><textarea rows="5"><%=myCom.Fcomment%></textarea></div>
			<button class="btnEnter" onClick="TnDelComment();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/btn_delete.png" alt="삭제하기" /></button>
		</div>
	</div>
	<% End If %>
	<% If cEvtFan.FresultCount < 1 Then %>
	<% Else %>
	<!-- for dev msg : 9개씩 노출-->
	<div class="enteredList" id="enteredList">
		<ul>
			<% For i=0 To cEvtFan.FresultCount-1 %>
			<li>
				<span class="wirter"><% If cEvtFan.FItemList(i).Fdevice="M" Then %><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/icon_m.png" alt="모바일로 작성" /><% End If %><%= printUserId(cEvtFan.FItemList(i).Fuserid,3,"*") %></span>
				<span class="num">No.<%= (cEvtFan.FTotalCount - (cEvtFan.FPageCount * cEvtFan.FPageSize)) -i %></span>
				<span class="userContet"><%= cEvtFan.FItemList(i).Fcomment %></span>
			</li>
			<% Next %>
		</ul>
		<div class="pageWrapV15 tMar20">
			<%= fnDisplayPaging_New_nottextboxdirect(page,cEvtFan.FTotalCount,9,10,"jsGoComPage") %>
		</div>
	</div>
	<% End If %>

	<div class="evntNoti">
		<div>
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79272/txt_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 본 이벤트는 ID당 1번씩만 응모하실 수 있습니다.</li>
				<li>- 욕설 및 비속어는 삭제될 수 있습니다.</li>
				<li>- 당첨자 발표는 8월 2일 (수) 사이트 공지사항에 게시될 예정입니다.</li>
				<li>- 제세공과금은 텐바이텐 부담이며, 세무신고를 위해 개인정보를 요청할 수 있습니다.</li>
				<li>- 당첨된 기프티콘은 회원정보상의 핸드폰번호로 발송됩니다. 정확한 배송을 위해 개인정보를 업데이트해주세요.</li>
			</ul>
		</div>
	</div>
</form>
</div>
<form method="post" name="frmcom" id="frmcom">
<input type="hidden" name="idx" value="<%=myCom.Fidx%>">
<input type="hidden" name="eCode" value="<%=eCode%>">
<input type="hidden" name="page" value="<%=page%>">
</form>
<%
Set cEvtFan = Nothing
Set myCom = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->