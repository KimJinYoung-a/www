<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
Dim cTime
If CDate(now()) <= CDate(Date() & " 00:05:00") Then
	cTime = 60*1
Else
	cTime = 60*10
End If

Dim sqlStr , rsMem , arrList , intI
dim page_no, evt_code, evt_name, evt_type, evt_subname,	etc_itemimg, evt_mo_listbanner,	case_type, new_yn, bannerNum
dim thumimgsize300, thumimgsize162, loginuserid, bannertag, issale, iscoupon, evt_name_sale
dim playingbannerArr, playing_idx, playing_bgcolor, playing_title, playing_imgurl
dim mktbannerArr,mkt_evtcode, mkt_title, mkt_imgurl, mkt_subcopyK
dim RetVal, rst, cmd, ABcase_type
			
	thumimgsize300 = "?cmd=thumb&w=300&h=300&fit=true&ws=false"
	thumimgsize162 = "?cmd=thumb&w=300&h=162&fit=true&ws=false"

	'--플레잉 배너 1개 오픈된것중에 최근꺼--------------------------------------------------------------
	sqlStr = " select top 1  d.didx, m.mo_bgcolor, d.title, i.imgurl " & vbcrlf
	sqlStr = sqlStr & " from [db_giftplus].[dbo].[tbl_play_master] as m " & vbcrlf
	sqlStr = sqlStr & "		join [db_giftplus].[dbo].[tbl_play_detail] as d " & vbcrlf
	sqlStr = sqlStr & "			on m.midx=d.midx " & vbcrlf
	sqlStr = sqlStr & "		join [db_giftplus].[dbo].[tbl_play_image] as i " & vbcrlf
	sqlStr = sqlStr & "			on d.didx=i.didx " & vbcrlf
	sqlStr = sqlStr & "		where m.state=7 and d.state=7 and ISNULL(i.imgurl,'') <> ''  and i.gubun=11 " & vbcrlf
	sqlStr = sqlStr & "			and datediff(day,m.startdate,getdate()) >= 0 " & vbcrlf
	sqlStr = sqlStr & "			and datediff(day,d.startdate,getdate()) >= 0 " & vbcrlf
	sqlStr = sqlStr & "		order by i.idx desc " & vbcrlf

	set rsMem = getDBCacheSQL(dbget, rsget, "2ndMPB", sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		playingbannerArr = rsMem.GetRows
	END IF
	rsMem.close
	'-----------------------------------------------------------------------------------------------

	'--마케팅 이벤트 배너 1개(web,오픈,중요도우선,최근이벤트)----------------------------------------------
	sqlStr = " select top 1 e.evt_code, e.evt_name, d.evt_mo_listbanner, e.evt_subcopyK " & vbcrlf
	sqlStr = sqlStr & " from [db_event].[dbo].[tbl_event] as e " & vbcrlf
	sqlStr = sqlStr & " join [db_event].[dbo].[tbl_event_display] as d " & vbcrlf
	sqlStr = sqlStr & " 	on e.evt_code=d.evt_code " & vbcrlf
	sqlStr = sqlStr & " where e.evt_kind=28 and e.evt_state=7 and e.isweb=1 and d.evt_mo_listbanner <> '' " & vbcrlf
	sqlStr = sqlStr & " and datediff(day,e.evt_startdate,getdate()) >= 0 " & vbcrlf
	sqlStr = sqlStr & " and datediff(day,e.evt_enddate,getdate()) < 1 " & vbcrlf
	sqlStr = sqlStr & " order by e.evt_level asc, e.evt_code desc " & vbcrlf

	set rsMem = getDBCacheSQL(dbget, rsget, "2ndMMB", sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		mktbannerArr = rsMem.GetRows
	END IF
	rsMem.close
	'-----------------------------------------------------------------------------------------------

	if IsUserLoginOK then
		loginuserid = getencloginuserid()

		Set cmd = CreateObject("ADODB.Command")
		with cmd
		    .ActiveConnection = dbget
		    .CommandType = adCmdStoredProc
		    .CommandText = "db_sitemaster.dbo.usp_Ten_Main_Colletion_Get"
		    .Parameters.Refresh
			.Parameters.Append .CreateParameter("RetVal", adInteger, adParamReturnValue)
			.Parameters.Append .CreateParameter("@UserId", adVarChar, adParamInput, 32, loginuserid)
		    Set rst = .Execute()
		    If Not rst.EOF Then arrList = rst.GetRows()
		    Call rst.Close()
		end with
		RetVal = cmd("RetVal")
	else
		sqlStr = "exec db_sitemaster.dbo.usp_Ten_Main_Colletion_Get '' "

		set rsMem = getDBCacheSQL(dbget, rsget, "2ndMB", sqlStr, cTime)
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
			arrList = rsMem.GetRows
		END IF
		rsMem.close		
	end if

	if RetVal < 1 then RetVal = 1

	on Error Resume Next

	If IsArray(mktbannerArr) Then
		mkt_evtcode		= mktbannerArr(0,0)
		mkt_title		= mktbannerArr(1,0)
		mkt_imgurl		= mktbannerArr(2,0)
		mkt_subcopyK	= mktbannerArr(3,0)
	end if

	If IsArray(playingbannerArr) Then
		playing_idx			= playingbannerArr(0,0)
		playing_bgcolor		= playingbannerArr(1,0)
		playing_title		= playingbannerArr(2,0)
		playing_imgurl		= playingbannerArr(3,0)
	end if
			
	If IsArray(arrList) Then

		'시작태그 출력
		Response.Write "<div class='section exhibitV17'><div class='exhibit-slideV17'>"
		For intI = 0 To ubound(arrlist,2)-1
			'배너 번호는 한판에 1~9까지 총 3판
			bannerNum = intI+1
			if intI = 7 then
				bannerNum = bannerNum+1
			end if
			if intI >= 8 and intI <= 16 then
				bannerNum = bannerNum-8
			elseif intI > 16 then
				bannerNum = bannerNum-17
			end if

			'MD추천, BEST 태그는 정해진 순번에 고정으로 박아넣음 feat:정진아
			select case intI
				case 0,12,22		' MD
					bannertag = " tag-recomanded"
				case 7,11,18		' BEST
					bannertag = " tag-best"
				case else
					bannertag = ""
			end select
			page_no				= arrlist(0,intI)
			evt_code			= arrlist(1,intI)
			evt_name			= arrlist(2,intI)
			evt_type			= arrlist(3,intI)
			evt_subname			= arrlist(4,intI)
			etc_itemimg			= arrlist(5,intI)
			evt_mo_listbanner	= arrlist(6,intI)
			case_type			= arrlist(7,intI)
			new_yn				= arrlist(8,intI)
			issale				= arrlist(9,intI)
			iscoupon			= arrlist(10,intI)
			ABcase_type			= case_type

			'//이벤트 명 할인이나 쿠폰시
		    dim tmpename
		    If issale Or iscoupon Then
			    tmpename = Split(evt_name,"|") 
			  			 
			  	if Ubound(tmpename)>0 then
				    evt_name = tmpename(0)
				    evt_name_sale = tmpename(1)
				end if
			End If 
			 
			if intI = 0 or intI = 8 or intI = 17 then
				Response.Write "<ul class='exhibit-bnr-listV17'>"
			end if

			if intI = 6 then	'1판 7번째 자리 마케팅배너
				If IsArray(mktbannerArr) Then
%>
					<li class="exhibit-bnr07">
						<a href="/event/eventmain.asp?eventid=<%= mkt_evtcode %>&gaparam=main_topbanner_17&rc=<%=ABcase_type%>">
							<p class="tag"><span></span></p>
							<p class="imgOverV15"><img src="<%=mkt_imgurl %>" alt="<%= mkt_title %>" /></p>
							<strong><span><%= mkt_title %></span></strong>
							<% if mkt_subcopyK <> "" then %>
								<p class="sub-copy"><%= stripHTML(mkt_subcopyK) %></p>
							<% end if %>
						</a>
					</li>
<%
				end if
			end if
				
			if intI = 19 then	'3판 3번째 자리 playing배너
				If IsArray(playingbannerArr) Then
%>
					<li class="exhibit-bnr03 bnr-playing" style="background-color:#<%= playing_bgcolor %>">
						<a href="/playing/view.asp?didx=<%= playing_idx %>&gaparam=main_topbanner_33&rc=<%=ABcase_type%>">
							<p class="tag"><span></span></p>
							<p class="thumbnail"><img src="<%= playing_imgurl %><%= thumimgsize300 %>" alt="<%= playing_title %>" /></p>
							<strong><img src="http://fiximage.10x10.co.kr/web2017/main/subtit_playing.png" alt="PLAYing" /></strong>
							<p class="sub-copy"><%= playing_title %></p>
						</a>
					</li>
<%
				end if
			end if

			if  intI = 6 then
				bannerNum = bannerNum+1
			elseif intI >= 19 then
				bannerNum = bannerNum+1
			end if
%>
				<li class="exhibit-bnr0<%=bannerNum%> <%= bannertag %>"><%' 1:MD, 8:BEST, 12:BEST, 13:MD, 19:BEST, 23:MD %>
					<a href="/event/eventmain.asp?eventid=<%=evt_code%>&gaparam=main_topbanner_<%= page_no&bannerNum%>&rc=<%=ABcase_type%>">
						<p class="tag"><span></span></p>
						<% if bannerNum = 1 or bannerNum = 3 or bannerNum = 8 then %>
							<p class="imgOverV15"><img src="<%=etc_itemimg %><%= thumimgsize300 %>" alt="<%= evt_name %>" /></p>
						<% else %>
							<p class="imgOverV15"><img src="<%=evt_mo_listbanner %>" alt="<%= evt_name %>" /></p>
						<% end if %>

						<strong><span><%= stripHTML(evt_name) %></span><% if issale and evt_name_sale <> "" then %> <em <%=chkIIF(iscoupon," class='cGr0V17'"," class='cRd0V15'")%>><%= evt_name_sale %></em><% end if %></strong>

						<% if evt_subname <> "" then %>
							<p class="sub-copy"><% if evt_type <> "" then %><span <%=chkIIF(iscoupon," class='cGr0V17'","")%>><%= evt_type %></span><% end if %><%= stripHTML(evt_subname) %></p>
						<% end if %>
					</a>
				</li>
<%
			if intI = 7 or intI = 16 or intI = 25 then
				Response.Write "</ul>"
			end if
		Next

		'종료태그 출력
		Response.Write "</div></div>"
	End If 

	on Error Goto 0
	
	call fn_AddIISAppendToLOG("&ab=014_"&ABcase_type)
%>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
//개인화 페이지 start change
$(function() {
	$('.exhibit-slideV17').slidesjs({
		width:980,
		height:848,
		start:<%=RetVal%>,
		navigation:{active:true, effect:"fade"},
		pagination:{active:true, effect:"fade"},
		play:{active:false, interval:4000, effect:"fade", auto:false, pauseOnHover:true},
		effect:{
			fade:{speed:750, crossfade:true}
		}
	});
	//기획전 자동화 영역 타이틀 글자수 조정(2017-10-30)
	$('.exhibit-bnr-listV17 li').each(function(){
		if ($(this).children('a').children('strong').children('em').length == 1) {
			$(this).children("a").children('strong').find('span').css('max-width','80%');
		}
	});
	//기획전 자동화 영역 태그 텍스트(2017-10-30)
	$('.exhibit-bnr-listV17 li').each(function(){
		if ($(this).hasClass('tag-recomanded')) {
			$(this).children("a").children('.tag').children('span').text('MD추천');
		} else if ($(this).hasClass('tag-best')) {
			$(this).children("a").children('.tag').children('span').text('BEST');
		}
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->