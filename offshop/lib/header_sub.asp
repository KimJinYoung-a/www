<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	If shopid = "streetshop091" Then	'CAFE1010
%>
		<tr>
			<td width="120" height="53"></td>
			<td align="right" valign="bottom">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><a href="/offshop/shopinfo.asp?shopid=<%=shopid%>&tabidx=1" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_rmenu01<% If vTab = "1" Then %>_on<% End If %>.gif" ></a></td>
					<td><a href="/offshop/shopnotice.asp?shopid=<%=shopid%>&tabidx=2" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_rmenu02<% If vTab = "2" Then %>_on<% End If %>.gif" ></a></td>
					<td><a href="/offshop/shopqna.asp?shopid=<%=shopid%>&tabidx=3" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_rmenu03<% If vTab = "3" Then %>_on<% End If %>.gif" ></a></td>
					<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_rmenu04<% If vTab = "4" Then %>_on<% End If %>.gif" ></td>
					<!--
					<td><a href="/offshop/shopmenu.asp?shopid=<%=shopid%>&tabidx=5" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub04_rmenu05<% If vTab = "5" Then %>_on<% End If %>.gif" ></a></td>
					//-->
				</tr>
				</table>
			</td>
		</tr>
<%
	ElseIf shopid = "cafe002" Then	'취화선
%>
		<tr>
			<td width="120" height="53"></td>
			<td align="right" valign="bottom">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><a href="/offshop/shopinfo.asp?shopid=<%=shopid%>&tabidx=1" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub03_rmenu01<% If vTab = "1" Then %>_on<% End If %>.gif" ></a></td>
					<td><a href="/offshop/shopnotice.asp?shopid=<%=shopid%>&tabidx=2" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub03_rmenu02<% If vTab = "2" Then %>_on<% End If %>.gif" ></a></td>
					<td><a href="/offshop/shopqna.asp?shopid=<%=shopid%>&tabidx=3" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub03_rmenu03<% If vTab = "3" Then %>_on<% End If %>.gif" ></a></td>
					<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub03_rmenu04<% If vTab = "4" Then %>_on<% End If %>.gif" ></td>
					<td><a href="/offshop/shopmenu.asp?shopid=<%=shopid%>&tabidx=5" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub03_rmenu05<% If vTab = "5" Then %>_on<% End If %>.gif" ></a></td>
				</tr>
				</table>
			</td>
		</tr>
<%
	Else
%>
		<tr>
			<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_<%=Num2Str(shopSn,2,"0","R")%>01_title.gif" ></td>
			<td align="right" valign="bottom">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><a href="/offshop/shopinfo.asp?shopid=<%=shopid%>&tabidx=1" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_rmenu01<% If vTab = "1" Then %>_on<% End If %>.gif" ></a></td>
					<td><a href="/offshop/shopnotice.asp?shopid=<%=shopid%>&tabidx=2" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_rmenu02<% If vTab = "2" Then %>_on<% End If %>.gif" ></a></td>
					<td><a href="/offshop/shopqna.asp?shopid=<%=shopid%>&tabidx=3" onFocus="blur()"><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_rmenu03<% If vTab = "3" Then %>_on<% End If %>.gif" ></a></td>
					<td><img src="http://fiximage.10x10.co.kr/tenbytenshop/sub01_rmenu04<% If vTab = "4" Then %>_on<% End If %>.gif" ></td>
				</tr>
				</table>
			</td>
		</tr>
<%
	End If
%>
</table>