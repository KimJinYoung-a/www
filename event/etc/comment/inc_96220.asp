<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : K현대미술관 - 8월의 문화생활 - 뮤지엄 테라피 : 디어 브레인
' History : 2019-08-05
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
dim evtStartDate, evtEndDate, currentDate
	currentDate =  date()
    evtStartDate = Cdate("2019-08-05")
    evtEndDate = Cdate("2019-08-20")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90333
Else
	eCode   =  96220
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
	iCPageSize = 9		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 9		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
.evt96220 {background-color: #ecffd1; font-family:'Roboto','Noto Sans KR','malgun Gothic','맑은고딕'; overflow: hidden;}
.topic {position: relative; height: 610px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96220/bg_top.jpg);}
.topic span {position: absolute; left: 50%; bottom: -130px; margin-left: -244px; transform: translate3d(0,-700px,0); transition-duration: 2s}
.topic span.on {transform: translate3d(0,0,0)}


.slide1 {width: 1310px; margin: 0 auto; padding-top: 120px; outline:none;}
.slide1 .slick-dots {position:absolute; top: 13px; left: 50%; width: 970px; z-index:999; transform: translate3d(-50%,0,0) }
.slide1 .slick-dots li {width: 33.33%; }
.slide1 .slick-dots li button {width: 100%; height: 90px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96220/btn_off.png) ; text-align: center; transition-duration: .2s}
.slide1 .slick-dots li:nth-child(2) button {background-position: center 0;}
.slide1 .slick-dots li:nth-child(3) button {background-position: right 0;}
.slide1 .slick-dots li.slick-active button,
.slide1 .slick-dots li:hover button {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96220/btn_on.png)}


.cmt-area {position: relative; background-color:#9e6af2;}
.cmt-area .input-box {position: absolute; top: 372px; left: 50%; width:784px; height: 146px; margin-left: -392px; text-align: left;}
.cmt-area .input-box input {display: inline-block; width:210px; height:32px; padding: 0; margin: 43px 0 0 275px; box-sizing: border-box; border:0; color:#444; font-weight: bold; font-size:20px; font-family: inherit; text-align: center; line-height: 40px; white-space: nowrap; vertical-align: top; overflow: hidden;}
.cmt-area .input-box input::-webkit-input-placeholder {color:#999; font-weight: normal;}
.cmt-area .input-box input:focus::-webkit-input-placeholder {opacity: 0;} 
.cmt-area .input-box .submit {float: right; display: block; width: 161px; height: 146px; text-indent: -9999px; background-color: transparent;}
.cmt-area .input-box .now-txt {position:absolute; bottom:59px; right: 300px; z-index:150; color:#bbb; font-size:12px;}
.cmt-list {padding-bottom: 80px;}
.cmt-list ul {width: 1026px; margin:0 auto;}
.cmt-list ul:after {content: ''; display: block; clear: both;}
.cmt-list li {position:relative; float:left; width:312px; height: 136px; margin:0 15px 30px; padding: 20px; color:#999; font-size:16px; line-height:1; text-align:left; background-color:#fff; background: url(//webimage.10x10.co.kr/fixevent/event/2019/96220/bg_cmt.png) no-repeat; box-sizing: border-box;}
.cmt-list li .num {color: #444;}
.cmt-list li .writer {position: absolute; top: 20px; right: 20px; font-size:14px; }
.cmt-list li .conts {margin-top: 25px; font-size:18px; line-height: 1.8; font-size: 18px; font-weight:500; text-align: center; word-wrap:break-word; word-break: break-all; color: #666;}
.cmt-list li .conts span {font-weight: bold; color: #8134ff  ; text-transform: uppercase;}
.cmt-list li button.delete {position: absolute; right: 20px; bottom: 10px; padding: 3px 5px;  color: #fff; background-color: #9e6af2; border-radius: 20px}
.cmt-list li:nth-child(5n-3) span {color: #ff3690  ;}
.cmt-list li:nth-child(5n-2) span {color: #05c85c   ;}
.cmt-list li:nth-child(5n-1) span {color: #ff8a34   ;}
.cmt-list li:nth-child(5n) span {color: #3657ff ;}
.cmt-list .paging a {width: 32px; height: 32px;  margin: 0 2px;border:0;  background-color:transparent; }
.cmt-list .paging a span {padding: 0; font-size: 20px; font-family: inherit; line-height: 32px; color:#d3b9ff; }
.cmt-list .paging a.current {background-color: #09d0a8; border-radius: 50%; opacity: 1}
.cmt-list .paging a.current span {color: #fff; font-weight: normal;}
.cmt-list .paging a.arrow span {display: none;}
.cmt-list .paging a.next {margin-left: 10px; transform: rotateY(180deg);}
.cmt-list .paging a.arrow.first,.cmt-list .paging a.arrow.end,.cmt-list .pageMove{display:none;}
.noti {position:relative; padding:47px 0; background-color:#3d3d3d; text-align: center; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif;}
.noti h3 {position: absolute; display: block; top: 50%; left: 50%; margin-left: -380px; font-family: inherit; font-weight: bold; font-size: 23px; color: #cddaff; transform: translateY(-50%); }
.noti ul {display: block; width:740px; margin: auto; padding-left: 400px; }
.noti ul li {color:#fefefe; font-size:14px; padding:6px 0; font-weight: normal; text-indent:-7px; word-break:keep-all; text-align: left; }
.noti ul li:before {content: '- '; display: inline-block;}
.bnr-float {position: fixed; right: 50%; bottom: 94px; margin-right: -700px; z-index: 999;}
</style>
<script>
$(function(){
	(function(){
        $('.topic span').addClass('on');
        $('.cmt-list .paging a.arrow').append('<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" stroke="#7835e8" stroke-width="2"><circle cx="15" cy="15" r="14"/><path d="M15 19.55L11.444 15 15 10.44" stroke-linecap="round"/></svg>')
        $(window).scroll(function() {
            var st=$(this).scrollTop();
            var winH=window.innerHeight;
            $('.intro dl').each(function(){
                var innerH=$(this).innerHeight()
                var ofs=$(this).offset().top;
                if(st>ofs-winH && ofs+ innerH>st){$(this).addClass('on')}
                else{$(this).removeClass('on')}
            })
        })
        $('.slide1').slick({
            pauseOnHover: false,
            autoplay: true,
            fade: true,
            dots: true,
        })
    })();

	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-area").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
            if(frm.txtcomm1.value == ""){
                alert('내용을 넣어주세요')
                frm.txtcomm1.focus()
                return false;
            }

            fnAmplitudeEventMultiPropertiesAction("click_comment_in_event","eventcode","<%=eCode%>");

            frm.txtcomm.value = frm.txtcomm1.value
            frm.action = "/event/lib/comment_process.asp";
            frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";
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
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";
			return false;
		}
		return false;
	}
}

function chkword(obj, maxByte) {
 	var strValue = obj.value;
	var strLen = strValue.length;
	var totalByte = 0;
	var len = 0;
	var oneChar = "";
	var str2 = "";

	for (var i = 0; i < strLen; i++) {
		oneChar = strValue.charAt(i);
		if (escape(oneChar).length > 4) {
			totalByte += 2;
		} else {
			totalByte++;
		}

		// 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
		if (totalByte <= maxByte) {
			len = i + 1;
		}
	}

    $("#nowtxt").text(parseInt(totalByte/2));

	// 넘어가는 글자는 자른다.
	if (totalByte > maxByte) {
		alert("띄어쓰기 포함 "+ maxByte/2 + "자를 초과 입력 할 수 없습니다.");
		str2 = strValue.substr(0, len);
		obj.value = str2;
		chkword(obj, 4000);
	}
}
</script>
<div class="evt96220">
	<div class="topic posr">
		<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/tit.png?v=1.01" alt="8월의 문화생활"></h2>
		<span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/img_post.png" alt=""></span>
	</div>
	<div class="intro">
		<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/img_intro.jpg" alt=""></p>
		<div class="slide1">
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/img_slide_1.jpg" alt=""></div>
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/img_slide_2.jpg" alt=""></div>
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/img_slide_3.jpg" alt=""></div>
		</div>
	</div>

	<div class="cmt-area">
		<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/img_cmt.jpg" alt="quiz event"></span>
		<div class="input-box">
			<form name="frmcom" method="post" onSubmit="return false;" >
                <input type="hidden" name="eventid" value="<%=eCode%>">
                <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                <input type="hidden" name="bidx" value="<%=bidx%>">
                <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
                <input type="hidden" name="iCTot" value="">
                <input type="hidden" name="mode" value="add">
                <input type="hidden" id="spoint" name="spoint" value="1">
                <input type="hidden" name="isMC" value="<%=isMyComm%>">
                <input type="hidden" name="pagereload" value="ON">
                <input type="hidden" name="txtcomm">
                <input type="hidden" name="gubunval">  
                <input type="text" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" title="검색어 입력" placeholder="정답을 입력해주세요" maxlength="5" onkeyup="chkword(this,10);" autocomplete="off"/>
                <button class="submit" onClick="jsSubmitComment(document.frmcom);return false;">등록하기</button>
                <p class="now-txt" name="현재 입력한 글자수"><span id="nowtxt">0</span>/5</p>
            </form>
            <form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
                <input type="hidden" name="eventid" value="<%=eCode%>">
                <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                <input type="hidden" name="bidx" value="<%=bidx%>">
                <input type="hidden" name="Cidx" value="">
                <input type="hidden" name="mode" value="del">                                        
            </form>
		</div>
		<div class="cmt-list">
			<% IF isArray(arrCList) THEN %>
			<ul>
				<% 
                    For intCLoop = 0 To UBound(arrCList,2) 
                %>
				<li>
					<div class="ect">
						<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
						<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
					</div>
					<div class="conts">≪뮤지엄 테라피 : <span><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></span>≫</div>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                    <button class="delete" onClick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;">삭제</button>
                    <% end if %>
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
	<div class="noti">
		<div class="noti">
			<h3>유의사항</h3>
			<ul>
				<li>해당 이벤트는 로그인 후 참여 가능합니다.</li>
				<li>≪뮤지엄 테라피 : 디어 브레인≫ 전시는 타인에게 양도가 불가합니다.</li>
				<li>텐바이텐 X K현대미술관 8월의 문화생활 당첨자 발표는 8월 21일 텐바이텐 공지사항에 게시됩니다.</li>
				<li>≪뮤지엄 테라피 : 디어 브레인≫ 전시 관람일은 8월 22일 ~ 9월 1일까지 관람 가능합니다.</li>
				<li>미술관 방문 시 본인 확인을 위하여, 신분증을 지참해주셔야 합니다.</li>
			</ul>
		</div>
	</div>
	<div class="bnr-float"><a href="/culturestation/" onclick="fnAmplitudeEventMultiPropertiesAction('click_floatingbanner_in_event','eventcode','<%=eCode%>');"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96220/bnr.png" alt="다양한 문화생활 즐기러 가기"></a></div>
</div>            