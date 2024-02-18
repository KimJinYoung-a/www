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
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_new_brand // cache DB경유
' History : 2018-06-01 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "NewBrand_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "NewBrand"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_PCMain_NewBrand_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


on Error Resume Next

If IsArray(arrList) Then
%>

			<div class="section new-brand">
				<div class="inner-cont">
					<div class="ftLt">
						<h2>Best <strong>Brand</strong></h2>
						<a href="/street/" class="btn-linkV18 link2">브랜드 더 보기 <span></span></a>
					</div>
					<div class="ftRt">
						<div class="items type-thumb item-hover">
							<ul>
								<% For jcnt = 0 To ubound(arrList,2) %>
								<li>
									<a href="/street/street_brand_sub06.asp?makerid=<%=arrList(0,jcnt)%>&gaparam=main_newbrand_<%=jcnt+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainnewbrand','indexnumber|brand_id','<%=jcnt+1%>|<%=arrList(1,jcnt)%>');">
										<div class="thumbnail"><img src="<%=arrList(3,jcnt)%>" alt="<%=arrList(1,jcnt)%>" /></div>
										<div class="desc">
											<div>
											<p class="headline"><%=arrList(1,jcnt)%></p>
											<p class="subcopy"><%=nl2br(db2html(arrList(2,jcnt)))%></p>
											</div>
										</div>
									</a>
								</li>
								<% Next %>
							</ul>
						</div>
					</div>
				</div>
				<script>
					function AmpNewBrand(jsonval)
					{
						AmplitudeEventSend('MainNewBrand', jsonval, 'eventProperties');
					}
				</script>
			</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->