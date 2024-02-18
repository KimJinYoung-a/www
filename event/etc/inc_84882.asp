<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2018 박스테이프 공모전
' History : 2018-03-05 원승현 생성
' 주의사항
'   - 이벤트 기간 : 2018-03-07 ~ 2018-03-13
'   - 오픈시간 : 24시간
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<%
	'// 해당 이벤트는 진행기간중 무조건 1회까지만 참여가능(중복참여불가)
	Dim eCode, userid, vQuery, currenttime, vEventStartDate, vEventEndDate, vBoolUserCheck
	Dim vResultVote1, vResultVote2, vResultVote3, vResultVote4

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  67513
	Else
		eCode   =  84882
	End If

	userid = GetEncLoginUserID()

	'// 현재시간
	currenttime = now()
	'currenttime = "2018-02-18 오전 10:03:35"

	vEventStartDate = "2018-03-05"
	vEventEndDate = "2018-03-13"

	If IsUserLoginOK() Then
		'로그인 한 유저가 해당 이벤트를 참여 했는지 확인.
		vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WITH (NOLOCK) WHERE evt_code = '" & eCode & "' And userid='"&userid&"' "
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		IF Not rsget.Eof Then
			If rsget(0) > 0 Then
				vBoolUserCheck = True
			Else
				vBoolUserCheck = False
			End If
		End IF
		rsget.close

		'// 이미 참여한 유저의 답안 데이터 가져오기
		If vBoolUserCheck Then
			vQuery = "SELECT sub_opt2 FROM [db_event].[dbo].[tbl_event_subscript] WITH (NOLOCK) WHERE evt_code = '" & eCode & "' And userid='"&userid&"' "
			rsget.CursorLocation = adUseClient
			rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
			IF Not rsget.Eof Then
				Do Until rsget.eof
					If rsget("sub_opt2") >= 1 And rsget("sub_opt2") < 7 Then
						vResultVote1 = rsget("sub_opt2")
					End If

					If rsget("sub_opt2") >= 7 And rsget("sub_opt2") < 13 Then
						vResultVote2 = rsget("sub_opt2")
					End If

					If rsget("sub_opt2") >= 13 And rsget("sub_opt2") < 19 Then
						vResultVote3 = rsget("sub_opt2")
					End If

					If rsget("sub_opt2") >= 19 And rsget("sub_opt2") < 25 Then
						vResultVote4 = rsget("sub_opt2")
					End If
				rsget.movenext
				Loop
			End If
		End If
	End If
%>
<style type="text/css">
@font-face {font-family:'SDCinemaTheater';
src:url('http://www.10x10.co.kr/webfont/SDCinemaTheater.woff') format('woff'), url('http://www.10x10.co.kr/webfont/SDCinemaTheater.woff2') format('woff2'); font-style:normal; font-weight:normal;}
.evt84882 button {vertical-align:top; background:transparent;}
.evt84882 .topic {position:relative; height:560px; background:#bc8450 url(http://webimage.10x10.co.kr/eventIMG/2018/84882/bg_top.jpg) no-repeat 50% 0;}
.evt84882 .topic h2 {position:relative; padding-top:73px;}
.evt84882 .inner {position:relative; width:1140px; margin:0 auto;}
.evt84882 .vote {height:1485px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84882/bg_cont.jpg) repeat-x 50% 0;}
.evt84882 .vote h3 {padding:145px 0 208px;}
.evt84882 .vote .inner {height:677px; margin-bottom:70px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84882/bg_list.jpg) no-repeat 0 0;}
.evt84882 .vote .nav-part {position:absolute; left:0; top:-100px; z-index:20;}
.evt84882 .vote .nav-part li{float:left; padding-left:22px;}
.evt84882 .vote .nav-part li:first-child {padding-left:0;}
.evt84882 .vote .nav-part li a {display:block; width:268px; height:100px; text-indent:-999em;}
.evt84882 .vote .tab {position:absolute; left:0; top:-100px; z-index:10;}
.evt84882 .vote .tab-container.finish:after {content:''; display:inline-block; position:absolute; left:0; top:10%; z-index:100; width:100%; height:88%; background-color:transparent;}
.evt84882 .vote .copy-list {overflow:hidden; width:1080px; margin:0 auto; padding-top:60px;}
.evt84882 .vote .copy-list li {position:relative; float:left; width:444px; height:115px; margin:0 20px 50px; padding:30px 28px 0; color:#fff; text-align:left; background-color:#db4b36;}
.evt84882 .vote .copy-list li:nth-child(2),
.evt84882 .vote .copy-list li:nth-child(3),
.evt84882 .vote .copy-list li:nth-child(6) {background-color:#db7836;}
.evt84882 .vote .copy-list li label {display:block; position:absolute; left:0; top:0; z-index:10; width:500px; height:145px;text-indent:-999em; cursor:pointer; background:transparent;}
.evt84882 .vote .copy-list li label:after {content:''; display:inline-block; position:absolute; right:30px; top:29px; width:30px; height:18px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84882/ico_heart.png) no-repeat 50% 0;}
.evt84882 .vote .copy-list li input {position:absolute; left:0; top:0; width:0; height:0;}
.evt84882 .vote .copy-list li .writer {padding:0 6px 10px; color:#ffe87f; font:bold 16px/1.1 'gulim'; border-bottom:1px solid #e98a53;}
.evt84882 .vote .copy-list li .copy {padding:15px 6px 0; font-size:24px; font-family:'SDCinemaTheater';}
.evt84882 .vote .copy-list li input[type=radio]:checked + label:after {background-position:50% 100%; animation:bounceIn .3s 1 ease-in-out forwards;}
.evt84882 .vote .copy-list li .ico {display:none;}
.evt84882 .vote .copy-list li.off .ico {display:block; position:absolute; left:0; top:0; width:500px; height:145px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84882/bg_mask.png) repeat 0 0;}
.evt84882 .noti {padding:110px 0 75px; color:#fff; font-size:14px; line-height:34px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84882/bg_noti.png) repeat 0 0;}
.evt84882 .noti h3 {position:absolute; left:222px; top:10px;}
.evt84882 .noti ul {padding-left:488px;}
@keyframes bounceIn {
  0% {transform: scale(.3); opacity:0;}
  60% {transform: scale(1.3);}
  100% {transform: scale(1); opacity:1;}
}
</style>
<script type="text/javascript">
	$(function(){
		$(".tab-cont").hide();
		$(".nav-part").find("li:first a").addClass("on");
		$(".tab-container").find(".tab-cont:first").show();
		$(".nav-part li").click(function() {
			$(this).siblings("li").find("a").removeClass("on");
			$(this).find("a").addClass("on");
			$(this).closest(".nav-part").nextAll(".tab-container:first").find(".tab-cont").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).show();
			return false;
		});

		<% if not(vBoolUserCheck) then %>
			$(".copy-list li").click(function() {
				$(this).removeClass("off");
				$(this).siblings("li").removeClass("on");
				$(this).siblings("li").addClass("off");
				$(this).addClass("on");
			});
		<% else %>
			$(".copy-list li").siblings("li").removeClass("on");
			$(".copy-list li").siblings("li").addClass("off");
			$("#part1 li:nth-child(<%=vResultVote1%>)").removeClass("off");
			$("#part1 li:nth-child(<%=vResultVote1%>)").addClass("on");
			$("#part2 li:nth-child(<%=vResultVote2-6%>)").removeClass("off");
			$("#part2 li:nth-child(<%=vResultVote2-6%>)").addClass("on");
			$("#part3 li:nth-child(<%=vResultVote3-12%>)").removeClass("off");
			$("#part3 li:nth-child(<%=vResultVote3-12%>)").addClass("on");
			$("#part4 li:nth-child(<%=vResultVote4-18%>)").removeClass("off");
			$("#part4 li:nth-child(<%=vResultVote4-18%>)").addClass("on");
			$(".tab-container").addClass("finish");
		<% end if %>
	});

	function BoxTapeVoteCheck(t)
	{
		<% If not(IsUserLoginOK) Then %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
			return false;
		<% end if %>

		<% If not( left(trim(currenttime),10)>=trim(vEventStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) ) Then %>
			alert("이벤트 응모기간이 아닙니다.");
			return false;
		<% end if %>

		<% if vBoolUserCheck then %>
			alert("이미 참여하신 이벤트 입니다.");
			return false;
		<% end if %>

		if (parseInt($(t).val()) >= 1 && parseInt($(t).val()) < 7)
		{
			$("#selectVoteVal1").val($(t).val());
			$("#selectVoteVal1Txt").val($(t).attr("txtValue"));
		}

		if (parseInt($(t).val()) >= 7 && parseInt($(t).val()) < 13)
		{
			$("#selectVoteVal2").val($(t).val());
			$("#selectVoteVal2Txt").val($(t).attr("txtValue"));
		}

		if (parseInt($(t).val()) >= 13 && parseInt($(t).val()) < 19)
		{
			$("#selectVoteVal3").val($(t).val());
			$("#selectVoteVal3Txt").val($(t).attr("txtValue"));
		}

		if (parseInt($(t).val()) >= 19 && parseInt($(t).val()) < 25)
		{
			$("#selectVoteVal4").val($(t).val());
			$("#selectVoteVal4Txt").val($(t).attr("txtValue"));
		}

		if ( $("#selectVoteVal1").val() != "" && $("#selectVoteVal2").val() != "" && $("#selectVoteVal3").val() != "" && $("#selectVoteVal4").val() != "" )
		{
			$("#voteButtonImgSrc").attr("src", "http://webimage.10x10.co.kr/eventIMG/2018/84882/btn_vote_2.png");
		}
	}

	function jsBoxTape2018Submit(){
		<% If not(IsUserLoginOK) Then %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
			return false;
		<% end if %>

		<% If not( left(trim(currenttime),10)>=trim(vEventStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) ) Then %>
			alert("이벤트 응모기간이 아닙니다.");
			return false;
		<% end if %>

		<% if vBoolUserCheck then %>
			alert("이미 참여하신 이벤트 입니다.");
			return false;
		<% end if %>

		if ( $("#selectVoteVal1").val() != "" && $("#selectVoteVal2").val() != "" && $("#selectVoteVal3").val() != "" && $("#selectVoteVal4").val() != "" )
		{
			$.ajax({
				type:"POST",
				url:"/event/etc/doEventSubscript84882.asp",
				data: $("#boxTapeVoteFrm").serialize(),
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data)
								{
									 if(Data.hasOwnProperty(i))
									{
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK")
								{
									$("#voteButtonImgSrc").attr("src", "http://webimage.10x10.co.kr/eventIMG/2018/84882/btn_vote_3.png");
									$(".tab-container").addClass("finish");
									alert("투표가 완료되었습니다.\n당첨자 발표일을 기다려주세요!");
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
								document.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					/*
						alert("잘못된 접근 입니다.");
						var str;
						for(var i in jqXHR)
						{
							 if(jqXHR.hasOwnProperty(i))
							{
								str += jqXHR[i];
							}
						}
						alert(str);
						document.location.reload();
						return false;
					*/
				}
			});
		}
		else
		{
			alert("투표가 완료되지 않았습니다. PART별로 1개씩\n하트를 클릭해주세요.");
			return false;
		}
	}
</script>

<div class="evt84882">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tit_copy.png" alt="박스테이프 카피, 어디까지 뽑아봤니?" /></h2>
	</div>
	<%' 투표하기 %>
	<div class="vote">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tit_vote_v2.png" alt="마음에 드는 카피는 파트별 1개씩, 총 4개를 고른 후 하트를 눌러 투표해주세요." /></h3>
		<div class="inner">
			<ul class="nav-part">
				<li><a href="#part1">PART.01</a></li>
				<li><a href="#part2">PART.02</a></li>
				<li><a href="#part3">PART.03</a></li>
				<li><a href="#part4">PART.04</a></li>
			</ul>
			<div class="tab-container">
				<%' part1 %>
				<div id="part1" class="tab-cont">
					<div class="tab"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tab_1.png" alt="." /></div>
					<ul class="copy-list">
						<li>
							<div class="box">
								<input type="radio" id="part1copy1" name="selectPart1" value="1" txtValue="옥천HUB로부터 벗어나 너에게 왔다" onclick="BoxTapeVoteCheck(this);" <% If vResultVote1="1" Then %>checked<% End If %>  />
								<label for="part1copy1">선택</label>
								<p class="writer">k0355**</p>
								<p class="copy">옥천HUB로부터 벗어나 너에게 왔다</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part1copy2" name="selectPart1" value="2" txtValue="괜찮아 꼭 필요해서 산 거니까" onclick="BoxTapeVoteCheck(this);" <% If vResultVote1="2" Then %>checked<% End If %> />
								<label for="part1copy2">선택</label>
								<p class="writer">kimsu94**</p>
								<p class="copy">괜찮아 꼭 필요해서 산 거니까</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part1copy3" name="selectPart1" value="3" txtValue="오늘 뜯을 택배를 내일로 미루지말라" onclick="BoxTapeVoteCheck(this);" <% If vResultVote1="3" Then %>checked<% End If %> />
								<label for="part1copy3">선택</label>
								<p class="writer">nanada**</p>
								<p class="copy">오늘 뜯을 택배를 내일로 미루지말라</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part1copy4" name="selectPart1" value="4" txtValue="택배가 왜 여기서 나와?" onclick="BoxTapeVoteCheck(this);" <% If vResultVote1="4" Then %>checked<% End If %> />
								<label for="part1copy4">선택</label>
								<p class="writer">kimhs73**</p>
								<p class="copy">♡택배가 왜 여기서 나와? ♡</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part1copy5" name="selectPart1" value="5" txtValue="택배 길만 걷게 해줄게" onclick="BoxTapeVoteCheck(this);" <% If vResultVote1="5" Then %>checked<% End If %> />
								<label for="part1copy5">선택</label>
								<p class="writer">royaldrag**</p>
								<p class="copy">택배 길만 걷게 해줄게</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part1copy6" name="selectPart1" value="6" txtValue="오늘 갈 수 있는거죠..?" onclick="BoxTapeVoteCheck(this);" <% If vResultVote1="6" Then %>checked<% End If %> />
								<label for="part1copy6">선택</label>
								<p class="writer">greentee**</p>
								<p class="copy">아저씨, 오늘 갈 수 있는거죠..?</p>
								<span class="ico"></span>
							</div>
						</li>
					</ul>
				</div>
				<%'// part1 %>

				<%' part2 %>
				<div id="part2" class="tab-cont">
					<div class="tab"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tab_2.png" alt="." /></div>
					<ul class="copy-list">
						<li>
							<div class="box">
								<input type="radio" id="part2copy1" name="selectPart2" value="7" txtValue="빨리 열여줘요. 현기증 난단 말이에요" onclick="BoxTapeVoteCheck(this);" <% If vResultVote2="7" Then %>checked<% End If %> />
								<label for="part2copy1">선택</label>
								<p class="writer">gogon**</p>
								<p class="copy">빨리 열어줘요. 현기증 난단 말이에요</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part2copy2" name="selectPart2" value="8" txtValue="내꺼 아니고 친구꺼야" onclick="BoxTapeVoteCheck(this);" <% If vResultVote2="8" Then %>checked<% End If %> />
								<label for="part2copy2">선택</label>
								<p class="writer">waterk**</p>
								<p class="copy">내꺼 아니고 친구꺼야</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part2copy3" name="selectPart2" value="9" txtValue="내가 뭘 샀는지 잘모르게쒀요" onclick="BoxTapeVoteCheck(this);" <% If vResultVote2="9" Then %>checked<% End If %> />
								<label for="part2copy3">선택</label>
								<p class="writer">shrg30**</p>
								<p class="copy">오께이~ 내가 뭘 샀는지 잘모르게쒀요</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part2copy4" name="selectPart2" value="10" txtValue="과거의 내가 주는 선물" onclick="BoxTapeVoteCheck(this);" <% If vResultVote2="10" Then %>checked<% End If %> />
								<label for="part2copy4">선택</label>
								<p class="writer">shin9412**</p>
								<p class="copy">과거의 내가 주는 선물</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part2copy5" name="selectPart2" value="11" txtValue="내가 돈이 없지 택배가 없냐?" onclick="BoxTapeVoteCheck(this);" <% If vResultVote2="11" Then %>checked<% End If %> />
								<label for="part2copy5">선택</label>
								<p class="writer">zpdlr**</p>
								<p class="copy">내가 돈이 없지 택배가 없냐?</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part2copy6" name="selectPart2" value="12" txtValue="택배는 잘못 없어.. 내가 결제했어.." onclick="BoxTapeVoteCheck(this);" <% If vResultVote2="12" Then %>checked<% End If %> />
								<label for="part2copy6">선택</label>
								<p class="writer">yesjj55**</p>
								<p class="copy">택배는 잘못 없어.. 내가 결제했어..</p>
								<span class="ico"></span>
							</div>
						</li>
					</ul>
				</div>
				<%'// part2 %>

				<%' part3 %>
				<div id="part3" class="tab-cont">
					<div class="tab"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tab_3.png" alt="." /></div>
					<ul class="copy-list">
						<li>
							<div class="box">
								<input type="radio" id="part3copy1" name="selectPart3" value="13" txtValue="이 택배는 영국에서 시작하여.." onclick="BoxTapeVoteCheck(this);" <% If vResultVote3="13" Then %>checked<% End If %> />
								<label for="part3copy1">선택</label>
								<p class="writer">yomi**</p>
								<p class="copy">이 택배는 영국에서 시작하여..</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part3copy2" name="selectPart3" value="14" txtValue="내 상자속에 저장♥" onclick="BoxTapeVoteCheck(this);" <% If vResultVote3="14" Then %>checked<% End If %> />
								<label for="part3copy2">선택</label>
								<p class="writer">anrrud**</p>
								<p class="copy">내 상자속에 저장♥</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part3copy3" name="selectPart3" value="15" txtValue="오른속이 결제한 걸 왼손이 모르게하라" onclick="BoxTapeVoteCheck(this);" <% If vResultVote3="15" Then %>checked<% End If %> />
								<label for="part3copy3">선택</label>
								<p class="writer">xllsoyoul**</p>
								<p class="copy">오른손이 결제한 걸 왼손이 모르게하라</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part3copy4" name="selectPart3" value="16" txtValue="사랑아 택배해" onclick="BoxTapeVoteCheck(this);" <% If vResultVote3="16" Then %>checked<% End If %> />
								<label for="part3copy4">선택</label>
								<p class="writer">ovoh**</p>
								<p class="copy">사랑아 택배해</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part3copy5" name="selectPart3" value="17" txtValue="택배는 가슴이 시킨다" onclick="BoxTapeVoteCheck(this);" <% If vResultVote3="17" Then %>checked<% End If %> />
								<label for="part3copy5">선택</label>
								<p class="writer">rkdsoddl**</p>
								<p class="copy">택배는 가슴이 시킨다</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part3copy6" name="selectPart3" value="18" txtValue="넌 뜯을 때가 제일 예뻐" onclick="BoxTapeVoteCheck(this);" <% If vResultVote3="18" Then %>checked<% End If %> />
								<label for="part3copy6">선택</label>
								<p class="writer">puchib**</p>
								<p class="copy">넌 뜯을 때가 제일 예뻐</p>
								<span class="ico"></span>
							</div>
						</li>
					</ul>
				</div>
				<%'// part3 %>

				<%' part4 %>
				<div id="part4" class="tab-cont">
					<div class="tab"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tab_4.png" alt="." /></div>
					<ul class="copy-list">
						<li>
							<div class="box">
								<input type="radio" id="part4copy1" name="selectPart4" value="19" txtValue="택배를 최애보듯 하라" onclick="BoxTapeVoteCheck(this);" <% If vResultVote4="19" Then %>checked<% End If %> />
								<label for="part4copy1">선택</label>
								<p class="writer">rainrain**</p>
								<p class="copy">택배를 최애보듯 하라</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part4copy2" name="selectPart4" value="20" txtValue="응 택배야~" onclick="BoxTapeVoteCheck(this);" <% If vResultVote4="20" Then %>checked<% End If %> />
								<label for="part4copy2">선택</label>
								<p class="writer">sb16**</p>
								<p class="copy">응 택배야~</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part4copy3" name="selectPart4" value="21" txtValue="엄마 나 아냐 고양이가 주문한 거야" onclick="BoxTapeVoteCheck(this);" <% If vResultVote4="21" Then %>checked<% End If %> />
								<label for="part4copy3">선택</label>
								<p class="writer">thd33**</p>
								<p class="copy">엄마 나 아냐 고양이가 주문한 거야</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part4copy4" name="selectPart4" value="22" txtValue="안 사면 0원 사면 영원" onclick="BoxTapeVoteCheck(this);" <% If vResultVote4="22" Then %>checked<% End If %> />
								<label for="part4copy4">선택</label>
								<p class="writer">lightyuj**</p>
								<p class="copy">안 사면 0원 사면 영원</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part4copy5" name="selectPart4" value="23" txtValue="내가 돈 버는 이유" onclick="BoxTapeVoteCheck(this);" <% If vResultVote4="23" Then %>checked<% End If %> />
								<label for="part4copy5">선택</label>
								<p class="writer">yoonjin**</p>
								<p class="copy">내가 돈 버는 이유</p>
								<span class="ico"></span>
							</div>
						</li>
						<li>
							<div class="box">
								<input type="radio" id="part4copy6" name="selectPart4" value="24" txtValue="YOLO (You 10 & Lover 10)" onclick="BoxTapeVoteCheck(this);" <% If vResultVote4="24" Then %>checked<% End If %> />
								<label for="part4copy6">선택</label>
								<p class="writer">figaro11**</p>
								<p class="copy">YOLO ( You 1O & Lover 1O )</p>
								<span class="ico"></span>
							</div>
						</li>
					</ul>
				</div>
				<%'// part4 %>
			</div>
		</div>
		<button type="button" onclick="jsBoxTape2018Submit();return false;">
			<% if not(vBoolUserCheck) then %>
				<%' 4개 선택 전 %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/btn_vote_1.png" alt="투표하기" id="voteButtonImgSrc"/>
			<% Else %>
				<%' 4개 선택 후 %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/btn_vote_3.png" alt="투표하기" id="voteButtonImgSrc"/>
			<% End If %>
		</button>
	</div>
	<%'// 투표하기 %>
	<div class="noti">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84882/tit_noti.png" alt="유의사항" /></h3>
			<ul>
				<li>- 투표는 한 ID 당 한번 참여 가능합니다.</li>
				<li>- 각 STEP 별로 1개씩만 선택, 총 4개를 선택할 수 있습니다.</li>
				<li>- 당첨자 발표일은 3월 20일입니다.</li>
				<li>- 최종 투표 후 취소 및 변경이 불가하므로 신중히 선택해주세요.</li>
				<li>- 모든 응모작의 저작권을 포함한 일체 권리는 텐바이텐에 귀속됩니다.</li>
				<li>- 실제 상품 제작 시, 일부분 수정될 가능성이 있습니다.</li>
				<li>- 비슷한 응모작은 최초 응모작을 당첨자로 선정하였습니다.</li>
				<li>- 새로운 박스테이프는 4월부터 만나보실 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>
<form name="boxTapeVoteFrm" id="boxTapeVoteFrm" method="post">
	<input type="hidden" name="selectVoteVal1" id="selectVoteVal1">
	<input type="hidden" name="selectVoteVal1Txt" id="selectVoteVal1Txt">
	<input type="hidden" name="selectVoteVal2" id="selectVoteVal2">
	<input type="hidden" name="selectVoteVal2Txt" id="selectVoteVal2Txt">
	<input type="hidden" name="selectVoteVal3" id="selectVoteVal3">
	<input type="hidden" name="selectVoteVal3Txt" id="selectVoteVal3Txt">
	<input type="hidden" name="selectVoteVal4" id="selectVoteVal4">
	<input type="hidden" name="selectVoteVal4Txt" id="selectVoteVal4Txt">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->