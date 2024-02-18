<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<%
	Dim snpTitle, snpLink, snpPre, snpTag2, snpImg
	snpTitle = URLEncodeUTF8("#Cat&Dog @Cat&Dog No.13 Cat&Dog 텐바이텐의 플레이 그라운드 열세번째 주제,캣 앤 도그")
	snpLink = URLEncodeUTF8("http://www.10x10.co.kr/play/playGround.asp?gidx=13&gcidx=52")
	snpPre = URLEncodeUTF8("텐바이텐 그라운드")
	snpTag2 = URLEncodeUTF8("#Cat&Dog")

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : MAKE YOUR FRIENDS HOME"		'페이지 타이틀 (필수)
	strPageDesc = "텐바이텐 PLAY - MAKE YOUR FRIENDS HOME" 	'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playGround.asp?gidx=13&gcidx=52"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21345
Else
	eCode   =  55957
End If

	Dim sqlStr, pNum, donationCost, graph
	sqlStr = "SELECT COUNT(distinct userid), sum(sub_opt2) from db_event.dbo.tbl_event_subscript where evt_code='" & eCode & "'"
	rsget.Open sqlStr,dbget,1
	IF Not rsget.Eof Then
		pNum = rsget(0)
		donationCost = rsget(1)
	End IF
	rsget.close

	IF pNum="" then pNum=0
	IF isNull(donationCost)  then donationCost=0
	graph = Int( donationCost / 2000000 * 100  )	'게이지바 % 계산

Dim oMileage, availtotalMile
set oMileage = new TenPoint
	oMileage.FRectUserID = getEncLoginUserID
	
if (getEncLoginUserID<>"") then
    oMileage.getTotalMileage

    availtotalMile = oMileage.FTotalMileage
end if

If availtotalMile = "" Then
	availtotalMile = 0
End IF

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
</head>
<% ' 수작업 영역 시작 %>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
<!--
	function keyevt(){
		if(event.keyCode < 48 || event.keyCode > 57){
			alert("숫자만 입력해주세요.");
			window.event.keyCode = 0;
			return false;
		}
	}

	function allcost(){
		if(document.frm1.allin.checked==true){
			document.frm1.dcost.value= <%= availtotalMile %>;
		}
		if(document.frm1.allin.checked==false){
			document.frm1.dcost.value= 0;
		}
	}
	function jsSubmitDonation(frm){
		alert("이벤트가 종료되었습니다");
		return false;
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(frm.dcost.value < 100){
	    alert("기부금액은 100원 이상부터 가능합니다.");
		document.frm1.dcost.value="0";
	    frm.dcost.focus();
	    return false;
	   }

	   document.getElementById("sbtn").style.display="hidden";
	    
	   frm.action = "/event/lib/mileage_process.asp";
	   return true;
	}
//-->
</script>
<style type="text/css">
/* iframe */
body {background-color:#f1efe3;}
.donation {overflow:hidden; width:1140px; margin:0 auto; background-color:#f1efe3;}
.donation .hgroup {float:left; width:380px;}
.donation .hgroup p {margin-top:22px;}
.donation .article {float:left; width:760px;}
.donation .field {position:relative; padding:42px 31px 32px 37px; background-color:#564940;}
.donation .donation-type {position:relative; width:544px;}
.donation .donation-type .mine {display:block;}
.donation .donation-type .mine img {vertical-align:middle;}
.donation .donation-type .mine strong {margin:0 4px 0 28px; color:#ff8c5a; font-size:16px; font-family:'Dotum', 'Verdana'; line-height:1.375em; vertical-align:middle;}
.donation .donation-type .all {margin-top:10px;}
.donation .donation-type .all .check {margin-top:-2px;}
.donation .donation-type .all img {vertical-align:middle;}
.donation .donation-type .fill {position:absolute; top:0; right:0;}
.donation .donation-type .fill input {width:149px; height:38px; margin:0 4px; padding:0 10px; color:#ff7b41; font-size:26px; font-family:'Dotum', 'Verdana'; font-weight:bold; text-align:right;}
.donation .field .btn-submit {position:absolute; top:39px; right:31px;}
.donation .rates {width:544px; margin-top:28px;}
.donation .rates .percent {display:block; width:544px; height:31px; background:url(http://webimage.10x10.co.kr/play/ground/20141027/bg_rates_off.png) no-repeat 0 0;}
.donation .rates .percent span {display:block; height:31px; background:url(http://webimage.10x10.co.kr/play/ground/20141027/bg_rates_on.png) no-repeat 0 0;}
.donation .rates p {position:relative; margin-top:8px;}
.donation .rates p strong {color:#efc8a5; font-size:20px; font-family:'Dotum', 'Verdana'; line-height:1.125em; vertical-align:top;}
.donation .rates p img {margin-top:-2px\9; vertical-align:middle;}
@media screen and (min-width:0\0) {
	.donation .rates p img {margin-top:-2px;}
}
.donation .rates .people {position:absolute; top:0; right:0;}
.donation .rates .people img {vertical-align:top;}
.donation .noti {overflow:hidden; position:relative; z-index:5; width:653px; height:96px; margin-top:30px;}
.donation .noti .bg {position:absolute; left:0; top:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20141027/bg_txt_noti.gif) no-repeat 0 0;}
</style>

<div class="donation">
	<div class="hgroup">
		<h2><img src="http://webimage.10x10.co.kr/play/ground/20141027/tit_donation.gif" alt="당신의 마일리지로 따뜻한 겨울을 만들어 주세요" /></h2>
		<p><img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_date.gif" alt="모금기간은 2014년 10월 27일부터 11월 17일까지입니다." /></p>
	</div>

	<div class="article">
		<div class="field">
			<form name="frm1" method="post" onSubmit="return jsSubmitDonation(this);" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
			<input type="hidden" name="availtotalMile" value="<%=availtotalMile%>">
				<fieldset>
				<legend>마일리지 기부하기</legend>
					<div class="donation-type">
						<% ' for dev msg : 보유마일리지 체크 %>
						<span class="mine">
							<img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_mileage.gif" alt="보유마일리지" />
							<strong><%=FormatNumber(availtotalMile,0)%></strong>
							<img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_won_01.gif" alt="원" />
						</span>

						<% ' for dev msg : 보유 마일리지 전부 기부하기 %>
						<span class="all">
							<input type="checkbox" name="allin" onclick="allcost();" id="donationAll" class="check" />
							<label for="donationAll"><img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_label_all.gif" alt="보유 마일리지 전부 기부하기" /></label>
						</span>

						<% ' for dev msg : 기부 마일리지 입력 %>
						<div class="fill">
							<label for="donationAmount"><img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_amount.gif" alt="기부금액입력" /></label>
							<input type="text" id="donationAmount" name="dcost" onkeypress="keyevt();" value="0"/>
							<img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_won_02.gif" alt="원" />
						</div>
					</div>
					<div class="btn-submit"><span id="sbtn"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20141027/btn_donation.gif" alt="기부하기" /></span></div>
				</fieldset>
			</form>

			<div class="rates">
				<% ' for dev msg : 기부율 퍼센트로 표시 %>
				<span class="percent"><span style="width:<%=graph%>%;"></span></span>
				<p>
					<strong class="present">
						<img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_present.gif" alt="현재" />
						<strong><%=FormatNumber(donationCost,0)%></strong>
						<img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_won_03.gif" alt="원" />
					</strong>

					<strong class="people">
						<strong><%=FormatNumber(pNum,0)%></strong>
						<img src="http://webimage.10x10.co.kr/play/ground/20141027/txt_people.gif" alt="명 참여" />
					</strong>
				</p>
			</div>
		</div>

		<div class="noti">
			<div class="bg"></div>
			<strong>미리 확인하세요!</strong>
			<ul>
				<li>마일리지 기부는 100마일리지 이상부터 기부가 가능하며, 취소 및 환불이 불가합니다.</li>
				<li>ID 당 나눔 동참하기의 횟수 제한은 없으며, 보유하고 계신 마일리지 금액 내에서만 가능합니다. </li>
				<li>고객님의 마일리지 기부금은 동물보호시민단체 KARA의 유기동물 보호소 겨울나기 사업 기금으로 전액 기부됩니다. </li>
				<li>보유하고 계신 마일리지는 기부하기를 누르시면 바로 차감되며, 취소 및 환불 받으실 수 없습니다. </li>
				<li>마일리지가 부족하시구요? 상품구매후기를 작성하시면 마일리지가 적립됩니다 : )</li>
			</ul>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->