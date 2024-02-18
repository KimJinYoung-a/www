<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  Wedding Membership
' History : 2016.09.12 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
Dim vGubun, i, evt_code, userid, totalbonuscouponcountusingy

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66201
Else
	evt_code   =  73007
End If

dim subscriptcount, subscriptcountsub
subscriptcount=0
subscriptcountsub=0
totalbonuscouponcountusingy=0

'' 실섭 899,900,901,902,903
'' 테섭 2809,2810,2811,2812,2813
		
'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(evt_code, userid, "", "", "")
	subscriptcountsub = getevent_subscriptexistscount(evt_code, userid, "subevt", "", "")
	totalbonuscouponcountusingy = getbonuscoupontotalcount("899,900,901,902,903", "N", "Y","")
end if

%>
<style type="text/css">
img {vertical-align:top;}
.weddingMembership {background:#fbf4ee url(http://webimage.10x10.co.kr/eventIMG/2016/73007/bg_body.png) repeat-x 0 0;}
.weddingCont {position:relative; width:1140px; margin:0 auto;}
.weddingHead {position:relative; width:1140px; height:485px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73007/bg_flower.png) no-repeat 50% 38px;}
.weddingHead h2 {position:absolute; left:50%; top:202px; width:482px; height:189px; margin-left:-241px;}
.weddingHead h2 span {display:block; position:absolute; left:0; width:100%; height:95px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73007/tit_membership.png) no-repeat 0 0; text-indent:-999em;}
.weddingHead h2 span.t1 {top:0;}
.weddingHead h2 span.t2 {bottom:0; background-position:0 100%;}
.weddingHead p {position:absolute;}
.weddingHead .date {right:15px; top:30px;}
.weddingHead .story {left:50%; top:142px; margin-left:-127px;}
.weddingHead .with {left:50%; top:418px; margin-left:-192px;}
.weddingHead .goSmall {left:10px; top:37px;}
.weddingEvt .weddingCont {width:1155px; margin:0 auto;}
.weddingEvt .addFile {height:30px; background-color:#fff;}
.weddingEvt.event1 {padding-bottom:65px;}
.weddingEvt.event1 .btnEnroll {position:absolute; right:160px; top:230px;}
.weddingEvt.event1 #writeInvitation {display:none; width:1000px; margin:0 auto; padding-top:25px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73007/blt_arrow.png) no-repeat 50% 0;}
.weddingEvt.event1 #writeInvitation dl {overflow:hidden; padding:28px 0; font-weight:bold; border-top:1px solid #efedeb;}
.weddingEvt.event1 #writeInvitation dl:first-child {border-top:0;}
.weddingEvt.event1 #writeInvitation dt {float:left; width:120px; padding-left:20px; line-height:30px;}
.weddingEvt.event1 #writeInvitation dt img {vertical-align:middle;}
.weddingEvt.event1 #writeInvitation dd {float:left; width:320px; line-height:30px;}
.weddingEvt.event1 #writeInvitation dd img {vertical-align:middle;}
.weddingEvt.event1 #writeInvitation dd input[type="text"] {height:30px; padding:0 10px; font-weight:bold; border:1px solid #ddd; vertical-align:middle;}
.weddingEvt.event1 #writeInvitation dd span {display:inline-block; padding-left:20px;}
.weddingEvt.event1 #writeInvitation .policy {padding:0; margin-top:22px;}
.weddingEvt.event1 #writeInvitation .policy .txt {overflow-y:auto; width:393px; height:160px; margin-bottom:15px; padding:0 25px 15px; border:1px solid #ddd; background:#fff;}
.weddingEvt.event1 #writeInvitation .policy .txt h4 {padding:20px 0 10px}
.weddingEvt.event2 {padding-bottom:87px;}
.weddingEvt.event2 .attachPhoto {position:relative;}
.weddingEvt.event2 .attachPhoto dl {position:absolute; left:560px; top:377px; width:478px;text-align:left;}
.weddingEvt.event2 .attachPhoto .btnSubmit {position:absolute; right:0; top:0;}
.evtNoti {padding:52px 0; text-align:left; background:#eae3dd;}
.evtNoti h3 {position:absolute; left:82px; top:50%; margin-top:-12px;}
.evtNoti ul {padding-left:354px;}
.evtNoti li {color:#868686; line-height:26px; text-indent:-10px; padding-left:10px;}
</style>
<script>
$(function(){
	titleAnimation()
	$(".weddingHead .story").css({"margin-top":"10px","opacity":"0"});
	$(".weddingHead h2 .t1").css({"margin-left":"10px","opacity":"0"});
	$(".weddingHead h2 .t2").css({"margin-left":"-10px","opacity":"0"});
	$(".weddingHead .with").css({"opacity":"0"});
	function titleAnimation() {
		$(".weddingHead .story").delay(10).animate({"margin-top":"-5px","opacity":"1"},800).delay(10).animate({"margin-top":"0"},600);
		$(".weddingHead h2 .t1").delay(400).animate({"margin-left":"0","opacity":"1"},700);
		$(".weddingHead h2 .t2").delay(400).animate({"margin-left":"0","opacity":"1"},700);
		$(".weddingHead .with").delay(1000).animate({"opacity":"1"},800);
	}
	function swing1 () {
		$(".weddingHead .goSmall").animate({"margin-top":"10px"},900).animate({"margin-top":"0"},900, swing1);
	}
	function swing2 () {
		$(".event1 .btnEnroll").animate({"margin-top":"5px"},800).animate({"margin-top":"0"},800, swing2);
	}
	swing1();
	swing2();

	// 청첩장 open
	$(".event1 .btnEnroll").click(function(){
		$("#writeInvitation").slideDown();
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});

function frmSubmit() {
	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/16/2016 23:59:59# Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% Else %>
			<% if subscriptcount < 1 then %>
				var frm = document.frmApply;

				// 내 이름
				if (frm.myArea1.value == '' || frm.myArea1.value == 'ex) 홍길동'){
					alert("본인 이름을 입력해 주세요.");
					frm.myArea1.value = '';
					frm.myArea1.focus();
					return;
				}

				//배우자 이름
				if (frm.myArea2.value == '' || frm.myArea2.value == 'ex) 홍길동'){
					alert("배우자 이름을 입력해 주세요.");
					frm.myArea2.value = '';
					frm.myArea2.focus();
					return;
				}

				//결혼 예정일
				if (frm.myArea3.value == ''){
					alert("결혼 예정일을 입력해 주세요");
					frm.myArea3.focus();
					return;
				}

				if (frm.myArea3.value == '' || GetByteLength(frm.myArea3.value) > 4 || frm.myArea3.value == '0000'){
					alert("결혼 예정일을 숫자로 4자리로 입력해 주세요.");
					frm.myArea3.focus();
					return;
				}

				// 체크 되어 있는지 확인
				var checkCnt = $("input[name=agreecheck]:checked").size();
				var checkval = $("input[name=agreecheck]:checked").val() ;
				if(checkCnt == 0) {
					alert("동의하지 않으면 응모하실 수 없습니다.");
					frm.agreecheck.focus();
					return;
				}else{
					if(checkval == '') {
						alert("개인정보 취급 방침에 동의 하셔야 응모 가능 합니다.");
						frm.agreecheck.focus();
						return;
					}
				}
				//* 파일 확장자 체크
				for(var ii=1; ii<2; ii++)
				{
					var frmname		 = eval("frm.imgfile"+ii+"");
			
					if(frmname.value != "")
					{
						var sarry        = frmname.value.split("\\");
						var maxlength    = sarry.length-1;
						var ext = sarry[maxlength].split(".");
			
						if(ext[1].toLowerCase() == "jpg" || ext[1].toLowerCase() == "png"){
							
						}else{
							alert('jpg나png파일만 가능 합니다.');
							return;
						}
					}
					else
					{
						alert('청첩장 이미지 파일을 등록해 주세요.');
						return;
					}
				}

				frm.optname.value = frm.myArea1.value+"/!/"+frm.myArea2.value+"/!/N";
				frm.mode.value = 'addreg';
				frm.submit();
		   <% else %>
				alert("이미 응모 하셨습니다.");
				return;
			<% end if %>
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsCheckLimit(textgb) {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
	if (textgb =='ta1'){
		if (document.frmApply.myArea1.value == 'ex) 홍길동'){
			document.frmApply.myArea1.value = '';
		}
	}else if(textgb =='ta2'){
		if (document.frmApply.myArea2.value == 'ex) 홍길동'){
			document.frmApply.myArea2.value = '';
		}
	}else if(textgb =='ta3'){
		if (document.frmApply.myArea3.value == '0000'){
			document.frmApply.myArea3.value = '';
		}
	}else{
		alert('잠시 후 다시 시도해 주세요');
		return;
	}
}

function maxLengthCheck(object){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}

function frmSubmitevt2() {

	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/16/2016 23:59:59# Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% Else %>
			<% if subscriptcount > 0 then %>
				var frm = document.frmApplyevt;

				//* 파일 확장자 체크
				for(var ii=1; ii<2; ii++)
				{
					var frmname		 = eval("frm.imgfile"+ii+"");

					if(frmname.value != "")
					{
						var sarry        = frmname.value.split("\\");
						var maxlength    = sarry.length-1;
						var ext = sarry[maxlength].split(".");
			
						if(ext[1].toLowerCase() == "jpg" || ext[1].toLowerCase() == "png"){
							
						}else{
							alert('jpg나png파일만 가능 합니다.');
							return;
						}
					}
					else
					{
						alert('웨딩사진 파일을 등록해 주세요.');
						return;
					}
				}

				frm.mode.value = 'addevt';
				frm.submit();
		   <% else %>
				alert("이미 응모 하셨습니다.");
				return;
			<% end if %>
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}
</script>
	<!-- WEDDING MEMBERSHIP -->
	<div class="evt73007 weddingMembership">
		<div class="weddingHead">
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_date.png" alt="이벤트기간 : 2016.09.19 – 10.16" /></p>
			<p class="story"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_precious.png" alt="소중한 나의 웨딩 스토리" /></p>
			<h2>
				<span class="t1">Wedding</span>
				<span class="t2">Membership</span>
			</h2>
			<p class="with"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_with_membership.png" alt="텐바이텐이 드리는 특별한 혜택! 웨딩멤버십과 함께하세요!" /></p>
			<p class="goSmall"><a href="/event/eventmain.asp?eventid=72792"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/btn_small_wedding.png" alt="웨딩기획전 바로가기" /></a></p>
		</div>

		<!-- event1 청첩장 등록 -->
		<div class="weddingEvt event1">
			<div class="weddingCont">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_event_1.png" alt="EVENT1.청첩장을 등록해주세요! 웨딩쿠폰 5종세트를 드립니다!" /></div>
				<a href="#writeInvitation" class="btnEnroll"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/btn_register.png" alt="청첩장 등록하기" /></a>
			</div>

			<form name="frmApply" method="POST" action="<%=staticImgUpUrl%>/linkweb/enjoy/73007_Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
			<input type="hidden" name="mode" value="">
			<input type="hidden" name="userid" value="<%= userid %>">
			<input type="hidden" name="optname" value="">
			<input type="hidden" name="device" value="W">
			<div id="writeInvitation">
				<h3 class="lt bPad20"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/tit_enroll.png" alt="청첩장 등록" /></h3>
				<div class="overHidden">
					<div class="ftLt" style="width:465px;">
						<dl>
							<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_myinfo.png" alt="나의정보" /></dt>
							<dd>
								<p>
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_id.png" alt="아이디" />
									<span>
										<% IF NOT(IsUserLoginOK) THEN %><% else %><%= userid %><% END IF %>
									</span>
								</p>
								<p>
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_name.png" alt="이름" />
									<span>
										<input type="text" id="myName" name="myArea1" onClick="jsCheckLimit('ta1');" onKeyUp="jsCheckLimit('ta1');" <% IF NOT(IsUserLoginOK) THEN %>value="ex) 홍길동"<% else %>value="ex) 홍길동"<% END IF %> style="width:220px;" />
									</span>
								</p>
							</dd>
						</dl>
						<dl>
							<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_partner.png" alt="배우자 정보" /></dt>
							<dd>
								<p>
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_name.png" alt="이름" />
									<span>
										<input type="text" id="spouseName" name="myArea2" onClick="jsCheckLimit('ta2');" onKeyUp="jsCheckLimit('ta2');" <% IF NOT(IsUserLoginOK) THEN %>value="ex) 홍길동"<% else %>value="ex) 홍길동"<% END IF %> style="width:220px;" />
									</span>
								</p>
								<em><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_desc_1.png" alt="※ 청첩장 정보와 일치여부 판단하기 위해 기입" /></em>
							</dd>
						</dl>
						<dl>
							<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_duedate.png" alt="결혼(예정)일" /></dt>
							<dd>
								<p>2016년 
									<span style="padding-left:8px;">
										<input type="number" id="weddingDate" placeholder="0000" onkeydown="return showKeyCode(event)" oninput="maxLengthCheck(this)" maxlength = "4" name="myArea3" onClick="jsCheckLimit('ta3');" onKeyUp="jsCheckLimit('ta3');" style="width:40px;" <% IF NOT(IsUserLoginOK) THEN %>value="로그인을 해주세요."<% else %>value="0000"<% END IF %>/>
									</span>
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_desc_2.png" alt="※ 예시: 9월 01일 ▶ 0901 으로 기입" class="lPad10" />
								</p>
							</dd>
						</dl>
						<dl>
							<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_attach_invite.png" alt="청첩장 첨부" /></dt>
							<dd>
								<p>
									<input type="file" id="weddingInvitation" name="imgfile1" class="addFile" />
								</p>
								<em><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_desc_3.png" alt="※ 최대 2MB, JPG(JPEG)파일" /></em>
							</dd>
						</dl>
					</div>
					<div class="ftRt" style="width:450px;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_notice.png" alt="공지사항" /></p>
						<div class="policy">
							<div class="txt">
								<h4>[수집하는 개인정보 항목 및 수집방법]</h4>
								<div>1. 수집하는 개인정보의 항목<br/>① 회사는 회원가입시 원할한 고객상담, 각종 서비스의 제공을 위해 아래와 같은 최소한의 개인정보를 필수항목을 수집하고 있습니다. - 아이디, 비밀번호, 이름, 성별, 생년월일, 이메일주소, 휴대폰번호, 가입인증정보<br/>② 서비스 이용과정이나 사업 처리과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.<br />- 최근접속일, 접속 IP 정보, 쿠키, 구매로그, 이벤트로그<br />- 물품 주문시 : 이메일주소, 전화번호, 휴대폰번호, 주소<br />- 물품(서비스)구매에 대한 결제 및 환불시 : 은행계좌정보<br />개인맞춤서비스 이용시 : 주소록, 기념일<br /><br />2. 개인정보 수집에 대한 동의<br />회사는 귀하께서 텐바이텐의 개인정보취급방침 및 이용약관의 내용에 대해 「동의한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다. 「동의안함」을 선택하실 경우, 회사가 제공하는 기본서비스 제공이 제한됩니다.</div>
								<h4>[개인정보의 수집목적 및 이용 목적]</h4>
								<div>① 회원제 서비스 이용에 따른 본인 식별 절차에 이용<br />② 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보, 새로운 서비스, 신상품이나 이벤트 정보 등 최신 정보의 안내<br />③ 쇼핑 물품 배송에 대한 정확한 배송지의 확보<br />④ 개인맞춤 서비스를 제공하기 위한 자료<br />⑤ 경품 수령 및 세무신고를 위한 별도의 개인정보 요청</div>
								<h4>[개인정보의 보유, 이용기간]</h4>
								<div>2. 위 개인정보 수집목적 달성시 즉시파기 원칙에도 불구하고 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등에 근거하여 일정기간 보유합니다.<br />① 「전자상거래 등에서의 소비자보호에 관한 법률」에 의한 보관<br />- 계약 또는 청약철회 등에 관한 기록 : 5년<br />- 대금결제 및 재화 등의 공급에 관한 기록 : 5년<br />- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년<br />② 「통신비밀보호법」 시행령 제41조에 의한 통신사실확인자료 보관 - 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월<br />③ 설문조사, 이벤트 등 일시적 목적을 위하여 수집한 경우 : 당해 설문조사, 이벤트 등의 종료 시점</div>
								<h4>[개인정보의 파기 절차]</h4>
								<div>회사는 원칙적으로 개인정보 수집 및 이용목적이 달성되면 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.<br />1. 파기절차<br />① 귀하가 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(제6조 개인정보의 보유, 이용기간 참조) 일정 기간 저장된 후 파기되어집니다.<br />② 동 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.<br />2. 파기방법 <br />① 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.<br />② 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</div>
							</div>
							<p>
								<input type="radio" id="agreeY" value="Y" name="agreecheck" />
								<label for="agreeY">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_agree.png" alt="텐바이텐 개인정보취급방침에 따라, 본 이벤트 참여를 위한 개인정보 취급방침에 동의합니다." />
								</label>
							</p>
						</div>
					</div>
				</div>
				<div class="ct tPad30">
					<p class="bPad05"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_desc_4.png" alt="상단의 공지사항을 꼭 확인 후 제출하세요." /></p>
					<input type="image" onclick="frmSubmit(); return false;" class="btnSubmit" src="http://webimage.10x10.co.kr/eventIMG/2016/73007/btn_send.png" alt="청첩장 제출하기" />
				</div>
			</div>
			</form>
		</div>
		<!--// event1 청첩장 등록  -->

		<!-- event2 -->
		<div class="weddingEvt event2">
			<div class="weddingCont">
				<% '' 청첩장 등록 안했을 경우 %>
				<% if subscriptcount < 1 then %>
					<div>
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_event_2_default.png" alt="EVENT2.웨딩사진을 등록해주세요!  겨울엔 토스트가 좋아에서 5명을 추첨해 여러분의 웨딩사진을 그려드립니다." />
					</div>
				<% else %>
					<form name="frmApplyevt" method="POST" action="<%=staticImgUpUrl%>/linkweb/enjoy/73007_Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="">
					<input type="hidden" name="userid" value="<%= userid %>">
					<input type="hidden" name="optname" value="">
					<input type="hidden" name="device" value="W">
						<% '' 청첩장 등록 했을 경우 %>
						<div class="attachPhoto">
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_event_2.png" alt="EVENT2.웨딩사진을 등록해주세요!  겨울엔 토스트가 좋아에서 5명을 추첨해 여러분의 웨딩사진을 그려드립니다." /></div>
							<% if subscriptcountsub < 1 then %>
								<dl>
									<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_attach_photo.png" alt="청첩장 첨부" /></dt>
									<dd class="tPad10 lPad15">
										<input type="file" id="weddingInvitation" name="imgfile1" class="addFile" />
										<p class="tPad10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/txt_desc_3.png" alt="※ 최대 2MB, JPG(JPEG)파일" /></p>
										<input type="image" onclick="frmSubmitevt2(); return false;" class="btnSubmit" src="http://webimage.10x10.co.kr/eventIMG/2016/73007/btn_photo.png" alt="사진 제출하기" />
									</dd>
								</dl>
							<% end if %>
						</div>
					</form>
				<% end if %>
			</div>
		</div>
		<!--// event2 -->
		<div class="evtNoti">
			<div class="weddingCont">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/73007/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>- 2016년 9월 1일 ~ 11월 30일 까지 결혼일(예정일)인 고객은 모두 이벤트에 참여 가능합니다.</li>
					<li>- 청첩장의 내용이 기입한 정보와 일치할 경우, 웨딩쿠폰은 청첩장 등록일 익일 2시 해당 ID로 자동 지급됩니다.<br />(단, 금/토/일 등록자는 월요일 오후 2시 일괄 지급)</li>
					<li>- 웨딩사진은 EVENT1 참여자에 한해 참여 할 수 있습니다.</li>
					<li>- EVENT2는 5만원 이상 사은품으로 당첨자에게는 텐바이텐 고객센터를 통해 개인정보 요청 예정입니다. (제세공과금은 텐바이텐 부담)</li>
					<li>- 해당 이벤트에 기입한 정보는 비공개이며, 이벤트 종료 후 파기됩니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!--// WEDDING MEMBERSHIP -->
<!-- #include virtual="/lib/db/dbclose.asp" -->