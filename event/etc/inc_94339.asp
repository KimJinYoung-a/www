<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 이웃집 토토로
' History : 2019-05-20 최종원 생성
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

    evtStartDate = Cdate("2019-05-20")
    evtEndDate = Cdate("2019-06-02")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  94339
Else
	eCode   =  94339
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
.evt94339, .evt94339>div {position: relative; background-color: #164596;}
.topic {height: 1427px; padding-top: 175px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94339/bg_top.jpg?v=1.01); background-position-x:50%; background-position-y:0; background-size: cover; box-sizing: border-box;}
.topic .inner {width: 1140px; height: 380px; margin: 0 auto 175px; text-align: left;}
.topic h2 {position: relative; margin: 35px 0 50px; transition-delay: .4s}
.topic h2:after {content: ''; position: absolute; display: block; top: -40px; left: 260px; width: 50px; height: 47px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94339/img_dust.png);  }
.totoro-vod {margin-bottom: 20px;}
.totoro-vod iframe {box-shadow: 0px 8px 20px 4px #060f2fab;}
.totoro-info {height: 655px; background: #1a376f url(//webimage.10x10.co.kr/fixevent/event/2019/94339/bg_info.jpg?v=1.01) no-repeat 50% 0;}
.totoro-synopsis {height: 1251px; padding-top: 190px; background: #164593 url(//webimage.10x10.co.kr/fixevent/event/2019/94339/img_sn.jpg?v=1.01) no-repeat 50% 0; box-sizing: border-box;}
.totoro-synopsis .slide1 {width: 890px; height: 500px; margin: 0 auto; box-shadow: 0px 8px 20px 7px #060f2f3b;}
.from-top {transform: translateY(100px); opacity: 0; transition-duration: 2s}
.from-top.on {transform: translateY(0); opacity: 1;}
.totoro-card {background-color: #1d3481; padding-bottom: 75px;}
.cmt-area {height: 905px; padding-top: 472px; background:#1d3480 url(//webimage.10x10.co.kr/fixevent/event/2019/94339/img_slt.jpg?v=1.01) no-repeat 50% 0; box-sizing: border-box;}
.cmt-area .radio-area input {position: absolute;left: -9999px;}
.cmt-area .radio-area label{position: relative; display: inline-block; cursor: pointer; width: 257px; height: 183px; margin: 0 2px;}
.cmt-area .radio-area label:before {content: '';display: inline-block;position: relative; width: 19px;height: 20px; background-color: transparent; background-repeat: no-repeat;}
.cmt-area .radio-area input:checked+label:before{background-image: url('//webimage.10x10.co.kr/fixevent/event/2019/94339/ico_check.png');}
.cmt-area form {width: 1140px; margin: auto; padding-top: 48px; text-indent: 32px;}
.cmt-area form input {width: 248px; height: 40px; margin-top: 8px; font-family: 'AvenirNext-Regular'; font-size: 25px; background-color: transparent;}\
.cmt-area form textarea::-moz-placeholder {color: #999;}
.cmt-area form textarea:-ms-input-placeholder {color: #999;}
.cmt-area form textarea:-moz-placeholder {color: #999;}
.cmt-area form textarea::-webkit-input-placeholder {color: #999;}
.cmt-area form a {margin-left: 130px;}
.cmt-area form input:focus::placeholder  {opacity: 0;} 
.cmt-list ul {width: 1104px; margin: 0 auto;}
.cmt-list li {position: relative; display: inline-block; width: 333px; height: 320px; padding: 30px 31px 29px;  margin: 0 16px 30px 16px; background-color: #f4fbff; box-sizing: border-box;}
.cmt-list li:nth-child(2n) {background-color: #fff4f8;}
.cmt-list li .desc {    overflow: hidden;    font-family: verdana;}
.cmt-list li .desc .num {    float: left;    font-weight: bold; font-size: 17px;}
.cmt-list li .desc .writer {    float: right; font-size: 14px;}
.cmt-list .conts {font-size: 20px; font-family: 'AppleSDGothicNeo-Medium';color:#383838;}
.cmt-list .conts span {display: block; margin: 14px 0 24px;}
.cmt-list .conts p  {line-height: 1.2; color: #004cf7; }
.cmt-list li:nth-child(2n) .conts p {color: #f40056;}
.cmt-list .conts:after {content: '토토로';}
.cmt-list li .delete {position: absolute; top: 0; right: 0;}
.cmt-list .paging {height:34px;}
.cmt-list .paging a {height:34px; line-height:34px; border:0; font-weight:bold; background-color:transparent;}
.cmt-list .paging a span {width:34px; height:34px; padding:0; font-size:16px; color:#aabdfc; font-family:"malgun Gothic","맑은고딕";}
.cmt-list .paging a.current {background-color:#ff5ab7; border:0; color:#fff; border-radius:580%;}
.cmt-list .paging a.current span {color:#fff;}
.cmt-list .paging a.current:hover {background-color:#ff5ab7;}
.cmt-list .paging a:hover {background-color:transparent;}
.cmt-list .paging a.arrow {width:29px; height:34px; margin:0 8px; background-color:transparent;}
.cmt-list .paging a.arrow span {display:inline-block; width:28px; height:28px; margin-bottom:2px; background-size:100%; background-position:0 0;}
.cmt-list .paging a.arrow.first,
.cmt-list .paging a.arrow.end{display:none;}
.cmt-list .paging a.arrow span {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94339/btn_prev.png);}
.cmt-list .paging a.arrow.next span {transform: rotateY(180deg);}
.cmt-list .pageMove {display:none;}
.cmt-list .conts p  {height:24px}
.totoro-notice {background-color: #21273b;}
html{scroll-behavior: smooth;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
    $('.from-top').addClass('on');
    $('.slide1').slick({
        fade: true,
        infinite:true,
        autoplay: true,
        pauseOnHover: false,
    });

    $('input[name=totoroImg]').click(function(){	        
        $("#spoint").val($(this).val())
    })    
})
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
                    alert('내용을 넣어주세요')
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
</script>
                            <!-- 94339 컬쳐스테이션 이웃집 토토로 -->
                            <div class="evt92632">
                                <div class="topic ani">
                                    <div class="inner">
                                        <p class="from-top"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/tit_sub.png" alt="전 세계를 사로잡은 사랑스러운 판타지"></p>
                                        <h2 class="from-top"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/tit_totoro.png" alt="이웃집 토토로"></h2>
                                        <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/txt_top.png?v=1.01" alt="텐바이텐과 영화 <이웃집 토토로>가 함께하는 이벤트! 시사회 관람권 응모하고, 이웃집 토토로 상품들도 만나보세요"></span>
                                    </div>
                                    <div class="totoro-vod">
                                        <iframe width="864" height="486" src="https://www.youtube.com/embed/8LLmvVSnYiw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                    </div>
                                    <div class="btn-area">
                                        <a href="#totoro-card"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/btn_evt.png" alt="이벤트 참여하기"></a>
                                        <a href="#groupBar1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/btn_goods.png" alt="이웃집 토토로 굿즈 구경하기"></a>
                                    </div>
                                </div>
                                <div class="totoro-info">
                                </div>
                                <div class="totoro-synopsis">
                                    <div class="slide1">
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/img_slide_01.jpg" alt="" /></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/img_slide_02.jpg" alt="" /></div>
                                        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/img_slide_03.jpg" alt="" /></div>
                                    </div>
                                </div>
                                <div class="totoro-card" id="totoro-card">
                                    <div class="cmt-area">
                                        <div class="radio-area">
                                            <span>
                                                <input type="radio" name="totoroImg" value="1" checked="checked" id="totoro-01"/>
                                                <label for="totoro-01"></label>
                                            </span>
                                            <span>
                                                <input type="radio" name="totoroImg" value="2" id="totoro-02"/> 
                                                <label for="totoro-02"></label>
                                            </span>
                                            <span>
                                                <input type="radio" name="totoroImg" value="3" id="totoro-03"/> 
                                                <label for="totoro-03"></label>
                                            </span>
                                            <span>
                                                <input type="radio" name="totoroImg" value="4" id="totoro-04"/> 
                                                <label for="totoro-04"></label>
                                            </span>
                                        </div> 
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
                                            <input type="text" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" title="검색어 입력" placeholder="내 어릴적 친구" maxlength="12" />
                                            <a href="javascript:jsSubmitComment(document.frmcom);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/btn_make.png" alt="포토카드 만들기" /></a>
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
                                        <!-- for dev msg :  9개씩 노출 -->
                                        <% IF isArray(arrCList) THEN %>            
                                        <ul>
                                            <% 
                                            dim tmpImgCode
                                            For intCLoop = 0 To UBound(arrCList,2) 

                                            tmpImgCode = Format00(2, arrCList(3,intCLoop))
                                            %>
											<li>
												<div class="desc">
													<p class="num">NO. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
													<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
												</div>
												<div class="conts">
                                                    <!-- 선택한 포토카드 이미지 --> <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/img_card_<%=tmpImgCode%>.jpg?v=1.01" ></span>
                                                    <!-- 입력한 텍스트 --> <p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
                                                </div>
                                                <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
												<a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>');" class="delete"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/btn_close.png" ></a>
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
                                <div class="totoro-notice">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/94339/img_notice.jpg" >
                                </div>
                            </div>
                            <!-- // 94339 컬쳐스테이션 이웃집 토토로 -->        
<!-- #include virtual="/lib/db/dbclose.asp" -->