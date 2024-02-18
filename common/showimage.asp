<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim img
img=request("img")
%>
<HTML>
<HEAD>
<TITLE>이미지를 클릭하시면 창이 닫힙니다.</TITLE>
<script language="javascript">
	function win_resize(x,y)
	{
		x = x + 37;
		y = y + 92;
		max_x = screen.width - 50;
		max_y = screen.height - 1;

		if(x>max_x){
			x = max_x;
		}
		if(y>max_y){
			y = max_y;
			document.all.divimg.style.height = y;
		}
		window.resizeTo(x,y);

	}
</script>
</HEAD>
<BODY style="margin:0" onload="javascript:win_resize(main_img.width,main_img.height);">
<div id="divimg" style="overflow-y:auto; width:100%;">
<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
<tr>
	<td align="center">
		<img src="<%= img %>" name="main_img" id="main_img" border="0" onclick="window.close()" style="cursor:pointer;" alt="클릭하시면 현재 창이 닫힙니다." align="absmiddle">
	</td>
</tR>
</table>
</div>
</BODY>
</HTML>
