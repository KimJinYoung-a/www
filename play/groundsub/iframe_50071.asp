<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg

	snpTitle = URLEncodeUTF8("No.6 Memo it 03.야근수당 야근 - 야금 까먹자!")
	snpLink = URLEncodeUTF8("http://10x10.co.kr/play/playGround.asp?gidx=6&gcidx=23")
	snpPre = URLEncodeUTF8("텐바이텐 그라운드")
	snpTag = URLEncodeUTF8("텐바이텐 " & Replace("#6 Memo it 03.야근수당 야근 - 야금 까먹자!"," ",""))
	snpTag2 = URLEncodeUTF8("#10x10")
	snpImg = URLEncodeUTF8("http://webimage.10x10.co.kr/play/beforeimg/201403/beforeimg20140314100435.JPEG")

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 그라운드"		'페이지 타이틀 (필수)
	strPageDesc = "텐바이텐 PLAY - GROUND #6 Memo it 03.야근수당 야근 - 야금 까먹자!" 		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/play/beforeimg/201403/beforeimg20140314100435.JPEG"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://10x10.co.kr/play/playGround.asp?gidx=6&gcidx=23"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'#### 2014-03-14 이종화 작성 play_sub ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21113
Else
	eCode   =  50071
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 9		'한 페이지의 보여지는 열의 수
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
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {background-color:#ffefb3;}
.groundCont {position:relative; min-width:1140px;}
.groundCont .grArea {width:100%; background:#f1eedd;}
.groundCont .tagView {width:1100px; padding:60px 20px;}
.playGr20140317 {width:100%; background-color:#ffefb3;}
.playGr20140317 .memo03Head {padding:74px 0 88px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_dash_line.gif) center bottom no-repeat #fbfbfb;}
.playGr20140317 .applyEvtWrap {padding:90px 0 70px; background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_dash_line.gif) center bottom no-repeat #f1eedd;}
.playGr20140317 .applyEvt {width:100%; background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_dash_line.gif) center 1132px no-repeat;}
.playGr20140317 .approval {position:relative; width:1000px; height:1082px; margin:0 auto 55px; background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_approval.png) left top no-repeat;}
.playGr20140317 .approval .doc {width:861px; margin:0 auto; padding-top:55px;}
.playGr20140317 .approval .doc table {width:859px; color:#1e1e1e; margin-top:8px;}
.playGr20140317 .approval .doc table th {padding:12px 0; font-weight:bold; text-align:center; border:1px solid #bbb; background:#e6e6e6;}
.playGr20140317 .approval .doc table td {padding:12px 28px; text-align:left; border:1px solid #bbb; background:#fff;}
.playGr20140317 .approval .share {position:absolute; left:62px; bottom:90px; overflow:hidden; width:600px;}
.playGr20140317 .approval .share dt {float:left; width:130px; line-height:13px; text-align:right; font-weight:bold; color:#1e1e1e;}
.playGr20140317 .approval .share dd {float:left; width:425px; padding-left:35px; font-size:11px; line-height:12px;}
.playGr20140317 .approval .share dd p {padding-bottom:10px; color:#5c5c5c;}
.playGr20140317 .approval .share dd.snsBtn {position:absolute; left:43px; top:25px;}
.playGr20140317 .approval .selectEnergy {overflow:hidden; padding:18px 0 18px 70px;}
.playGr20140317 .approval .selectEnergy li {float:left; width:70px; padding:0 18px; text-align:center;}
.playGr20140317 .approval .selectEnergy li span {display:block; width:70px; height:77px; margin-bottom:10px; font-size:0; line-height:999; text-indent:-9999px; cursor:pointer; background:url(http://webimage.10x10.co.kr/play/ground/20140317/img_energy.gif) left top no-repeat;}
.playGr20140317 .approval .selectEnergy li.energy01 span {background-position:left top;}
.playGr20140317 .approval .selectEnergy li.energy02 span {background-position:-70px top;}
.playGr20140317 .approval .selectEnergy li.energy03 span {background-position:-140px top;}
.playGr20140317 .approval .selectEnergy li.energy04 span {background-position:-210px top;}
.playGr20140317 .approval .selectEnergy li.energy05 span {background-position:-280px top;}
.playGr20140317 .approval .selectTime {overflow:hidden; padding:20px 0 20px 70px;}
.playGr20140317 .approval .selectTime li {float:left; width:70px; padding:0 18px; text-align:center;}
.playGr20140317 .approval .selectTime li span {display:block; width:65px; height:45px; font-weight:bold; margin:0 auto 15px; cursor:pointer; padding-top:20px; font-size:15px; color:#1e1e1e; border:3px solid #363636;}
.playGr20140317 .approval .fBtn {text-align:right; padding-top:28px; margin-right:-8px;}
.playGr20140317 .approval .fBtn span {cursor:pointer;}
.playGr20140317 .approvalList {width:1140px; margin:0 auto; padding:65px 15px 0 0;}
.playGr20140317 .approvalList ul {overflow:hidden; margin-right:-40px;}
.playGr20140317 .approvalList li {position:relative; float:left; width:355px; height:208px; margin:0 38px 40px 0; background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_doc.png) left top no-repeat;}
.playGr20140317 .approvalList li .docNum {position:absolute; left:40px; top:12px; font-size:11px; color:#222;}
.playGr20140317 .approvalList li .docNum em {color:#777;}
.playGr20140317 .approvalList li .delete {position:absolute; right:15px; top:14px; cursor:pointer;}
.playGr20140317 .approvalList li div {height:98px; font-size:11px; margin:67px 0 0 31px; padding:15px 0 0 138px;  background-position:left top; background-repeat:no-repeat;}
.playGr20140317 .approvalList li.e01 div {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/ico_energy00.gif)}
.playGr20140317 .approvalList li.e02 div {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/ico_energy01.gif)}
.playGr20140317 .approvalList li.e03 div {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/ico_energy02.gif)}
.playGr20140317 .approvalList li.e04 div {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/ico_energy03.gif)}
.playGr20140317 .approvalList li.e05 div {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/ico_energy04.gif)}
.playGr20140317 .approvalList li .getOff {display:inline-block; border-bottom:2px solid #181818; font-size:20px; line-height:23px; padding-bottom:4px; margin-bottom:16px; color:#181818;}
.playGr20140317 .approvalList li .txt {line-height:18px;}
.playGr20140317 .tentenBaemin li {margin:0 auto; text-align:center; background-color:#fbfbfb;}
.playGr20140317 .tentenBaemin li.fir {background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_dash_line.gif) center bottom no-repeat #fbfbfb;}
.playGr20140317 .collaboInfo {margin:0 auto; text-align:center;}
.playGr20140317 .cartoon {margin-top:5px;}
.playGr20140317 .cartoon .slidesjs-pagination {overflow:hidden; float:right; padding:12px 12px 0 0;}
.playGr20140317 .cartoon .slidesjs-pagination-item {float:left; padding-left:6px; }
.playGr20140317 .cartoon .slidesjs-pagination-item a {display:block; width:24px; height:24px; text-indent:-9999px; background-position:left top; background-repeat:no-repeat;}
.playGr20140317 .cartoon .slidesjs-pagination-item a.active {background-position:left -24px;}
.playGr20140317 .cartoon .p01 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/btn_pagination01.gif);}
.playGr20140317 .cartoon .p02 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/btn_pagination02.gif);}
.playGr20140317 .tentenBaemin li.slash {padding:85px 0 95px; background:url(http://webimage.10x10.co.kr/play/ground/20140317/bg_slash.gif) left top repeat;}
.playGr20140317 .kit {position:relative; border-top:3px solid #161616; margin:48px 0 28px;}
.playGr20140317 .kit .slidesjs-pagination {overflow:hidden; position:absolute; left:600px; top:40px; z-index:50;}
.playGr20140317 .kit .slidesjs-pagination-item {float:left; padding-left:10px; background:none;}
.playGr20140317 .kit .slidesjs-pagination-item a {display:block; width:12px; height:12px; text-indent:-9999px; background-repeat:no-repeat; background-image:url(http://webimage.10x10.co.kr/play/ground/20140317/blt_pagination.png); background-position:left top;}
.playGr20140317 .kit .slidesjs-pagination-item a.active {background-position:-22px top;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".goMemo").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:5000}, 500);
	});

	$("label img").on("click", function() {
		$("#" + $(this).parents("label").attr("for")).click();
	});
});
</script>
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

	   
	   if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked||frm.spoint[3].checked||frm.spoint[4].checked)){
	    alert("현재 당 수치를 선택해주세요");
	    return false;
	   }

	   if(!(frm.txtcomm[0].checked||frm.txtcomm[1].checked||frm.txtcomm[2].checked||frm.txtcomm[3].checked||frm.txtcomm[4].checked)){
	    alert("예상 퇴근시간을 선택해주세요");
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

	
	$(function(){
		$('.approvalList .t01 .getOff strong').text('칼퇴');
		$('.approvalList .t02 .getOff strong').text('밥퇴');
		$('.approvalList .t03 .getOff strong').text('10시퇴근');
		$('.approvalList .t04 .getOff strong').text('12시퇴근');
		$('.approvalList .t05 .getOff strong').text('예측불가');

		$('.cartoon').slidesjs({
			width:'1141',
			height:'774',
			navigation:false,
			pagination:{effect: "fade"},
			play:{interval:3000,effect: "fade",auto: false}
		});
		$('.kit').slidesjs({
			width:'1321',
			height:'801',
			navigation:false,
			pagination:{effect: "fade"},
			play:{interval:3000,effect: "fade",auto: true}
		});
		$('.cartoon .slidesjs-pagination-item:nth-child(1)').addClass('p01');
		$('.cartoon .slidesjs-pagination-item:nth-child(2)').addClass('p02');
	});
//-->
</script>
<div class="playGr20140317">
	<div class="memo03Head"><img src="http://webimage.10x10.co.kr/play/ground/20140317/txt_memo_head.png" alt="" /></div>
	<ol class="tentenBaemin">
		<li class="fir" style="padding:93px 0 80px;"><p><img src="http://webimage.10x10.co.kr/play/ground/20140317/img_delivery_img01.png" alt="" /></p></li>
		<li style="padding:70px 0 80px;">
			<div class="collaboInfo" style="width:1141px;">
				<p>
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_delivery_img02.png" alt=""usemap="#Map" />
					<map name="Map" id="Map">
						<area shape="circle" coords="1012,108,68" href="#writeMemo" alt="야근수당 신청하기" class="goMemo" />
					</map>
				</p>
				<div class="cartoon">
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_cartoon01.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_cartoon02.jpg" alt="" />
				</div>
			</div>
		</li>
		<li class="slash">
			<div class="collaboInfo" style="width:1321px;">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140317/img_delivery_img03.png" alt="" /></p>
				<div class="kit">
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_kit01.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_kit02.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_kit03.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_kit04.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_slide_kit05.jpg" alt="" />
				</div>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140317/img_delivery_img04.png" alt="" /></p>
			</div>
		</li>
		<li style="padding:115px 0 80px;">
			<p>
				<img src="http://webimage.10x10.co.kr/play/ground/20140317/img_delivery_img05.png" alt=""usemap="#Map02" />
				<map name="Map02" id="Map02">
					<area shape="circle" coords="415,599,65" href="https://play.google.com/store/apps/details?id=com.sampleapp" target="_blank" />
					<area shape="circle" coords="586,600,67" href="https://itunes.apple.com/app/id378084485" target="_blank" />
					<area shape="circle" coords="753,600,67" href="/street/street_brand_sub06.asp?makerid=woowahan" />
				</map>
			</p>
		</li>
	</ol>
	<div class="applyEvtWrap" id="writeMemo">
		<div class="applyEvt">
			<div class="approval">
				<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				<div class="doc">
					<table>
						<colgroup>
							<col width="130px" /><col /><col width="130px" /><col width="150px" />
						</colgroup>
						<tbody>
							<tr>
								<th>문서코드</th>
								<td>No. 1010</td>
								<th>텐바이텐</th>
								<td><img src="http://webimage.10x10.co.kr/play/ground/20140317/img_logo.gif" alt="텐바이텐" /></td>
							</tr>
						</tbody>
					</table>
					<table>
						<colgroup>
							<col width="130px" /><col /><col width="130px" /><col width="230px" />
						</colgroup>
						<tbody>
							<tr>
								<td colspan="4" style="padding:52px 0 42px;" class="ct"><img src="http://webimage.10x10.co.kr/play/ground/20140317/txt_approval.gif" alt="텐바이텐" /></td>
							</tr>
							<tr>
								<th>문서코드</th>
								<td colspan="3" style="padding:25px 28px;">오늘의 예상 퇴근 시간과 당 수치를 체크하여 결재 요청서를 올려주세요.<br />요청서를 올려주신 분들 가운데 <strong>50분</strong>을 추첨하여 배달의 민족과 텐바이텐이 콜라보 한 ‘<strong>야근수당키트</strong>’를 보내드립니다.</td>
							</tr>
							<tr>
								<th>이벤트 기간</th>
								<td>2014.03.17 ~ 2014.03.28</td>
								<th>당첨자 발표</th>
								<td>2014.03.31</td>
							</tr>
							<tr>
								<th>현재<br />당 수치</th>
								<td colspan="3">
									<ul class="selectEnergy">
										<li class="energy01">
											<label for="energy01"><span>당수치4</span></label>
											<input type="radio" id="energy01" name="spoint" value="5"/>
										</li>
										<li class="energy02">
											<label for="energy02"><span>당수치3</span></label>
											<input type="radio" id="energy02" name="spoint" value="4"/>
										</li>
										<li class="energy03">
											<label for="energy03"><span>당수치2</span></label>
											<input type="radio" id="energy03" name="spoint" value="3"/>
										</li>
										<li class="energy04">
											<label for="energy04"><span>당수치1</span></label>
											<input type="radio" id="energy04" name="spoint" value="2"/>
										</li>
										<li class="energy05">
											<label for="energy05"><span>당수치0</span></label>
											<input type="radio" id="energy05" name="spoint" value="1"/>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>예상<br />퇴근시간</th>
								<td colspan="3">
									<ul class="selectTime">
										<li>
											<label for="time01"><span>칼퇴</span></label>
											<input type="radio" id="time01" name="txtcomm" value="1"/>
										</li>
										<li>
											<label for="time02"><span>밥퇴</span></label>
											<input type="radio" id="time02" name="txtcomm" value="2"/>
										</li>
										<li>
											<label for="time03"><span>10시</span></label>
											<input type="radio" id="time03" name="txtcomm" value="3"/>
										</li>
										<li>
											<label for="time04"><span>12시</span></label>
											<input type="radio" id="time04" name="txtcomm" value="4"/>
										</li>
										<li>
											<label for="time05"><span style="padding-top:10px; height:55px;">예측<br />불가</span></label>
											<input type="radio" id="time05" name="txtcomm" value="5"/>
										</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
					<p class="fBtn"><span><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140317/btn_finish.png" alt="작성완료" /></span></p>
				</div>
				</form>
				<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				</form>
				<dl class="share">
					<dt>당첨 확률 높이기</dt>
					<dd>
						<p>야근수당 이벤트를 SNS를 통해 공유해주시면 더욱 당첨확률이 높아져요!</p>
						<p>페이스북 아이콘을 클릭하고 자신의 타임라인에 <strong>공개</strong>로 공유해주세요</p>
						<p>트위터 아이콘을 클릭하고, 트윗 작성시에 <strong>#텐바이텐</strong> 해시태그를 꼭 남겨주세요.</p>
					</dd>
					<dd class="snsBtn">
						<a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a>
						<a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a>
					</dd>
				</dl>
			</div>
			<% IF isArray(arrCList) THEN %>
			<div class="approvalList">
				<ul>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
					<li class="t0<%=nl2br(arrCList(1,intCLoop))%> e0<%=arrCList(3,intCLoop)%>">
						<span class="docNum">문서코드 <em>no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></em></span>
						<div>
							<p class="getOff">나오늘 <strong></strong></p>
							<p class="txt"><%=printUserId(arrCList(2,intCLoop),2,"*")%> 님의<br />결재 요청서가 접수되었습니다.</p>
						</div>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
						<span class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')"><img src="http://webimage.10x10.co.kr/play/ground/20140317/btn_delete.gif" alt="삭제" /></span>
						<% end if %>
					</li>
					<% Next %>
				</ul>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
			<% End If %>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->