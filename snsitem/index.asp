<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%

    '============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "http://m.10x10.co.kr/snsitem/"
                REsponse.End
            end if
        end if
    end if   

	Dim vCurrPage 
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1
	

	dim myWishArr, sqlStr
	dim i, userid , objCmd , vRs

	userid = getencLoginUserid()

	if userid <> "" then
		Set objCmd = Server.CreateObject("ADODB.COMMAND")
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdText
			.CommandText = "SELECT itemid from db_my10x10.dbo.tbl_myfavorite where userid = ? "
			.Prepared = true
			.Parameters.Append .CreateParameter("userid", adVarChar, adParamInput, Len(userid), userid)
			SET vRs = objCmd.Execute
				if not vRs.EOF then
					myWishArr = vRs.getRows()
				end if
			SET vRs = nothing
		End With
		Set objCmd = Nothing
	end if
%>
<style type="text/css">
.sns-best {background-color:#f7f7f7; font-family:"AvenirNext-Regular", "AppleSDGothicNeo-Regular", "malgun Gothic","맑은고딕";}
.sns-best .inner {width:1140px; margin:0 auto;}
.sns-top {padding:50px 0 47px; background-image:linear-gradient(to left, #9bf6ef, #94a0f6 49%, #e4a1fa); color:#fff;}
.sns-top h2 {position:relative;color:#fff; font-size:60px; line-height:1.37; letter-spacing:.9px; font-family:"AvenirNext-Regular", "AppleSDGothicNeo-Regular", "malgun Gothic","맑은고딕"; font-weight:normal;}
.sns-top h2:after {display:inline-block; position:absolute; top:0; left:448px; width:40px; height:32px; background-image:url(//fiximage.10x10.co.kr/web2019/common/img_heart.png); content:''; animation:zoomInUp .8s 1; transform-origin:0 100%;}
.sns-top h2 em {font-weight:bold;}
.sns-top .subcopy {font-size:15px;}

.sns-best .items {padding-bottom:29px;}
.sns-best .items ul {overflow:initial;}
.sns-best .items ul:after {clear:both; display:block; content:'';}
.sns-best .items li {width:320px; height:360px; margin:0 10px 40px; padding:20px; background-color:#fff;box-shadow:5px 5px 15px 0 rgba(0, 0, 0, 0.1);}
.sns-best .items li a div {position:relative;}
.sns-best .items li .thumbnail {width:100%; height:320px;}
.sns-best .items li .thumbnail img {position:relative; z-index:2; height:100%;}
.sns-best .items li .thumbnail:after {z-index:3; background-color:rgba(0,0,0,.04)}
.sns-best .items li .thumbnail:before {display:inline-block; position:absolute; top:0; left:0; z-index:5; width:100%; height:100%; background-color:rgba(0,0,0,.6); opacity:0; content:''; transition:all .6s;}
.sns-best .items li:hover .thumbnail:before {opacity:1;}
.sns-best .items li .desc {position:absolute; bottom:0; left:0; z-index:10; width:calc(100% - 95px); min-height:45px; padding:0 70px 55px 25px; color:#fff; opacity:0; transition:all .6s;}
.sns-best .items li:hover .desc {opacity:1;}
.sns-best .items .name {width:100%; height:auto; font-size:14px; line-height:1.43; font-weight:bold; text-align:left; word-break:keep-all; text-overflow:unset; white-space:normal;}
.sns-best .items .price {position:absolute; bottom:30px; left:25px; color:#fff; font-size:13px;}
.sns-best .items .price .discount.red {margin-right:3px; color:#ffa9a9;}
.sns-best .items .etc {font-size:0; line-height:1;}
.sns-best .items .etc .review {border-right:1px solid rgba(0,0,0,.1); color:#666; font-family:"roboto","AvenirNext-Medium", "AppleSDGothicNeo-Medium", "malgun Gothic","맑은고딕";}
.sns-best .items .etc .review .icon-rating span {display:inline-block; position:relative; top:2px; width:82px; height:13px; margin-right:10px; background:url(//fiximage.10x10.co.kr/web2019/common/ico_star.png) 0 0 no-repeat;}
.sns-best .items .etc .review .icon-rating span i {display:inline-block; position:absolute; top:0; left:0; z-index:10; width:82px; height:13px; background:url(//fiximage.10x10.co.kr/web2019/common/ico_star.png) 0 100% no-repeat; text-indent:-999em;}
.sns-best .items .etc .review,
.sns-best .items .etc .btn-wish{display:inline-block; width:49%; margin:21px 0; background-color:transparent; font-size:13px; line-height:18px; text-align:center;}
.sns-best .items .etc .btn-wish {margin:0; padding:21px 0;}
.sns-best .items .etc .btn-wish span {padding-left:25px; background-image:url(//fiximage.10x10.co.kr/web2019/common/ico_heart.png?v=1.02); background-repeat:no-repeat; background-position:0 2px; color:#666; font-weight:500;}
.sns-best .items .etc .btn-wish.on span {background-position:0 -15px;}

.sns-best .items li.bnr-sns {position:relative; width:360px; height:400px; padding:0; background-color:transparent; box-shadow:none;}
.sns-best .items li.bnr-sns a {display:inline-block; position:absolute; top:202px; left:90px; width:110px; height:30px; text-indent:-999em;}
.sns-best .items li.bnr-sns a:before {display:inline-block; position:absolute; bottom:6px; right:0; width:70px; height:1px; background-color:#fff; content:''; opacity:0;}
.sns-best .items li.bnr-sns a:hover:before{opacity:1;}
.sns-best .items li.bnr-sns a.insta {top:243px; width:115px;}
.sns-best .items li.bnr-sns a.insta:before {right:0; width:74px;}

.bnr-share {position:fixed; bottom:55px; left:50%; z-index:100; margin-left:-115px;}
.bnr-share ul {overflow:hidden; position:absolute; top:0; right:5%; width:34.71%; height:100%;}
.bnr-share ul li {position:relative; float:left; width:53.97%; height:100%;}
.bnr-share ul li.insta {width:46.03%;}
.bnr-share ul li:before {display:inline-block; position:absolute; left:38px; bottom:20px; width:74px; height:1px; background-color:#fff; opacity:0; content:' ';}
.bnr-share ul li:hover:before {opacity:1;}
.bnr-share ul li a {display:inline-block; width:100%; height:100%; border-bottom:solid 1px #fff; text-indent:-999em;}
@keyframes zoomInUp {
    from {opacity:0; transform:scale(0.3); animation-timing-function:cubic-bezier(0.55, 0.055, 0.675, 0.19);}
    60% {opacity:1; transform:scale(0.475); animation-timing-function:cubic-bezier(0.175, 0.885, 0.32, 1);}
}

.sorting-bar {padding:25px 0 15px; height:30px; margin-bottom:19px; border-bottom:solid 1px #eee; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif;}
.sorting-bar:after {display:block; clear:both; content:'';}
.select-boxV19 {position:relative; z-index:50; width:200px; height:28px; margin-right:10px; cursor:pointer;}
.select-boxV19 dl {height:100%;}
.select-boxV19 dt {position:relative; z-index:10; width:100%; height:100%; border:1px solid #ddd;}
.select-boxV19 dt span {display:block; position:relative; height:calc(100% - 13px); padding:6px 11px 7px; background-color:#fff; color:#666; font-size:13px; line-height:1.2; text-overflow:ellipsis; overflow:hidden; white-space:nowrap; cursor:pointer; text-align:left;}
.select-boxV19 dt i {position:absolute; top:12px; right:10px;}
.select-boxV19 dt i:before {display:inline-block; position:absolute; top:-5px; left:-9px; width:1px; height:15px; background-color:#eee; content:'';}
.select-boxV19 dd {display:none; position:absolute; z-index:5; top:31px; left:0; width:200px; border:1px solid #ddd; border-top:none; background-color:#fff;}
.select-boxV19 dd li {overflow:hidden; width:calc(100% - 22px); height:30px; padding:0 11px; color:#999; font-size:13px; line-height:2.31; text-align:left !important; text-overflow:ellipsis; white-space:nowrap; }
.select-boxV19 dd li:first-child {padding-top:5px;}
.select-boxV19 dd li:last-child {padding-bottom:5px;}
.select-boxV19 dd li:hover {background-color:#f5f5f5;}
</style>
<script type="text/javascript">
    $(function(){
        // dropdown box
        $(".select-boxV19 dt").click(function(){
            if($(".select-boxV19 dd").is(":hidden")){
                $(this).parent().children('dd').show("slide", {direction:"up"}, 300);
                $(this).addClass("over");
            }else{
                $(this).parent().children('dd').hide("slide", {direction:"up"}, 200);
                $(this).removeClass("over");
            };
        });
        $(".select-boxV19 dd li").click(function(){
            var evtName = $(this).text();
            var idx = $(this).index() + 1            
            $(this).parent().parent().parent().children('dt').children('span').empty().append(evtName);
            $(this).parent().parent().hide("slide", {direction:"up"}, 200);
            $(".select-boxV19 dt").removeClass("over");
            $("#popularfrm input[name='cpg']").val(1);
            $("#popularfrm input[name='sortMet']").val(idx);                        
            //데이터
            $('#lySearchResult').empty()
            getList();
        });
    });
    function scrollBnr(){        
        $(window).scroll(function(){
            var nowSt = $(this).scrollTop();
            var lastSt = $(".footer-wrap").offset().top*.92;
            // console.log(nowSt + "/" + lastSt);
            if ( lastSt < nowSt ) {
                $(".bnr-share").hide();
            } else {
                $(".bnr-share").show();
            }
        });
    }    
</script>
<script type="text/javascript">
    $(function(){
        $('.btn-wish').click(function(e){
		    e.stoppropagation()            
        });
    });    
</script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
var isloading=true;
var myWish = ''

<%
if isArray(myWishArr) then
	for i=0 to uBound(myWishArr,2) 
	%>
	myWish = myWish + '<%=myWishArr(0,i)%>,'
	<%
	next
end if
%>
$(function(){
	fnAmplitudeEventMultiPropertiesAction('view_snsitem_main','','');
	//첫페이지 접수
	getList();

	//스크롤 이벤트 시작
	$(window).scroll(function() {
      if ($(window).scrollTop() >= $(document).height() - $(window).height() - 350){
          if (isloading==false){
            isloading=true;
			var pg = $("#popularfrm input[name='cpg']").val();
			pg++;
			$("#popularfrm input[name='cpg']").val(pg);
            setTimeout("getList()",500);
          }
      }
    });
});

function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "snsitem_act.asp",
	        data: $("#popularfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
    	if($("#popularfrm input[name='cpg']").val()=="1") {
        	//내용 넣기			
        	$('#lySearchResult').html(str);					
        } else {        	
       		$str = $(str)       		
       		$('#lySearchResult').append($str)               
        }
        isloading=false;
        chkMyWish()        
    } else {
        //더이상 자료가 없다면 스크롤 이벤트 종료                
        $(".bnr-share").hide();
        scrollBnr();                 
        // $(window).unbind("scroll");        
    }
}
function chkMyWish(){	
    $('.item-list').each(function(index, item){
        if(myWish.indexOf($(this).attr("itemid")) > -1){
            $(this).find(".btn-wish").addClass("on")
        }        
    })
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
            <!-- sns best -->
            <div class="sns-best">
                <div class="sns-top">
                    <div class="inner">
                        <h2><em>SNS</em> BEST ITEM</h2>
                        <p class="subcopy">SNS에서 핫한 아이템, 이젠 텐바이텐에서 바로 만나보세요!</p>
                    </div>
                </div>
                
                <div class="inner">
                    <div class="sorting-bar">
                        <div class="select-boxV19 ftRt">
                            <dl>
                                <dt><span>등록 순</span><i class="arrow-bottom bottom4"></i></dt>
                                <dd style="display:none;">
                                    <ul>
                                        <li>등록 순</li>
                                        <li>NEW 아이템 순</li>
                                        <li>후기 많은 순</li>
                                        <li>위시 많은 순</li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                    </div>

                    <form id="popularfrm" name="popularfrm" method="get" style="margin:0px;">
                    <input type="hidden" name="cpg" value="1" />				
                    <input type="hidden" name="sortMet" value="1" />
                    </form>
                    <div class="inner">
                        <div class="items type-thumb">
                            <ul id="lySearchResult">
                            </ul>
                        </div>

                        <div class="bnr-share">
                            <img src="//fiximage.10x10.co.kr/web2019/common/bnr_sns.png" alt="텐바이텐 SNS 계정 팔로우하고 다양한 소식받아보세요!">
                            <ul>
                                <li class="fb"><a href="http://bit.ly/2TMmgyd" target="_blank" onclick="fnAmplitudeEventMultiPropertiesAction('click_snsitem_facebook','','');">페이스북</a></li>
                                <li class="insta"><a href="http://bit.ly/2TMn7ip" target="_blank" onclick="fnAmplitudeEventMultiPropertiesAction('click_snsitem_instar','','');">인스타그램</a></li>
                            </ul>
                        </div>
                    </div>
                </div>                    
            </div>
            <!-- sns best -->
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->