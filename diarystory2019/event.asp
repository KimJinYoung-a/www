<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2019 EVENT
' History : 2018.08.27 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2019/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim odibest, i, selOp , scType, CurrPage, PageSize
	selOp		=  requestCheckVar(Request("selOP"),1) '정렬
	scType 		= requestCheckVar(Request("scT"),4) '쇼핑찬스 분류
	CurrPage 	= requestCheckVar(request("cpg"),9)
	
	IF CurrPage = "" then CurrPage = 1
	If scType ="end" then
		selOp = "1"
	ElseIf selOp = "" Then
		selOp = "0"
	End if
	PageSize = 10

	set odibest = new cdiary_list
		odibest.FPageSize = PageSize
		odibest.FCurrPage = CurrPage
		odibest.FselOp	 	= selOp	'이벤트정렬
		odibest.FSCType 	= scType    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
		odibest.FEScope =2
		odibest.FEvttype = "1,13"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent

	function ampliname(v)
		select case (v)
			case "sale" 
				ampliname = "sale"
			case "gift" 
				ampliname = "gift"
			case "ips" 
				ampliname = "participation"
			case else
				ampliname = "all"
		end select 
	end function
%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
function jsGoUrl(scT){
	document.sFrm.cpg.value = 1;
	document.sFrm.scT.value = scT;
	document.sFrm.submit();
}

function jsGoPage(iP){
	fnAmplitudeEventMultiPropertiesAction('click_diary_events_menu','gubun|page_num','<%=ampliname(scType)%>|'+ iP +'');
	document.sFrm.cpg.value = iP;
	document.sFrm.submit();
}

$(function(){
	// amplitude init
	fnAmplitudeEventAction("view_diaryevent","","");
});

// 사은품 소개 레이어 팝업
$(function() {
	$('.diary2019-list .rolling').slidesjs({
		height:85,
		navigation:{active:false},
		pagination:{active:false},
		play:{active:false, interval:1400, effect:"fade", auto:1400},
		effect:{fade:{speed:1000, crossfade:true}}
    });
    
    // gift layer
    function diaryGiftSlide(){
        $('.gift-layer .slide').slidesjs({
            width:"670",
            height:"470",
            pagination:false,
            navigation:false,
            play:{interval:1000, effect:"fade", auto:true},
            effect:{fade: {speed:1000, crossfade:true}
            },
            callback: {
                complete: function(number) {
                    var pluginInstance = $('.gift-layer .slide').data('plugin_slidesjs');
                    setTimeout(function() {
                        pluginInstance.play(true);
                    }, pluginInstance.options.play.interval);
                }
            }
        });
    }

    $('.main-evt a').click(function(){
        diaryGiftSlide();
        $('.scrollbarwrap').tinyscrollbar();
    });
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2019">
		<div id="contentWrap" class="diary-evt">
			<!-- #include virtual="/diarystory2019/inc/head.asp" -->
			<div class="diary-content">
				<%' if date() > "2018-12-11" then %>
				<!--<div class="main-evt">
					<p><img src="http://fiximage.10x10.co.kr/web2018/diary2019/txt_event_top.png" alt="텐바이텐 X 일러스트레이터 이공 스탠다드러브댄스 키링 증정 오직 텐바이텐 다이어리 스토리에서만 만나볼 수 있는 한정 키링을 선물합니다!"></p>
					<a href="" onclick="viewPoupLayer('modal',$('#lyrGift').html());return false;"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_gift_detail.jpg" alt="자세히보러가기"></a>
				</div>-->
				<%' else %>
				<!--<div class="main-evt" style="background:#fedb35 url(http://fiximage.10x10.co.kr/web2018/diary2019/bg_event_top_snoopy.jpg) no-repeat 50% 0;">
					<a href="" onclick="viewPoupLayer('modal',$('#lyrGift').html());return false;" style="top:370px; margin-left:-572px"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_gift_detail_snoopy.jpg" alt="자세히보러가기"></a>
				</div>-->
				<%' end if %>
				<div class="inner">
					<div class="diary-list <%=chkiif(odibest.FResultCount > 0,"","no-data")%>">
						<ul class="tabV18">
							<li <%=CHKIIF(scType="","class='current'","")%>><a href="#all-evt" onclick="jsGoUrl('');fnAmplitudeEventAction('click_diary_events_menu','gubun','all'); return false;">전체 이벤트</a></li>
							<li <%=CHKIIF(scType="sale","class='current'","")%>><a href="#sale-evt" onclick="jsGoUrl('sale');fnAmplitudeEventAction('click_diary_events_menu','gubun','sale'); return false;">할인 이벤트</a></li>
							<li <%=CHKIIF(scType="gift","class='current'","")%>><a href="#gift-evt" onclick="jsGoUrl('gift');fnAmplitudeEventAction('click_diary_events_menu','gubun','gift'); return false;">사은 이벤트</a></li>
							<li <%=CHKIIF(scType="ips","class='current'","")%>><a href="#partici-evt" onclick="jsGoUrl('ips');fnAmplitudeEventAction('click_diary_events_menu','gubun','participation'); return false;">참여 이벤트</a></li>
						</ul>
						<div class="tab-container" id="diary2019evtlist">
							<% If odibest.FResultCount > 0 Then %>
							<div class="tab-cont items type-list">
								<ul>
									<%
									Dim vLink, vImg, vIcon, vName, vmbannerImg , vEventid
									
										FOR i = 0 to odibest.FResultCount -1

											IF odibest.FItemList(i).FEvt_kind = "16" Then
												IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
													vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
												ELSE
													vLink = "GoToBrandShopevent_direct('" & odibest.FItemList(i).fbrand & "','" & odibest.FItemList(i).fevt_code & "');"
												END IF
												vName = split(odibest.FItemList(i).FEvt_name,"|")(0)
											Elseif odibest.FItemList(i).FEvt_kind = "13" Then
												vLink = "TnGotoProduct('" & odibest.FItemList(i).fetc_itemid & "');"
												vName = odibest.FItemList(i).FEvt_name
											Else
												IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
													vLink = "location.href='" & odibest.FItemList(i).feventitemid & "';"
												ELSE
													vLink = "TnGotoEventMain('" & odibest.FItemList(i).fevt_code & "');"
												END IF
												vName = odibest.FItemList(i).FEvt_name
											End IF

											IF odibest.FItemList(i).Fevt_LinkType = "I" and odibest.FItemList(i).feventitemid <> "" THEN '링크타입 체크
												vEventid = odibest.FItemList(i).feventitemid
											ELSE
												vEventid = odibest.FItemList(i).fevt_code
											END IF
											
											' if odibest.FItemList(i).fevt_mo_listbanner <> "" then
											' 	vmbannerImg = odibest.FItemList(i).fevt_mo_listbanner
											' else
												If odibest.FItemList(i).Fetc_itemimg <> "" Then
													vmbannerImg = odibest.FItemList(i).Fetc_itemimg
												Else
													vmbannerImg = odibest.FItemList(i).FImageList
												End IF
											' end if
									%>
									<li>
										<a href="" onclick="<%=vLink%>fnAmplitudeEventMultiPropertiesAction('click_diary_events_menu','gubun|eventid','<%=ampliname(scType)%>|<%=vEventid%>');return false;">
											<span class="thumbnail"><img src="<%=vmbannerImg%>" alt="<%= vName %>"><% If odibest.FItemList(i).fisgift Then %><em class="gift">GIFT</em><% end if %></span>
											<span class="desc">
												<span class="name">
												<%
													If odibest.FItemList(i).fissale Or odibest.FItemList(i).fiscoupon Then
														if ubound(Split(vName,"|"))> 0 Then
															If odibest.FItemList(i).fissale Or (odibest.FItemList(i).fissale And odibest.FItemList(i).fiscoupon) then
																vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <span class='discount color-red'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
															ElseIf odibest.FItemList(i).fiscoupon Then
																vName	= cStr(Split(odibest.FItemList(i).FEvt_name,"|")(0)) &" <span class='discount color-green'>"&cStr(Split(odibest.FItemList(i).FEvt_name,"|")(1))&"</span>"
															End If 			
														end If
													End If 
												%>
												<%=chrbyte(vName,80,"Y")%>
												</span>
												<span class="sub"><%=chrbyte( odibest.FItemList(i).FEvt_subcopyK ,70,"Y")%></span>
												<span class="date"><%=formatdate(odibest.FItemList(i).fevt_enddate,"0000.00.00") %>까지</span>
											</span>
										</a>
									</li>
									<%
										Next									
									%>
								</ul>
								<button class="btn-more"></button>
							</div>
							<% else %>
							<div class="no-diary">
								<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/txt_no_event.png" alt="진행중인 이벤트가 없습니다" /></div>
								<a href=""><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_all.png" alt="전체보기" /></a>
							</div>
							<% end if %>
						</div>
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(CurrPage,odibest.FTotalCount,PageSize,10,"jsGoPage") %>
						</div>
					</div>
				</div>
				<%'!-- 관련기획전 --%>
				<!-- #include virtual="/diarystory2019/inc/inc_etcevent.asp" -->
				<%'!--// 관련기획전 --%>

				<!-- 사은품 소개 레이어 팝업 -->
				<div id="lyrGift" style="display:none;">
					<div class="gift-layer">
						<% if date() > "2018-12-11" then  %>
						<div class="slide">
							<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_1.jpg" alt="" /></div>
							<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_2.jpg" alt="" /></div>
							<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_3.jpg" alt="" /></div>
						</div>
						<h3><img src="http://fiximage.10x10.co.kr/web2018/diary2019/tit_gift.png" alt="텐바이텐 일러스트레이터 이공 콜라보 스탠다드러브 댄스" /></h3>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<p><img src="http://fiximage.10x10.co.kr/web2018/diary2019/txt_about_gift_v2.png?v=1.01" alt="" /></p>
									<ul class="noti">
										<li>- 기간 : 2018년 9월 17일 ~ 12월 31일 (한정수량으로 조기 품절 될 수 있습니다)</li>
										<li>- 사은품은 쿠폰 등과 같은 할인 수단 사용 후, 구매확정 금액을 기준으로 증정됩니다.</li>
										<li>- 다이어리 구매 개수에 관계없이 총 구매금액 조건 충족 시 사은품이 증정됩니다.</li>
										<li>- 환불 및 교환으로 인해 증정 기준 금액이 미달될 경우, 사은품을 반품해 주셔야 합니다.</li>
										<li>- 사은품 불량으로 인한 교환은 불가능합니다.</li>
										<li>- 비회원 구매 시 사은품 증정에서 제외됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_close.png" alt="닫기" /></button>
						<% else %>
						<div class="slide" style="height:380px; background:url(http://fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_1.jpg);">
							<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_1.jpg" alt="" /></div>
							<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_2.jpg" alt="" /></div>
							<div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_pop_snoopy_3.jpg" alt="" /></div>
						</div>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<p><img src="http://fiximage.10x10.co.kr/web2018/diary2019/txt_pop_snoopy_v2.png" alt="" /></p>
									<ul class="noti" style="margin-top:0; padding-top:43px; border-top:solid 1px #e3e3e3;">
										<li>- 기간 : 2018년 11월 25일 ~ 12월 31일 (한정수량으로 조기 품절 될 수 있습니다)</li>
										<li>- 사은품은 쿠폰 등과 같은 할인 수단 사용 후, 구매확정 금액을 기준으로 증정됩니다.</li>
										<li>- 다이어리 구매 개수에 관계없이 총 구매금액 조건 충족 시 사은품이 증정됩니다.</li>
										<li>- 환불 및 교환으로 인해 증정 기준 금액이 미달될 경우, 사은품을 반품해 주셔야 합니다.</li>
										<li>- 사은품 불량으로 인한 교환은 불가능합니다.</li>
										<li>- 비회원 구매 시 사은품 증정에서 제외됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_close.png" alt="닫기" /></button>
						<% end if %>
					</div>
				</div>
				<!--// 사은품 소개 레이어 팝업 -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="sFrm" method="get" action="/diarystory2019/event.asp#diary2019evtlist">
<input type="hidden" name="cpg" value="<%= odibest.FCurrPage %>"/>
<input type="hidden" name="scT" value="<%= scType %>"/>
</form>
</body>
</html>
<% set odibest = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->