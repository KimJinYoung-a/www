<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 이왕 이렇게 된 거! 코멘트 이벤트
' History : 2021.07.22 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eventStartDate, eventEndDate, LoginUserid, mktTest
dim eCode, currentDate

IF application("Svr_Info") = "Dev" THEN
	eCode = "108379"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "113032"
    mktTest = True
Else
	eCode = "113032"
    mktTest = False
End If

eventStartDate  = cdate("2021-07-26")		'이벤트 시작일
eventEndDate 	= cdate("2021-08-08")		'이벤트 종료일

LoginUserid		= getencLoginUserid()

if mktTest then
    currentDate = cdate("2021-07-26")
else
    currentDate = date()
end if
%>
<style>
/* common */
.evt113032 .section{position:relative;}
.evt113032 .section .center{width:1140px;height:100%;margin:0 auto;position:relative;}
.evt113032 .float{position:absolute;top:500px;left:50%;margin-left:600px;animation:updown 0.8s ease-in-out alternate infinite;z-index:9;}
.evt113032 .float.active{position:fixed;top:50px;}
.evt113032 .float.finish{position:absolute;top:4354px;}

/* section01 */
.evt113032 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/title.jpg?v=2) no-repeat 50% 0;height:1133px;}
.evt113032 .section01 .title_img{position:absolute;top:215px;right:48px;width:400px;}
.evt113032 .section01 .title_img .slide03 img{margin-top:50px;}
.evt113032 .section01 .title_img img{margin:0 auto;}
.evt113032 .section01 .title_txt{position:absolute;top:310px;left:60px;width:350px;}
.evt113032 .section01 .title_txt img{margin:0 auto;}
.evt113032 .section01 .click{position:absolute;top:520px;right:80px;}
.evt113032 .section01 .click:hover{transform:scale(1.5);cursor: pointer;}

/* section02 */
.evt113032 .section02{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/staff.jpg?v=2) no-repeat 50% 0;height:460px;}
.evt113032 .section02 .smile{width:72px;height:72px;background:url("//webimage.10x10.co.kr/fixevent/event/2021/113032/smile01.png")no-repeat 0 0;position:absolute;top:115px;right:205px;}
.evt113032 .section02 .smile.on{background:url("//webimage.10x10.co.kr/fixevent/event/2021/113032/smile02.png")no-repeat 0 0;}
.evt113032 .section02 .twinkle{width:77px;height:80px;background:url("//webimage.10x10.co.kr/fixevent/event/2021/113032/twinkle.png")no-repeat 0 0;position:absolute;bottom:37px;left:200px;}
.evt113032 .section02 .twinkle.on{left:250px;}

/* section03 */
.evt113032 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/eunji.jpg?v=2) no-repeat 50% 0;height:720px;}
.evt113032 .section03 .eunji{width:176px;position:absolute;bottom:18px;right:120px;}

/* section04 */
.evt113032 .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/jihye.jpg?v=2) no-repeat 50% 0;height:710px;}
.evt113032 .section04 .jihye{width:176px;position:absolute;bottom:18px;right:-30px;}

/* section05 */
.evt113032 .section05{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/star.jpg?v=2) no-repeat 50% 0;height:710px;}
.evt113032 .section05 .star{width:176px;position:absolute;bottom:20px;right:120px;}

/* section06 */
.evt113032 .section06{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/hyunji.jpg?v=2) no-repeat 50% 0;height:830px;}
.evt113032 .section06 .hyunji{width:176px;position:absolute;bottom:145px;right:-30px;}

/* section07 */
.evt113032 .section07{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/plan.jpg?v=2) no-repeat 50% 0;height:860px;}

/* section08 */
.evt113032 .section08{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/input.jpg?v=3) no-repeat 50% 0;height:1260px;text-align:left;}
.evt113032 .section08 .name{position:absolute;top:380px;left:304px;font-size:30px;text-align:left;color:#fff;font-weight:bold;}
.evt113032 .section08 .name span{text-decoration: underline;}
.evt113032 .section08 form{position:absolute;top:555px;left:304px;}
.evt113032 .section08 form input{width:203px;height:65px;margin-right:72px;margin-bottom:45px;font-size:26px;background:transparent;text-indent: 10px;color:#2242e4;}
.evt113032 .section08 form input:last-child{display:block;}
.evt113032 .section08 .btn_popup{width:600px;height:120px;display:block;position:absolute;top:852px;left:50%;margin-left:-300px;}

/* section09 */
.evt113032 .section09{background:#2242e4;overflow: hidden;padding-top:30px;}
.evt113032 .section09 .comment{float:left;width:380px;height:320px;position:relative;}
.evt113032 .section09 .comment img{margin-left:-47px;margin-top:-47px;}
.evt113032 .section09 .name{position:absolute;top:90px;font-size:17px;left:50px;color:#2242e4;font-weight:bold;}
.evt113032 .section09 .name span{text-decoration: underline;}
.evt113032 .section09 .resolve{position:absolute;top:130px;left:50px;font-size:24px;line-height:1;text-align:left;}
.evt113032 .section09 .resolve p{margin-bottom:10px;color:#8999ea;font-weight:bold;}
.evt113032 .section09 .resolve p span{color:#2242e4;text-decoration: underline;}
.evt113032 .section09 .delete{position:absolute;top:120px;right:30px;}

/* section10 */
.evt113032 .section10{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/more.jpg?v=3) no-repeat 50% 0;height:224px;cursor: pointer;}

/* section11 */
.evt113032 .section11{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113032/notice.jpg?v=2) no-repeat 50% 0;height:469px;}

/* popup */
.evt113032 .popup{z-index: 10;}
.evt113032 .bg_dim{position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.6);z-index:20;}
.evt113032 .popup .pop{position:fixed;top:150px;left:50%;width:820px;margin-left:-410px;z-index:21;text-align:left;}
.evt113032 .popup .pop .name{position:absolute;top:350px;left:266px;font-size:24px;color:#2242e4;font-weight:bold;}
.evt113032 .popup .pop .name span{text-decoration: underline;}
.evt113032 .popup .pop .resolve{position:absolute;top:400px;left:266px;font-size:26px;line-height:30px;}
.evt113032 .popup .pop .resolve p{margin-bottom:10px;color:#8999ea;font-weight:bold;}
.evt113032 .popup .pop .resolve p span{color:#2242e4;text-decoration: underline;}
.evt113032 .popup .pop .btn_close{width:80px;height:80px;position:absolute;top:0;right:0;}

@keyframes updown {
    0% {transform: translateY(-15px);}
    100% {transform: translateY(15px));}
}
</style>
<script>
$(function(){
	$(window).scroll(function(){
        var $height = $(window).scrollTop();
        if($height > 700 && $height < 4700){
            $(".float").addClass("active");
			$(".float").removeClass("finish");
        }else if($height > 4701){
            $(".float").removeClass("active");
            $(".float").addClass("finish");
        }else{
            $(".float").removeClass("active");
        }
    });

    // $('.title_img, .title_txt').slick({
	// 	autoplay:true,
    //     autoplaySpeed:1700,
	// 	pauseOnHover:false,
	// });

	var myImage=document.getElementById("title_img");
	var imageArray=[
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide01.png?v=3",
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide02.png?v=3",
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide03.png?v=3",
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide04.png?v=3"];
	var imageIndex=0;

	function changeImage(){
	myImage.setAttribute("src",imageArray[imageIndex]);
	imageIndex++;
	if(imageIndex>=imageArray.length){
	imageIndex=0;
	}
	}
	setInterval(changeImage,1000);

	var myImage2=document.getElementById("title_txt");
	var imageArray2=[
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t01.png?v=2",
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t02.png?v=2",
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t03.png?v=2",
		"//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t04.png?v=2"];
	var imageIndex2=0;

	function changeImage2(){
	myImage2.setAttribute("src",imageArray2[imageIndex2]);
	imageIndex2++;
	if(imageIndex2>=imageArray2.length){
	imageIndex2=0;
	}
	}
	setInterval(changeImage2,1000);

	$('.eunji, .jihye, .star, .hyunji').slick({
		autoplay:true,
        autoplaySpeed:1700,
		pauseOnHover:true,
	});

	setInterval(function(){
        $(".smile, .twinkle").toggleClass("on");
    },1000);

    $(".btn_close").click(function(){
        $(".popup").css("display","none");
        return false;
    });
    doViewComment();
});

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}

function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>

        if($("#txt1").val()==""){
			alert("코멘트를 입력해 주세요.");
            $("#txt1").focus();
			return false;
		};
        if($("#txt2").val()==""){
			alert("코멘트를 입력해 주세요.");
            $("#txt2").focus();
			return false;
		};
        if($("#txt3").val()==""){
			alert("코멘트를 입력해 주세요.");
            $("#txt3").focus();
			return false;
		};
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript113032.asp",
            data: {
                mode: 'add',
                txt1: $("#txt1").val(),
                txt2: $("#txt2").val(),
                txt3: $("#txt3").val()
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>');
                    $(".popup").css("display","block");
                    $("#txtview1").empty().html($("#txt1").val());
                    $("#txtview2").empty().html($("#txt2").val());
                    $("#txtview3").empty().html($("#txt3").val());
                    $("#txt1").val("");
                    $("#txt2").val("");
                    $("#txt3").val("");
                    doResetViewComment();
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}

function doResetViewComment(){
    $.ajax({
        type: "POST",
        url:"/event/etc/inc_113032list.asp",
        data: {
            currentPage: 1
        },
        success: function(Data){
            if(Data != ""){
                $("#commentList").html(Data);
            }
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
        }
    });
}

function doViewComment(){
    $.ajax({
        type: "POST",
        url:"/event/etc/inc_113032list.asp",
        data: {
            currentPage: $("#page").val()
        },
        success: function(Data){
            if(Data != ""){
                $("#commentList").append(Data);
            }
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
        }
    });
}

function fnDelComment(obj){
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript113032.asp",
            data: {
                mode: 'del',
                idx: obj
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    alert("내용이 삭제되어 응모가 취소되었습니다.\n응모를 원하시면 다시 작성해주세요.");
                    $("#c"+obj).hide();
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}

function fnCheckLength(el,len){
    if(el.value.length > len){
        el.value = el.value.substr(0, len);
    }
}

function jsGoComPage(){
    $("#page").val(Number($("#page").val())+1);
    doViewComment();
    return false;
}
</script>
						<div class="evt113032">
							<section class="section section01">
								<div class="center">
									<div class="title_img">
										<img id="title_img" src="" alt="">
										<!-- <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide01.png?v=3" alt=""></div>
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide02.png?v=3" alt=""></div>
										<div class="slide03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide03.png?v=3" alt=""></div>
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide04.png?v=3" alt=""></div> -->
									</div>
									<div class="title_txt">
										<img id="title_txt" src="" alt="">
										<!-- <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t01.png" alt=""></div>
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t02.png" alt=""></div>
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t03.png" alt=""></div>
										<div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/slide_t04.png" alt=""></div> -->
									</div>
									<p class="click"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/click.png" alt=""></p>
								</div>								
							</section>
							<section class="section section02">
								<div class="center">
									<p class="smile"></p>
									<p class="twinkle"></p>
								</div>								
							</section>
							<section class="section section03">
								<div class="center">
									<div class="eunji">
										<div><a href="/shopping/category_prd.asp?itemid=3581275&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/eun01.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=2783164&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/eun02.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=1628870&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/eun03.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3880254&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/eun04.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=2653277&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/eun05.png" alt=""></a></div>
									</div>
								</div>								
							</section>
							<section class="section section04">
								<div class="center">
									<div class="jihye">
										<div><a href="/shopping/category_prd.asp?itemid=3248594&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/ji01.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3852494&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/ji02.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3536345&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/ji03.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3726255&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/ji04.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3059288&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/ji05.png" alt=""></a></div>
									</div>
								</div>								
							</section>
							<section class="section section05">
								<div class="center">
									<div class="star">
										<div><a href="/shopping/category_prd.asp?itemid=3717869&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/star01.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3930656&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/star02.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3922860&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/star03.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3016904&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/star04.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3700043&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/star05.png" alt=""></a></div>
									</div>
								</div>								
							</section>
							<section class="section section06">
								<div class="center">
									<div class="hyunji">
										<div><a href="/shopping/category_prd.asp?itemid=3568029&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/hyun01.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3728726&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/hyun02.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3823913&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/hyun03.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3646229&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/hyun04.png" alt=""></a></div>
										<div><a href="/shopping/category_prd.asp?itemid=3823925&pEtr=113032"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/hyun05.png" alt=""></a></div>
									</div>
								</div>								
							</section>
							<section class="section section07" id="go_button"></section>
							<section class="section section08" id="eventJoin">
								<div class="center">
									<p class="name"><span><% if GetLoginUserName()<>"" then %><%=GetLoginUserName()%><% else %>고객<% end if %></span> 님의 다짐!</p>
									<form action="">
										<input type="text" id="txt1" placeholder="달리기" onKeyUp="fnCheckLength(this,4);">
										<input type="text" id="txt2" placeholder="하루" onKeyUp="fnCheckLength(this,4);">
										<input type="text" id="txt3" placeholder="30분씩" onKeyUp="fnCheckLength(this,10);">
									</form>
									<a href="" onclick="doAction();return false;" class="btn_popup"></a>
								</div>								
							</section>
							<section class="section section09">
								<div class="center" id="commentList"></div>
							</section>
							<section class="section section10" onclick="jsGoComPage();return false;"><input type="hidden" id="page" value="1"></section>
							<section class="section section11"></section>
							<div class="float"><a href="#go_button"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/float.png?v=2" alt=""></a></div>
							<div class="popup" style="display:none;">
								<div class="bg_dim"></div>
								<div class="pop">
									<img src="//webimage.10x10.co.kr/fixevent/event/2021/113032/popup.png" alt="">
									<p class="name"><span><%=GetLoginUserName()%></span> 님의 다짐!</p>
									<div class="resolve">
										<p>이왕 이렇게 된 거</p>
										<p><span id="txtview1"></span>을/를 <span id="txtview2"></span>에</p>
										<p><span id="txtview3"></span> 해볼까</p>
									</div>
									<a href="#" class="btn_close"></a>
								</div>
							</div>
                        </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->