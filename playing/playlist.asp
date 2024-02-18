<%
Dim cCa1list, vCa1Directer, vCa1Type, vCa1VideoURL, vCa1ComTitle, vCa1Coment1, vCa1Coment2, vCa1Coment3, vCa1PreComm1, vCa1PreComm2, vCa1PreComm3
Dim vCate1VideoOrigin, vCate1RewardCopy
SET cCa1list = New CPlay
cCa1list.FRectDIdx = vDIdx
cCa1list.sbPlayPlaylistDetail

vCa1Directer 	= cCa1list.FOneItem.Fdirecter
vCa1Type		= cCa1list.FOneItem.Ftype
vCa1VideoURL	= cCa1list.FOneItem.Fvideourl
vCa1ComTitle	= cCa1list.FOneItem.Fcomm_title
vCa1Coment1	= cCa1list.FOneItem.Fcomment1
vCa1Coment2	= cCa1list.FOneItem.Fcomment2
vCa1Coment3	= cCa1list.FOneItem.Fcomment3
vCa1PreComm1	= cCa1list.FOneItem.FCate1precomm1
vCa1PreComm2	= cCa1list.FOneItem.FCate1precomm2
vCa1PreComm3	= cCa1list.FOneItem.FCate1precomm3
vCate1VideoOrigin = cCa1list.FOneItem.FCate1VideoOrigin
vCate1RewardCopy = cCa1list.FOneItem.FCate1RewardCopy
SET cCa1list = Nothing
%>
<div class="article playDetailV16 playlist">
	<div class="cont">
		<div class="detail" style="background-color:#<%=vBGColor%>;">
			<div class="topic">
				<div class="hgroup">
					<!--<a href="list.asp?cate=1" class="corner">PLAYLIST♬</a>//-->
					TALK
					<h2><%=vTitleStyle%></h2>
					<div class="textarea">
						<p>
							<%=vSubCopy%>
						</p>
						<div class="by"><%=vCa1Directer%></div>
					</div>
				</div>
				<div class="player">
				<% If vCa1Type = "1" Then %>
					<div class="video">
						<iframe src="<%=vCa1VideoURL%>" width="630" height="374" frameborder="0" title="playlist video" allowfullscreen></iframe>
						<% If vCate1VideoOrigin <> "" Then %><p class="copyright"><%=vCate1VideoOrigin%></p><% End If %>
					</div>
				<% ElseIf vCa1Type = "2" Then %>
					<div class="poster">
						<img src="<%=fnPlayImageSelect(vImageList,vCate,"2","i")%>" alt="" />
					</div>
				<% End If %>
				</div>
			</div>
			<div class="form" style="background-color:#<%=vBGColor%>;">
				<div class="desc">
					<h3><%=vCa1ComTitle%></h3>
					<% If vCate1RewardCopy <> "" Then %>
						<p><%=vCate1RewardCopy%></p>
						<p class="date">응모기간 : <%=Right(FormatDate(vTagSDate,"0000.00.00"),5)%> ~ <%=Right(FormatDate(vTagEDate,"0000.00.00"),5)%>  |  발표 : <%=Right(FormatDate(vTagAnnounce,"0000.00.00"),5)%></p>
					<% End If %>
				</div>
				<div class="field">
					<form name="frm1" method="post" action="playlist_proc.asp" onSubmit="return chkfrm1(this);">
					<input type="hidden" name="didx" value="<%=vDidx%>">
						<fieldset>
						<legend class="hidden">추천 노래 작성 폼</legend>
							<div class="texarea">
								<div class="grouping">
									<span># <%=vCa1PreComm1%></span>
									<input type="text" name="comment1" value="" maxlength="15" title="입력1" <%=CHKIIF(IsUserLoginOK(),"","onclick='chkfrm1(this)'")%> />
									<span><%=vCa1Coment1%></span>
								</div>
								<div class="grouping">
									<span># <%=vCa1PreComm2%></span>
									<input type="text" name="comment2" value="" maxlength="15" title="입력2" <%=CHKIIF(IsUserLoginOK(),"","onclick='chkfrm1(this)'")%> />
									<span><%=vCa1Coment2%></span>
								</div>
								<% If vCa1Coment3 <> "" Then %>
								<div class="grouping">
									<span># <%=vCa1PreComm3%></span>
									<input type="text" name="comment3" value="" maxlength="15" title="입력3" <%=CHKIIF(IsUserLoginOK(),"","onclick='chkfrm1(this)'")%> />
									<span><%=vCa1Coment3%></span>
								</div>
								<% End If %>
							</div>
							<div class="btnSubmit"><input type="submit" value="추천하기" /></div>
						</fieldset>
					</form>
				</div>
			</div>
			<!-- #include file="./playlist_comment.asp" -->
		</div>
	</div>
	<% If fnPlayImageSelect(vImageList,vCate,"3","i") <> "" Then %>
	<div class="bnr">
		<a href="<%=fnPlayImageSelect(vImageList,vCate,"3","l")%>"><img src="<%=fnPlayImageSelect(vImageList,vCate,"3","i")%>" alt="" /></a>
	</div>
	<% End If %>
	<!-- #include file="./inc_sns.asp" -->
	<div class="listMore">
		<div class="more">
			<h2>다른 TALK 보기</h2>
			<a href="list.asp?cate=talk">more</a>
		</div>
		<!-- #include file="./inc_listmore.asp" -->
	</div>
</div>
<script>
function chkfrm1(f){
<% If IsUserLoginOK() Then %>
	if(f.comment1.value == ""){
		alert("'#<%=vCa1PreComm1%>' (을)를 입력해주세요!");
		f.comment1.focus();
		return false;
	}
	if(f.comment2.value == ""){
		alert("'#<%=vCa1PreComm2%>' (을)를 입력해주세요!");
		f.comment2.focus();
		return false;
	}
	<% If vCa1Coment3 <> "" Then %>
	if(f.comment3.value == ""){
		alert("'#<%=vCa1PreComm3%>' (을)를 입력해주세요!");
		f.comment3.focus();
		return false;
	}
	<% End If %>
	return true;
<% Else %>
	if(confirm("로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx&"")%>';
		return false;
	}
	return false;
<% End If %>
}
</script>