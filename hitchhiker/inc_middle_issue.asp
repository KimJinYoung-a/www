<%
'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.06 유태욱 생성
'#############################################################
%>
<%
Dim oissue
set oissue = new CHitchhikerlist
	oissue.Frectisusing = "Y"
	oissue.FrectCurrentpreview = "Y"
	oissue.fnGetissue
	'//최근 오픈 인것이 없으면, 종료된것중 최근것을 가져옴
	if oissue.ftotalcount < 1 then
		set oissue = new CHitchhikerlist
			oissue.Frectisusing = "Y"
			oissue.FrectCurrentpreview = ""
			oissue.fnGetissue
	end if
%>
<div class="part">
<% if oissue.FOneItem.Freqgubun = "1" then %>
	<p><img src="<%=oissue.FOneItem.Freqissueimg%>" alt="징크스 여러분의 징크스는 무엇인가요?" usemap="#hitchhikerissue" /></p>
	<%=oissue.FOneItem.Freqimghtmltext%>
<% elseif oissue.FOneItem.Freqgubun = "2" then %>
	<p><img src="<%=oissue.FOneItem.Freqissueimg%>" alt="텐바이텐 히치하이커 고객 에디터 모집" usemap="#hitchhikerissue" /></p>
	<%=oissue.FOneItem.Freqimghtmltext%>
<% else %>
	<p><img src="<%=oissue.FOneItem.Freqissueimg%>" alt="텐바이텐 히치하이커 고객 에디터 모집" /></p>
<% end if %>
</div>
<% set oissue = nothing %>
<!--
<p><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/@temp_img_handwork_publish.jpg" alt="징크스 여러분의 징크스는 무엇인가요?" usemap="#buyHitchhiker" /></p>
<map id="buyHitchhiker" name="buyHitchhiker">
	<area shape="circ" coords="174,738,65" href="http://10x10.co.kr/shopping/category_prd.asp?itemid=5555" alt="현금 구매하기" />
	<area shape="circ" coords="387,738,67.5" href="http://10x10.co.kr/shopping/category_prd.asp?itemid=5555" alt="마일리지 구매하기" />
</map>
<p><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/@temp_img_handwork_editor.jpg" alt="텐바이텐 히치하이커 고객 에디터 모집" usemap="#hitchhikerEditor" /></p>
<map id="hitchhikerEditor" name="hitchhikerEditor">
	<area shape="rect" coords="54,259,259,275" href="#" onclick="fileDownload(2952); return false;" alt="워드 파일 지원서 양식 다운로드" />
	<area shape="rect" coords="55,279,260,295" href="#" onclick="fileDownload(2951); return false;" alt="한글 파일 지원서 양식 다운로드" />
	<area shape="circ" coords="443,237,58.5" href="#lyEssay" onclick="editerLayer('1','con1');return false;" alt="에세이 지원하기" />
	<area shape="circ" coords="444,431,59" href="#lyPhoto" onclick="editerLayer('2','con2');return false;" alt="포토 스티커 지원하기" />
</map>
-->