<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_onlybrand // cache DB경유
' History : 2018-04-13 원승현 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList
Dim arrItem1, arrItem2, arrItem3
Dim gaParam : gaParam = "&gaparam=main_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()
Dim playingGubun, targetNum, intT, amplitudeonlybrandVal, totalprice, totalsale
Dim listI
Dim foidx, soidx, toidx, fomaincopy, somaincopy, tomaincopy
Dim fototalprice, fototalsale
Dim sototalprice, sototalsale
Dim tototalprice, tototalsale
Dim amplitudeOnlyBrand

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBONLYBRANDMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PBONLYBRANDMAIN_"
End If

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_OnlyBrandList]"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

If IsArray(arrList) Then
	For listI = 0 To UBound(arrList, 2)
		If listI = 0 Then
			foidx = arrList(0, listI)
			fomaincopy = arrList(1, listI)
		End If

		If listI = 1 Then
			soidx = arrList(0, listI)
			somaincopy = arrList(1, listI)
		End If

		If listI = 2 Then
			toidx = arrList(0, listI)
			tomaincopy = arrList(1, listI)
		End If
	Next
End If


If foidx<>"" Then
	sqlStr = "exec db_sitemaster.dbo.[usp_Ten_pcmain_OnlyBrandItem] '"&foidx&"'"
	set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrItem1 = rsMem.GetRows
	END IF
	rsMem.close
End If

If soidx<>"" Then
	sqlStr = "exec db_sitemaster.dbo.[usp_Ten_pcmain_OnlyBrandItem] '"&soidx&"'"
	'Response.write sqlStr
	'response.End

	set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrItem2 = rsMem.GetRows
	END IF
	rsMem.close
End If

If toidx<>"" Then
	sqlStr = "exec db_sitemaster.dbo.[usp_Ten_pcmain_OnlyBrandItem] '"&toidx&"'"
	'Response.write sqlStr
	'response.End

	set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrItem3 = rsMem.GetRows
	END IF
	rsMem.close
End If

on Error Resume Next

intJ = 0
%>
<script>
	function AmpEventOnlyBrand(jsonval)
	{
		AmplitudeEventSend('MainOnlyBrand', jsonval, 'eventProperties');
	}
</script>
<% If IsArray(arrList) Then %>
	<div class="ftLt">
		<h2><strong>ONLY</strong> BRAND</h2>
		<ul class="tabV18">
			<li class="current"><a href="#onlybrand<%=foidx%>"><%=fomaincopy%></a></li>
			<% If soidx <> "" Then %>
				<li><a href="#onlybrand<%=soidx%>"><%=somaincopy%></a></li>
			<% End If %>
			<% If toidx <> "" Then %>
				<li><a href="#onlybrand<%=toidx%>"><%=tomaincopy%></a></li>
			<% End If %>
		</ul>
		<div class="tab-container">
			<% If foidx <> "" Then %>
				<div id="onlybrand<%=foidx%>" class="tab-cont">
					<% 
						amplitudeOnlyBrand = "{'brand':'"&Replace(Replace(Trim(arrItem1(30, 0)), " ", ""), "\\p{z}", "")&"_0'}" 
						amplitudeOnlyBrand = Replace(amplitudeOnlyBrand, "'", "\""")
					%>
					<div class="main-bnr"><a href="<%=arrItem1(3, 0)%>&gaparam=main_onlybrand_<%=Trim(arrItem1(30, 0))%>_0" 
					onclick="fnAmplitudeEventMultiPropertiesAction('click_mainonlybrand','banner','<%=arrItem1(3, 0)%>&gaparam=main_onlybrand_<%=Trim(arrItem1(30, 0))%>_0')"><img src="<%=arrItem1(2, 0)%>" alt="<%=arrItem1(4, 0)%>" /></a></div>
					<div class="items type-thumb item-150 item-hover">
						<ul>
							<% For intI = 0 To UBound(arrItem1, 2) %>
								<li>
									<% 
										amplitudeOnlyBrand = "{'brand':'"&Replace(Replace(Trim(arrItem1(30, intI)), " ", ""), "\\p{z}", "")&"_"&intI+1&"'}" 
										amplitudeOnlyBrand = Replace(amplitudeOnlyBrand, "'", "\""")

										If arrItem1(16, intI) = "21" Then 
											fototalprice = ""&formatNumber(arrItem1(18, intI),0) &""
											fototalsale = ""& arrItem1(34, intI) &"%"
										else
											if arrItem1(23, intI) = "N" and arrItem1(27, intI) = "N" Then
												fototalprice = ""&formatNumber(arrItem1(19, intI),0) &""
											End If
											If arrItem1(23, intI) = "Y" and arrItem1(27, intI) = "N" Then
												fototalprice = ""&formatNumber(arrItem1(18, intI),0) &""
											End If
											if arrItem1(27, intI) = "Y" And arrItem1(26, intI)>0 Then
												If arrItem1(25, intI) = "1" Then
												fototalprice = ""&formatNumber(arrItem1(18, intI) - CLng(arrItem1(26, intI)*arrItem1(18, intI)/100),0) &""
												ElseIf arrItem1(25, intI) = "2" Then
												fototalprice = ""&formatNumber(arrItem1(18, intI) - arrItem1(26, intI),0) &""
												ElseIf arrItem1(25, intI) = "3" Then
												fototalprice = ""&formatNumber(arrItem1(18, intI),0) &""
												Else
												fototalprice = ""&formatNumber(arrItem1(18, intI),0) &""
												End If
											End If
											If arrItem1(23, intI) = "Y" And arrItem1(27, intI) = "Y" Then
												If arrItem1(25, intI) = "1" Then
													'//할인 + %쿠폰
													fototalsale = ""& CLng((arrItem1(19, intI)-(arrItem1(18, intI) - CLng(arrItem1(26, intI)*arrItem1(18, intI)/100)))/arrItem1(19, intI)*100)&"%"
												ElseIf arrItem1(25, intI) = "2" Then
													'//할인 + 원쿠폰
													fototalsale = ""& CLng((arrItem1(19, intI)-(arrItem1(18, intI) - arrItem1(26, intI)))/arrItem1(19, intI)*100)&"%"
												Else
													'//할인 + 무배쿠폰
													fototalsale = ""& CLng((arrItem1(19, intI)-arrItem1(18, intI))/arrItem1(19, intI)*100)&"%"
												End If 
											ElseIf arrItem1(23, intI) = "Y" and arrItem1(27, intI) = "N" Then
												If CLng((arrItem1(19, intI)-arrItem1(18, intI))/arrItem1(19, intI)*100)> 0 Then
													fototalsale = ""& CLng((arrItem1(19, intI)-arrItem1(18, intI))/arrItem1(19, intI)*100)&"%"
												End If
											elseif arrItem1(23, intI) = "N" And arrItem1(27, intI) = "Y" And arrItem1(26, intI)>0 Then
												If arrItem1(25, intI) = "1" Then
													fototalsale = ""&  CStr(arrItem1(26, intI)) & "%"
												ElseIf arrItem1(25, intI) = "2" Then
													fototalsale = "쿠폰"
												ElseIf arrItem1(25, intI) = "3" Then
													fototalsale = "쿠폰"
												Else
													fototalsale = ""& arrItem1(26, intI) &"%"
												End If
											Else 
												fototalsale = ""
											End If
										End If
									%>
									<a href="/shopping/category_Prd.asp?itemid=<%=arrItem1(13, intI)%>&gaparam=main_onlybrand_<%=Trim(arrItem1(30, 0))%>_<%=intI+1%>" onclick=AmpEventOnlyBrand(JSON.parse('<%=amplitudeOnlyBrand%>'));fnAmplitudeEventMultiPropertiesAction('click_mainonlybrand','itemid|categoryname|brand_id','<%=arrItem1(13, intI)%>|<%=fnItemIdToCategory1DepthName(arrItem1(13, intI))%>|<%=fnItemIdToBrandName(arrItem1(13, intI))%>');>
										<div class="thumbnail">
												<% If arrItem1(16, intI) = "21" And fototalsale<>"" Then %>
													<span class="discount color-red"><%=fototalsale%></span>
												<% Else %>
													<% If arrItem1(27, intI)="Y" And fototalsale<>"" Then %>
														<span class="discount color-green"><%=fototalsale%></span>
													<% ElseIf fototalsale<>"" Then %>
														<span class="discount color-red"><%=fototalsale%></span>
													<% End If %>
												<% End If %>
											<img src="<%=arrItem1(24, intI)%>" alt="<%=arrItem1(33, intI)%>" />
										</div>
										<div class="desc">
											<p class="name"><%=arrItem1(33, intI)%></p>
											<div class="price">
												<% If arrItem1(16, intI) = "21" Then %>
													<span class="discount color-red"><%=fototalsale%></span>
												<% Else %>
													<% If arrItem1(27, intI)="Y" Then %>
														<span class="discount color-green"><%=fototalsale%></span>
													<% Else %>
														<span class="discount color-red"><%=fototalsale%></span>
													<% End If %>
												<% End If %>
												<span class="sum"><%=fototalprice%></span>
											</div>
										</div>
									</a>
								</li>
							<% Next %>
						</ul>
					</div>
				</div>
			<% End If %>

			<% If soidx <> "" Then %>
				<div id="onlybrand<%=soidx%>" class="tab-cont">
					<% 
						amplitudeOnlyBrand = "{'brand':'"&Replace(Replace(Trim(arrItem2(30, 0)), " ", ""), "\\p{z}", "")&"_0'}" 
						amplitudeOnlyBrand = Replace(amplitudeOnlyBrand, "'", "\""")
					%>
					<div class="main-bnr"><a href="<%=arrItem2(3, 0)%>&gaparam=main_onlybrand_<%=Trim(arrItem2(30, 0))%>_0" 
					onclick="fnAmplitudeEventMultiPropertiesAction('click_mainonlybrand','banner','<%=arrItem2(3, 0)%>&gaparam=main_onlybrand_<%=Trim(arrItem2(30, 0))%>_0');"><img src="<%=arrItem2(2, 0)%>" alt="<%=arrItem2(4, 0)%>" /></a></div>
					<div class="items type-thumb item-150 item-hover">
						<ul>
							<% For intI = 0 To UBound(arrItem2, 2) %>
								<li>
									<% 
										amplitudeOnlyBrand = "{'brand':'"&Replace(Replace(Trim(arrItem2(30, intI)), " ", ""), "\\p{z}", "")&"_"&intI+1&"'}" 
										amplitudeOnlyBrand = Replace(amplitudeOnlyBrand, "'", "\""")

										If arrItem2(16, intI) = "21" Then 
											sototalprice = ""&formatNumber(arrItem2(18, intI),0) &""
											sototalsale = ""& arrItem2(34, intI) &"%"
										else
											if arrItem2(23, intI) = "N" and arrItem2(27, intI) = "N" Then
												sototalprice = ""&formatNumber(arrItem2(19, intI),0) &""
											End If
											If arrItem2(23, intI) = "Y" and arrItem2(27, intI) = "N" Then
												sototalprice = ""&formatNumber(arrItem2(18, intI),0) &""
											End If
											if arrItem2(27, intI) = "Y" And arrItem2(26, intI)>0 Then
												If arrItem2(25, intI) = "1" Then
												sototalprice = ""&formatNumber(arrItem2(18, intI) - CLng(arrItem2(26, intI)*arrItem2(18, intI)/100),0) &""
												ElseIf arrItem2(25, intI) = "2" Then
												sototalprice = ""&formatNumber(arrItem2(18, intI) - arrItem2(26, intI),0) &""
												ElseIf arrItem2(25, intI) = "3" Then
												sototalprice = ""&formatNumber(arrItem2(18, intI),0) &""
												Else
												sototalprice = ""&formatNumber(arrItem2(18, intI),0) &""
												End If
											End If
											If arrItem2(23, intI) = "Y" And arrItem2(27, intI) = "Y" Then
												If arrItem2(25, intI) = "1" Then
													'//할인 + %쿠폰
													sototalsale = ""& CLng((arrItem2(19, intI)-(arrItem2(18, intI) - CLng(arrItem2(26, intI)*arrItem2(18, intI)/100)))/arrItem2(19, intI)*100)&"%"
												ElseIf arrItem2(25, intI) = "2" Then
													'//할인 + 원쿠폰
													sototalsale = ""& CLng((arrItem2(19, intI)-(arrItem2(18, intI) - arrItem2(26, intI)))/arrItem2(19, intI)*100)&"%"
												Else
													'//할인 + 무배쿠폰
													sototalsale = ""& CLng((arrItem2(19, intI)-arrItem2(18, intI))/arrItem2(19, intI)*100)&"%"
												End If 
											ElseIf arrItem2(23, intI) = "Y" and arrItem2(27, intI) = "N" Then
												If CLng((arrItem2(19, intI)-arrItem2(18, intI))/arrItem2(19, intI)*100)> 0 Then
													sototalsale = ""& CLng((arrItem2(19, intI)-arrItem2(18, intI))/arrItem2(19, intI)*100)&"%"
												End If
											elseif arrItem2(23, intI) = "N" And arrItem2(27, intI) = "Y" And arrItem2(26, intI)>0 Then
												If arrItem2(25, intI) = "1" Then
													sototalsale = ""&  CStr(arrItem2(26, intI)) & "%"
												ElseIf arrItem2(25, intI) = "2" Then
													sototalsale = "쿠폰"
												ElseIf arrItem2(25, intI) = "3" Then
													sototalsale = "쿠폰"
												Else
													sototalsale = ""& arrItem2(26, intI) &"%"
												End If
											Else 
												sototalsale = ""
											End If
										End If 
									%>
									<a href="/shopping/category_Prd.asp?itemid=<%=arrItem2(13, intI)%>&gaparam=main_onlybrand_<%=Trim(arrItem2(30, intI))%>_<%=intI+1%>" onclick=AmpEventOnlyBrand(JSON.parse('<%=amplitudeOnlyBrand%>'));fnAmplitudeEventMultiPropertiesAction('click_mainonlybrand','itemid|categoryname|brand_id','<%=arrItem2(13, intI)%>|<%=fnItemIdToCategory1DepthName(arrItem2(13, intI))%>|<%=fnItemIdToBrandName(arrItem2(13, intI))%>');>
										<div class="thumbnail">
											<% If arrItem2(16, intI) = "21" And sototalsale<>"" Then %>
												<span class="discount color-red"><%=sototalsale%></span>
											<% Else %>
												<% If arrItem2(27, intI)="Y" Then %>
													<span class="discount color-green"><%=sototalsale%></span>
												<% ElseIf sototalsale<>"" Then %>
													<span class="discount color-red"><%=sototalsale%></span>
												<% End If %>
											<% End If %>
											<img src="<%=arrItem2(24, intI)%>" alt="<%=arrItem2(33, intI)%>" />
										</div>
										<div class="desc">
											<p class="name"><%=arrItem2(33, intI)%></p>
											<div class="price">
												<% If arrItem2(16, intI) = "21" Then %>
													<span class="discount color-red"><%=sototalsale%></span>
												<% Else %>
													<% If arrItem2(27, intI)="Y" Then %>
														<span class="discount color-green"><%=sototalsale%></span>
													<% Else %>
														<span class="discount color-red"><%=sototalsale%></span>
													<% End If %>
												<% End If %>
												<span class="sum"><%=sototalprice%></span>
											</div>
										</div>
									</a>
								</li>
							<% Next %>
						</ul>
					</div>
				</div>
			<% End If %>

			<% If toidx <> "" Then %>
				<div id="onlybrand<%=toidx%>" class="tab-cont">
					<% 
						amplitudeOnlyBrand = "{'brand':'"&Replace(Replace(Trim(arrItem3(30, 0)), " ", ""), "\\p{z}", "")&"_0'}" 
						amplitudeOnlyBrand = Replace(amplitudeOnlyBrand, "'", "\""")
					%>
					<div class="main-bnr"><a href="<%=arrItem3(3, 0)%>&gaparam=main_onlybrand_<%=Trim(arrItem3(30, 0))%>_0" 
					onclick="fnAmplitudeEventMultiPropertiesAction('click_mainonlybrand','banner','<%=arrItem3(3, 0)%>&gaparam=main_onlybrand_<%=Trim(arrItem3(30, 0))%>_0');"><img src="<%=arrItem3(2, 0)%>" alt="<%=arrItem3(4, 0)%>" /></a></div>
					<div class="items type-thumb item-150 item-hover">
						<ul>
							<% For intI = 0 To UBound(arrItem3, 2) %>
								<li>
									<% 
										amplitudeOnlyBrand = "{'brand':'"&Replace(Replace(Trim(arrItem3(30, intI)), " ", ""), "\\p{z}", "")&"_"&intI+1&"'}" 
										amplitudeOnlyBrand = Replace(amplitudeOnlyBrand, "'", "\""")

										If arrItem3(16, intI) = "21" Then 
											tototalprice = ""&formatNumber(arrItem3(18, intI),0) &""
											tototalsale = ""& arrItem3(34, intI) &"%"
										else
											if arrItem3(23, intI) = "N" and arrItem3(27, intI) = "N" Then
												fototalprice = ""&formatNumber(arrItem3(19, intI),0) &""
											End If
											If arrItem3(23, intI) = "Y" and arrItem3(27, intI) = "N" Then
												fototalprice = ""&formatNumber(arrItem3(18, intI),0) &""
											End If
											if arrItem3(27, intI) = "Y" And arrItem3(26, intI)>0 Then
												If arrItem3(25, intI) = "1" Then
												fototalprice = ""&formatNumber(arrItem3(18, intI) - CLng(arrItem3(26, intI)*arrItem3(18, intI)/100),0) &""
												ElseIf arrItem3(25, intI) = "2" Then
												fototalprice = ""&formatNumber(arrItem3(18, intI) - arrItem3(26, intI),0) &""
												ElseIf arrItem3(25, intI) = "3" Then
												fototalprice = ""&formatNumber(arrItem3(18, intI),0) &""
												Else
												fototalprice = ""&formatNumber(arrItem3(18, intI),0) &""
												End If
											End If
											If arrItem3(23, intI) = "Y" And arrItem3(27, intI) = "Y" Then
												If arrItem3(25, intI) = "1" Then
													'//할인 + %쿠폰
													fototalsale = ""& CLng((arrItem3(19, intI)-(arrItem3(18, intI) - CLng(arrItem3(26, intI)*arrItem3(18, intI)/100)))/arrItem3(19, intI)*100)&"%"
												ElseIf arrItem3(25, intI) = "2" Then
													'//할인 + 원쿠폰
													fototalsale = ""& CLng((arrItem3(19, intI)-(arrItem3(18, intI) - arrItem3(26, intI)))/arrItem3(19, intI)*100)&"%"
												Else
													'//할인 + 무배쿠폰
													fototalsale = ""& CLng((arrItem3(19, intI)-arrItem3(18, intI))/arrItem3(19, intI)*100)&"%"
												End If 
											ElseIf arrItem3(23, intI) = "Y" and arrItem3(27, intI) = "N" Then
												If CLng((arrItem3(19, intI)-arrItem3(18, intI))/arrItem3(19, intI)*100)> 0 Then
													fototalsale = ""& CLng((arrItem3(19, intI)-arrItem3(18, intI))/arrItem3(19, intI)*100)&"%"
												End If
											elseif arrItem3(23, intI) = "N" And arrItem3(27, intI) = "Y" And arrItem3(26, intI)>0 Then
												If arrItem3(25, intI) = "1" Then
													fototalsale = ""&  CStr(arrItem3(26, intI)) & "%"
												ElseIf arrItem3(25, intI) = "2" Then
													fototalsale = "쿠폰"
												ElseIf arrItem3(25, intI) = "3" Then
													fototalsale = "쿠폰"
												Else
													fototalsale = ""& arrItem3(26, intI) &"%"
												End If
											Else 
												fototalsale = ""
											End If
										End If 
									%>
									<a href="/shopping/category_Prd.asp?itemid=<%=arrItem3(13, intI)%>&gaparam=main_onlybrand_<%=Trim(arrItem3(30, intI))%>_<%=intI+1%>" onclick=AmpEventOnlyBrand(JSON.parse('<%=amplitudeOnlyBrand%>'));fnAmplitudeEventMultiPropertiesAction('click_mainonlybrand','itemid|categoryname|brand_id','<%=arrItem3(13, intI)%>|<%=fnItemIdToCategory1DepthName(arrItem3(13, intI))%>|<%=fnItemIdToBrandName(arrItem3(13, intI))%>');>
										<div class="thumbnail">
											<% If arrItem3(16, intI) = "21" And fototalsale<>"" Then %>
												<span class="discount color-red"><%=fototalsale%></span>
											<% Else %>
												<% If arrItem3(27, intI)="Y" And fototalsale<>"" Then %>
													<span class="discount color-green"><%=fototalsale%></span>
												<% ElseIf fototalsale<>"" Then %>
													<span class="discount color-red"><%=fototalsale%></span>
												<% End If %>
											<% End If %>
											<img src="<%=arrItem3(24, intI)%>" alt="<%=arrItem3(33, intI)%>" />
										</div>
										<div class="desc">
											<p class="name"><%=arrItem3(33, intI)%></p>
											<div class="price">
												<% If arrItem3(16, intI) = "21" Then %>
													<span class="discount color-red"><%=fototalsale%></span>
												<% Else %>
													<% If arrItem3(27, intI)="Y" Then %>
														<span class="discount color-green"><%=fototalsale%></span>
													<% Else %>
														<span class="discount color-red"><%=fototalsale%></span>
													<% End If %>
												<% End If %>
												<span class="sum"><%=fototalprice%></span>
											</div>
										</div>
									</a>
								</li>
							<% Next %>
						</ul>
					</div>
				</div>
			<% End If %>
		</div>
	</div>
<% End If %>
<%
	on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->