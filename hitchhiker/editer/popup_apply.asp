<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'####################################################
' Description :  히치하이커 고객에디터모집 Layer
' History : 2014.08.08 유태욱
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/contest/contestCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
Dim g_Contest, vGubun
vGubun = CStr(requestCheckVar(request("gb"),1))
g_Contest = CStr(requestCheckVar(request("g_Contest"),10))

'If vGubun = "1" Then
'	g_Contest = "con45"
'Else
'	g_Contest = "con46"
'End If

if vGubun="" or g_Contest="" then
	Response.Write "<script language='javascript'>"
	Response.Write "	alert('정상적인 페이지가 아닙니다.');"
	Response.Write "</script>"
	dbget.close()	:	Response.End
end if

If IsUserLoginOK = False Then
	response.write "<script>alert('로그인이 필요한 서비스입니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
'	response.write "<script>alert('로그인이 필요한 서비스입니다.');top.location.href='/login/loginpage.asp?vType=G';</script>"
	response.end
End If

Dim clsContest, userid, vEntrySDate, vEntryEDate
userid = GetLoginUserID

Set clsContest = New cContest
	clsContest.FContest = g_Contest
	clsContest.FContestChk
	
	if clsContest.FTotalCount > 0 then
		vEntrySDate = clsContest.FOneItem.fentry_sdate
		vEntryEDate = clsContest.FOneItem.fentry_edate
	else
		Response.Write "<script language='javascript'>"
		Response.Write "	alert('해당되는 공모전이 없습니다.');"

		Response.Write "</script>"
		dbget.close()	:	Response.End
	end if
Set clsContest = Nothing

'// 응모기간 확인
'If date < vEntrySDate Then
'	Response.Write "<script language='javascript'>" &_
'		"alert('죄송합니다.\지원 기간이 아닙니다.\n"&vEntrySDate&" 부터 진행됩니다.');" &_
'
'		"</script>"
'	Response.End
'End If
'
'If date > vEntryEDate Then
'	Response.Write "<script language='javascript'>" &_
'		"alert('죄송합니다.\n지원 기간이 종료되었습니다.');" &_
'	
'		"</script>"
'	Response.End
'End If
%>

<% If vGubun = "1" Then		'### ESSAY 페이지 %>
	<script language="javascript">

		function frmSubmit() {
			var frm = document.frmApply;
			if(!frm.imgfile1.value) {
				alert("응모하실 파일을 선택해주세요.");
				return;
			}
	
			//* 파일확장자 체크
			for(var ii=1; ii<2; ii++)
			{
				var frmname		 = eval("frm.imgfile"+ii+"");
	
				if(frmname.value != "")
				{
					var sarry        = frmname.value.split("\\");      // 선택된 이미지 화일의 풀 경로
					var maxlength    = sarry.length-1;       // 이미지 화일 풀 경로에서 이미지만 뽑아내기
					var ext = sarry[maxlength].split(".");
	
					if(ext[1].toLowerCase() != "zip")
					{
						alert('zip파일만 업로드가 가능합니다.');
						return;
					}
				}
			}
			if(!document.getElementById('agreeYes').checked) {
				alert("동의하셔야만 지원이 가능합니다");
				return;
			}
			if(document.getElementById('agreeNo').checked) {
				alert("동의하셔야만 지원이 가능합니다");
				return;
			}
			frm.submit();
		}

	</script>
	<!-- for dev msg : 히치하이커 고객에디터 모집 ESSAY지원 -->
	<div class="lyHitchhiker window" style="height:484px; margin-top:-247px;">
		<div class="modalBox vtype">
			<div class="modalHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_editor_essay.gif" alt="히치하이커 고객에디터 모집 ESSAY" /></h1>
			</div>
			<form name="frmApply" method="POST" action="<%=staticImgUpUrl%>/linkweb/enjoy/Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
			<input type="hidden" name="userid" value="<%=userid%>">
			<input type="hidden" name="div" value="<%=g_Contest%>">
			<input type="hidden" name="hitchhiker" value="o">
			<input type="hidden" name="myinfo" value="">
			<input type="hidden" name="imgContent" value="">
			<div class="modalBody editorRecruit">
				<fieldset>
				<legend>히치하이커 고객에디터 ESSAY 모집 지원하기</legend>
					<h2><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_file_attach.gif" alt="파일 첨부하기" /></h2>
					<input type="file" name="imgfile1" title="히치하이커 고객에디터 지원서 파일 첨부" />
					<p class="starpoint">고객에디터 지원서 양식을 다운로드 받아 작성한 뒤, 압축하여 ZIP 파일로 업로드 해주시기 바랍니다.</p>
					<div class="boxgrey">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_rule.gif" alt="규정" /></h3>
						<ul>
							<li>작품은 타출판물에 게재된 적이 없는 순수창작물이어야 합니다. 타인의 저작권 및 초상권 침해의 소지가 있거나 유사, 모방 작품일 경우 심사대상에서 제외되며, 관련된 모든 법적 분쟁은 지원자가 책임지게 됩니다.</li>
							<li>당선작의 저작권은 텐바이텐에 귀속되며, 콘텐츠는 출판 인쇄물 외에 웹서비스, E - 퍼블리싱 등 다양한 방식으로 활용됩니다.</li>
							<li>당선된 작품의 원본 파일을 반드시 제출하여야 합니다. 접수된 작품은 반환되지 않습니다.</li>
							<li>글과 사진은 기획의도에 따라 윤문과 수정 작업을 거쳐 발간되며, 유상으로 판매됩니다.</li>
						</ul>
					</div>
					<div class="agree">
						<p><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_agree.gif" alt="고객에디터 모집관련 규정을 읽었으며, 이에 동의합니까?" /></p>
						<input type="radio" id="agreeYes" name="ch" checked="checked" /> <label for="agreeYes"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_agree_yes.gif" alt="네, 동의합니다." /></label>
						<input type="radio" id="agreeNo" name="ch" /> <label for="agreeNo"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_agree_no.gif" alt="아니오, 동의하지 않습니다." /></label>
						<button type="submit" href="" onclick="javascript:frmSubmit();" class="btn btnB1 btnGry btnW200"><em class="whiteArr01">지원하기</em></button>
					</div>
				</fieldset>
			</div>
			<button onclick="ClosePopLayer()" class="modalClose">닫기</button>
		</div>
	</div>
	
<% Else		'### PHOTO STICKER 페이지 %>
	<script language="javascript">

		function frmSubmit() {
			var frm = document.frmApply;
			if(!frm.imgfile1.value) {
				alert("응모하실 파일을 선택해주세요.");
				return;
			}
	
			//* 파일확장자 체크
			for(var ii=1; ii<2; ii++)
			{
				var frmname		 = eval("frm.imgfile"+ii+"");
	
				if(frmname.value != "")
				{
					var sarry        = frmname.value.split("\\");      // 선택된 이미지 화일의 풀 경로
					var maxlength    = sarry.length-1;       // 이미지 화일 풀 경로에서 이미지만 뽑아내기
					var ext = sarry[maxlength].split(".");
	
					if(ext[1].toLowerCase() != "jpg")
					{
						alert('jpg 파일만 업로드가 가능합니다.');
						return;
					}
				}
			}
			if(!document.getElementById('agreeYes').checked) {
				alert("동의하셔야만 지원이 가능합니다");
				return;
			}
			if(document.getElementById('agreeNo').checked) {
				alert("동의하셔야만 지원이 가능합니다.");
				return;
			}
			frm.submit();
		}
		
	</script>
	
	<div class="lyHitchhiker window" style="height:484px; margin-top:-247px;">
		<div class="modalBox vtype">
			<div class="modalHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_editor_photo_sticker.gif" alt="히치하이커 고객에디터 모집 PHOTO STICKER" /></h1>
			</div>
			<form name="frmApply" method="POST" action="<%=staticImgUpUrl%>/linkweb/enjoy/Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
			<input type="hidden" name="userid" value="<%=userid%>">
			<input type="hidden" name="div" value="<%=g_Contest%>">
			<input type="hidden" name="hitchhiker" value="o">
			<input type="hidden" name="myinfo" value="">
			<input type="hidden" name="imgContent" value="">
			<div class="modalBody editorRecruit">
				<fieldset>
				<legend>히치하이커 고객에디터 PHOTO STICKER 모집 지원하기</legend>
					<h2><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_file_attach.gif" alt="파일 첨부하기" /></h2>
					<input type="file" name="imgfile1" title="사진 첨부" />
					<p class="starpoint">좌우 1000px 이상의 jpg 파일로 업로드 해주시기 바랍니다. <span style="color:#999;">(아이디 하나당 열 장까지만 지원 가능합니다.)</span></p>
					<div class="boxgrey">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_rule.gif" alt="규정" /></h3>
						<ul>
							<li>작품은 타출판물에 게재된 적이 없는 순수창작물이어야 합니다. 타인의 저작권 및 초상권 침해의 소지가 있거나 유사, 모방 작품일 경우 심사대상에서 제외되며, 관련된 모든 법적 분쟁은 지원자가 책임지게 됩니다.</li>
							<li>당선작의 저작권은 텐바이텐에 귀속되며, 콘텐츠는 출판 인쇄물 외에 웹서비스, E - 퍼블리싱 등 다양한 방식으로 활용됩니다.</li>
							<li>당선된 작품의 원본 파일을 반드시 제출하여야 합니다. 접수된 작품은 반환되지 않습니다.</li>
							<li>글과 사진은 기획의도에 따라 윤문과 수정 작업을 거쳐 발간되며, 유상으로 판매됩니다.</li>
						</ul>
					</div>
					<div class="agree">
						<p><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_agree.gif" alt="고객에디터 모집관련 규정을 읽었으며, 이에 동의합니까?" /></p>
						<input type="radio" id="agreeYes" name="ch" checked="checked" /> <label for="agreeYes"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_agree_yes.gif" alt="네, 동의합니다." /></label>
						<input type="radio" id="agreeNo" name="ch" /> <label for="agreeNo"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_agree_no.gif" alt="아니오, 동의하지 않습니다." /></label>
						<button type="submit" href="" onclick="javascript:frmSubmit();" class="btn btnB1 btnGry btnW200"><em class="whiteArr01">지원하기</em></button>
					</div>
				</fieldset>
			</div>
			<button onclick="ClosePopLayer()" class="modalClose">닫기</button>
		</div>
	</div>
<% End If %>

<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->