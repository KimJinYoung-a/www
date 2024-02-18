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
' Description : 3월 신규고객 이벤트 쓱싹쓱싹
' History : 2016-02-24 이종화
'###########################################################

dim eCode, cnt, sqlStr, couponkey, regdate, gubun, arrList, i, totalsum, linkeCode, imgLoop, imgLoopVal, irdsite20, arrRdSite, vUserID, evtCnt, newUsrCnt
	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66050"
	Else
		eCode 		= "69393"
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

		'// 3월에 신규가입 하였는지 확인한다.
		sqlstr = " Select count(userid) From db_user.dbo.tbl_user_n Where regdate >= '2016-03-01' And regdate < '2016-04-01' And userid='"&vUserID&"' "
		rsget.Open sqlStr,dbget,1
			newUsrCnt = rsget(0)
		rsget.close

	End If
%>
<style type="text/css">
img {vertical-align:top;}
.evt69393 {position:relative; padding-bottom:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69393/bg_yellow.png) repeat 0 0;}
.title {position:relative; height:362px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69393/bg_title.png) repeat 0 0;}
.title h2 {position:absolute; left:360px; top:170px;}
.title h2 span {position:absolute; top:0;}
.title h2 .t01 {left:0;}
.title h2 .t02 {left:110px;}
.title h2 .t03 {left:220px;}
.title h2 .t04 {left:330px;}
.title .copy {position:absolute; left:50%; top:308px; margin-left:-210px;}
.getLamy {position:relative;}
.getLamy .btnJoin {display:block; position:absolute; left:50%; bottom:73px; margin-left:-230px;}
.evtNoti {overflow:hidden; padding:40px 0 40px 100px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69393/bg_noti.png) repeat 0 0;}
.evtNoti h3 {float:left; width:217px;}
.evtNoti ul {float:left; width:805px; padding-top:4px; color:#f7f0e3;}
.evtNoti li {padding-bottom:10px; line-height:13px;}
#resultLayer {position:absolute; left:0; top:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69393/bg_mask.png) repeat 0 0;}
#resultLayer .resultCont {position:absolute; left:50%; top:220px; margin-left:-300px;}
#resultLayer .btnClose {position:absolute; right:60px; top:42px; background:transparent;}
#resultLayer .btnConfirm {position:absolute; left:50%; bottom:150px; margin-left:-162px; background:transparent;}
#resultLayer .goCpbook {display:block; position:absolute; left:108px; bottom:104px; width:260px; height:25px; z-index:50; font-size:0; line-height:0; background:rgba(0,0,0,0);}
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
			<% If Now() >= #03/01/2016 00:00:00# And now() < #04/01/2016 00:00:00# Then %>
				<% if evtCnt > 0 then %>
					alert("3월 신규고객 이벤트 참여는 1회만 가능합니다.");
					return;				
				<% else %>
					<% if newUsrCnt > 0 then %>
						$.ajax({
							type:"GET",
							url:"/event/etc/doeventsubscript/doEventSubscript69393.asp",
							dataType: "text",
							async:false,
							cache:false,
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
								document.location.reload();
								return false;
							}
						});
					<% else %>
						alert("3월에 신규가입한 회원만 참여하실 수 있습니다.");
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
<div class="evt69393">
	<div class="title">
		<h2>
			<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/tit_write_01.png" alt="쓱" /></span>
			<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/tit_write_02.png" alt="싹" /></span>
			<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/tit_write_01.png" alt="쓱" /></span>
			<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/tit_write_02.png" alt="싹" /></span>
		</h2>
		<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/txt_copy.png" alt="3월 신규가입 고객 중 매일 1분을 추첨하여 라미 만년필을 드립니다!" /></p>
	</div>
	<div class="getLamy">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/img_lamy.jpg" alt="" /></div>
		<button class="btnJoin" onclick="checkform();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/btn_join.png" alt="가입하고 응모하기" /></button>
	</div>
	<div id="resultLayer" style="display:none">
		<div class="resultCont">
			<button class="btnClose" onclick="fnlayerClose();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/btn_close.png" alt="닫기" /></button>
			<div id="confirmResultData"></div>
		</div>
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69393/tit_noti.png" alt="가입하고 응모하기" /></h3>
		<ul>
			<li>- 본 이벤트는 3월 신규 가입 고객에 한 해, ID 당 1회 응모 가능합니다.</li>
			<li>- 당첨자는 개인 정보에 있는 주소지로 사은품을 배송하오니, 당첨 확인 후 개인 정보 수정에서 연락처 및 주소지를 꼭 기입해 주세요.</li>
			<li>- 주소 확인 완료 후, 1~3일 이내에 발송됩니다.</li>
			<li>- 당첨 상품의 컬러는 랜덤으로 발송되며, 선택이 불가능합니다.</li>
			<li>- 당첨 상품의 배송 후 반품 / 교환 / 취소가 불가능합니다.</li>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$(".title .t01").css({"margin-left":"-5px", "opacity":"0"});
	$(".title .t02").css({"margin-top":"5px", "opacity":"0"});
	$(".title .t03").css({"margin-top":"-5px", "opacity":"0"});
	$(".title .t04").css({"margin-left":"5px", "opacity":"0"});
	function titleAnimation() {
		$(".title span.t01").delay(10).animate({"margin-left":"0","opacity":"1"},500);
		$(".title span.t02").delay(300).animate({"margin-top":"0","opacity":"1"},500);
		$(".title span.t03").delay(600).animate({"margin-top":"0","opacity":"1"},500);
		$(".title span.t04").delay(900).animate({"margin-left":"0","opacity":"1"},500);
	}
	titleAnimation();
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->