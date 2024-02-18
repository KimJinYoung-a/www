<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 19주년 브랜드 페이지
' History : 2020-10-07 원승현
'####################################################

dim currentDate
dim eCode, vQuery

currentDate = date()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  103237
Else
	eCode   =  106390
End If
%>
<script>
$(function() {
	var brandCategory = [
		{
			cateName: 'design',
			brandInfo: [
                <%
                    vQuery = "select makerid, socname, socname_kor, frontcategory, maxsalepercent, orderby "
                    vQuery = vQuery & " FROM [db_temp].[dbo].[tbl_brandMaxSalePercent] WITH(NOLOCK) WHERE frontcategory='design' ORDER BY orderby"
                    rsget.CursorLocation = adUseClient
                    rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
                    If Not(rsget.bof or rsget.eof) Then
                        Do Until rsget.eof
                %>
                            <% If rsget("maxsalepercent") > 0 Then %>
                                <% If Trim(rsget("socname_kor"))="드롱기" Then %>
                                    {
                                        brandName: '드롱기',
                                        brandId: 'ipcltd',
                                        imgName: 'ipcltd1',
                                        salePer: <%=Formatnumber(rsget("maxsalepercent"),0)%>
                                    },
                                <% ElseIf Trim(rsget("socname_kor"))="브라운" Then %>
                                    {
                                        brandName: '브라운',
                                        brandId: 'ipcltd',
                                        imgName: 'ipcltd2',
                                        salePer: <%=Formatnumber(rsget("maxsalepercent"),0)%>
                                    },
                                <% Else %>
                                    {
                                        brandName: '<%=rsget("socname_kor")%>',
                                        brandId: '<%=rsget("makerid")%>',
                                        salePer: <%=Formatnumber(rsget("maxsalepercent"),0)%>
                                    },
                                <% End If %>
                            <% End If %>
                <%
                        rsget.movenext
                        Loop
                    End If
                    rsget.close
                %>
			]
		},
		{
			cateName: 'living',
			brandInfo: [
                <%
                    vQuery = "select makerid, socname, socname_kor, frontcategory, maxsalepercent, orderby "
                    vQuery = vQuery & " FROM [db_temp].[dbo].[tbl_brandMaxSalePercent] WITH(NOLOCK) WHERE frontcategory='living' ORDER BY orderby"
                    rsget.CursorLocation = adUseClient
                    rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
                    If Not(rsget.bof or rsget.eof) Then
                        Do Until rsget.eof
                %>
                            <% If rsget("maxsalepercent") > 0 Then %>                    
                                {
                                    brandName: '<%=rsget("socname_kor")%>',
                                    brandId: '<%=rsget("makerid")%>',
                                    salePer: <%=Formatnumber(rsget("maxsalepercent"),0)%>
                                },
                            <% End If %>
                <%
                        rsget.movenext
                        Loop
                    End If
                    rsget.close
                %>
			]
		},
		{
			cateName: 'life',
			brandInfo: [
                <%
                    vQuery = "select makerid, socname, socname_kor, frontcategory, maxsalepercent, orderby "
                    vQuery = vQuery & " FROM [db_temp].[dbo].[tbl_brandMaxSalePercent] WITH(NOLOCK) WHERE frontcategory='life' ORDER BY orderby"
                    rsget.CursorLocation = adUseClient
                    rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
                    If Not(rsget.bof or rsget.eof) Then
                        Do Until rsget.eof
                %>
                            <% If rsget("maxsalepercent") > 0 Then %>                                        
                                {
                                    brandName: '<%=rsget("socname_kor")%>',
                                    brandId: '<%=rsget("makerid")%>',
                                    salePer: <%=Formatnumber(rsget("maxsalepercent"),0)%>
                                },
                            <% End If %>                                    
                <%
                        rsget.movenext
                        Loop
                    End If
                    rsget.close
                %>
			]
		},
		{
			cateName: 'fashion',
			brandInfo: [
                <%
                    vQuery = "select makerid, socname, socname_kor, frontcategory, maxsalepercent, orderby "
                    vQuery = vQuery & " FROM [db_temp].[dbo].[tbl_brandMaxSalePercent] WITH(NOLOCK) WHERE frontcategory='fashion' ORDER BY orderby"
                    rsget.CursorLocation = adUseClient
                    rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
                    If Not(rsget.bof or rsget.eof) Then
                        Do Until rsget.eof
                %>
                            <% If rsget("maxsalepercent") > 0 Then %>                                                            
                                {
                                    brandName: '<%=rsget("socname_kor")%>',
                                    brandId: '<%=rsget("makerid")%>',
                                    salePer: <%=Formatnumber(rsget("maxsalepercent"),0)%>
                                },
                            <% End If %>                                                                        
                <%
                        rsget.movenext
                        Loop
                    End If
                    rsget.close
                %>
			]
		},
	];
	function renderBrands() {
		brandCategory.forEach(function(cate, i) {
			var $rootEl = $("#"+cate.cateName);
			var itemEle = tmpEl = ""
			$rootEl.empty();
			cate.brandInfo.forEach(function(brand, i) {
				var imgName;
				if (brand.imgName) {
					imgName = brand.imgName;
				} else {
					imgName = brand.brandId;
				}
				var tmpEl = '\
								<li>\
									<div class="brand-item">\
										<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/m/' + imgName + '.jpg" alt="' + brand.brandName + '">\
										<div class="per">~'+ brand.salePer +'%</div>\
										<a href="/street/street_brand_sub06.asp?makerid=' + brand.brandId + '"></a>\
									</div>\
								</li>\
							';
				itemEle += tmpEl;
			});
			$rootEl.append(itemEle);
		});
	}
	renderBrands();
});
</script>
<style>
.evt106390 {position:relative; background:#faeae1;}
.evt106390 .topic {background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/bg_topic.jpg) repeat center top;}
.evt106390 .brand-wrap {position:relative; overflow:hidden;}
.evt106390 .brand-list {position:relative; display:inline-block; width:1155px; margin:-20px 0 0 -3px; vertical-align:top;}
.evt106390 .brand-list::after {content:' '; display:block; clear:both;}
.evt106390 .brand-list li {width:228px; float:left; margin:20px 0 0 3px;}
.evt106390 .brand-item {position:relative; border-top:3px solid #fae7cc;}
.evt106390 .brand-item .per {height:35px; line-height:36px; font-size:20px; background:#ff694d; color:#fffdfa;}
.evt106390 .brand-item a {display:block; position:absolute; left:0; top:0; width:100%; height:100%;}
.evt106390 .bot {margin-top:140px; background:#fd5437;}
</style>
<%' <!-- 19주년 참여 브랜드 106390 --> %>
<div class="evt106390">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/tit_brands.png" alt="19주년 프렌즈 세일"></h2>
    </div>
    <section id="">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/tit_design.png" alt="Design"></h3>
        <div class="brand-wrap">
            <%' <!-- for dev msg : 디자인 파트 브랜드 리스트 (20개) --> %>
            <ul id="design" class="brand-list"></ul>
        </div>
    </section>
    <section id="">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/tit_living.png" alt="Living"></h3>
        <div class="brand-wrap">
            <%' <!-- for dev msg : 리빙 파트 브랜드 리스트 (20개) --> %>
            <ul id="living" class="brand-list"></ul>
        </div>
    </section>
    <section id="">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/tit_life.png" alt="Life"></h3>
        <div class="brand-wrap">
            <%' <!-- for dev msg : 라이프 파트 브랜드 리스트 (15개) --> %>
            <ul id="life" class="brand-list"></ul>
        </div>
    </section>
    <section id="">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/tit_fashion.png" alt="Fashion"></h3>
        <div class="brand-wrap">
            <%' <!-- for dev msg : 패션 파트 브랜드 리스트 (20개) --> %>
            <ul id="fashion" class="brand-list"></ul>
        </div>
    </section>
    <p class="bot"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/txt_bot.png" alt="19th anniversary"></p>
</div>
<%' <!-- //19주년 참여 브랜드 --> %>
<!-- #include virtual="/lib/db/dbclose.asp" -->