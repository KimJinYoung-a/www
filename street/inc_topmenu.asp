<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<script type="text/javascript">
	function goToByScroll(val){
		if (val=='1'){
			location.href="/street/street_brand_sub01.asp?makerid=<%=makerid%>&slidecode="+val;
		}else if (val=='2'){
			location.href="/street/street_brand_sub02.asp?makerid=<%=makerid%>&slidecode="+val;
		}else if (val=='3'){
			location.href="/street/street_brand_sub03.asp?makerid=<%=makerid%>&slidecode="+val;
		}else if (val=='4'){
			location.href="/street/street_brand_sub04.asp?makerid=<%=makerid%>&slidecode="+val;
		}else if (val=='6'){
			location.href="/street/street_brand_sub05.asp?makerid=<%=makerid%>&slidecode="+val;
		}else if (val=='5'){
			location.href="/street/street_brand_sub06.asp?makerid=<%=makerid%>";
		}
	}

</script>
<%
'업체에서 등록하는 배경 이미지가 있는 경우 : customBgUse / 업체에서 등록하는 배경 이미지가 없는 경우 : customBgNone
If bgImageURL <> "" Then
%>
	<div class='brandIntro customBgUse'>
<% else %>
	<div class='brandIntro customBgNone'>
<% end if %>
	<%
	If bgImageURL <> "" Then
		response.write "<div class='brandNavV15'>" '각 브랜드마다 지정된 대표 카테고리별 클래스 지정(ctgyBg01~ctgyBg10), 업체에서 등록한 배경이미지가 있는 경우 클래스명 제거
	ElseIf catecode <> "" AND catecode <> "0" Then
		Select Case catecode
			Case "101"		response.write "<div class='brandNavV15 ctgyBg01'>"		'디자인문구
			Case "102"		response.write "<div class='brandNavV15 ctgyBg02'>"		'디지털/핸드폰
			Case "103"		response.write "<div class='brandNavV15 ctgyBg03'>"		'캠핑/트래블
			Case "104"		response.write "<div class='brandNavV15 ctgyBg04'>"		'토이/취미
			Case "114"		response.write "<div class='brandNavV15 ctgyBg11'>"		'가구/수납
			Case "106"		response.write "<div class='brandNavV15 ctgyBg06'>"		'홈인테리어
			Case "112"		response.write "<div class='brandNavV15 ctgyBg07'>"		'키친
			Case "119"		response.write "<div class='brandNavV15 ctgyBg14'>"		'푸드
			Case "117"		response.write "<div class='brandNavV15 ctgyBg08'>"		'패션의류
			Case "116"		response.write "<div class='brandNavV15 ctgyBg12'>"		'패션잡화
			Case "118"		response.write "<div class='brandNavV15 ctgyBg13'>"		'뷰티/다이어트
			Case "115"		response.write "<div class='brandNavV15 ctgyBg09'>"		'베이비/키즈
			Case "110"		response.write "<div class='brandNavV15 ctgyBg10'>"		'고냥이/개
			Case "122"		response.write "<div class='brandNavV15 ctgyBg15'>"		'데코,조명
			Case "120"		response.write "<div class='brandNavV15 ctgyBg16'>"		'패브릭,생활
			Case "124"		response.write "<div class='brandNavV15 ctgyBg17'>"		'디자인가전
			Case "125"		response.write "<div class='brandNavV15 ctgyBg18'>"		'주얼리/시계
			Case Else		response.write "<div class='brandNavV15 ctgyBg00'>"		'기타
		End Select
	Else
		response.write "<div class='brandNavV15 ctgyBg00'>"
	End If
	%>
		<div class="bg">
			<div class="wFix">
				<h3>
					<span class="eng"><%=socname%></span>
					<span class="korean"><%=socname_kor%></span>
				</h3>

				<%
				'<!-- for dev msg : 브랜드별 메뉴 노출 상이함 -->
				if topmenudispyn="Y" then
				%>
					<ul class="navListV15">
						<%
						'/샵만 있을경우 뿌리지 않음
						if not(interview_yn="N" and artistwork_yn="N" and lookbook_yn="N") then
						%>
							<li id="brTab05" onclick="goToByScroll('5');" <% if ucase(nowViewPage)=ucase("street_brand_sub06.asp") then %> class="current"<% end if %>>
								<span>SHOP</span>
							</li>
						<% end if %>
						
						<% if interview_yn="Y" then %>
							<li id="brTab02" onclick="goToByScroll('2');" <% if ucase(nowViewPage)=ucase("street_brand_sub02.asp") then %> class="current"<% end if %>>
								<span>INTERVIEW</span>
							</li>
						<% end if %>
						<% if artistwork_yn="Y" then %>
							<li id="brTab04" onclick="goToByScroll('4');" <% if ucase(nowViewPage)=ucase("street_brand_sub04.asp") then %> class="current"<% end if %>>
								<span>ARTIST WORK</span>
							</li>
						<% end if %>
						<% if lookbook_yn="Y" then %>
							<li id="brTab06" onclick="goToByScroll('6');" <% if ucase(nowViewPage)=ucase("street_brand_sub05.asp") then %> class="current"<% end if %>>
								<span>LOOKBOOK</span>
							</li>
						<% end if %>
					</ul>
				<% end if %>
			</div>
		</div>
	</div>

	<div class="snsAreaV15">
		<div class="snsBoxV15">
			<dl>
				<dt>공유</dt>
				<dd>
					<ul>
                        <%
                            '// 쇼셜서비스로 글보내기
                            dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
                            snpTitle = Server.URLEncode(strPageTitle)
                            snpLink = Server.URLEncode("http://www.10x10.co.kr/street/street_brand_sub06.asp?makerid=" & makerid)

                            '기본 태그
                            snpPre = Server.URLEncode("텐바이텐 브랜드 스트리트 - INTERVIEW")
                            snpTag = Server.URLEncode("텐바이텐 브랜드" & Replace(socname_kor," ",""))
                            snpTag2 = Server.URLEncode("#10x10")
                            snpImg = Server.URLEncode(bgImageURL)
                        %>
						<li class="twitter"><a href="#" onClick="shareBrand('tw','<%=snpPre%>','<%=snpTag2%>',''); return false;"><span></span>트위터</a></li>
						<li class="facebook"><a href="#" onClick="shareBrand('fb','','',''); return false;"><span></span>페이스북</a></li>
						
						<% if snpImg<>"" then %>
							<li class="pinterest"><a href="#" onClick="shareBrand('pt','','','<%=snpImg%>'); return false;"><span></span>핀터레스트</a></li>
						<% end if %>
					</ul>
				</dd>
			</dl>
			<% '<!-- for dev msg : div 태그에 로그인 후 zzimBrOff 클래스 추가 / 찜브랜드 등록 후 zzimBrOn 클래스 변경 되게 해주세요 --> %>
			<div style="cursor:pointer;" id="zzimBrandCnt" class="<%=chkIIF(isMyFavBrand,"zzimBrOn","zzimBrOff")%>" onclick="TnMyBrandJJim('<%= makerid %>', '<%=socname%>');"><strong><%=CurrFormat(recommendcount)%></strong></div>
		</div>
	</div>
</div>
<script>
    function shareBrand(gubun, pre, tag, img) {
        let share_method;
        switch(gubun) {
            case 'tw' : share_method = 'twitter'; break;
            case 'fb' : share_method = 'facebook'; break;
            case 'pt' : share_method = 'pinterest'; break;
        }

        popSNSPost(gubun, '<%=snpTitle%>', '<%=snpLink%>', pre, tag, img);
    }
</script>