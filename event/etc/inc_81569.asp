<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 컬쳐 이벤트 시시한 일상 WWW
' History : 2017-11-01 유태욱 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #02/13/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67448
Else
	eCode   =  81569
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if date() < "2017-11-02" then
	if userid="baboytw" or userid="bjh2546" then
		currenttime = #11/02/2017 09:00:00#
	end if
end if

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 3		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 3		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<style>
.evt81569 {background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_noise_1.png) repeat 0 0;}
.evt81569 .inner {position:relative; width:1140px; margin:0 auto;}
.evt81569 .topic {height:1020px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_topic.png) no-repeat 50% 0;}
.evt81569 .topic h2 {padding:116px 0 72px;}
.evt81569 .topic .slidewrap {position:relative; width:1140px; height:708px; margin:0 auto; padding:0 19px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_slide_v3.png) no-repeat 0 0;}
.evt81569 .topic .sentence {padding:92px 0 90px; text-align:center;}
.evt81569 .topic .book {position:relative; padding-left:71px;}
.evt81569 .topic .book p {position:absolute; left:174px; top:0; width:248px; height:372px;}
.evt81569 .topic .book span {position:absolute; left:-100px; bottom:-20px; opacity:0; transition:all .5s;}
.evt81569 .topic .book p:hover span {opacity:1;}
.evt81569 .topic .slide {overflow:visible !important; position:absolute; right:235px; top:242px; width:268px; height:229px;}
.evt81569 .slide .slidesjs-navigation {position:absolute; z-index:10; top:100px; width:36px; height:71px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/btn_nav.png) no-repeat 0 50%; text-indent:-999em;}
.evt81569 .slide .slidesjs-previous {left:-118px;}
.evt81569 .slide .slidesjs-next {right:-118px; background-position:100% 50%;}
.evt81569 .slidesjs-pagination {overflow:hidden; position:absolute; bottom:-58px; left:50%; z-index:50; width:112px; margin-left:-55px;}
.evt81569 .slidesjs-pagination li {float:left; padding:0 10px;}
.evt81569 .slidesjs-pagination li a {display:block; width:8px; height:8px; background:#63789f; text-indent:-999em; border-radius:50%}
.evt81569 .slidesjs-pagination li a.active {background:#e6a891;}
.evt81569 .event1 {padding:216px 0 130px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_noise_2.png) repeat 0 0;}
.evt81569 .event1 h3 {position:relative; padding-left:48px; margin-bottom:-61px; text-align:left;}
.evt81569 .event1 .comment-write {position:relative;}
.evt81569 .event1 .comment-write .form-group {position:absolute; right:110px; top:50px; width:456px;}
.evt81569 .event1 .comment-write .form-group textarea {display:block; width:418px; padding:18px; color:#848484; font-size:15px; font-weight:bold; background:#fff;}
.evt81569 .event1 .comment-write .form-group .btn-submit {vertical-align:top;}
.evt81569 .event1 .comment-list {padding:65px 0 0;}
.evt81569 .event1 .comment-list ul {overflow:hidden; margin:0 -18px 0 -17px; padding-bottom:40px;}
.evt81569 .event1 .comment-list li {float:left; width:291px; height:216px; margin:0 18px 0 17px; padding:32px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_noise_1.png) repeat 0 0;}
.evt81569 .event1 .comment-list li .writer {position:relative; padding-bottom:20px; font-size:13px; font-family:arial; color:#2d4c72;}
.evt81569 .event1 .comment-list li .writer i {display:inline-block; width:10px; height:13px; margin-right:4px; text-indent:-999em; vertical-align:middle; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/ico_mobile.png) repeat 0 0;}
.evt81569 .event1 .comment-list li .writer .num {position:absolute; right:0; top:0;}
.evt81569 .event1 .pageMove {display:none;}
.evt81569 .event2 {height:628px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_event_2.jpg) no-repeat 50% 0;}
.evt81569 .event2 .inner {padding:145px 0 0 70px;}
.evt81569 .event2 h3 {margin-left:-22px; padding-bottom:55px;}
.evt81569 .event2 .siyoil {position:absolute; left:50%; top:282px; margin-left:332px;}
.evt81569 .sale {text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_noise_3.png) repeat 0 0;}
.evt81569 .sale p {padding:33px 0 44px 70px;}
.evt81569 .sale a {position:absolute; right:70px; top:70px;}
.evt81569 .noti {padding:60px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/bg_noise_4.png) repeat 0 0;}
.evt81569 .noti h3 {position:absolute; left:154px; top:50%; margin-top:-12px;}
.evt81569 .noti ul {padding-left:550px; font-size:11px; line-height:24px; text-align:left; color:#fff; }
.evt81569 .noti li {position:relative; padding-left:15px;}
.evt81569 .noti li:after {content:''; display:inline-block; position:absolute; left:0; top:9px; width:5px; height:5px; background:#fff; border-radius:50%;}

.scrollbarwrap {width:100%;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:270px; height:170px;}
.scrollbarwrap .overview {font-size:14px; color:#333; line-height:28px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:6px;}
.scrollbarwrap.track {position: relative; width:6px; height:100%; background-color:#ececec;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:4px; height:24px; background-color:#efa395; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:4px; height:5px;}
.scrollbarwrap .disable {display:none;}

.paging {display:inline-block; width:auto; height:29px; padding:6px 20px; background:#e2977e; border-radius:20px;}
.paging a {height:29px; line-height:29px; border:0; background:transparent;}
.paging a:hover {color:#2d4c72 !important; background:transparent !important;}
.paging a span {height:29px; padding:0 10px; color:#fff; font-size:11px; font-family:dotum;}
.paging a.current {background-color:transparent; border:0; color:#2d4c72;}
.paging a.current span {color:#2d4c72;}
.paging a.arrow {background:transparent;}
.paging a.arrow span {width:30px; height:29px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81569/btn_pagination.png) repeat 0 0;}
.paging a.first span {background-position:0 0;}
.paging a.prev span {background-position:-30px 0;}
.paging a.next span {background-position:-60px 0;}
.paging a.end span {background-position:-90px 0;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script>
$(function(){
	$('.scrollbarwrap').tinyscrollbar();
	$(".slide").slidesjs({
		width:"268",
		height:"229",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}}
	});
});

<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},100);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2017-11-02" and left(currenttime,10)<"2017-11-14" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("한 ID당 최대 5번까지 참여할 수 있습니다.");
				return false;
			<% else %>
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 600 || frm.txtcomm1.value == '띄어쓰기 포함 최대 한글 300자 이내로 적어주세요'){
					alert("띄어쓰기 포함\n최대 한글 300자 이내로 적어주세요.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.txtcomm1.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}

	if (frmcom.txtcomm1.value == '띄어쓰기 포함 최대 300자 이내로 적어주세요'){
		frmcom.txtcomm1.value = '';
	}
}

function jsevtchk(){
	<% If not( left(currenttime,10)>="2017-11-02" and left(currenttime,10)<"2017-11-14" ) Then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		var result;
		$.ajax({
			type:"GET",
			url:"/event/etc/doeventsubscript/doEventSubscript81569.asp",
			data: "mode=1mon",
			dataType: "text",
			async:false,
			cache:false,
			success : function(Data){
				result = jQuery.parseJSON(Data);
				if (result.resultcode=="11")
				{
					alert('응모가 완료 되었습니다.');
				}
				else if (result.resultcode=="44")
				{
					if(confirm("로그인을 하셔야 응모가 가능 합니다. 로그인 하시겠습니까?")){
						var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
						winLogin.focus();
						return;
					}
				}
				else if (result.resultcode=="77")
				{
					alert('이미 응모 하셨습니다.');
					return false;
				}
				else if (result.resultcode=="88")
				{
					alert("이벤트 기간이 아닙니다.");
					return;
				}
			}
		});
	<% end if %>
}
</script>
	<div class="evt81569">
		<div class="section topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/tit_poem.png" alt="詩詩한 일상 With. 박성우 시인" /></h2>
			<div class="inner">
				<div class="slidewrap">
					<p class="sentence"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_sentence.png" alt="쓸쓸한 밤에 닿아도 우리는 웃을 수 있다" /></p>
					<div class="book">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/img_book.jpg" alt="" />
						<p><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_book_info.png" alt="" /></span></p>
					</div>
					<div class="slide">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_slide_1.png" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_slide_2.png" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_slide_3.png" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_slide_4.png" alt="" />
					</div>
				</div>
			</div>
		</div>
		<div class="section event1">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/tit_event_1.png" alt="컬쳐콘서트에 초대합니다" /></h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_book_talk.jpg" alt="도처에서 반짝거리는 일상을 한편의 시로 만드는 시인 박성우" /></p>

				<!-- 코멘트 작성 -->
				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="com_egC" value="<%=com_egCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="spoint" value="0">
				<input type="hidden" name="isMC" value="<%=isMyComm%>">
				<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
				<% Else %>
					<input type="hidden" name="hookcode" value="&ecc=1">
				<% End If %>
				<input type="hidden" name="txtcomm">
				<div class="comment-write">
					<h4><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_comment_event.png" alt="COMMENT EVENT - 가장 좋아하는 시를 소개해주세요!" /></h4>
					<div class="form-group">
						<textarea cols="30" rows="5" name="txtcomm1" id="txtcomm1" placeholder="한글 300자 이내로 입력해주세요!" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<button type="submit" onclick="jsSubmitComment(document.frmcom); return false;" class="btn-submit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/btn_comment.png" alt="코멘트 응모하기" /></button>
					</div>
				</div>
				</form>
				<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="com_egC" value="<%=com_egCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="Cidx" value="">
					<input type="hidden" name="mode" value="del">
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>

				<!-- 코멘트 목록 -->
				<% IF isArray(arrCList) THEN %>
					<div class="comment-list" id="commentlist">
						<ul>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
								<li>
									<div class="writer">
										<strong>
											<% If arrCList(8,intCLoop) <> "W" Then %><i>모바일에서 작성</i><% end if %>
											<%=printUserId(arrCList(2,intCLoop),2,"*")%>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
												<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_delete.png" alt="삭제" /></a>
											<% end if %>	
										</strong>
										<span class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
									</div>
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
											</div>
										</div>
									</div>
								</li>
							<% next %>
						</ul>
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% end if %>
			</div>
		</div>
		<div class="section event2">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/tit_event_2.png" alt="시요일 이용권을 선물로 드립니다." /></h3>
				<button type="submit" onclick="jsevtchk(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/btn_1month.png" alt="1개월 이용권 응모하기" /></button>
				<p class="siyoil"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_siyoil.png" alt="세상의 모든 시 당신을 위한 시 한편 詩 날마다 시요일" /></p>
			</div>
		</div>
		<div class="section sale">
			<div class="inner">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/txt_sale.jpg" alt="시요일 1년 이용권 + 특별판 시집 5권 64% SALE" /></p>
				<a href="/shopping/category_prd.asp?itemid=1825013&pEtr=81569"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/btn_buy.png" alt="구매하기" /></a>
			</div>
		</div>
		<div class="section noti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81569/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>오직 텐바이텐 회원님을 위한 이벤트 입니다. (로그인 후 참여가능, 비회원 참여 불가)</li>
					<li>이벤트 경품은 내부 사정에 의해 변경될 수 있습니다.</li>
					<li>당첨자와 수령자는 동일해야 하며, 양도는 불가합니다.</li>
					<li>정확한 발표를 위해 마이텐바이텐의 개인정보를 업데이트 해주세요.</li>
					<li>이벤트 종료 후 당첨된 경품의 교환 및 변경은 불가 합니다.</li>
				</ul>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->