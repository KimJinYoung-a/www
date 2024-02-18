<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
response.Charset="UTF-8"
Session.CodePage = 65001
'###########################################################
' Description :  PCWEB 우편번호 찾기
' History : 2016.06.16 원승현 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 우편번호찾기"		'페이지 타이틀 (필수)
	strPageDesc = "우편번호 찾기 이미지"		'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

%>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<%
	dim fiximgPath
	'이미지 경로 지정(SSL 처리)
	if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
		fiximgPath = "http://fiximage.10x10.co.kr"
	else
		fiximgPath = "/fiximage"
	end If
	
	Dim strTarget
	Dim strMode
	strTarget	= requestCheckVar(Request("target"),32)
	strMode     = requestCheckVar(Request("strMode"),32)

%>
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


	<%'// 검색 %>
	function SubmitForm(stype) {

		<%'// 지번 일 경우 %>
		if (stype=="jibun")
		{
			if ($("#tJibundong").val().length < 2) { alert("검색어를 두 글자 이상 입력하세요."); return; }
			$("#sGubun").val(stype);
			$("#sJibundong").val($("#tJibundong").val());
		}

		<%'// 도로명+건물번호 일 경우 %>
		if (stype=="RoadBnumber")
		{
			if ($("#ctiy11").val()=="")
			{
				alert('시/도를 선택해 주세요.');
				return;
			}

			<%'// 세종특별자치시는 시군구가 없어서 체크안함 %>
			if ($("#ctiy11").val()!="세종특별자치시")
			{
				if ($("#ctiy12").val()=="")
				{
					alert('시/군/구를 선택해 주세요.');
					return;
				}
			}
			if ($("#NameRoadBnumber").val()=="")
			{
				alert('도로명을 입력해 주세요.');
				$("#NameRoadBnumber").focus();
				return;	
			}
			if ($("#NumberRoadBnumber").val()=="")
			{
				alert('건물번호를 입력해 주세요.');
				$("#NumberRoadBnumber").focus();
				return;	
			}

			$("#sGubun").val(stype);
			$("#sSido").val($("#ctiy11").val());
			$("#sGungu").val($("#ctiy12").val());
			$("#sRoadName").val($("#NameRoadBnumber").val());
			$("#sRoadBno").val($("#NumberRoadBnumber").val());
		}

		<%'// 도로명에 동(읍/면)+지번 일 경우 %>
		if (stype=="RoadBjibun")
		{
			if ($("#ctiy21").val()=="")
			{
				alert('시/도를 선택해 주세요.');
				return;
			}

			<%'// 세종특별자치시는 시군구가 없어서 체크안함 %>
			if ($("#ctiy21").val()!="세종특별자치시")
			{
				if ($("#ctiy22").val()=="")
				{
					alert('시/군/구를 선택해 주세요.');
					return;
				}
			}
			if ($("#DongRoadBjibun").val()=="")
			{
				alert('동(읍/면)을 입력해 주세요.');
				$("#DongRoadBjibun").focus();
				return;	
			}
			if ($("#JibunRoadBjibun").val()=="")
			{
				alert('지번을 입력해 주세요.');
				$("#JibunRoadBjibun").focus();
				return;	
			}
			$("#sGubun").val(stype);
			$("#sSido").val($("#ctiy21").val());
			$("#sGungu").val($("#ctiy22").val());
			$("#sRoaddong").val($("#DongRoadBjibun").val());
			$("#sRoadjibun").val($("#JibunRoadBjibun").val());
		}

		<%'// 도로명에 건물명 일 경우 %>
		if (stype=="RoadBname")
		{
			if ($("#ctiy31").val()=="")
			{
				alert('시/도를 선택해 주세요.');
				return;
			}

			<%'// 세종특별자치시는 시군구가 없어서 체크안함 %>
			if ($("#ctiy31").val()!="세종특별자치시")
			{
				if ($("#ctiy32").val()=="")
				{
					alert('시/군/구를 선택해 주세요.');
					return;
				}
			}
			if ($("#NameRoadBname").val()=="")
			{
				alert('건물명을 입력해 주세요.');
				$("#NameRoadBname").focus();
				return;	
			}
			$("#sGubun").val(stype);
			$("#sSido").val($("#ctiy31").val());
			$("#sGungu").val($("#ctiy32").val());
			$("#sRoadBname").val($("#NameRoadBname").val());
		}

		$.ajax({
			type:"POST",
			url:"/common/searchzip_newDocProc.asp",
		   data: $("#searchProcFrm").serialize(),
		   dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
				if (jqXHR.readyState == 4) {
					if (jqXHR.status == 200) {
						if(Data!="") {
							var str;
							for(var i in Data)
							{
								 if(Data.hasOwnProperty(i))
								{
									str += Data[i];
								}
							}
							str = str.replace("undefined","");
							res = str.split("|");
							if (res[0]=="OK")
							{
								if (stype=="jibun")
								{
									$("#Jibunfinder").hide();
									$("#resultJibun").show();
									window.$('html,body').animate({scrollTop:$("#resultJibun").offset().top}, 0);
									$("#jibunaddrList").empty().html(res[1]);
									if (res[2] > 100)
									{
										$("#cautionTxtJibun").empty().html("<p></p><p>검색결과 <strong>총 "+numberWithCommas(res[2])+"건</strong> 중 <strong>100건</strong>만 표시됩니다.</p><p>검색 결과가 많을 경우 지번 또는 건물명과 함께 검색해주세요</p><p class='ex'>예) 동숭동 1-45, 동숭동 자유빌딩</p>");
										$("#cautionTxtJibun").show();
									}
									else
									{
										$("#cautionTxtJibun").empty();
									}
								}

								if (stype=="RoadBnumber")
								{
									$("#RoadBnumberfinder").hide();
									$("#resultRoadBnumber").show();
									window.$('html,body').animate({scrollTop:$("#resultRoadBnumber").offset().top}, 0);
									$("#RoadBnumberaddrList").empty().html(res[1]);
								}

								if (stype=="RoadBjibun")
								{
									$("#RoadBjibunfinder").hide();
									$("#resultRoadBjibun").show();
									window.$('html,body').animate({scrollTop:$("#resultRoadBjibun").offset().top}, 0);
									$("#RoadBjibunaddrList").empty().html(res[1]);
								}

								if (stype=="RoadBname")
								{
									$("#RoadBnamefinder").hide();
									$("#resultRoadBname").show();
									window.$('html,body').animate({scrollTop:$("#resultRoadBname").offset().top}, 0);
									$("#RoadBnameaddrList").empty().html(res[1]);
								}
							}
							else
							{
								errorMsg = res[1].replace(">?n", "\n");
								alert(errorMsg );
								return false;
							}
						} else {
							alert("잘못된 접근 입니다.");
							return false;
						}
					}
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다!");
				return false;
			}
		});
	}


	<%'// 시군구 리스트 가져옴 %>
	function getgunguList(v, stype) {

		$("#sGubun").val("gungureturn");
		$("#sSidoGubun").val(v);

		if (v=="")
		{
			alert("시/도를 선택해 주세요.");
			return false;
		}

		<%'// 세종특별자치시는 시군구가 없으므로 안타도됨 %>
		if (v=="세종특별자치시")
		{
			$("#"+stype).empty().html("<option value=''>시/군/구 없음</option>");
		}
		else
		{
			$.ajax({
				type:"POST",
				url:"/common/searchzip_newDocProc.asp",
			   data: $("#searchProcFrm").serialize(),
			   dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data)
								{
									 if(Data.hasOwnProperty(i))
									{
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK")
								{
									$("#"+stype).empty().html(res[1]);
								}
								else
								{
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg );
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다!");
					return false;
				}
			});
		}
	}

	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function setBackAction(x, y) {
		$("#"+x).hide();
		$("#"+y).show();
	}

	<%'// form에 각 값들 넣고 기본, 상세 주소 입력값 만듦 %>
	function setAddr(zip, sido, gungu, dong, eupmyun, ri, official_bld, jibun, road, building_no, type, wp, uwp) {

		var basicAddr; // 기본주소
		var basicAddr2; // 상세주소
		var roadbasicAddr; // 도로명으로 검색할시 표시할 지번주소

		$("#zip").val(zip);
		$("#sido").val(sido);
		$("#gungu").val(gungu);
		$("#dong").val(dong);
		$("#eupmyun").val(eupmyun);
		$("#ri").val(ri);
		$("#official_bld").val(official_bld);
		$("#jibun").val(jibun);
		$("#road").val(road);
		$("#building_no").val(building_no);

		if (type=="jibun")
		{
			<%'// 기본주소 입력값을 만든다.%>
			basicAddr = "["+zip+"] "+sido+" "+gungu;
			if (dong=="")
			{
				basicAddr = basicAddr + " "+eupmyun;
			}
			else
			{
				basicAddr = basicAddr + " "+dong;
			}
			if (ri!="")
			{
				basicAddr = basicAddr + " "+ri;
			}
			<%'// 상세주소 입력값을 만든다.%>
			if (official_bld!="")
			{
				basicAddr2 = official_bld+" "+jibun;
			}
			else
			{
				basicAddr2 = jibun;
			}
			$("#resultJibun").hide();
			$("#jibunDetail").show();
		}

		if (type=="RoadBnumber")
		{
			<%'// 기본주소 입력값을 만든다.%>
			basicAddr = "["+zip+"] "+sido+" "+gungu;
			if (eupmyun!="")
			{
				basicAddr = basicAddr + " "+eupmyun+" "+road;
			}
			else
			{
				basicAddr = basicAddr + " "+road;
			}
			if (building_no!="")
			{
				basicAddr = basicAddr + " "+building_no;
			}
			<%'// 상세주소 입력값을 만든다.%>
			if (official_bld!="")
			{
				basicAddr2 = ""+official_bld+"";
			}

			<%' // 지번주소 입력값을 만든다.%>
			roadbasicAddr = sido+" "+gungu;
			if (dong=="")
			{
				roadbasicAddr = roadbasicAddr + " "+eupmyun;
			}
			else
			{
				roadbasicAddr = roadbasicAddr + " "+dong;
			}
			if (ri!="")
			{
				roadbasicAddr = roadbasicAddr + " "+ri;
			}
			if (official_bld!="")
			{
				roadbasicAddr = roadbasicAddr + " "+official_bld+" "+jibun;
			}
			else
			{
				roadbasicAddr = roadbasicAddr + " "+jibun;
			}
			$("#RoadBnumberJibunDetail").empty().html("지번 주소 : "+roadbasicAddr);
			$("#resultRoadBnumber").hide();
			$("#RoadBnumberDetail").show();
		}

		if (type=="RoadBjibun")
		{
			<%'// 기본주소 입력값을 만든다.%>
			basicAddr = "["+zip+"] "+sido+" "+gungu;
			if (eupmyun!="")
			{
				basicAddr = basicAddr + " "+eupmyun+" "+road;
			}
			else
			{
				basicAddr = basicAddr + " "+road;
			}
			if (building_no!="")
			{
				basicAddr = basicAddr + " "+building_no;
			}
			<%'// 상세주소 입력값을 만든다.%>
			if (official_bld!="")
			{
				basicAddr2 = ""+official_bld+"";
			}

			<%' // 지번주소 입력값을 만든다.%>
			roadbasicAddr = sido+" "+gungu;
			if (dong=="")
			{
				roadbasicAddr = roadbasicAddr + " "+eupmyun;
			}
			else
			{
				roadbasicAddr = roadbasicAddr + " "+dong;
			}
			if (ri!="")
			{
				roadbasicAddr = roadbasicAddr + " "+ri;
			}
			if (official_bld!="")
			{
				roadbasicAddr = roadbasicAddr + " "+official_bld+" "+jibun;
			}
			else
			{
				roadbasicAddr = roadbasicAddr + " "+jibun;
			}
			$("#RoadBjibunJibunDetail").empty().html("지번 주소 : "+roadbasicAddr);
			$("#resultRoadBjibun").hide();
			$("#RoadBjibunDetail").show();
		}

		if (type=="RoadBname")
		{
			<%'// 기본주소 입력값을 만든다.%>
			basicAddr = "["+zip+"] "+sido+" "+gungu;
			if (eupmyun!="")
			{
				basicAddr = basicAddr + " "+eupmyun+" "+road;
			}
			else
			{
				basicAddr = basicAddr + " "+road;
			}
			if (building_no!="")
			{
				basicAddr = basicAddr + " "+building_no;
			}
			<%'// 상세주소 입력값을 만든다.%>
			if (official_bld!="")
			{
				basicAddr2 = ""+official_bld+"";
			}

			<%' // 지번주소 입력값을 만든다.%>
			roadbasicAddr = sido+" "+gungu;
			if (dong=="")
			{
				roadbasicAddr = roadbasicAddr + " "+eupmyun;
			}
			else
			{
				roadbasicAddr = roadbasicAddr + " "+dong;
			}
			if (ri!="")
			{
				roadbasicAddr = roadbasicAddr + " "+ri;
			}
			if (official_bld!="")
			{
				roadbasicAddr = roadbasicAddr + " "+official_bld+" "+jibun;
			}
			else
			{
				roadbasicAddr = roadbasicAddr + " "+jibun;
			}
			$("#RoadBnameJibunDetail").empty().html("지번 주소 : "+roadbasicAddr);
			$("#resultRoadBname").hide();
			$("#RoadBnameDetail").show();
		}

		$("#"+wp).empty().html(basicAddr);
		if (basicAddr2!="")
		{
			$("#"+uwp).val(basicAddr2);
		}
		$("#"+uwp).focus();
	}


	<%'// 모창에 값 던져줌 %>
	function CopyZip(x, y)	{
		var frm = eval("opener.document.<%=strTarget%>");
		var basicAddr;
		var basicAddr2;

		<%'// 기본주소 입력값을 만든다.%>
		basicAddr = $("#sido").val()+" "+$("#gungu").val();

		if (y=="jibun")
		{
			<%'// 상세주소 입력값을 만든다.%>
			if ($("#dong").val()=="")
			{
				basicAddr2 = $("#eupmyun").val();
			}
			else
			{
				basicAddr2 = $("#dong").val();
			}
			if ($("#ri").val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#ri").val();
			}
			if ($("#"+x).val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#"+x).val();
			}
		}
		if (y=="RoadBnumber")
		{
			if ($("#eupmyun").val()!="")
			{
				basicAddr2 = $("#eupmyun").val()+" "+$("#road").val();
			}
			else
			{
				basicAddr2 = $("#road").val();
			}
			if ($("#building_no").val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#building_no").val();
			}
			if ($("#"+x).val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#"+x).val();
			}
		}
		if (y=="RoadBjibun")
		{
			if ($("#eupmyun").val()!="")
			{
				basicAddr2 = $("#eupmyun").val()+" "+$("#road").val();
			}
			else
			{
				basicAddr2 = $("#road").val();
			}
			if ($("#building_no").val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#building_no").val();
			}
			if ($("#"+x).val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#"+x).val();
			}

		}
		if (y=="RoadBname")
		{
			if ($("#eupmyun").val()!="")
			{
				basicAddr2 = $("#eupmyun").val()+" "+$("#road").val();
			}
			else
			{
				basicAddr2 = $("#road").val();
			}
			if ($("#building_no").val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#building_no").val();
			}
			if ($("#"+x).val()!="")
			{
				basicAddr2 = basicAddr2 + " "+$("#"+x).val();
			}
		}


		<% if strMode="MyAddress" then %>
			// copy
			frm.zip.value		= $("#zip").val();
			frm.reqZipaddr.value		= basicAddr;
			frm.reqAddress.value		= basicAddr2;

			// focus
			frm.reqAddress.focus();
		<% elseif (strMode="buyer") then %>
			// copy
//			frm.buyZip1.value		= post1;
//			frm.buyZip2.value		= post2;
			frm.buyZip.value		= $("#zip").val();
			frm.buyAddr1.value		= basicAddr;
			frm.buyAddr2.value		= basicAddr2;

			// focus
			frm.buyAddr2.focus();
		<% else %>
			// copy
//			frm.txZip1.value			= post1;
//			frm.txZip2.value			= post2;
			frm.txZip.value				= $("#zip").val();
			frm.txAddr1.value		= basicAddr;
			frm.txAddr2.value		= basicAddr2;

			// focus
			frm.txAddr2.focus();
		<% end if %>
		// close this window
		window.close();

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
						<li><a href="#tabcont1">도로명 주소</a></li>
						<li><a href="#tabcont2">지번 주소</a></li>
					</ul>

					<div class="tabcontainer">
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
											<span class="itext"><input type="text" id="tJibundong" placeholder="동숭동" onkeydown="javascript: if (event.keyCode == 13) {SubmitForm('jibun');}" /></span>
										</div>
									</div>

									<div class="btnAreaV16a">
										<input type="submit" class="btn btnM2 btnRed btnW220" value="검색" onclick="SubmitForm('jibun');"/>
									</div>
								</fieldset>
							</div>

							<%' 검색결과 %>
							<div class="result" id="resultJibun" style="display:none;">
								<div class="help">
									<p>아래 주소중 해당하는 주소를 선택해주세요</p>
									<span id="cautionTxtJibun"></span>
								</div>

								<div class="scrollbarwrap">
									<ul class="list" id="jibunaddrList"></ul>
								</div>

								<div class="btnAreaV16a">
									<a href="" class="btn btnM2 btnWhite btnW220" onclick="setBackAction('resultJibun','Jibunfinder');return false;">이전</a>
								</div>
							</div>

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
			<input type="hidden" name="sJibundong" id="sJibundong">
			<input type="hidden" name="sSidoGubun" id="sSidoGubun">
			<input type="hidden" name="sSido" id="sSido">
			<input type="hidden" name="sGungu" id="sGungu">
			<input type="hidden" name="sRoadName" id="sRoadName">
			<input type="hidden" name="sRoadBno" id="sRoadBno">
			<input type="hidden" name="sRoaddong" id="sRoaddong">
			<input type="hidden" name="sRoadjibun" id="sRoadjibun">
			<input type="hidden" name="sRoadBname" id="sRoadBname">
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
