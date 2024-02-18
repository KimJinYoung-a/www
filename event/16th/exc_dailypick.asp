<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'###########################################################
' Description : 16주년 이벤트 골라보쑈
' History : 2017-09-28 이종화
'###########################################################


'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/16th/" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

''// Facebook 오픈그래프 메타태그 작성
'strPageKeyword = "[텐바이텐] 16주년 텐쑈"
'strPageDesc = "[텐바이텐] 이벤트 - 매일 응모 이벤트 골라보쑈! 하루에 한번 엄청난 선물에 도전하세요!"
'strPageUrl = "http://www.10x10.co.kr/event/16th/"
'strPageImage = "http://webimage.10x10.co.kr/eventIMG/2017/16th/m/kakao_tenshow_main.jpg"

Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 16주년 골라보쑈!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/16th/")
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2017/16th/m/kakao_tenshow_main.jpg")

Dim vUserID
vUserID		= GetEncLoginUserID

%>
<script>
function checkpick(){
	<% If Not(IsUserLoginOK) Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% else %>
		<%' If Now() > #09/27/2017 23:59:59# And Now() < #10/25/2017 23:59:59# Then '테스트용%>
		<% If Now() > #10/09/2017 23:59:59# And Now() < #10/25/2017 23:59:59# Then %>
			$.ajax({
				type:"GET",
				url:"/event/16th/dailypick_proc.asp",
				data: "mode=add",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								//console.log(res[1]);
								if (res[0]=="OK"){
									$("#layerCont").empty().html(res[1]);
									viewPoupLayer('modal',$('#lyrGollabo').html());
									return false;
								} else {
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
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;				
		<% End If %>
	<% End If %>
}

function get_coupon(){
<% If IsUserLoginOK Then %>
	<%' If not(Now() > #09/27/2017 23:59:59# And Now() < #10/25/2017 23:59:59#) Then '테스트용%>
	<% If not(Now() > #10/09/2017 23:59:59# And Now() < #10/25/2017 23:59:59#) Then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% else %>
		var rstStr = $.ajax({
			type: "POST",
			url: "/event/16th/dailypick_proc.asp",
			data: "mode=coupon",
			dataType: "text",
			async: false
		}).responseText;
		if (rstStr == "SUCCESS"){
			alert('쿠폰이 발급되었습니다.');
			//location.reload();
			return false;
		}else if (rstStr == "MAXCOUPON"){
			alert('오늘의 쿠폰을 모두 받으셨습니다.');
			return false;
		}else if (rstStr == "NOT1"){
			alert('응모후 다운로드가 가능합니다.');
			return false;
		}else if (rstStr == "DATENOT"){
			alert('이벤트 응모 기간이 아닙니다.');
			return false;
		}else if (rstStr == "USERNOT"){
			alert('로그인을 해주세요.');
			return false;
		}else{
			alert('관리자에게 문의');
			return false;
		}
	<% end if %>
<% Else %>
	if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
<% end if %>
}

function sharesns(snsnum) {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		console.log(snsnum);
		var reStr;
		var str = $.ajax({
			type: "GET",
			url:"/event/16th/dailypick_proc.asp",
			data: "mode=snschk&snsnum="+snsnum,
			dataType: "text",
			async: false
		}).responseText;
			reStr = str.split("|");
			console.log(str);
			if(reStr[1] == "tw") {
				popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
			}else if(reStr[1]=="fb"){
				popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
			}else if(reStr[1]=="pt"){
				popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','<%=snpImg%>');
			}else if(reStr[1] == "none"){
				alert('참여 이력이 없습니다.\n응모후 이용 하세요');
				return false;
			}else if(reStr[1] == "end"){
				alert('공유는 하루에 1회만 가능합니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
	<% End If %>
}

function mypicklist(){
	<% If IsUserLoginOK Then %>
		<% If Now() > #10/09/2017 23:59:59# And Now() < #10/25/2017 23:59:59# Then %>
			$.ajax({
				type:"GET",
				url:"/event/16th/dailypick_proc.asp",
				data: "mode=mypick",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								//console.log(res[1]);
								if (res[0]=="OK"){
									$("#mypicklist").empty().html(res[1]);
									viewPoupLayer('modal',$('#lyrResult').html());
									return false;
								} else {
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
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;				
		<% End If %>
	<% else %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인후 현황을 확인 하실 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
}
</script>
<div class="section show-event2">
	<div class="inner">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/tit_select.png" alt="매일 응모 이벤트 골라보쑈" /></h3>
		<div class="desc">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_select.png" alt="하루에 한 번 엄청난 선물에 도전하세요!" /></p>
			<a href="" onclick="mypicklist();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_result.png" alt="내 응모 현황 확인하기" /></a>
		</div>
		<a href="/shopping/category_prd.asp?itemid=1750502&pEtr=80410" class="item-rolling item1">
			<div id="slide1" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png" alt="다이슨 V8 앱솔루트 플러스" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png" alt="오각뿔캔들" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png" alt="위글위글 블루투스 스피커" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4.png" alt="오버액션토끼 가방고리(3종)" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png" alt="케이블바이트" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png" alt="텐텐배송 무료 쿠폰" /></div>
			</div>
		</a>
		<a href="/shopping/category_prd.asp?itemid=1474359&pEtr=80410" class="item-rolling item2">
			<div id="slide2" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png" alt="오각뿔캔들" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png" alt="다이슨 V8 앱솔루트 플러스" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4.png" alt="오버액션토끼 가방고리(3종)" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png" alt="위글위글 블루투스 스피커" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png" alt="텐텐배송 무료 쿠폰" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png" alt="케이블바이트" /></div>
			</div>
		</a>
		<a href="/shopping/category_prd.asp?itemid=1758010&pEtr=80410" class="item-rolling item3">
			<div id="slide3" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4.png" alt="오버액션토끼 가방고리(3종)" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png" alt="텐텐배송 무료 쿠폰" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png" alt="다이슨 V8 앱솔루트 플러스" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png" alt="케이블바이트" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png" alt="오각뿔캔들" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png" alt="위글위글 블루투스 스피커" /></div>
			</div>
		</a>
		<a href="/shopping/category_prd.asp?itemid=1768120&pEtr=80410" class="item-rolling item4">
			<div id="slide4" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png" alt="텐텐배송 무료 쿠폰" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4.png" alt="오버액션토끼 가방고리(3종)" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png" alt="케이블바이트" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png" alt="다이슨 V8 앱솔루트 플러스" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png" alt="위글위글 블루투스 스피커" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png" alt="오각뿔캔들" /></div>
			</div>
		</a>
		<a href="/shopping/category_prd.asp?itemid=1759439&pEtr=80410" class="item-rolling item5">
			<div id="slide5" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png" alt="위글위글 블루투스 스피커" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png" alt="케이블바이트" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png" alt="오각뿔캔들" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png" alt="텐텐배송 무료 쿠폰" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4.png" alt="오버액션토끼 가방고리(3종)" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png" alt="다이슨 V8 앱솔루트 플러스" /></div>
			</div>
		</a>
		<div class="item-rolling item6">
			<div id="slide6" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_2.png" alt="오각뿔캔들" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_3.png" alt="위글위글 블루투스 스피커" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_1.png" alt="다이슨 V8 앱솔루트 플러스" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_4.png" alt="오버액션토끼 가방고리(3종)" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_5.png" alt="케이블바이트" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/img_item_6.png" alt="텐텐배송 무료 쿠폰" /></div>
			</div>
		</div>
		<button type="button" class="btn-select" onclick="checkpick();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_select_v3.png" alt="응모하기" /></button>
		<div class="deco d1"></div>
		<div class="deco d2"></div>
		<div class="deco d3"></div>
	</div>

	<%'!-- 골라보쑈 응모 레이어 --%>
	<div id="lyrGollabo" style="display:none;">
		<div class="layer layer-gollabo">
			<div class="layerCont" id="layerCont"></div>
			<button type="button" class="btn-close" onclick="ClosePopLayer()">닫기</button>
		</div>
	</div>
	<%'!--// 골라보쑈 응모 레이어 --%>

	<%'!-- 응모결과 레이어 --%>
	<div id="lyrResult" style="display:none;">
		<div class="layer layer-result">
			<div class="layerCont" id="mypicklist"></div>
			<button type="button" class="btn-close" onclick="ClosePopLayer()">닫기</button>
		</div>
	</div>
	<%'!--// 응모결과 레이어 --%>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->