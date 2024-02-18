<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : MIDORI 창립 66주년, 당신의 매일을 풍요롭게 하다
' History : 2015-12-18 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->

<%
Dim eCode, userid, sqlstr
Dim vTotalCount, selcount1, selcount2, selcount3, selcount4, selcount5
Dim selper1, selper2, selper3, selper4, selper5

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  65987
Else
	eCode   =  68207
End If

'// 총 카운트
sqlstr = "select count(*) "
sqlstr = sqlstr & " ,count(case when sub_opt2=1 then 1 end) as selcount1 "
sqlstr = sqlstr & " ,count(case when sub_opt2=2 then 1 end) as selcount2 "
sqlstr = sqlstr & " ,count(case when sub_opt2=3 then 1 end) as selcount3 "
sqlstr = sqlstr & " ,count(case when sub_opt2=4 then 1 end) as selcount4 "
sqlstr = sqlstr & " ,count(case when sub_opt2=5 then 1 end) as selcount5 "
sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
sqlstr = sqlstr & " where evt_code='"& eCode &"'  "
rsget.Open sqlstr, dbget, 1

If Not rsget.Eof Then
	vTotalCount =	rsget(0)
	selcount1	=	rsget(1)
	selcount2	=	rsget(2)
	selcount3	=	rsget(3)
	selcount4	=	rsget(4)
	selcount5	=	rsget(5)
End IF
rsget.close

IF isNull(vTotalCount)  then vTotalCount=0

'vTotalCount=100
'selcount1=0

if vTotalCount <> 0 then
	selper1 = Int( selcount1 * 100 / vTotalCount )
	selper2 = Int( selcount2 * 100 / vTotalCount )
	selper3 = Int( selcount3 * 100 / vTotalCount )
	selper4 = Int( selcount4 * 100 / vTotalCount )
	selper5 = Int( selcount5 * 100 / vTotalCount )
else
	selper1 = 0
	selper2 = 0
	selper3 = 0
	selper4 = 0
	selper5 = 0
end if

%>
<style type="text/css">
img {vertical-align:top;}
.evt68207 {background-color:#f7f7f7;}
.myMidori {height:1235px; background:#f8e3d3 url(http://webimage.10x10.co.kr/eventIMG/2015/68207/bg_paper.png) no-repeat 50% 245px;}
.myMidori ul {overflow:hidden; padding-left:70px;}
.myMidori ul li {position:relative; float:left; padding:0 19px; margin-bottom:30px;}
.myMidori ul li.pdt04 {margin-left:10px;}
.myMidori ul li.pdt04, .myMidori ul li.pdt05 {padding:0 9px;}
.myMidori ul li input {display:inline-block; position:absolute; left:50%; bottom:15px; margin-left:-6px;}
.myMidori .btnArea {padding:30px 0 65px;}
.myMidori .btnArea a {margin:0 20px;}
#layerVoteResult { width:849px; height:478px;}
.resultCont {position:fixed; z-index:99999; width:849px; height:478px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68207/bg_layer.png) no-repeat 0 0;}
.resultCont .lyrClose {right:27px; top:27px;}
.resultCont .inner {padding:65px 60px 0;}
.resultCont h3 {line-height:30px; padding-bottom:10px; margin-bottom:50px;border-bottom:1px solid #5a341a;}
.resultCont ul {}
.resultCont li {overflow:hidden; width:100%; line-height:16px; margin-bottom:42px;}
.resultCont li div {float:left; vertical-align:middle;}
.resultCont li .name {width:172px;}
.resultCont li .name img {vertical-align:middle;}
.resultCont li .bar {width:470px;}
.resultCont li .bar p {height:16px;}
.resultCont li .percent {float:right; width:60px; text-align:right; font-size:14px; font-weight:bold; font-family:tahoma;}
.resultCont li.nom01 {color:#27404d;}
.resultCont li.nom02 {color:#f5b41b;}
.resultCont li.nom03 {color:#f4476d;}
.resultCont li.nom04 {color:#b78649;}
.resultCont li.nom05 {color:#99b749;}
.resultCont li.nom01 .bar p {background:#27404d;}
.resultCont li.nom02 .bar p {background:#ffe3a1;}
.resultCont li.nom03 .bar p {background:#f4476d;}
.resultCont li.nom04 .bar p {background:#b78649;}
.resultCont li.nom05 .bar p {background:#99b749;}
</style>
<script>
function jsevtchk(){
	<% if Date() < "2015-12-21" or Date() > "2016-12-31" then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		var st = $(":input:radio[name=selridio]:checked").val();

		if (typeof st == "undefined")
		{
			alert("내가 좋아하는 MIDORI를 선택해 주세요.");
			return;
		}

		var result;
		$.ajax({
			type:"GET",
			url:"/event/etc/doeventsubscript/doEventSubscript68207.asp",
			data: "mode=midoriadd&itemsel="+st,
			dataType: "text",
			async:false,
			cache:false,
			success : function(Data){
				result = jQuery.parseJSON(Data);
				if (result.resultcode=="11")
				{

					alert('투표가 완료 되었습니다.');
					location.reload();

				}
				else if (result.resultcode=="44")
				{
					if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
						var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
						winLogin.focus();
						return;
					}
				}
				else if (result.resultcode=="77")
				{
					alert('이미 투표 하셨습니다.');
					return false;
				}
				else if (result.resultcode=="88")
				{
					alert("이벤트 기간이 아닙니다.");
					return;
				}
			}
		});
	<% end if %>
}
</script>
	<div class="contF">
		
		<div class="evt68207">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/tit_modori_v1.png" alt="MIDORI 창립 66주년, 당신의 매일을 풍요롭게 하다" /></h2>
			<!-- 투표하기 -->
			<div class="myMidori">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/txt_vote_v1.png" alt="내가 좋아하는 MIDORi를 투표해주세요!" /></h3>
				<ul>
					<li class="pdt01">
						<label for="pdt01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/img_nominee_01_v1.png" alt="트래블러스노트" /></label>
						<input type="radio" name="selridio" id="pdt01" value="1" />
					</li>
					<li class="pdt02">
						<label for="pdt02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/img_nominee_02_v1.png" alt="MD노트" /></label>
						<input type="radio" name="selridio" id="pdt02" value="2" />
					</li>
					<li class="pdt03">
						<label for="pdt03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/img_nominee_03_v1.png" alt="CL스테이셔너리" /></label>
						<input type="radio" name="selridio" id="pdt03" value="3" />
					</li>
					<li class="pdt04">
						<label for="pdt04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/img_nominee_04_v1.png" alt="Brass Product" /></label>
						<input type="radio" name="selridio" id="pdt04" value="4" />
					</li>
					<li class="pdt05">
						<label for="pdt05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/img_nominee_05_v1.png" alt="PET GIFT" /></label>
						<input type="radio" name="selridio" id="pdt05" value="5" />
					</li>
				</ul>
				<div class="btnArea">
					<a href="" onclick="jsevtchk(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/btn_vote_v1.png" alt="투표하기" /></a>
					<a href="#" onclick="viewPoupLayer('modal',$('#layerVoteResult').html());return false;" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/btn_result_v1.png" alt="결과보기" /></a>
				</div>
				<!-- 투표결과 레이어 -->
				<div id="layerVoteResult" style="display:none">
					<div class="resultCont">
						<div class="inner">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/tit_vote_result.png" alt="실시간 투표 결과" /></h3>
							<ul>
								<li class="nom01">
									<div class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/txt_nominee_01.png" alt="트래블러스노트" /></div>
									<div class="bar"><p style="width:<%= selper1 %>%"></p></div>
									<div class="percent"><%= selper1 %>%</div>
								</li>
								<li class="nom02">
									<div class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/txt_nominee_02.png" alt="MD노트" /></div>
									<div class="bar"><p style="width:<%= selper2 %>%"></p></div>
									<div class="percent"><%= selper2 %>%</div>
								</li>
								<li class="nom03">
									<div class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/txt_nominee_03.png" alt="CL스테이셔너리" /></div>
									<div class="bar"><p style="width:<%= selper3 %>%"></p></div>
									<div class="percent"><%= selper3 %>%</div>
								</li>
								<li class="nom04">
									<div class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/txt_nominee_04.png" alt="Brass Product" /></div>
									<div class="bar"><p style="width:<%= selper4 %>%"></p></div>
									<div class="percent"><%= selper4 %>%</div>
								</li>
								<li class="nom05">
									<div class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/txt_nominee_05.png" alt="PET GIFT" /></div>
									<div class="bar"><p style="width:<%= selper5 %>%"></p></div>
									<div class="percent"><%= selper5 %>%</div>
								</li>
							</ul>
						</div>
						<p class="lyrClose" onclick="ClosePopLayer();"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/btn_close.png" alt="닫기" /></p>
					</div>
				</div>
				<!--// 투표결과 레이어 -->
			</div>
			<!--// 투표하기 -->

			<div class="bnr">
				<a href="/event/eventmain.asp?eventid=68288"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68207/img_bnr.jpg" alt="MIDORi창립 66주년을 축하합니다! 소비자의 눈높이에 맞추어 개성을 완성해주는 상품, 그 이상의 것 더 많은 상품 보러 가기" /></a>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	$("#btncomment a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},800);
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->