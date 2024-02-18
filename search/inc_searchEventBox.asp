<%
Dim oGrEvt, oGrEvtMore, extEvtCd
	'// 이벤트 검색결과
	set oGrEvt = new SearchEventCls
	oGrEvt.FRectSearchTxt = DocSearchText
	oGrEvt.FRectExceptText = ExceptText
	oGrEvt.FRectChannel = "W"
	oGrEvt.FCurrPage = 1
	oGrEvt.FPageSize = 3
	oGrEvt.FScrollCount =10
	oGrEvt.getEventList

''검색시 오류가 있음. 제외 
if (FALSE) and oGrEvt.FResultCount > 0 And oGrEvt.FResultCount < 3 Then
	'// 이벤트 재 검색
	for i=0 to oGrEvt.FResultCount-1
		extEvtCd = oGrEvt.FItemList(i).Fevt_code & chkIIF(i<oGrEvt.FResultCount-1,",","")
	next

	set oGrEvtMore = new SearchEventCls
	oGrEvtMore.FRectSearchTxt = replace(oGrEvt.FItemList(0).Fevt_tag,","," ")
	'oGrEvtMore.FRectSearchTxt = DocSearchText
	'oGrEvtMore.FRectExceptText = ExceptText
	oGrEvtMore.FRectChannel = "W"
	oGrEvtMore.FCurrPage = 1
	oGrEvtMore.FPageSize = 3 - oGrEvt.FResultCount
	oGrEvtMore.FScrollCount =10
	oGrEvtMore.FRectEvtCode=extEvtCd
	oGrEvtMore.getEventListMore
End If

%>
<% 	if oGrEvt.FResultCount>0 Then %>
<script>
var mySwiper;
$(function() {
	// event
		mySwiper = new Swiper('.schEventV17 .swiper-container',{
			speed:800,
			slidesPerView:3,
			slidesPerGroup:3,
			onSlideChangeStart : function(swiper){
				var pgcnt = swiper.activeIndex;
				pgcnt = parseInt(pgcnt/3);
				if ($("#page").val() > pgcnt )
				{
					$("#pgcnt").text($("#page").val());
				}else{
					$("#pgcnt").text(pgcnt+1);
				}
			}
		});
		$('.schEventV17 .btnPrev').on('click', function(e){
			e.preventDefault();
			mySwiper.swipePrev();
			if($("#page").val()>1){
				$("#page").val(Number($("#page").val())-1);
				$("#pgcnt").text($("#page").val());
			}
		});
	<% if oGrEvt.FTotalCount > 3 then %>
		$('.schEventV17 .btnNext').on('click', function(e){
			if (Number($("#tpage").val())>Number($("#page").val())){
				$("#page").val(Number($("#page").val())+1);
			}
			if($("#mpage").val()==$("#page").val()){
				jsGoEventPage($("#page").val(),e);
				$("#mpage").val(Number($("#mpage").val())+1);
			}
			e.preventDefault();
			mySwiper.swipeNext();
		});
		$('.schEventV17 .ctgySpcEvtV16 .spcEvtWrap button').show();
	<% end if %>
});

function jsGoEventPage(pg,e) {
	$.ajax({
		url: "act_searchEvent.asp?rect=<%=server.URLEncode(DocSearchText)%>&extxt=<%=server.URLEncode(ExceptText)%>&cpg="+pg+"",
		cache: false,
		async: false,
		success: function(message) {
			if(message!="") {
				var arrMessage= message.split("|");
				e.preventDefault();
				mySwiper.appendSlide(arrMessage[0]);
				e.preventDefault();
				mySwiper.appendSlide(arrMessage[1]);
				e.preventDefault();
				mySwiper.appendSlide(arrMessage[2]);
			}
		}
	});
}
</script>
<input type="hidden" id="page" value="1">
<input type="hidden" id="mpage" value="2">
<input type="hidden" id="tpage" value="<%=int((oGrEvt.FTotalCount-1)/oGrEvt.FPageSize)+1%>">
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
										vEvtName = chrbyte(split(oGrEvt.FItemList(lp).Fevt_name,"|")(0),30,"Y")
									Else
										vEvtName = stripHTML(db2html(oGrEvt.FItemList(lp).Fevt_name))
										if ubound(Split(vEvtName,"|"))> 0 Then
											If oGrEvt.FItemList(lp).Fissale Or (oGrEvt.FItemList(lp).Fissale And oGrEvt.FItemList(lp).Fiscoupon) then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),30,"Y") &" <span style=color:red>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											ElseIf oGrEvt.FItemList(lp).Fiscoupon Then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),30,"Y") &" <span style=color:green>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											Else
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),40,"Y")
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
										vEvtImg = chkIIF(application("Svr_Info")<>"Dev",getThumbImgFromURL(vEvtImg,430,290,"true","false"),vEvtImg)
									End If
							%>
								<div class="swiper-slide">
									<a href="<%=vEvtUrl%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_serach_result_event','item_index|keyword|eventcode','<%=lp+1%>|<%=vAmplitudeSearchText%>|<%=oGrEvt.FItemList(lp).Fevt_code%>')">
										<p><img src="<%=vEvtImg%>" alt=""></p>
										<p class="evtTitV15"><strong><%=vEvtName%></strong></p>
										<p style="display:none"><%=oGrEvt.FItemList(lp).Fevt_subcopyK%></p>
									</a>
								</div>
							<% Next %>
							<%
							if (FALSE) and oGrEvt.FResultCount > 0 And oGrEvt.FResultCount < 3 Then
								FOR lp = 0 to oGrEvtMore.FResultCount-1

									'이벤트 링크
									IF oGrEvtMore.FItemList(lp).Fevt_kind="16" Then		'#브랜드할인이벤트(16)
										vEvtUrl = "/street/street_brand.asp?makerid=" & oGrEvtMore.FItemList(lp).Fbrand
										vEvtName = chrbyte(split(oGrEvtMore.FItemList(lp).Fevt_name,"|")(0),30,"Y")
									Else
										vEvtName = stripHTML(db2html(oGrEvtMore.FItemList(lp).Fevt_name))
										if ubound(Split(vEvtName,"|"))> 0 Then
											If oGrEvtMore.FItemList(lp).Fissale Or (oGrEvtMore.FItemList(lp).Fissale And oGrEvtMore.FItemList(lp).Fiscoupon) then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),30,"Y") &" <span style=color:red>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											ElseIf oGrEvtMore.FItemList(lp).Fiscoupon Then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),30,"Y") &" <span style=color:green>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											End If
										end If

										IF oGrEvtMore.FItemList(lp).Fevt_LinkType="I" and oGrEvtMore.FItemList(lp).Fevt_bannerLink<>"" THEN		'#별도 링크타입
											vEvtUrl = oGrEvtMore.FItemList(lp).Fevt_bannerLink
										Else
											vEvtUrl = "/event/eventmain.asp?eventid=" & oGrEvtMore.FItemList(lp).Fevt_code
										End If
									End If

									'이벤트 이미지(200x200px)
									If oGrEvtMore.FItemList(lp).Fevt_mo_listbanner = "" Then
										If oGrEvtMore.FItemList(lp).Ficon1image <> "" Then
											vEvtImg = "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(oGrEvtMore.FItemList(lp).Fetc_itemid) & "/" & oGrEvtMore.FItemList(lp).Ficon1image
										else
											vEvtImg = ""
										End IF
									Else
										'// 포토서버 사용
										vEvtImg = oGrEvtMore.FItemList(lp).Fevt_mo_listbanner
										vEvtImg = chkIIF(application("Svr_Info")<>"Dev",getThumbImgFromURL(vEvtImg,430,290,"true","false"),vEvtImg)
									End If
							%>
								<div class="swiper-slide">
									<a href="<%=vEvtUrl%>" onclick=fnAmplitudeEventMultiPropertiesAction('click_serach_result_event','item_index|keyword|eventcode','<%=lp+1%>|<%=vAmplitudeSearchText%>|<%=oGrEvt.FItemList(lp).Fevt_code%>')>
										<p><img src="<%=vEvtImg%>" alt=""></p>
										<p class="evtTitV15"><strong><%=vEvtName%></strong></p>
										<p style="display:none"><%=oGrEvtMore.FItemList(lp).Fevt_subcopyK%></p>
									</a>
								</div>
							<%
								Next
							End If
							%>
							</div>
						</div>
						<div class="search-paging"><span id="pgcnt">1</span>/<span><% If oGrEvt.FTotalCount Mod oGrEvt.FPageSize = 0 Then %><%=CInt((oGrEvt.FTotalCount-1)/oGrEvt.FPageSize)%><% Else %><%=CInt((oGrEvt.FTotalCount-1)/oGrEvt.FPageSize)+1%><% End If %></span></div>
						<button type="button" class="btnPrev">이전</button>
						<button type="button" class="btnNext">다음</button>
					</div>
				</div>
			</div>
			<!--// 이벤트 검색 결과 -->
<% End If %>
<%
Set oGrEvt = Nothing
''Set oGrEvtMore = Nothing
%>