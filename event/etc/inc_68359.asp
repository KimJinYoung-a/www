<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'###########################################################
' Description : 1월 신규고객 이벤트 찰칵!
' History : 2016.01.04 원승현
'###########################################################

dim eCode, cnt, sqlStr, couponkey, regdate, gubun, arrList, i, totalsum, linkeCode, imgLoop, imgLoopVal, irdsite20, arrRdSite, vUserID, evtCnt, newUsrCnt
	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "65998"
	Else
		eCode 		= "68359"
	End If

	vUserID = GetEncLoginUserID

	If IsUserLoginOK Then
		'// 이벤트에 참여하였는지 확인한다.
		sqlstr = "Select count(sub_idx) as cnt" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "' and userid='" & vUserID & "'"
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			evtCnt = rsget(0)
		rsget.Close

		'// 1월에 신규가입 하였는지 확인한다.
		sqlstr = " Select count(userid) From db_user.dbo.tbl_user_n Where regdate >= '2016-01-01' And regdate < '2016-02-01' And userid='"&vUserID&"' "
		rsget.Open sqlStr,dbget,1
			newUsrCnt = rsget(0)
		rsget.close
	End If
%>
<style type="text/css">
img {vertical-align:top;}
.evt68359 {position:relative; background:#fff;}
.title {position:relative; height:350px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68359/bg_title.jpg) no-repeat 0 0;}
.title .ribon {position:absolute; left:430px; top:100px;}
.title h2 {position:absolute; left:444px; top:171px;}
.title .new {position:absolute; left:377px; top:300px;}
.newMember {height:195px; padding-top:435px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68359/img_camera.jpg) no-repeat 0 0;}
.newMember .btnApply {background:transparent;}
.evtNoti {overflow:hidden; height:150px; padding-top:42px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68359/bg_notice.png) no-repeat 0 0;}
.evtNoti h3 {float:left; padding:0 44px 0 103px;}
.evtNoti ul {float:left; padding-top:4px;}
.evtNoti ul li {line-height:13px; padding-bottom:10px; color:#727272;}

#resultLayer {position:absolute; left:0; top:0; width:100%; height:980px; z-index:50; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68359/bg_mask.png) repeat 0 0;}
#resultLayer .resultCont {position:absolute; left:50%; top:165px; margin-left:-312px;}
#resultLayer .resultCont .lyrBtn {display:block; position:absolute; background:transparent;}
#resultLayer .btnClose {position:absolute; right:40px; top:35px;}
#resultLayer .result01 .lyrBtn {left:50%; top:480px; margin-left:-162px;}
#resultLayer .result02 .lyrBtn {left:130px; top:584px; width:247px; height:20px; text-indent:-9999px;}
</style>

<script type="text/javascript">

	function checkform(){
		<% If vUserID = "" Then %>
			if ("<%=IsUserLoginOK%>"=="False") {
				if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
					var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
					winLogin.focus();
					return;
				}
			}
		<% End If %>
		<% If vUserID <> "" Then %>
			<% If Now() >= #01/01/2016 00:00:00# And now() < #02/01/2016 00:00:00# Then %>
				<% if evtCnt > 0 then %>
					alert("1월 신규고객 이벤트 참여는 1회만 가능합니다.");
					return;				
				<% else %>
					<% if newUsrCnt > 0 then %>
						$.ajax({
							type:"GET",
							url:"/event/etc/doEventSubscript68359.asp",
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
												$("#resultLayer").show();
												$("#confirmResultData").empty().html(res[1]);
												window.parent.$('html,body').animate({scrollTop:270}, 500);
												return false;
											}
											else
											{
												errorMsg = res[1].replace(">?n", "\n");
												alert(errorMsg);
												document.location.reload();
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
								alert("잘못된 접근 입니다.");
								//var str;
								//for(var i in jqXHR)
								//{
								//	 if(jqXHR.hasOwnProperty(i))
								//	{
								//		str += jqXHR[i];
								//	}
								//}
								//alert(str);
								document.location.reload();
								return false;
							}
						});
					<% else %>
						alert("1월에 신규가입한 회원만 참여하실 수 있습니다.");
						return;				
					<% end if %>
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;				
			<% end if %>
		<% End If %>
	}


	function fnlayerClose(){
		$("#resultLayer").hide();
	}


</script>


<%' 1월 신규회원:찰칵 %>
<div class="evt68359">
	<div class="title">
		<p class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68359/txt_new_member.png" alt="1월 신규고객 이벤트" /></p>
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/68359/tit_shutter.png" alt="찰칵" /></h2>
		<p class="new"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68359/txt_instax.png" alt="1월 신규가입 고객 중 매일 1분을 추첨하여 INSTAX 카메라를 드립니다!" /></p>
	</div>
	<div class="newMember">
		<button class="btnApply" onclick="checkform();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68359/btn_apply.png" alt="응모하기" /></button>
	</div>

	<%' 응모결과 레이어 %>
	<div id="resultLayer" style="display:none">
		<div class="resultCont">
			<button class="btnClose" onclick="fnlayerClose();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68359/btn_close.png" alt="닫기" /></button>
			<div id="confirmResultData"></div>
		</div>
	</div>
	<%'// 응모결과 레이어 %>

	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68359/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 이벤트기간 동안 신규가입 한 고객에게 ID당 1회 응모 가능 합니다.</li>
			<li>- 당첨자에게는 세무신고를 위해 개인정보를 요청 할 수 있으며 제세공과금은 텐바이텐 부담입니다.</li>
			<li>- 매주 월~목요일 당첨자는 당일 혹은 익일 상품 수령에 대한 공지를 드리며, 금~일요일 당첨자는 월요일에 연락드립니다.</li>
			<li>- 당첨 상품의 컬러는 랜덤으로 발송되며, 선택이 불가능 합니다.</li>
			<li>- 당첨 상품의 배송 후 반품 / 교환 / 취소가 불가능 합니다.</li>
		</ul>
	</div>
</div>
<%' // 1월 신규회원:찰칵 %>
<script type="text/javascript">
$(function(){
	/* title animation */
	titleAnimation()
	$(".title .ribon").css({"margin-top":"-8px","opacity":"0"});
	function titleAnimation() {
		$(".title .ribon").delay(100).animate({"margin-top":"8px", "opacity":"1"},500).animate({"margin-top":"0"},400);
		$('.title h2').delay(1000).effect("pulsate", {times:1},300 );
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->