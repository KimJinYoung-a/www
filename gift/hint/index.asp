<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.09 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim chint, i, j, currentdate, itemarr1, itemarr2, themeidx, vSort
	themeidx = getNumeric(requestcheckvar(request("themeidx"),10))
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script language='javascript'>

function searchtheme(themeidx){
	location.replace('/gift/hint/index.asp?themeidx='+themeidx)
}

$(function(){
	if ($.browser.msie && parseInt($.browser.version, 10) === 7) {
		console.log();
	} else {
		$("#giftHint .hint:nth-child(odd)").find("ul").addClass("left");
		$("#giftHint .hint:nth-child(even)").find("ul").addClass("right");
	}

	$("#giftHint .hint .box ul li .btnmore").hide();
	$("#giftHint .hint .box ul li").mouseover(function(){
		$(this).find(".btnmore").fadeIn("fast");
	});
	$("#giftHint .hint .box ul li").mouseleave(function(){
		$(this).find(".btnmore").fadeOut("fast");
	});
});

function itemwrite(itemid){
	frmtalk.ritemid.value=itemid;
	frmtalk.submit();
}

//검색페이지 보기
function gogifttalksearch(itemid){
	location.href="/gift/talk/search.asp?itemid="+itemid
}

</script>
</head>
<body>
<div id="giftWrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container giftSection">
		<div id="contentWrap">
			<div class="head">
				<!-- #include virtual="/gift/inc_gift_menu.asp" -->
			</div>

			<h3 class="hidden">GIFT HINT</h3>

			<div id="giftHint" class="giftHint">
				<%
				currentdate = date()

				SET chint = new CGiftTalk
					chint.frectexecutedate = currentdate
					chint.frectthemeidx = themeidx
					chint.fitemtop = 7
					'chint.getGifthint_notpaging		'메인디비
					chint.getGifthint_notpaging_B		'캐쉬디비
				%>				
				<% ' <!-- for dev msg : 각 카테고리에 해당하는 him, teen, baby, her, home 클래스명 넣어주세요.ex) <div class="hint him">....</div> --> %>
				<% if chint.FResultCount > 0 then %>
					<% for i = 0 to chint.FResultCount - 1 %>
					<% if dateconvert(now()) > currentdate & " " & chint.FItemList(i).fexecutetime then %>
						<% if chint.FItemList(i).fitemarr<>"" then %>
							<div class="hint <%= Lcase(getthemetype(chint.FItemList(i).Fthemetype)) %>">
								<div class="line"></div>
								<div class="topic">
									<h4><a href="" onclick="searchtheme('<%= chint.FItemList(i).Fthemetype %>'); return false;"><span></span><%= getthemetype(chint.FItemList(i).Fthemetype) %></a></h4>
									<span class="time">
										<%= getRegTimeTerm(currentdate & " " & chint.FItemList(i).fexecutetime,1) %>
									</span>
								</div>
								<div class="box">
									<p class="desc"><span></span><%= chint.FItemList(i).Ftitle %></p>
									<ul>
										<%
										itemarr1="" : itemarr2=""
										itemarr1 = split(chint.FItemList(i).fitemarr,"|^|")

										if isarray(itemarr1) then
											for j = 0 to ubound(itemarr1)
											itemarr2 = split(replace(itemarr1(j),"^|",""),"|*|")
											
											if isarray(itemarr2) then
										%>
												<li>
													<a href="" onclick="TnGotoProduct('<%= itemarr2(0) %>'); return false;">
													<% if j = 0 then %>
														<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemarr2(0))&"/"&itemarr2(1),370,370,"true","false") %>" alt="<%= itemarr2(0) %>" />
													<% else %>
														<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemarr2(0))&"/"&itemarr2(1),180,180,"true","false") %>" alt="<%= itemarr2(0) %>" width='180' height='180' />
													<% end if %>
													</a>

													<span class="btnmore">
														<% ' <!-- for dev msg : 해당 상품에 쓰여진 기프트 톡 갯수 카운팅입니다. 100이상이면 99+로 표시해주세요. --> %>
														<a href="" onclick="gogifttalksearch('<%= itemarr2(0) %>'); return false;">보기 
														<strong>
															<% if itemarr2(7)>=100 then %>
																99+
															<% else %>
																<%= itemarr2(7) %>
															<% end if %>
														</strong></a>
														<a href="" onclick="itemwrite('<%= itemarr2(0) %>'); return false;">쓰기</a>
													</span>
												</li>
										<%
											end if
											next
										end if
										%>
									</ul>
								</div>
							</div>
						<% end if %>
					<% end if %>
					<% next %>
				<% end if %>
				<% set chint=nothing %>

				<%
				currentdate = dateadd("d",currentdate,-1)

				SET chint = new CGiftTalk
					chint.frectexecutedate = currentdate
					chint.frectthemeidx = themeidx
					chint.fitemtop = 7
					'chint.getGifthint_notpaging		'메인디비
					chint.getGifthint_notpaging_B		'캐쉬디비
				%>				
				<% ' <!-- for dev msg : 각 카테고리에 해당하는 him, teen, baby, her, home 클래스명 넣어주세요.ex) <div class="hint him">....</div> --> %>
				<% if chint.FResultCount > 0 then %>
					<% for i = 0 to chint.FResultCount - 1 %>
					<% if dateconvert(now()) > currentdate & " " & chint.FItemList(i).fexecutetime then %>
						<% if chint.FItemList(i).fitemarr<>"" then %>
							<div class="hint <%= Lcase(getthemetype(chint.FItemList(i).Fthemetype)) %>">
								<div class="line"></div>
								<div class="topic">
									<h4><a href="" onclick="searchtheme('<%= chint.FItemList(i).Fthemetype %>'); return false;"><span></span><%= getthemetype(chint.FItemList(i).Fthemetype) %></a></h4>
									<span class="time">
										<%= getRegTimeTerm(currentdate & " " & chint.FItemList(i).fexecutetime,1) %>
									</span>
								</div>
								<div class="box">
									<p class="desc"><span></span><%= chint.FItemList(i).Ftitle %></p>
									<ul>
										<%
										itemarr1="" : itemarr2=""
										itemarr1 = split(chint.FItemList(i).fitemarr,"|^|")

										if isarray(itemarr1) then
											for j = 0 to ubound(itemarr1)
											itemarr2 = split(replace(itemarr1(j),"^|",""),"|*|")
											
											if isarray(itemarr2) then
										%>
												<li>
													<a href="" onclick="TnGotoProduct('<%= itemarr2(0) %>'); return false;">
													<% if j = 0 then %>
														<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemarr2(0))&"/"&itemarr2(1),370,370,"true","false") %>" alt="<%= itemarr2(0) %>" />
													<% else %>
														<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemarr2(0))&"/"&itemarr2(1),180,180,"true","false") %>" alt="<%= itemarr2(0) %>" width='180' height='180' />
													<% end if %>
													</a>

													<span class="btnmore">
														<% ' <!-- for dev msg : 해당 상품에 쓰여진 기프트 톡 갯수 카운팅입니다. 100이상이면 99+로 표시해주세요. --> %>
														<a href="" onclick="gogifttalksearch('<%= itemarr2(0) %>'); return false;">보기 
														<strong>
															<% if itemarr2(7)>=100 then %>
																99+
															<% else %>
																<%= itemarr2(7) %>
															<% end if %>
														</strong></a>
														<a href="" onclick="itemwrite('<%= itemarr2(0) %>'); return false;">쓰기</a>
													</span>
												</li>
										<%
											end if
											next
										end if
										%>
									</ul>
								</div>
							</div>
						<% end if %>
					<% end if %>
					<% next %>
				<% end if %>
				<% set chint=nothing %>

				<%
				currentdate = dateadd("d",currentdate,-1)

				SET chint = new CGiftTalk
					chint.frectexecutedate = currentdate
					chint.frectthemeidx = themeidx
					chint.fitemtop = 7
					'chint.getGifthint_notpaging		'메인디비
					chint.getGifthint_notpaging_B		'캐쉬디비
				%>				
				<% ' <!-- for dev msg : 각 카테고리에 해당하는 him, teen, baby, her, home 클래스명 넣어주세요.ex) <div class="hint him">....</div> --> %>
				<% if chint.FResultCount > 0 then %>
					<% for i = 0 to chint.FResultCount - 1 %>
					<% if dateconvert(now()) > currentdate & " " & chint.FItemList(i).fexecutetime then %>
						<% if chint.FItemList(i).fitemarr<>"" then %>
							<div class="hint <%= Lcase(getthemetype(chint.FItemList(i).Fthemetype)) %>">
								<div class="line"></div>
								<div class="topic">
									<h4><a href="" onclick="searchtheme('<%= chint.FItemList(i).Fthemetype %>'); return false;"><span></span><%= getthemetype(chint.FItemList(i).Fthemetype) %></a></h4>
									<span class="time">
										<%= getRegTimeTerm(currentdate & " " & chint.FItemList(i).fexecutetime,1) %>
									</span>
								</div>
								<div class="box">
									<p class="desc"><span></span><%= chint.FItemList(i).Ftitle %></p>
									<ul>
										<%
										itemarr1="" : itemarr2=""
										itemarr1 = split(chint.FItemList(i).fitemarr,"|^|")

										if isarray(itemarr1) then
											for j = 0 to ubound(itemarr1)
											itemarr2 = split(replace(itemarr1(j),"^|",""),"|*|")
											
											if isarray(itemarr2) then
										%>
												<li>
													<a href="" onclick="TnGotoProduct('<%= itemarr2(0) %>'); return false;">
													<% if j = 0 then %>
														<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemarr2(0))&"/"&itemarr2(1),370,370,"true","false") %>" alt="<%= itemarr2(0) %>" />
													<% else %>
														<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemarr2(0))&"/"&itemarr2(1),180,180,"true","false") %>" alt="<%= itemarr2(0) %>" width='180' height='180' />
													<% end if %>
													</a>

													<span class="btnmore">
														<% ' <!-- for dev msg : 해당 상품에 쓰여진 기프트 톡 갯수 카운팅입니다. 100이상이면 99+로 표시해주세요. --> %>
														<a href="" onclick="gogifttalksearch('<%= itemarr2(0) %>'); return false;">보기 
														<strong>
															<% if itemarr2(7)>=100 then %>
																99+
															<% else %>
																<%= itemarr2(7) %>
															<% end if %>
														</strong></a>
														<a href="" onclick="itemwrite('<%= itemarr2(0) %>'); return false;">쓰기</a>
													</span>
												</li>
										<%
											end if
											next
										end if
										%>
									</ul>
								</div>
							</div>
						<% end if %>
					<% end if %>
					<% next %>
				<% end if %>
				<% set chint=nothing %>

				<form name="frmtalk" method="post" action="/gift/talk/write.asp" style="margin:0px;">
				<input type="hidden" name="isitemdetail" value="o">
				<input type="hidden" name="ritemid">
				</form>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->