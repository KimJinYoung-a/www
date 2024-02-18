<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim i,opackmaster, opackitemlist, userid, guestSessionID, orderserial, message, title, midx
userid       	= getEncLoginUserID()
guestSessionID 	= GetGuestSessionKey
orderserial  	= requestCheckVar(request("idx"),11)
midx			= requestCheckVar(request("midx"),11)

If Not isNumeric(orderserial) Then
	Response.Write "<script>alert('잘못된 경로입니다.1');window.close();</script>"
	dbget.close
	Response.End
End If

If midx <> "" AND Not isNumeric(midx) Then
	Response.Write "<script>alert('잘못된 경로입니다.2');window.close();</script>"
	dbget.close
	Response.End
End If

Dim arr, jj
arr = fnGetOrderDetailStateList(orderserial)
If IsArray(arr) Then
For jj=0 To UBound(arr,2)
	If arr(0,jj) > 6 Then
		Response.Write "<script>alert('이미 출고가 완료되어\n선물포장 메세지를 수정할 수 없습니다.');window.close();</script>"
		dbget.close
		Response.End
	End If
Next
End If

set opackmaster = new Cpack
	opackmaster.FRectUserID = userid
	opackmaster.FRectSessionID = guestSessionID
	opackmaster.FRectOrderSerial = orderserial
	opackmaster.FRectCancelyn = "N"
	opackmaster.FRectSort = "ASC"
	opackmaster.Getpojang_master()
	
	If opackmaster.FResultCount < 1 Then
		Response.Write "<script>alert('잘못된 경로입니다.3');window.close();</script>"
		dbget.close
		Response.End
	End If
	
	If midx = "" Then
		midx = opackmaster.FItemList(0).fmidx
	End If
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<style>
.msgInput {border:1px solid #ddd; width:97%; padding:5px; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; box-sizing:border-box;}
.msgInput textarea {font-size:12px; line-height:1.4; color:#555; border:none; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; box-sizing:border-box;}
.msgInput p {color:#888;}
.pkgPdtWrap {position:relative; overflow:hidden; height:50px;}
.pkgPdtWrap .viewControl {display:none; position:absolute; right:15px; top:17px; padding-right:10px; background:url(http://fiximage.10x10.co.kr/web2015/common/blt16.png) 100% 7px no-repeat; font-size:11px; color:#d50c0c; cursor:pointer;}
.pkgPdtWrap span.folding {background:url(http://fiximage.10x10.co.kr/web2015/common/blt16.png) 100% -90px no-repeat;}
.pkgPdtList {margin:-5px 0;}
.pkgPdtList li {display:table; width:100%;}
.pkgPdtList li a {display:block;}
.pkgPdtList li p {display:table-cell; width:70px; padding:5px 0;}
.pkgPdtList li p img {vertical-align:top;}
.pkgPdtList li span {display:table-cell; padding-right:85px; vertical-align:middle; line-height:1.5;}
.pkgPdtList li span em {padding-left:10px;}
</style>
<script>
$(function() {
	var leng = $('.pkgPdtWrap .pkgPdtList li').length;
	var wrapH = $('.pkgPdtWrap').height();
	if (leng > 1) {
		$('.pkgPdtWrap .viewControl').show();
		$('.pkgPdtList li:first-child span').append("<em>...외 <strong class='crRed'>" + (leng-1) + "건</strong></em>");
		$('.pkgPdtWrap .viewControl').click(function(){
			var wrapH = $('.pkgPdtWrap').height();
			if (wrapH <= 50) {
				$(this).parent('.pkgPdtWrap').css('height', '100%');
				$('.pkgPdtWrap .viewControl').text('접기');
				$('.pkgPdtWrap .viewControl').addClass('folding');
				$('.pkgPdtList li:first-child span em').hide();
			} else {
				$(this).parent('.pkgPdtWrap').css('height', '50px');
				$('.pkgPdtWrap .viewControl').text('전체보기');
				$('.pkgPdtWrap .viewControl').removeClass('folding');
				$('.pkgPdtList li:first-child span').append("<em>...외 <strong class='crRed'>" + (leng-1) + "건</strong></em>");
			}
		});
	} else {
		$('.pkgPdtWrap .viewControl').hide();
	}


	$("#field textarea").each(function() {
		var defaultVal = this.value;
		$(this).focus(function() {

		});
		$(this).blur(function(){
			if(this.value == ''){
				
			}
		});
	});
	function frmCount(val) {
		var len = val.value.length;
		if (len >= 101) {
			val.value = val.value.substring(0, 100);
		} else {
			$("#mmsLen").text(len);
		}
	}
	$("#field textarea").keyup(function() {
		frmCount(this);
	});
	$("#mmsLen").text($("#field textarea").val().length);
});

function jsGoMessageEdit(v){
	$("input[name=midx]").val(v);
	frmgo.submit();
}

function jsSavePMsg(){
	if(frmMsg.message.value == ""){
		alert("선물포장 메세지를 입력해주세요.");
		frmMsg.message.focus();
		return false;
	}
	frmMsg.submit();
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_pakage_msg_edit.png" alt="선물포장 메세지 수정" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frmgo" action="<%=CurrURL()%>" method="get" style="margin:0px;">
				<input type="hidden" name="idx" value="<%=orderserial%>">
				<input type="hidden" name="midx" value="">
				</form>
				<form name="frmMsg" action="/inipay/pack/pack_message_edit_proc.asp" method="post" style="margin:0px;">
				<input type="hidden" name="idx" value="<%=orderserial%>">
				<div class="mySection">
					<p>선물포장 선택 후 메세지를 수정해주세요.</p>

					<div class="orderDetail tMar10">
						<table class="baseTable rowTable">
							<caption>선물포장 메세지 수정</caption>
							<colgroup>
								<col width="130" /><col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">선물포장 선택</th>
								<td>
									<select class="select" name="midx" onChange="jsGoMessageEdit(this.value);">
									<%
										For i=0 To opackmaster.FResultCount-1
											Response.Write "<option value=""" & opackmaster.FItemList(i).fmidx & """"
											If CStr(midx) = CStr(opackmaster.FItemList(i).fmidx) Then
												Response.Write " selected"
												message = opackmaster.FItemList(i).Fmessage
											End If
											Response.Write ">" & opackmaster.FItemList(i).Ftitle & "</option>" & vbCrLf
										Next

										
										opackmaster.frectmidx = midx
										opackmaster.Getpojang_itemlist
									%>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">상품정보</th>
								<td>
									<div class="pkgPdtWrap">
										<ul class="pkgPdtList">
										<%	For i=0 To opackmaster.FResultCount-1 %>
											<li>
												<p><img src="<%=opackmaster.FItemList(i).FImageList%>" width="50px" height="50px" /></p>
												<span><%=opackmaster.FItemList(i).FItemName%><%=CHKIIF(opackmaster.FItemList(i).FItemOptionName<>"","/"&opackmaster.FItemList(i).FItemOptionName,"")%> 
												<% If opackmaster.FItemList(i).FItemEa > 1 Then %>
													<strong class="crRed">x <%=opackmaster.FItemList(i).FItemEa%></strong></span>
												<% End If %>
											</li>
										<%	Next %>
										</ul>
										<span class="viewControl">전체보기</span>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">입력 메세지</th>
								<td>
									<div id="field" class="msgInput">
										<textarea style="width:99%;" rows="5" name="message"><%=message%></textarea>
										<p class="rt fs11"><strong><span id="mmsLen">0</span></strong>/100</p>
									</div>
								</td>
							</tr>
							</tbody>
						</table>
					</div>

					<div class="btnArea ct tPad25">
						<a href="" onClick="jsSavePMsg();return false;" class="btn btnS1 btnRed btnW120">수정</a>
						<a href="" onClick="window.close();return false;" class="btn btnS1 btnGry btnW120">취소</a>
					</div>
				</div>
				</form>
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
<% set opackmaster = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->