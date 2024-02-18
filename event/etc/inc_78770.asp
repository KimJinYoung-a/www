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
<!-- #include virtual="/event/etc/electricfanCls.asp" -->
<%
dim eCode, userid, currenttime, page, i
IF application("Svr_Info") = "Dev" THEN
	eCode = "66377"
Else
	eCode = "78770"
End If

page=requestcheckvar(request("page"),5)
If page="" Then  page=1
currenttime = now()
userid = GetEncLoginUserID()

dim subscriptcountend
subscriptcountend=0

'//본인 참여 여부
if userid<>"" then
	subscriptcountend = getevent_subscriptexistscount(eCode, userid, "", "2", "")
end If

Dim cEvtFan
set cEvtFan = new CEvtElectricFan
cEvtFan.FECode = eCode	'이벤트 코드
cEvtFan.FCurrPage = page
cEvtFan.FPageSize = 5
cEvtFan.GetElectricFanList
%>
<style type="text/css">
.fanHead {position:relative; height:660px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_light_blue.jpg) repeat 50% 0;}
.fanHead h2 {position:absolute; top:160px; left:50%; width:246px; height:311px; margin-left:-123px;}
.fanHead h2 span {display:block; width:100%; height:103px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/tit_fan.png) no-repeat 0 0;}
.fanHead h2 span.t2 {height:112px; background-position:0 -103px}
.fanHead h2 span.t3 {height:96px;background-position:0 100%}
.fanHead > p{position:absolute; left:50%;}
.fanHead .tentenPrj {top:105px; margin-left:-85px; }
.fanHead .subcopy {top:500px; margin-left:-86.5px; }
.fanHead .evntDate {position:absolute; top:40px; left:50%; margin-left:430px;}
.fanHead .prd {position:relative; width:1140px; height:100%; margin:0 auto;}
.fanHead .prd ul li {position:absolute; bottom:0;}
.fanHead .prd ul li:first-child {left:50px;}
.fanHead .prd ul li:first-child + li {right:25px;}
.fanHead .prd ul li:first-child + li span {position:absolute; top:258px; right:-12px;}
.fanHead .prd ul li:first-child span {position:absolute; top:13px;}
.fanHead .prd ul li:first-child span.deco1 { right:-8px;}
.fanHead .prd ul li:first-child span.deco2 {display:inline; top:240px; left:-20px;}
.howToEnter {position:relative; height:193px; margin-top:-15px; padding-top:77px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_dark_blue.png) repeat 50% 0;}
.howToEnter h3 {position:absolute; top:110px; left:50%; margin-left:-364px;}
.howToEnter p {margin-left:200px;}
.enter {height:250px; padding-top:80px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_yellow.jpg) repeat 50% 0;}
.enter p {position:relative; width:1140px; height:60px; margin:0 auto;}
.enter p input {position:absolute; top:0; left:50%; width:240px; height:60px; padding:1px 20px; margin-left:-436px;background-color:transparent; text-align:center; font-size:20px; color:#227cdf; font-weight:bold; line-height:60px;}
.enter p input.inpNum1 {width:40px; margin-left:62px; padding:1px 0 0;}
.enter p input.inpNum2 {width:40px; margin-left:117px; padding:1px 0 0;}
.enter button{margin-top:45px; background-color:transparent;}
.enter input::-input-placeholder {font-size:20px; color:#bbb;}
.enter input::-webkit-input-placeholder {font-size:20px; color:#bbb;}
.enter input::-moz-placeholder {font-size:20px; color:#bbb;}
.enter input:-ms-input-placeholder {font-size:20px; color:#bbb;}
.enter input:-moz-placeholder {font-size:20px; color:#bbb;}
.enter .enteredLayer {position:absolute; top:0; left:50%; width:100%; height:100%; margin-left:-50%; background-color:rgba(0,0,0,.5); z-index:10;}
.enter .enteredLayer div {position:relative; padding-top:245px;}
.enter .enteredLayer div a {position:absolute; bottom:45px; left:50%; margin-left:-150px;}
.enter .enteredLayer .btnClose {display:inline-block; position:absolute; top:180px; left:50%; width:115px; height:115px; margin-left:130px; background-color:transparent; text-indent:-999em;}
.enteredList {height:683px; padding:66px 0 95px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_light_blue.jpg) repeat 50% 0;}
.enteredList ul {width:850px; margin:45px auto;}
.enteredList ul li {display:table; width:790px; height:20px; padding:30px; margin-bottom:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_round_dark_blue.png) no-repeat 50% 0; font-size:20px; line-height:20px; color:#fff; font-weight:bold;}
.enteredList ul li > .num,
.enteredList ul li > .wirter{display:table-cell; color:#5cc8ff; font-size:12px; line-height:12px; vertical-align:middle;}
.enteredList ul .userContet {vertical-align:middle;}
.enteredList ul .userContet em {color:#ffea59; }
.enteredList ul .userContet .team {overflow:hidden; display:inline-block; position:relative; top:2px; max-width:270px; max-height:20px; font-size:19px; line-height:19px;;}
.enteredList .paging {height:30px; padding:5px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_round_light_blue.png) no-repeat 50% 0;}
.enteredList .paging a{width:29px; height:30px; background-color:transparent; border:none;}
.enteredList .paging a.current:hover {background-color:transparent; }
.enteredList .paging a span {width:100%; height:100%; color:#fff; padding:4px 0 0;}
.enteredList .paging a.current span {color:#ffe955;}
.enteredList .paging a.arrow {width:30px;}
.enteredList .paging a.arrow span {width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/img_arrow.png) no-repeat 0 0;}
.enteredList .paging a.prev span {background-position:-33px 0;}
.enteredList .paging a.next {margin-left:5px;}
.enteredList .paging a.next span {background-position:-400px 0;}
.enteredList .paging a.end span {background-position:100% 0;}
.shareSns {position:relative; height:20px; padding:75px 0 67px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_dark_blue.jpg) repeat 50% 0;}
.shareSns .fb {position:absolute; top:55px; left:50%; margin-left:190px;}

.evntNoti {position:relative; height:85px; padding:60px  0 55px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78770/bg_black.jpg) repeat 50% 0;}
.evntNoti h3 {position:absolute; top:60px; left:50%; margin-left:-436px;}
.evntNoti ul {overflow:hidden; width:868px; margin:0 auto; padding:35px 8px 0;}
.evntNoti ul li{float:left;width:50%;  color:#fff; text-align:left; font-size:12px; line-height:26px;}

.swing{animation:swing 1.3s 20 forwards ease-in-out; transform-origin:0 100%;} 
.swing2 {animation:swing 1.3s .6s 20 forwards ease-in-out; transform-origin:100% 0;}
@keyframes swing { 0%,100%{transform:rotate(8deg);} 50% {transform:rotate(-8deg);} }
</style>
<script type="text/javascript">
$(function(){	
	titleAnimation()
	$(".fanHead h2 .t1").css({"margin-left":"-100px", "opacity":"0"});
	$(".fanHead h2 .t2").css({"opacity":"0"});
	$(".fanHead h2 .t3").css({"margin-left":"100px", "opacity":"0"});
	function titleAnimation() {
		$(".fanHead h2 .t1").delay(100).animate({"margin-left":"0", "opacity":"1"},300);
		$(".fanHead h2 .t2").delay(350).animate({"opacity":"1"},550);
		$(".fanHead h2 .t3").delay(500).animate({"margin-left":"0", "opacity":"1"},600);
	}
	$(".enteredLayer").hide();
	$(".enteredLayer .btnClose").click(function(){
		$(".enteredLayer").hide();
	});
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
	if (GetByteLength(frm.teamname.value) > 32){
		alert("32자 까지 작성 가능합니다.");
		frm.teamname.focus();
		return false;
	}
	if (frm.teamname.value==""){
		alert("빈칸을 정확하게 모두 채워 주세요.");
		frm.teamname.focus();
		return false;
	}
	if (!IsDigit(frm.num1.value)){
		alert("숫자만 작성 가능합니다.");
		frm.num1.focus();
		return false;
	}
	if (!IsDigit(frm.num2.value)){
		alert("숫자만 작성 가능합니다.");
		frm.num2.focus();
		return false;
	}
	if (frm.num1.value=="" && frm.num2.value==""){
		alert("빈칸을 정확하게 모두 채워 주세요.");
		frm.num1.focus();
		return false;
	}
	jsEventSubmit();
	<% End IF %>
}

function jsEventSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If now() > #07/09/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/doEventSubscript78770.asp",
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
				//응모완료 레이어 팝업
				window.parent.$('html,body').animate({scrollTop:$(".fanHead").offset().top},300);
				$('.enteredLayer').show();
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

function jsGoComPage(iP){
	document.frmcom.page.value = iP;
	location.href="/event/eventmain.asp?eventid=<%=eCode%>&page="+iP + "#enteredList"
}
</script>

<!-- 78770 선풍기-->
<div class="evt78770">
	<div class="fanHead">
		<h2>
			<span class="t1"></span>
			<span class="t2"></span>
			<span class="t3"></span>
		</h2>
		<p class="tentenPrj"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_10x10_project.png" alt="10X10 = 100프로젝트" /></p>
		<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_subcopy.png" alt="무더운 여름, 텐바이텐이 선풍기 100대 를 쏩니다!" /></p>
		<p class="evntDate"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_evnt_date.png" alt="이벤트 기간은 07월 03일부터 07월.09일 입니다. 당첨자 발표는 07월 12일 수요일입니다." /></p>
		<div class="prd">
			<ul>
				<li>
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/img_fan_1.png" alt="" />
					<span class="deco1 swing"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/img_deco_1.png" alt="" /></span>
					<span class="deco2 swing2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/img_deco_2.png" alt="" /></span>
				</li>
				<li>
					<a><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/img_fan_2.png" alt="OA 슈퍼팬 핸디미니선풍기" /></a>
					<span><a><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_prd_2.png" alt="OA 슈퍼팬 핸디미니선풍기" /></a></span>
				</li>
			</ul>
		</div>
	</div>
	<div class="howToEnter">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/tit_how_to_enter.png" alt="" /></h3>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_how_to_enter.png" alt="Step 01 선풍기를 함께 받고 싶은 모임의 이름을 적는다 Step 02 필요한 선풍기의 수량을 적고 응모하면 완료!" /></p>
	</div>

	<!-- 응모하기 -->
	<div class="enter">
	<form name="frm" id="frm" method="post" onsubmit="return false;">
		<p>
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_enter.png" alt="***팀과(와) 선푸이 **대를 받고 싶습니다." />
			<input type="text" name="teamname" class="inpTeam" placeholder="함께 받고 싶은 모임/팀" maxlength="32" />
			<!-- for dev msg // 숫자만 입력되도록 해주세요.-->
			<input type="number" name="num1" class="inpNum1" placeholder="9" maxlength="1" />
			<input type="number" name="num2" class="inpNum2" placeholder="9" maxlength="1"/>
		</p>
		<button class="btnEnter" onclick="chkevt();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/btn_enter.png" alt="응모하기" /></button>

		<!-- 응모 완료 팝업 레이어-->
		<div class="enteredLayer" style="display:none">
			<div>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_completed.png" alt="응모가 완료되었습니다! 당첨되신 고객님께는 회원 정보상의 기본주소로 선풍기가 배송됩니다 개인정보를 업데이트해주세요!" />
				<a href="/my10x10/userinfo/membermodify.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/bnt_check_info.png" alt="내 정보 확인하기" /></a>
				<button type="button" class="btnClose">닫기</button>
			</div>
		</div>
	</form>
	</div>
	<!-- for dev msg // 다른 친구들의 신청 현황 // 5개씩 노출-->
	<div class="enteredList" id="enteredList">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/tit_enteredList.png" alt="다른 친구들의 신청 현황" /></h3>
		<ul>
			<% If cEvtFan.FresultCount < 1 Then %>
			<% Else %>
			<% For i=0 To cEvtFan.FresultCount-1 %>
			<li>
				<span class="num">No.<%= (cEvtFan.FTotalCount - (cEvtFan.FPageCount * cEvtFan.FPageSize)) -i %></span>
				<span class="userContet"><em class="team"><%= cEvtFan.FItemList(i).Fteamname %></em>과(와) 선풍기 <em class="num"><%= cEvtFan.FItemList(i).Fnum %>대</em>를 받고 싶습니다!</span>
				<span class="wirter"><%= printUserId(cEvtFan.FItemList(i).Fuserid,3,"*") %> 님</span>
			</li>
			<% Next %>
			<% End If %>
		</ul>
		<div class="pageWrapV15 tMar20">
			<%= fnDisplayPaging_New_nottextboxdirect(page,cEvtFan.FTotalCount,5,10,"jsGoComPage") %>
		</div>
	</div>
<form method="post" name="frmcom">
<input type="hidden" name="eCode" value="<%=eCode%>">
<input type="hidden" name="page" value="<%=page%>">
</form>
<%
'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
dim snpTitle, snpLink, snpPre, snpTag, snpTag2
snpTitle = Server.URLEncode("[100 프로젝트] 선풍기")
snpLink = Server.URLEncode("http://10x10.co.kr/event/78770")
snpPre = Server.URLEncode("텐바이텐 이벤트")
snpTag = Server.URLEncode("텐바이텐 [100 프로젝트]선풍기")
snpTag2 = Server.URLEncode("#10x10")
''snpImg = Server.URLEncode(emimg)	'상단에서 생성
%>
	<!-- sns 공유 -->
	<div class="shareSns">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_share_sns.png" alt="친구들에게 공유하면 당첨 확률이 올라가요" />
		<div class="fb"><a href="" class="btnFb" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/txt_sns_fb.png" alt="" /></a></div>
	</div>

	<!-- 이벤트 유의사항 -->
	<div class="evntNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78770/tit_evt_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 본 이벤트는 하루에 1번씩만 응모할 수 있습니다.</li>
			<li>- 당첨되신 분들께는 선풍기가 신청하신 수량대로 한 번에 배송됩니다.</li>
			<li>- 정확한 배송을 위해 마이텐바이텐의 개인정보를 업데이트해주세요.</li>
			<li>- 당첨자 발표는 7월 12일(수) 사이트 공지사항에 게시될 예정입니다.</li>
		</ul>
	</div>
</div>
<%
Set cEvtFan = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->