<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 인스타그램 이벤트
' History : 2019-07-08
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim oItem
dim evtStartDate, evtEndDate, currentDate
	currentDate =  date()
    evtStartDate = Cdate("2019-08-19")
    evtEndDate = Cdate("2019-08-31")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90369
Else
	eCode   =  96367
End If

dim userid, commentcount, i , totalsubscriptcount , sqlstr
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

if (GetLoginUserID="greenteenz") or (GetLoginUserID="ley330") or (GetLoginUserID="rnldusgpfla") or (GetLoginUserID="motions") then
    '//전체 참여수
    sqlstr = "select count(*) as cnt"
    sqlstr = sqlstr & " from db_event.dbo.tbl_event_comment c with(nolock)"
    sqlstr = sqlstr & " where c.evt_code="& eCode &""
    rsget.Open sqlstr,dbget
    IF not rsget.EOF THEN
        totalsubscriptcount = rsget("cnt")
    END IF
    rsget.close
end if 

%>
<style type="text/css">
.evt96367 {position: relative; background-color: #fff; }
.evt96367 > div {position: relative; width: 1140px; margin: 0 auto;}
.evt96367 .pos {position: absolute;}
.topic .pos {top: 80px; left: 50%; margin-left: -420px;}
.topic p {font-size:56px; font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; font-weight: 400; line-height: 80px; color: #fff; text-align: left; animation: blink 3s steps(1) 20; animation-delay: 0s}
.topic p.delay {animation-delay: 1s}
.topic p.delay1 {animation-delay: 2s}
    @keyframes blink {
        from,66%,to {color: #fff;}
        33% {color: #ffd87a;}
    }
.insta-guide ul {text-align: center;}
.insta-guide li {display: inline-block; width: 365px; height: 580px; text-indent: -9999px; background-size: contain; background-repeat: no-repeat; background-position: 50% 0; transition-duration: .1s; transform: scale(.74)}
.insta-guide li.on {transform: scale(1)}
.insta-guide li:nth-child(1) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96367/img_guide_1.jpg?v=1.02);}
.insta-guide li:nth-child(2) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96367/img_guide_2.jpg?v=1.02);}
.insta-guide li:nth-child(3) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96367/img_guide_3.jpg?v=1.02);}
.insta-guide li.on:nth-child(1) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96367/img_guide_1_on.jpg?v=1.01);}
.insta-guide li.on:nth-child(2) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96367/img_guide_2_on.jpg?v=1.01);}
.insta-guide li.on:nth-child(3) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/96367/img_guide_3_on.jpg?v=1.01);}
.gift-area .pos {top: 220px; left: 42px;}
.gift-area a {display: inline-block; width: 208px; height: 240px; text-indent: -9999px;}
.insta-join div.pos {top: 248px; width: 100%; text-align: left;}
.insta-join div.pos a {display: inline-block; height: 65px; width: 210px; margin-left: 110px; text-indent: -9999px;}
.insta-join div.pos div {display: inline-block;}
.insta-join div.pos span.pos {top: -20px; left: 290px; animation: twinkle .9s steps(1) 40;}
    @keyframes twinkle{
        0% {opacity:1;}
        50% {opacity:0;}
    }
.input-box {width:275px; height: 65px; margin-left: 110px;}
.input-box input {width:205px; height:32px; margin-top: 17px; padding: 0 10px; background-color: transparent; box-sizing: border-box; border:0; color:#444; font-weight: bold; font-size:19px; font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; text-align: center; line-height: 40px; white-space: nowrap; vertical-align: top; overflow: hidden;}
.input-box input::-webkit-input-placeholder {color:#999; }
.input-box input:focus::-webkit-input-placeholder {opacity: 0;} 
.input-box .submit {display: inline-block; width: 65px; height: 65px; text-indent: -9999px; background-color: transparent;}
.prd-wrap div.pos {top: 0; width: 100%; padding-left: 300px; box-sizing: border-box;}
.prd-wrap div.pos ul {content: ''; display: block; clear: both;}
.prd-wrap div.pos li {float: left; width: 168px; height: 168px;}
.prd-wrap div.pos li a {display: block; height: 100%; text-indent: -9999px;}
.noti {position:relative; padding:50px 0; background-color:#ededed; text-align: center; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; font-size: 14px; }
.noti h3 {position: absolute; top: 50%; left: 50%; margin-left: -410px; font-family: inherit; font-weight: normal; font-size: 20px; color: #000; transform: translateY(-50%); }
.noti ul {position: relative; left: 50%; width:740px; margin-left: -270px; }
.noti ul li {padding-left: 11px; word-break:keep-all;  text-align: left; line-height: 2.1;}
.noti li:before {content: '-'; display: inline-block; width: 11px; margin-left: -11px;}
</style>
<script type="text/javascript" src="/lib/js/TweenMax.min.js"></script>
<script>
$(function(){
    $('.insta-guide li').hover(function (){
        console.log('ttt')
        var i=$(this).index();
        console.log(i)
		$('.insta-guide li').eq(i).addClass('on').siblings().removeClass('on')
    })
})
</script>
<script>
function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			if(frm.txtcomm.value == ""){
                alert('id를 입력해주세요.')
                frm.txtcomm.focus()
                return false;
            }            
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

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";
			return false;
		}
		return false;
	}
}
</script>
<% if (GetLoginUserID="greenteenz") or (GetLoginUserID="ley330") or (GetLoginUserID="rnldusgpfla") or (GetLoginUserID="motions") then %>
<div style="color:red">*스태프만 노출</div>
<div>전체 응모 수 : <%=totalsubscriptcount%></div>
<% end if %>
<!-- MKT_96367_#텐바이텐#인스타그램#팔로팔로미 -->
    <div class="evt96367">
        <div class="topic">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/96367/bg_top.jpg" alt="텐바이텐 인스타그램을 팔로우하신 분 중 추첨을 통해 10분께 선물이 팡! 팡!">
            <div class="pos">
                <p>#텐바이텐</p>
                <p class="delay">#인스타그램</p>
                <p class="delay1">#팔로팔로미</p>
            </div>
        </div>
        <div class="insta-guide">
            <ul>
                <li class="on">#다양한_상품_소식을</li>
                <li>#베스트_포토_후기</li>
                <li>#인스타그램_스토리_이벤트</li>
            </ul>
        </div>
        <div class="gift-area">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/96367/img_gift.jpg" alt="텐바이텐이 드리는 선물">
            <div class="pos">
                <a href="/shopping/category_prd.asp?itemid=2439464&pEtr=96367">상품 보러가기</a>
                <a href="/shopping/category_prd.asp?itemid=2369273&pEtr=96367">상품 보러가기</a>
                <a href="/shopping/category_prd.asp?itemid=2324114&pEtr=96367">상품 보러가기</a>
                <a href="/shopping/category_prd.asp?itemid=2242441&pEtr=96367">상품 보러가기</a>
                <a href="/shopping/category_prd.asp?itemid=2339541&pEtr=96367">상품 보러가기</a>
            </div>
        </div>
        <div class="insta-join">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/96367/img_join.jpg" alt="이벤트 참여 방법">
            <form name="frmcom" method="post" onSubmit="return false;" >
            <input type="hidden" name="eventid" value="<%=eCode%>">
            <input type="hidden" name="mode" value="add">
            <input type="hidden" id="spoint" name="spoint" value="1">
            <input type="hidden" name="alertTxt" value="당첨자 발표일을 기다려주세요.">
            <div class="pos">
                <a href="https://tenten.app.link/FpZ0TaRo8Y">팔로우</a>
                <span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96367/ico_click.png" alt="click"></span>
                <!-- 인스타 id 입력 -->
                <div class="input-box">
                    <input type="text" name="txtcomm" autocomplete="off" onClick="jsCheckLimit();" placeholder="ID를 입력해주세요">
                    <button class="submit" onClick="jsSubmitComment(document.frmcom);return false;" type="button">등록하기</button>                            
                </div>
            </div>
            </form>
        </div>
        <div class="prd-wrap">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/96367/img_prd.jpg" alt="텐바이텐 인스타그램 인기 상품 구경하기">
            <div class="pos">
                <ul>
                    <li><a href="/shopping/category_prd.asp?itemid=2383744&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BA%94%EB%94%94%EC%B9%B4%EB%A9%94%EB%9D%BC">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2369273&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2421868&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2339541&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2367258&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2420649&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2360312&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="http://www.10x10.co.kr/search/search_result.asp?rect=이딸라&cpg=1&extUrl=&tvsTxt=&">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2436410&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2242441&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2036806&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2330710&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2414079&pEtr=96367">상품 보러가기</a></li>
                    <li><a href="/shopping/category_prd.asp?itemid=2420121&pEtr=96367">상품 보러가기</a></li>
                </ul>
            </div>
        </div>
        <div class="noti">
            <h3>유의사항</h3>
            <ul>
                <li>해당 이벤트는 로그인 후 참여 가능합니다.</li>
                <li>등록된 인스타그램 ID가 확인되지 않거나 비공개일 경우, 당첨이 어려움을 알려드립니다.</li>
                <li>텐바이텐 인스타그램 팔로우 여부 확인 후 이벤트 상품이 지급됩니다.</li>
                <li>텐바이텐 인스타그램 팔로우 유지기간은 1개월이며, 1개월 이내 팔로우가 취소 될 경우 이벤트 상품 반환 요청이 될 수 있습니다.</li>
            </ul>
        </div>	
    </div>
    <!-- // MKT_96367_#텐바이텐#인스타그램#팔로팔로미 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->