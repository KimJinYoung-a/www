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
	snpTitle = URLEncodeUTF8("#Timecapsule @Timecapsule No.3 CARD 텐바이텐의 플레이 그라운드 세번째 주제,CARD")
	snpLink = URLEncodeUTF8("http://www.10x10.co.kr/play/playGround.asp?gidx=3&gcidx=12")
	snpPre = URLEncodeUTF8("텐바이텐 그라운드")
	snpTag2 = URLEncodeUTF8("#Timecapsule")

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : MAKE YOUR FRIENDS HOME"		'페이지 타이틀 (필수)
	strPageDesc = "텐바이텐 PLAY - MAKE YOUR FRIENDS HOME" 	'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playGround.asp?gidx=3&gcidx=12"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21042
Else
	eCode   =  48020
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
		graph = Int( donationCost / 2000000 * 100  )		'% 계산

	If Request.ServerVariables("REMOTE_ADDR") = "61.252.133.75" Then
	Response.Write donationCost
	End If
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





dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	'그룹 번호(엣지1, 초식2, 연하3)

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 10		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'선택범위 리플개수 접수
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
</head>

				<!-- 수작업 영역 시작 -->
		<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$('.petSlide').slidesjs({
				width:1140,
				height:593,
				navigation: {
					effect: "fade"
				},
				pagination:false,
				effect: {
					fade: {
						speed:2000,
						crossfade: true
					}
				  },
				play: {
					interval:4000,
					effect: "fade",
					auto:false
				}
			});
			$('.cmtHome li:nth-child(even)').addClass('type02');
		});

		function scroll(id){
			id = $(id);
			off = id.offset();
			offset = off.top;
			window.parent.$('html,body').animate({scrollTop:offset},800);
		}
		$(function(e) {
			$(".moveScr").click(function(e){
				var scr = $(this).attr("id");
				scroll("#go"+scr);
			});
		});
		</script>
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

		<% If Now() > #01/12/2014 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return false;
		<% Else %>
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
		   frm.action = "/event/lib/mileage_process.asp";
		   return true;
		<% end if %>

	}



 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>


	   if(!frm.txtcomm.value||frm.txtcomm.value=="10자 이내"){
	    alert("코멘트를 입력해주세요");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>20){
			alert('10자 이내');
	    frm.txtcomm.focus();
	    return false;
		}

	   frm.action = "/event/lib/comment_process.asp";
	   return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.txtcomm.value =="10자 이내"){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{
		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value="10자 이내";
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("10자 이내");
		obj.value = obj.value.substring(0,maxLength); //10자 이하 튕기기
		}
	}

//-->
</script>
				<style type="text/css">
				img {vertical-align:top;}
				.groundCont {border-top:1px solid #fff; background:#fff3e3;}
				.groundCont .tagView {width:1100px; margin:0 auto; padding:40px 20px 0;}
				.playGr1223 .tMar30 {margin-top:30px;}
				.playGr1223 .tPad35 {padding-top:35px;}
				.playGr1223 .bPad10 {padding-bottom:10px;}
				.playGr1223 .playGrHead {padding:55px 0 75px; text-align:center; background:#ffe9cb;}
				.playGr1223 .dot {background:url(http://webimage.10x10.co.kr/play/ground/20131223/bg_dot.gif) left bottom repeat-x;}
				.playGr1223 .donationWrap {height:190px; background:#69564e;}
				.playGr1223 .donation {overflow:hidden; width:1100px; padding:0 20px; margin:0 auto;}
				.playGr1223 .donation .dnGoal {float:left; width:675px; padding-top:45px;}
				.playGr1223 .donation .dnGoal .graph {width:674px; height:29px; margin:16px 0 5px; background:url(http://webimage.10x10.co.kr/play/ground/20131223/bg_graph.gif) left top no-repeat;}
				.playGr1223 .donation .dnGoal .graph p {height:29px; background:url(http://webimage.10x10.co.kr/play/ground/20131223/bg_graph_fill.gif) left top no-repeat;}
				.playGr1223 .donation .dnGoal .state {overflow:hidden; font-size:20px; color:#ffeacd; font-style:italic;}
				.playGr1223 .donation .dnGoal .state strong {letter-spacing:1px; padding-right:2px;}
				.playGr1223 .donation .dnGoal .state .money {float:left;}
				.playGr1223 .donation .dnGoal .state .donator {float:right;}
				.playGr1223 .donation .goDonate {float:right; width:420px; padding-top:30px;}
				.playGr1223 .donation .goDonate span {padding-left:10px; cursor:pointer;}

				.playGr1223 .donationInfo {width:1140px; margin:0 auto; padding:140px 0 77px;}
				.playGr1223 .slideWrap {padding-bottom:100px; margin-bottom:105px;}
				.playGr1223 .petSlide {position:relative; width:1140px; height:593px;}
				.playGr1223 .petSlide .slidesjs-navigation {position:absolute; top:262px; z-index:100; display:block; width:72px; height:72px; text-indent:-9999px; background-position:left top; background-repeat:no-repeat;}
				.playGr1223 .petSlide .slidesjs-previous {left:12px; background-image:url(http://webimage.10x10.co.kr/play/ground/20131223/btn_slide_prev.png);}
				.playGr1223 .petSlide .slidesjs-next {right:12px; background-image:url(http://webimage.10x10.co.kr/play/ground/20131223/btn_slide_next.png);}
				.playGr1223 .cardPrd {padding-bottom:110px; margin-bottom:104px;}
				.playGr1223 .mileage {padding-bottom:100px; margin-bottom:100px;}
				.playGr1223 .paging a {background-color:#fff3e3;}
				.playGr1223 .paging a.current:hover {background-color:#fff3e3;}

				.playGr1223 .cmtWrite {overflow:hidden; padding:30px 20px 0 20px; height:150px; background:#ffecd4;}
				.playGr1223 .cmtWrite .tit {float:left; width:155px;}
				.playGr1223 .cmtWrite .writeCont {position:relative; float:right; width:840px;}
				.playGr1223 .cmtWrite .writeCont .period {position:absolute; right:0; top:0px;}
				.playGr1223 .inpTxt {margin-top:18px;}
				.playGr1223 .inpTxt input {vertical-align:top;}
				.playGr1223 .inpTxt .txtBox {width:613px; height:43px; line-height:43px; padding:0 10px; margin-right:4px; font-weight:bold; color:#666; font-size:13px; background:#fff;}
				.playGr1223 .cmtHome {overflow:hidden; width:100%; margin-top:77px;}
				.playGr1223 .cmtHome ul {overflow:hidden; width:1158px; padding-left:20px; margin:0 -38px 30px 0;}
				*:first-child+html .playGr1223 .cmtHome ul {margin-bottom:83px;}
				.playGr1223 .cmtHome li {position:relative; float:left; width:190px; height:125px; padding-top:83px; margin:0 38px 53px 0; font-size:13px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20131223/bg_cmt_home01.gif) left top no-repeat;}
				.playGr1223 .cmtHome li.type02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20131223/bg_cmt_home02.gif)}
				.playGr1223 .cmtHome li .txt {display:table-cell; width:82px; height:55px; vertical-align:middle; padding:0 54px; line-height:20px; font-weight:bold; color:#353535;}
				.playGr1223 .cmtHome li .writer {position:absolute; left:0; top:148px; width:100%; color:#6f5e49;}
				.playGr1223 .cmtHome li .writer .num {display:block; color:#b79882;}

				.playGr1223 .mileage {padding-left:270px; background:url(http://webimage.10x10.co.kr/play/ground/20131223/bg_home_logo.gif) left top no-repeat;}
				.playGr1223 .mileage .mgDonate {overflow:hidden; padding:0 28px; height:185px; background:#69564e;}
				.playGr1223 .mileage .mgDonate img {vertical-align:top;}
				.playGr1223 .mileage .mgDonate .myMg {float:left; width:274px; padding-top:53px;}
				.playGr1223 .mileage .mgDonate .myMg span {position:relative; top:-2px; display:inline-block; font-weight:bold; padding-left:8px; color:#f9af91; font-size:15px; line-height:15px;}
				.playGr1223 .mileage .mgDonate .inpMg {float:left; padding-top:38px;}
				.playGr1223 .mileage .mgDonate .inpMg input {vertical-align:top;}
				.playGr1223 .mileage .mgDonate .inpMg .cost {height:39px; margin:0 3px; border:1px solid #604a41; }
				.playGr1223 .mileage .mgDonate .inpMg .cost input {width:174px; height:37px; padding:0 5px; border:1px solid #f6f5f5; font-size:36px; font-weight:bold; text-align:right; color:#ff8651;}
				.playGr1223 .mileage .mgDonate .btnMg {float:right; padding-top:28px;}
				</style>
				<div class="groundCont" style="border-top:0;">

					<div class="grArea" style="width:100%">
						<div class="playGr1223">
							<div class="playGrHead">
								<p><img src="http://webimage.10x10.co.kr/play/ground/20131223/img_ground_head.gif" alt="MAKE YOUR FRIENDS HOME" /></p>
								<p class="tPad35 bPad10"><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_home_complete.gif" alt="여러분들의 응원과 기부로 용인 꽁꽁이네 아이들에게 새 집이 생겼어요~" /></p>
								<a href="http://ekara.org/board/bbs/board.php?bo_table=community01&wr_id=2952" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20131223/btn_view_home.gif" alt="기부 이후 자세한 공사내용 살펴보기" /></a>
							</div>
							<!-- 기부현황 -->
							<div class="donationWrap">
								<div class="donation">
									<div class="dnGoal">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_goal.gif" alt="모금기간  2013.12.23 ~ 2014.1.1 / 목표금액  2,000,000원" /></p>
										<div class="graph">
											<p style="width:<%=graph%>%"><!-- 모금액에 따라 width 값이 늘어납니다. --></p>
										</div>
										<div class="state">
											<p class="money"><strong><%=FormatNumber(donationCost,0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_money.gif" alt="원 모금" /></p>
											<p class="donator"><strong><%=FormatNumber(pNum,0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_donator.gif" alt="명 참여" /></p>
										</div>
									</div>
									<div class="goDonate">
										<span class="moveScr" id="mileage"><img src="http://webimage.10x10.co.kr/play/ground/20131223/btn_go_mileage.gif" alt="마일리지 기부하러가기" /></span>
										<span class="moveScr" id="product"><img src="http://webimage.10x10.co.kr/play/ground/20131223/btn_go_product.gif" alt="기부상품 보러가기" /></span>
										<span class="moveScr" id="comment"><img src="http://webimage.10x10.co.kr/play/ground/20131223/btn_go_comment.gif" alt="코멘트 작성하러 가기" /></span>
									</div>
								</div>
							</div>
							<!--// 기부현황 -->


							<div class="donationInfo dot">
								<!-- 기부 과정 및 방법 -->
								<div class="happyDonation">
									<p style="padding-bottom:92px;"><img src="http://webimage.10x10.co.kr/play/ground/20131223/img_donate_info01.gif" alt="모두가 행복하고 따뜻한 겨울 나기" /></p>
									<div class="slideWrap dot">
										<div class="petSlide">
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_slide_pet01.jpg" alt="" />
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_slide_pet02.jpg" alt="" />
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_slide_pet03.jpg" alt="" />
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_slide_pet04.jpg" alt="" />
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_slide_pet05.jpg" alt="" />
										</div>
										<p>
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_kara.gif" alt="유기견의 따뜻한 겨울나기 프로젝트는 동물보호 시민단체 KARA의‘겨울용 견사 제작’사업과 함께 합니다." usemap="#goKara" />
											<map name="goKara" id="goKara">
												<area shape="rect" coords="1010,7,1138,47" href="http://www.ekara.org/" target="_blank" />
											</map>
										</p>
									</div>
									<div class="cardPrd dot" id="goproduct">
										<p>
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_donate_info02.gif" alt="카드구매로 기부참여하는 방법" usemap="#Map01" />
											<map name="Map01" id="Map01">
												<area shape="rect" coords="763,1,1046,29" href="/street/street_brand_sub06.asp?makerid=ttableoffice" target="_top" alt="Design by ttable-office 브랜드 보러가기" />
											</map>
										</p>
										<p style="padding-top:80px;">
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_donate_info03.jpg" alt="CARD" usemap="#Map02" />
											<map name="Map02" id="Map02">
												<area shape="rect" coords="1009,6,1116,35" href="/shopping/category_prd.asp?itemid=978986" target="_top" alt="상품 보러가기" />
											</map>
										</p>
										<p style="padding-top:110px;">
											<img src="http://webimage.10x10.co.kr/play/ground/20131223/img_donate_info04.jpg" alt="MOBILE" usemap="#Map03" />
											<map name="Map03" id="Map03">
												<area shape="rect" coords="1009,6,1116,35" href="/shopping/category_prd.asp?itemid=978987" target="_top" alt="상품 보러가기" />
											</map>
										</p>
									</div>
									<!-- 마일리지 기부하기 -->
									<div class="dot">
									<form name="frm1" method="post" onSubmit="return jsSubmitDonation(this);" style="margin:0px;">
									<input type="hidden" name="eventid" value="<%=eCode%>">
									<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
									<input type="hidden" name="availtotalMile" value="<%=availtotalMile%>">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20131223/img_mileage_info.gif" alt="마일리지로 기부참여하는 방법" /></p>
										<div class="mileage" id="gomileage">
											<div class="mgDonate">
												<div class="myMg">
													<img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_mileage01.gif" alt="보유 마일리지" />
													<span><%=FormatNumber(availtotalMile,0)%></span>
													<img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_mileage02.gif" alt="원" />
												</div>
												<div class="inpMg">
													<p>
														<img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_mileage03.gif" alt="기부금액입력" />
														<span class="cost"><input type="text" name="dcost" onkeypress="keyevt();" value="0" /></span>
														<img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_mileage04.gif" alt="원" />
													</p>
													<p style="padding:7px 0 0 100px;"><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_mileage05.gif" alt="직접 입력해 주신 금액이 기부됩니다." /></p>
													<p class="tMar30">
														<input type="checkbox" name="allin" onclick="allcost();" id="whole" />
														<label for="whole"><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_mileage06.gif" alt="원" /></label>
													</p>
												</div>
												<div class="btnMg"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20131223/btn_donate.gif" alt="기부하기" /></div>
											</div>
											<p style="padding:23px 0 0 30px;"><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_donate_tip.gif" alt="미리 확인하세요!" /></p>
										</div>
									</form>
									</div>
									<!--// 마일리지 기부하기 -->
								</div>
								<!--// 기부 과정 및 방법 -->


								<!-- 코멘트 -->
								<div class="yourWinter" id="gocomment">
								<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
								<input type="hidden" name="eventid" value="<%=eCode%>">
								<input type="hidden" name="bidx" value="<%=bidx%>">
								<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
								<input type="hidden" name="iCTot" value="">
								<input type="hidden" name="mode" value="add">
								<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
									<!-- 코멘트 작성 -->
									<div class="cmtWrite">
										<p class="tit"><img src="http://webimage.10x10.co.kr/play/ground/20131223/tit_cmt.gif" alt="COMMENT EVENT" /></p>
										<div class="writeCont">
											<p><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_cmt_winter.gif" alt="COMMENT EVENT" /></p>
											<p class="period"><img src="http://webimage.10x10.co.kr/play/ground/20131223/txt_cmt_period.gif" alt="COMMENT EVENT" /></p>
											<p class="inpTxt">
												<input type="text" name="txtcomm" maxlength="10" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>  autocomplete="off" class="txtBox" value="10자 이내" />
												<input type="image" src="http://webimage.10x10.co.kr/play/ground/20131223/btn_cmt_apply.gif" />
											</p>
										</div>
									</div>
									<!--// 코멘트 작성 -->
								</form>
								<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
								<input type="hidden" name="eventid" value="<%=eCode%>">
								<input type="hidden" name="bidx" value="<%=bidx%>">
								<input type="hidden" name="Cidx" value="">
								<input type="hidden" name="mode" value="del">
								<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
								</form>
									<!-- 코멘트 리스트 -->
								<% IF isArray(arrCList) THEN %>
									<div class="cmtHome">
										<ul>
										<% For intCLoop = 0 To UBound(arrCList,2)%>
											<li>
												<p class="txt"><%=db2html(arrCList(1,intCLoop))%>  <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>&nbsp;&nbsp;<a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>')" class="btn btnS6 btnGry2 fn">삭제</a><% End If %></p>
												<p class="writer">
													<span class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
													<span><strong><%=printUserId(arrCList(2,intCLoop),2,"*")%></strong> 님</span>
												</p>
											</li>
										<% Next %>
										</ul>
										<div class="pageWrapV15">
											<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
										</div>
									</div>
								<% End If %>
									<!--// 코멘트 리스트 -->
								</div>
								<!--// 코멘트 -->
							</div>




						</div>
				<!-- 수작업 영역 끝 -->

<!-- #include virtual="/lib/db/dbclose.asp" -->