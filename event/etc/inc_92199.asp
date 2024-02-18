<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 버킷리스트 - 튜터링
' History : 2019-01-25 이종화 생성
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90220
Else
	eCode   =  92199
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

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
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
.evt91956 .topic {position:relative; background:#ff7c95 url(//webimage.10x10.co.kr/fixevent/event/2019/92199/bg_topic.jpg) 50% 0 repeat-x;}
.evt91956 .topic h2 {position:relative; z-index:8; padding-top:60px;}
.evt91956 .topic p {position:absolute; top:185px; left:50%; z-index:5; margin-left:290px; animation:slideX 1s 500 ease-in forwards;}
.evt91956 .topic i {display:inline-block; position:absolute; top:63px; left:50%; z-index:3; width:16px; height:498px; margin-left:305px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/91819/bg_tit.png) 50% 0 no-repeat;}

.evt91956 .info {padding:70px 0 100px; background-color:#fff;}
.evt91956 .info .slide {position:relative; width:1028px; height:560px; padding-top:195px; margin:50px auto 0;}
.evt91956 .info .slide .slidesjs-pagination {position:absolute; top:0; left:50%; width:100%; margin-left:-50%; text-align:center;}
.evt91956 .info .slide .slidesjs-pagination li {display:inline-block; width:150px; height:150px; margin:0 30px;}
.evt91956 .info .slide .slidesjs-pagination a {display:inline-block; width:100%; height:100%; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92199/txt_info.png); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.evt91956 .info .slide .slidesjs-pagination a.active {background-position:0 100%;}
.evt91956 .info .slide .slidesjs-pagination li:nth-child(2) a {background-position:-210px 0;}
.evt91956 .info .slide .slidesjs-pagination li:nth-child(2) a.active {background-position:-210px 100%;}
.evt91956 .info .slide .slidesjs-pagination li:nth-child(3) a {background-position:-420px 0 ;}
.evt91956 .info .slide .slidesjs-pagination li:nth-child(3) a.active {background-position:-420px 100%;}
.evt91956 .info .slide .slidesjs-pagination li:nth-child(4) a {background-position:100% 0;}
.evt91956 .info .slide .slidesjs-pagination li:nth-child(4) a.active {background-position:100% 100%;}
.evt91956 .info .slide .slidesjs-navigation {position:absolute; top:190px; z-index:10; width:24px; height:560px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/91819/btn_prev.png); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.evt91956 .info .slide .slidesjs-navigation.slidesjs-previous {left:0;}
.evt91956 .info .slide .slidesjs-navigation.slidesjs-next {right:0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/91819/btn_next.png)}

.cmt-area {background-color:#bbe2f9; font-family:"malgun Gothic","맑은고딕";}
.cmt-area h4 {padding:100px 0 60px;}
.cmt-area .inner {width:1140px; margin:0 auto; text-align:left;}
.caution {margin:27px 0 0 70px;}
.cmt-area .input-box {position:relative; padding:30px; background-color:#9ed3f2;}
.txt-wrap {width:747px; padding:30px 30px 40px; background-color:#fff;}
.cmt-area textarea {width:100%; height:70px; padding:0; border:0; color:#444; font-size:16px; line-height:1.4; font-weight:bold;}
.cmt-area textarea::-webkit-input-placeholder {color:#999;}
.cmt-area .submit {position:absolute; top:47px; right:30px; z-index:50; background-color:transparent;}
.cmt-area .now-txt {position:absolute; top:140px; left:755px; z-index:150; color:#a2a2a2; font-size:14px;}

.cmt-list {margin-top:48px; padding-bottom:80px;}
.cmt-list ul {overflow:hidden; margin:0 auto; padding:0 15px;}
.cmt-list li {position:relative; float:left; width:285px; margin:20px 20px 50px; padding:34px 22px 0 23px; color:#383838; font-size:16px; line-height:1; text-align:left; background-color:#e2ffed;}
.cmt-list li .desc {overflow:hidden; padding:0 17px 16px; border-bottom:solid 1px rgba(0,0,0,.1);}
.cmt-list li .desc .num {float:left; font-weight:bold;}
.cmt-list li .desc .writer {float:right;}
.cmt-list li .delete {display:inline-block; position:absolute; right:16px; top:16px; width:13px; height:12px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/91819/btn_delete.png) 50% 50% no-repeat; background-size:100%; text-indent:-999em;}
.cmt-list .conts {position:relative; height:246px; padding:0 16px; margin-top:18px; font-size:14px; line-height:2; font-weight:500; word-wrap:break-word; word-break: break-all;}
.cmt-list .conts:after {display:inline-block; position:absolute; bottom:-29px; left:-26px; width:333px; height:29px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/92199/bg_cmt_2.png) 50% 50% no-repeat; content:'';}
.cmt-list li:nth-child(2n) .conts:after {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92199/bg_cmt_1.png)}

.cmt-list .paging {height:34px;}
.cmt-list .paging a {height:34px; line-height:34px; border:0; font-weight:bold; background-color:transparent;}
.cmt-list .paging a span {width:34px; height:34px; padding:0; font-size:16px; color:#415c76; font-family:"malgun Gothic","맑은고딕";}
.cmt-list .paging a.current {background-color:#3585a6; border:0; color:#fff; border-radius:580%;}
.cmt-list .paging a.current span {color:#fff;}
.cmt-list .paging a.current:hover {background-color:#3585a6;}
.cmt-list .paging a:hover {background-color:transparent;}
.cmt-list .paging a.arrow {width:29px; height:34px; margin:0 8px; background-color:transparent;}
.cmt-list .paging a.arrow span {display:inline-block; width:28px; height:28px; margin-bottom:2px; background-size:100%; background-position:0 0;}
.cmt-list .paging a.arrow.first,
.cmt-list .paging a.arrow.end{display:none;}
.cmt-list .paging a.prev span {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92199/btn_cmt_prev.png);}
.cmt-list .paging a.next span {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92199/btn_cmt_next.png);}
.cmt-list .pageMove {display:none;}

.noti {position:relative; padding:65px 0; background-color:#445269; color:#dadce1; font-size:15px; text-align:left;}
.noti h5 {position:absolute; top:50%; left:50%; margin-top:-15px; margin-left:-420px;}
.noti ul {width:1140px; margin:0 auto;}
.noti ul li {padding-left:399px; margin:10px 0; color:#dadce1; font-weight:bold; text-indent:-12px;}

@keyframes slideX {
	0%, 100% {transform:translateX(-7px);}
	50% {transform:translateX(7px);}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function() {
	$(".slide ").slidesjs({
		width:"1028",
		height:"560",
		navigation:{effect:"fade"},
		pagination:{effect:"fade"},
		play:{interval:8000, effect:"fade", auto:true},
		effect:{fade:{speed:800, crossfade:true}}
	});
	$(".topic p").addClass("animation");
	$(".cmt-list li:nth-child(2n-1)").css('background-color', '#ffe0ea');
	$(".cmt-list li:nth-child(2n)").css('background-color', '#fffec6');

	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-list").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2019-01-25" and left(currenttime,10) < "2019-02-07" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("한 ID당 1회만 참여 가능합니다.");
				return false;
			<% else %>
				frm.txtcomm.value = frm.txtcomm1.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	}
}

function fnChkByte(obj) {
    var maxByte = 300; //최대 입력 바이트 수
    var str = obj.value;
    var str_len = str.length;
 
    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";
 
    for (var i = 0; i < str_len; i++) {
        one_char = str.charAt(i);
 
        if (escape(one_char).length > 4) {
            rbyte += 2; //한글2Byte
        } else {
            rbyte++; //영문 등 나머지 1Byte
        }
 
        if (rbyte <= maxByte) {
            rlen = i + 1; //return할 문자열 갯수
        }
    }
 
    if (rbyte > maxByte) {
        alert("한글 "+ (maxByte / 2) +"자 이내로 작성 가능합니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    } else {
        document.getElementById('byteInfo').innerText = Math.ceil(rbyte / 2);
    }
}

</script>
<div class="evt91956">
    <%' 최상단 %>
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/tit_bucket.png?v=1.02" alt="tutoring과 함께 영어공부"></h2>
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/img_winner.png" alt="총 당첨자 100명!"></p>
        <i></i>
    </div>

    <%' 브랜드 소개 %>
    <div class="info">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/tit_info.png" alt="튜터링 궁금해요!"></h3>
        <div class="slide">
            <div class="swiper-slide"><a href=""><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/img_slide_1.jpg" alt="언제 어디서나 수업 시작 버튼 클릭으로 30초만에 튜터와 공부를 시작할 수 있어요!  " /></a></div>
            <div class="swiper-slide"><a href=""><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/img_slide_2.jpg?v=1.01" alt="비즈니스, 면접, 시험 준비부터 여행, 영화, 음식 등 삶의 다양한 소재로 영어 수다에 빠질 수 있어요! " /></a></div>
            <div class="swiper-slide"><a href=""><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/img_slide_3.jpg?v=1.01" alt="유저의 관심사 및 레벨에 따라 최적의 회화 코스를 안내해줘요! " /></a></div>
            <div class="swiper-slide"><a href=""><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/img_slide_4.jpg" alt="1:1 피드백으로 수업 중엔 채팅으로 동시에 첨삭받고, 수업 후에는 내 실력에 대해 피드백  받을 수 있어요! ." /></a></div>
        </div>
    </div>

    <%' 코멘트 %>
    <div class="cmt-area">
        <h4><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/txt_cmt_evt.png" alt="영어공부 할 때, 힘들었던 점을 남겨주세요 "></h4>
        <div class="inner">
            <form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
            <input type="hidden" name="eventid" value="<%=eCode%>">
            <input type="hidden" name="com_egC" value="<%=com_egCode%>">
            <input type="hidden" name="bidx" value="<%=bidx%>">
            <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
            <input type="hidden" name="iCTot" value="">
            <input type="hidden" name="mode" value="add">
            <input type="hidden" name="spoint" value="0">
            <input type="hidden" name="isMC" value="<%=isMyComm%>">
            <input type="hidden" name="pagereload" value="ON">
            <input type="hidden" name="txtcomm">
            <input type="hidden" name="gubunval">        
            <div class="input-box">
                <div class="txt-wrap">
                    <textarea class="" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="fnChkByte(this);" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> placeholder="띄어쓰기 포함 150자 이내로 적어주세요!"></textarea>
                    <button class="submit" onclick="jsSubmitComment(document.frmcom); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92199/btn_submit.png" alt="등록하기" /></button>
                    <p class="now-txt"><span id="byteInfo">0</span> / 150자</p>
                </div>
            </div>
            <p class="caution"><img src="//webimage.10x10.co.kr/fixevent/event/2019/91819/txt_notify.png" alt="한 ID당 한번 참여 가능합니다. 통신예절에 어긋나는 글이나 상업적인 글은 이벤트 참여에 제한을 받을 수 있습니다."></p>
            </form>
            <form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
                <input type="hidden" name="eventid" value="<%=eCode%>">
                <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                <input type="hidden" name="bidx" value="<%=bidx%>">
                <input type="hidden" name="Cidx" value="">
                <input type="hidden" name="mode" value="del">
                <input type="hidden" name="pagereload" value="ON">
            </form>            
            <div class="cmt-list">
				<% IF isArray(arrCList) THEN %>            
                <ul>
                    <% For intCLoop = 0 To UBound(arrCList,2) %>
                    <li>
                        <div class="desc">
                            <p class="num"><%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
                            <p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
                        </div>
                        <div class="conts">
                            <%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>
                        </div>
                        <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                            <button class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;">삭제</button>
                        <% End If %>
                    </li>
                    <% Next %>
                </ul>
                <% End If %>
                <div class="pageWrapV15 tMar30">
					<% IF isArray(arrCList) THEN %>
                    	<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					<% End If %>
                </div>
            </div>
        </div>
        <%' 유의사항 %>
        <div class="noti">
            <h5><img src="//webimage.10x10.co.kr/fixevent/event/2019/91819/tit_noti.png" alt="유의사항"></h5>
            <ul>
                <li>- 해당 이벤트는 로그인 후, 한 ID 당 1회만 참여할 수 있습니다.</li>
                <li>- 입력 완료된 댓글 내용은 수정이 불가합니다.</li>
                <li>- 통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며, 이벤트 참여에 제한을 받을 수 있습니다.</li>
                <li>- 이벤트 당첨자는 2019년 2월 8일 금요일 텐바이텐 공지사항에 기재 및 개별 연락 드릴 예정입니다.</li>
            </ul>
        </div>
    </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->