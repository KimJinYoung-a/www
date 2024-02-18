<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2019 다꾸랭킹페이지
' History : 2018-11-20 원승현 생성
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
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/diarystory2019/daccu_ranking.asp"
			REsponse.End
		end if
	end if
end if

Dim vDate, vRankingCount, vCateType, sqlStr, vDateDisplayValue, rns, rne, i

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

vDateDisplayValue = Left(vDate, 4)&"년 "&Mid(vDate, 6, 2)&"월 "&Right(vDate, 2)&"일"

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

    // fixed nav
	var nav1 = $(".ranking-conts thead").offset().top;
	$(window).scroll(function() {
		var y = $(window).scrollTop();
        if (nav1 < y ) {
			$(".ranking-conts thead").addClass("fixed-nav");
        } 
        else {
			$(".ranking-conts thead").removeClass("fixed-nav");
        }
    });
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
                        "top" : offsetTop-270,
                        "left" : offsetLeft+19
                    });
                    $("#alertMsgV15").html("선택하신 상품을<br />장바구니에 담았습니다.");
                    $(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
                    $("#ibgaCNT").html(message.split("||")[1]);
                    break;
                case "2":
                    $(".alertLyrV15").css({
                        "posion" : "absolute",
                        "top" : offsetTop-270,
                        "left" : offsetLeft+19
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
	<div class="container diary2019">
		<div id="contentWrap" class="daccu-ranking">
			<!-- #include virtual="/diarystory2019/inc/head.asp" -->
			<div class="diary-content">
                <div class="section top-ranking">
                    <h2 class="ftLt"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/tit_ranking.png" alt="프로 다꾸러들이 애용하는 베스트 데코템" /></h2>
                    <div class="date ftRt">
                        <dl class="evtSelect">
                            <dt><span><%=vDateDisplayValue%></span></dt>
                            <dd style="display: none;">
                                <ul>
                                    <%=GetDiaryDaccuBestDate(vDate)%>
                                </ul>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="ranking-conts">
                    <table class="section">
                        <caption>베스트 데코템 목록</caption>
                        <thead>
                            <tr>
                                <th>랭킹</th>
                                <th>펜 / 색연필</th>
                                <th>떡메모지</th>
                                <th>스티커</th>
                                <th>테이프</th>
                                <th>스탬프</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <ol class="ranking-num">
                                        <% for rns = 1 to rne %>
                                            <li><span><%=rns%></span></li>
                                        <% next %>
                                    </ol>
                                </td>

                                <%' 펜/색연필 %>
                                <td>
                                    <ol>
                                        <% If oDaccuRankingPen.FResultCount > 0 Then %>
                                            <%	For i=0 to oDaccuRankingPen.FResultCount-1 %>
                                                <%
                                                    If i > 49 Then
                                                        exit for
                                                    End If
                                                %>                                    
                                                    <li class="<% IF oDaccuRankingPen.FItemList(i).isSoldOut Then response.write "sold-out" %>">
                                                        <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingPen.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>">
                                                            <span class="thumbnail"><img src="<%= getThumbImgFromURL(oDaccuRankingPen.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingPen.FItemList(i).FItemName%>" /></span>
                                                            <span class="desc">
                                                                <span class="brand"><%=oDaccuRankingPen.FItemList(i).FBrandName%></span>
                                                                <span class="name"><%=oDaccuRankingPen.FItemList(i).FItemName%></span>
                                                            </span>
                                                        </a>
                                                        <% if oDaccuRankingPen.FItemList(i).FOptionCount > 0 Then %>
                                                            <span class="btn-shoppingbag" onclick="ZoomItemInfo('<%=oDaccuRankingPen.FItemList(i).FItemId%>'); return false;" style="cursor:pointer"></span>    
                                                        <% Else %>
                                                            <span class="btn-shoppingbag" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingPen.FItemList(i).FItemId%>','<%= oDaccuRankingPen.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer"></span>
                                                        <% End If %>                                  
                                                    </li>
                                            <% Next %>
                                        <% End If %>
                                    </ol>
                                </td>

                                <%' 떡메모지 %>
                                <td>
                                    <ol>
                                        <% If oDaccuRankingMemo.FResultCount > 0 Then %>
                                            <%	For i=0 to oDaccuRankingMemo.FResultCount-1 %>
                                                <%
                                                    If i > 49 Then
                                                        exit for
                                                    End If
                                                %>                                    
                                                    <li class="<% IF oDaccuRankingMemo.FItemList(i).isSoldOut Then response.write "sold-out" %>">
                                                        <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingMemo.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>">
                                                            <span class="thumbnail"><img src="<%= getThumbImgFromURL(oDaccuRankingMemo.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingMemo.FItemList(i).FItemName%>" /></span>
                                                            <span class="desc">
                                                                <span class="brand"><%=oDaccuRankingMemo.FItemList(i).FBrandName%></span>
                                                                <span class="name"><%=oDaccuRankingMemo.FItemList(i).FItemName%></span>
                                                            </span>
                                                        </a>
                                                        <% if oDaccuRankingMemo.FItemList(i).FOptionCount > 0 Then %>
                                                            <span class="btn-shoppingbag" onclick="ZoomItemInfo('<%=oDaccuRankingMemo.FItemList(i).FItemId%>'); return false;" style="cursor:pointer"></span>    
                                                        <% Else %>
                                                            <span class="btn-shoppingbag" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingMemo.FItemList(i).FItemId%>','<%= oDaccuRankingMemo.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer"></span>
                                                        <% End If %>                                  
                                                    </li>
                                            <% Next %>
                                        <% End If %>
                                    </ol>
                                </td>

                                <%' 스티커 %>
                                <td>
                                    <ol>
                                        <% If oDaccuRankingSticker.FResultCount > 0 Then %>
                                            <%	For i=0 to oDaccuRankingSticker.FResultCount-1 %>
                                                <%
                                                    If i > 49 Then
                                                        exit for
                                                    End If
                                                %>                                    
                                                    <li class="<% IF oDaccuRankingSticker.FItemList(i).isSoldOut Then response.write "sold-out" %>">
                                                        <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingSticker.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>">
                                                            <span class="thumbnail"><img src="<%= getThumbImgFromURL(oDaccuRankingSticker.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingSticker.FItemList(i).FItemName%>" /></span>
                                                            <span class="desc">
                                                                <span class="brand"><%=oDaccuRankingSticker.FItemList(i).FBrandName%></span>
                                                                <span class="name"><%=oDaccuRankingSticker.FItemList(i).FItemName%></span>
                                                            </span>
                                                        </a>
                                                        <% if oDaccuRankingSticker.FItemList(i).FOptionCount > 0 Then %>
                                                            <span class="btn-shoppingbag" onclick="ZoomItemInfo('<%=oDaccuRankingSticker.FItemList(i).FItemId%>'); return false;" style="cursor:pointer"></span>    
                                                        <% Else %>
                                                            <span class="btn-shoppingbag" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingSticker.FItemList(i).FItemId%>','<%= oDaccuRankingSticker.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer"></span>
                                                        <% End If %>                                  
                                                    </li>
                                            <% Next %>
                                        <% End If %>
                                    </ol>
                                </td>

                                <%' 테이프 %>
                                <td>
                                    <ol>
                                        <% If oDaccuRankingTape.FResultCount > 0 Then %>
                                            <%	For i=0 to oDaccuRankingTape.FResultCount-1 %>
                                                <%
                                                    If i > 49 Then
                                                        exit for
                                                    End If
                                                %>                                    
                                                    <li class="<% IF oDaccuRankingTape.FItemList(i).isSoldOut Then response.write "sold-out" %>">
                                                        <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingTape.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>">
                                                            <span class="thumbnail"><img src="<%= getThumbImgFromURL(oDaccuRankingTape.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingTape.FItemList(i).FItemName%>" /></span>
                                                            <span class="desc">
                                                                <span class="brand"><%=oDaccuRankingTape.FItemList(i).FBrandName%></span>
                                                                <span class="name"><%=oDaccuRankingTape.FItemList(i).FItemName%></span>
                                                            </span>
                                                        </a>
                                                        <% if oDaccuRankingTape.FItemList(i).FOptionCount > 0 Then %>
                                                            <span class="btn-shoppingbag" onclick="ZoomItemInfo('<%=oDaccuRankingTape.FItemList(i).FItemId%>'); return false;" style="cursor:pointer"></span>    
                                                        <% Else %>
                                                            <span class="btn-shoppingbag" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingTape.FItemList(i).FItemId%>','<%= oDaccuRankingTape.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer"></span>
                                                        <% End If %>                                  
                                                    </li>
                                            <% Next %>
                                        <% End If %>
                                    </ol>
                                </td>

                                <%' 스탬프 %>
                                <td>
                                    <ol>
                                        <% If oDaccuRankingStamp.FResultCount > 0 Then %>
                                            <%	For i=0 to oDaccuRankingStamp.FResultCount-1 %>
                                                <%
                                                    If i > 49 Then
                                                        exit for
                                                    End If
                                                %>                                    
                                                    <li class="<% IF oDaccuRankingStamp.FItemList(i).isSoldOut Then response.write "sold-out" %>">
                                                        <a href="/shopping/category_prd.asp?itemid=<%=oDaccuRankingStamp.FItemList(i).FItemId%>&gaparam=diary_daccuranking_<%=i+1%>">
                                                            <span class="thumbnail"><img src="<%= getThumbImgFromURL(oDaccuRankingStamp.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oDaccuRankingStamp.FItemList(i).FItemName%>" /></span>
                                                            <span class="desc">
                                                                <span class="brand"><%=oDaccuRankingStamp.FItemList(i).FBrandName%></span>
                                                                <span class="name"><%=oDaccuRankingStamp.FItemList(i).FItemName%></span>
                                                            </span>
                                                        </a>
                                                        <% if oDaccuRankingStamp.FItemList(i).FOptionCount > 0 Then %>
                                                            <span class="btn-shoppingbag" onclick="ZoomItemInfo('<%=oDaccuRankingStamp.FItemList(i).FItemId%>'); return false;" style="cursor:pointer"></span>    
                                                        <% Else %>
                                                            <span class="btn-shoppingbag" onclick="fnDiaryDaccuShopping('<%=oDaccuRankingStamp.FItemList(i).FItemId%>','<%= oDaccuRankingStamp.FItemList(i).getRealPrice %>', $(this).offset().top, $(this).offset().left); return false;" style="cursor:pointer"></span>
                                                        <% End If %>                                  
                                                    </li>
                                            <% Next %>
                                        <% End If %>
                                    </ol>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="alertLyrV15" style="display:none;">
                        <div class="alertBox">
                            <em class="closeBtnV15" onclick="fnDiaryDaccuLayerClose();return false;">&times;</em>
                            <div class="alertInner">
                                <p><strong class="cBk0V15" id="alertMsgV15">선택하신 상품을<br />장바구니에 담았습니다.</strong></p>
                                <p class="tPad10">
                                    <a href="" onclick="fnDiaryDaccuLayerClose();return false;" class="btn btnS1 btnPurple">쇼핑 계속하기</a>
                                    <a href="/inipay/shoppingbag.asp" class="btn btnS1 btnWhite">장바구니 가기</a>
                                </p>
                            </div>
                        </div>
                    </div>                    
                </div>
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
<input type="hidden" name="IsSpcTravelItem" value="">
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