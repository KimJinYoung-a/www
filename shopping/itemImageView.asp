<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 상품이미지보기
' Hieditor : 	2009.04. 허진원 생성
'				2017.03.23 한용민 수정
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 상품 이미지 목록"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
td {font-size:11px; border:1px dotted #ccc; padding:2px;}
.mainconttable img {max-width:900px;}
</style>
<script>
$(function() {
	$(".mainconttable img").error(function(){
		$(this).attr("src","https://fiximage.10x10.co.kr/web2018/common/ico_noimage.png").css("max-width","30px");
	});
});
</script>
</head>
<%
dim Itemid
dim SQL, lp

itemid= getNumeric(requestCheckVar(request("itemid"),9))

IF itemid="" Then
	response.write "<script>alert('상품번호를 입력하세요');</script>"	
	response.end
End IF

on error resume next
%>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
		<!-- // 본문 시작 //-->
		<table width="100%" border="0" class="mainconttable">
		<%
			'// 상품 기본 이미지
			SQL = " select top 1 * from db_item.[dbo].tbl_item " &_
					" where itemid='" & Cstr(itemid) & "'"
			rsget.CursorLocation = adUseClient
			rsget.open SQL, dbget, adOpenForwardOnly, adLockReadOnly
		
			if not rsget.eof then
		%>
		<tr>
			<td colspan="3" align="left" style="background:#555; color:#EEE; padding:5px;">
				<ul>
					<li>상품코드 : <b><%=itemid%></b> <a href="/shopping/category_prd.asp?itemid=<%=itemid%>" target="_blank" style="color:#EEB;" title="새창에서 상품상세 보기">[새창]</a></li>
					<li>상품명 : <b><%=rsget("itemname")%></b></li>
				</ul>
			</td>
		</tr>
		<tr height="20" bgcolor="FEFEFE" align="center">
			<td width="80">구분</td>
			<td width="100">크기</td>
			<td>이미지</td>
		</tr>
		<tr height="40" align="center">
			<td width="80" rowspan="9" bgcolor="F0F0FF">상품기본</td>
			<td width="100" bgcolor="F0F0F8"><b>38x38</b><br>(Thumb)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/basicicon/<%= GetImageSubFolderByItemid(itemid) %>/C<%= rsget("basicimage") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>50x50</b><br>(Small)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/small/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("smallimage") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>100x100</b><br>(List)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/List/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("listimage") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>120x120</b><br>(List120)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/List120/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("listimage120") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>150x150</b><br>(icon2)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/icon2/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("icon2image") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>200x200</b><br>(icon1)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/icon1/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("icon1image") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>400x400</b><br>(basic)</td>
			<td bgcolor="FAFAFA" align="left"><img src="http://webimage.10x10.co.kr/image/basic/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("basicimage") %>"></td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>600x600</b><br>(basic600)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("basicimage600")="" or isNull(rsget("basicimage600"))) then %>
				<img src="http://webimage.10x10.co.kr/image/basic600/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("basicimage600") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F0F8"><b>1000x1000</b><br>(basic1000)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("basicimage1000")="" or isNull(rsget("basicimage1000"))) then %>
				<img src="http://webimage.10x10.co.kr/image/basic1000/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("basicimage1000") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td width="80" rowspan="2" bgcolor="F0FFF0">흰배경(누끼)<br>이미지</td>
			<td bgcolor="F0F8F0"><b>400x400</b><br>(mask)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("maskimage")="" or isNull(rsget("maskimage"))) then %>
				<img src="http://webimage.10x10.co.kr/image/mask/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("maskimage") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F8F0"><b>1000x1000</b><br>(mask1000)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("maskimage1000")="" or isNull(rsget("maskimage1000"))) then %>
				<img src="http://webimage.10x10.co.kr/image/mask1000/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("maskimage1000") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td width="80" rowspan="5" bgcolor="F0F055">텐바이텐기본<br>이미지</td>
			<td bgcolor="F0F8F0"><b>50x50</b><br>(50사이즈)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("tentenimage50")="" or isNull(rsget("tentenimage50"))) then %>
				<img src="http://webimage.10x10.co.kr/image/tenten50/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("tentenimage50") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F8F0"><b>200x200</b><br>(200사이즈)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("tentenimage200")="" or isNull(rsget("tentenimage200"))) then %>
				<img src="http://webimage.10x10.co.kr/image/tenten200/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("tentenimage200") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F8F0"><b>400x400</b><br>(400사이즈)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("tentenimage400")="" or isNull(rsget("tentenimage400"))) then %>
				<img src="http://webimage.10x10.co.kr/image/tenten400/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("tentenimage400") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F8F0"><b>600x600</b><br>(600사이즈)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("tentenimage600")="" or isNull(rsget("tentenimage600"))) then %>
				<img src="http://webimage.10x10.co.kr/image/tenten600/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("tentenimage600") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F0F8F0"><b>1000x1000</b><br>(1000사이즈)</td>
			<td bgcolor="FAFAFA" align="left">
				<% if Not(rsget("tentenimage1000")="" or isNull(rsget("tentenimage1000"))) then %>
				<img src="http://webimage.10x10.co.kr/image/tenten1000/<%= GetImageSubFolderByItemid(itemid) %>/<%= rsget("tentenimage1000") %>">
				<% else %>
				등록이미지 없음
				<% end if %>
			</td>
		</tr>
		<% 
			else
				response.Write "<tr><td bgcolor='#FFFFFF' align='center'>존재하지 않는 상품입니다.</td></tr>"
			end if
			rsget.close 
		
			'// 상품 추가 이미지
			dim ArrAddImage,i
			SQL = " select gubun,itemid,AddImage_400,AddImage_600,AddImage_1000  " &_
					" from db_item.[dbo].tbl_item_addimage "&_
					" where itemid='"& CStr(itemid) & "'"
			rsget.CursorLocation = adUseClient
			rsget.open SQL, dbget, adOpenForwardOnly, adLockReadOnly
			
			if not rsget.eof then
				ArrAddImage = rsget.GetRows()
			End if
			
			rsget.close
			
		%>
		<%
			if isArray(ArrAddImage) then
				for i= 0 to Ubound(ArrAddImage,2)
		%>
		<tr height="40" align="center">
			<td width="80" rowspan="3" bgcolor="FFF0F0">추가 이미지<br>#<%= i +1 %></td>
			<td bgcolor="F8F0F0"><b>400x400</b></td>
			<td bgcolor="FAFAFA" align="left">
			<%
				if Not(ArrAddimage(2,i)="" or isNull(ArrAddimage(2,i))) then
					Response.Write "<img src=http://webimage.10x10.co.kr/image/add" & Cstr(ArrAddImage(0,i)) & "icon/" & GetImageSubFolderByItemid(ArrAddimage(1,i)) & "/C" + ArrAddimage(2,i) & "><br>"
					Response.Write "<img src=http://webimage.10x10.co.kr/image/add" & Cstr(ArrAddImage(0,i)) & "/" & GetImageSubFolderByItemid(ArrAddimage(1,i)) & "/" + ArrAddimage(2,i) & ">"
				else
					Response.Write "등록이미지 없음"
				end if
			%>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F8F0F0"><b>600x600</b></td>
			<td bgcolor="FAFAFA" align="left">
			<%
				if Not(ArrAddimage(3,i)="" or isNull(ArrAddimage(3,i))) then
					Response.Write "<img src=http://webimage.10x10.co.kr/image/add" & Cstr(ArrAddImage(0,i)) & "_600/" & GetImageSubFolderByItemid(ArrAddimage(1,i)) & "/" + ArrAddimage(3,i) & ">"
				else
					Response.Write "등록이미지 없음"
				end if
			%>
			</td>
		</tr>
		<tr height="40" align="center">
			<td bgcolor="F8F0F0"><b>1000x1000</b></td>
			<td bgcolor="FAFAFA" align="left">
			<%
				if Not(ArrAddimage(4,i)="" or isNull(ArrAddimage(4,i))) then
					Response.Write "<img src=http://webimage.10x10.co.kr/image/add" & Cstr(ArrAddImage(0,i)) & "_1000/" & GetImageSubFolderByItemid(ArrAddimage(1,i)) & "/" + ArrAddimage(4,i) & ">"
				else
					Response.Write "등록이미지 없음"
				end if
			%>
			</td>
		</tr>
		<%
				next
			end if
			
			Dim sColorImg
			SQL = " select listimage from [db_item].[dbo].tbl_item_colorOption where itemid='"& CStr(itemid) & "'"
			rsget.CursorLocation = adUseClient
			rsget.open SQL, dbget, adOpenForwardOnly, adLockReadOnly
			
			If not rsget.eof Then
				if ((Not IsNULL(rsget(0))) and (rsget(0)<>"")) then
					sColorImg = webImgUrl & "/color/list/" + GetImageSubFolderByItemid(itemid) + "/"  + rsget(0)
				end if
			End If
			rsget.close
		%>
		<tr height="40" align="center">
			<td width="80" bgcolor="FEE8FE">색상별<br>상품이미지</td>
			<td bgcolor="F8E8F8"><b>1000x1000</b></td>
			<td bgcolor="FAFAFA" align="left"><img src="<%=sColorImg%>" border="0" align="absmiddle"></td>
		</tr>

		<%
		'// 상품상세 편집용 이미지 (Uploaded / ImgType:3) - 2019.08.29 허진원
			dim oADD
			set oADD = new CatePrdCls
			oADD.getAddImage itemid
			'설명용 이미지(추가)
			IF oAdd.FResultCount > 0 THEN
				lp = 1
				FOR i= 0 to oAdd.FResultCount-1
					IF oAdd.FADD(i).FAddImageType=3 AND oAdd.FADD(i).FIsExistAddimg THEN
		%>
		<tr height="40" align="center">
			<td width="80" bgcolor="FEFEFE" colspan="2">상품설명 편집용<br>이미지 #<%=lp%></td>
			<td bgcolor="FAFAFA" align="left"><img src="<%=oAdd.FADD(i).FAddimage%>" border="0" style="max-width:1000px;" /></td>
		</tr>
		<%
					lp = lp + 1
					End IF
				NEXT
			END IF
			set oADD = Nothing
		%>

		<%
		'/캡쳐 이미지	'/2017.03.23 한용민 추가
		dim isUseCaptureView, vCaptureExist, VCaptureImgArr, oItem
		isUseCaptureView = False

		'캡쳐이미지
		set oItem = new CatePrdCls
		oItem.sbDetailCaptureViewCount itemid
		vCaptureExist = oItem.FCaptureExist

		If vCaptureExist = "1" Then
			isUseCaptureView = true
			VCaptureImgArr = oItem.sbDetailCaptureViewImages(itemid)
		End If
		%>
		<tr height="40" align="center">
			<td width="80" bgcolor="F0FFF0">캡쳐이미지</td>
			<td bgcolor="F0F8F0"><b>경로</b></td>
			<td bgcolor="FAFAFA" align="left">
				<% If ((isUseCaptureView)) Then %>
					<% if isArray(VCaptureImgArr) then %>
						<% for i=0 to UBound(VCaptureImgArr,2) %>
							<%= VCaptureImgArr(2,i) %><br>
						<% next %>
					<% end if %>
				<% End If %>
			</td>
		</tr>
		<%
			on error goto 0
		%>
		</table>
		<!-- // 본문 끝 //-->
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->