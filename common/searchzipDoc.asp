<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.CharSet = "UTF-8"

'#######################################################
'	History	:  
'	Description : zip 검색 결과
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/Zipsearchcls_TT.asp" -->


<%

dim sJibundong : sJibundong = requestCheckVar(request("sJibundong"),100) '현재 입력된 검색어
dim zipgroup : zipgroup = requestCheckVar(request("zipgroup"),60)

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
if CurrPage="" then CurrPage=1
if PageSize="" then PageSize=100
    
dim iSiDo : iSiDo  = requestCheckVar(request("iSiDo"),20) 
dim iGunGu : iGunGu  = requestCheckVar(request("iGunGu"),30) 
dim iRoad : iRoad  = requestCheckVar(request("iRoad"),50) 
dim iBuilding_no : iBuilding_no  = requestCheckVar(request("iBuilding_no"),20) 
dim iDong : iDong  = requestCheckVar(request("iDong"),30) 
dim iJibun_main : iJibun_main  = requestCheckVar(request("iJibun_main"),20) 
dim iJibun_sub : iJibun_sub  = requestCheckVar(request("iJibun_sub"),20) 


sJibundong = RepWord(sJibundong,"[^가-힣a-zA-Z0-9.&%\-\_\s]","")


response.write iJibun_main&"<br>"&sJibundong
response.write zipgroup&"<br>"

dim iRows,i,ix


'// 상품검색
dim oDoc,iLp
set oDoc = new SearchItemCls
oDoc.FRectSearchTxt = sJibundong        '' search field allwords
oDoc.FRectZipgroup = zipgroup
oDoc.FCurrPage = CurrPage
oDoc.FPageSize = PageSize

oDoc.FRectSearchSiDo  = iSiDo           
oDoc.FRectSearchGunGu = iGunGu
oDoc.FRectSearchRoad  = iRoad
oDoc.FRectSearchBuilding_no	= iBuilding_no
oDoc.FRectSearchDong	= iDong
oDoc.FRectSearchJibun_main	= iJibun_main
oDoc.FRectSearchJibun_sub	= iJibun_sub
oDoc.FRectSortMethod = "zipcode" '' 2016/07/14  지번으로 소팅.

oDoc.getSearchList

'' 시구별 그루핑 (MAX 276 개)
dim oDocGrp
set oDocGrp = new SearchItemCls
IF oDoc.FResultCount >0 then  '' 조절 가능할듯. 결과가 N개 이상일경우.
    oDocGrp.FRectSearchTxt = sJibundong        '' search field allwords
    oDocGrp.getGroupbySido
    
    response.write "grpCNT:"&oDocGrp.FResultCount&"<br>"
end if

%>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15_ssl.css" />
<script>
    document.title="텐바이텐 우편번호 검색";
	$(function(){
		/* tab onoff */
		$(".tabonoff .tabcontainer .tabcont").css("display", "none");
		$(".tabonoff .tabcontainer .tabcont:first-child").css("display", "block");
		$(".tabonoff .tabs li:first-child a").addClass("on");
		$(".tabonoff").delegate(".tabs li", "click", function() {
			var index = $(this).parent().children().index(this);
			$(this).siblings().children().removeClass();
			$(this).children().addClass("on");
			$(this).parent().next(".tabcontainer").children().hide().eq(index).show();
			return false;
		});
	});

function SubmitForm(stype) {

		<%'// 지번 일 경우 %>
		if (stype=="jibun")
		{
			if ($("#tJibundong").val().length < 2) { alert("검색어를 두 글자 이상 입력하세요."); return; }
			$("#sGubun").val(stype);
			$("#sJibundong").val($("#tJibundong").val());
		}
		
		fnzipsearch(1);
		
}
			
function fnzipsearch(icpg){
    var frm = document.searchProcFrm;
    frm.cpg.value=icpg;
    frm.submit();
}

function fnzipsubsearch(comp){
    var frm = document.searchProcFrm;
    frm.cpg.value=1;
    frm.zipgroup.value=comp.value;
    frm.submit();
}
   
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/common/tit_zipcode_find.gif" alt="우편번호 찾기" /></h1>
			</div>
			<div class="popContent">

				<div class="tabonoff zipcodeV16">
					<ul class="tabs">
					    <li><a href="#tabcont2">지번 주소</a></li>
						<li><a href="#tabcont1">도로명 주소</a></li>
						
					</ul>

					<div class="tabcontainer">
					    <%' tab2 지번 주소 %>
						<div id="tabcont2" class="tabcont jibeon">
							<h2 class="hidden">지번 주소</h2>

							<%' 검색 %>
							<div class="finder" id="Jibunfinder">
								<fieldset>
									<legend>동(읍/면)으로 우편번호 찾기</legend>
									<div class="help">
										<p>찾고 싶으신 주소의 동(읍/면) 또는 동(읍/면) 지번, 건물명을 입력해주세요</p>
										<p class="ex">예) 동숭동, 동숭동 1-45, 동숭동 자유빌딩</p>
									</div>

									<div class="address">
										<div class="row">
											<label for="dong">동(읍/면)</label>
											<span class="itext"><input type="text" value="<%=sJibundong%>" id="tJibundong" placeholder="동숭동" onkeydown="javascript: if (event.keyCode == 13) {SubmitForm('jibun');}" /></span>
										</div>
									</div>

									<div class="btnAreaV16a">
										<input type="submit" class="btn btnM2 btnRed btnW220" value="검색" onclick="SubmitForm('jibun');"/>
									</div>
								</fieldset>
							</div>

							<%' 검색결과 %>
							<% if oDocGrp.FResultCount>1 then %> <!-- 1개는 의미 없음-->
							    <select name="ttzipgroup" id="ttzipgroup" onChange="fnzipsubsearch(this);">
							    <option value="" >시/도 군/구 선택</option>
							<%
							for ii=0 to oDocGrp.FResultCount-1    
							%>
							    <option value="<%=oDocGrp.FitemList(ii).Fzipgroup%>" <%=CHKIIF(oDocGrp.FitemList(ii).Fzipgroup=zipgroup,"selected","")%>><%=oDocGrp.FitemList(ii).Fsido%> <%=oDocGrp.FitemList(ii).Fgungu%>(<%=oDocGrp.FitemList(ii).FCNT%>건)</option>
							
							<%
						    next
							%>
							    </select>
							<% end if %>
            				
				<% if oDoc.FTotalCount>0 then %>
				    total : <%=oDoc.FTotalCount%>
							<div class="pageWrapV15 tMar20">
            				<!-- //Paging -->
            				<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"fnzipsearch") %>
            				</div>
            				
							<div class="result" id="resultJibun" >
								<div class="help">
									<p>아래 주소중 해당하는 주소를 선택해주세요</p>
									<span id="cautionTxtJibun"></span>
								</div>

								<div class="scrollbarwrap">
									<ul class="list" id="jibunaddrList">
									<%
				Dim ii
				IF oDoc.FResultCount >0 then
				    For ii=0 To oDoc.FResultCount -1 
				        response.write "<li>"&oDoc.FItemList(ii).Fzipcode&"|"&oDoc.FItemList(ii).Fsido&"|"&oDoc.FItemList(ii).Fsido&"|"&oDoc.FItemList(ii).Fgungu&"|"&oDoc.FItemList(ii).Feupmyun&"|"&oDoc.FItemList(ii).Fri&"|"&oDoc.FItemList(ii).Froad&"|"&oDoc.FItemList(ii).Fofficial_bld&"|"&oDoc.FItemList(ii).Fdong&"|"&oDoc.FItemList(ii).Fdong_admin&"|"&oDoc.FItemList(ii).Fjibun_main&"|"&oDoc.FItemList(ii).Fjibun_sub&"</li>"
				    next
			    end if					
									%>
									
									</ul>
								</div>

								<div class="btnAreaV16a">
									<a href="" class="btn btnM2 btnWhite btnW220" onclick="setBackAction('resultJibun','Jibunfinder');return false;">이전</a>
								</div>
							</div>
                <% end if %>
							<%' 상세주소 입력 %>
							<div class="form" id="jibunDetail" style="display:none;">
								<fieldset>
									<div class="help">
										<p>상세 주소를 입력하신 후 &apos;주소입력&apos; 버튼을 눌러주세요</p>
									</div>

									<div class="address">
										<p><div id="jibunDetailtxt"></div></p>
										<span class="itext"><input type="text" title="상세주소 입력" id="jibunDetailAddr2" value="" placeholder="상세 주소를 입력해주세요" onkeydown="javascript: if (event.keyCode == 13) {CopyZip('jibunDetailAddr2', 'jibun');}"  /></span>
									</div>

									<div class="btnAreaV16a">
										<a href="" class="btn btnM2 btnWhite btnW150" onclick="setBackAction('jibunDetail','resultJibun');return false;">이전</a>
										<input type="submit" class="btn btnM2 btnRed btnW150" onclick="CopyZip('jibunDetailAddr2', 'jibun');" value="주소입력" />
									</div>
								</fieldset>
							</div>
						</div>
						<!-- //tab2 -->
						
						
						<%' tab1 도로명 주소 %>
						<div id="tabcont1" class="tabcont">
							<h2 class="hidden">도로명 주소</h2>
							<div class="tabonoff">
								<ul class="tabs tabsLine">
									<li class="tabs1"><a href="#tabcont1-1">도로명 + 건물번호</a></li>
									<li class="tabs2"><a href="#tabcont1-2">동(읍/면) + 지번</a></li>
									<li class="tabs3"><a href="#tabcont1-3">건물명</a></li>
								</ul>
								<div class="tabcontainer">
									<%' tab1-1 도로명 + 건물번호 %>
									<div id="tabcont1-1" class="tabcont">
										<h3 class="hidden">도로명 + 건물번호</h3>

										<%' 검색 %>
										<div class="finder" id="RoadBnumberfinder">
											<fieldset>
												<legend>도로명 + 건물번호로 우편번호 찾기</legend>
												<div class="help">
													<p>도로명, 건물번호 를 입력 후 검색해주세요</p>
													<p class="ex">예) 대학로12길(도로명) 31 (건물번호)</p>
												</div>

												<ul>
													<li class="child1">
														<div>
															<label for="ctiy11">시/도</label>
															<select id="ctiy11" onchange="getgunguList(this.value, 'ctiy12')">
																<option value="">시/도 선택</option>
																<option value="서울특별시">서울특별시</option>
																<option value="경기도">경기도</option>
																<option value="강원도">강원도</option>
																<option value="인천광역시">인천광역시</option>
																<option value="충청북도">충청북도</option>
																<option value="충청남도">충청남도</option>
																<option value="대전광역시">대전광역시</option>
																<option value="경상북도">경상북도</option>
																<option value="경상남도">경상남도</option>
																<option value="세종특별자치시">세종특별자치시</option>
																<option value="대구광역시">대구광역시</option>
																<option value="부산광역시">부산광역시</option>
																<option value="울산광역시">울산광역시</option>
																<option value="전라북도">전라북도</option>
																<option value="전라남도">전라남도</option>
																<option value="광주광역시">광주광역시</option>
																<option value="제주특별자치도">제주특별자치도</option>
															</select>
														</div>
													</li>
													<li class="child2">
														<div>
															<label for="ctiy12">시/군/구</label>
															<select id="ctiy12">
																<option>시/군/구 선택</option>
															</select>
														</div>
													</li>
													<li class="child3">
														<div>
															<label for="road">도로명</label>
															<span class="itext"><input type="text" id="NameRoadBnumber" /></span>
														</div>
													</li>
													<li class="child4">
														<div>
															<label for="buildingno">건물번호</label>
															<span class="itext"><input type="text" id="NumberRoadBnumber" onkeydown="javascript: if (event.keyCode == 13) {SubmitForm('RoadBnumber');}" /></span>
														</div>
													</li>
												</ul>

												<div class="btnAreaV16a">
													<input type="submit" class="btn btnM2 btnRed btnW220" value="검색" onclick="SubmitForm('RoadBnumber');" />
												</div>
											</fieldset>

											<div class="reference">
												<p>도로명 주소 검색 결과가 없을 경우,<br /> 도로명 주소 안내시스템을 참고해주시길 바랍니다</p>
												<p><a href="http://www.juso.go.kr" target="_blank">http://www.juso.go.kr</a></p>
											</div>
										</div>

										<%' 검색결과 %>
										<div class="result" id="resultRoadBnumber" style="display:none;">
											<div class="help">
												<p>아래 주소중 해당하는 주소를 선택해주세요</p>
											</div>

											<div class="scrollbarwrap">
												<ul class="list" id="RoadBnumberaddrList"></ul>
											</div>

											<div class="btnAreaV16a">
												<a href="" class="btn btnM2 btnWhite btnW220" onclick="setBackAction('resultRoadBnumber','RoadBnumberfinder');return false;">이전</a>
											</div>
										</div>

										<%' 상세주소 입력 %>
										<div class="form" id="RoadBnumberDetail" style="display:none;">
											<fieldset>
												<legend>상세주소 입력</legend>
												<div class="help">
													<p>상세 주소를 입력하신 후 &apos;주소입력&apos; 버튼을 눌러주세요</p>
												</div>

												<div class="address">
													<p><span id="RoadBnumberDetailTxt"></span><span id="RoadBnumberJibunDetail"></span></p>
													<div class="itext"><input type="text" title="상세주소 입력" id="RoadBnumberDetailAddr2" placeholder="상세 주소를 입력해주세요" onkeydown="javascript: if (event.keyCode == 13) {CopyZip('RoadBnumberDetailAddr2', 'RoadBnumber');}" /></div>
												</div>

												<div class="btnAreaV16a">
													<a href="" class="btn btnM2 btnWhite btnW150" onclick="setBackAction('RoadBnumberDetail','resultRoadBnumber');return false;">이전</a>
													<input type="submit" class="btn btnM2 btnRed btnW150" value="주소입력" onclick="CopyZip('RoadBnumberDetailAddr2', 'RoadBnumber');" />
												</div>
											</fieldset>
										</div>
									</div>
									<%' //tab1-1 %>

									<%' tab1-2 동(읍/면) + 지번 %>
									<div id="tabcont1-2" class="tabcont">
										<h3 class="hidden">동(읍/면) + 지번</h3>

										<%' 검색 %>
										<div class="finder" id="RoadBjibunfinder">
											<fieldset>
												<legend>동(읍/면) + 지번으로 우편번호 찾기</legend>
												<div class="help">
													<p>동(읍/면), 지번 입력 후 검색해주세요</p>
													<p class="ex">예) 동숭동(동) 1-45 (지번)</p>
												</div>

												<ul>
													<li class="child1">
														<div>
															<label for="ctiy21">시/도</label>
															<select id="ctiy21" onchange="getgunguList(this.value, 'ctiy22')">
																<option value="">시/도 선택</option>
																<option value="서울특별시">서울특별시</option>
																<option value="경기도">경기도</option>
																<option value="강원도">강원도</option>
																<option value="인천광역시">인천광역시</option>
																<option value="충청북도">충청북도</option>
																<option value="충청남도">충청남도</option>
																<option value="대전광역시">대전광역시</option>
																<option value="경상북도">경상북도</option>
																<option value="경상남도">경상남도</option>
																<option value="세종특별자치시">세종특별자치시</option>
																<option value="대구광역시">대구광역시</option>
																<option value="부산광역시">부산광역시</option>
																<option value="울산광역시">울산광역시</option>
																<option value="전라북도">전라북도</option>
																<option value="전라남도">전라남도</option>
																<option value="광주광역시">광주광역시</option>
																<option value="제주특별자치도">제주특별자치도</option>
															</select>
														</div>
													</li>
													<li class="child2">
														<div>
															<label for="ctiy22">시/군/구</label>
															<select id="ctiy22">
																<option>시/군/구 선택</option>
															</select>
														</div>
													</li>
													<li class="child3">
														<div>
															<label for="town">동(읍/면)</label>
															<span class="itext"><input type="text" id="DongRoadBjibun" /></span>
														</div>
													</li>
													<li class="child4">
														<div>
															<label for="addressno">지번</label>
															<span class="itext"><input type="text" id="JibunRoadBjibun" onkeydown="javascript: if (event.keyCode == 13) {SubmitForm('RoadBjibun');}"/></span>
														</div>
													</li>
												</ul>

												<div class="btnAreaV16a">
													<input type="submit" class="btn btnM2 btnRed btnW220" value="검색" onclick="SubmitForm('RoadBjibun');" />
												</div>
											</fieldset>
											<div class="reference">
												<p>도로명 주소 검색 결과가 없을 경우,<br /> 도로명 주소 안내시스템을 참고해주시길 바랍니다</p>
												<p><a href="http://www.juso.go.kr" target="_blank">http://www.juso.go.kr</a></p>
											</div>
										</div>

										<%' 검색결과 %>
										<div class="result" id="resultRoadBjibun" style="display:none;">
											<div class="help">
												<p>아래 주소중 해당하는 주소를 선택해주세요</p>
											</div>

											<div class="scrollbarwrap">
												<ul class="list" id="RoadBjibunaddrList"></ul>
											</div>

											<div class="btnAreaV16a">
												<a href="" class="btn btnM2 btnWhite btnW220" onclick="setBackAction('resultRoadBjibun','RoadBjibunfinder');return false;">이전</a>
											</div>
										</div>

										<%' 상세주소 입력 %>
										<div class="form" id="RoadBjibunDetail" style="display:none;">
											<fieldset>
												<legend>상세주소 입력</legend>
												<div class="help">
													<p>상세 주소를 입력하신 후 &apos;주소입력&apos; 버튼을 눌러주세요</p>
												</div>

												<div class="address">
													<p><span id="RoadBjibunDetailTxt"></p><span id="RoadBjibunJibunDetail"></span></p>
													<div class="itext"><input type="text" title="상세주소 입력" placeholder="상세 주소를 입력해주세요" id="RoadBjibunDetailAddr2" onkeydown="javascript: if (event.keyCode == 13) {CopyZip('RoadBjibunDetailAddr2', 'RoadBjibun');}" /></div>
												</div>

												<div class="btnAreaV16a">
													<a href="" class="btn btnM2 btnWhite btnW150" onclick="setBackAction('RoadBjibunDetail','resultRoadBjibun');return false;">이전</a>
													<input type="submit" class="btn btnM2 btnRed btnW150" value="주소입력" onclick="CopyZip('RoadBjibunDetailAddr2', 'RoadBjibun');" />
												</div>
											</fieldset>
										</div>
									</div>
									<%' //tab1-2 %>

									<%' tab1-3 건물명 %>
									<div id="tabcont1-3" class="tabcont">
										<h3 class="hidden">건물명</h3>

										<%' 검색 %>
										<div class="finder" id="RoadBnamefinder">
											<fieldset>
												<legend>건물명으로 우편번호 찾기</legend>
												<div class="help">
													<p>건물명을 입력 후 검색해주세요</p>
													<p class="ex">예) 자유빌딩 (건물번호)</p>
												</div>

												<ul>
													<li class="child1">
														<div>
															<label for="ctiy31">시/도</label>
															<select id="ctiy31"  onchange="getgunguList(this.value, 'ctiy32')">
																<option value="">시/도 선택</option>
																<option value="서울특별시">서울특별시</option>
																<option value="경기도">경기도</option>
																<option value="강원도">강원도</option>
																<option value="인천광역시">인천광역시</option>
																<option value="충청북도">충청북도</option>
																<option value="충청남도">충청남도</option>
																<option value="대전광역시">대전광역시</option>
																<option value="경상북도">경상북도</option>
																<option value="경상남도">경상남도</option>
																<option value="세종특별자치시">세종특별자치시</option>
																<option value="대구광역시">대구광역시</option>
																<option value="부산광역시">부산광역시</option>
																<option value="울산광역시">울산광역시</option>
																<option value="전라북도">전라북도</option>
																<option value="전라남도">전라남도</option>
																<option value="광주광역시">광주광역시</option>
																<option value="제주특별자치도">제주특별자치도</option>
															</select>
														</div>
													</li>
													<li class="child2">
														<div>
															<label for="ctiy32">시/군/구</label>
															<select id="ctiy32">
																<option>시/군/구 선택</option>
															</select>
														</div>
													</li>
													<li class="child3">
														<div>
															<label for="building">건물명</label>
															<span class="itext"><input type="text" id="NameRoadBname" onkeydown="javascript: if (event.keyCode == 13) {SubmitForm('RoadBname');}"/></span>
														</div>
													</li>
												</ul>

												<div class="btnAreaV16a">
													<input type="submit" class="btn btnM2 btnRed btnW220" value="검색" onclick="SubmitForm('RoadBname');" />
												</div>
											</fieldset>
											<div class="reference">
												<p>도로명 주소 검색 결과가 없을 경우,<br /> 도로명 주소 안내시스템을 참고해주시길 바랍니다</p>
												<p><a href="http://www.juso.go.kr" target="_blank">http://www.juso.go.kr</a></p>
											</div>
										</div>

										<%' 검색결과 %>
										<div class="result" id="resultRoadBname" style="display:none;">
											<div class="help">
												<p>아래 주소중 해당하는 주소를 선택해주세요</p>
											</div>

											<div class="scrollbarwrap">
												<ul class="list" id="RoadBnameaddrList"></ul>
											</div>

											<div class="btnAreaV16a">
												<a href="" class="btn btnM2 btnWhite btnW220" onclick="setBackAction('resultRoadBname','RoadBnamefinder');return false;">이전</a>
											</div>
										</div>

										<%' 상세주소 입력 %>
										<div class="form" id="RoadBnameDetail" style="display:none;">
											<fieldset>
												<legend>상세주소 입력</legend>
												<div class="help">
													<p>상세 주소를 입력하신 후 &apos;주소입력&apos; 버튼을 눌러주세요</p>
												</div>

												<div class="address">
													<p><span id="RoadBnameDetailTxt"></p><span id="RoadBnameJibunDetail"></span></p>
													<div class="itext"><input type="text" title="상세주소 입력" placeholder="상세 주소를 입력해주세요" id="RoadBnameDetailAddr2" onkeydown="javascript: if (event.keyCode == 13) {CopyZip('RoadBnameDetailAddr2', 'RoadBname');}"/></div>
												</div>

												<div class="btnAreaV16a">
													<a href="" class="btn btnM2 btnWhite btnW150" onclick="setBackAction('RoadBnameDetail','resultRoadBname');return false;">이전</a>
													<input type="submit" class="btn btnM2 btnRed btnW150" value="주소입력" onclick="CopyZip('RoadBnameDetailAddr2', 'RoadBname');" />
												</div>
											</fieldset>
										</div>
									</div>
									<%' //tab1-3 %>
								</div>
							</div>
						</div>
						<%' //tab1 %>

						
					</div>
				</div>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
		
		
		
		<form name="searchProcFrm" id="searchProcFrm" method="post">
			<input type="hidden" name="sGubun" id="sGubun">
			<input type="hidden" name="sJibundong" id="sJibundong" value="<%=sJibundong%>">
			<input type="hidden" name="sSidoGubun" id="sSidoGubun">
			<input type="hidden" name="sSido" id="sSido">
			<input type="hidden" name="sGungu" id="sGungu">
			<input type="hidden" name="sRoadName" id="sRoadName">
			<input type="hidden" name="sRoadBno" id="sRoadBno">
			<input type="hidden" name="sRoaddong" id="sRoaddong">
			<input type="hidden" name="sRoadjibun" id="sRoadjibun">
			<input type="hidden" name="sRoadBname" id="sRoadBname">
			
			<input type="hidden" name="zipgroup" id="zipgroup">
			
			<input type="hidden" name="cpg" id="cpg">
			
		</form>

		<form name="tranFrm" id="tranFrm" method="post">
			<input type="hidden" name="zip" id="zip">
			<input type="hidden" name="sido" id="sido">
			<input type="hidden" name="gungu" id="gungu">
			<input type="hidden" name="dong" id="dong">
			<input type="hidden" name="eupmyun" id="eupmyun">
			<input type="hidden" name="ri" id="ri">
			<input type="hidden" name="official_bld" id="official_bld">
			<input type="hidden" name="jibun" id="jibun">
			<input type="hidden" name="road" id="road">
			<input type="hidden" name="building_no" id="building_no">
		</form>

		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->