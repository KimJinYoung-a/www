<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 MAIN
' History : 2019-08-26 최종원 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->

<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<!-- #include virtual="/diarystory2020/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "//m.10x10.co.kr/diarystory2020/"
			REsponse.End
		end if
	end if
end if

IF application("Svr_Info") <> "Dev" THEN
	If GetLoginUserLevel <> "7" Then
		Response.Redirect "/diarystory2021/"
	End If
end if

Dim oExhibition
dim masterCode
dim i

IF application("Svr_Info") = "Dev" THEN
    masterCode = "3"
else
    masterCode = "10"
end if

SET oExhibition = new ExhibitionCls
%>
<%
public function couponDisp(couponVal)
	if couponVal = "" or isnull(couponVal) then exit function
	couponDisp = chkIIF(couponVal > 100, couponVal, couponVal & "%")
end function
%>
<script>
// 검색 스크립트
$(function(){
	$(".cate-menu .diary-attr li input").click(function(){		
		if($(this).val() == ''){
        // 전체
			$(".cate-menu .diary-attr input[type=checkbox]").prop("checked",function(i, val){
				return $(this).val() == '' ? true : false
			});
		}else{
        // 전체 이외
			$("#all_items").prop("checked",false)
            if($('.cate-menu input:checkbox:checked').length == 0){
				$("#all_items").prop("checked", true)
            }			
		}
	})
	// 기프트팝업 
	$('#mask').css({'width':$(document).width(),'height':$(document).height()});
	$('.btn-gift-lyr').click(function(){
		$('#boxes, #mask').show();
		$('.layer-area').show();
		$("html, body").css({'overflow-x':'hidden'})
		giftPop();
		return false;
	})
	$('.layer-area .btn-close, #mask').click(function(){
		$(".layer-area, #boxes, #mask").hide();
		$("html, body").css({'overflow-x':'auto'})
		return false;
	});
})
</script>
</head>
<body>
<div class="wrap">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2020">
		<div id="contentWrap" class="diary-main">
        <!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<div class="diary-content">
				<%'<!-- 상단 슬라이드 영역 -->%>
				<!-- #include virtual="/diarystory2020/inc/main/inc_main_rolling.asp" -->
				<%'<!-- 모두에게 드리는 스페셜 혜택 -->%>
				<!-- #include virtual="/diarystory2020/inc/main/inc_special_benefit.asp" -->
				<%'<!-- 추천 다이어리 -->%>
				<!-- #include virtual="/diarystory2020/inc/main/inc_recommended_diary.asp" -->
				<%'<!-- 세상의 모든 다이어리 -->%>
				<div class="category">
					<div class="tit-area" id="cate-menu"><h3>세상의 모든 <b>다이어리</b></h3></div>
					<div class="cate-menu">
						<ul class="diary-attr">
							<li class="all"><input value="" type="checkbox" name="dtype" id="all_items" checked/><label for="all_items">전체보기</label></li>
							<li><input type="checkbox" value="302001" name="dtype" id="simple" /><label for="simple">심플</label></li>
							<li><input type="checkbox" value="302002" name="dtype" id="illust" /><label for="illust">일러스트</label></li>
							<li><input type="checkbox" value="302004" name="dtype" id="pattern" /><label for="pattern">패턴</label></li>
							<li class="bar"><input type="checkbox" value="302003" name="dtype" id="photo" /><label for="photo">포토</label></li>
							<li><input type="checkbox" value="307006" name="dtype" id="hard" /><label for="hard">양장/무선</label></li>
							<li><input type="checkbox" value="307007" name="dtype" id="spring" /><label for="spring">스프링</label></li>
							<li class="bar"><input type="checkbox" value="307008" name="dtype" id="six" /><label for="six">6공</label></li>
							<li><input type="checkbox" value="303001" name="dtype" id="year" /><label for="year">2020</label></li>
							<li><input type="checkbox" value="303002" name="dtype" id="every" /><label for="every">만년형</label></li>
						</ul>
					</div>
					<!-- #include virtual="/diarystory2020/inc/main/inc_prdwrap.asp" -->
				</div>
					<!-- #include virtual="/diarystory2020/inc/inc_etcevent.asp" -->
			</div>
		</div>
	</div>
	<div class="layer-area">
		<div class="gift-popup">
			<a href="" class="btn-close">&#10005;</a>
			<div class="inner">
				<img src="//fiximage.10x10.co.kr/web2019/diary2020/diary_gift_1.jpg" alt="like you edition">
				<img src="//fiximage.10x10.co.kr/web2019/diary2020/diary_gift_2.jpg" alt="15,000이상 구매 시">
				<img src="//fiximage.10x10.co.kr/web2019/diary2020/diary_gift_3.jpg" alt="35,000이상 구매 시">
				<img src="//fiximage.10x10.co.kr/web2019/diary2020/diary_gift_4.jpg?v=1.01" alt="50,000이상 구매 시">
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->