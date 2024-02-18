<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2014-01-23이종화 작성 ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21066
Else
	eCode   =  48871
End If

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

	iCPageSize = 12		'한 페이지의 보여지는 열의 수
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

	dim puz(6)
	dim i, n, cnt
	Dim rencolor
	 
	randomize
	for i = 1 to ubound(puz)
		puz(i) = false
	next
	 
	do
		n = int(rnd * 6) + 1
		if not puz(n) then
			puz(n) = true
			cnt = cnt + 1
			rencolor =  rencolor & n & "//"
			if cnt >= 3 then exit do
		end if
	loop
%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.playGr20140127 {background-color:#fffbb9;}
.lovecellIntro {background:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_wave_01.gif) left top repeat-x;}
.lovecellIntro .lovecellIntroInner {width:1140px; margin:0 auto; padding-top:80px; text-align:center;}
.lovecellIntro .lovecellIntroInner p {padding:72px 0 47px;}
.lovecellCase01 {background:#92eebb url(http://webimage.10x10.co.kr/play/ground/20140127/bg_dot_01.gif) left top repeat-x;}
.lovecellCase01 .lovecellCase01Inner {width:1140px; height:700px; margin:0 auto;}
.lovecellCase02 {background:#d5e951 url(http://webimage.10x10.co.kr/play/ground/20140127/bg_dot_02.gif) left top repeat-x;}
.lovecellCase02 .lovecellCase02Inner {width:1140px; height:700px; margin:0 auto;}
.lovecellCase03 {background:#82dfea url(http://webimage.10x10.co.kr/play/ground/20140127/bg_dot_03.gif) left top repeat-x;}
.lovecellCase03 .lovecellCase03Inner {width:1140px; height:700px; margin:0 auto;}
.lovecellCase04 {background:#82dfea url(http://webimage.10x10.co.kr/play/ground/20140127/bg_dot_04.gif) left top repeat-x;}
.lovecellCase04 .lovecellCase04Inner {width:1140px; height:700px; margin:0 auto;}
.lovecellCookies {position:relative; background:#ffe1b7 url(http://webimage.10x10.co.kr/play/ground/20140127/bg_pattern.gif) left top repeat;}
.lovecellCookies .cookies {position:absolute; right:0; top:330px;}
.lovecellCookies .lovecellCookiesInner {width:1140px; margin:0 auto; padding-bottom:50px; text-align:center;}
.lovecellCookies .lovecellCookiesInner {position:relative; padding-top:107px;}
.lovecellCookies .lovecellCookiesInner .medicine {position:absolute; left:50%; top:-15px; margin-left:-173px;}
.lovecellCookies .lovecellCookiesInner h3 {padding-bottom:50px;}
.lovecellMaking {background:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_wave.gif) left top repeat-x;}
.lovecellMakingInner {width:1100px; margin:0 auto; padding-left:40px;}
.lovecellMakingInner h3 {padding:49px 0 90px;}
.lovecellForm {position:relative;}
.lovecellForm p {position:absolute; left:0; top:45px; width:156px; padding-left:2px; padding-bottom:12px; border-bottom:2px solid #ffbbad; color:#fff;}
.lovecellForm ul {overflow:hidden; width:601px; height:214px; margin-left:194px; padding-top:47px; background:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_beaker_fix.png) 10px bottom no-repeat;}
.lovecellForm ul li {float:left; width:205px; text-align:center;}
.lovecellForm ul li.fill {width:176px; padding-left:15px;}
.lovecellForm ul li .iText {display:block; width:94px; height:36px; margin:0 auto 5px; padding:0 5px; background:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_input_text.gif) left top no-repeat; font-size:15px; font-family:Dotum; font-weight:bold; line-height:36px; text-align:center;}
.lovecellForm ul li span {color:#8e2b16; font-size:15px; font-family:Dotum; font-weight:bold;}
.lovecellForm .btnSubmit {position:absolute; right:62px; top:-2px;}
.lovecellMakingList {padding-top:30px; background-color:#fefde5;}
.lovecellMakingList .llovecellMakingListInner {width:1120px; margin:0 auto; padding-bottom:60px; border-top:2px solid #f3e8dd;}
.lovecellList {overflow:hidden; width:1140px; padding-bottom:60px;}
.lovecellList .lovecellBox {float:left; position:relative; width:360px; height:300px; margin:40px 20px 0 0; background:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_comment.png) left top no-repeat;}
.lovecellList .lovecellBox .maker {position:relative; padding:30px 20px 0 40px;}
.lovecellList .lovecellBox .maker strong {color:#f1532e;}
.lovecellList .lovecellBox .maker span {position:absolute; right:20px; top:30px; color:#b29a8a; font-size:11px;}
.lovecellList .lovecellBox ul {overflow:hidden; margin-top:32px; padding-left:37px;}
.lovecellList .lovecellBox ul li {float:left;}
.lovecellList .lovecellBox ul li.spoon {width:105px;}
.lovecellList .lovecellBox ul li.waterdrop {width:80px;}
.lovecellList .lovecellBox ul li.full {width:95px;}
.lovecellList .lovecellBox ul li span {display:block; height:127px; background-repeat:no-repeat;}
.lovecellList .lovecellBox ul li.spoon span {height:54px; margin-top:73px; background-position:21px bottom;}
.lovecellList .lovecellBox ul li.waterdrop span {height:22px;; margin-top:105px; background-position:6px bottom;}
.lovecellList .lovecellBox ul li.full span {background-position:15px bottom;}
.lovecellList .lovecellBox ul li strong {display:block; padding-top:47px; color:#735744; text-align:center;}
.lovecellList .lovecellBox ul li span.color01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_color_01.png);}
.lovecellList .lovecellBox ul li span.color02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_color_02.png);}
.lovecellList .lovecellBox ul li span.color03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_color_03.png);}
.lovecellList .lovecellBox ul li span.color04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_color_04.png);}
.lovecellList .lovecellBox ul li span.color05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_color_05.png);}
.lovecellList .lovecellBox ul li span.color06 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140127/bg_color_06.png);}
.lovecellList .lovecellBox .btnDelete {position:absolute; right:20px; top:66px;}
.lovecellList .lovecellBox .btnDelete button {width:42px; height:18px; background:url(http://webimage.10x10.co.kr/play/ground/20140127/btn_del.gif) left bottom no-repeat; text-indent:-999em; *text-indent:0;}
.lovecellList .lovecellBox .btnDelete button span {*text-indent:-999em;}
.paging a, .paging a.arrow, .paging a.current, .paging a.current:hover {background-color:#fefde5;}
.lovecellDal {background-color:#fefde5;}
.lovecellDal p {width:1120px; margin:0 auto; padding-top:30px; border-top:1px solid #e8e0d8;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
<!--
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

	   if(!frm.qtext1.value||frm.qtext1.value=="다섯글자로"){
	    alert("매력을 입력해주세요");
		document.frmcom.qtext1.value="";
	    frm.qtext1.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.qtext1.value)>10){
			alert('5자 까지 가능합니다.');
	    frm.qtext1.focus();
	    return false;
		}

	   if(!frm.qtext2.value||frm.qtext2.value=="연애세포를"){
	    alert("매력을 입력해주세요");
		document.frmcom.qtext2.value="";
	    frm.qtext2.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.qtext2.value)>10){
			alert('5자 까지 가능합니다.');
	    frm.qtext2.focus();
	    return false;
		}

	   if(!frm.qtext3.value||frm.qtext3.value=="채워보아요"){
	    alert("매력을 입력해주세요");
		document.frmcom.qtext3.value="";
	    frm.qtext3.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.qtext3.value)>10){
			alert('5자 까지 가능합니다.');
	    frm.qtext3.focus();
	    return false;
		}

	   frm.action = "doEventSubscript48871.asp";
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
			if(document.frmcom.qtext1.value =="다섯글자로"){
				document.frmcom.qtext1.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin22(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext2.value =="연애세포를"){
				document.frmcom.qtext2.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin33(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext3.value =="채워보아요"){
				document.frmcom.qtext3.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur11()
	{
		if(document.frmcom.qtext1.value ==""){
			document.frmcom.qtext1.value="다섯글자로";
		}
	}

	function jsChkUnblur22()
	{
		if(document.frmcom.qtext2.value ==""){
			document.frmcom.qtext2.value="연애세포를";
		}
	}

	function jsChkUnblur33()
	{
		if(document.frmcom.qtext3.value ==""){
			document.frmcom.qtext3.value="채워보아요";
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다.");
		obj.value = obj.value.substring(0,maxLength); //200자 이하 튕기기
		}
	}

//-->
</script>
<div class="playGr20140127">
	<div class="lovecellIntro">
		<div class="lovecellIntroInner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_what.png" alt="연애세포가 뭔가요? 먹는 건가요?" /></h3>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20140127/img_love_cell_intro.gif" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_intro_01.gif" alt="텐텐 연애세포 연구소 : 텐텐 연애 세포 연구원들은 각 사용자의 성격과 환경 및 사양을 분석하여 솔로탈출에 적합한 연애세포를 만들고 있습니다." /></p>
		</div>
	</div>

	<div class="lovecellCase01">
		<div class="lovecellCase01Inner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_case_01.gif" alt="연애세포 연구 Case. 1" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_case_01.gif" alt="왜…? 아무런 느낌도 없는 걸까요? 저는 모태솔로 26년차 구요. 소개 팅을 해서 만난 남자와 처음으로 손을 잡았어요. 그런데.. 왜 아무런 느낌도 없는 걸까요? - 무덤덤님의 사연 / 처방 : 두근 두근 1스푼" /></p>
		</div>
	</div>

	<div class="lovecellCase02">
		<div class="lovecellCase02Inner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_case_02.gif" alt="연애세포 연구 Case. 2" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_case_02.gif" alt="왜…? 왜죠? 왜 연락이 없을까요? 분명 분위기도 좋았는데 소개팅 남에게 연락이 오지 않습니다. 왜 연락이 없을까요? 왜.. 왜죠? 그 남자.. 수줍음이 많은 성격이라 그런 걸까요? - 불같애님의 사연 / 처방 : 사랑스러움 10방울" /></p>
		</div>
	</div>

	<div class="lovecellCase03">
		<div class="lovecellCase03Inner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_case_03.gif" alt="연애세포 연구 Case. 3" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_case_03.gif" alt="왜…? 뭐가 부족한 걸까요? 제가 남 이야기를 잘 들어주는 편이라 들어주고 또 들어줬더니 너무 무뚝뚝하대요.. 저에게 뭐가 부족한 걸까요? 애교는 성격상 안 될 것 같고 다른 방법 없을까요? - 러블리걸님의 사연  / 처방 : 물개박수 5초 주르륵" /></p>
		</div>
	</div>

	<div class="lovecellCase04">
		<div class="lovecellCase04Inner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_case_04.gif" alt="연애세포 연구 Case. 4" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_case_04.gif" alt="도대체…? 남자는 어떻게 만나요 ? 저는 여중, 여고, 여대를 나왔어요. 그리고 현재 다니는 회사도 비슷한 분위기입니다. 도대체 남자는 어떻게 만날 수 있을까요? - 안생겨요님의 사연  / 처방 : 음양의 조화 콸콸콸" /></p>
		</div>
	</div>

	<div class="lovecellCookies">
		<div class="cookies"><img src="http://webimage.10x10.co.kr/play/ground/20140127/bg_cookies.png" alt="" /></div>
		<div class="lovecellCookiesInner">
			<p class="medicine"><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_cookies_01.png" alt="이 모든 사례들을 한 번에 극복하게 해줄 치료제" /></p>
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_cookies.png" alt="" /></h3>
			<div>
				<img src="http://webimage.10x10.co.kr/play/ground/20140127/img_love_cell_cookies_02.png" alt="연애세포 쿠기" />
				<img src="http://webimage.10x10.co.kr/play/ground/20140127/img_love_cell_cookies_03.png" alt="연애세포 연구진의 수많은 연구 끝에 완성된 텐바이텐 연애세포 쿠키! " />
			</div>
			<p style="padding-top:58px;"><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_cookies_02.png" alt="텐바이텐 연애세포쿠키는 기획 사은품으로 큰 사이즈 1병(머랭), 작은 사이즈 1병(쿠키)가 함께 배송될 예정입니다. 연애세포 안심하고 맛있게 드세요 : )" /></p>
		</div>
	</div>

	<!-- 나의 연애세포 만들기! -->
	<div class="lovecellMaking">
		<div class="lovecellMakingInner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140127/tit_love_cell_makking.png" alt="나만의 연애세포 만들기!" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_makking_01.png" alt="나의 연애세포엔 무엇을 넣을까? 넣고 싶은 매력을 넣어 당신의 연애세포를 완성하세요! 연애 세포를 만들어 주신 30분을 추첨해 텐바이텐과 DAL.D 스튜디오에서 제작한 연애세포 쿠키를 선물로 드립니다." /></p>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_love_cell_makking_02.png" alt="이벤트 기간 : 2014년 1월 27일 - 2월 10일 당첨자 발표 : 2월 11일" /></p>

			<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
			<input type="hidden" name="txtcommURL" value="<%=rencolor%>">
			<fieldset>
				<legend>나의 연애세포 만들기</legend>
				<div class="lovecellForm">
					<p><strong>다섯 글자로<br /> 연애세포를 채워보세요! <img src="http://webimage.10x10.co.kr/play/ground/20140127/blt_arrow.png" alt="" /></strong></p>
					<ul>
						<li>
							<input type="text" name="qtext1" title="첫번째 연애세포 입력" value="" class="iText" maxlength="5" onClick="jsChklogin11('<%=IsUserLoginOK%>');"/>
							<span>일곱스푼</span>
						</li>
						<li>
							<input type="text" name="qtext2" title="두번째 연애세포 입력" value="" class="iText" maxlength="5" onClick="jsChklogin22('<%=IsUserLoginOK%>');"/>
							<span>다섯방울</span>
						</li>
						<li class="fill">
							<input type="text" name="qtext3" title="세번째 연애세포 입력" value="" class="iText" maxlength="5" onClick="jsChklogin33('<%=IsUserLoginOK%>');"/>
							<span>콸콸콸</span>
						</li>
					</ul>
					<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140127/btn_making.gif" alt="연애세포 완성!" /></div>
				</div>
			</fieldset>
			</form>
			<form name="frmdelcom" method="post" action="doEventSubscript48871.asp" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="Cidx" value="">
			<input type="hidden" name="mode" value="del">
			<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
			</form>
		</div>
	</div>
	<!-- //나의 연애세포 만들기! -->

	<% IF isArray(arrCList) THEN %>
	<!-- 연애세포 만들기 리스트 -->
	<div class="lovecellMakingList">
		<div class="llovecellMakingListInner">
			<div class="lovecellList">
				<% 
						Dim opt1 , opt2 , opt3
						Dim optc1 , optc2 , optc3
						For intCLoop = 0 To UBound(arrCList,2)
						
						If arrCList(1,intCLoop) <> "" then
							opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
							opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
							opt3 = SplitValue(arrCList(1,intCLoop),"//",2)
						End If 

						If arrCList(7,intCLoop) <> "" Then
							optc1 = SplitValue(arrCList(7,intCLoop),"//",0)
							optc2 = SplitValue(arrCList(7,intCLoop),"//",1)
							optc3 = SplitValue(arrCList(7,intCLoop),"//",2)
						End If 

				%>
				<div class="lovecellBox">
					<div class="maker">
						<strong><%=printUserId(arrCList(2,intCLoop),2,"*")%>님의 연애세포</strong>
						<span>No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					</div>
					<ul>
						<li class="spoon">
							<span class="color0<%=optc1%>"></span>
							<strong><%=opt1%></strong>
						</li>
						<li class="waterdrop">
							<span class="color0<%=optc2%>"></span>
							<strong><%=opt2%></strong>
						</li>
						<li class="full">
							<span class="color0<%=optc3%>"></span>
							<strong><%=opt3%></strong>
						</li>
					</ul>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<div class="btnDelete"><button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><span>삭제</span></button></div>
					<% end if %>
				</div>
				<% Next %>
			</div>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
	</div>
	<!-- //연애세포 만들기 리스트 -->
	<% End If %>

	<div class="lovecellDal">
		<p>
			<img src="http://webimage.10x10.co.kr/play/ground/20140127/txt_dal_new.gif" alt="Sweet STUDIO DAL.D / DAL Director. 조은이 : 재미있고 맛있는 쿠키를 연구하는 스튜디오 달디. 달디는 특별한 사연을 바탕으로 단 하나의 특별한 케이크와 쿠키를 만듭니다." usemap="#linkBlog" />
			<map name="linkBlog" id="linkBlog">
				<area shape="rect" coords="876,39,923,59" href="http://www.dal-d.com" target="_blank" title="새창" alt="BLOG" />
				<area shape="rect" coords="930,39,1010,59" href="http://www.facebook.com/sweetstudioDALD" target="_blank" title="새창" alt="FACEBOOK" />
				<area shape="rect" coords="1019,39,1077,60" href="http://www.twitter.com/sweetstudioDALD" target="_blank" title="새창" alt="TWITTER" />
			</map>
		</p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->