<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 사진찍냥? 투표하개!
' History : 2017-08-22 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID, sqlstr
dim votecnt1, votecnt2, votecnt3, votecnt4, votecnt5, votecnt6, votecnt7, votecnt8, votecnt9

IF application("Svr_Info") = "Dev" THEN
	eCode = "66415"
Else
	eCode = "79941"
End If

vUserID = getEncLoginUserID

'투표 카운터
sqlstr = "SELECT " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '1' then 1 else 0 end),0) as vote1, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '2' then 1 else 0 end),0) as vote2, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '3' then 1 else 0 end),0) as vote3, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '4' then 1 else 0 end),0) as vote4, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '5' then 1 else 0 end),0) as vote5, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '6' then 1 else 0 end),0) as vote6, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '7' then 1 else 0 end),0) as vote7, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '8' then 1 else 0 end),0) as vote8, " + vbcrlf
sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '9' then 1 else 0 end),0) as vote9 " + vbcrlf
sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"'  " 
rsget.Open sqlstr,dbget,1
IF Not rsget.Eof Then
	votecnt1 = rsget("vote1")
	votecnt2 = rsget("vote2")
	votecnt3 = rsget("vote3")
	votecnt4 = rsget("vote4")
	votecnt5 = rsget("vote5")
	votecnt6 = rsget("vote6")
	votecnt7 = rsget("vote7")
	votecnt8 = rsget("vote8")
	votecnt9 = rsget("vote9")
End If
rsget.close()
	
%>
<style>
.evt79941 {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/79941/bg_top.png) repeat-x 0 0;}
.inner {position:relative; width:1140px; margin:0 auto;}
.topic {height:639px; padding-top:140px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79941/bg_topic.jpg) no-repeat 50% 0;}
.vote {padding:130px 0 140px;}
.vote ul {overflow:hidden; width:1150px; margin:0 auto; padding:60px 0 10px;}
.vote li {float:left; width:20%; height:380px; cursor:pointer;}
.vote li:nth-child(6) {margin-left:10%;}
.vote li .photo {position:relative; width:200px; height:200px; margin:0 auto 18px;}
.vote li .photo img {width:200px;}
.vote li .count {display:inline-block; height:28px; padding:0 20px; margin-top:15px; font:bold 16px/28px dotum; color:#999; border:1px solid #999; border-radius:15px;}
.vote li .count i {display:inline-block; width:16px; height:13px; margin:-3px 7px 0 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79941/ico_heart.png) no-repeat 0 0; vertical-align:middle;}
.vote li:hover .photo:after,
.vote li.current .photo:after {content:''; display:inline-block; position:absolute; left:-1px; top:-1px; width:206px; height:206px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79941/bg_select.png) no-repeat 0 0;}
.vote li:hover .count,
.vote li.current .count {color:#fff; border-color:#d92631; background:#d92631;}
.vote li:hover .count i,
.vote li.current .count i {background-position:100% 0;}
.vote li p {height:20px; overflow:hidden;}
.gift {padding:95px 0 100px; background:#c2e5ed;}
.evtNoti {position:relative; padding:75px 0; text-align:left; background:#4e4e4e;}
.evtNoti h3 {position:absolute; left:126px; top:50%; margin-top:-13px;}
.evtNoti ul {overflow:hidden; padding-left:450px;}
.evtNoti li {padding:0 0 0 11px; line-height:24px; color:#fff; text-indent:-11px;}
</style>
<script>
$(function(){
	$(".vote li").click(function(){
		$(".vote li").removeClass("current");
		$(this).addClass("current");
	});
});

function fnVote() {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	var reStr;
	var voteval = $("#voteval").val();
		if(voteval > 0 && voteval < 10 ){
		}else{
			alert('투표할 친구를 선택해 주세요.');
			return;
		}
	var str = $.ajax({
		type: "GET",
		url:"/event/etc/doeventsubscript/doEventSubscript79941.asp",
		data: "mode=vote&voteval="+voteval,
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "vt") {
				<% if date() = "2017-08-30" then %>
					alert('이벤트에 응모하셨습니다.\n당첨일을 기대해 주세요!');
					$("#votecnt1").empty().html("<i></i>"+reStr[2]);
					$("#votecnt2").empty().html("<i></i>"+reStr[3]);
					$("#votecnt3").empty().html("<i></i>"+reStr[4]);
					$("#votecnt4").empty().html("<i></i>"+reStr[5]);
					$("#votecnt5").empty().html("<i></i>"+reStr[6]);
					$("#votecnt6").empty().html("<i></i>"+reStr[7]);
					$("#votecnt7").empty().html("<i></i>"+reStr[8]);
					$("#votecnt8").empty().html("<i></i>"+reStr[9]);
					$("#votecnt9").empty().html("<i></i>"+reStr[10]);
				<% else %>
					alert('소중한 한 표 감사합니다!\n내일 또 투표해주세요!');
					$("#votecnt1").empty().html("<i></i>"+reStr[2]);
					$("#votecnt2").empty().html("<i></i>"+reStr[3]);
					$("#votecnt3").empty().html("<i></i>"+reStr[4]);
					$("#votecnt4").empty().html("<i></i>"+reStr[5]);
					$("#votecnt5").empty().html("<i></i>"+reStr[6]);
					$("#votecnt6").empty().html("<i></i>"+reStr[7]);
					$("#votecnt7").empty().html("<i></i>"+reStr[8]);
					$("#votecnt8").empty().html("<i></i>"+reStr[9]);
					$("#votecnt9").empty().html("<i></i>"+reStr[10]);
				<% end if %>
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			document.location.reload();
			return false;
		}
	<% End If %>
}

function fnVoteval(vval){
	if(vval > 0 && vval < 10 ){
		$("#voteval").val(vval);
	}else{
		$("#voteval").val(1);
	}
}


</script>
	<!-- 사진찍냥? 투표하개! -->
	<div class="evt79941">
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/tit_cat_dog.png" alt="사진찍냥? 투표하개!" /></h2>
		</div>
		<!-- 투표하기 -->
		<div class="vote">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_vote.png" alt="SNS 사전 이벤트에서 선택받은 행운의 주인공을 소개합니다 당신의 마음을 사로잡는 친구에게 투표해주세요!" /></p>
			<ul>
				<li onclick="fnVoteval(1);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_1.jpg" alt="두부 (3살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_1.png" alt="최근 크게 아팠던 두부, 예쁜 사진 많이 남기고 싶어요!" /></p>
					<span class="count" id="votecnt1"><i></i><%=votecnt1%></span>
				</li>
 
				<li onclick="fnVoteval(2);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_2.jpg" alt="무무 (2살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_2.png" alt="처음에 부모님이 반대했지만 지금은 사랑받는 애교둥이에요!" /></p>
					<span class="count" id="votecnt2"><i></i><%=votecnt2%></span>
				</li>

				<li onclick="fnVoteval(3);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_3.jpg" alt="복댕이 (4살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_3.png" alt="길쭉한 다리가 매력적인 댕이! 이름처럼 행복을 주는 아이예요!" /></p>
					<span class="count" id="votecnt3"><i></i><%=votecnt3%></span>
				</li>

				<li onclick="fnVoteval(4);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_4.jpg" alt="샤로 (5살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_4.png" alt="미모가 아름다운 샤로님의 모습을 전문가의 손길로 남기고 싶어요!" /></p>
					<span class="count" id="votecnt4"><i></i><%=votecnt4%></span>
				</li>

				<li onclick="fnVoteval(5);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_5.jpg" alt="시월 (10개월)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_6.png" alt="수수와 1년 정도 함께 지냈던 부모님께 사진을 선물하고 싶어요!" /></p>
					<span class="count" id="votecnt5"><i></i><%=votecnt5%></span>
				</li>

				<li onclick="fnVoteval(6);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_6.jpg" alt="수수 (3살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_8.png" alt="자라면서 모색이 사라지는 꼬똥, 어릴 적 모습을 남기고 싶어요!" /></p>
					<span class="count" id="votecnt6"><i></i><%=votecnt6%></span>
				</li>

				<li onclick="fnVoteval(7);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_7.jpg" alt="앵두 (2살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_7.png" alt="나의 첫 강아지 앵두와 소중한 추억을 남기고 싶어요!" /></p>
					<span class="count" id="votecnt7"><i></i><%=votecnt7%></span>
				</li>

				<li onclick="fnVoteval(8);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_8.jpg" alt="지봉이 (9개월)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_5.png" alt="5번의 파양과 학대를 받았던 시월이 밝아진 지금의 모습을 남기고 싶어요!" /></p>
					<span class="count" id="votecnt8"><i></i><%=votecnt8%></span>
				</li>

				<li onclick="fnVoteval(9);">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_candidate_9.jpg" alt="이하윤 (2살)" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_name_9.png" alt="나에게 새로운 세상을 열어준 소중한 하윤이 모습을 남기고 싶어요!" /></p>
					<span class="count" id="votecnt9"><i></i><%=votecnt9%></span>
				</li>
			</ul>
			<input type="hidden" name="voteval" id="voteval" value="" >
			<button type="button"  onclick="fnVote(); return false;" class="btnVote"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/btn_vote.png" alt="투표하기" /></button>
			<p class="tPad25"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/txt_tip.png" alt="한 ID당 1일 1회 참여 가능" /></p>
		</div>
		<!--// 투표하기 -->
		<div class="gift">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/79941/img_gift.jpg" alt="1,2,3등에게는 땡큐 스튜디오 촬영권을 4~9등에게는 반려동물 쿠션을 드리며 투표 참여자 중 추첨을 통해 텐바이텐 기프트카드 1만원권을 드립니다." /></div>
		</div>
		<div class="evtNoti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79743/tit_noti.png" alt="이벤트 유의사항 " /></h3>
				<ul>
					<li>- 오직 텐바이텐 회원님을 위한 이벤트 입니다. (로그인 후 참여가능, 비회원 참여 불가)</li>
					<li>- 한 ID당 하루에 한 번만 참여할 수 있습니다.</li>
					<li>- 이벤트 당첨 상품 중 ‘땡큐스튜디오 촬영권’의 구성은 다음과 같습니다.<br/ >(전문 리터칭 6장 이미지 파일, 5x7 4장 프린트, 찍은 사진이 담긴 커스텀 휴대폰 케이스, 원본파일 제공)</li>
					<li>- [땡큐스튜디오 촬영권] 사용방법은 이벤트 당첨시에 공지 예정입니다.</li>
					<li>- 이벤트 경품은 내부 사정에 의해 변경될 수 있습니다.</li>
					<li>- 당첨자와 수령자는 동일해야 하며, 양도는 불가합니다.</li>
					<li>- 정확한 발표를 위해 마이텐바이텐의 개인정보를 업데이트 해주세요.</li>
					<li>- 이벤트 종료 후 당첨된 경품의 교환 및 변경은 불가 합니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!--// 사진찍냥? 투표하개! -->
<!-- #include virtual="/lib/db/dbclose.asp" -->