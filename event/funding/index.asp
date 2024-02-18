<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2019 펀딩템 기획전
' History : 2019-04-15 최종원 생성
'####################################################
%>
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
                Response.Redirect "http://m.10x10.co.kr/event/funding/"
                REsponse.End
            end if
        end if
    end if

	Dim vCurrPage 
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1
	

	dim myWishArr, sqlStr
	dim i, userid , vRs , objCmd

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
@import url('https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css');
.fundingtem {position: relative; padding-bottom: 50px; font-family: 'Nanum Barun Gothic', '나눔바른고딕', 'roboto', sans-serif; font-size: 13px; font-weight: 500;}
.fundingtem .inner {width: 1140px; margin: 0 auto; }
.fundingtem a:hover {text-decoration: none;}
.fundingtem .topic {position: relative; width: 100%; height: 470px; }
.fundingtem .topic .txt {position: absolute; top:0; left: 50%; width:1140px; margin-left:-570px;} 
.fundingtem .topic .txt h2 {margin-top: 70px;}
.fundingtem .topic .txt p {margin-top:37px; font-size: 15px; letter-spacing: 0.5px; color: #cf59ff;}
.fundingtem .topic .txt span {position: absolute; right: 0; bottom: 0; line-height: 1.77; color: #2a1c6c;}
.fundingtem .topic .txt span b {display: block;}
.fundingtem .topic ul {overflow: hidden;}
.fundingtem .topic li {position: relative; height: 470px; }
.fundingtem .topic .slick-slide {display:block; float:left; height:470px; outline:none}
.fundingtem .topic .slick-slide p {position: absolute; top: 0; left: 0; width: 0; height: 470px; overflow: hidden; }
.fundingtem .topic .slick-active p {animation: slidebg .7s both linear ;  transform-origin: 100% 0; }
.fundingtem .topic .slick-slide span {position: absolute; display: none; top: 0; left: 50%; margin-left: -960px; }
.fundingtem .topic .slick-active span {animation: slideimg 4.6s 1s both ease-out ; transform: translateX(-10px); transform-origin: 0 0; opacity: 0; display: block;}
.slick-slide,
.slick-slide p {background-size: cover;}
.slide-01 {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/funding/bg_funding3.jpg);}
.slide-02 {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/funding/bg_funding1.jpg);}
.slide-03 {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/funding/bg_funding2.jpg);}
.slide-01 p {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/funding/bg_funding1.jpg);}
.slide-02 p {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/funding/bg_funding2.jpg);}
.slide-03 p {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/funding/bg_funding3.jpg);}
.fundingtem .sorting-bar { margin: 45px 0 22px;  *zoom:1}
.fundingtem .sorting-bar:after {display:block; clear:both; content:'';} 
.fundingtem .sorting-bar li {display: inline-block; margin-right: 20px;}
.fundingtem .sorting-bar li:last-child {margin-right:0;}
.fundingtem .sorting-bar li a {position: relative; color: #b0b0b0; font-weight: bold;}
.fundingtem .sorting-bar li.on a {color: #342b78;}
.fundingtem .sorting-bar li.on a:after {content: ''; position: absolute; bottom: -2px; left: 0; width: 100%; height: 1px; background-color: #342b78;}
.fundingtem .sorting-bar li:not(.on):hover a:after {content: ''; position: absolute; bottom: -2px; left: 0; width: 100%; height: 1px; background-color: #b0b0b0;}
.fundingtem .items li {width: 360px; height: 478px; overflow: hidden; margin-bottom: 40px; margin-left: 20px;}
.fundingtem .items li .pic {position: relative; display: block; overflow: hidden; height: 360px; box-sizing: border-box;}
.fundingtem .items li .pic .thumbnail {width: 360px; height: 360px;}
.fundingtem .items li .pic .desc {position: absolute; bottom: 0; width: 100%; height: 47px; color: #fff; background-color: rgba(0, 0, 0, 0.2); *zoom:1} 
.fundingtem .items li .pic .desc:after {display:block; clear:both; content:'';} 
.fundingtem .items li .pic .desc .name {float: left; display:inline-block; height: 47px; width: 255px; padding: 0 15px; letter-spacing:0; box-sizing: border-box;}
.fundingtem .items li .pic .desc .name span {width: 100%; line-height: 47px; }
.fundingtem .items li .pic .desc .btn-wish {float: right; display:inline-block; max-width:105px; height:47px; margin:0; background-color:transparent; text-align:center;}
.fundingtem .items li .pic .desc .btn-wish span {display: block; height: 20px; line-height: 20px; padding: 0 15px; text-align: left; text-indent: 11px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/funding/ico_heart.png); background-size: 20px auto; background-repeat:no-repeat; background-position:0 2px; color:#fff; font-weight:500;}
.fundingtem .items li .pic .desc .btn-wish.on span {background-position:0 -31px; }
.fundingtem .items li .txt {padding: 15px 15px 0;}
.fundingtem .items li .txt p {display: inline-block; overflow: hidden; width: 100%; height: 25px; margin-bottom: 5px; color: #000; font-size: 16px; font-weight: bold; letter-spacing: 0.5px; text-overflow: ellipsis; white-space: nowrap;}
.fundingtem .items li .txt span {display: -webkit-box; overflow: hidden; width:100%; min-height: 17px; max-height: 34px; margin-bottom: 15px; color: #666; line-height: 1.38; letter-spacing: 0.5px; -webkit-line-clamp: 2; -webkit-box-orient: vertical; text-overflow: ellipsis; word-break : break-all; white-space: unset; }
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
    .fundingtem .items li .txt span {display:block;}
}
.fundingtem .items li .brand a {display: block; height: 17px; width: 100%; overflow: hidden; padding-left: 15px; box-sizing: border-box; color: #cf59ff; font-size: 11px; text-overflow: ellipsis; word-break : break-all; white-space: nowrap;}
.fundingtem .items li .brand a:hover {text-decoration: underline;}
@keyframes slideimg {
    20% {transform: translateX(0)}
    45%,85% {opacity: 1; transform: translateX(0)}
    100% {opacity: 0;  transform: translateX(100px); transform-origin: center center;}
}
@keyframes slidebg {
    100% {width: 100%;}
}
</style>
<script type="text/javascript">
$(function(){
    $('.btn-wish').click(function(e){
        $(this).toggleClass('on');
        e.preventDefault()
    });
    $('.topic ul').slick({
        autoplay: true,	//auto
        autoplaySpeed: 5500,
        speed: 0,
        arrows: true,
        infinite:true,
        pauseOnHover: false,
    });
    $(".sorting-bar ul li").click(function(){        
        var sort = $(this).attr("sort");
        
        $(this).parent().children().removeClass("on")
        $(this).addClass("on")
        
        $("#popularfrm input[name='cpg']").val(1);
        $("#popularfrm input[name='sortMet']").val(sort);
        //데이터
        $('#lySearchResult').empty()
        getList();
    });    
})
</script>
<script type="text/javascript">
    $(function(){
        $('.btn-wish').click(function(e){
		    e.stoppropagation()
        });
    });
</script>
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
	        url: "funding_act.asp",
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
        
        $(window).unbind("scroll");        
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
        <!-- CROWD FUNDING ITEM -->
        <div class="fundingtem">
            <div class="topic">
                <ul>
                    <li class="slide-01">
                        <p></p><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/funding/img_funding1.png" alt=""></span>
                    </li>
                    <li class="slide-02">
                        <p></p><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/funding/img_funding2.png?v=1.01" alt=""></span>
                    </li>
                    <li class="slide-03">
                        <p></p><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/funding/img_funding3.png" alt=""></span>
                    </li>
                </ul>
                <div class="txt">
                    <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/funding/tit_funding.png" alt="crowd funding item"></h2>
                    <p>텐바이텐에서 베스트 펀딩 상품들을 만나보세요!</p>
                    <span><b><img src="//webimage.10x10.co.kr/fixevent/event/2019/funding/txt_funding.png" alt="Funding"></b>대중으로부터 자금을 모아 프로젝트를 진행하는 소셜펀딩. <br/>펀딩 달성에 성공한 잇템들을 만나보세요.</span>
                </div>
            </div>
            <form id="popularfrm" name="popularfrm" method="get" style="margin:0px;">
            <input type="hidden" name="cpg" value="1" />				
            <input type="hidden" name="sortMet" value="1" />
            </form>            
            <div class="inner">
                <!-- sorting bar -->
                <div class="sorting-bar">
                    <ul class="ftRt">
                        <li class="on" sort=1 style="cursor:pointer;"><a>최신 등록순</a></li>
                        <li sort=4 style="cursor:pointer;"><a>베스트 펀딩템</a></li>                        
                    </ul>
                </div>
                <!-- for dev msg 페이지당 9개의 상품 보여줌-->
                <div class="items type-thumb">
                    <ul id="lySearchResult">
                    </ul>
                </div>
            </div>
        </div>
        <!-- // CROWD FUNDING ITEM -->
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->