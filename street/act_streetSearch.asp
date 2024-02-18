<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  브랜드스트리트메인
' History : 2013.09.13 김진영 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/street/BrandStreetCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<%
Dim charcd, lang, cdl, scTxt
Dim page, ctab
page = requestcheckvar(request("page"),2)
ctab = requestcheckvar(request("ctab"),5)

if page = "" Then page = 1

charcd = requestcheckvar(Request("charcd"),4)
charcd	= unescape(charcd)

lang	= requestcheckvar(Request("lang"),4)
cdl		= requestcheckvar(Request("cdl"),4)

scTxt	= requestCheckVar(request("scTxt"),50)
scTxt	= unescape(scTxt)

If scTxt <> "" Then
	If (Asc(scTxt) >= 65 AND Asc(scTxt) <= 90) OR (Asc(scTxt) >= 97 AND Asc(scTxt) <= 122) Then
		Lang = ""
	Else
		Lang = "K"
	End IF
	charcd = ""
End If
%>
<script type="text/javascript">
$(function() {
	// Brand search
	$('.findWord li').click(function(){
		$('.findWord li').removeClass('current');
		$(this).addClass('current');
	});

	$('.brandschList .brdGroup:nth-child(odd)').css('background','#fafafa');
});
function trim(str) {
	return str.replace(/^\s\s*/,"").replace(/\s\s*$/,"");
}
function SearchModm(charcd, langs, cdl, txtYN, paraTxt) {
	var scTxt = "";
	if(txtYN == "Y"){
		if(trim(document.brsearchfrm.brname.value) == ""){
			alert('검색하고자 하는 단어를 입력해주세요');
			document.brsearchfrm.brname.value = "";
			document.brsearchfrm.brname.focus();
			return;
		}else{
			scTxt = document.brsearchfrm.brname.value;
		}
	}

	if(paraTxt != ""){
		scTxt = paraTxt
	}

	$("#brdlist").empty();
	var str = $.ajax({
		type: "POST",
		url: "/street/act_streetSearch.asp",
		data: "charcd="+escape(charcd)+"&lang="+langs+"&cdl="+cdl+"&scTxt="+escape(scTxt),
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
		$("#brdlist").html(str);
	}
}

function SearchModrecmd(ctab, langs, cdl, txtYN, paraTxt, page) {
	var scTxt = "";
	if(txtYN == "Y"){
		if(trim(document.brsearchfrm.brname.value) == ""){
			alert('검색하고자 하는 단어를 입력해주세요');
			document.brsearchfrm.brname.value = "";
			document.brsearchfrm.brname.focus();
			return;
		}else{
			scTxt = document.brsearchfrm.brname.value;
		}
	}

	if(paraTxt != ""){
		scTxt = paraTxt
	}

	$("#brdlist").empty();
	var str = $.ajax({
		type: "POST",
		url: "/street/act_recommendSearch.asp",
		data: "ctab="+ctab+"&lang="+langs+"&cdl="+cdl+"&scTxt="+escape(scTxt)+"&page="+page,
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
		$("#brdlist").html(str);
	}
}
</script>
<div class="schHeader">
	<h3><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_brand_search.gif" alt="INTERVIEW"/></h3>
	<dl class="brandTag">
	<%
		Dim fso, oFile, vTag, vTmp, j
		Set fso = CreateObject("Scripting.FileSystemObject")
		If (fso.FileExists(server.mappath("/chtml/street/")&"\taglist.txt")) Then
			Set oFile = Server.CreateObject("ADODB.Stream")
				oFile.CharSet = "UTF-8"
				oFile.Open
				oFile.LoadFromFile(server.mappath("/chtml/street/")&"\taglist.txt")
				vTag = oFile.ReadText()
			Set oFile = nothing
		End If
		Set fso = nothing

		If UBound(Split(vTag,"|")) > 0 Then
	%>
		<dt># BRAND TAG</dt>
	<%
		End If
	%>
		<dd>
			<ul>
	<%
		On Error Resume Next
		For j = 0 To UBound(Split(vTag,"|"))
			vTmp = vTmp & "<li style='cursor:pointer;' onclick=javascript:SearchModm('','','','','"&Trim(Split(vTag,"|")(j))&"');>" & Trim(Split(vTag,"|")(j)) & "</li>"
		Next
		vTmp = Trim(vTmp)
		vTmp = Left(vTmp,Len(vTmp)-1)
		Response.Write vTmp
		On Error Goto 0
	%>
			</ul>
		</dd>
	</dl>
	<div class="schWrap">
		<form name="brsearchfrm" action="javascript:SearchModm('','','','Y','');" method="post">
		<div class="schBox">
			<input type="text" name="brname" class="hdschInput" value="<%=scTxt%>" title="검색하고자 하는 단어를 입력해주세요." style="width:182px">
			<input type="submit" value="" class="hdSchBtn">
		</div>
		</form>
	</div>
</div>
<div>
	<ul class="brandCate">
		<li style="cursor:pointer;" class="<%= chkiif(cdl="","current","")%>"     onclick="SearchModm('<%=charcd%>', '<%=Lang%>', '', '',  '<%=scTxt%>');">전체</li>
		<%=fnBrandStreetCategoryHeaderAct(cdl,"SearchModm",charcd,Lang,scTxt)%>
	</ul>
	<ul>
		<li style="border-bottom:1px solid #ddd;"></li>
	</ul>
<%
	''상단 ul은 카테고리 풀라고하면 삭제해야됨
	Dim oStreet
	Dim i, char1, char2 , chrCd
	Call convertChar(Lang, charcd, char1, char2)

	Set oStreet = New CStreet
		oStreet.FRectchar1 = char1
		oStreet.FRectchar2 = char2
		oStreet.FRectchrCd = charcd
		oStreet.FRectLang = Lang
		oStreet.FBrandName = scTxt
		oStreet.FRectCDL = cdl
	
	'//한글
	If Lang = "K" Then
		oStreet.GetBrandStreetList_k
	'//영어
	Else
		oStreet.GetBrandStreetList_E
	End If
%>
	<div class="findWord">
		<dl>
			<dt><span class="crRed">가나다순</span> 찾기</dt>
			<dd>
				<ol>
					<li <%= chkiif(charcd="가","class='current'","")%> onclick="SearchModm('가', 'K', '', '', '');">가</li>
					<li <%= chkiif(charcd="나","class='current'","")%> onclick="SearchModm('나', 'K', '', '', '');">나</li>
					<li <%= chkiif(charcd="다","class='current'","")%> onclick="SearchModm('다', 'K', '', '', '');">다</li>
					<li <%= chkiif(charcd="라","class='current'","")%> onclick="SearchModm('라', 'K', '', '', '');">라</li>
					<li <%= chkiif(charcd="마","class='current'","")%> onclick="SearchModm('마', 'K', '', '', '');">마</li>
					<li <%= chkiif(charcd="바","class='current'","")%> onclick="SearchModm('바', 'K', '', '', '');">바</li>
					<li <%= chkiif(charcd="사","class='current'","")%> onclick="SearchModm('사', 'K', '', '', '');">사</li>
					<li <%= chkiif(charcd="아","class='current'","")%> onclick="SearchModm('아', 'K', '', '', '');">아</li>
					<li <%= chkiif(charcd="자","class='current'","")%> onclick="SearchModm('자', 'K', '', '', '');">자</li>
					<li <%= chkiif(charcd="차","class='current'","")%> onclick="SearchModm('차', 'K', '', '', '');">차</li>
					<li <%= chkiif(charcd="카","class='current'","")%> onclick="SearchModm('카', 'K', '', '', '');">카</li>
					<li <%= chkiif(charcd="타","class='current'","")%> onclick="SearchModm('타', 'K', '', '', '');">타</li>
					<li <%= chkiif(charcd="파","class='current'","")%> onclick="SearchModm('파', 'K', '', '', '');">파</li>
					<li <%= chkiif(charcd="하","class='current'","")%> onclick="SearchModm('하', 'K', '', '', '');">하</li>
				</ol>
			</dd>
		</dl>
		<dl>
			<dt><span class="crRed">알파벳순</span> 찾기</dt>
			<dd>
				<ol>
					<li <%= chkiif(charcd="A","class='current'","")%> onclick="SearchModm('A', 'E', '', '', '');">A</li>
					<li <%= chkiif(charcd="B","class='current'","")%> onclick="SearchModm('B', 'E', '', '', '');">B</li>
					<li <%= chkiif(charcd="C","class='current'","")%> onclick="SearchModm('C', 'E', '', '', '');">C</li>
					<li <%= chkiif(charcd="D","class='current'","")%> onclick="SearchModm('D', 'E', '', '', '');">D</li>
					<li <%= chkiif(charcd="E","class='current'","")%> onclick="SearchModm('E', 'E', '', '', '');">E</li>
					<li <%= chkiif(charcd="F","class='current'","")%> onclick="SearchModm('F', 'E', '', '', '');">F</li>
					<li <%= chkiif(charcd="G","class='current'","")%> onclick="SearchModm('G', 'E', '', '', '');">G</li>
					<li <%= chkiif(charcd="H","class='current'","")%> onclick="SearchModm('H', 'E', '', '', '');">H</li>
					<li <%= chkiif(charcd="I","class='current'","")%> onclick="SearchModm('I', 'E', '', '', '');">I</li>
					<li <%= chkiif(charcd="J","class='current'","")%> onclick="SearchModm('J', 'E', '', '', '');">J</li>
					<li <%= chkiif(charcd="K","class='current'","")%> onclick="SearchModm('K', 'E', '', '', '');">K</li>
					<li <%= chkiif(charcd="L","class='current'","")%> onclick="SearchModm('L', 'E', '', '', '');">L</li>
					<li <%= chkiif(charcd="M","class='current'","")%> onclick="SearchModm('M', 'E', '', '', '');">M</li>
					<li <%= chkiif(charcd="N","class='current'","")%> onclick="SearchModm('N', 'E', '', '', '');">N</li>
					<li <%= chkiif(charcd="O","class='current'","")%> onclick="SearchModm('O', 'E', '', '', '');">O</li>
					<li <%= chkiif(charcd="P","class='current'","")%> onclick="SearchModm('P', 'E', '', '', '');">P</li>
					<li <%= chkiif(charcd="Q","class='current'","")%> onclick="SearchModm('Q', 'E', '', '', '');">Q</li>
					<li <%= chkiif(charcd="R","class='current'","")%> onclick="SearchModm('R', 'E', '', '', '');">R</li>
					<li <%= chkiif(charcd="S","class='current'","")%> onclick="SearchModm('S', 'E', '', '', '');">S</li>
					<li <%= chkiif(charcd="T","class='current'","")%> onclick="SearchModm('T', 'E', '', '', '');">T</li>
					<li <%= chkiif(charcd="U","class='current'","")%> onclick="SearchModm('U', 'E', '', '', '');">U</li>
					<li <%= chkiif(charcd="V","class='current'","")%> onclick="SearchModm('V', 'E', '', '', '');">V</li>
					<li <%= chkiif(charcd="W","class='current'","")%> onclick="SearchModm('W', 'E', '', '', '');">W</li>
					<li <%= chkiif(charcd="X","class='current'","")%> onclick="SearchModm('X', 'E', '', '', '');">X</li>
					<li <%= chkiif(charcd="Y","class='current'","")%> onclick="SearchModm('Y', 'E', '', '', '');">Y</li>
					<li <%= chkiif(charcd="Z","class='current'","")%> onclick="SearchModm('Z', 'E', '', '', '');">Z</li>
					<li <%= chkiif(charcd="Σ","class='current'","")%> onclick="SearchModm('Σ', 'E', '', '', '');">etc</li>
				</ol>
			</dd>
		</dl>

		<dl class="recommend">
			<dt><span class="crRed">추천순</span> 찾기</dt>
			<dd>
				<ul>
					<li class="new"><span <%=chkiif(ctab="ctab1","class='current'","")%> onclick="SearchModrecmd('ctab1', '', '', '', '','');">NEW</span></li>
					<li class="best"><span <%=chkiif(ctab="ctab3","class='current'","")%> onclick="SearchModrecmd('ctab3', '', '', '', '','');">BEST</span></li>
					<li class="zzim"><span <%=chkiif(ctab="ctab2","class='current'","")%> onclick="SearchModrecmd('ctab2', '', '', '', '','');">ZZIM</span></li>
					<li class="artist"><span <%=chkiif(ctab="ctab5","class='current'","")%> onclick="SearchModrecmd('ctab5', '', '', '', '','');">ARTIST</span></li>
					<li class="lookbook"><span <%=chkiif(ctab="ctab7","class='current'","")%> onclick="SearchModrecmd('ctab7', '', '', '', '','');">LOOKBOOK</span></li>
					<li class="interview"><span <%=chkiif(ctab="ctab8","class='current'","")%> onclick="SearchModrecmd('ctab8', '', '', '', '','');">INTERVIEW</span></li>
				</ul>
			</dd>
		</dl>

	</div>
<%
'	Dim oaward, b
'	set oaward = new CAWard
'		oaward.FPageSize = 5
'		oaward.FDisp1 = ""
'		oaward.FRectAwardgubun = "b"
'		oaward.GetBrandAwardList
'	If oaward.FResultCount > 0 Then
%>
	<!-- <dl class="schBestBrand">
		<dt>BEST BRAND</dt>
		<dd>
			<ul>
			<%' For b = 0 to oaward.FResultCount-1 %>
				<li><em></em><a href="/street/street_brand_sub01.asp?makerid=<%'= oaward.FItemList(b).FMakerid %>"><strong><%'= oaward.FItemList(b).FSocname %></strong><br /><%'= oaward.FItemList(b).FSocname_kor %></a></li>
			<%' Next %>
			</ul>
		</dd>
	</dl> -->
<%
	'Else
%>
	<!-- <dl><dd><ul><li style="border-bottom:1px solid #ddd;"></li></ul></dd></dl> -->
<%
	'End If
	'Set oaward = nothing
%>
	<div class="brandschList">
<%
	Dim vChkBG, vFirstChar, grpNo, lp
	vChkBG = 1
	vFirstChar = 0
	Dim slp: slp=0
	If oStreet.ftotalcount > 0 Then
		grpNo = getInitial2Num(oStreet.FItemList(0).Fdiv)
		If scTxt = "" Then
%>
		<div class="brdGroup">
			<p class="word"><img src="http://fiximage.10x10.co.kr/web2013/brand/txt_<%=chkiif(lang="K","kor","eng")%><%= Chkiif(grpNo < 10, "0"&grpNo, grpNo) %>.png" class="pngFix" alt="<%=Lang%>"/></p>
			<ul>
<%
			For i = 0 to oStreet.FTotalCount-1
%>
				<li><a href="/street/street_brand_sub06.asp?makerid=<%= oStreet.FItemList(i).FMakerid %>" target="_blank"><%= Chkiif(lang="K" ,oStreet.FItemList(i).FSocname_kor, oStreet.FItemList(i).FSocname)  %></a></li>
<%	
				If (slp mod 40)=39 Then
					response.write "</ul></div><div class='brdGroup'><ul>"
				End If
	
				slp = slp + 1
			Next
			Set oStreet = nothing
%>
			</ul>
		</div>
<%
		Else
%>
		<div class="brdGroup">
			<p class="word"><img src="http://fiximage.10x10.co.kr/web2013/brand/txt_<%=chkiif(lang="K","kor","eng")%><%= Chkiif(grpNo < 10, "0"&grpNo, grpNo) %>.png" class="pngFix" alt="<%=Lang%>"/></p>
			<ul>
<%
			For lp=0 to oStreet.ftotalcount-1
				If grpNo<>getInitial2Num(oStreet.FItemList(lp).Fdiv) Then
					grpNo = getInitial2Num(oStreet.FItemList(lp).Fdiv)
					slp = 0
%>
			</ul>
		</div>
		<div class="brdGroup">
			<p class="word"><img src="http://fiximage.10x10.co.kr/web2013/brand/txt_<%=chkiif(lang="K","kor","eng")%><%= Chkiif(grpNo < 10, "0"&grpNo, grpNo) %>.png" class="pngFix" alt="<%=Lang%>"/></p>
			<ul>
<%
				End If
%>
				<li><a href="/street/street_brand_sub06.asp?makerid=<%= oStreet.FItemList(lp).FMakerid %>" target="_blank"><%= Chkiif(lang="K" ,oStreet.FItemList(lp).FSocname_kor, oStreet.FItemList(lp).FSocname) %></a></li>
<%	
				If (slp mod 40)=39 Then
					response.write "</ul></div><div class='brdGroup'><ul>"
				End If
				slp = slp + 1
			Next
			Set oStreet = nothing
		End If
	Else
%>
	<div align="center" class="brdGroup">
		<dd>해당되는 브랜드가 없습니다.</dd>
	</div>
<% End If %>
	</div>
</div>