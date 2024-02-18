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
dim eCode, sqlStr, i, vArr, vUserID, vCount(5), vCheck(5)
	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66123"
	Else
		eCode 		= "70687"
	End If

	vUserID = GetEncLoginUserID
	vCount(0) = 0
	vCount(1) = 0
	vCount(2) = 0
	vCount(3) = 0
	vCount(4) = 0
	vCount(5) = 0
	
	sqlstr = "select " & _
			 "isNull(sum(case when sub_opt2 = '1' then 1 else 0 end),0), isNull(sum(case when sub_opt2 = '2' then 1 else 0 end),0), " & _
			 "isNull(sum(case when sub_opt2 = '3' then 1 else 0 end),0), isNull(sum(case when sub_opt2 = '4' then 1 else 0 end),0), " & _
			 "isNull(sum(case when sub_opt2 = '5' then 1 else 0 end),0), isNull(sum(case when sub_opt2 = '6' then 1 else 0 end),0) " & _
			 "from [db_event].[dbo].[tbl_event_subscript] where evt_code = '" & eCode & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr,dbget,adOpenForwardOnly,adLockReadOnly
	If Not rsget.Eof Then
		vCount(0) = rsget(0)
		vCount(1) = rsget(1)
		vCount(2) = rsget(2)
		vCount(3) = rsget(3)
		vCount(4) = rsget(4)
		vCount(5) = rsget(5)
	End If
	rsget.Close
	
	If IsUserLoginOK Then
		'// 이벤트에 참여하였는지 확인한다.
		sqlstr = "Select sub_opt2 From db_event.dbo.tbl_event_subscript WHERE evt_code='" & eCode & "' and userid='" & vUserID & "'"
		rsget.CursorLocation = adUseClient
		rsget.Open sqlStr,dbget,adOpenForwardOnly,adLockReadOnly
		If Not rsget.Eof Then
			vArr = rsget.getRows()
		End If
		rsget.Close
	End If
%>
<style type="text/css">
img {vertical-align:top;}
.evt70687 .item {position:relative;}
.evt70687 .item span {display:block; position:absolute;}
.evt70687 .item span button {overflow:hidden; width:24px; height:20px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/70687/mark_heart.png) 50% 0 no-repeat; text-indent:-9999em; outline:none;}
.evt70687 .item span button.heartOn {background-position:50% 100%;}
.evt70687 .item span strong {display:inline-block; width:45px; padding-left:62px; font-size:18px; color:#000; letter-spacing:-0.045em; text-align:right; line-height:20px;}
.evt70687 .item01 {left:265px; bottom:89px;}
.evt70687 .item02 {left:718px; bottom:196px;}
.evt70687 .item03 {left:145px; top:271px;}
.evt70687 .item04 {left:655px; top:271px;}
.evt70687 .item05 {left:145px; bottom:158px;}
.evt70687 .item06 {left:655px; bottom:158px;}
.evt70687 .flag {position:absolute; display:block; width:61px; height:61px;}
.evt70687 .flagBest {left:890px; top:125px;}
.evt70687 .flagNew {left:188px; top:95px;}
.evt70687 .rolling {position:relative; padding-top:115px; padding-bottom:90px;}
.evt70687 .rolling1 {background-color:#fff2ee;}
.evt70687 .rolling1 .slide {background-color:#ffafaf;}
.evt70687 .rolling2 {background-color:#e8f0fd;}
.evt70687 .rolling2 .slide {background-color:#a7c4f5;}
.evt70687 .rolling1 .slidesjs-previous {background:url(http://webimage.10x10.co.kr/eventIMG/2016/70687/btn_slide_nav_prev.png) no-repeat 0 0;}
.evt70687 .rolling1 .slidesjs-next {background:url(http://webimage.10x10.co.kr/eventIMG/2016/70687/btn_slide_nav_next.png) no-repeat 0 0;}
.evt70687 .rolling2 .slidesjs-previous {background:url(http://webimage.10x10.co.kr/eventIMG/2016/70687/btn_slide_nav2_prev.png) no-repeat 0 0;}
.evt70687 .rolling2 .slidesjs-next {background:url(http://webimage.10x10.co.kr/eventIMG/2016/70687/btn_slide_nav2_next.png) no-repeat 0 0;}
.evt70687 .slide {width:890px; margin:0 auto; padding:10px;}
.evt70687 .slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; left:50%; width:33px; height:69px; margin-top:-33px; text-indent:-999em;}
.evt70687 .slide .slidesjs-previous {margin-left:-488px;}
.evt70687 .slide .slidesjs-next {margin-left:455px;}
.evt70687 .slidesjs-pagination {overflow:hidden; position:absolute; bottom:110px; left:50%; z-index:50; width:88px; margin-left:-44px;}
.evt70687 .slidesjs-pagination li {float:left;}
.evt70687 .slidesjs-pagination li a {display:block; width:22px; height:22px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70687/btn_slide_paging.png) no-repeat -33px 0; text-indent:-999em;}
.evt70687 .slidesjs-pagination li a.active {background-position:5px 0;}
</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"890",
		height:"578",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#slide2").slidesjs({
		width:"890",
		height:"578",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});

	function jsClickGood(g){
		<% If vUserID = "" Then %>
			if ("<%=IsUserLoginOK%>"=="False") {
				if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
					var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
					winLogin.focus();
					return;
				}
			}
		<% Else %>
			$.ajax({
				type:"GET",
				url:"/event/etc/doEventSubscript70687.asp?g="+g+"",
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								var r1;
								var r2;
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
									r1 = res[1].substring(0,1);
									r2 = res[1].substring(1);
									$("#checkcnt"+g).empty().text(r2);
									
									if(r1 == "I"){
										$("#goodbtn"+g).addClass("heartOn");
									}else{
										$("#goodbtn"+g).removeClass("heartOn");
									}
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
								alert("잘못된 접근 입니다.1");
								document.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다.2");
					document.location.reload();
					return false;
				}
			});
		<% End If %>
	}
	function fnlayerClose(){
		$("#resultLayer").hide();
	}
</script>
<div class="evt70687">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/tit_between.png" alt="메리 비트윈! - 비트윈 캐릭터 상품을 구매하신 고객 중 선착순 100분께 비트윈 에코백을 드립니다.(랜덤발송)" /></h2>
	<div class="item">
		<span class="item01"><button type="button" <%=CHKIIF(fnMyGoodCheck(vArr,1),"class='heartOn'","")%> id="goodbtn1" onclick="jsClickGood('1');return false;">좋아요</button><strong id="checkcnt1"><%=vCount(0)%></strong></span>
		<i class="flag flagBest"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/ico_between_best.png" alt="BEST" /></i>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_item1.jpg" alt="Mochi Couple 찰떡 궁합 모찌 커플!" usemap="#btwChar1Map" /></p>
		<map name="btwChar1Map">
			<area shape="rect" coords="571,52,1031,532" href="/shopping/category_prd.asp?itemid=1410057&pEtr=70687" alt="Mochi Couple 찰떡 궁합 모찌 커플!" />
		</map>
	</div>
	<div class="item">
		<span class="item02"><button type="button" <%=CHKIIF(fnMyGoodCheck(vArr,2),"class='heartOn'","")%> id="goodbtn2" onclick="jsClickGood('2');return false;">좋아요</button><strong id="checkcnt2"><%=vCount(1)%></strong></span>
		<i class="flag flagNew"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/ico_between_new.png" alt="NEW" /></i>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_item2.jpg" alt="Merry 비트윈 대표 여친 메리!" usemap="#btwChar2Map" /></p>
		<map name="btwChar2Map">
			<area shape="rect" coords="110,19,569,499" href="/shopping/category_prd.asp?itemid=1485266&pEtr=70687" alt="Merry 비트윈 대표 여친 메리!" />
		</map>
	</div>
	<div class="rolling rolling1">
		<div id="slide" class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide1.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide2.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide3.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide4.jpg" alt="" /></div>
		</div>
	</div>
	<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/subtit_between.png" alt="비트윈에서 놀러온 다른 친구들도 소개합니다!" /></h3>
	<div class="item">
		<span class="item03"><button type="button" <%=CHKIIF(fnMyGoodCheck(vArr,3),"class='heartOn'","")%> id="goodbtn3" onclick="jsClickGood('3');return false;">좋아요</button><strong id="checkcnt3"><%=vCount(2)%></strong></span>
		<span class="item04"><button type="button" <%=CHKIIF(fnMyGoodCheck(vArr,4),"class='heartOn'","")%> id="goodbtn4" onclick="jsClickGood('4');return false;">좋아요</button><strong id="checkcnt4"><%=vCount(3)%></strong></span>
		<span class="item05"><button type="button" <%=CHKIIF(fnMyGoodCheck(vArr,5),"class='heartOn'","")%> id="goodbtn5" onclick="jsClickGood('5');return false;">좋아요</button><strong id="checkcnt5"><%=vCount(4)%></strong></span>
		<span class="item06"><button type="button" <%=CHKIIF(fnMyGoodCheck(vArr,6),"class='heartOn'","")%> id="goodbtn6" onclick="jsClickGood('6');return false;">좋아요</button><strong id="checkcnt6"><%=vCount(5)%></strong></span>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_item3.jpg" alt="Milk / Gray / Ivy / Robin Egg" usemap="#btwChar3Map" /></p>
		<map name="btwChar3Map">
			<area shape="rect" coords="359,29,554,333" href="/shopping/category_prd.asp?itemid=1291762&pEtr=70687" alt="밀크 머그" />
			<area shape="rect" coords="869,30,1064,333" href="/shopping/category_prd.asp?itemid=1342237&pEtr=70687" alt="그레이 머그" />
			<area shape="rect" coords="359,363,554,667" href="/shopping/category_prd.asp?itemid=1350015&pEtr=70687" alt="데코 스티커_아이비" />
			<area shape="rect" coords="868,363,1064,668" href="/shopping/category_prd.asp?itemid=1350017&pEtr=70687" alt="데코 스티커_로빈" />
		</map>
	</div>
	<div class="rolling rolling2">
		<div id="slide2" class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide11.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide12.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide13.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/img_between_slide14.jpg" alt="" /></div>
		</div>
	</div>
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70687/txt_between.png" alt="Between - 비트윈은 사랑하는 두 사람만을 위한 SNS 입니다. 둘만을 위한 채팅, 사진첩, 캘린더를 통해 여러분의 소중한 추억을 더욱 아름답게 저장해드려요." /></p>
</div>
<%
Function fnMyGoodCheck(arr,num)
	Dim vTmp, i
	vTmp = False
	If IsUserLoginOK Then
		If IsArray(arr) Then
			For i = 0 To UBound(arr,2)
				If CStr(arr(0,i)) = CStr(num) Then
					vTmp = True
					Exit For
				End IF
			Next
		End If
	End If
	fnMyGoodCheck = vTmp
End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->