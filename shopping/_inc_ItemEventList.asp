<%
	dim tmpSQL, arrEvt, chkEvtDiv(2)
	dim strLink, strLinkName, chkDl, chkCnt, vEvtListBody, strEvtTerm, strEvtRc, strLinkNameSale, strLinkNameTag, strLinkNameImg, strLinksubcopy, strLinkLastName
	chkDl = 0: chkCnt = 0
	vEvtListBody = ""

	tmpSQL = "Execute [db_item].[dbo].sp_Ten_EvtByItem_Temp2  @vItemid=" & itemid &" , @device='W' "

'	rsget.CursorLocation = adUseClient
'	rsget.CursorType=adOpenStatic
'	rsget.Locktype=adLockReadOnly
'	rsget.Open tmpSQL, dbget
'
'	If Not rsget.EOF Then
'		arrEvt 	= rsget.GetRows
'	End if
'	rsget.close

	Function FnEventInfoClass(bannerTypeDiv)
		If bannerTypeDiv="1" Then
			FnEventInfoClass="item-bnr-discount"
		ElseIf bannerTypeDiv="2" Then
			FnEventInfoClass="item-bnr-coupon"
		ElseIf bannerTypeDiv="3" Then
			FnEventInfoClass="item-bnr-gift"
		ElseIf bannerTypeDiv="4" Then
			FnEventInfoClass="item-bnr-shipping"
		ElseIf bannerTypeDiv="5" Then
			FnEventInfoClass="item-bnr-booking"
		ElseIf bannerTypeDiv="6" Then
			FnEventInfoClass="item-bnr-onetoone"
		ElseIf bannerTypeDiv="7" Then
			FnEventInfoClass="item-bnr-oneplus"
		End If
	End Function

	Function FnChangeTextImage(ByVal bannerTypeDiv, ByVal TextImageValue)
		TextImageValue=CStr(TextImageValue)
		If bannerTypeDiv="1" Then
			For ix=0 To 9
				TextImageValue = Replace(TextImageValue,CStr(ix),"<em class='num"+CStr(ix)+"'>"+CStr(ix)+"</em>")
			Next
			TextImageValue = TextImageValue + "<span>% SALE</span>"
			FnChangeTextImage=TextImageValue
		ElseIf bannerTypeDiv="2" Then
			For ix=0 To 9
				TextImageValue = Replace(TextImageValue,CStr(ix),"<em class='num"+CStr(ix)+"'>"+CStr(ix)+"</em>")
			Next
			TextImageValue = Replace(TextImageValue,",","<em class='comma'>,</em>")
			TextImageValue = Replace(TextImageValue,"%","<em class='percent'>%</em>")
			TextImageValue = Replace(TextImageValue,"원","<em class='won'>원</em>")
			TextImageValue = TextImageValue + "<span>COUPON</span>"
			FnChangeTextImage=TextImageValue
		End If
	End Function

	Function FnEventNameSplit(strName)
		if ubound(Split(strName,"|"))> 0 Then
			FnEventNameSplit = cStr(Split(strName,"|")(0))
		Else
			FnEventNameSplit = db2html(strName)
		end If
	End Function

	''캐시로 변경 //2015/04/08
	dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"EVTisu",tmpSQL,60*10)
	If Not rsMem.EOF Then
		arrEvt 	= rsMem.GetRows
	End if
	rsMem.close

	If isArray(arrEvt) and not(isnull(arrEvt)) Then

		FOR i=0 to ubound(arrEvt,2)
			strLink = "": strLinkName="": strLinkNameSale="": strLinkNameTag="": strLinkNameImg="": strLinksubcopy="": strLinkLastName=""
			strEvtRc = "rc=item_event_" & (chkCnt+1)		'// Log Param 추가(2017.03.20 허진원)
			strEvtTerm = "기간: " & FormatDate(arrEvt(11,i),"00.00.00") & "~" & FormatDate(arrEvt(12,i),"00.00.00")

			SELECT CASE cStr(arrEvt(0,i))
				'' arrEvt(16,i) : 정사각 이미지(어드민-대표상품정보 및 배너)
				'' arrEvt(17,i) : 서브카피KO(어드민-WWW서브카피KO) PC에서 사용하는거
				'' arrEvt(18,i) : 서브카피(어드민-모바일 서브카피)
				case "1" '/쇼핑 찬스
					IF arrEvt(6,i)="I" and arrEvt(7,i)<>"" Then
						strLink = "<a href="""& arrEvt(7,i) & chkIIF(instr(arrEvt(7,i),"?")>0,"&","?") & strEvtRc & """>"
					Else
						strLink = "<a href=""/event/eventmain.asp?eventid=" & arrEvt(4,i) & "&"&strEvtRc & """>"
					End If
					strLinkName = db2html(arrEvt(2,i))
				case "7" '/위클리 코디네이터 (x)
					strLink = "<a href=""/guidebook/weekly_coordinator.asp?eventid=" & db2html(arrEvt(4,i)) & "&"&strEvtRc & """>"
					strLinkName = db2html(arrEvt(2,i))
				case "11" '/디자인 핑거스 (x)
					strLink = "<a href=""" & db2html(arrEvt(1,i)) & chkIIF(instr(arrEvt(1,i),"?")>0,"&","?") & strEvtRc & """>"
					strLinkName = db2html(arrEvt(2,i)) & " " & CStr(arrEvt(3,i)) &"회차<" & db2html(arrEvt(10,i)) & ">"
				case "12" '/전체이벤트
					IF arrEvt(6,i)="I" and arrEvt(7,i)<>"" Then
						strLink = "<a href="""& arrEvt(7,i) & chkIIF(instr(arrEvt(7,i),"?")>0,"&","?") & strEvtRc &""">"
					Else
						strLink = "<a href=""/event/eventmain.asp?eventid=" & arrEvt(4,i) & "&"&strEvtRc & """>"
					End if
					strLinkName = db2html(arrEvt(2,i))
				CASE "13"
					'상품 이벤트
					IF arrEvt(5,i)<>"" Then
						itEvtImg = arrEvt(5,i)
						itEvtImgMap = arrEvt(9,i)
						itEvtImgNm = Replace(arrEvt(2,i),"""","")
					End IF
				case "16" '/브랜드할인행사 (x)
					strLink = "<a href="""" onclick=""GoToBrandShopevent_direct('" & oItem.Prd.FMakerid & "'); return false;"">"
					strLinkName = split(db2html(arrEvt(2,i)),"|")(0)
				case "17" '/다이어리 이벤트 (x)
					IF arrEvt(6,i)="I" and arrEvt(7,i)<>"" Then
						strLink = "<a href="""& arrEvt(7,i) &""">"
						strLinkName = db2html(arrEvt(2,i))
					ELSE
						strLink = "<a href=""/diary2010/diary_event_view.asp?eventid="& arrEvt(4,i) &""">"
						strLinkName = db2html(arrEvt(2,i))
					END IF
				case "23" '/테스터이벤트
					strLink = "<a href=""/event/eventmain.asp?eventid=" & arrEvt(4,i) & "&"&strEvtRc & """>"
					strLinkName = db2html(arrEvt(2,i))
				case "29" '/Hey Something Project
					strLink = "<a href=""/HSProject/?eventid=" & arrEvt(4,i) & "&"&strEvtRc & """>"
					strLinkName = db2html(arrEvt(2,i))
				case "31" '/브랜드위크
					IF arrEvt(6,i)="I" and arrEvt(7,i)<>"" Then
						strLink = "<a href="""& arrEvt(7,i) & chkIIF(instr(arrEvt(7,i),"?")>0,"&","?") & strEvtRc &""">"
					Else
						strLink = "<a href=""/event/eventmain.asp?eventid=" & arrEvt(4,i) & "&"&strEvtRc & """>"
					End if
					strLinkName = db2html(arrEvt(2,i))
			End Select

			'MD등록 상품 배너형 이벤트 노출 2017-11-08 정태훈

			If arrEvt(33,i)="80" Then
				If arrEvt(20,i)="5" Then
					itEvtBanner="<div class='item-bnr " + FnEventInfoClass(arrEvt(23,i)) + "'>"
					itEvtBanner=itEvtBanner+"<p class='label'>"
					If arrEvt(23,i)="1" Then
						itEvtBanner=itEvtBanner+FnChangeTextImage(arrEvt(23,i),arrEvt(22,i))
					ElseIf arrEvt(23,i)="2" Then
						itEvtBanner=itEvtBanner+FnChangeTextImage(arrEvt(23,i),arrEvt(24,i))
					ElseIf arrEvt(23,i)="3" Then
						itEvtBanner=itEvtBanner+"	<span>GIFT EVENT</span>"
					ElseIf arrEvt(23,i)="4" Then
						itEvtBanner=itEvtBanner+"	<span>무료배송</span>"
					ElseIf arrEvt(23,i)="5" Then
						itEvtBanner=itEvtBanner+"	<span>예약판매</span>"
					ElseIf arrEvt(23,i)="6" Then
						itEvtBanner=itEvtBanner+"	<span>1:1 EVENT</span>"
					ElseIf arrEvt(23,i)="7" Then
						itEvtBanner=itEvtBanner+"	<span>1+1 EVENT</span>"
					End If
					itEvtBanner=itEvtBanner+"	</p>"
					itEvtBanner=itEvtBanner+"	<div class='desc'>"
					itEvtBanner=itEvtBanner+"	<p class='tit'>"
					itEvtBanner=itEvtBanner+ FnEventNameSplit(arrEvt(2,i))
					itEvtBanner=itEvtBanner+"	<span class='date'>("+ FormatDate(arrEvt(11,i),"0000.00.00") + "~" + FormatDate(arrEvt(12,i),"00.00") + ")</span>"
					itEvtBanner=itEvtBanner+"	</p>"
					If arrEvt(25,i)="1" Then
						itEvtBanner=itEvtBanner+"<p class='txt'>" + nl2br(arrEvt(17,i)) + "</p>"
					Else
						itEvtBanner=itEvtBanner+"<p class='txt'>"
						If arrEvt(26,i) <> "" Then
						itEvtBanner=itEvtBanner+"1. "+arrEvt(26,i)
						End If
						If arrEvt(28,i) <> "" Then
						itEvtBanner=itEvtBanner+"<br />2. "+arrEvt(28,i)
						End If
						If arrEvt(30,i) <> "" Then
						itEvtBanner=itEvtBanner+"<br />3. "+arrEvt(30,i)
						End If
						itEvtBanner=itEvtBanner+"</p>"
					End If
					itEvtBanner=itEvtBanner+"	</div>"
					If arrEvt(27,i)<>"" Or arrEvt(29,i)<>"" Or arrEvt(31,i)<>"" Then
						itEvtBanner=itEvtBanner+"	<div class='figure'>"
							If arrEvt(27,i) <> "" Then
							itEvtBanner=itEvtBanner+"<div class='image'><img src='"+arrEvt(27,i)+"' /></div>"
							End If
							If arrEvt(29,i) <> "" Then
							itEvtBanner=itEvtBanner+"<div class='image'><img src='"+arrEvt(29,i)+"' /></div>"
							End If
							If arrEvt(31,i) <> "" Then
							itEvtBanner=itEvtBanner+"<div class='image'><img src='"+arrEvt(31,i)+"' /></div>"
							End If
						itEvtBanner=itEvtBanner+"	</div>"
					End If
					itEvtBanner=itEvtBanner+"	</div>"
				End If
			End If

			if ubound(Split(strLinkName,"|"))> 0 Then
				strLinkLastName	= "<strong>"&cStr(Split(strLinkName,"|")(0))&"</strong>"
				strLinkNameSale = " <i class='cRd0V15'>"&cStr(Split(strLinkName,"|")(1))&"</i>"
			Else
				strLinkLastName = "<strong>"&db2html(strLinkName)&"</strong>"
			end If

			'태그(쿠폰,GIFT) 추가(2017-04-13 유태욱)
			If arrEvt(13,i)="True" Then
				strLinkNameTag	= strLinkNameTag&" <i class='cRd0V15'>SALE</i>"
			End If
			If arrEvt(14,i)="True" Then
				strLinkNameTag	= strLinkNameTag&" <i class='cGr0V15'>쿠폰</i>"
			End If
			If arrEvt(15,i)="True" Then
				strLinkNameTag	= strLinkNameTag&" <i class='cMt0V15'>GIFT</i>"
			End If

			'서브카피 추가(2017-04-13 유태욱)
			If arrEvt(18,i) <> "" Then
				strLinksubcopy	= "<p class='evtDesc'>"&stripHTML(db2html(arrEvt(17,i)))&"</p>"
			End If

			'정사각 대표이미지 추가(2017-04-13 유태욱)
			dim viEvtmb
			If arrEvt(16,i) <> "" Then
				viEvtmb = getThumbImgFromURL(arrEvt(16,i),50,50,"true","false")
				strLinkNameImg	= strLinkNameImg&" <span><img src='"&viEvtmb&"' style='width:50px; height:50px' alt='' /></span>"
			End If

			If strLink <> "" Then
'기존꺼			vEvtListBody = vEvtListBody & "	<li title='" & strEvtTerm & "' " & CHKIIF(cStr(arrEvt(0,i))<>"11","class=evt","") & ">" & strLink & strLinkName & "</a></li>" & vbCrLf

				vEvtListBody = vEvtListBody &	"<li class='imgOverV15'>"
				vEvtListBody = vEvtListBody	&		strLink
				vEvtListBody = vEvtListBody	&		strLinkNameImg
				vEvtListBody = vEvtListBody &		"<p class='evtTit'>"
				vEvtListBody = vEvtListBody	&			strLinkLastName
				vEvtListBody = vEvtListBody &			"<dfn>"
				vEvtListBody = vEvtListBody &				strLinkNameSale
				vEvtListBody = vEvtListBody &				strLinkNameTag
				vEvtListBody = vEvtListBody &			"</dfn>"
				vEvtListBody = vEvtListBody &		"</p>"
				vEvtListBody = vEvtListBody	&		strLinksubcopy
				vEvtListBody = vEvtListBody &		"</a>"
				vEvtListBody = vEvtListBody &	"</li>" & vbCrLf

				chkCnt = chkCnt+1
			End If
		Next

		If vEvtListBody <> "" Then
%>
<dl class="evtIssuV17a">
	<dt>Event & Issue</dt>
	<dd>
		<ul>
			<%= vEvtListBody %>
		</ul>
	</dd>
</dl>
<script>
$(function() {
	$('.evtIssuV17a ul li').each(function(){
		var tagWidth = $(this).find('dfn').width()+10;
		$(this).find('.evtTit').css('padding-right',tagWidth+'px');
		var txtWidth = $(this).find('.evtTit').outerWidth();
		if (txtWidth > 355) {
			$(this).find('.evtTit').children('strong').css('width',355-tagWidth+'px');
		}
	});

	// 이미지가 없는 이벤트는 노출X
	$('.evtIssuV17a ul li.imgOverV15').each(function(){
		if(!$(this).find("a span").children().is('img')) {
			$(this).remove();
		}
	});
	if($('.evtIssuV17a ul li').length==0) {
		$('.evtIssuV17a').hide();
	}
});
</script>
<%
		End If
	End If
	'// 상품 이벤트 배너가 있을 경우 레이어 처리 방식으로 변경 (2012.07.02; 허진원)
	IF itEvtImg<>"" Then
		Response.Write "<script type='text/javascript'>"
		Response.Write " $(""#lyItemEventBanner"").html('<img src=""" & itEvtImg & """ usemap=""#Mainmap"" alt=""" & itEvtImgNm & """ />');"
		Response.Write " $(""#lyItemEventBanner"").show(); "
		Response.Write "</script>"
		If Not(itEvtImgMap="" or isNull(itEvtImgMap)) then Response.Write itEvtImgMap
	end If
	If itEvtBanner <> "" Then
		Response.Write "<script type='text/javascript'>"
		Response.Write " $(""#lyItemEventBanner"").html(""" &itEvtBanner&""");"
		Response.Write " $(""#lyItemEventBanner"").show(); "
		Response.Write "</script>"
	End If
%>