<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""
'#############################################
' 그림일기 ajax - 이종화
' 2013-09-09 
'#############################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<%
	Dim idx : idx = getNumeric(requestCheckVar(request("idx"),8))
	Dim viewno : viewno = getNumeric(requestCheckVar(request("viewno"),8))
	Dim oPictureDiary
	Dim i 
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	Dim playcode : playcode = 5 '메뉴상단 번호를 지정 해주세요
	dim loginuserid : loginuserid = requestCheckVar(request("uid"),30)

	set oPictureDiary = new CPlayContents
		oPictureDiary.FRectviewno = viewno
		oPictureDiary.FRectIdx = idx
		oPictureDiary.Fplaycode = playcode
		oPictureDiary.Fuserid = loginuserid
		oPictureDiary.GetOneRowContent()
		oPictureDiary.GetRowTagContent()

		snpTitle = Server.URLEncode("#"&oPictureDiary.FOneItem.Fviewno&" "&oPictureDiary.FOneItem.Fviewtitle)
		snpLink = Server.URLEncode("http://10x10.co.kr/play/playPicDiary.asp?idx=" & idx&"&viewno="& viewno &"")
		snpPre = Server.URLEncode("텐바이텐 그림일기")
		snpTag = Server.URLEncode("텐바이텐 " & Replace("#"&oPictureDiary.FOneItem.Fviewno&" "&oPictureDiary.FOneItem.Fviewtitle," ",""))
		snpTag2 = Server.URLEncode("#10x10")
		snpImg = Server.URLEncode(oPictureDiary.FOneItem.Fviewimg)
%>
<div class="swiper-slide">
	<div style="display:none" id="prevval" rel="<%=oPictureDiary.FOneItem.Fminidx%>" rel2="<%=oPictureDiary.FOneItem.Fminno%>"></div><div style="display:none" id="nextval" rel="<%=oPictureDiary.FOneItem.Fmaxidx%>" rel2="<%=oPictureDiary.FOneItem.Fmaxno%>"></div>
	<p class="dairyPic"><img src="<%=oPictureDiary.FOneItem.Fviewimg%>" alt="#<%=oPictureDiary.FOneItem.Fviewno%> <%=oPictureDiary.FOneItem.Fviewtitle%>" /></p>
	<div class="diaryWrap">
		<dl class="diary">
			<dt>
				<p>#<%=oPictureDiary.FOneItem.Fviewno%></p>
				<p class="tPad15"><%=oPictureDiary.FOneItem.Fviewtitle%></p>
			</dt>
			<dd class="diaryView">
				<%=nl2br(oPictureDiary.FOneItem.Fviewtext)%>
			</dd>
			<dd class="diaryDate"><%=FormatDate(oPictureDiary.FOneItem.Freservationdate,"0000.00.00")%></dd>
		</dl>

		<div class="diaryShare">
			<dl class="tagView tMar50">
				<dt>Tag</dt>
				<dd>
					<ul>
					<% If oPictureDiary.FTotalCount > 0 Then %>
						<% For i = 0 To oPictureDiary.FTotalCount -1 %>
						<li><span><a href="<%=chkiif(oPictureDiary.FItemList(i).Ftagurl="","/search/search_result.asp?rect="&oPictureDiary.FItemList(i).Ftagname&"",oPictureDiary.FItemList(i).Ftagurl)%>"><%=oPictureDiary.FItemList(i).Ftagname%></a></span></li>
						<% Next %>
					<% End If %>
					</ul>
				</dd>
			</dl>
			<div class="snsArea tPad40">
				<div class="sns">
					<ul>
						<!-- <li><a href="" onClick="popSNSPost('m2','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li> -->
						<li><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
						<li><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
						<li><a href="" onClick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
					</ul>
					<div id="mywish<%=oPictureDiary.FOneItem.Fidx%>" class="favoriteAct <%=chkiif(oPictureDiary.FOneItem.Fchkfav > 0 ,"myFavor","")%>" <% If loginuserid <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oPictureDiary.FOneItem.Fidx %>','<%= oPictureDiary.FOneItem.Fviewno %>');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oPictureDiary.FOneItem.Ffavcnt,0) %></strong></div>
				</div>
			</div>
		</div>
	</div>
	<div id="tempdiv" style="display:none" ></div>
</div>
<%
	Set oPictureDiary = Nothing 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->