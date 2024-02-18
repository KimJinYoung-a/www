<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : wedding_쇼핑리스트 // cache DB경유
' History : 2018-04-17 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList, intI

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "WeddingShoppingList_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "WeddingShoppingList"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_Wedding_ShoppingList_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

Function GetDDayTitleMo(ByVal WeddingStepID)
	If (WeddingStepID="1") Then
		GetDDayTitleMo =  "상견례"
	ElseIf (WeddingStepID="2") Then
		GetDDayTitleMo =  "혼수 가구 준비"
	ElseIf (WeddingStepID="3") Then
		GetDDayTitleMo =  "혼수 가전 준비"
	ElseIf (WeddingStepID="4") Then
		GetDDayTitleMo =  "웨딩 촬영"
	ElseIf (WeddingStepID="5") Then
		GetDDayTitleMo =  "리빙 아이템 준비"
	ElseIf (WeddingStepID="6") Then
		GetDDayTitleMo =  "브라이덜 샤워"
	ElseIf (WeddingStepID="7") Then
		GetDDayTitleMo =  "신혼여행 짐싸기"
	ElseIf (WeddingStepID="8") Then
		GetDDayTitleMo =  "집들이"
	End If
End Function

Function GetDDayImage(ByVal ItemID, UploadImage)
	If (instr(UploadImage,"http")>0) Then
		GetDDayImage = UploadImage
	Else
		GetDDayImage = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(ItemID) + "/" + UploadImage
	End If
End Function

On Error Resume Next

If IsArray(arrList) Then
%>
<script type="text/javascript">
$(function(){
	// 롤링밑작은썸네일삽입
	// rolling1
	$(".rolling1 .pagination span:nth-child(1)").css('background-image' , 'url(<%=GetDDayImage(arrList(0,4),arrList(1,4))%>)');
	$(".rolling1 .pagination span:nth-child(2)").css('background-image' , 'url(<%=GetDDayImage(arrList(3,4),arrList(4,4))%>)');
	$(".rolling1 .pagination span:nth-child(3)").css('background-image' , 'url(<%=GetDDayImage(arrList(6,4),arrList(7,4))%>)');
	$(".rolling1 .pagination span:nth-child(4)").css('background-image' , 'url(<%=GetDDayImage(arrList(9,4),arrList(10,4))%>)');
	$(".rolling1 .pagination span:nth-child(5)").css('background-image' , 'url(<%=GetDDayImage(arrList(12,4),arrList(13,4))%>)');
	$(".rolling1 .pagination span:nth-child(6)").css('background-image' , 'url(<%=GetDDayImage(arrList(15,4),arrList(16,4))%>)');
	// rolling2
	$(".rolling2 .pagination span:nth-child(1)").css('background-image' , 'url(<%=GetDDayImage(arrList(0,5),arrList(1,5))%>)');
	$(".rolling2 .pagination span:nth-child(2)").css('background-image' , 'url(<%=GetDDayImage(arrList(3,5),arrList(4,5))%>)');
	$(".rolling2 .pagination span:nth-child(3)").css('background-image' , 'url(<%=GetDDayImage(arrList(6,5),arrList(7,5))%>)');
	// rolling3
	$(".rolling3 .pagination span:nth-child(1)").css('background-image' , 'url(<%=GetDDayImage(arrList(0,8),arrList(1,8))%>)');
	$(".rolling3 .pagination span:nth-child(2)").css('background-image' , 'url(<%=GetDDayImage(arrList(3,8),arrList(4,8))%>)');
	$(".rolling3 .pagination span:nth-child(3)").css('background-image' , 'url(<%=GetDDayImage(arrList(6,8),arrList(7,8))%>)');
	$(".rolling3 .pagination span:nth-child(4)").css('background-image' , 'url(<%=GetDDayImage(arrList(9,8),arrList(10,8))%>)');
});
</script>
			<div class="shp-list">
				<!-- D-100 -->
				<div class="section section1">
					<div>
						<p class="d-day" ><i></i>D-100<span>결혼 준비의 설레는 첫 걸음</span></p>
					</div>
					<button class="dwn-chck-list" onclick="javascript:fileDownload(4374);"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_download_x2.png" alt="웨딩체크리스트 다운받기" /></button>
					<div class="inner">
						<!-- 결혼계획세우기 -->
						<div class="step step1 overHidden">
							<div class="thumb ftRt"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,0)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,0),arrList(1,0))%>" alt="<%=arrList(2,0)%>" style="width:246px; height:246px;"/></a></span></div>
							<div class="info ftLt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d100_step_1_x2.png" alt="결혼 계획 세우기 만족스러운 결혼 준비는 꼼꼼한 계획에서부터! 충분한 대화를 통해 '우리'의 결혼을 준비해보세요.해야 할 일이 한눈에 보이면 준비가 수월해져요!" usemap="#map-d100-1" style="width:414px; height:246px;" />
								<map name="map-d100-1">
									<area alt="웨딩다이어리" href="/search/search_result.asp?rect=웨딩다이어리&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=웨딩다이어리" shape="rect" coords="25,181,127,215" onfocus="this.blur();" />
									<area alt="디데이플래너" href="/search/search_result.asp?rect=디데이플래너&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=디데이플래너" shape="rect" coords="128,181,230,215" onfocus="this.blur();" />
								</map>
								<a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar3');" class="more">more<i></i></a>
							</div>
						</div>
						<!--// 결혼계획세우기 -->
						<!-- 상견례 -->
						<div class="step step2">
							<div class="info">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d100_step_2_x2.png" alt="상견례 예비 신랑, 신부와 양가 가족이 공식적으로 만나 인사를 나누고 혼인 절차를 의논하는 자리에요.긴장되는 자리인 만큼 미리미리 준비하는 게 좋겠죠?" usemap="#map-d100-2" style="width:660px; height:224px;" />
								<map name="map-d100-2" id="map-d100-2">
									<area alt="감사카드" href="/search/search_result.asp?rect=감사카드&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=감사카드" shape="rect" coords="226,123,299,153" onfocus="this.blur();"/>
									<area alt="정장원피스" href="/shopping/category_list.asp?disp=117102104" shape="rect" coords="303,123,390,154" onfocus="this.blur();"/>
									<area alt="미들힐" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%AF%B8%EB%93%A4%ED%9E%90&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%AF%B8%EB%93%A4%ED%9E%90" shape="rect" coords="393,122,457,154" onfocus="this.blur();"/>
									<area alt="떡케익" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%96%A1%EC%BC%80%EC%9D%B5&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%96%A1%EC%BC%80%EC%9D%B5" shape="rect" coords="460,123,522,153" onfocus="this.blur();"/>
									<area alt="주얼리" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%A3%BC%EC%96%BC%EB%A6%AC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%A3%BC%EC%96%BC%EB%A6%AC" shape="rect" coords="226,157,288,187" onfocus="this.blur();"/>
									<area alt="네일" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%84%A4%EC%9D%BC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%84%A4%EC%9D%BC" shape="rect" coords="290,156,343,186" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar1');" class="more">more<i></i></a>
							</div>
							<div class="thumb">
								<span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,1)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,1),arrList(1,1))%>" alt="<%=arrList(2,1)%>" style="width:208px; height:208px;" /></a></span>
								<span><a href="/shopping/category_prd.asp?itemid=<%=arrList(3,1)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(3,1),arrList(4,1))%>" alt="<%=arrList(5,1)%>" style="width:208px; height:208px;" /></a></span>
								<span><a href="/shopping/category_prd.asp?itemid=<%=arrList(6,1)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(6,1),arrList(7,1))%>" alt="<%=arrList(8,1)%>" style="width:208px; height:208px;" /></a></span>
							</div>
						</div>
						<!--// 상견례 -->
						<!--// 프로포즈 -->
						<div class="step step3 more-kit">
							<div class="thumb"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,2)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,2),arrList(1,2))%>" alt="<%=arrList(2,2)%>"  style="width:382px; height:377px;"/></a></span></div>
							<div class="info">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d100_step_3_x2.png" alt="프로포즈 약효가 평생 간다는 프로포즈! 진실한 담아 마음을 전하고, 평생을 약속해보세요." usemap="#map-d100-3" style="width:382px; height:323px;"/>
								<map name="map-d100-3" id="map-d100-3">
									<area alt="프로포즈소품" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%94%84%EB%A1%9C%ED%8F%AC%EC%A6%88%EC%86%8C%ED%92%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%94%84%EB%A1%9C%ED%8F%AC%EC%A6%88%EC%86%8C%ED%92%88" shape="rect" coords="173,142,270,172" onfocus="this.blur();"/>
									<area alt="프로포즈꽃" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%94%84%EB%A1%9C%ED%8F%AC%EC%A6%88%EA%BD%83&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%94%84%EB%A1%9C%ED%8F%AC%EC%A6%88%EA%BD%83" shape="rect" coords="273,141,363,171" onfocus="this.blur();"/>
									<area alt="웨딩슈즈" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%9B%A8%EB%94%A9%EC%8A%88%EC%A6%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%9B%A8%EB%94%A9%EC%8A%88%EC%A6%88" shape="rect" coords="171,175,246,206" onfocus="this.blur();"/>
									<area alt="플라워박스" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%94%8C%EB%9D%BC%EC%9B%8C%EB%B0%95%EC%8A%A4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%94%8C%EB%9D%BC%EC%9B%8C%EB%B0%95%EC%8A%A4" shape="rect" coords="248,175,338,205" onfocus="this.blur();"/>
									<area alt="링박스" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%A7%81%EB%B0%95%EC%8A%A4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%A7%81%EB%B0%95%EC%8A%A4" shape="rect" coords="171,208,235,236" onfocus="this.blur();"/>
									<area alt="캔들" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BA%94%EB%93%A4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BA%94%EB%93%A4" shape="rect" coords="237,207,288,238" onfocus="this.blur();"/>
									<area alt="파티용품" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%8C%8C%ED%8B%B0%EC%9A%A9%ED%92%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%8C%8C%ED%8B%B0%EC%9A%A9%ED%92%88" shape="rect" coords="291,207,368,238" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar4');" class="more">more<i></i></a>
							</div>
							<div class="kit">
								<a href="/shopping/category_prd.asp?itemid=1895808&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_proposal_kit_x2.png" alt="프로포즈 심플 키트 보기" style="width:418px; height:51px;" /></a>
							</div>
						</div>
						<!--// 프로포즈 -->
						<!-- 웨딩다이어트 -->
						<div class="step step4 overHidden">
							<div class="thumb ftRt"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,3)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,3),arrList(1,3))%>" alt="<%=arrList(2,3)%>" style="width:392px; height:262px;"/></a></span></div>
							<div class="info ftLt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d100_step_4_x2.png?v=1.0" alt="웨딩다이어트 웨딩촬영,가봉,본식을위해서 외모를 가꿔야할 시기예요! 다이어트의 핵심인 식단조절과 꾸준한 피부관리 잊지마세요!" usemap="#map-d100-4" style="width:699px; height:262px;"/>
								<map name="map-d100-4" id="map-d100-4">
									<area alt="다이어트" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8" shape="rect" coords="225,167,300,197" onfocus="this.blur();"/>
									<area alt="다이어트도시락" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8%EB%8F%84%EC%8B%9C%EB%9D%BD&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8%EB%8F%84%EC%8B%9C%EB%9D%BD" shape="rect" coords="303,167,413,197" onfocus="this.blur();"/>
									<area alt="다이어트플래너" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8%ED%94%8C%EB%9E%98%EB%84%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8%ED%94%8C%EB%9E%98%EB%84%88" shape="rect" coords="417,168,528,197" onfocus="this.blur();"/>
									<area alt="마사지볼" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%A7%88%EC%82%AC%EC%A7%80%EB%B3%BC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%A7%88%EC%82%AC%EC%A7%80%EB%B3%BC" shape="rect" coords="224,200,299,229" onfocus="this.blur();"/>
									<area alt="1일1팩" href="http://www.10x10.co.kr/search/search_result.asp?rect=1%EC%9D%BC1%ED%8C%A9&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=1%EC%9D%BC1%ED%8C%A9" shape="rect" coords="302,200,377,229" onfocus="this.blur();"/>
									<area alt="바디케어" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B0%94%EB%94%94%EC%BC%80%EC%96%B4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B0%94%EB%94%94%EC%BC%80%EC%96%B4" shape="rect" coords="382,201,455,230" onfocus="this.blur();"/>
									<area alt="페이스롤러" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%8E%98%EC%9D%B4%EC%8A%A4%EB%A1%A4%EB%9F%AC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%8E%98%EC%9D%B4%EC%8A%A4%EB%A1%A4%EB%9F%AC" shape="rect" coords="459,200,545,229" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar5');" class="more">more<i></i></a>
							</div>
						</div>
						<!-- 웨딩다이어트 -->
					</div>
					<a href="javascript:fnEvtItemList(85159,240250,'tab1','');" class="more-all">D-100 쇼핑리스트 모두 보기</a>
				</div>
				<!--// D-100 -->
				<!-- D-60 -->
				<div class="section section2">
					<p class="d-day"><i></i>D-60<span>하나씩 차근차근 본격적인 준비!</span></p>
					<div class="inner">
						<!-- 혼수가구준비 -->
						<div class="step step1 more-kit overHidden">
							<div class="thumb ftRt">
								<div class="rolling rolling1">
									<div class="swiper-container">
										<div class="swiper-wrapper">
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,4)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,4),arrList(1,4))%>" alt="<%=arrList(2,4)%>" style="width:632px; height:356px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(3,4)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(3,4),arrList(4,4))%>" alt="<%=arrList(5,4)%>" style="width:632px; height:356px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(6,4)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(6,4),arrList(7,4))%>" alt="<%=arrList(8,4)%>" style="width:632px; height:356px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(9,4)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(9,4),arrList(10,4))%>" alt="<%=arrList(11,4)%>" style="width:632px; height:356px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(12,4)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(12,4),arrList(13,4))%>" alt="<%=arrList(14,4)%>" style="width:632px; height:356px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(15,4)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(15,4),arrList(16,4))%>" alt="<%=arrList(17,4)%>" style="width:632px; height:356px;" /></a></span></div>
										</div>
									</div>
									<div class="pagination"></div>
								</div>
							</div>
							<div class="info ftLt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d60_step_1_x2.png" alt="혼수 가구 준비 신혼집이 정해졌다면, 소품보다는 큰 가구부터 준비하는 것이 좋아요." usemap="#map-d60-1" style="width:430px; height:516px;" />
								<map name="map-d60-1" id="map-d60-1">
									<area alt="신혼가구" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%8B%A0%ED%98%BC%EA%B0%80%EA%B5%AC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%8B%A0%ED%98%BC%EA%B0%80%EA%B5%AC" shape="rect" coords="118,322,198,356" onfocus="this.blur();"/>
									<area alt="소파" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%86%8C%ED%8C%8C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%86%8C%ED%8C%8C" shape="rect" coords="197,322,252,356" onfocus="this.blur();"/>
									<area alt="침대" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%B9%A8%EB%8C%80&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%B9%A8%EB%8C%80" shape="rect" coords="251,322,305,356" onfocus="this.blur();"/>
									<area alt="식탁" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%8B%9D%ED%83%81&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%8B%9D%ED%83%81" shape="rect" coords="305,327,359,356" onfocus="this.blur();"/>
									<area alt="디자인체어" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%94%94%EC%9E%90%EC%9D%B8%EC%B2%B4%EC%96%B4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%94%94%EC%9E%90%EC%9D%B8%EC%B2%B4%EC%96%B4" shape="rect" coords="119,356,210,390" onfocus="this.blur();"/>
									<area alt="화장대" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%99%94%EC%9E%A5%EB%8C%80&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%99%94%EC%9E%A5%EB%8C%80" shape="rect" coords="210,356,275,390" onfocus="this.blur();"/>
									<area alt="서랍장" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%84%9C%EB%9E%8D%EC%9E%A5&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%84%9C%EB%9E%8D%EC%9E%A5" shape="rect" coords="275,356,341,390" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240256,'tab2','groupBar2');" class="more">more<i></i></a>
							</div>
							<div class="kit">
								<a href="/shopping/category_prd.asp?itemid=1926966&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_furniture_kit_x2.png" alt="가구 심플 키트 보기" style="width:1135px; height:51px;" /></a>
							</div>
						</div>
						<!--// 혼수가구준비 -->
						<!-- 혼수가전준비 -->
						<div class="step step2">
							<div class="info">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d60_step_2_x2.png" alt="혼수 가전 준비 가구와 함께 가전도 준비해야겠죠? 기능뿐 아니라, 디자인까지 잡은 가전이 많아져 고르는 즐거움도 2배!" usemap="#map-d60-2" style="width:650px; height:325px;" />
								<map name="map-d60-2" id="map-d60-2">
									<area alt="디자인가전" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%94%94%EC%9E%90%EC%9D%B8%EA%B0%80%EC%A0%84&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%94%94%EC%9E%90%EC%9D%B8%EA%B0%80%EC%A0%84" shape="rect" coords="381,115,466,148" onfocus="this.blur();"/>
									<area alt="청소기" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%B2%AD%EC%86%8C%EA%B8%B0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%B2%AD%EC%86%8C%EA%B8%B0" shape="rect" coords="469,116,535,146" onfocus="this.blur();"/>
									<area alt="공기청정기" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EA%B3%B5%EA%B8%B0%EC%B2%AD%EC%A0%95%EA%B8%B0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EA%B3%B5%EA%B8%B0%EC%B2%AD%EC%A0%95%EA%B8%B0" shape="rect" coords="537,116,626,146" onfocus="this.blur();"/>
									<area alt="가습기" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EA%B0%80%EC%8A%B5%EA%B8%B0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EA%B0%80%EC%8A%B5%EA%B8%B0" shape="rect" coords="380,151,445,181" onfocus="this.blur();"/>
									<area alt="선풍기" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%84%A0%ED%92%8D%EA%B8%B0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%84%A0%ED%92%8D%EA%B8%B0" shape="rect" coords="446,150,511,180" onfocus="this.blur();"/>
									<area alt="커피머신" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BB%A4%ED%94%BC%EB%A8%B8%EC%8B%A0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BB%A4%ED%94%BC%EB%A8%B8%EC%8B%A0" shape="rect" coords="512,150,589,180" onfocus="this.blur();"/>
									<area alt="오븐" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%98%A4%EB%B8%90&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%98%A4%EB%B8%90" shape="rect" coords="590,150,643,182" onfocus="this.blur();"/>
									<area alt="토스터기" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%86%A0%EC%8A%A4%ED%84%B0%EA%B8%B0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%86%A0%EC%8A%A4%ED%84%B0%EA%B8%B0" shape="rect" coords="380,184,456,216" onfocus="this.blur();"/>
									<area alt="전기주전자" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%A0%84%EA%B8%B0%EC%A3%BC%EC%A0%84%EC%9E%90&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%A0%84%EA%B8%B0%EC%A3%BC%EC%A0%84%EC%9E%90" shape="rect" coords="458,183,546,215" onfocus="this.blur();"/>
									<area alt="믹서기" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%AF%B9%EC%84%9C%EA%B8%B0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%AF%B9%EC%84%9C%EA%B8%B0" shape="rect" coords="548,184,612,216" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240256,'tab2','groupBar5');" class="more">more<i></i></a>
							</div>
							<div class="thumb overHidden">
								<div class="rolling rolling2 ftLt">
									<div class="swiper-container">
										<div class="swiper-wrapper">
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,5)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,5),arrList(1,5))%>" alt="<%=arrList(2,5)%>" style="width:522px; height:311px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(3,5)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(3,5),arrList(4,5))%>" alt="<%=arrList(5,5)%>"style="width:522px; height:311px;" /></a></span></div>
											<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(6,5)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(6,5),arrList(7,5))%>" alt="<%=arrList(8,5)%>"style="width:522px; height:311px;" /></a></span></div>
										</div>
									</div>
									<div class="pagination"></div>
								</div>
							</div>
						</div>
						<!--// 혼수가전준비 -->
						<!-- 웨딩촬영 -->
						<div class="step step3 more-kit">
							<div class="thumb"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,6)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,6),arrList(1,6))%>" alt="<%=arrList(2,6)%>" style="width:355px; height:355px;" /></a></span></div>
							<div class="info">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d60_step_3_x2.png" alt="웨딩 촬영 둘만의 특별한 컨셉이 담긴 웨딩 사진을 꿈꾸시나요? 셀프 웨딩을 위한 상품부터, 사진을 특별하게 해줄 센스있는 소품까지!" usemap="#map-d60-3" style="width:355px; height:329px;" />
								<map name="map-d60-3" id="map-d60-3">
									<area alt="웨딩소품" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%9B%A8%EB%94%A9%EC%86%8C%ED%92%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%9B%A8%EB%94%A9%EC%86%8C%ED%92%88" shape="rect" coords="129,206,202,237" onfocus="this.blur();"/>
									<area alt="웨딩드레스" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%9B%A8%EB%94%A9%EB%93%9C%EB%A0%88%EC%8A%A4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%9B%A8%EB%94%A9%EB%93%9C%EB%A0%88%EC%8A%A4" shape="rect" coords="207,206,293,237" onfocus="this.blur();"/>
									<area alt="화관" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%99%94%EA%B4%80&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%99%94%EA%B4%80" shape="rect" coords="127,238,178,269" onfocus="this.blur();"/>
									<area alt="부케" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B6%80%EC%BC%80&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B6%80%EC%BC%80" shape="rect" coords="180,239,231,270" onfocus="this.blur();"/>
									<area alt="부토니에" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B6%80%ED%86%A0%EB%8B%88%EC%97%90&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B6%80%ED%86%A0%EB%8B%88%EC%97%90" shape="rect" coords="236,239,310,270" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240256,'tab2','groupBar1');" class="more">more<i></i></a>
							</div>
							<div class="kit">
								<a href="/shopping/category_prd.asp?itemid=1929160&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_shoes_kit_x2.png" alt="웨딩슈즈 심플 키트 보기" style="width:391x; height:51px;" /></a>
							</div>
						</div>
						<!--// 웨딩촬영 -->
					</div>
					<a href="javascript:fnEvtItemList(85159,240256,'tab2','');" class="more-all">D-60 쇼핑리스트 모두 보기</a>
				</div>
				<!--// D-60 -->

				<!-- D-30 -->
				<div class="section section3">
					<p class="d-day"><i></i>D-30<span>완벽한 결혼을 위해 세심한 점검!</span></p>
					<div class="inner">
						<!-- 브라이덜샤월 -->
						<div class="step step1 ftRt">
							<div class="thumb"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,7)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,7),arrList(1,7))%>" alt="<%=arrList(2,7)%>" style="width:322px; height:322px;" /></a></span></div>
							<div class="info">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d30_step_1_x2.png" alt="브라이덜샤워 많은 신부님들의 로망이라는 브라이덜샤워! 친구들과의 잊지 못할 추억과 함께, 인생샷도 꼭 남겨야겠죠?" usemap="#map-d30-1" style="width:321px; height:362px;"/>
								<map name="map-d30-1" id="map-d30-1">
									<area alt="꽃팔찌" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EA%BD%83%ED%8C%94%EC%B0%8C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EA%BD%83%ED%8C%94%EC%B0%8C" shape="rect" coords="24,197,89,228" onfocus="this.blur();"/>
									<area alt="파티용품" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%8C%8C%ED%8B%B0%EC%9A%A9%ED%92%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%8C%8C%ED%8B%B0%EC%9A%A9%ED%92%88" shape="rect" coords="91,198,167,229" onfocus="this.blur();"/>
									<area alt="파티풍선" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%8C%8C%ED%8B%B0%ED%92%8D%EC%84%A0&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%8C%8C%ED%8B%B0%ED%92%8D%EC%84%A0" shape="rect" coords="170,198,246,229" onfocus="this.blur();"/>
									<area alt="파티접시" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%8C%8C%ED%8B%B0%EC%A0%91%EC%8B%9C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%8C%8C%ED%8B%B0%EC%A0%91%EC%8B%9C" shape="rect" coords="24,231,100,262" onfocus="this.blur();"/>
									<area alt="가랜드" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EA%B0%80%EB%9E%9C%EB%93%9C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EA%B0%80%EB%9E%9C%EB%93%9C" shape="rect" coords="102,231,168,262" onfocus="this.blur();"/>
									<area alt="토퍼" href="/search/search_result.asp?rect=%ED%86%A0%ED%8D%BC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%86%A0%ED%8D%BC" shape="rect" coords="169,231,223,262" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240262,'tab3','groupBar5');" class="more">more<i></i></a>
							</div>
						</div>
						<!--// 브라이덜샤월 -->
						<!-- 리빙아이템준비 -->
						<div class="step step2 more-kit overHidden">
							<div class="thumb ftRt">
									<div class="rolling rolling3">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,8)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,8),arrList(1,8))%>" alt="<%=arrList(2,8)%>" style="width:418px; height:418px;" /></a></span></div>
												<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(3,8)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(3,8),arrList(4,8))%>" alt="<%=arrList(5,8)%>" style="width:418px; height:418px;" /></a></span></div>
												<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(6,8)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(6,8),arrList(7,8))%>" alt="<%=arrList(8,8)%>" style="width:418px; height:418px;" /></a></span></div>
												<div class="swiper-slide"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(9,8)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(9,8),arrList(10,8))%>" alt="<%=arrList(11,8)%>" style="width:418px; height:418px;" /></a></span></div>
											</div>
										</div>
										<div class="pagination"></div>
									</div>
								</div>
								<div class="info ftLt">
									<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d30_step_2_x2.png" alt="리빙 아이템 준비 큰 가구와 가전이 준비되었다면, 리빙 아이템들을 채워 넣을 차례에요. 당장 필요한 아이템은 체크리스트를 작성해야 당황하지 않을 거예요!" usemap="#map-d30-2" style="width:265px; height:578px;" />
									<map name="map-d30-2" id="map-d30-2">
										<area alt="침구세트" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%B9%A8%EA%B5%AC%EC%84%B8%ED%8A%B8&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%B9%A8%EA%B5%AC%EC%84%B8%ED%8A%B8" shape="rect" coords="9,337,83,367" onfocus="this.blur();"/>
										<area alt="커튼" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BB%A4%ED%8A%BC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BB%A4%ED%8A%BC" shape="rect" coords="86,336,138,366" onfocus="this.blur();"/>
										<area alt="블라인드" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B8%94%EB%9D%BC%EC%9D%B8%EB%93%9C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B8%94%EB%9D%BC%EC%9D%B8%EB%93%9C" shape="rect" coords="139,336,216,366" onfocus="this.blur();"/>
										<area alt="식기세트" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%8B%9D%EA%B8%B0%EC%84%B8%ED%8A%B8&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%8B%9D%EA%B8%B0%EC%84%B8%ED%8A%B8" shape="rect" coords="8,369,85,399" onfocus="this.blur();"/>
										<area alt="주방용품" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%A3%BC%EB%B0%A9%EC%9A%A9%ED%92%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%A3%BC%EB%B0%A9%EC%9A%A9%ED%92%88" shape="rect" coords="86,370,163,400" onfocus="this.blur();"/>
										<area alt="러그" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%9F%AC%EA%B7%B8&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%9F%AC%EA%B7%B8" shape="rect" coords="164,369,218,399" onfocus="this.blur();"/>
										<area alt="쿠션" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BF%A0%EC%85%98&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BF%A0%EC%85%98" shape="rect" coords="7,402,61,432" onfocus="this.blur();"/>
										<area alt="욕실용품" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%9A%95%EC%8B%A4%EC%9A%A9%ED%92%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%9A%95%EC%8B%A4%EC%9A%A9%ED%92%88" shape="rect" coords="62,402,139,432" onfocus="this.blur();"/>
										<area alt="커피잔/찻잔" href="/shopping/category_list.asp?disp=112101109 " shape="rect" coords="141,402,233,432" onfocus="this.blur();"/>
									</map>
									<a href="javascript:fnEvtItemList(85159,240262,'tab3','groupBar1');" class="more">more<i></i></a>
								</div>
							<div class="kit"><a href="/shopping/category_prd.asp?itemid=1916509&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_plate_kit_x2.png" alt="플레이트 심플 키트 보기" style="width:755px; height:51px;" /></a></div>
						</div>
						<!--// 리빙아이템준비 -->
					</div>
					<a href="javascript:fnEvtItemList(85159,240262,'tab3','');" class="more-all">D-30 쇼핑리스트 모두 보기</a>
				</div>
				<!--// D-30 -->

				<!-- D-15 -->
				<div class="section section4">
					<p class="d-day"><i></i>D-15<span>꼼꼼한 마무리로 결혼 준비 끝!</span></p>
					<div class="inner">
						<!-- 웨딩부케 -->
						<div class="step step1 overHidden">
							<div class="thumb ftRt"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,9)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,9),arrList(1,9))%>" alt="<%=arrList(2,9)%>" style="width:235px; height:235px;" /></a></span></div>
							<div class="info ftLt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d15_step_1_x2.png" alt="웨딩 부케 웨딩드레스의 완성은 부케! 내가 원하는 스타일로 부케를 직접 만들어보세요!" usemap="#map-d15-1" style="width:222px; height:235px;" />
								<map name="map-d15-1" id="map-d15-1">
									<area alt="부케원데이클래스" href="/shopping/category_prd.asp?itemid=1565056&pEtr=85159" shape="rect" coords="27,178,158,207" onfocus="this.blur();"/>
								</map>
							</div>
						</div>
						<!--// 웨딩부케 -->
						<div class="step step2"><a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar7');" class="more">사례비 / 식권도장<br/ >챙기기<s></s></div>
						<div class="step step3"><a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar6');" class="more">웨딩카<br/ >꾸미기<s></s></a></div>
						<!-- 포토테이블장식 -->
						<div class="step step4 overHidden">
							<div class="thumb ftRt"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,10)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,10),arrList(1,10))%>" alt="<%=arrList(2,10)%>" style="width:345px; height:345px;" /></a></span></div>
							<div class="info ftLt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d15_step_2_x2.png" alt="포토테이블 장식 정성껏 준비한 웨딩포토가 공개될 공간, 포토테이블! 감각있게 꾸며볼까요?"usemap="#map-d15-2" style="width:240px; height:345px;" />
								<map name="map-d15-2" id="map-d15-2">
									<area alt="포토테이블" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%8F%AC%ED%86%A0%ED%85%8C%EC%9D%B4%EB%B8%94&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%8F%AC%ED%86%A0%ED%85%8C%EC%9D%B4%EB%B8%94" shape="rect" coords="27,206,118,236" onfocus="this.blur();"/>
									<area alt="액자" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%95%A1%EC%9E%90&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%95%A1%EC%9E%90" shape="rect" coords="123,205,175,235" onfocus="this.blur();"/>
									<area alt="화병" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%99%94%EB%B3%91&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%99%94%EB%B3%91" shape="rect" coords="27,239,80,269" onfocus="this.blur();"/>
									<area alt="촛대" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%B4%9B%EB%8C%80&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%B4%9B%EB%8C%80" shape="rect" coords="83,238,135,269" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar5');" class="more">more<i></i></a>
							</div>
						</div>
						<!--// 포토테이블장식 -->
						<!-- 신혼여행짐싸기 -->
						<div class="step step5 more-kit overHidden">
							<div class="thumb ftLt overHidden">
								<span class="ftLt"><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,11)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,11),arrList(1,11))%>" alt="<%=arrList(2,11)%>" style="width:323px; height:323px;" /></a></span>
								<span class="ftLt"><a href="/shopping/category_prd.asp?itemid=<%=arrList(3,11)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(3,11),arrList(4,11))%>" alt="<%=arrList(5,11)%>" style="width:323px; height:323px;" /></a></span>
							</div>
							<div class="info ftRt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d15_step_3_x2.png" alt="신혼여행 짐싸기 생각만 해도 설레는 신혼여행! 급하게 싸다보면 어찌나 필요한게 많은지, 미리 해야 후회 없이 준비할 수 있어요. 여권, 비자, 환전도 꼭 다시 한 번 확인할 것!" usemap="#map-d15-3" style="width:433px; height:341px;" />
								<map name="map-d15-3" id="map-d15-3">
									<area alt="캐리어" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BA%90%EB%A6%AC%EC%96%B4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BA%90%EB%A6%AC%EC%96%B4" shape="rect" coords="46,182,109,212" onfocus="this.blur();"/>
									<area alt="보조가방" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B3%B4%EC%A1%B0%EA%B0%80%EB%B0%A9&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B3%B4%EC%A1%B0%EA%B0%80%EB%B0%A9" shape="rect" coords="113,182,187,212" onfocus="this.blur();"/>
									<area alt="여행정리팩" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%97%AC%ED%96%89%EC%A0%95%EB%A6%AC%ED%8C%A9&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%97%AC%ED%96%89%EC%A0%95%EB%A6%AC%ED%8C%A9" shape="rect" coords="190,182,277,211" onfocus="this.blur();"/>
									<area alt="네임택" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%84%A4%EC%9E%84%ED%83%9D&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%84%A4%EC%9E%84%ED%83%9D" shape="rect" coords="280,182,343,212" onfocus="this.blur();"/>
									<area alt="여권커버" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%97%AC%EA%B6%8C%EC%BB%A4%EB%B2%84&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%97%AC%EA%B6%8C%EC%BB%A4%EB%B2%84" shape="rect" coords="347,182,412,212" onfocus="this.blur();"/>
									<area alt="카메라" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%B9%B4%EB%A9%94%EB%9D%BC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%B9%B4%EB%A9%94%EB%9D%BC" shape="rect" coords="46,216,109,246" onfocus="this.blur();"/>
									<area alt="삼각대" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%82%BC%EA%B0%81%EB%8C%80&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%82%BC%EA%B0%81%EB%8C%80" shape="rect" coords="112,216,175,246" onfocus="this.blur();"/>
									<area alt="방수백" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B0%A9%EC%88%98%EB%B0%B1&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B0%A9%EC%88%98%EB%B0%B1" shape="rect" coords="178,216,241,246" onfocus="this.blur();"/>
									<area alt="비키니" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B9%84%ED%82%A4%EB%8B%88&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B9%84%ED%82%A4%EB%8B%88" shape="rect" coords="244,216,307,246" onfocus="this.blur();"/>
									<area alt="커플잠옷" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BB%A4%ED%94%8C%EC%9E%A0%EC%98%B7&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BB%A4%ED%94%8C%EC%9E%A0%EC%98%B7" shape="rect" coords="310,216,385,246" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar1');" class="more">more<i></i></a>
							</div>
							<div class="kit">
								<a href="/shopping/category_prd.asp?itemid=1924512&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_honeymoon_kit_x2.png" alt="허니문 심플 키트 보기" style="width:1134px; height:51px;"></a>
							</div>
						</div>
						<!--// 신혼여행짐싸기 -->
					</div>
					<a href="javascript:fnEvtItemList(85159,240268,'tab4','');" class="more-all">D-15 쇼핑리스트 모두 보기</a>
				</div>
				<!--// D-15 -->

				<!-- D+10 -->
				<div class="section section5">
					<p class="d-day"><i></i>D+10<span>결혼식 이후 잊지 말아야 할 일!</span></p>
					<div class="inner">
						<!-- 감사인사 -->
						<div class="step step1 more-kit ftRt">
							<div class="thumb"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,12)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,12),arrList(1,12))%>" alt="<%=arrList(2,12)%>" style="width:432px; height:234px;" /></a></span></div>
							<div class="info">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d10_step_1_x2.png" alt="감사 인사 결혼을 축복 해주신 분들께 그저 그런 선물 대신, 기억에 남을 만한 선물을 하고 싶다면!?" usemap="#map-d10-1" style="width:432px; height:254px;" />
								<map name="map-d10-1" id="map-d10-1">
									<area alt="석고방향제" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%84%9D%EA%B3%A0%EB%B0%A9%ED%96%A5%EC%A0%9C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%84%9D%EA%B3%A0%EB%B0%A9%ED%96%A5%EC%A0%9C" shape="rect" coords="173,140,264,173" onfocus="this.blur();"/>
									<area alt="수제쿠키" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%88%98%EC%A0%9C%EC%BF%A0%ED%82%A4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%88%98%EC%A0%9C%EC%BF%A0%ED%82%A4" shape="rect" coords="263,140,341,173" onfocus="this.blur();"/>
									<area alt="견과류" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EA%B2%AC%EA%B3%BC%EB%A5%98&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EA%B2%AC%EA%B3%BC%EB%A5%98" shape="rect" coords="341,141,407,173" onfocus="this.blur();"/>
									<area alt="캔들" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BA%94%EB%93%A4&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BA%94%EB%93%A4" shape="rect" coords="173,173,227,207" onfocus="this.blur();"/>
									<area alt="타월" href="http://www.10x10.co.kr/search/search_result.asp?rect=%ED%83%80%EC%9B%94&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%ED%83%80%EC%9B%94" shape="rect" coords="227,173,281,206" onfocus="this.blur();"/>
								</map>
								<a href="javascript:fnEvtItemList(85159,240276,'tab5','groupBar1');" class="more">more<i></i></a>
							</div>
							<div class="kit"><a href="/shopping/category_prd.asp?itemid=1878643&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_cookie_kit_x2.png" alt="화과자 심플 키트 보기" style="width:468px; height:51px;"></a></div>
						</div>
						<!--// 감사인사 -->
						<!-- 집들이 -->
						<div class="step step2 more-kit overHidden">
							<div class="thumb ftRt"><span><a href="/shopping/category_prd.asp?itemid=<%=arrList(0,13)%>&pEtr=85159"><img src="<%=GetDDayImage(arrList(0,13),arrList(1,13))%>" alt="<%=arrList(2,13)%>" style="width:330px; height:396px;" /></a></span></div>
							<div class="info ftLt">
								<img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_d10_step_2_x2.png" alt="집들이 양가가족, 지인들을 초대해서 감사의 인사를 전해보세요. 오시는 분들의 취향에 맞춰 준비하면 더욱 좋겠죠?" usemap="#map-d10-2" style="width:280px; height:414px;" />
								<map name="map-d10-2" id="map-d10-2">
										<area alt="집들이음식" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%A7%91%EB%93%A4%EC%9D%B4%EC%9D%8C%EC%8B%9D&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%A7%91%EB%93%A4%EC%9D%B4%EC%9D%8C%EC%8B%9D" shape="rect" coords="25,212,120,244" onfocus="this.blur();"/>
										<area alt="나눔접시" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%82%98%EB%88%94%EC%A0%91%EC%8B%9C&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%82%98%EB%88%94%EC%A0%91%EC%8B%9C" shape="rect" coords="129,212,203,245" onfocus="this.blur();"/>
										<area alt="커트러리" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%BB%A4%ED%8A%B8%EB%9F%AC%EB%A6%AC&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%BB%A4%ED%8A%B8%EB%9F%AC%EB%A6%AC" shape="rect" coords="24,245,107,277" onfocus="this.blur();"/>
										<area alt="와인잔" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EC%99%80%EC%9D%B8%EC%9E%94&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EC%99%80%EC%9D%B8%EC%9E%94" shape="rect" coords="107,245,177,277" onfocus="this.blur();"/>
										<area alt="보드게임" href="http://www.10x10.co.kr/search/search_result.asp?rect=%EB%B3%B4%EB%93%9C%EA%B2%8C%EC%9E%84&cpg=1&extUrl=%2Fevent%2Feventmain.asp%3Feventid%3D85111&tvsTxt=&gaparam=main_menu_search&sTtxt=%EB%B3%B4%EB%93%9C%EA%B2%8C%EC%9E%84" shape="rect" coords="25,278,107,310" onfocus="this.blur();"/>
									</map>
								<a href="javascript:fnEvtItemList(85159,240276,'tab5','groupBar2');" class="more">more<i></i></a>
							</div>
							<div class="kit">
								<a href="/shopping/category_prd.asp?itemid=1927642&pEtr=85159"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_cutlery_kit_x2.png" alt="커트러리 심플 키트 보기" style="width:646px; height:51px;"></a>
							</div>
						</div>
						<!--// 집들이 -->
					</div>
				</div>
				<!--// D+10 -->
			</div>
<%
End If
On Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->