<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'' 사이트 구분
Const sitename = "10x10"

dim userid, guestSessionID
userid = GetLoginUserID
guestSessionID = GetGuestSessionKey

dim oShoppingBag
set oShoppingBag = new CShoppingBag
oShoppingBag.FRectUserID    = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

oshoppingbag.GetShoppingBagDataDB


dim itemid, itemoption, itemea, i
dim requiredetail
dim mode, requiredetailedit

itemid      = requestCheckVar(request("itemid"),9)
itemoption  = requestCheckVar(request("itemoption"),4)
requiredetail = oShoppingBag.getRequireDetailByItemID(itemid,itemoption)
itemea      = oShoppingBag.getItemNoByItemID(itemid,itemoption)

if (itemea<1) then
    response.write "<script>alert('해당 상품이 없습니다.');window.close();</script>"
    dbget.close() : response.end
end if

mode = request.form("mode")
requiredetailedit = request.form("requiredetailedit")

dim ret
if mode="edit" then
    if (itemea>1) then
        requiredetailedit = ""
        for i=0 to itemea-1
            if (request.form("requiredetailedit"&i)<>"") then
            requiredetailedit = requiredetailedit & request.form("requiredetailedit"&i) & CAddDetailSpliter
            end if
        next
        if Right(requiredetailedit,2)=CAddDetailSpliter then
            requiredetailedit = Left(requiredetailedit,Len(requiredetailedit)-2)
        end if
    end if

    ret = oShoppingBag.EditShoppingRequireDetail(itemid, itemoption, Html2DB(requiredetailedit))
end if

set oShoppingBag = Nothing

if (ret) then
    response.write "<script>alert('수정 되었습니다.');</script>"
    response.write "<script>opener.location.reload();window.close();</script>"
    dbget.close() : response.end
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>
function editRequire(frm){
    var detailArr='';
	if (frm.requiredetailedit != undefined) {
		if (frm.requiredetailedit.value.length < 1) {
			alert('주문 제작 상품 문구를 작성해 주세요.');
			frm.requiredetailedit.focus();
			return;
		}

		if(GetByteLength(frm.requiredetailedit.value) > 500) {
			alert('문구 입력은 최대 250자(한글 기준) 까지 가능합니다.\n\n현재 글자수 : ' + frm.requiredetailedit.value.length);
			frm.requiredetailedit.focus();
			return;
		}
	} else {
		<% if (itemea>1) then %>
        for (var i = 0; i < <%= itemea %>; i++) {
			var obj = eval("frm.requiredetailedit" + i);

			if (obj.value.length < 1) {
				alert('주문 제작 상품 문구를 작성해 주세요.');
				obj.focus();
				return;
			}

            if(GetByteLength(obj.value) > 500) {
    			alert('문구 입력은 최대 250자(한글 기준) 까지 가능합니다.\n\n현재 글자수 : ' + obj.value.length);
    			obj.focus();
    			return;
    		}

            detailArr = detailArr + obj.value + '||';
        }

        if(GetByteLength(detailArr) > 800) {
			alert('문구 입력합계는 최대 400자(한글 기준) 까지 가능합니다.\n\n현재 글자수 : ' + detailArr.length);
			frm.requiredetailedit0.focus();
			return;
		}
        <% end if %>
	}

	if (confirm('수정 하시겠습니까?')) {
	    frm.mode.value = "edit";
		frm.submit();
	}
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/inipay/tit_ordermade_edit.gif" alt="주문제작 문구 수정" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->

				<div class="orderMade">
				    <p class="ct fs12">같은 상품을 2개 이상 주문하시고 문구를 다르게 하실 경우, <br />반드시 각각의 문구를 작성해주시기 바랍니다.</p>
					<form name="frm" method="post" onsubmit="return false;" >
                    <input type="hidden" name="mode" value="">
                    <input type="hidden" name="itemid" value="<%= itemid %>">
                    <input type="hidden" name="itemoption" value="<%= itemoption %>">
					<fieldset>
					<legend>주문제작 문구 수정하기</legend>
					<% if (itemea=1) then %>
						<textarea title="주문제작 문구 입력" name="requiredetailedit" id="requiredetailedit" cols="20" rows="8"><%= splitValue(requiredetail,CAddDetailSpliter,i) %></textarea>
					<% else %>
					<% for i=0 to itemea-1 %>
					    <p class="tPad30"><strong><%= i+1 %>번 상품 문구</strong></p>
					    <textarea title="주문제작 문구 입력" name="requiredetailedit<%= i %>" id="requiredetailedit<%= i %>" cols="20" rows="4" class="tMar05" ><%= splitValue(requiredetail,CAddDetailSpliter,i) %></textarea>
					    <br>
					<% next %>
					<% end if %>

						<div class="btnArea ct tPad30">
							<input type="submit" class="btn btnS1 btnRed btnW100" value="수정" onclick="editRequire(frm)"/>
							<button type="button" class="btn btnS1 btnGry btnW100"  onclick="window.close();">취소</button>
						</div>
					</fieldset>
					</form>
				</div>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
