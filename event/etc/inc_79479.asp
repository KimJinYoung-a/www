<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#############################################################
' Description : DistroDojo 설문조사 이벤트
' History : 2017-07-06 원승현 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
	Dim eCode
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66382
	Else
		eCode   =  79479
	End If

	dim userid, i, UserAppearChk, nowdate, sqlstr, over9score, totalcount, min6score
		userid = GetEncLoginUserID()

	nowdate = Left(Now(), 10)


	If userid="thensi7" Or userid="woongspace" Or userid="tkwon" Or userid="badblue37" Or userid="yangpastory" Or userid="greenteenz" Then
		'// 이벤트에 참여하였는지 확인한다.
		sqlstr = "Select count(*)" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "' And sub_opt2 >= 9  "
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			over9score = rsget(0)
		rsget.Close

		sqlstr = "Select count(*)" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "' And sub_opt2 < 7  "
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			min6score = rsget(0)
		rsget.Close

		sqlstr = "Select count(*)" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "'  "
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			totalcount = rsget(0)
		rsget.Close

		response.write "NPS : "&Round((cdbl(over9score/totalcount)-CDbl(min6score/totalcount))*100, 2)&"%"
	End If


%>
<style type="text/css">
.layerCont {position:fixed; left:50% !important; top:50% !important; width:641px; height:596px; margin:-298px 0 0 -320px; z-index:99999;}
.layerCont textarea {position:absolute; left:50%; top:260px; width:520px; height:175px; margin-left:-265px; color:#000; font-size:15px; font-weight:bold; line-height:1.5; border:0;}
.layerCont .lyrClose {position:absolute; right:0; top:0; background:transparent;}
.layerCont .btnSubmit {position:absolute; left:50%; bottom:32px; margin-left:-156px; background:transparent;}
</style>

<script>
function goMinionsIns()
{
	<% If not( left(now(),10)>="2017-07-24" and left(now(),10)<"2017-07-26" ) Then %>
		alert("설문 응모 기간이 아닙니다.");
		return false;
	<% else %>
		<% if request.Cookies("dojo")("survey") then %>
			alert("이미 참여하셨습니다.");
			return false;
		<% else %>
			$("#SVTxt").val($("#surveyTxt").val());
			$.ajax({
				type:"GET",
				url:"/event/etc/doEventSubscript79479.asp",
				data: $("#frmcom").serialize(),
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								res = Data.split("|");
								if (res[0]=="OK")
								{
									alert("설문조사에 참여해주셔서 감사합니다.");
									parent.location.reload();
									return false;
								}
								else
								{
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg);
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								parent.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다.");
					<% if false then %>
						//var str;
						//for(var i in jqXHR)
						//{
						//	 if(jqXHR.hasOwnProperty(i))
						//	{
						//		str += jqXHR[i];
						//	}
						//}
						//alert(str);
					<% end if %>
					parent.location.reload();
					return false;
				}
			});
		<% end if %>
	<% end if %>
}

function sendSVS(v)
{
	$("#SVS").val(v);
}
</script>
<div class="evt79479">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79479/txt_friends.png" alt="당신의 친구에게 텐바이텐을 추천한다면, 몇 점인가요?" /></h2>
	<div class="score">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79479/txt_score.png" alt="" usemap="#scoreMap" /></p>
		<map name="scoreMap" id="scoreMap">
			<area shape="rect" coords="263,70,318,124" onfocus="this.blur();" class="btnScore" id="score1" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('1');return false;" href="#" alt="1점" />
			<area shape="rect" coords="326,70,381,124" onfocus="this.blur();" class="btnScore" id="score2" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('2');return false;" href="#" alt="2점" />
			<area shape="rect" coords="388,70,443,124" onfocus="this.blur();" class="btnScore" id="score3" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('3');return false;" href="#" alt="3점" />
			<area shape="rect" coords="449,70,504,124" onfocus="this.blur();" class="btnScore" id="score4" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('4');return false;" href="#" alt="4점" />
			<area shape="rect" coords="511,70,566,124" onfocus="this.blur();" class="btnScore" id="score5" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('5');return false;" href="#" alt="5점" />
			<area shape="rect" coords="573,70,629,124" onfocus="this.blur();" class="btnScore" id="score6" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('6');return false;" href="#" alt="6점" />
			<area shape="rect" coords="634,70,691,124" onfocus="this.blur();" class="btnScore" id="score7" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('7');return false;" href="#" alt="7점" />
			<area shape="rect" coords="695,70,753,124" onfocus="this.blur();" class="btnScore" id="score8" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('8');return false;" href="#" alt="8점" />
			<area shape="rect" coords="759,70,816,124" onfocus="this.blur();" class="btnScore" id="score9" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('9');return false;" href="#" alt="9점" />
			<area shape="rect" coords="821,70,877,124" onfocus="this.blur();" class="btnScore" id="score10" onclick="viewPoupLayer('modal',$('#lyrScore').html());sendSVS('10');return false;" href="#" alt="10점" />
		</map>
	</div>
	<%' 의견작성 레이어 %>
	<div id="lyrScore" style="display:none">
		<div class="layerCont">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79479/txt_more.png" alt="선택하신 이유에 대해 좀 더 말씀해 주세요" /></p>
			<textarea cols="10" rows="10" id="surveyTxt" name="surveyTxt"></textarea>
			<button class="btnSubmit" onclick="goMinionsIns();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79479/btn_submit.png" alt="제출하기" /></button>
			<button class="lyrClose" onclick="ClosePopLayer();"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79479/btn_close.png" alt="닫기" /></button>
		</div>
	</div>
	<%'// 의견작성 레이어 %>
</div>
<form method="post" name="frmcom" id="frmcom">
<input type="hidden" name="eCode" value="<%=eCode%>">
<input type="hidden" name="mode" value="ins">
<input type="hidden" name="SVS" id="SVS">
<input type="hidden" name="SVTxt" id="SVTxt">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->