<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 릴레이 마일리지
' History : 2017.09-12 허진원
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
dim eCode, sqlStr, userid
userid = getEncLoginUserid()

IF application("Svr_Info") = "Dev" THEN
	eCode = "66428"
Else
	eCode = "80389"
End If

dim iRstCnt, iRelayCnt, iOrdPrice, iOrdPer, iOrdRemain, lp
dim arrCplDt(10), arrRelNo(10), arrPrvDt(10)

iRelayCnt = 0			'연속 구매 횟수
iOrdPrice = 0			'이번달 구매금액
iOrdRemain = 100000		'달성까지 필요한 구매금액
iOrdPer = 0				'이번달 달성현황

''userid="0anamure0"

if userid<>"" then
	'// 과거 연속 구매현황 확인
	sqlStr = "select top 10 * from db_temp.dbo.tbl_relaymile_info"
	sqlStr = sqlStr & "	where userid='"&userid&"' "
	sqlStr = sqlStr & "		and isUsing='Y' "
	sqlStr = sqlStr & "		and isComplete='Y' "
	sqlStr = sqlStr & "		and relayCount>0 "
	sqlStr = sqlStr & "		and yyyymm>=( "
	sqlStr = sqlStr & "			select max(yyyymm) "
	sqlStr = sqlStr & "			from db_temp.dbo.tbl_relaymile_info "
	sqlStr = sqlStr & "			where userid='"&userid&"' "
	sqlStr = sqlStr & "				and isUsing='Y' "
	sqlStr = sqlStr & "				and isComplete='Y' "
	sqlStr = sqlStr & "				and relayCount=1 "
	sqlStr = sqlStr & "		) "
	sqlStr = sqlStr & "	order by yyyymm "
	rsget.CursorLocation = adUseClient
    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly

	if Not(rsget.EOF or rsget.BOF) then
		iRstCnt = rsget.recordCount
		for lp=1 to iRstCnt
			arrCplDt(lp) = left(rsget("completeDate"),10)	'달성일
			arrRelNo(lp) = rsget("relayCount")				'회차
			arrPrvDt(lp) = left(rsget("dueDate"),10)		'지급일
			rsget.MoveNext
		Next
	end if
    rsget.Close

	'// 이번달 결제 현황 확인
	sqlStr = "select top 1 * "
	sqlStr = sqlStr & "	from db_temp.dbo.tbl_relaymile_info "
	sqlStr = sqlStr & "	where userid='"&userid&"' "
	sqlStr = sqlStr & "		and isUsing='Y' "
	sqlStr = sqlStr & "		and yyyymm=convert(varchar(7),getdate(),21) "
	rsget.CursorLocation = adUseClient
    rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly

    if Not(rsget.EOF or rsget.BOF) then
		iRelayCnt = rsget("relayCount")
		iOrdPrice = rsget("orderTotal")
		iOrdRemain = chkIIF(100000-iOrdPrice>0,100000-iOrdPrice,0)
		iOrdPer = formatNumber(100-iOrdRemain/1000,1)
	end if
    rsget.Close

	'현재 참여는 없지만 과거(지난달)에 있다면 최종 참여 기록 추가
	if iRelayCnt=0 and iRstCnt>0 then
		if arrCplDt(iRstCnt)<>"" and datediff("m",arrCplDt(iRstCnt),date)=1 then
			iRelayCnt = arrRelNo(iRstCnt)
		end if
	end if
end if
%>
<style type="text/css">
.relayMileage {position:relative; background-color:#fff;}
.relayMileage .inner {position:relative; width:1140px; margin:0 auto;}
.relayMileage .btnTen {display:inline-block; height:24px; padding:0 18px 0 8px; color:#fff; font-size:13px; line-height:24px; font-weight:bold; background:#e85635 url(http://fiximage.10x10.co.kr/web2013/common/blt_btn_arr_white02.gif) no-repeat 95% 50%;text-decoration:none;}
.topic {position:relative; height:600px; background:#69d134 url(http://webimage.10x10.co.kr/eventIMG/2017/80389/bg_topic_v2.png) no-repeat 50% 0;}
.topic h2 {position:absolute; left:50%; top:177px; margin-left:-198px;}
.topic p {position:absolute;}
.topic .relay {left:50%; top:100px; margin-left:-195px;}
.topic .subcopy {left:50%; top:417px; margin-left:-172px;}
.topic .btnDeliver {position:absolute; left:67px; top:41px;}
.topic .btnMethod {position:absolute; right:65px; top:244px; z-index:20; animation:swinging 1.6s 50;}
.topic .coin {position:absolute; left:50%; top:375px; width:160px; height:160px; margin-left:315px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/img_move_coin.gif) no-repeat 0 0;}
.myShopping {padding:70px 0 80px; background-color:#444859;}
.myShopping ul {overflow:hidden; padding:0 10px;}
.myShopping li {float:left; width:248px; height:157px; margin:0 15px; padding-top:31px; text-align:center; border:1px solid #bdbdc2; background-color:#fff;}
.myShopping li p {width:175px; height:58px; margin:0 auto 24px; padding-top:15px; border-bottom:1px solid #bdbdc2;}
.myShopping li:last-child p {height:73px; padding:0;}
.myShopping li em {color:#e95938; font:bold 27px/29px arial,'malgun gothic';}
.myShopping li:nth-child(odd) em {color:#2fa134;}
.myShopping .btnTen {position:absolute; right:25px; top:213px;}
.getMileage {position:relative; width:1059px; margin:118px auto 133px;}
.getMileage .start {position:absolute; left:-6px; top:10px; z-index:50;}
.getMileage ol {position:relative; height:840px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/img_map.png) no-repeat 0 0;}
.getMileage ol:before {content:''; display:inline-block; position:absolute; left:-36px; top:47px; z-index:10; width:112px; height:106px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/img_coin.png) no-repeat 0 0;}
.getMileage li {position:absolute; background-position:0 0; background-repeat:no-repeat;}
.getMileage li div {display:none; position:absolute; right:0; bottom:67px; width:182px; text-align:center; color:#fed967; font:bold 11px/17px verdana,dotum;}
.getMileage li.success div {display:block;}
.getMileage li.last:after {content:''; display:inline-block; position:absolute; right:0; top:-75px; width:145px; height:115px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/img_success_man.png) 0 0 no-repeat;}
.getMileage li.month1.success {left:-46px; top:0; z-index:10; width:421px; height:213px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_1_v2.png);}
.getMileage li.month2.success {left:370px; top:0; z-index:20; width:250px; height:213px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_2.png);}
.getMileage li.month3.success {left:611px; top:0; z-index:30; width:250px; height:213px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_3.png);}
.getMileage li.month4.success {right:0; top:79px; z-index:40; width:211px; height:286px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_4.png);}
.getMileage li.month5.success {right:28px; top:303px; z-index:30; width:350px; height:213px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_5.png);}
.getMileage li.month6.success {left:439px; top:302px; z-index:40; width:250px; height:214px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_6.png);}
.getMileage li.month7.success {left:196px; top:302px; z-index:40; width:250px; height:214px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_7.png);}
.getMileage li.month8.success {left:43px; bottom:21px; z-index:50; width:400px; height:517px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_8.png);}
.getMileage li.month9.success {left:369px; bottom:21px; z-index:60; width:250px; height:213px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_9.png);}
.getMileage li.month10.success {right:158px; bottom:0; z-index:70; width:284px; height:254px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_success_10.png);}
.getMileage li.month1 div {bottom:85px;}
.getMileage li.month5 div {right:170px;}
.getMileage li.month6 div,.getMileage li.month7 div,.getMileage li.month8 div {right:67px;}
.getMileage li.month10 div {bottom:82px; width:220px; color:#fff;}
.getMileage li.month4.success:after {top:0;}
.getMileage li.month5.success:after {right:170px;}
.getMileage li.month6.success:after,.getMileage li.month7.success:after {right:70px;}
.getMileage li.month8.success:after {right:70px; top:230px;}
.getMileage li.month10.success:after {right:-64px; top:-15px; width:285px; height:231px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/img_finish_man.png);}
.process {padding:75px 0; background-color:#5fb732;}
.process h3 {position:absolute; left:88px; top:60px;}
.process ul {width:722px; height:150px; margin-left:323px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_process.png) no-repeat 0 0;}
.process li {text-align:left; text-indent:-999em;}
.process .btnTen {position:absolute; left:343px; top:99px;}
.noti {padding:55px 0; background:#444859;}
.noti h3 {position:absolute; left:58px; top:50%; margin-top:-15px;}
.noti ul {padding-left:324px; text-align:left; color:#fff; line-height:25px;}
.noti li {text-indent:-10px; padding-left:10px;}
@keyframes swinging {
	from,to {transform:rotate(0); }
	50% {transform: translate(10px,0px) rotate(7deg);}
}
</style>
<script type="text/javascript">
$(function(){
	$('.getMileage li.success').last().addClass('last');
	$(".topic .btnMethod").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});
</script>
<!-- 릴레이 마일리지 -->
<div class="evt80389 relayMileage">
	<div class="topic">
		<div class="inner">
			<p class="relay"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_event.png" alt="10만원 x 10개월 연속구매 이벤트" /></p>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/tit_mileage.png" alt="릴레이 마일리지" /></h2>
			<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_buy.png" alt="매달 텐텐 배송상품을 10만원 이상 구매하고  릴레이 마일리지 혜택 받아가세요!" /></p>
			<a href="eventmain.asp?eventid=80481" class="btnDeliver"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/btn_ten_delivery.png" alt="텐텐 배송 상품 보러가기" /></a>
			<a href="#process" class="btnMethod"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/btn_method.png" alt="참여방법 보러가기" /></a>
			<div class="coin"></div>
		</div>
	</div>

	<!-- 구매현황 -->
	<div class="myShopping">
		<div class="inner">
			<ul>
				<li class="my1">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_continuously.png" alt="연속 구매현황" /></p>
					<em><%=chkIIF(iRelayCnt>0,iRelayCnt&"개월","-")%></em>
				</li>
				<li class="my2">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_price.png" alt="이번달 결제금액" /></p>
					<em><%=chkIIF(iOrdPrice>0,formatNumber(iOrdPrice,0)&"원","-")%></em>
				</li>
				<li class="my3">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_achieve.png" alt="이번달 달성현황" /></p>
					<em><%=iOrdPer%>%</em>
				</li>
				<li class="my4">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_need.png" alt="달성까지 필요한 결제금액" /></p>
					<em><%=formatNumber(iOrdRemain,0)%>원</em>
				</li>
			</ul>
			<a href="eventmain.asp?eventid=80481" class="btnTen">텐텐 배송상품 보러가기</a>
		</div>
	</div>

	<!-- 마일리지 지급 현황  -->
	<div class="getMileage">
		<p class="start"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/txt_start.png" alt="Start" /></p>
		<ol>
			<!-- 구매 릴레이 -->
		<%
			for lp=1 to 10
		%>
			<li class="month<%=lp & " " & chkIIF(lp<=iRelayCnt,"success","")%>">
				<div>
					<p>달성일 : <%=FormatDate(arrCplDt(lp),"0000/00/00")%></p>
					<% if lp>1 then %><p>지급일 : <%=FormatDate(arrPrvDt(lp),"0000/00/00")%></p><% end if %>
				</div>
			</li>
		<%
			next
		%>
		</ol>
	</div>

	<!-- 참여방법 -->
	<div id="process" class="process">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/tit_process.png" alt="참여방법" /></h3>
			<ul class="step">
				<li>STEP 01 : 텐텐배송 확인하기</li>
				<li>STEP 02 : 매달 10만원 이상  연속 구매하기</li>
				<li>STEP 03 : 매달 커지는 릴레이 마일리지 받기 </li>
			</ul>
			<a href="eventmain.asp?eventid=80481" class="btnTen">텐텐 배송상품 보러가기</a>
		</div>
	</div>

	<!-- 이벤트 유의사항 -->
	<div class="noti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80389/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 텐바이텐 배송 상품 결제액으로만 구매확정 금액이 10만원 이상이어야 참여 가능합니다.<br />(할인쿠폰, 할인카드 등의 사용 후 금액)</li>
				<li>- 이벤트 참여 첫 달에는 상품 마일리지 외 추가 마일리지가 지급되지 않습니다.</li>
				<li>- 결제완료 기준으로 매월 1일 0시부터 말일 23시59분까지입니다.(무통장 주문시 입금확인 기준)</li>
				<li>- 이벤트 참여 이후에 구매하지 않은 달이 생겼을 시, 연속구매 횟수는 처음부터 다시 카운트됩니다.</li>
				<li>- 구매횟수와는 상관없이 텐바이텐 배송상품으로 누적결제액이 10만원이상일 때 자동 달성됩니다.</li>
				<li>- 릴레이 마일리지는 달성일 이후 +20일차에 자동지급 됩니다.</li>
				<li>- 구매현황은 전일 주문기준입니다.(오늘 주문내역은 내일 오전 6부터 확인 가능합니다.)</li>
				<li>- 취소, 반품으로 인해 결제금액(10만원) 미달시, 릴레이 마일리지 지급 대상에서 제외됩니다.</li>
				<li>- 본 이벤트는 당사의 사정에 따라 조기종료될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>
<!--// 릴레이 마일리지 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->