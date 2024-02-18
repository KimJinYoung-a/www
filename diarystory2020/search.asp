<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 검색
' History : 2019-08-26 최종원 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "//m.10x10.co.kr/diarystory2020/"
			REsponse.End
		end if
	end if
end if

IF application("Svr_Info") <> "Dev" THEN
    If GetLoginUserLevel <> "7" Then
        Response.Redirect "/diarystory2021/"
    End If
end if

%>
</head>
<body>
<div class="wrap">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2020">
		<div id="contentWrap" class="diary-search">
        <!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<div class="diary-content">
                <div class="sub-header">
                    <div class="inner">
                        <h3>나만의 다이어리 찾기<span>원하는 항목에 체크해 주세요, <strong>중복체크</strong>도 가능합니다.</span></h3>
                    </div>
                </div>
                <div class="search-wrap">
                    <div class="diary-search">
                        <div class="search-option">
                            <dl class="type01">
                                <dt>Theme</dt>
                                <dd>
                                    <dl>
                                        <dt>구분</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="301001" id="optCt4-1" /> <label for="optCt4-1">다이어리</label></li>
                                                <li><input type="checkbox" class="check" value="301002" id="optCt4-2" /> <label for="optCt4-2">스터디</label></li>
                                                <li><input type="checkbox" class="check" value="301003" id="optCt4-3" /> <label for="optCt4-3">가계부</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="type02">
                                <dt>Design</dt>
                                <dd>
                                    <dl>
                                        <dt>스타일</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="302001" id="optS1" /> <label for="optS1">심플</label></li>
                                                <li><input type="checkbox" class="check" value="302002" id="optS2" /> <label for="optS2">일러스트</label></li>
                                                <li><input type="checkbox" class="check" value="302003" id="optS3" /> <label for="optS3">포토</label></li>
                                                <li><input type="checkbox" class="check" value="302004" id="optS4" /> <label for="optS4">패턴</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="type03">
                                <dt>Contents</dt>
                                <dd>
                                    <dl>
                                        <dt>날짜</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="303001" id="optCt1-1" /> <label for="optCt1-1">2020 날짜형</label></li>
                                                <li><input type="checkbox" class="check" value="303002" id="optCt1-2" /> <label for="optCt1-2">만년형</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>기간</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="304001" id="optCt2-1" /> <label for="optCt2-1">1개월</label></li>
                                                <li><input type="checkbox" class="check" value="304002" id="optCt2-2" /> <label for="optCt2-2">3개월</label></li>
                                                <li><input type="checkbox" class="check" value="304003" id="optCt2-3" /> <label for="optCt2-3">6개월</label></li>
                                                <li><input type="checkbox" class="check" value="304004" id="optCt2-4" /> <label for="optCt2-4">1년</label></li>
                                                <li><input type="checkbox" class="check" value="304005" id="optCt2-5" /> <label for="optCt2-5">1년 이상</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>내지 구성</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="305001" id="optCt3-2" /> <label for="optCt3-2">먼슬리</label></li>
                                                <li><input type="checkbox" class="check" value="305002" id="optCt3-3" /> <label for="optCt3-3">위클리</label></li>
                                                <li><input type="checkbox" class="check" value="305003" id="optCt3-4" /> <label for="optCt3-4">데일리</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="type04">
                                <dt>Cover</dt>
                                <dd>
                                    <dl>
                                        <dt>재질</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="306001" id="optCv1-1" /> <label for="optCv1-1">소프트커버</label></li>
                                                <li><input type="checkbox" class="check" value="306002" id="optCv1-2" /> <label for="optCv1-2">하드커버</label></li>
                                                <li><input type="checkbox" class="check" value="306003" id="optCv1-3" /> <label for="optCv1-3">가죽</label></li>
                                                <li><input type="checkbox" class="check" value="306004" id="optCv1-4" /> <label for="optCv1-4">PVC</label></li>
                                                <li><input type="checkbox" class="check" value="306005" id="optCv1-5" /> <label for="optCv1-5">패브릭</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>제본</dt>
                                        <dd>
                                            <ul class="option-list diary-attr">
                                                <li><input type="checkbox" class="check" value="307006" id="optCv2-1" /> <label for="optCv2-1">양장/무선</label></li>
                                                <li><input type="checkbox" class="check" value="307007" id="optCv2-2" /> <label for="optCv2-2">스프링</label></li>
                                                <li><input type="checkbox" class="check" value="307008" id="optCv2-3" /> <label for="optCv2-3">6공 (바인더류)</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl class="tMar15">
                                        <dt>컬러</dt>
                                        <dd>
                                            <ul class="option-list colorchips">
                                                <li class="all selected"><input type="checkbox" value="" id="all" checked /><label for="all">ALL</label></li>
                                                <li class="skyblue"><input type="checkbox" value="006" id="skyblue" /><label for="skyblue">SKYBLUE</label></li>
                                                <li class="blue"><input type="checkbox" value="007" id="blue" /><label for="blue">BLUE</label></li>
                                                <li class="navy"><input type="checkbox" value="020" id="navy" /><label for="navy">NAVY</label></li>
                                                <li class="mint"><input type="checkbox" value="016" id="mint" /><label for="mint">MINT</label></li>
                                                <li class="green"><input type="checkbox" value="005" id="green" /><label for="green">GREEN</label></li>
                                                <li class="khaki"><input type="checkbox" value="019" id="khaki" /><label for="khaki">KHAKI</label></li>
                                                <li class="ivory"><input type="checkbox" value="024" id="ivory" /><label for="ivory">IVORY</label></li>
                                                <li class="beige"><input type="checkbox" value="004" id="beige" /><label for="beige">BEIGE</label></li>
                                                <li class="camel"><input type="checkbox" value="021" id="camel" /><label for="camel">CAMEL</label></li>
                                                <li class="brown"><input type="checkbox" value="010" id="brown" /><label for="brown">BROWN</label></li>
                                                <li class="yellow"><input type="checkbox" value="003" id="yellow" /><label for="yellow">YELLOW</label></li>
                                                <li class="orange"><input type="checkbox" value="002" id="orange" /><label for="orange">ORANGE</label></li>
                                                <li class="red"><input type="checkbox" value="001" id="red" /><label for="red">RED</label></li>
                                                <li class="wine"><input type="checkbox" value="023" id="wine" /><label for="wine">WINE</label></li>
                                                <li class="violet"><input type="checkbox" value="008" id="violet" /><label for="violet">VIOLET</label></li>
                                                <li class="lilac"><input type="checkbox" value="018" id="lilac" /><label for="lilac">LILAC</label></li>
                                                <li class="babypink"><input type="checkbox" value="017" id="babypink" /><label for="babypink">BABYPINK</label></li>
                                                <li class="pink"><input type="checkbox" value="009" id="pink" /><label for="pink">PINK</label></li>
                                                <li class="grey"><input type="checkbox" value="012" id="grey" /><label for="grey">GREY</label></li>
                                                <li class="charcoal"><input type="checkbox" value="022" id="charcoal" /><label for="charcoal">CHARCOAL</label></li>
                                                <li class="black"><input type="checkbox" value="013" id="black" /><label for="black">BLACK</label></li>
                                                <li class="white"><input type="checkbox" value="011" id="white" /><label for="white">WHITE</label></li>
                                                <li class="gold"><input type="checkbox" value="015" id="gold" /><label for="gold">GOLD</label></li>
                                                <li class="silver"><input type="checkbox" value="014" id="silver" /><label for="silver">SILVER</label></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </div>
                        <div class="btn-group">
                            <input type="button" onclick="resetOptions()" value="초기화" class="btnV18 btn-reset" />
                            <input type="button" onclick="getDiaryItems()" value="검색" class="btnV18 btn-search" />
                        </div>
                    </div>
                </div>
                <!-- 상품 리스트 -->
                <!-- #include virtual="/diarystory2020/inc/main/inc_prdwrap.asp" -->
                <!-- 링크 수작업 미정 -->
                <!-- #include virtual="/diarystory2020/inc/inc_etcevent.asp" -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->