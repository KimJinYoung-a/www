<%
Dim oGrEvt, oGrEvtMore
	'// 이벤트 검색결과
	set oGrEvt = new SearchEventCls
	oGrEvt.FRectSearchTxt = DocSearchText
	oGrEvt.FRectExceptText = ExceptText
	oGrEvt.FRectChannel = "W"
	oGrEvt.FCurrPage = 1
	oGrEvt.FPageSize = 4
	oGrEvt.FScrollCount =10
	oGrEvt.getEventList

if oGrEvt.FResultCount=1 Then
	'// 이벤트 재 검색
	set oGrEvtMore = new SearchEventCls
	oGrEvtMore.FRectSearchTxt = replace(oGrEvt.FItemList(0).Fevt_tag,","," ")
	'oGrEvtMore.FRectSearchTxt = DocSearchText
	'oGrEvtMore.FRectExceptText = ExceptText
	oGrEvtMore.FRectChannel = "W"
	oGrEvtMore.FCurrPage = 1
	oGrEvtMore.FPageSize = 1
	oGrEvtMore.FScrollCount =10
	oGrEvtMore.FRectEvtCode=oGrEvt.FItemList(0).Fevt_code
	oGrEvtMore.getEventListMore
End If
%>
<% 	if oGrEvt.FResultCount>0 Then %>
<script>
var mySwiper;
$(function() {
	// event
	if ($('.schEventV17 .swiper-slide').length > 2) {
		mySwiper = new Swiper('.schEventV17 .swiper-container',{
			speed:800,
			slidesPerView:2,
			slidesPerGroup:2
		});
		$('.schEventV17 .btnPrev').on('click', function(e){
			e.preventDefault();
			mySwiper.swipePrev();
			if($("#page").val()>1){
				$("#page").val(Number($("#page").val())-1);
			}
		});
		$('.schEventV17 .btnNext').on('click', function(e){
			if (Number($("#tpage").val())>Number($("#page").val())){
				$("#page").val(Number($("#page").val())+1);
			}
			if($("#mpage").val()==$("#page").val() && Number($("#tpage").val())>Number($("#page").val())){
				jsGoEventPage($("#page").val(),e);
				$("#mpage").val(Number($("#mpage").val())+1);
			}
			e.preventDefault();
			mySwiper.swipeNext();
		});
		$('.schEventV17 .ctgySpcEvtV16 .spcEvtWrap button').show();
	}
});

function jsGoEventPage(pg,e) {
	$.ajax({
		url: "act_searchEvent_TT.asp?rect=<%=server.URLEncode(DocSearchText)%>&extxt=<%=server.URLEncode(ExceptText)%>&cpg="+pg+"",
		cache: false,
		async: false,
		success: function(message) {
			if(message!="") {
				var arrMessage= message.split("|");
				e.preventDefault();
				mySwiper.appendSlide(arrMessage[0]);
				e.preventDefault();
				mySwiper.appendSlide(arrMessage[1]);
			}
		}
	});
}
</script>
<input type="hidden" id="page" value="2">
<input type="hidden" id="mpage" value="3">
<input type="hidden" id="tpage" value="<%=int((oGrEvt.FTotalCount-1)/oGrEvt.FPageSize) +1%>">
			<!-- 이벤트 검색 결과 (17/06/21 수정) -->
			<div class="schEventV17">
				<div class="section ctgySpcEvtV16">
					<div class="spcEvtWrap">
						<div class="swiper-container">
							<div class="swiper-wrapper" id="lyrEvent">
							<%
								dim vEvtUrl, vEvtName, vEvtImg
								FOR lp = 0 to oGrEvt.FResultCount-1
									
									'이벤트 링크
									IF oGrEvt.FItemList(lp).Fevt_kind="16" Then		'#브랜드할인이벤트(16)
										vEvtUrl = "/street/street_brand.asp?makerid=" & oGrEvt.FItemList(lp).Fbrand
										vEvtName = chrbyte(split(oGrEvt.FItemList(lp).Fevt_name,"|")(0),20,"Y")
									Else
										vEvtName = stripHTML(db2html(oGrEvt.FItemList(lp).Fevt_name))
										if ubound(Split(vEvtName,"|"))> 0 Then
											If oGrEvt.FItemList(lp).Fissale Or (oGrEvt.FItemList(lp).Fissale And oGrEvt.FItemList(lp).Fiscoupon) then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),20,"Y") &" <span style=color:red>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											ElseIf oGrEvt.FItemList(lp).Fiscoupon Then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),20,"Y") &" <span style=color:green>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											End If 			
										end If
				
										IF oGrEvt.FItemList(lp).Fevt_LinkType="I" and oGrEvt.FItemList(lp).Fevt_bannerLink<>"" THEN		'#별도 링크타입
											vEvtUrl = oGrEvt.FItemList(lp).Fevt_bannerLink
										Else
											vEvtUrl = "/event/eventmain.asp?eventid=" & oGrEvt.FItemList(lp).Fevt_code
										End If
									End If

									'이벤트 이미지(200x200px)
									If oGrEvt.FItemList(lp).Fevt_mo_listbanner = "" Then
										If oGrEvt.FItemList(lp).Ficon1image <> "" Then
											vEvtImg = "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(oGrEvt.FItemList(lp).Fetc_itemid) & "/" & oGrEvt.FItemList(lp).Ficon1image
										else
											vEvtImg = ""
										End IF
									Else
										'// 포토서버 사용
										vEvtImg = oGrEvt.FItemList(lp).Fevt_mo_listbanner
										vEvtImg = chkIIF(application("Svr_Info")<>"Dev",getThumbImgFromURL(vEvtImg,430,230,"true","false"),vEvtImg)
									End If
							%>
								<div class="swiper-slide">
									<a href="<%=vEvtUrl%>">
										<p><img src="<%=vEvtImg%>" alt="<%=vEvtName%>"></p>
										<p class="evtTitV15"><strong><%=vEvtName%></strong></p>
										<p><%=oGrEvt.FItemList(lp).Fevt_subcopyK%></p>
									</a>
								</div>
							<% Next %>
							<%
							if oGrEvt.FResultCount=1 Then
							%>
								<div class="swiper-slide">
									<a href="/search/search_result.asp?rect=텐바이텐배송&gaparam=main_menu_tenbae"><p><img src="http://imgstatic.10x10.co.kr/offshop/temp/2017/201708/MOBILE_LIST_bn.jpg" alt=""></p></a>
								</div>
							<%
							End If
							%>
							</div>
						</div>
						<button type="button" class="btnPrev">이전</button>
						<button type="button" class="btnNext">다음</button>
					</div>
				</div>
			</div>
			<!--// 이벤트 검색 결과 -->
<% End If %>
<%
Set oGrEvt = Nothing
Set oGrEvtMore = Nothing
%>