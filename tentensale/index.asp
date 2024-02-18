<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 12월 텐텐세일
' History : 2022.12.03 정태훈 생성
'####################################################

if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
    if Not(Request("mfg")="pc" or session("mfg")="pc") then
        if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
            Response.Redirect "//m.10x10.co.kr/universal/"
            REsponse.End
        end if
    end if
end if

dim tabType : tabType = RequestCheckVar(request("tabType"),7)

'If tabType = "" Then '//초기 진입시 혜택 탭
'    tabType = "benefit"
'End if

dim eCode
IF application("Svr_Info") = "Dev" THEN
    eCode = "119233"
ElseIf application("Svr_Info")="staging" Then
    eCode = "121346"
Else
    eCode = "121346"
End If
%>
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Abril+Fatface" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style>
@font-face {
font-family: 'GmarketSansMedium';
src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
font-weight: normal;
font-style: normal;
}
.ten_sale12{position:relative;}
.ten_sale12 section{position:relative;width:1920px;left:50%;transform:translateX(-50%);}
.ten_sale12 section .in_wrap{width:1440px;margin:0 auto;}
.ten_sale12 section .inner{width:990px;margin:0 auto;padding-left:121px;padding-top:65px;padding-bottom:121px;}
.ten_sale12 section h2{font-size:41px;line-height: 52px;text-align:center;font-weight:800;margin-bottom:25px;}
.ten_sale12 section h2 span{display:block;font-size:21px;line-height:33px;margin-bottom:5px;font-weight:500;}
.ten_sale12 a:hover{text-decoration:none;}

.ten_sale12 .main .talk p{position:absolute;}
.ten_sale12 .main .go_gift{position:absolute;width:224px;height:65px;display:block;top:379px;left:1171px;}
.ten_sale12 .main01{background:url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/main.png?v=1.03) #FFEBDD no-repeat 50%;height:494px;background-size:1440px;position:relative;}
.ten_sale12 .main02{background:url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/main02.png?v=1.03) #F6F1ED no-repeat 50%;height:494px;background-size:1440px;position:relative;}
.ten_sale12 .main03{background:url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/main03.png?v=1.03) #F3CFBD no-repeat 50%;height:494px;background-size:1440px;position:relative;}
.ten_sale12 .main01::before{content:'';width:200px;height:494px;position:absolute;top:0;left:180px;background: linear-gradient(270deg, rgba(255,235,221,0) 0%, rgba(255,235,221,0.8883928571428571) 60%, rgba(255,235,221,1) 100%);}
.ten_sale12 .main01::after{content:'';width:200px;height:494px;position:absolute;top:0;right:180px;background: linear-gradient(90deg, rgba(255,235,221,0) 0%, rgba(255,235,221,0.8883928571428571) 60%, rgba(255,235,221,1) 100%);}
.ten_sale12 .main02::before{content:'';width:200px;height:494px;position:absolute;top:0;left:180px;background: linear-gradient(270deg, rgba(246,241,237,0) 0%, rgba(246,241,237,0.9108018207282913) 60%, rgba(246,241,237,1) 100%);}
.ten_sale12 .main02::after{content:'';width:200px;height:494px;position:absolute;top:0;right:180px;background: linear-gradient(90deg, rgba(246,241,237,0) 0%, rgba(246,241,237,0.9108018207282913) 60%, rgba(246,241,237,1) 100%);}
.ten_sale12 .main03::before{content:'';width:200px;height:494px;position:absolute;top:0;left:180px;background: linear-gradient(270deg, rgba(243,207,189,0) 0%, rgba(243,207,189,0.8827906162464986) 60%, rgba(243,207,189,1) 100%);}
.ten_sale12 .main03::after{content:'';width:200px;height:494px;position:absolute;top:0;right:180px;background: linear-gradient(90deg, rgba(243,207,189,0) 0%, rgba(243,207,189,0.8827906162464986) 60%, rgba(243,207,189,1) 100%);}
.ten_sale12 .main01 .talk p.talk01{top:31px;left:878px;animation:updown 0.9s ease-in-out alternate infinite;}
.ten_sale12 .main01 .talk p.talk02{top:73px;left:1210px;animation:updown 0.7s ease-in-out alternate infinite;}
.ten_sale12 .main01 .talk p.talk03{top:257px;left:1157px;animation:updown 1s ease-in-out alternate infinite;}
.ten_sale12 .main02 .talk p.talk01{top:50px;left:900px;animation:updown 1.1s ease-in-out alternate infinite;}
.ten_sale12 .main02 .talk p.talk02{top:152px;left:1290px;animation:updown 0.9s ease-in-out alternate infinite;}
.ten_sale12 .main02 .talk p.talk03{top:321px;left:983px;animation:updown 0.65s ease-in-out alternate infinite;}
.ten_sale12 .main03 .talk p.talk01{top:60px;left:963px;animation:updown 0.7s ease-in-out alternate infinite;}
.ten_sale12 .main03 .talk p.talk02{top:148px;left:1255px;animation:updown 0.8s ease-in-out alternate infinite;}
.ten_sale12 .main03 .talk p.talk03{top:321px;left:983px;animation:updown 1s ease-in-out alternate infinite;}

.ten_sale12 .section01{background:#DF4E55;}
.ten_sale12 .section01 h2{color:#fff;}
.ten_sale12 .section01 ul{width:895px;display:flex;justify-content:space-between;margin:0 auto;}
.ten_sale12 .section01 ul li{width:245px;height:285px;background:#FFE8D1;border-radius: 10px;overflow: hidden;position:relative;padding:20px 20px 0;}
.ten_sale12 .section01 ul li .thumbnail{width:237.5px;height:237.5px;display:flex;justify-content:center;align-items:center;overflow:hidden;position:absolute;bottom:-10px;left:50%;transform: translateX(-50%);}
.ten_sale12 .section01 ul li .thumbnail img{width:100%;}
.ten_sale12 .section01 ul li .desc .name{position:absolute;top:20px;left:20px;width:124px;font-size:17px;line-height:22.5px;font-weight:600;max-height:43px; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical;white-space:unset;}
.ten_sale12 .section01 ul li .desc .price .sum{position:absolute;top:70.92px;left:20.81px;font-size:19px;line-height:18.66px;color:#111;font-weight:600;}
.ten_sale12 .section01 ul li .desc .price .discount{position:absolute;top:59.48px;right:17.1px;font-size:36px;line-height:35.35px;font-weight:800;color:transparent !important;-webkit-text-stroke:1px #000;text-stroke:1px #000;}

.ten_sale12 .section02{background:#FFCBBF;}
.ten_sale12 .section02 .inner{padding-bottom:79px;}
.ten_sale12 .section02 h2{color:#000;}
.ten_sale12 .section02 .gage_wrap{width:640px;text-align:center;margin:0 auto;margin-bottom:27px;}
.ten_sale12 .section02 .gage_wrap .gage_tit{font-size:18px;line-height:34.5px;letter-spacing:-0.015em;font-weight:700;margin-bottom:5px;}
.ten_sale12 .section02 .gage_wrap .gage{width:100%;height:47px;background:#FFA28E;border-radius: 25px;overflow:hidden;}
.ten_sale12 .section02 .gage_wrap .gage p{width:30%;height:100%;background:#E44737;display:flex;align-items:center;justify-content:flex-end;border-radius: 25px 0 0 25px;}
.ten_sale12 .section02 .gage_wrap .gage p span{font-size:18px;line-height:21.6px;color:#fff;font-weight:600;margin-right:10px;}
.ten_sale12 .section02 .mileage_wrap{width:628px;height:248px;margin:0 auto;position:relative;margin-bottom:40px;padding-top:4px}
.ten_sale12 .section02 .mileage_wrap .finish{position:absolute;top:0;left:0;}
.ten_sale12 .section02 .mileage_wrap ul{display:flex;flex-wrap:wrap;justify-content:space-between;width:628px;height:248px;}
.ten_sale12 .section02 .mileage_wrap ul li{position:relative;width:115px;height:115px;background:#FFD0C6;border:1px dashed #FF8064;border-radius: 10px;display:flex;align-items:center;justify-content:center;flex-direction: column;font-size:22px;line-height:21.6px;font-weight:600;color:#FF8064;}
.ten_sale12 .section02 .mileage_wrap ul li span{font-size:17px;line-height:20.4px;font-weight:500;margin-bottom:4.5px;}
.ten_sale12 .section02 .mileage_wrap ul li.end{background-color:#FFA28E;color:#B85F4C;border:0;}
.ten_sale12 .section02 .mileage_wrap ul li.end .mask{z-index:0;background: url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/check.png) no-repeat 0 0; background-size:100%;position:absolute;top:-4px;left:3px;right:0;bottom:0;width:100%;height:100%;display:block;}
.ten_sale12 .section02 .mileage_wrap ul li.on{background-color:#E44737;color:#fff;border:0;}
.ten_sale12 .section02 .mileage_wrap ul li.final{background-color:#232323;color:#FF8064;border:0;}
.ten_sale12 .section02 .mileage_wrap ul li.final span{font-size:15px;line-height:18px;font-weight:700;margin-bottom:9px;}
.ten_sale12 .section02 .noti_wrap .btn_check{width:303px;height:57px;margin:0 auto;display:flex;align-items:center;justify-content:center;background:#E44737;border-radius: 48px;font-size:19px;line-height:22.8px;color:#fff;font-weight:bold;margin-bottom:16px;}
.ten_sale12 .section02 .noti_wrap .alert{width:303px;height:57px;margin:0 auto;display:flex;align-items:center;justify-content:center;background:#B27364;border-radius: 48px;font-size:19px;line-height:22.8px;color:#fff;font-weight:lighter;margin-bottom:10px;}
.ten_sale12 .section02 .noti_wrap .alert span{font-weight:bold;margin-left:5px;}
.ten_sale12 .section02 .noti_wrap .no_alert{font-size:15px;line-height:18px;color:#594743;text-decoration: underline;font-weight:normal;margin-bottom:37px;display:block;}
.ten_sale12 .section02 .noti_wrap .noti{font-size:15px;color:#CE5339;font-weight:normal;}
.ten_sale12 .section02 .noti_wrap .noti_more{font-size:16px;line-height:19.2px;color:#CE5339;font-weight:bold;text-decoration:underline;display:block;margin-top:19px;}
.ten_sale12 .section02 .mileage_wrap > img{width:629px;height:244px;}
.ten_sale12 .section02 .mileage_wrap .btnWrap{position:absolute;top:0;width:629px;height:244px;;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div{position:absolute;display:none}
.ten_sale12 .section02 .mileage_wrap .btnWrap div img{width:102%;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn01{top:4px;left:1px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn01 .btn_off{position:relative;top:-9px;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn02{top:4px;left:127px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn02 .btn_off{position:relative;top:-9px;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn03{top:4px;left:50%;transform:translateX(-50%);margin-left:-2.1px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn03 .btn_off{position:relative;top:-9px;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn04{top:4px;right:129px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn04 .btn_off{position:relative;top:-9px;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn05{top:4px;right:3.5px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn05 .btn_off{position:relative;top:-9px;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn06{bottom:-5px;left:1px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn07{bottom:-5px;left:127px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn08{bottom:-5px;left:50%;transform:translateX(-50%);margin-left:-2.1px;display:block;}
.ten_sale12 .section02 .mileage_wrap .btnWrap div.btn09{bottom:-5px;right:129px;display:block;}

.ten_sale12 .section03, .ten_sale12 .section06{background:#FFFCF8;}
.ten_sale12 section .inner{padding-bottom:79px;}
.ten_sale12 section .prd_wrap{margin-bottom:70px;}
.ten_sale12 section .prd_wrap:last-child{margin-bottom:0;}
.ten_sale12 section .prd_wrap .prd_tit{width:989px;height:92px;margin:0 auto;background:#FCF6EE;display:flex;align-items: center;justify-content:center;margin-bottom:30px;position:relative;cursor:pointer;}
.ten_sale12 section .prd_wrap .prd_tit::after{content:'';position:absolute;top:50%;right:60px;width:22px;height:22px;margin-top:-11px;background: url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/arrow.png)no-repeat 0 0;}
.ten_sale12 section .prd_wrap .prd_tit .copy{text-align:left;margin-left:15px;}
.ten_sale12 section .prd_wrap .prd_tit .main_copy{font-size:21px;line-height:25.2px;font-weight:bold;margin-bottom:4px;}
.ten_sale12 section .prd_wrap .prd_tit .sub_copy{font-size:16px;line-height:19.2px;font-weight:normal;}
.ten_sale12 section .prd_wrap .prd-list ul{display:flex;justify-content:space-around;margin-bottom:45px;}
.ten_sale12 section .prd_wrap .prd-list ul li{width:285px;}
.ten_sale12 section .prd_wrap .prd-list ul li .thumbnail{position:relative;}
.ten_sale12 section .prd_wrap .prd-list ul li .thumbnail.free::after{content:'';position:absolute;top:0;left:10px;background: url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/badge01.png)no-repeat 0 0;width:61px;height:26px;background-size:100%;}
.ten_sale12 section .prd_wrap .prd-list ul li .thumbnail.package::after{content:'';position:absolute;top:0;left:10px;background: url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/badge02.png)no-repeat 0 0;width:61px;height:26px;background-size:100%;}
.ten_sale12 section .prd_wrap .prd-list ul li .thumbnail{width:285px;height:285px;display:flex;align-items: center;justify-content: center;background:#eee;margin-bottom:15px;}
.ten_sale12 section .prd_wrap .prd-list ul li .thumbnail img{width:100%;}
.ten_sale12 section .prd_wrap .prd-list ul li .desc{text-align:left;}
.ten_sale12 section .prd_wrap .prd-list ul li .desc .price{font-size:20px;line-height:19.64px;color:#111;font-weight:bold;margin-bottom:10px;}
.ten_sale12 section .prd_wrap .prd-list ul li .desc .price s{display:block;font-size:16px;line-height:15.71px;color:#666;font-weight:lighter;margin-bottom:5px;}
.ten_sale12 section .prd_wrap .prd-list ul li .desc .price span{font-size:18px;line-height:17.68px;color:#FF214F;font-weight:bold;margin-left:2px;}
.ten_sale12 section .prd_wrap .prd-list ul li .desc .name{font-size:17px;line-height:20.4px;font-weight:normal;color:#111;margin-bottom:5px;letter-spacing:-0.01em;}
.ten_sale12 section .prd_wrap .prd-list ul li .desc .brand{font-size:13px;line-height:12.77px;font-weight:normal;color:#666;margin-bottom:5px;}
.ten_sale12 section .prd_wrap .more{width:261px;height:57px;display:flex;align-items: center;justify-content:center;font-size:19px;line-height:22.8px;border:1px solid #333;margin:0 auto;font-weight:bold;}

.ten_sale12 .section04{background:#F56F52;}
.ten_sale12 .section04 .inner{padding-bottom:125px;}
.ten_sale12 .section04 h2{color:#fff;}
.ten_sale12 .section04 .surprise.two{display:flex;width:895px;margin:0 auto 30px;justify-content:space-between;}
.ten_sale12 .section04 .surprise.one{width:895px;margin:0 auto 30px;background:#F6EADE;}
.ten_sale12 .section04 .surprise.one .coupon a{width:895px;display:block;}
.ten_sale12 .section04 .surprise.one .mileage{display:none;}
.ten_sale12 .section04 .limit_price .bene_prd a{width:683px;margin:0 auto 30px;display:flex;justify-content:space-between;background:#F6EADE;padding:64px 106px 47px;}
.ten_sale12 .section04 .limit_price .bene_prd a .thumbnail{width:300px;height:300px;background:#fff;display:flex;align-items: center;justify-content:center;position:relative;}
.ten_sale12 .section04 .limit_price .bene_prd a .thumbnail::after{content:'';position:absolute;top:10px;left:15px;background: url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/badge_limit.png)no-repeat 0 0;width:75px;height:75px;background-size:100%;}
.ten_sale12 .section04 .limit_price .bene_prd a .thumbnail img{width:100%;}
.ten_sale12 .section04 .limit_price .bene_prd a .right{width:263px;display:flex;text-align: left;flex-direction: column;justify-content:space-around;}
.ten_sale12 .section04 .limit_price .bene_prd a .right .bene_tit h4{font-size:32px;line-height:38.4px;font-weight:bold;color:#262626;margin-bottom:5px;}
.ten_sale12 .section04 .limit_price .bene_prd a .right .bene_tit h4 span{color:#FF461E}
.ten_sale12 .section04 .limit_price .bene_prd a .right .bene_tit .bene_copy{font-size:18px;line-height:25.11px;color:#655A4E;letter-spacing: -0.05em;font-weight:normal;}
.ten_sale12 .section04 .limit_price .bene_prd a .right .desc .price{font-size:25px;line-height:24.55px;color:#111;font-weight:bold;margin-bottom:14px;}
.ten_sale12 .section04 .limit_price .bene_prd a .right .desc .price s{display:block;font-size:17px;line-height: 16.69px;font-weight:lighter;color:#999;margin-bottom:5px;}
.ten_sale12 .section04 .limit_price .bene_prd a .right .desc .price span{font-size:27px;line-height:26.51px;color:#FF214F;font-weight:bold;float:right;}
.ten_sale12 .section04 .limit_price .bene_prd a .right .desc .name{font-size:17px;line-height: 26.26px;font-weight:normal;}
.ten_sale12 .section04 .free_delivery{width:895px;margin:0 auto 30px;background:#F6EADE;padding: 54px 0 45px;}
.ten_sale12 .section04 .free_delivery .bene_tit h4{font-size:32px;line-height:38.4px;font-weight:bold;color:#262626;}
.ten_sale12 .section04 .free_delivery .bene_tit h4 span{color:#FF461E}
.ten_sale12 .section04 .free_delivery .bene_tit .bene_copy{font-size:18px;line-height:25.11px;color:#655A4E;letter-spacing: -0.05em;font-weight:normal;margin-bottom:5px;margin-bottom:32px;}
.ten_sale12 .section04 .free_delivery .mySwiper{width:681px;margin:0 auto 30px;}
.ten_sale12 .section04 .free_delivery .mySwiper .swiper-wrapper{margin-left:-50px;}
.ten_sale12 .section04 .free_delivery .mySwiper .swiper-slide{width:216px !important;margin-right:19px;height:260px !important;overflow:hidden;position:relative;}
.ten_sale12 .section04 .free_delivery .mySwiper .swiper-slide::after{content:'';position:absolute;top:10px;right:17px;background: url(//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/badge_free.png)no-repeat 0 0;width:65px;height:65px;background-size:100%;z-index:11;}
.ten_sale12 .section04 .free_delivery .mySwiper .swiper-slide a{display:flex;justify-content:center;align-items:center;}
.ten_sale12 .section04 .free_delivery .mySwiper .swiper-slide img{height:260px;}
.ten_sale12 .section04 .free_delivery .free_more{width:261px;height:57px;margin:0 auto;display:flex;align-items: center;justify-content:center;background-color:#000;color:#fff;font-size:19px;font-weight:bold;}

.ten_sale12 .section05{background:#252525;}
.ten_sale12 .section05 .inner{padding-bottom:125px;}
.ten_sale12 .section05 h2{color:#fff;margin-bottom:32px;}
.ten_sale12 .section05 .app_wrap{width:935px;margin:0 auto;display:flex;justify-content:center;margin-bottom:41px;}

.ten_sale12 .section06 h2 i{font-size:50px;line-height:34.5px;color:#FF214F;font-weight:bold;margin-top:23px;display:block;font-style:unset;}
.ten_sale12 .section06 .prd_wrap .prd_tit{width:989px;height:92px;background:#FCF6EE;margin-bottom:30px;justify-content:center;}
.ten_sale12 .section06 .prd_wrap .prd_tit .copy{text-align:left;margin-right:0;margin-left:0;display:flex;justify-content:center;}
.ten_sale12 .section06 .prd_wrap .prd_tit .main_copy{font-size:21px;line-height:25.2px;font-weight:bold;margin-bottom:4px;}

.ten_sale12 .tab-area{position:absolute;top:574px;left:50%;margin-left:-650px;}
.ten_sale12 .tab-area.fixed{position:fixed;top:90px;left:50%;margin-left:-650px;}
.ten_sale12 .tab-area div{margin-bottom:2px;}
.ten_sale12 .tab-area div.on a{background:#000;color:#fff;}
.ten_sale12 .tab-area a{width:80px;height:80px;display:flex;justify-content:center;align-items:center;flex-direction:column;background:#FCF6F0;color:#7B7B7B;font-weight:500;font-size:14px;line-height:16.8px;letter-spacing:-0.05em;}
.ten_sale12 .tab-area a span{color:#FF214F;margin-top:5px;}
.ten_sale12 .tab-area .tab05 a span{color:#fff;background:#FF214F;width:16px;height:16px;display:flex;justify-content:center;align-items:center;border-radius: 50%;}
.ten_sale12 .tab-area .tab07 a{background:transparent;margin-top:10px;}

.ten_sale12 .pop_noti{position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.8);z-index: 999;}
.ten_sale12 .pop_noti .noti_info{display:block !important;position:fixed;top:50%;left:50%;transform:translate3d(-50%, -50%, 0);background:#fff;color:#000;width:315px;height:273px;text-align: left;padding:59px 30px 50px;border-radius: 16px;}
.ten_sale12 .pop_noti .noti_info h3{font-size:16px;line-height:24px;font-weight:bold;margin-bottom:7px;}
.ten_sale12 .pop_noti .noti_info button{text-indent: -9999999px;margin-left:0; font-size:15px;width:28px;height:28px;background-image:url("data:image/svg+xml,%3Csvg width='28' height='28' viewBox='0 0 28 28' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M4.66667 4.6665L23.3333 23.3332' stroke='%23111111' stroke-linecap='round'/%3E%3Cpath d='M4.66667 23.3335L11.6667 16.3335' stroke='%23111111' stroke-linecap='round'/%3E%3Cpath d='M16.3333 11.6665L23.3333 4.6665' stroke='%23111111' stroke-linecap='round'/%3E%3C/svg%3E%0A");background-color:transparent;background-repeat:no-repeat;background-size:28px;position:absolute;top:14px;left:16px;margin-bottom:17px;}
.ten_sale12 .pop_noti .noti_info ul li{font-size:15px;line-height: 22.5px;font-weight:normal;position:relative;padding-left:10px;margin-bottom:7px;}
.ten_sale12 .pop_noti .noti_info ul li::before{content:'-';position:absolute;top:0;left:0;font-size:15px;}

@keyframes updown {
    0% {transform: translateY(0);}
    100% {transform: translateY(15px);}
}
</style>
<style>[v-cloak] { display: none; }</style>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="eventContV15 tMar15">
        <div class="contF contW" style="background:#fff;">
            <div id="app" v-cloak></div>
        </div>
    </div>
    <script type="text/javascript">
        const loginUserLevel = "<%= GetLoginUserLevel %>";
        const userid = "<%= GetLoginUserID %>";
        const server_info = "<%= application("Svr_Info") %>";
        let eventid = "";
        let tabType="";
        let isUserLoginOK = "";
        let sysdt = new Date(<%=year(now)%>,<%=month(now)-1%>,<%=day(now)%>,<%=hour(now)%>,<%=minute(now)%>,<%=second(now)%>).getTime();
        <%''let sysdt = new Date(2022, 11, 12, 18, 0, 0).getTime();%>
        isUserLoginOK = false;
        <% IF IsUserLoginOK THEN %>
            isUserLoginOK = true;
        <% END IF %>
        eventid = "<%=eCode%>";
        tabType = "<%=tabType%>";

        function goProduct(itemid) {
            parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
            return false;
        }

        function goEventLink(evt) {
        	parent.location.href='/event/eventmain.asp?eventid='+evt;
        }
    </script>

    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
	<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>

    <script src="/vue/2.5/vue.min.js"></script>
    <script src="/vue/vue.lazyimg.min.js"></script>
    <script src="/vue/vuex.min.js"></script>
    
    <script src="/vue/common/common.js?v=1.00"></script>
    <script src="/vue/components/common/functions/item_mixins.js?v=1.0"></script>
    <script src="/vue/components/common/functions/modal_mixins.js?v=1.0"></script>
    <script src="/vue/components/common/functions/common_mixins.js?v=1.0"></script>

    <script src="/vue/tentensale/just_one_day.js?v=1.00"></script>
    <script src="/vue/tentensale/everyday_mileage.js?v=1.01"></script>
    <script src="/vue/tentensale/present_item.js?v=1.00"></script>
    <script src="/vue/tentensale/surprise.js?v=1.05"></script>
    <script src="/vue/tentensale/app_benefit.js?v=1.02"></script>
    <script src="/vue/tentensale/saleItem.js?v=1.00"></script>
	<script src="/vue/tentensale/store.js?v=1.00"></script>
	<script src="/vue/tentensale/index.js?v=1.00"></script>

    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->