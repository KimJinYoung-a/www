<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 대림미술관
' History : 2019-07-08
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
    evtStartDate = Cdate("2019-07-09")
    evtEndDate = Cdate("2019-07-23")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90333
Else
	eCode   =  95815
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
	iCPageSize = 12		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 12		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
<style type="text/css">
.evt95815 {background-color: #d4e4d7; font-family:'Roboto','Noto Sans KR','malgun Gothic','맑은고딕'; overflow: hidden;}
.evt95815 .posr {position: relative;}
.evt95815 .pos {position: absolute;}
.topic { height: 610px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/95815/bg_top.jpg);}
.topic span {left: 50%; bottom: -125px; margin-left: -300px; transform: translate3d(0,-700px,0); transition-duration: 2s}
.topic span.on {transform: translate3d(0,0,0)}
.intro .slick-slider {width: 1140px; margin: 0 auto; outline:none;}
.intro .slick-arrow {position: absolute; bottom: 30px; right: 48px; width: 30px; height: 40px;}
.intro .slick-arrow.slick-prev {right: 138px;}
.vod-area {height: 780px; padding-top: 120px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/95815/bg_vod.jpg?v=1.01) no-repeat 50% 0; box-sizing: border-box;}
.vod-area .vod {width: 830px; height: 468px; margin: 0 auto;}
.vod-area .vod iframe {width: 100%; height: 100%;}
.cmt-area {background: url() no-repeat #ef835c 50% 0;}
.cmt-area {position: relative; background-color: #ef835c;}
.cmt-area .input-box {position: absolute; top: 380px; left: 50%; width:784px; height: 146px; margin-left: -397px;}
.cmt-area .input-box input {display: inline-block; width:230px; height:32px; padding: 0; margin: 49px 0 0 15px; box-sizing: border-box; border:0; color:#444; font-weight: bold; font-size:20px; font-family: inherit; text-align: center; line-height: 40px; white-space: nowrap; vertical-align: top; overflow: hidden;}
.cmt-area .input-box input::-webkit-input-placeholder {color:#999; font-weight: normal;}
.cmt-area .input-box input:focus::-webkit-input-placeholder {opacity: 0;} 
.cmt-area .input-box .submit {float: right; display: block; width: 161px; height: 146px; text-indent: -9999px; background-color: transparent;}
.cmt-area .input-box .now-txt {position:absolute; bottom:55px; right: 346px; z-index:150; color:#bbb; font-size:11px;}
.cmt-list {padding-bottom: 80px;}
.cmt-list ul {width: 1026px; margin:0 auto;}
.cmt-list ul:after {content: ''; display: block; clear: both;}
.cmt-list li {position:relative; float:left; width:312px; height: 169px; margin:0 15px 30px; padding:20px; color:#999; font-size:16px; line-height:1; text-align:left; background-color:#fff; border-radius: 12px; box-sizing: border-box;}
.cmt-list li .num {color: #444;}
.cmt-list li .writer {position: absolute; top: 20px; right: 20px; font-size:14px; }
.cmt-list li .conts {margin-top: 5px; font-size:18px; line-height: 1.8; font-weight:500; text-align: center; word-wrap:break-word; word-break: break-all;}
.cmt-list li .conts span {color: #444; font-size: 23px;}
.cmt-list li button.delete {position: absolute; right: 20px; bottom: 20px; padding: 4px 8px;  color: #fff; font-weight: bold; background-color: #ef835c; border-radius: 20px}
.cmt-list .paging a {width: 32px; height: 32px;  margin: 0 2px;border:0;  background-color:transparent; }
.cmt-list .paging a span {padding: 0; font-size: 20px; font-family: inherit; line-height: 32px; color:#f5bca7; }
.cmt-list .paging a.current {background-color: #1b3f93; border-radius: 50%; opacity: 1}
.cmt-list .paging a.current span {color: #fff; font-weight: normal;}
.cmt-list .paging a.arrow span {display: none;}
.cmt-list .paging a.next {transform: rotateY(180deg);}
.cmt-list .paging a.arrow.first,.cmt-list .paging a.arrow.end,.cmt-list .pageMove{display:none;}
.evt95815 .noti {width: 100%; background-color: #414141;}
.bnr-float {position: fixed; right: 50%; bottom: 94px; margin-right: -700px; z-index: 999;}
</style>
<script type="text/javascript" src="/lib/js/TweenMax.min.js"></script>
<script>
$(function(){
    (function(){
        $('.topic span').addClass('on');
        $('.slide1').slick({
            fade: true,
            speed: 400,	
            autoplay: true,
            arrows: true,
            infinite:true,
            pauseOnHover: false,
        });
        $('.cmt-list .paging a.arrow').append('<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" stroke="#be4416" stroke-width="2"><circle cx="15" cy="15" r="14"/><path d="M15 19.55L11.444 15 15 10.44" stroke-linecap="round"/></svg>')
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
<div class="evt95815">
    <div class="topic posr">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/tit.png?v=1.02" alt="7월의 문화생활"></h2>
        <span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_post.png" alt=""></span>
    </div>
    <div class="intro">
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_intro.jpg" alt="≪하이메 아욘, 숨겨진 일곱 가지 사연≫"></p>
        <div class="slide1">
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_1.jpg?v=1.01" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_2.jpg?v=1.01" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_3.jpg?v=1.01" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_4.jpg?v=1.01" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_5.jpg?v=1.01" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_6.jpg?v=1.01" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_slide_7.jpg?v=1.01" alt=""></div>
        </div>
    </div>
    <div class="vod-area">
        <div class="vod"><iframe src="https://www.youtube.com/embed/ST21xe-QjU8?list=PLf5kadn9tolzbcZUiD_yvhHNXyLrEwcDJ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
    </div>
    <div class="cmt-area">
        <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_cmt.jpg?v=1.01" alt="quiz event"></span>
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
                <input type="text" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" title="검색어 입력" placeholder="정답을 입력해주세요!" maxlength="5" onkeyup="chkword(this,10);" autocomplete="off"/>
                <button class="submit" onClick="jsSubmitComment(document.frmcom);return false;">등록하기</button>
                <p class="now-txt"><span id="nowtxt">0</span>/5</p>
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
                        <p class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
                        <p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
                    </div>
                    <div class="conts">정답은<br/><span><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></span><br/>입니다!</div>
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
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/img_notice.jpg" alt="유의사항">
    </div>
    <div class="bnr-float"><a href="/culturestation/" onclick="fnAmplitudeEventMultiPropertiesAction('click_floatingbanner_in_event','eventcode','<%=eCode%>');"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95815/bnr.png" alt="다양한 문화생활 즐기러 가기"></a></div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->