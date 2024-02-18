<%
	Dim vTab, vInfoPage
	vTab = requestCheckVar(Request("tabidx"),1)
	If vTab = "" Then
		vTab = "1"
		IF Request.ServerVariables("PATH_INFO") = "/offshop/shopqna.asp" OR Request.ServerVariables("PATH_INFO") = "/offshop/shopqna_write.asp" Then
			vTab = "3"
		End IF
		IF Request.ServerVariables("PATH_INFO") = "/offshop/shopnotice.asp" OR Request.ServerVariables("PATH_INFO") = "/offshop/shopnotice_view.asp" Then
			vTab = "2"
		End IF
	End If

	'Tab번호에 따른 PageURL 지정
	Select Case vTab
		Case "1"
			vInfoPage = "/offshop/shopinfo.asp"
		Case "2"
			vInfoPage = "/offshop/shopnotice.asp"
		Case "3"
			vInfoPage = "/offshop/shopqna.asp"
		Case "4"
			vInfoPage = "/offshop/shopgallery.asp"
		Case "5"
			vInfoPage = "/offshop/shopmenu.asp"
		Case "6"
			vInfoPage = "/offshop/sub01.asp"
	End Select
%>
<table width="140" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td height="349" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<%
			If shopid = "streetshop091" Then	'CAFE1010
		%>
			<tr>
				<td height="349" valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_title.gif" width="140" height="42"></td>
					</tr>
					<tr>
						<td style="padding-top:29px;"><a href="http://blog.naver.com/1010cafe" onFocus="blur()" target="_blank"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_bnblog.gif" width="140" height="102"></a></td>
					</tr>
					<tr>
						<td style="padding:29 0 0 0;"><a href="http://twitter.com/@cafe10x10" target="_blank"><img src="http://fiximage.10x10.co.kr/tenbytenshop/tw_cafe1010.gif"></a></td>
					</tr>
					</table>
				</td>
			</tr>
		<%
			ElseIf shopid = "cafe002" Then	'취화선
		%>
			<tr>
				<td height="349" valign="top"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub03_title.gif" width="140" height="192"></td>
			</tr>
		<%
			Else
		%>
			<tr>
				<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_title.gif" width="140" height="38"></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6; padding-top:25px;"><a href="<%=vInfoPage%>?shopid=streetshop011&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu01<% if shopSn=1 then Response.Write "_on"%>.gif" ></a></td>
			</tr>
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop014&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu07<% if shopSn=9 then Response.Write "_on"%>.gif" ></a></td>
			</tr>-->
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%'=vInfoPage%>?shopid=streetshop015&tabidx=<%'=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu10<%' if shopSn=10 then Response.Write "_on"%>.gif" ></a></td>
			</tr>-->
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop012&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu02<% if shopSn=2 then Response.Write "_on"%>.gif" ></a></td>
			</tr>-->
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%'=vInfoPage%>?shopid=streetshop016&tabidx=<%'=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu11<%' if shopSn=11 then Response.Write "_on"%>.gif" ></a></td>
			</tr>//-->
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop018&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu12<% if shopSn=12 then Response.Write "_on"%>.gif" ></a></td>
			</tr>-->
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%'=vInfoPage%>?shopid=streetshop019&tabidx=<%'=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu14<%' if shopSn=14 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>-->
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop803&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu03<% if shopSn=3 then Response.Write "_on"%>.gif" ></a></td>
			</tr>-->
			<!--
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop807&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu04<% if shopSn=4 then Response.Write "_on"%>.gif" ></a></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop801&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu05<% if shopSn=5 then Response.Write "_on"%>.gif" ></a></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop808&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu06<% if shopSn=6 then Response.Write "_on"%>.gif" ></a></td>
			</tr>
			//-->
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop020&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu17<% if shopSn=17 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			<!--<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop022&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu18<% if shopSn=18 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>-->
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop023&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu19<% if shopSn=19 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop024&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu20<% if shopSn=20 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop026&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu21<% if shopSn=21 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			<!--
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop025&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu22<% if shopSn=22 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			-->
			<!-- 가맹점 시작 -->
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop809&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu13<% if shopSn=13 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			<!--<tr>-->
				<!--<td style="padding:12 0 0 0;"><a href="http://twitter.com/@10x10store" target="_blank"><img src="http://fiximage.10x10.co.kr/tenbytenshop/tw_1010store.gif"></a></td>-->
                <!--<td style="padding:12 0 0 0;"><a href="/offshop/sub01.asp?shopid=streetshop011" onFocus="blur()" target="_blank"><img src="http://fiximage.10x10.co.kr/web2012/offshop/join_store_btn.gif" width="140" height="34"></a></td>-->
			<!--</tr>-->
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop810&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu15<% if shopSn=15 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #e6e6e6;"><a href="<%=vInfoPage%>?shopid=streetshop811&tabidx=<%=vTab%>" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_menu16<% if shopSn=16 then Response.Write "_on"%>.gif" width="140" height="25"></a></td>
			</tr>
		<%
			End If
		%>
		</table>
	</td>
</tr>
<tr>
	<td align="center" height="120">
		<!--포인트1010 배너, 메뉴-->
		<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td><a href="/offshop/point/card_service.asp"><img src="http://fiximage.10x10.co.kr/web2017/membercard/bnr_memcard.png"></td></a>
		</tr>
		</table>
		<!-- <map name="Map">
			<area shape="rect" coords="7,94,68,114" href="/offshop/point/card_reg.asp" onFocus="blur()">
			<% If GetLoginUserID() = "" Then %>
			<area shape="rect" coords="71,93,130,114" href="javascript:goPointLogin();" onFocus="blur()">
			<% Else %>
			<area shape="rect" coords="71,93,130,114" href="/offshop/point/point_switch.asp" onFocus="blur()">
			<% End If %>
			<area shape="rect" coords="5,3,134,90" href="/offshop/point/card_service.asp" onFocus="blur()">
		</map> -->
	</td>
</tr>
<tr>
	<td height="100" valign="top"><div style="display:none; position:absolute; width:200px; height:200px; margin-left:-69px; margin-top:12px;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/object_left.png" class="png24"></div></td>
</tr>
</table>
<script language="javascript">
function goPointLogin()
{
	alert('로그인을 하세요.');
	location.href='/offshop/point/point_login.asp?reurl=/offshop/point/point_switch.asp';
}
</script>