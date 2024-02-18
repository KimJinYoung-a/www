<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 다꾸랭킹페이지
' History : 2018-11-20 원승현 생성
'           2019-08-22 이종화 UI 스킨 변경 - 카테고리 코드 변경
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/diarystory2020/daccu_ranking.asp"
			REsponse.End
		end if
	end if
end if

Dim vDate, vRankingCount, vCateType, sqlStr, rns, rne, i

vDate = RequestCheckVar(request("date"),10)

If Trim(vDate) = "" Then
    sqlStr = "SELECT MAX(rankdate) as maxRankDate " +vbcrlf
    sqlStr = sqlStr & " FROM db_temp.dbo.tbl_DiaryDecoItemRanking " +vbcrlf
    'response.write sqlStr
    rsget.CursorLocation = adUseClient
    rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
    If Not rsget.EOF Then
        If left(Trim(rsget("maxRankDate")),10) <> Trim(vDate) Then
            vDate = left(Trim(rsget("maxRankDate")),10)
        End If
    End if
    rsget.close
End If

Dim oDaccuRankingPen, oDaccuRankingMemo, oDaccuRankingSticker, oDaccuRankingTape, oDaccuRankingStamp
set oDaccuRankingPen = new cdiary_list
oDaccuRankingPen.frecttoplimit = 70
oDaccuRankingPen.frectcate = "PEN"
oDaccuRankingPen.FRectRankingDate = vDate
oDaccuRankingPen.GetDiaryDaccuItemRanking

set oDaccuRankingMemo = new cdiary_list
oDaccuRankingMemo.frecttoplimit = 70
oDaccuRankingMemo.frectcate = "MEMO"
oDaccuRankingMemo.FRectRankingDate = vDate
oDaccuRankingMemo.GetDiaryDaccuItemRanking

set oDaccuRankingSticker = new cdiary_list
oDaccuRankingSticker.frecttoplimit = 70
oDaccuRankingSticker.frectcate = "STICKER"
oDaccuRankingSticker.FRectRankingDate = vDate
oDaccuRankingSticker.GetDiaryDaccuItemRanking

set oDaccuRankingTape = new cdiary_list
oDaccuRankingTape.frecttoplimit = 70
oDaccuRankingTape.frectcate = "TAPE"
oDaccuRankingTape.FRectRankingDate = vDate
oDaccuRankingTape.GetDiaryDaccuItemRanking

set oDaccuRankingStamp = new cdiary_list
oDaccuRankingStamp.frecttoplimit = 70
oDaccuRankingStamp.frectcate = "STAMP"
oDaccuRankingStamp.FRectRankingDate = vDate
oDaccuRankingStamp.GetDiaryDaccuItemRanking

rns = 1
rne = 50
%>
<script type="text/javascript">
$(function(){
	// amplitude init
	fnAmplitudeEventMultiPropertiesAction('view_diary_daccu_ranking','','');

	// dropdown box
	$(".date dt").click(function(){
		if($(".date dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", {direction:"up"}, 300);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", {direction:"up"}, 200);
			$(this).removeClass("over");

		};
	});
	$(".date dd li").click(function(){
		var evtName = $(this).text();
		$(this).parent().parent().parent().children('dt').children('span').empty().append(evtName);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
		$(".date dt").removeClass("over");
	});    
});

function fnDiaryDaccuShopping(itemid, price, offsetTop, offsetLeft) {
    var frm = document.sbagfrm;
    frm.itemid.value = itemid;
    frm.itemid.itemPrice = price;
    var sAddBagArr = "";
    var vTrData;

    vTrData = "mode=add";
    vTrData += "&itemid=" + frm.itemid.value;
    vTrData += "&sitename=" + frm.sitename.value;
    vTrData += "&itemoption=" + frm.itemoption.value;
    vTrData += "&itemPrice=" + frm.itemPrice.value;
    vTrData += "&isPhotobook=" + frm.isPhotobook.value;
    vTrData += "&isPresentItem=" + frm.isPresentItem.value;
    vTrData += "&itemea=" + frm.itemea.value;
    $.ajax({
        type: "POST",
        url: "/inipay/shoppingbag_process.asp?tp=ajax",
        data:vTrData,
        success: function(message) {
            switch(message.split("||")[0]) {
                case "0":
                    alert("유효하지 않은 상품이거나 품절된 상품입니다.");
                    break;
                case "1":
                    fnDelCartAll();
                    $(".alertLyrV15").css({
                        "posion" : "absolute",
                        "top" : offsetTop-310,
                        "left" : offsetLeft+6
                    });
                    $("#alertMsgV15").html("선택하신 상품을<br />장바구니에 담았습니다.");
                    $(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
                    $("#ibgaCNT").html(message.split("||")[1]);
                    break;
                case "2":
                    $(".alertLyrV15").css({
                        "posion" : "absolute",
                        "top" : offsetTop-310,
                        "left" : offsetLeft+6
                    });
                    $("#alertMsgV15").html("장바구니에 이미<br />같은 상품이 있습니다.");
                    $(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
                    break;
                default:
                    alert("죄송합니다. 오류가 발생했습니다.");
                    break;
            }
        }
    });    
}

function fnDiaryDaccuLayerClose() {
    $('.alertLyrV15').hide();
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2020">
		<div id="contentWrap" class="diary-sub">
			<!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<div class="diary-content">
                <div class="sub-header">
                    <div class="inner">
                        <h3>다꾸러들이 애용하는 베스트 데코템 랭킹 50</span></h3>
                    </div>
                </div>
                <div class="ranking-wrap">
                    <div class="inner">
                        <dl class="rannking-num">
                            <dt></dt>
                            <% for rns = 1 to rne %>
                            <dd>
                                <div class="badge badge-count1 <%=chkiif(rns < 4, "num-rolling", "")%>">
                                    <em><%=rns%></em>
                                </div>
                            </dd>
                            <% next %>
                        </dl>
                        <%' 펜/색연필 %>
                        <dl>
                            <dt>펜 / 색연필</dt>
                            <% If oDaccuRankingPen.FResultCount > 0 Then %>
                                <%	For i=0 to oDaccuRankingPen.FResultCount-1 %>
                                    <%
                                        If i > 49 Then
                                            exit for
                                        End If
                                    %>
                                        <dd class="item">
                                            <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingPen.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_ranking_items','gubun|itemid','PEN|<%=oDaccuRankingPen.FItemList(i).FItemId%>');">
                                                <div class="thumbnail">
                                                    <img src="<%= getThumbImgFromURL(oDaccuRankingPen.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingPen.FItemList(i).FItemName%>" />
                                                    <% IF oDaccuRankingPen.FItemList(i).isSoldOut THEN %><span class="soldout"><span class="ico-soldout">일시품절</span></span><% END IF %>
                                                </div>
                                                <div class="desc">
                                                    <p class="name ellipsis"><%=oDaccuRankingPen.FItemList(i).FItemName%></p>
                                                    <div class="brand"><%=oDaccuRankingPen.FItemList(i).FBrandName%></div>
                                                </div>
                                            </a>
                                            <% if oDaccuRankingPen.FItemList(i).FOptionCount > 0 Then %>
                                                <a href="" onclick="ZoomItemInfo('<%=oDaccuRankingPen.FItemList(i).FItemId%>'); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% Else %>
                                                <a href="" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingPen.FItemList(i).FItemId%>','<%= oDaccuRankingPen.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% End If %>  
                                        </dd>
                                <% Next %>
                            <% End If %>
                        </dl>
                        <%' 떡메모지 %>
                        <dl>
                            <dt>떡메모지</dt>
                            <% If oDaccuRankingMemo.FResultCount > 0 Then %>
                                <%	For i=0 to oDaccuRankingMemo.FResultCount-1 %>
                                    <%
                                        If i > 49 Then
                                            exit for
                                        End If
                                    %>
                                        <dd class="item">
                                            <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingMemo.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_ranking_items','gubun|itemid','MEMO|<%=oDaccuRankingMemo.FItemList(i).FItemId%>');">
                                                <div class="thumbnail">
                                                    <img src="<%= getThumbImgFromURL(oDaccuRankingMemo.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingMemo.FItemList(i).FItemName%>" />
                                                    <% IF oDaccuRankingMemo.FItemList(i).isSoldOut THEN %><span class="soldout"><span class="ico-soldout">일시품절</span></span><% END IF %>
                                                </div>
                                                <div class="desc">
                                                    <p class="name ellipsis"><%=oDaccuRankingMemo.FItemList(i).FItemName%></p>
                                                    <div class="brand"><%=oDaccuRankingMemo.FItemList(i).FBrandName%></div>
                                                </div>
                                            </a>
                                            <% if oDaccuRankingMemo.FItemList(i).FOptionCount > 0 Then %>
                                                <a href="" onclick="ZoomItemInfo('<%=oDaccuRankingMemo.FItemList(i).FItemId%>'); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% Else %>
                                                <a href="" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingMemo.FItemList(i).FItemId%>','<%= oDaccuRankingMemo.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% End If %>  
                                        </dd>
                                <% Next %>
                            <% End If %>
                        </dl>
                        <%' 스티커 %>
                        <dl>
                            <dt>스티커</dt>
                            <% If oDaccuRankingSticker.FResultCount > 0 Then %>
                                <%	For i=0 to oDaccuRankingSticker.FResultCount-1 %>
                                    <%
                                        If i > 49 Then
                                            exit for
                                        End If
                                    %>
                                        <dd class="item">
                                            <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingSticker.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_ranking_items','gubun|itemid','STICKER|<%=oDaccuRankingSticker.FItemList(i).FItemId%>');">
                                                <div class="thumbnail">
                                                    <img src="<%= getThumbImgFromURL(oDaccuRankingSticker.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingSticker.FItemList(i).FItemName%>" />
                                                    <% IF oDaccuRankingSticker.FItemList(i).isSoldOut THEN %><span class="soldout"><span class="ico-soldout">일시품절</span></span><% END IF %>
                                                </div>
                                                <div class="desc">
                                                    <p class="name ellipsis"><%=oDaccuRankingSticker.FItemList(i).FItemName%></p>
                                                    <div class="brand"><%=oDaccuRankingSticker.FItemList(i).FBrandName%></div>
                                                </div>
                                            </a>
                                            <% if oDaccuRankingSticker.FItemList(i).FOptionCount > 0 Then %>
                                                <a href="" onclick="ZoomItemInfo('<%=oDaccuRankingSticker.FItemList(i).FItemId%>'); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% Else %>
                                                <a href="" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingSticker.FItemList(i).FItemId%>','<%= oDaccuRankingSticker.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% End If %>  
                                        </dd>
                                <% Next %>
                            <% End If %>
                        </dl>
                        <%' 테이프 %>
                        <dl>
                            <dt>테이프</dt>
                            <% If oDaccuRankingTape.FResultCount > 0 Then %>
                                <%	For i=0 to oDaccuRankingTape.FResultCount-1 %>
                                    <%
                                        If i > 49 Then
                                            exit for
                                        End If
                                    %>
                                        <dd class="item">
                                            <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingTape.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_ranking_items','gubun|itemid','TAPE|<%=oDaccuRankingTape.FItemList(i).FItemId%>');">
                                                <div class="thumbnail">
                                                    <img src="<%= getThumbImgFromURL(oDaccuRankingTape.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingTape.FItemList(i).FItemName%>" />
                                                    <% IF oDaccuRankingTape.FItemList(i).isSoldOut THEN %><span class="soldout"><span class="ico-soldout">일시품절</span></span><% END IF %>
                                                </div>
                                                <div class="desc">
                                                    <p class="name ellipsis"><%=oDaccuRankingTape.FItemList(i).FItemName%></p>
                                                    <div class="brand"><%=oDaccuRankingTape.FItemList(i).FBrandName%></div>
                                                </div>
                                            </a>
                                            <% if oDaccuRankingTape.FItemList(i).FOptionCount > 0 Then %>
                                                <a href="" onclick="ZoomItemInfo('<%=oDaccuRankingTape.FItemList(i).FItemId%>'); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% Else %>
                                                <a href="" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingTape.FItemList(i).FItemId%>','<%= oDaccuRankingTape.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% End If %>  
                                        </dd>
                                <% Next %>
                            <% End If %>
                        </dl>
                        <%' 스탬프 %>
                        <dl>
                            <dt>스탬프</dt>
                            <% If oDaccuRankingStamp.FResultCount > 0 Then %>
                                <%	For i=0 to oDaccuRankingStamp.FResultCount-1 %>
                                    <%
                                        If i > 49 Then
                                            exit for
                                        End If
                                    %>
                                        <dd class="item">
                                            <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingStamp.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_diary_daccu_ranking_items','gubun|itemid','STAMP|<%=oDaccuRankingStamp.FItemList(i).FItemId%>');">
                                                <div class="thumbnail">
                                                    <img src="<%= getThumbImgFromURL(oDaccuRankingStamp.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingStamp.FItemList(i).FItemName%>" />
                                                    <% IF oDaccuRankingStamp.FItemList(i).isSoldOut THEN %><span class="soldout"><span class="ico-soldout">일시품절</span></span><% END IF %>
                                                </div>
                                                <div class="desc">
                                                    <p class="name ellipsis"><%=oDaccuRankingStamp.FItemList(i).FItemName%></p>
                                                    <div class="brand"><%=oDaccuRankingStamp.FItemList(i).FBrandName%></div>
                                                </div>
                                            </a>
                                            <% if oDaccuRankingStamp.FItemList(i).FOptionCount > 0 Then %>
                                                <a href="" onclick="ZoomItemInfo('<%=oDaccuRankingStamp.FItemList(i).FItemId%>'); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% Else %>
                                                <a href="" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingStamp.FItemList(i).FItemId%>','<%= oDaccuRankingStamp.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer" class="ico-diary btn-cart" >장바구니</a>
                                            <% End If %>  
                                        </dd>
                                <% Next %>
                            <% End If %>
                        </dl>
                    </div>
                    <div class="alertLyrV15" style="display:none;">
                        <div class="alertBox">
                            <div class="layer-cart">
                                <em class="closeBtnV15 btn-close" onclick="fnDiaryDaccuLayerClose();return false;">&#10005;</em>
                                <a href="" onclick="fnDiaryDaccuLayerClose();return false;" class="btn-close">&#10005;</a>
                                <div class="alertInner">
                                    <p>선택하신 상품을<br />장바구니에 담았습니다.</p>
                                    <div class="btn-area">
                                        <a href="" onclick="fnDiaryDaccuLayerClose();return false;" class="btn-layer1">쇼핑 계속하기</a>
                                        <a href="/inipay/shoppingbag.asp" class="btn-layer2">장바구니 가기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%'!-- 관련기획전 --%>
				<!-- #include virtual="/diarystory2020/inc/inc_etcevent.asp" -->
				<%'!--// 관련기획전 --%>
			</div>
		</div>
	</div>    
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="sbagfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="mode" value="add">
<input type="hidden" name="itemid" value="">
<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
<input type="hidden" name="itemoption" value="0000">
<input type="hidden" name="userid" value="<%= getEncLoginUserId %>">
<input type="hidden" name="itemPrice" value="">
<input type="hidden" name="isPhotobook" value="">
<input type="hidden" name="isPresentItem" value="">
<input type="hidden" name="IsSpcTravelItem" value="">1
<input type="hidden" name="itemRemain" id="itemRamainLimit" value="">
<input type="hidden" name="itemea" value="1" />
</form>
</body>
</html>
<%
    Set oDaccuRankingPen = Nothing
    Set oDaccuRankingMemo = Nothing
    Set oDaccuRankingSticker = Nothing
    Set oDaccuRankingTape = Nothing
    Set oDaccuRankingStamp = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->