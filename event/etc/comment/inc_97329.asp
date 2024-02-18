<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : TO DO LIST
' History : 2019-09-20
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim evtStartDate, evtEndDate, currentDate, presentDate

currentDate =  date()
evtStartDate = Cdate("2019-09-19")
evtEndDate = Cdate("2019-10-13")
presentDate = Cdate("2019-12-31")

'test
'currentDate = Cdate("2019-12-31")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90389
Else
	eCode   =  97329
End If

dim userid
	userid = GetEncLoginUserID()

dim isWinner : isWinner = false
%>
<style>
.evt97329 {position: relative; overflow: hidden; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/bg.jpg);  font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif}
.evt97329 area {outline: none}
.evt97329 .hide {display: none; opacity: 0;}
.evt97329 .pos {position: relative; margin: 0 auto;}
.evt97329 .pos div {position: absolute; top: 0; left: 0; width: 100%;}
.evt97329 button {background-color: transparent; border: 0;}
.evt97329 input:focus::-webkit-input-placeholder {opacity: 0;} 
.evt97329 .topic {position: relative; height: 310px; padding-top: 95px; box-sizing: border-box;}
.evt97329 .topic h2 {position: relative; z-index: 4;}
.evt97329 .topic h2 ~ div {z-index: 3;}
.evt97329 .pos div.ani1 {top: 163px;}
.evt97329 .pos div.ani2 {top: 60px; margin-left: 240px;}
.evt97329 .topic .copy {position: absolute; bottom: 50px; top: auto; width: 100%;  color: #95530c; font-size: 1.1rem; font-weight: 500; text-align: center; line-height: 1.5;}
.evt97329 .topic .copy b {font-weight: 600;}
.evt97329 .topic .copy p {color: #663806; font-weight: bold;}
.evt97329 .todo {background: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/bg_todo.png?v=1.02) no-repeat 50% 0;}
.evt97329 .cmt-input {width: 32rem;}
.evt97329 .cmt-input button {position: absolute; bottom: 100px; left: 50%; margin-left: -180px;}
.evt97329 .cmt-input .btn-area {position: absolute; display: flex; justify-content: space-between; width: 405px; top: auto; bottom: 75px; left: 50%; margin-left: -195px;}
.evt97329 .cmt-input .btn-area button {position: static; margin-left: 0;}
.evt97329 .tit-plan {height: 73px; margin-bottom: 2.8rem; font-size: 1.8rem; font-weight: bold; text-align: center; line-height: 73px; }
.evt97329 .tit-plan b {color: #5c1af3;}
.evt97329 .list-plan li {position: relative; width: 400px; margin: 0 auto 1.25rem; font-size: 1.2rem; font-weight: 500; line-height: 3.4rem; cursor:pointer; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
.evt97329 .list-plan li .now-txt {position: absolute; bottom: -.5rem; right:.5rem; color:#999; font-size:0.8rem; font-weight: 500;}
.evt97329 .list-plan li input[type=text] {overflow:hidden; width:90%; height: 3.4rem; padding-left: 3.7rem; border:0; background-color:transparent; font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; font-size: 1.2rem; color:#444; vertical-align: 0; box-sizing: border-box;} 
.evt97329 .list-plan li input::-webkit-input-placeholder {color:#999;}
.evt97329 .list-plan li input:focus::-webkit-input-placeholder {opacity: 0;}
.evt97329 .list-plan li input[type="checkbox"] {position:absolute; width:0; height:0; opacity:0;}
.evt97329 .list-plan li input[type="checkbox"] + label {display:block; position:relative; height:3.4rem; padding-left: 0; }
.evt97329 .list-plan li input[type="checkbox"]:checked + label:before,
.evt97329 .list-plan li.checked:before {content:' '; display:inline-block; position:absolute; top:0; left:0; width:37px; height:38px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/ico_check.png) no-repeat  right center; background-size: contain;}
.evt97329 .cmt-input .list-plan li input[type="checkbox"]:checked + label:before {left: 10px;}
.evt97329 .alarm {background-color: #684bd7;}
.evt97329 .cmt-list {padding-bottom: 70px; background-color: #f5a54a;}
.evt97329 .cmt-list ul.list-area {width: 1140px; margin: 0 auto; padding-top: 60px;}
.evt97329 .cmt-list .pos {display: inline-block; width: 344px; height: 258px; margin: 0 15px 38px;}
.evt97329 .cmt-list .pos:nth-child(4n-3) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/img_cmt_4.png);}
.evt97329 .cmt-list .pos:nth-child(4n-3) b {color: #f31aa9;}
.evt97329 .cmt-list .pos:nth-child(4n-2) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/img_cmt_3.png);}
.evt97329 .cmt-list .pos:nth-child(4n-2) b {color: #291af3;}
.evt97329 .cmt-list .pos:nth-child(4n-1) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/img_cmt_1.png);}
.evt97329 .cmt-list .pos:nth-child(4n-1) b {color: #761af3;}
.evt97329 .cmt-list .pos:nth-child(4n) {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/img_cmt_2.png);}
.evt97329 .cmt-list .tit-plan {margin-bottom: 3px; font-size: 20px; line-height: 53px;}
.evt97329 .cmt-list .pos:nth-child(4n) b {color: #f33e1a;}
.evt97329 .cmt-list .list-plan li {width: 240px; padding-left: 40px; margin-bottom: 0; font-size: 17px; line-height: 53px;}
.evt97329 .cmt-list .list-plan li input[type="checkbox"]:checked + label:before,
.evt97329 .cmt-list .list-plan li.checked:before {width: 28px; background-size: contain;}
.evt97329 .pageWrapV15 .paging a, .pageWrapV15 .paging a:hover {height: 33px; margin: 5px; background-color: transparent; border: none; }
.evt97329 .pageWrapV15 .first, .pageWrapV15 .end {display: none;}
.evt97329 .paging a span {height: 28px; font-size: 18px; color: #fff; font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; line-height: 28px;}
.evt97329 .paging a.current span {width: 33px; height: 33px; padding: 0; color: #fff; background: #291af3; border-radius: 50%;}
.evt97329 .paging a.arrow span {width: 28px; height: 28px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_next.png) 0 0;}
.evt97329 .paging a.arrow.prev {transform: rotateY(180deg)}
.evt97329 .noti {position:relative; display: flex; align-items: center; padding:50px 0; background-color:#605243; text-align: center; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; font-size: 14px; }
.evt97329 .noti h3 {position: absolute; display: flex; left: 50%; margin-left: -450px; font-family: inherit; font-weight: normal; font-size: 22px; color: #fff; }
.evt97329 .noti ul {position: relative; left: 50%; width:700px; margin-left: -230px; }
.evt97329 .noti ul li {color:#fefefe; padding-left: 11px; word-break:keep-all;  text-align: left; line-height: 2.1;}
.evt97329 .noti li:before {content: '-'; display: inline-block; width: 11px; margin-left: -11px;}
.evt97329 .layerPopup {overflow:hidden; position:fixed; left:0; top:0; right:0; bottom:0; width:100%; height:100%; z-index:100000;}
.evt97329 .layerPopup .layerPopup-cont {position: absolute; z-index: 88; top: 50%; left: 50%; width: 566px;  transform: translate(-50%,-50%); text-align: center; background-color: #fff;}
.evt97329 .layerPopup .layerPopup-cont .btn-close {position: absolute; z-index: 1; top: 0; right: 0; padding: 30px;}
.evt97329 .layerPopup .layerPopup-cont .pos div {top: auto; bottom: 150px; font-size: 1.2rem; text-align: center; font-weight: 600; line-height: 1.6;}
.evt97329 .layerPopup .layerPopup-cont .pos div b {color: #fe397a;}
.evt97329 .layerPopup .layerPopup-cont button {position: absolute; bottom: 50px; left: 50%; margin-left: -158px;}
.evt97329 .layerPopup .mask {overflow:hidden; display:block; position:fixed; top:0; left:0; z-index:50; width:100%; height:100%; background:rgba(0, 0, 0, 0.5);} 
</style>
<script>
$(function(){
    swiper = new Swiper('.slide1', {
        nextButton:'.slide1 .btn-next',
	    prevButton:'.slide1 .btn-prev'
    })
    $('#layerPopup1 .mask, #layerPopup1 .btn-close ').click(function(){
        $('.layer-area').hide();
        window.$('html,body').animate({scrollTop:$("#alarm").offset().top}, 400);
        return false;
    })
});
</script>
<script type="text/javascript">
    $(function(){
        getList(1, true);
        <% If IsUserLoginOK() Then %>
        getMyComment();
        <% end if %>
    })
    function validate(){
        var chkRes = true
        $(".list-plan input[type='text']").each(function(idx, el){
            if(el.value == ''){
                alert('목표3가지를 모두 작성해주세요!');
                el.focus();
                chkRes = false
                return false;
            }
            chkRes = true
        })        
        return chkRes
    }
    function chkLogin(){
        <% If not IsUserLoginOK() Then %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";			
		}
        return false;
        <% end if %>
        return true
    }
    function jsSubmitComment(mode){
        if(!chkLogin()) return false;
        if(!validate()) return false;
        
        var payLoad = {
            mode: mode,
            eventCode: '<%=eCode%>',
            txtcomm:  $("#content1").val(),
            txtcomm2: $("#content2").val(),
            txtcomm3: $("#content3").val(),
            option1: mode == 'add' ? '0': $('input:checkbox[id="option1"]').is(':checked') ? 1 : 0,
            option2: mode == 'add' ? '0': $('input:checkbox[id="option2"]').is(':checked') ? 1 : 0,
            option3: mode == 'add' ? '0': $('input:checkbox[id="option3"]').is(':checked') ? 1 : 0,
            commentNum: 1,
            commidx: $('#my_comment').attr("idx")
        }
        // console.log(payLoad)
        // return false;
        $.ajax({
            type: "post",
            url: "/event/evt_comment/api/util_comment_action.asp",
            data: payLoad,
            success: function(data){
                var res = data.split("|")
                if(res[0] == "ok"){
                    if(mode == "add") {
                        $('.layer-area#submit').show();
                        getList(1, true);
                    } 
                    $('#inputContainer').hide()
                    getMyComment()
                }else if(res[0] == "Err") {
                    alert(res[1])
                }
                // console.log(data, mode)
            },
            error: function(e){
                console.log(e)
            }
        })
    }
    function resetForm(){
        $(".list-plan input[type='text']").each(function(idx, el){el.value = ''})
        $("[id*=disp]").each(function(idx, el){$(el).text("0")})
    }

    function getList(currentPage, init){
        var pageSize = 9

        if (!currentPage){
            currentPage=1;
        }
        var payLoad = {
            currentPage: currentPage,
            eventCode: '<%=eCode%>',
            pageSize: pageSize,
            scrollCount: 10,
            // isMyComments: 1
        }
        var items = []
        var pagingData = {}

        $.ajax({
            type: "GET",
            url: "/event/evt_comment/api/util_comment_list.asp",
            data: payLoad,
            dataType: "json",
            success: function(Data){
                items = Data.comments
                pagingData = Data.pagingData
                // console.log(items)
                renderItems(items)
                renderPaging(pagingData)

                if(!init) window.$('html,body').animate({scrollTop:$("#cmtList").offset().top}, 400);
            },
            error: function(e){
                console.log('데이터를 받아오는데 실패하였습니다.')
            }
        })
    }
    function getMyComment(){
        var payLoad = {
            currentPage: 1,
            eventCode: '<%=eCode%>',
            pageSize: 1,
            scrollCount: 1,
            isMyComments: 1
        }
        var items = []

        $.ajax({
            type: "GET",
            url: "/event/evt_comment/api/util_comment_list.asp",
            data: payLoad,
            dataType: "json",
            success: function(Data){
                items = Data.comments
                if(items.length > 0){
                    $('#inputContainer').hide()
                    var myHtmlStr = ''
                    var content = items[0].content
                    var content2 = items[0].content2
                    var content3 = items[0].content3
                    var option1 = items[0].option1
                    var option2 = items[0].option2
                    var option3 = items[0].option3
                    var userid = items[0].userId
                    var regdate = items[0].regDate
                    var tmpFlag = function(flag){return flag == "1" ? 'checked' : ''}

                    items.forEach(function(item){
                        myHtmlStr += '\
                        <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/img_input_2_v1.png" alt=""></span>\
                        <div id="my_comment" idx='+ items[0].contentId +'>\
                            <p class="tit-plan"><b>'+ userid +'</b>의 목표</p>\
                            <ul class="list-plan">\
                                <li><input type="checkbox" value="1" onclick="jsSubmitComment(\'mod\')" id="option1" '+ tmpFlag(option1) +'><label for="option1">'+ content +'</label></li>\
                                <li><input type="checkbox" value="1" onclick="jsSubmitComment(\'mod\')" id="option2" '+ tmpFlag(option2) +'><label for="option2">'+ content2 +'</label></li>\
                                <li><input type="checkbox" value="1" onclick="jsSubmitComment(\'mod\')" id="option3" '+ tmpFlag(option3) +'><label for="option3">'+ content3 +'</label></li>\
                            </ul>\
                        </div>\
                        <button type="button" onclick="setUpdateForm(true)" class="btn-submit" style="bottom: 75px;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn modify.png" alt="수정하기"></button>\
                        '
                    })
                    $("#myList").html(myHtmlStr);
                    setUpdateForm(false)
                    $("#dipDate").html(regdate.substring(6, 7)+'월 '+regdate.substring(8, 10)+'일')
                }
            },
            error: function(e){
                console.log('데이터를 받아오는데 실패하였습니다.')
            }
        })
    }
    function setUpdateForm(toggle){
        if(toggle){
            $("#myList").hide();
            $('#inputContainer').show()
            $('#submitBtn').hide();
            $('#updateBtn').show();
            $(".list-plan input[type='text']").each(function(idx, el){
                chkWord(el, 15, 'disp'+(parseInt(idx)+1))
            })            
        }else{
            $("#myList").show();
            $('#inputContainer').hide()
            $('#submitBtn').show();
            $('#updateBtn').hide();
            // original values
            $("#content1").val($("#option1").next().text())
            $("#content2").val($("#option2").next().text())
            $("#content3").val($("#option3").next().text())
        }
    }    
    function renderPaging(pagingObj){
        if(Object.keys(pagingObj).length === 0 && pagingObj.constructor === Object) return false;
        var pagingHtml='';
        var totalpage = parseInt(pagingObj.totalpage);
        var currpage = parseInt(pagingObj.currpage);
        var scrollpage = parseInt(pagingObj.scrollpage);
        var scrollcount = parseInt(pagingObj.scrollcount);
        var totalcount = parseInt(pagingObj.totalcount);

        if(totalpage > 1){               
            var prevHtml = currpage > 1 ? ' <a href="" class="prev arrow" onclick="getList('+(currpage-1)+'); return false;"><span>이전페이지로 이동</span></a> ' : ''
            var nextHtml = currpage < totalpage ? ' <a href="" class="next arrow" onclick="getList('+(currpage+1)+'); return false;"><span>다음 페이지로 이동</span></a>' : ''
            
            pagingHtml +='<div class="paging">' + prevHtml
            for (var ii=(0+scrollpage); ii< (scrollpage+scrollcount); ii++) {
                if(ii > totalpage){
                    break;
                }
                if(ii==currpage){
                    pagingHtml +='<a href="javascript:void(0)" class="current"><span>'+ii+'</span></a>'
                }else{
                    pagingHtml +='<a href="" onclick="getList('+ii+'); return false;"><span>'+ii+'</span></a>'
                                   
                }
            }
            pagingHtml += nextHtml + '</div>';
        }
        $("#pagingElement").html(pagingHtml);
    }
    function renderItems(items){
        if(items.length < 1){
            var noResultHtml = ''
            $("#listContainer").html(noResultHtml);
            return false;
        }
        var listHtmlStr = ''

        var tmpFlag = function(flag){return flag == "1" ? 'class=\'checked\'' : ''}
        listHtmlStr += '<ul class="list-area">'
        items.forEach(function(item){
            listHtmlStr += '\
                    <li class="pos">\
                        <div>\
                            <p class="tit-plan"><b>'+ item.userId +'</b>의 목표</h3>\
                            <ul class="list-plan">\
                                <li '+ tmpFlag(item.option1) +'>'+ item.content +'</li>\
                                <li '+ tmpFlag(item.option2) +'>'+ item.content2 +'</li>\
                                <li '+ tmpFlag(item.option3) +'>'+ item.content3 +'</li>\
                            </ul>\
                        </div>\
                    </li>\
            '
        })
        listHtmlStr += '</ul>'
        $("#listContainer").html(listHtmlStr);
    }
    function chkWord(obj, maxLength, txtId){
        var currentLengh = obj.value.length < maxLength ? obj.value.length : maxLength
        obj.value = obj.value.substr(0, maxLength)
        $("#"+txtId).text(parseInt(currentLengh));
    }
</script>
<!-- MKT_97329_To do list -->
<div class="evt97329">
    <div class="topic pos">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/tit.png" alt="To do list"></h2>
        <div class="ani1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/bg_top.png" alt=""></div>
        <div class="ani2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/bg_top_2.png" alt=""></div>
        <div class="copy">앞으로 <b><%=DateDiff("d", Cdate("2020-01-01"), date()) * -1%></b>일 남은 2019년!
            <p>올해 꼭 이루고 싶은 목표 적고 기프트카드 받아가세요!</p>
        </div>
    </div>
    <!-- 입력 -->
    <div class="todo">
        <!-- 9/23 부터 노출 -->
        <div class="cmt-input pos" id="inputContainer" style="display:<%=chkIIF(currentDate <= evtEndDate, "", "none" )%>">
            <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/img_input_1.png" alt=""></span>
            <div>
                <p class="tit-plan"><b><%=chkIIF(userid <> "",userid ,"__________")%></b>의 목표</p>
                <ul class="list-plan">
                    <li>
                        <input type="text" onclick="chkLogin()" onkeyup="chkWord(this, 15, 'disp1');" id="content1" placeholder="첫 번째 목표를 입력해주세요.">
                        <p class="now-txt" name="입력한 글자 수"><span id='disp1'>0</span>/15</p>
                    </li>
                    <li>
                        <input type="text" onclick="chkLogin()" onkeyup="chkWord(this, 15, 'disp2');" id="content2" placeholder="두 번째 목표를 입력해주세요.">
                        <p class="now-txt" name="입력한 글자 수"><span id='disp2'>0</span>/15</p>
                    </li>
                    <li>
                        <input type="text" onclick="chkLogin()" onkeyup="chkWord(this, 15, 'disp3');" id="content3" placeholder="세 번째 목표를 입력해주세요.">
                        <p class="now-txt" name="입력한 글자 수"><span id='disp3'>0</span>/15</p>
                    </li>
                </ul>
            </div>
            <div class="btn-area" id="updateBtn" style="display: none">
                <button type="button" onclick="setUpdateForm(false)"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_cancel.jpg" alt="취소"></button>
                <button type="button" onclick="jsSubmitComment('mod')"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_modsubmit.jpg" alt="수정완료하기"></button>
            </div>            
            <button type="button" id="submitBtn" class="btn-submit" onclick="jsSubmitComment('add')"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_submit.png" alt="목표 제출하기"></button>
        </div>
        <%'<!-- 10/14 부터 노출-->%>
        <div class="cmt-input after pos" id="myList" style="display:"></div>
        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/txt_guide.jpg" alt="이벤트기간 2019년 9월 23일 - 10월 13일까지"></div>
    </div>
    <div class="alarm" id="alarm">
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/img_alarm.jpg" alt="푸시 수신 설정 방법" usemap="#Map" />
        <map name="Map" id="Map">
            <area shape="rect" coords="554,94,945,172" href="javascript:regAlram();" />
        </map>
    </div>
    <!-- 다른사람의 목표 구경하기 -->
    <div class="cmt-list" id="cmtList">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/tit_other.jpg" alt="다른 사람의 목표 구경하기" /></h3>
        <div id="listContainer"></div>
        <div id="pagingElement" class="pageWrapV15"></div>
    </div>
    <div class="noti">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/tit_noti.png" alt="유의사항" /></h3>
        <ul>
            <li>push 수신 동의를 하신 분에 한하여, 당첨자 발표 공지 push가 발송됩니다.</li>
            <li>사전에 push 동의가 되어 있는 분은 이벤트만 참여하면 당첨자 대상에 포함됩니다.</li>
        </ul>
    </div>	
    <%'<!-- 9/23 팝업 -->%>
    <div class="layer-area" id="submit" style="display:none">
        <div class="layerPopup" id="layerPopup1">
            <div class="layerPopup-cont">
                <a href="javascript:void(0)" class="btn-close"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_close.png" alt="닫기" /></a>
                <img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/layer_submit.jpg" alt="목표 제출 완료!" />
                <button type="button" onclick="regAlram()"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/layer_btn.png?v=1.01" alt="당첨자 발표 알림 신청"></button>
            </div>
            <div class="mask"></div>
        </div>
    </div>
<% If false Then %>  
    <% if currentDate >= Cdate("2019-12-31") and IsUserLoginOK() then %>
    <script>
    $(function(){    
        $('.layerPopup .btn-check, .layerPopup .btn-close ').click(function(){     
            $('.layer-area').hide();
            window.$('html,body').animate({scrollTop:$("#my_comment").offset().top}, 400);
            return false;
        })  
    })
    </script>          
        <% if isWinner then %>              
    <%'<!-- 12/31 당첨 -->%>
    <div class="layer-area" >
        <div class="layerPopup">
            <div class="layerPopup-cont">
                <a href="javascript:void(0)" class="btn-close"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_close.png" alt="닫기" /></a>
                <div class="pos">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/layer_win.jpg?v=1.01" alt="축하합니다!" />
                    <div>
                        <b id="dipDate"></b>에 적은 <b><%=userid%></b>님의 
                        <p>목표를 다시 한 번 확인해보세요!</p>
                    </div>
                </div>
                <button type="button" class="btn-check"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/layer_btn_mytodo.png" alt="목표 확인하러 가기"></button>
            </div>
            <div class="mask"></div>
        </div>
    </div>
    <% else %>
    <%'<!-- 12/31 비당첨 -->%>
    <div class="layer-area">
        <div class="layerPopup" >
            <div class="layerPopup-cont">
                <a href="javascript:void(0)" class="btn-close"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/btn_close.png" alt="닫기" /></a>
                <div class="pos">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/layer_fail.jpg" alt="당첨은 되지 않았지만, 쿠폰을 드려요!!" />
                    <div>
                        <b id="dipDate"></b>에 적은 <b><%=userid%></b>님의 
                        <p>목표를 다시 한 번 확인해보세요!</p>
                    </div>
                </div>
                <button type="button" class="btn-check"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97329/layer_btn_mytodo.png" alt="목표 확인하러 가기"></button>
            </div>
            <div class="mask"></div>
        </div>
    </div>
        <% end if %>        
    <% end if %>     
<% end if %>    
</div>
<script type="text/javascript" src="/event/etc/json/js_regAlram.js?v=1.5"></script>
<!-- //MKT_97329_To do list -->
<!-- #include virtual="/lib/db/dbclose.asp" -->