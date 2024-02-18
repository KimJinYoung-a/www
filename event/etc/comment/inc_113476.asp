<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
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
'####################################################
' Description : 박스테이프 공모전
' History : 2021-08-17 정태훈
'####################################################
%>
<%
dim currenttime
dim commentcount, i
Dim eCode , userid , pagereload , vDIdx, newAdd
Dim className
    className = "rdBox"

	currenttime =  now()
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  108389
	Else
		eCode   =  113476
	End If

	userid = GetEncLoginUserID()

If userid <> "" then
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
Else
	commentcount = 0
End If

vDIdx = request("didx")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)
    newAdd	= requestCheckVar(request("newAdd"),2)

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
	iCPageSize = 8		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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

dim sqlstr, evtcom_txt
if newAdd="ON" then
	sqlstr = "select top 1 "
	sqlstr = sqlstr & " c.evtcom_txt"
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_comment c"
	sqlstr = sqlstr & " where c.evt_code="& eCode &""
    sqlstr = sqlstr & " and c.userid='"& userid &"'"
    sqlstr = sqlstr & " order by evtcom_idx desc"
    rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		evtcom_txt = rsget("evtcom_txt")
	END IF
end if
%>
<style>
@font-face {font-family:'10x10'; src:url('//fiximage.10x10.co.kr/webfont/10x10.woff') format('woff'), url('//fiximage.10x10.co.kr/webfont/10x10.woff2') format('woff2'); font-style:normal; font-weight:normal;}
.box-tape .topic {position:relative; height:761px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/bg_main.jpg) no-repeat 50% 0;}
.box-tape .topic h2 {position:absolute; left:50%; top:120px; margin-left:-315px; opacity:0; transform:translateY(5%); transition:all 1s;}
.box-tape .topic .date {position:absolute; left:50%; top:260px; margin-left:-305px; opacity:0; transform:translateY(5%); transition:all 1s .3s;}
.box-tape .topic .animates.on {opacity:1; transform:translateY(0);}
.box-tape .section-01 {position:relative; height:997px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/bg_sub01.jpg) no-repeat 50% 0;}
.box-tape .section-01 .txt01 {position:absolute; left:50%; top:200px; margin-left:-277px;}
.box-tape .section-01 .box {position:absolute; left:50%; top:485px; margin-left:-151px;}
.box-tape .section-01 .txt02 {position:absolute; left:50%; top:790px; margin-left:-301px;}
.box-tape .section-02 {position:relative; height:667px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/bg_sub02.jpg) no-repeat 50% 0;}
.box-tape .noti-area {background:#ebd2b4;}
.box-tape .noti-area .btn-detail {position:relative; width:100%; height:87px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/btn_detail.jpg) no-repeat 50% 0;}
.box-tape .noti-area .noti {display:none; height:250px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/img_detail.jpg) no-repeat 50% 0;}
.box-tape .noti-area .noti.on {display:block;}
.box-tape .noti-area .icon {position:absolute; left:50%; top:39px; margin-left:75px; width:18px; height:11px; transform: rotate(0);}
.box-tape .noti-area .icon.on {transform: rotate(180deg);}
.box-tape .section-03 {position:relative; height:1045px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/bg_sub03.jpg) no-repeat 50% 0;}
.box-tape .section-03 .btn-apply {position:absolute; left:0; bottom:140px; width:100%; height:120px; background:transparent;}
.box-tape .section-03 .apply-input {position:absolute; left:50%; top:477px; transform:translate(-50%,0); width:488px; height:52px; padding:24px 26px;}
.box-tape .section-03 .apply-input input {width:100%; height:100%; text-align:center; font-size:28px; color:#fff; background:transparent;}
.box-tape .section-03 .apply-input input::placeholder {opacity:0.45; color:#fff;}
.box-tape .section-04 {height:1065px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/bg_sub04.jpg) no-repeat 50% 0;}
.box-tape .section-05 .tit {height:278px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/tit_copy.jpg) no-repeat 50% 0;}
.box-tape .section-06 {position:relative; height:691px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/bg_sub05.jpg) no-repeat 50% 0;}
.box-tape .section-06 .btn-font {display:inline-block; width:500px; height:100px; position:absolute; left:50%; top:455px; transform: translate(-50%,0);}
@keyframes wing {
    0% {transform: translateX(-1rem);}
    100% {transform: translateX(1rem);}
}
.box-tape .animate {opacity:0; transform:translateY(10%); transition:all 1s;}
.box-tape .animate.on {opacity:1; transform:translateY(0);}
.box-tape .pop-container {position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(0, 0, 0,0.741); z-index:150;}
.box-tape .pop-container .pop-inner {position:relative; width:100%; height:100%; padding:2.47rem 1.73rem 4.17rem; overflow-y: scroll;}
.box-tape .pop-container .pop-inner a {display:inline-block;}
.box-tape .pop-container .pop-inner .btn-close {position:absolute; right:20px; top:20px; width:27px; height:28px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;}
.box-tape .pop-container .pop-contents {position:relative; width:651px; margin:0 auto;}
.box-tape .pop-container .pop-contents .copy {position:absolute; left:50%; top:31.5%; transform:translate(-50%,0); overflow:hidden; margin:0 auto; padding:0; border:0; background:transparent; text-align:center; font-size:20px; color:#fff; width:calc(100% - 320px); height:63px; padding:0 20px; line-height:63px; overflow:hidden;}
.box-tape .pop-container .pop-contents .inner-txt {width:100%; position:absolute; left:50%; top:68%; transform:translate(-50%,0); text-align:center;}
.box-tape .pop-container .pop-contents .inner-txt p {padding-bottom:5px; color:#111; font-size:24px; font-weight:700;}
.box-tape .pop-container .pop-contents .inner-txt p:nth-child(2) {padding-bottom:2rem;}
.box-tape .pop-container .pop-contents .inner-txt .id span {text-decoration:underline; text-decoration-color:#111;}
.box-tape .pop-container .pop-contents .inner-txt .day {font-weight:400;}
.box-tape .pop-container .pop-contents .btn-share {width:100%; height:10rem; position:absolute; left:0; bottom:0; background:transparent;}
.box-tape .contest {position:relative; padding:110px 0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101230/bg_cont.jpg); background-position:50% 0;} 
.box-tape .contest .btn-font {position:absolute; top:265px; left:50%; width:208px; height:40px; margin-left:60px; color:transparent;}
.box-tape .contest .down-otf {margin-left:320px;}
.box-tape .contest .slide1 {position:absolute; top:425px; left:50%; width:459px; height:395px; margin-left:60px;}
.box-tape .contest .slide1 .slick-dots {position:absolute; bottom:29px; left:0; width:100%;}
.box-tape .contest .slide1 .slick-dots li {width:5px; height:5px; background-color:transparent; border:solid 2px #bf1b17; border-radius:50%; margin:0 5px;}
.box-tape .contest .slide1 .slick-dots .slick-active {background-color:#bf1b17;}
.box-tape .cmt-section {background:#f5e0c6;}
.box-tape .cmt-section h3 {padding:95px 0 35px;}
.box-tape .cmt-section .input-wrap {position:relative; width:1031px; height:158px; margin:0 auto 23px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101230/bg_input.png); background-position:0 50%;}
.box-tape .cmt-section .input-wrap input {position:absolute; top:28px; left:30px; width:970px; height:102px; padding-left:35px; padding-right:272px; font-size:20px; box-sizing:border-box;}
.box-tape .cmt-section .input-wrap input::placeholder{color:#b6b6b6;}
.box-tape .cmt-section .input-wrap .btn-submit {position:absolute; top:28px; right:30px;}
.box-tape .cmt-section .cmt-list {margin:0 0 70px;}
.box-tape .cmt-section .cmt-list ul {display:flex; width:1140px; margin:0 auto; justify-content:space-between; flex-wrap:wrap;}
.box-tape .cmt-section .cmt-list li {position:relative; width:550px; height:109px; margin-top:30px; padding:28px 30px; background-color:#f70d0d; box-sizing:border-box;}
.box-tape .cmt-section .cmt-list li:nth-child(4n-1),.box-tape .cmt-section .cmt-list li:nth-child(4n-2) {background-color:#ff7272;}
.box-tape .cmt-section .cmt-list li .info {display:flex; justify-content:space-between; font-size:18px; color:#ffe87f; line-height:1;}
.box-tape .cmt-section .cmt-list li .info .writer {color:#ffe2cd;}
.box-tape .cmt-section .cmt-list li .copy {margin-top:13px; color:#fff; font-size:24px; line-height:31px; font-family:'10X10'; text-align:left;}
.box-tape .cmt-section .cmt-list li .btn-delete {position:absolute; top:0; right:0; width:37px; height:16px; background-image:url(//webimage.10x10.co.kr/eventIMG/2017/76169/btn_delete.png)}
.box-tape .cmt-section .pageMove {display:none;}
.box-tape .cmt-section .paging {height:34px; padding-bottom:115px;}
.box-tape .cmt-section .paging a{height:34px; background-color:transparent; border:0;}
.box-tape .cmt-section .paging a span {height:100%; padding:0 14px 0 12px; color:#f33f27; font:bold 20px/34px dotum, '돋움', sans-serif; text-align:center;}
.box-tape .cmt-section .paging a.current span{background-color:#f33f27; color:#fff; border-radius:50%;}
.box-tape .cmt-section .paging a.arrow span {width:30px; height:100%; padding:0; margin:0 28px;}
.box-tape .cmt-section .paging a.prev span {background-position:0 3px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/icon_arr_left.png);}
.box-tape .cmt-section .paging a.next span {background-position:100% 3px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2021/113476/icon_arr_right.png);}
.box-tape .cmt-section .paging a.first,
.box-tape .cmt-section .paging a.end {display:none;}
.box-tape .noti {background-color:#eec8ac;}
</style>
<script>
$(function(){
    $('.topic .animates').addClass('on');
    /* 글자,이미지 스르륵 모션 */
    $(window).scroll(function(){
        $('.animate').each(function(){
        var y = $(window).scrollTop() + $(window).height() * 1;
        var imgTop = $(this).offset().top;
        if(y > imgTop) {
            $(this).addClass('on');
        }
        });
    });
    // btn more
	$('.box-tape .btn-detail').click(function (e) { 
		$(this).next().toggleClass('on');
        $(this).find('.icon').toggleClass('on');
	});
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-section").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2021-08-17" and date() <= "2021-08-29" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(!frm.txtcomm.value){
					alert("택배 받는 순간을 즐겁게 해줄 카피를 적어주세요!");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 36){
					alert("제한길이를 초과하였습니다. 18자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	}
}

function fnClosePop(){
    location.href="/event/eventmain.asp?eventid=<%= eCode %>&pagereload=ON";
}
</script>
						<div class="evt113476 box-tape">
							<div class="topic">
								<h2 class="animates"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/tit_main.png" alt="텐바이텐 박스테이프 카피 공모전"></h2>
								<p class="date animates"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/txt_main.png" alt="21.08.18 ㅡ 21.08.29"></p>
							</div>
                            <div class="section-01">
                                <div class="txt01 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/txt_sub01.png" alt=""></div>
                                <div class="box animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/img_box.png" alt=""></div>
                                <div class="txt02 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/txt_sub02.png" alt=""></div>
                            </div>
                            <div class="section-02"></div>
                            <div class="noti-area">
                                <button type="button" class="btn-detail">
                                    <span class="icon"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/icon_arrow.png" alt=""></span>
                                </button>
                                <div class="noti"></div>
                            </div>
                            <div class="section-03">
                            <form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
                            <input type="hidden" name="eventid" value="<%=eCode%>">
                            <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                            <input type="hidden" name="bidx" value="<%=bidx%>">
                            <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
                            <input type="hidden" name="iCTot" value="">
                            <input type="hidden" name="mode" value="add">
                            <input type="hidden" name="spoint">
                            <input type="hidden" name="isMC" value="<%=isMyComm%>">
                            <input type="hidden" name="pagereload" value="ON">
                            <input type="hidden" name="returnurl" value="/event/eventmain.asp?eventid=<%= eCode %>&pagereload=ON&newAdd=ON">
                            <input type="hidden" name="gubunval">
                                <div class="apply-input">
                                    <input type="text" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" maxlength="18" placeholder="여기에 작성해주세요!">
                                </div>
                                <!-- 응모하기 버튼 -->
                                <button type="button" class="btn-apply" onclick="jsSubmitComment(document.frmcom);"></button>
                            </form>
                            </div>
                            <div class="section-04"></div>
                            <div class="section-05">
                                <div class="tit"></div>
                                <div class="cmt-section">
                                    <% If isArray(arrCList) Then %>
                                    <div class="cmt-list">
                                        <ul>
                                            <% For intCLoop = 0 To UBound(arrCList,2) %>
                                            <li>
                                                <div class="info">
                                                    <span class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
                                                    <span class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%></span>
                                                </div>
                                                <div class="copy"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></div>
                                                <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                                                <button class="btn-delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');"></button>
                                                <% End If %>
                                            </li>
                                            <% Next %>
                                        </ul>
                                    </div>
                                    <div class="pageWrapV15">
                                        <%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
                                    </div>
                                    <% End If %>
                                </div>
                            </div>
                            <div class="section-06">
                                <a href="http://company.10x10.co.kr/" target="_blank" class="btn-font"></a>
                            </div>
                            <% if newAdd = "ON" then %>
                            <div class="pop-container done">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/113476/pop_done.jpg?v=1.2" alt="참여완료">
                                        <!-- 카피 문구 노출 -->
                                        <div class="copy">
                                            <%=evtcom_txt%>
                                        </div>
                                        <div class="inner-txt">
                                            <p class="id"><span><%=userid%></span>님, 참여가 완료되었습니다!</p>
                                            <p class="day">후보작 발표일은 9월 10일입니다.</p>
                                        </div>
                                        <button type="button" class="btn-close" onclick="fnClosePop();">닫기</button>
                                    </div>
                                </div>
                            </div>
                            <% end if %>
                        </div>
<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="com_egC" value="<%=com_egCode%>">
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="Cidx" value="">
<input type="hidden" name="mode" value="del">
<input type="hidden" name="pagereload" value="ON">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->