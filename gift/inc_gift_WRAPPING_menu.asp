<%
'###########################################################
' Description :  기프트
' History : 2015.02.09 한용민 생성
'###########################################################
%>
<div class="hgroup wrapping">
	<h3><img src="http://fiximage.10x10.co.kr/web2013/gift/tit_wrapping.png" alt="WRAPPING" /></h3>
	<p><span></span>선물의 감동을 더해줄 특별한 아이템</p>
</div>
<ul class="sidebar">
	<!-- for dev msg : 선택한 곳에 클래스명 on 붙여주세요. -->
	<li class="nav1"><a href="" onclick="fnChgPackDiv(1); return false;" <%=chkIIF(vPackIdx=1,"class='on'","")%>>플라워</a></li>
	<li class="nav2"><a href="" onclick="fnChgPackDiv(2); return false;" <%=chkIIF(vPackIdx=2,"class='on'","")%>>카드</a></li>
	<li class="nav3"><a href="" onclick="fnChgPackDiv(3); return false;" <%=chkIIF(vPackIdx=3,"class='on'","")%>>포장지</a></li>
	<li class="nav4"><a href="" onclick="fnChgPackDiv(4); return false;" <%=chkIIF(vPackIdx=4,"class='on'","")%>>선물상자</a></li>
	<li class="nav5"><a href="" onclick="fnChgPackDiv(5); return false;" <%=chkIIF(vPackIdx=5,"class='on'","")%>>리본</a></li>
	<li class="nav6"><a href="" onclick="fnChgPackDiv(6); return false;" <%=chkIIF(vPackIdx=6,"class='on'","")%>>악세사리</a></li>
</ul>
