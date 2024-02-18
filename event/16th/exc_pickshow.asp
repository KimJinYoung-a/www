<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [텐쑈]뽑아주쑈!
' History : 2017.09.26 정태훈
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/event/16th/pickshowCls.asp" -->
<%
dim eCode, eItemCode, vUserID, nowdate, itemid, ItemGroupCate
Dim sqlstr, evtsubscriptcnt, ItemGroup, ItemGroupNum, gid
IF application("Svr_Info") = "Dev" THEN
	eCode = "67435"
	eItemCode="67436"
Else
	eCode = "80412"
	eItemCode="80741"
End If

nowdate = date()

If nowdate="2017-10-10" Then
	ItemGroup="220325"
	ItemGroupNum="0"
	ItemGroupCate="101"
ElseIf nowdate="2017-10-11" Then
	ItemGroup="220326"
	ItemGroupNum="1"
	ItemGroupCate="102"
ElseIf nowdate="2017-10-12" Then
	ItemGroup="220327"
	ItemGroupNum="2"
	ItemGroupCate="103"
ElseIf nowdate="2017-10-13" Then
	ItemGroup="220328"
	ItemGroupNum="3"
	ItemGroupCate="104"
ElseIf nowdate="2017-10-14" Then
	ItemGroup="220329"
	ItemGroupNum="4"
	ItemGroupCate="124"
ElseIf nowdate="2017-10-15" Then
	ItemGroup="220437"
	ItemGroupNum="5"
	ItemGroupCate="121"
ElseIf nowdate="2017-10-16" Then
	ItemGroup="220438"
	ItemGroupNum="6"
	ItemGroupCate="122"
ElseIf nowdate="2017-10-17" Then
	ItemGroup="220439"
	ItemGroupNum="7"
	ItemGroupCate="120"
ElseIf nowdate="2017-10-18" Then
	ItemGroup="220440"
	ItemGroupNum="8"
	ItemGroupCate="112"
ElseIf nowdate="2017-10-19" Then
	ItemGroup="220441"
	ItemGroupNum="9"
	ItemGroupCate="119"
ElseIf nowdate="2017-10-20" Then
	ItemGroup="220442"
	ItemGroupNum="10"
	ItemGroupCate="117"
ElseIf nowdate="2017-10-21" Then
	ItemGroup="220443"
	ItemGroupNum="11"
	ItemGroupCate="116"
ElseIf nowdate="2017-10-22" Then
	ItemGroup="220444"
	ItemGroupNum="12"
	ItemGroupCate="125"
ElseIf nowdate="2017-10-23" Then
	ItemGroup="220445"
	ItemGroupNum="13"
	ItemGroupCate="118"
ElseIf nowdate="2017-10-24" Then
	ItemGroup="220446"
	ItemGroupNum="14"
	ItemGroupCate="115"
ElseIf nowdate="2017-10-25" Then
	ItemGroup="220447"
	ItemGroupNum="15"
	ItemGroupCate="110"
Else
	ItemGroup="220325"
	ItemGroupNum="0"
	ItemGroupCate="101"
End If

Dim cEventItem, iTotCnt, ix
Set cEventItem = New ClsEvtItem
cEventItem.FECode 	= eItemCode
cEventItem.FEGCode 	= ItemGroup
cEventItem.FEItemCnt=3
cEventItem.FItemsort=8
cEventItem.fnGetEventItem
iTotCnt = cEventItem.FTotCnt
%>
							<div class="section show-event5">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/tit_pick.png" alt="상품 추천 이벤트 뽑아주쑈" /></h3>
									<div class="desc">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/txt_pick.png" alt="하루에 한번 마음에 드는 상품을 골라보고 100마일리지 받아가세요!" /></p>
										<a href="/event/16th/pickshow.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80410/btn_pick.png" alt="참여하러 가기" /></a>
									</div>
									<!-- 실시간 순위 -->
									<% IF (iTotCnt >= 0) Then %>
									<ol class="rank">
										<% For ix=0 To 2 %>
										<li><a href="/shopping/category_prd.asp?itemid=<%=cEventItem.FCategoryPrdList(ix).FItemID%>"><img src="<% if Not(cEventItem.FCategoryPrdList(ix).Ftentenimage400="" Or isnull(cEventItem.FCategoryPrdList(ix).Ftentenimage400)) Then %><%=cEventItem.FCategoryPrdList(ix).Ftentenimage400%><% Else %><%=getThumbImgFromURL(cEventItem.FCategoryPrdList(ix).FImageIcon1,"125","125","true","false")%><% End If %>" alt="<%=cEventItem.FCategoryPrdList(ix).FItemName%>" /></a></li>
										<% Next %>
									</ol>
									<% End If %>
									<div class="deco d1"></div>
									<div class="deco d2"></div>
									<div class="deco d3"></div>
								</div>
							</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->