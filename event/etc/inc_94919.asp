<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : JAJU 2차 이벤트
' History : 2019-05-31 최종원 생성
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

    evtStartDate = Cdate("2019-05-31")
    evtEndDate = Cdate("2019-06-12")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  94919
Else
	eCode   =  94919
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
<style type="text/css">
.evt94919 {background-color: #f2fee8;}
.evt94919,.evt94919>div{position: relative;}

.topic {height: 600px; background: #e0fbea url(//webimage.10x10.co.kr/fixevent/event/2019/94919/bg_top.jpg) no-repeat 50% 0;overflow: hidden;transition-duration: .8s; transition-timing-function: ease-out}
.inner {position: relative; width: 1140px; margin: 0 auto;}
.topic p,.topic span,.topic em {position: absolute;}
.topic p {right: 0; top: 30px}
.topic .tit1 {top: 110px; left: 0;}
.topic .tit2 {top: 155px; left: 0;}
.topic .tit3 {top: 345px; left: 0;}
.topic em {top: 220px; left: 280px; transform: scale(0);  transition: transform .6s 1.5s  cubic-bezier(0.18, 0.89, 0.32, 1.28); transform-origin:left bottom}
.topic.on em {transform: scale(1)}
.topic div span {display: block; transform:skewX(-10deg); transition-duration: 1.6s}
.topic.on div span {transform:skewX(0)}
.topic span.delay2 {transition-delay: .2s}
.topic span.delay3 {transition-delay: .5s}

.slide-area {padding: 50px 0; background-color: #fff;}
.slide1 {width: 1140px; height: 520px; margin: 0 auto 30px;}
.slide1 .slick-slide {display:block; float:left; height:100%; outline:none}
.slide1 .slick-dots {position:absolute; left: 80px;bottom: 65px; width: 150px;  z-index:999;}
.slick-dots li button {width:150px; height: 55px;}
.slick-arrow {display: inline-block; width: 40px; height: 40px; bottom: 90px; right:55px;}
.slick-arrow.slick-prev {right: 95px;}

.cmt-evt {background-color: #f2fee8;}
.cmt-evt .imgbx-area {width: 1140px; margin: 0 auto;}
.cmt-evt .imgbx-area:after {content: ''; display: block; clear: both;}


.cmt-area {font-family:"malgun Gothic","맑은고딕";}
.cmt-area .input-box {position:relative;  width:1140px; height: 300px; padding-top: 43px; margin: 0 auto; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94919/bg_input.jpg); background-repeat: no-repeat;}
.cmt-area .input-box textarea {display: inline-block; width:770px; height:190px; margin-top: 25px; box-sizing: border-box; border:0; color:#444; font-size:16px; line-height:1.4; font-weight:bold; vertical-align: top;}
.cmt-area .input-box textarea::-webkit-input-placeholder {color: #b1c1b0;} 
.cmt-area .input-box textarea:-moz-placeholder {color: #b1c1b0;} 
.cmt-area .input-box textarea::-moz-placeholder {color: #b1c1b0;} 
.cmt-area .input-box textarea:-ms-input-placeholder {color: #b1c1b0 !important;} 
.cmt-area .input-box textarea:focus::-webkit-input-placeholder {opacity: 0;} 
.cmt-area .input-box .submit {display: inline-block; width: 250px; height: 250px; text-indent: -9999px; background-color: transparent;}
.cmt-area .input-box .now-txt {position:absolute; bottom:65px; left:780px; z-index:150; color:#6aa781; font-size:14px;}

.cmt-list {padding: 50px 0 80px; margin-top: 50px; background-color: #dcf7e6;}
.cmt-list ul {width: 1170px; margin:0 auto;}
.cmt-list ul:after {content: ''; display: block; clear: both;}
.cmt-list li {position:relative; float:left; width:360px; height: 265px; margin:0 15px 30px; padding:25px 30px; color:#383838; font-size:16px; line-height:1; text-align:left; background-color:#fff; box-sizing: border-box;}
.cmt-list li .num {margin-bottom: 10px; color: #1ad160; font-weight:bold; }
.cmt-list li .conts {margin-bottom: 13px; font-size:14px; line-height:1.53; font-weight:500; word-wrap:break-word; word-break: break-all;}
.cmt-list li .writer {font-size:13px; color: #acb4c5;}
.cmt-list li .btn-area {position: absolute; right: 0; bottom: 0;}
.cmt-list li .btn-area button.delete {width: 53px; height: 40px; color: #35455f; background-color: #79f4a8;}
.cmt-list .paging a {margin: 0 10px;border:0;  background-color:transparent;}
.cmt-list .paging a span {min-width:20px; height:30px; padding:0; line-height: 16px; font-size:19px; color:#afccb9; font-family:'AvenirNext-DemiBold';}
.cmt-list .paging a.current {border-bottom:5px solid #1ad160;}
.cmt-list .paging a.current:hover {background-color:transparent ;}
.cmt-list .paging a.current span {color:#1ad160; transform: skewX(-5deg);}
.cmt-list .paging a:hover span {color: #1ad160;}
.cmt-list .paging a.arrow {width:30px; height:30px; margin-top: -5px; background-color:transparent; }
.cmt-list .paging a.arrow span {display:inline-block; }
.cmt-list .paging a.arrow span {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94919/btn_arrow.png); background-position: 0 0;}
.cmt-list .paging a.next span {transform: rotateY(180deg);}
.cmt-list .paging a.arrow.first,.cmt-list .paging a.arrow.end,.cmt-list .pageMove{display:none;}

.noti {position:relative; padding:50px 0; background-color:#50b074; color:#fff; font-size:15px; text-align:left; font-family:"malgun Gothic","맑은고딕"; }
.noti h5 {position:absolute; top:75px; left:50%; margin-top:-15px; margin-left:-420px; font-size: 20px; letter-spacing: -1px;}
.noti ul {width:1140px; margin:0 auto;}
.noti ul li {padding-left:399px; margin:10px 0; font-weight:500; font-size: 14px; text-indent:-12px;}

</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
    $('.topic').addClass('on')
	$('.slide1').slick({
        fade: true,
        dots: true,
        speed: 400,	
        autoplay: true,
        arrows: true,
        infinite:true,
        pauseOnHover: false,
    });

    $(window).scroll(function() {
        var st=$(this).scrollTop();
        var wh=window.innerHeight;
        $('.ani').each(function(){
            if( st>$(this).offset().top-wh && $(this).offset().top+wh>st ){
                $(this).addClass('on')
            }else{
                $(this).removeClass('on')
            }
        })
        $('.on.topic').css({'background-position-y':st*0.25+'px'});
    })
});
</script>
<script>
$(function() {
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
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("한 ID당 1회만 참여 가능합니다.");
				return false;
			<% else %>
                if(frm.txtcomm1.value == ""){
                    alert('내용을 넣어주세요.')
                    frm.txtcomm1.focus()
                    return false;
                }            
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

    <!-- 94919 jaju 써큘레이터 -->
    <div class="evt94919">
        <div class="topic ani">
            <div class="inner">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/img_logo.png" alt="ten by ten x jaju"/></p>
                <span class="tit1 delay1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/tit_jaju_01.png" alt="조용하고 편안한"/></span>
                <span class="tit2 delay2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/tit_jaju_02.png" alt="여름날의 바람선물"/></span>
                <span class="tit3 delay3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/tit_jaju_03.png" alt="당신의 조용하고 편안한 휴식 시간을 위해"/></span>
                <em><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/tit_jaju_04.png" alt="2탄"/></em>
            </div>
        </div>
        <div class="slide-area">
            <div class="slide1">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/img_slide_01.jpg" alt="리버스윈도"/></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/img_slide_02.jpg" alt="바람조절"/></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/img_slide_03.jpg" alt="4가지모드"/></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/img_slide_04.jpg" alt="리모컨"/></p>
            </div>
            <a href="/shopping/category_prd.asp?itemid=2365293&pEtr=94919"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/btn_more.jpg" alt="자세히 보러가기"/></a>
        </div>
        <div class="cmt-evt">
            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/img_cmt.jpg" alt="코멘트 이벤트"></p>
        </div>
        <!-- 코멘트 -->
        <div class="cmt-area">
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
                    <textarea class="" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="fnChkByte(this);" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> placeholder="띄어쓰기 포함 150자 이내로 적어주세요!"></textarea>
                    <button class="submit" onclick="jsSubmitComment(document.frmcom); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/91956/btn_submit.png" alt="등록하기" /></button>
                    <p class="now-txt"><span id="byteInfo">0</span> / 150자</p>
                </div>
            </form>    
            <form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
                <input type="hidden" name="eventid" value="<%=eCode%>">
                <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                <input type="hidden" name="bidx" value="<%=bidx%>">
                <input type="hidden" name="Cidx" value="">
                <input type="hidden" name="mode" value="del">
                <input type="hidden" name="pagereload" value="ON">
            </form>        
            <a href="http://www.sivillage.com/jaju/event/initEventDetail.siv?event_no=E190502448&partnerNm=jaju_10x10"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94919/btn_jaju.jpg" alt="자주에도 이벤트 참여하러 가기" /></a>
            <div class="cmt-list">
                <% IF isArray(arrCList) THEN %>            
                <ul>
                    <% For intCLoop = 0 To UBound(arrCList,2) %>
                    <li>
                        <p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
                        <div class="conts">
                            <%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>
                        </div>
                        <p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
                        <div class="btn-area">                            
                            <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                            <button class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;">삭제</button>
                            <% end if %>
                        </div>
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
        <!-- // 코멘트 -->

        <!-- 유의사항 -->
        <div class="noti">
            <h5>이벤트 유의사항</h5>
            <ul>
                <li>- 해당 이벤트는 로그인 후, 한 ID 당 1회만 참여할 수 있습니다.</li>
                <li>- 입력 완료된 댓글 내용은 수정이 불가합니다.</li>
                <li>- 통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며, 이벤트 참여에 제한을 받을 수 있습니다.</li>
                <li>- 이벤트 당첨자는 2019년 6월 14일 금요일 텐바이텐 공지사항에 기재 및 개별 연락 드릴 예정입니다.</li>
                <li>- 당첨된 고객께는 세무신고를 위해 개인정보를 요청할 수 있습니다. 제세공과금은 JAJU 부담입니다. </li>
                <li>- 당첨된 [바람, 선물]은 구성된 상품별로 각각 배송될 예정입니다.</li>
                <li>- JAJUX텐바이텐 이벤트 당첨 고객의 최소한의 개인정보는 경품 배송을 위해 양사에 제공될 수 있습니다. 배송된 후 개인정보는 즉시 파기 될 예정입니다.</li>
            </ul>
        </div>
    </div>
    <!-- // 94919 jaju 써큘레이터 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->