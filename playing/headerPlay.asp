<%
	Dim vCa1HeaderOn, vCa2HeaderOn, vCa3HeaderOn
	SELECT CASE vCate
		Case "thing" : vCa1HeaderOn = "on"
		Case "talk"  : vCa2HeaderOn = "on"
		Case "inspi" : vCa3HeaderOn = "on"
	END SELECT
%>
<div id="headerPlayV16" class="headerPlayV16">
	<div class="inner">
		<h2><a href="/playing/"><span><i></i>PLAY ing</span> 당신의 감성을 플레이하다</a></h2>
		<div class="sortingBar">
			<ul>
				<li class="sortingThing">
					<!-- for dev msg : 리스트 페이지에서 각각 메뉴가 선택되었을때 클래스명 "on"붙여주세요 -->
					<a href="list.asp?cate=thing" class="<%=vCa1HeaderOn%>"><i></i><span>THING.</span></a>
				</li>
				<li class="sortingTalk">
					<a href="list.asp?cate=talk" class="<%=vCa2HeaderOn%>"><i></i><span>TALK</span></a>
				</li>
				<li class="sortingInspiration">
					<a href="list.asp?cate=inspi" class="<%=vCa3HeaderOn%>"><i></i><span>!NSPIRATION</span></a>
				</li>
			</ul>
		</div>
	</div>
</div>