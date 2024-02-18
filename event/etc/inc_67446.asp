<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' #사은품스타그램
' 2015-11-13 이종화 작성
'########################################################
Dim eCode , userid , strSql , todaycnt
Dim totcnt1 , totcnt2 , totcnt3 , totcnt4
Dim mycnt1 , mycnt2 , mycnt3 , mycnt4

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  65949
Else
	eCode   =  67446
End If
	
	'// 응모자 설정
	If IsUserLoginOK Then
		strSql = " select  "
		strSql = strSql & " isnull(sum(case when sub_opt2 = 1 then 1 else 0 end),0) as mycnt1 , "
		strSql = strSql & " isnull(sum(case when sub_opt2 = 2 then 1 else 0 end),0) as mycnt2 , "
		strSql = strSql & " isnull(sum(case when sub_opt2 = 3 then 1 else 0 end),0) as mycnt3 , "
		strSql = strSql & " isnull(sum(case when sub_opt2 = 4 then 1 else 0 end),0) as mycnt4  "
		strSql = strSql & " From [db_event].[dbo].[tbl_event_subscript] "
		strSql = strSql & " where evt_code = '"&eCode&"' and userid = '"&userid&"' "
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly 
		IF Not rsget.Eof Then
			mycnt1 = rsget(0)
			mycnt2 = rsget(1)
			mycnt3 = rsget(2)
			mycnt4 = rsget(3)
		End IF
		rsget.close()
	End If 

	strSql = " select  "
	strSql = strSql & " isnull(sum(case when sub_opt2 = 1 then 1 else 0 end),0) as totcnt1 , "
	strSql = strSql & " isnull(sum(case when sub_opt2 = 2 then 1 else 0 end),0) as totcnt2 , "
	strSql = strSql & " isnull(sum(case when sub_opt2 = 3 then 1 else 0 end),0) as totcnt3 , "
	strSql = strSql & " isnull(sum(case when sub_opt2 = 4 then 1 else 0 end),0) as totcnt4  "
	strSql = strSql & " From [db_event].[dbo].[tbl_event_subscript] "
	strSql = strSql & " where evt_code = '"&eCode&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly 
	IF Not rsget.Eof Then
		totcnt1 = rsget(0)
		totcnt2 = rsget(1)
		totcnt3 = rsget(2)
		totcnt4 = rsget(3)
	End IF
	rsget.close()

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.evt67446 {background:#fff;}
.itemCont {position:relative; width:1140px; margin:0 auto;}
.giftstagram {height:2490px; background:#d0e4e9 url(http://webimage.10x10.co.kr/eventIMG/2015/67446/bg_body.png) no-repeat 50% 0;}
.giftstagram h2 {position:absolute; left:50%; top:130px; margin-left:-389px;}
.giftstagram ol {text-align:left;}
.giftstagram li {position:absolute;}
.giftstagram li.g01 {left:82px; top:600px;}
.giftstagram li.g02 {left:652px; top:921px;}
.giftstagram li.g03 {left:10px; top:1361px;}
.giftstagram li.g04 {left:576px; top:1699px;}
.giftstagram li .num {padding-bottom:18px;}
.giftstagram .itemBox {position:relative;}
.giftstagram li.g03 .itemBox {margin-left:-67px;}
.giftstagram .itemBox .goPdt {display:block; position:absolute; left:10px; top:10px; width:448px; height:448px; text-indent:-9999px;}
.giftstagram li.g03 .itemBox .goPdt {left:77px;}
.giftstagram li .giftInfo {position:absolute; left:15px; top:475px; width:435px; }
.giftstagram li.g03 .giftInfo {left:82px;}
.giftstagram li .giftInfo .overHidden {padding:0 5px 14px; border-bottom:1px solid #eeefef;}
.giftstagram li .giftInfo .btnLike {display:inline-block; overflow:hidden; width:32px; margin:4px 22px 0 0; vertical-align:top; cursor:pointer;}
.giftstagram li .giftInfo .btnLike.on img {margin-left:-32px; transition:all .3s;}
.giftstagram li .giftInfo .posting {display:inline-block; margin:1px 0 0 0; vertical-align:top;}
.giftstagram li .giftInfo .like {margin:19px 0 0 10px; color:#6d6d6d; font-size:13px; line-height:13px; padding-left:19px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_heart02.png) no-repeat 0 1px;}
.giftstagram li .giftInfo .name {padding:15px 10px;}
.giftstagram li .giftInfo .relateTag {padding-left:10px; font-size:11px; color:#929292; word-spacing:5px;}
.evtNoti {height:355px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67446/bg_notice.png) repeat-x 0 0;}
.evtNoti h3 {padding:54px 0 24px;}
.evtNoti li {font-size:13px; line-height:14px; padding:0 0 10px 20px; color:#656565; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67446/blt_round.png) no-repeat 0 2px;}
.evtNoti li img {display:inline-block; margin-top:-5px;}
.evtNoti .instagram {position:absolute; right:0px; top:-25px;}
.evtNoti .instagram a {display:inline-block; position:absolute; left:-206px; top:109px;}
.bnr {padding-top:20px;}
.bnr span {padding-left:15px;}
</style>
<script type="text/javascript">
<!--
$(function(){
	function moveBalloon() {
		$(".instagram a").animate({"margin-left":"-8px"},600).animate({"margin-left":"0"},600, moveBalloon);
	}
	moveBalloon();
});

 function chklike(v){
	<% If IsUserLoginOK() Then %>
		var frm = document.frm
		frm.opt.value = v;
		frm.action = "/event/etc/doeventsubscript/doeventsubscript67446.asp";
		frm.submit();
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
 }
//-->
</script>
<form name="frm" method="get" onSubmit="return false;" style="margin:0px;">
<input type="hidden" name="opt" value=""/>
</form>
<div class="evt67446">
	<div class="giftstagram">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/tit_gift_stagram.png" alt="#사은품스타그램" /></h2>
		<div class="itemCont">
			<%' <!-- 사은품 좋아요 누르기 -->%>
			<ol>
				<li class="g01">
					<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/tit_gfit01.png" alt="#사은품1" /></p>
					<div class="itemBox">
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/img_gift01.png" alt="" /></div>
						<a href="/shopping/category_prd.asp?itemid=1212471&pEtr=<%=eCode%>" class="goPdt">상품 보러가기</a>
						<div class="giftInfo">
							<div class="overHidden">
								<p class="ftLt">
									<% '<!-- 선택 시 클래스 on 붙여주세요 --> %>
									<span class="btnLike <%=chkiif(mycnt1 = 1," on","")%>" onclick="chklike('1');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_heart.png" alt="좋아요 버튼" /></span>
									<a href="https://www.instagram.com/p/wlmYvWSRwU/?taken-by=your10x10" target="_blank" class="posting"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_balloon.png" alt="관련 포스팅 보기" /></a>
								</p>
								<a href="/shopping/category_prd.asp?itemid=1212471" class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/btn_view.png" alt="상품 보러가기" /></a>
							</div>
							<p class="like"><%=totcnt1%>명이 좋아합니다</p>
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/txt_candle.png" alt="플레이버 : 틴-캔들" /></p>
							<p class="relateTag">#향초 #혼자있고싶어 #감성돋는밤 #킁킁 #이게무슨냄새지 #내마음이타고있어</p>
						</div>
					</div>
				</li>
				<li class="g02">
					<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/tit_gfit02.png" alt="#사은품2" /></p>
					<div class="itemBox">
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/img_gift02.png" alt="" /></div>
						<a href="/shopping/category_prd.asp?itemid=1371651&pEtr=<%=eCode%>" class="goPdt">상품 보러가기</a>
						<div class="giftInfo">
							<div class="overHidden">
								<p class="ftLt">
									<span class="btnLike <%=chkiif(mycnt2 = 1," on","")%>" onclick="chklike('2');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_heart.png" alt="좋아요 버튼" /></span>
									<a href="https://www.instagram.com/p/9pAu_wSR3v/?taken-by=your10x10" target="_blank" class="posting"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_balloon.png" alt="관련 포스팅 보기" /></a>
								</p>
								<a href="/shopping/category_prd.asp?itemid=1371651" class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/btn_view.png" alt="상품 보러가기" /></a>
							</div>
							<p class="like"><%=totcnt2%>명이 좋아합니다</p>
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/txt_figure.png" alt="데꼴:크리스마스 피규어" /></p>
							<p class="relateTag">#decole #christmas #키덜트 #딩가딩가 #먹고놀자 #아무것도하고싶지않다</p>
						</div>
					</div>
				</li>
				<li class="g03">
					<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/tit_gfit03.png" alt="#사은품3" /></p>
					<div class="itemBox">
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/img_gift03.png" alt="" /></div>
						<a href="/shopping/category_prd.asp?itemid=1381298&pEtr=<%=eCode%>" class="goPdt">상품 보러가기</a>
						<div class="giftInfo">
							<div class="overHidden">
								<p class="ftLt">
									<span class="btnLike <%=chkiif(mycnt3 = 1," on","")%>" onclick="chklike('3');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_heart.png" alt="좋아요 버튼" /></span>
									<a href="https://www.instagram.com/p/-BHLocyR_u/?taken-by=your10x10" target="_blank" class="posting"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_balloon.png" alt="관련 포스팅 보기" /></a>
								</p>
								<a href="/shopping/category_prd.asp?itemid=1381298" class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/btn_view.png" alt="상품 보러가기" /></a>
							</div>
							<p class="like"><%=totcnt3%>명이 좋아합니다</p>
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/txt_magnet.png" alt="서커스보이밴드:마그넷" /></p>
							<p class="relateTag">#내방에붙일래 #책상에놓자 #자석 #마그넷 #방글방글웃자 #smile</p>
						</div>
					</div>
				</li>
				<li class="g04">
					<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/tit_gfit04.png" alt="#사은품4" /></p>
					<div class="itemBox">
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/img_gift04.png" alt="" /></div>
						<a href="/shopping/category_prd.asp?itemid=1114756&pEtr=<%=eCode%>" class="goPdt">상품 보러가기</a>
						<div class="giftInfo">
							<div class="overHidden">
								<p class="ftLt">
									<span class="btnLike <%=chkiif(mycnt4 = 1," on","")%>" onclick="chklike('4');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_heart.png" alt="좋아요 버튼" /></span>
									<a href="https://www.instagram.com/p/5zlqROSRxF/?taken-by=your10x10" target="_blank" class="posting"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/ico_balloon.png" alt="관련 포스팅 보기" /></a>
								</p>
								<a href="/shopping/category_prd.asp?itemid=1114756" class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/btn_view.png" alt="상품 보러가기" /></a>
							</div>
							<p class="like"><%=totcnt4%>명이 좋아합니다</p>
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/txt_mirror.png" alt="쿨 이너프 스튜디오:더 미러" /></p>
							<p class="relateTag">#거울 #mirror #사과같은내얼굴 #호박같나 #미안하다 #여자코스프레</p>
						</div>
					</div>
				</li>
			</ol>
		</div>
	</div>
	<div class="evtNoti">
		<div class="itemCont">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/tit_notice.png" alt="이벤트공지사항" /></h3>
			<ul>
				<li>텐바이텐 사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다.(비회원 구매 증정 불가)</li>
				<li style="margin-top:5px;">텐바이텐 배송상품을 포함해야 사은품 선택이 가능합니다. <a href="/event/eventmain.asp?eventid=66572"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/btn_ten_delivery.png" alt="텐바이텐 배송상품 받으러 가기" /></a></li>
				<li>상품쿠폰, 보너스쿠폰, 할인카드 등의 사용 후 구매확정 금액이 6만원 이상 이어야 선택 가능 합니다.</li>
				<li>마일리지, 예치금, 기프트카드를 사용하신 경우는 구매확정 금액에 포함되어 사은품을 받으실 수 있습니다.</li>
				<li>각 상품 별 한정수량이므로, 조기에 소진 될 수 있습니다.</li>
				<li>텐바이텐 기프트카드를 구매하신 경우는 사은품 증정이 되지 않습니다.</li>
				<li>사은품은 텐바이텐 배송 상품과 함께 배송됩니다.</li>
				<li>환불이나 교환 시 최종 구매 가격이 사은품 수량 가능금액 미만이 될 경우, 사은품과 함께 반품해야 합니다.</li>
				<li>이벤트는 조기종료 될 수 있습니다.</li>
			</ul>
			<div class="instagram">
				<a href="http://www.instagram.com/your10x10" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/btn_follow.png" alt="지금 인스타그램에서 텐바이텐을 팔로우 해주세요! @YOUR10X10 바로가기" /></a>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/img_phone.jpg" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="bnr itemCont">
		<a href="/event/eventmain.asp?eventid=67567"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/bnr_hot_item.png" alt="금주의 핫 아이템이 한자리에!" /></a>
		<span>
			<% If Date() <= "2015-11-16" Then %>
			<a href="/event/eventmain.asp?eventid=67460"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/bnr_keyword01.png" alt="핫키워드 기획전 #아이폰6S" /></a>
			<% End If %>
			<% If Date() = "2015-11-17" Then %>
			<a href="/event/eventmain.asp?eventid=67518"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/bnr_keyword02.png" alt="핫키워드 기획전 #방한소품" /></a>
			<% End If %>
			<% If Date() = "2015-11-18" Then %>
			<a href="/event/eventmain.asp?eventid=67538"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/bnr_keyword03.png" alt="핫키워드 기획전 #보온" /></a>
			<% End If %>
			<% If Date() = "2015-11-19" Then %>
			<a href="/event/eventmain.asp?eventid=67460"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/bnr_keyword04.png" alt="핫키워드 기획전 #건조주의보" /></a>
			<% End If %>
			<% If Date() >= "2015-11-20" Then %>
			<a href="/event/eventmain.asp?eventid=67460"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67446/bnr_keyword05.png" alt="핫키워드 기획전 #BOTTLE" /></a>
			<% End If %>
		</span>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->