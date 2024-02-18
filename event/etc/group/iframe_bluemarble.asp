<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 럭키박스 블루마블
' History : 2020-04-03 조경애
'####################################################
%>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2020-04-06"
	'response.write currentdate
%>
<style type="text/css">
.bluemarble {position:relative;}
.bluemarble .item-list {position:absolute; left:50%; top:140px; margin-left:-200px;}
.bluemarble .item-list .price {position:absolute; left:200px; top:140px; font-size:20px; color:#371c0f; font-weight:900; letter-spacing:-1px;}
.bluemarble .item-list .price s {display:block; font-size:15px; font-weight:400;}
.bluemarble .item-list .price span {display:inline-block; height:22px; margin-left:5px;  padding:0 5px; color:#fff; font-size:18px; font-weight:600;line-height:22px; border:1px solid #371c0f; background:#c92326;}
.bluemarble .brand-list li {position:absolute; top:0; width:140px; height:110px; font-size:0;}
.bluemarble .brand-list li a {display:block; width:100%; height:100%;}
.bluemarble .brand-list .item1 {left:302px; width:168px;}
.bluemarble .brand-list .item2 {left:470px;}
.bluemarble .brand-list .item3 {left:610px;}
.bluemarble .brand-list .item4 {left:750px; width:151px;}
.bluemarble .brand-list .item5 {left:901px; width:110px;}
.bluemarble .brand-list .item6 {left:901px; top:112px; width:110px; height:127px;}
.bluemarble .brand-list .item7 {left:901px; top:238px; width:110px;}/* jump*/
.bluemarble .brand-list .item8 {left:901px; top:388px; width:110px;}
.bluemarble .brand-list .item9 {left:779px; top:388px; width:122px;}
.bluemarble .brand-list .item10 {left:639px; top:388px; width:140px;}
.bluemarble .brand-list .item11 {left:520px; top:388px; width:120px;}
.bluemarble .brand-list .item12 {left:380px; top:388px; width:140px;}
.bluemarble .brand-list .item13 {left:241px; top:388px; width:140px;}
.bluemarble .brand-list .item14 {left:130px; top:388px; width:110px;}
.bluemarble .brand-list .item15 {left:130px; top:286px; width:110px; height:102px;}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	fnApplyItemInfoEach({
		items:"2796450,2797054,2775137,2796882,2807356,2802729,2803691,2442085,2786478,2786479,2807398,2802906,2803895,2803377,2814257",
		target:"item",
		fields:["price","sale"],
		unit:"won",
		saleBracket:false
    });
    $('.bluemarble .slider').slick({
		autoplay:true,
        autoplaySpeed:2500,
		fade:true,
        speed:10
	});
});
</script>
</head>
<body>
<!-- 101687 이벤트기간:0406~0420 -->
<div class="bluemarble">
    <ul class="item-list">
        <% if currentdate < "2020-04-07" then %>
        <li class="item2796450">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2796450&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item1.jpg" alt="">
                <p class="price"><s>39000</s> 20000won<span>50%</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-08" then %>
        <li class="item2797054">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2797054&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item2.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-09" then %>
        <li class="item2775137">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2775137&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item3.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-10" then %>
        <li class="item2796882">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2796882&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item4.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-11" then %>
        <li>
            <a target="_top" href="/shopping/category_prd.asp?itemid=2807356&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item5.jpg" alt="">
                <p class="price">9,900원~</p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-12" then %>
        <li>
            <a target="_top" href="/shopping/category_prd.asp?itemid=2802729&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item6.jpg" alt="">
                <p class="price"><s>35,000원</s> 22,750원<span>35%</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-14" then %>
        <li class="item2803691">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2803691&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item7.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-15" then %>
        <li class="item2442085">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2442085&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item8.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-16" then %>
        <li class="slider">
            <a class="item2786478" target="_top" href="/shopping/category_prd.asp?itemid=2786478&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item9_1.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
            <a class="item2786479" target="_top" href="/shopping/category_prd.asp?itemid=2786479&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item9_2.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-17" then %>
        <li>
            <a target="_top" href="/shopping/category_prd.asp?itemid=2807398&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item10.jpg" alt="">
                <p class="price">19,900원~</p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-18" then %>
        <li class="item2802906">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2802906&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item11.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-19" then %>
        <li class="item2803895">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2803895&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item12.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% elseif currentdate < "2020-04-20" then %>
        <li class="item2803377">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2803377&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item13.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>

        <% else %>
        <li class="item2814257">
            <a target="_top" href="/shopping/category_prd.asp?itemid=2814257&pEtr=101687">
                <img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/item14.jpg" alt="">
                <p class="price"><s>원가</s> 판매가<span>할인율</span></p>
            </a>
        </li>
        <% end if %>

    </ul>
    <div class="brand-list">
        <ul>
            <li class="item1"><a target="_top" href="/shopping/category_prd.asp?itemid=2796450&pEtr=101687"></a></li>

            <% if currentdate < "2020-04-07" then %>
            <li class="item2">coming soon</li>
            <% Else %>
            <li class="item2"><a target="_top" href="/shopping/category_prd.asp?itemid=2797054&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-08" then %>
            <li class="item3">coming soon</li>
            <% Else %>
            <li class="item3"><a target="_top" href="/shopping/category_prd.asp?itemid=2775137&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-09" then %>
            <li class="item4">coming soon</li>
            <% Else %>
            <li class="item4"><a target="_top" href="/shopping/category_prd.asp?itemid=2796882&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-10" then %>
            <li class="item5">coming soon</li>
            <% Else %>
            <li class="item5"><a target="_top" href="/shopping/category_prd.asp?itemid=2807356&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-11" then %>
            <li class="item6">coming soon</li>
            <% Else %>
            <li class="item6"><a target="_top" href="/shopping/category_prd.asp?itemid=2802729&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-13" then %>
            <li class="item8">coming soon</li>
            <% Else %>
            <li class="item8"><a target="_top" href="/shopping/category_prd.asp?itemid=2803691&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-14" then %>
            <li class="item9">coming soon</li>
            <% Else %>
            <li class="item9"><a target="_top" href="/shopping/category_prd.asp?itemid=2442085&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-15" then %>
            <li class="item10">coming soon</li>
            <% Else %>
            <li class="item10"><a target="_top" href="/shopping/category_prd.asp?itemid=2786478&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-16" then %>
            <li class="item11">coming soon</li>
            <% Else %>
            <li class="item11"><a target="_top" href="/shopping/category_prd.asp?itemid=2807398&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-17" then %>
            <li class="item12">coming soon</li>
            <% Else %>
            <li class="item12"><a target="_top" href="/shopping/category_prd.asp?itemid=2802906&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-18" then %>
            <li class="item13">coming soon</li>
            <% Else %>
            <li class="item13"><a target="_top" href="/shopping/category_prd.asp?itemid=2803895&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-19" then %>
            <li class="item14">coming soon</li>
            <% Else %>
            <li class="item14"><a target="_top" href="/shopping/category_prd.asp?itemid=2803377&pEtr=101687"></a></li>
            <% End If %>

            <% if currentdate < "2020-04-20" then %>
            <li class="item15">coming soon</li>
            <% Else %>
            <li class="item15"><a target="_top" href="/shopping/category_prd.asp?itemid=2814257&pEtr=101687"></a></li>
            <% End If %>

        </ul>

        <!-- 맵 이미지 변경 -->
        <% if currentdate < "2020-04-07" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_1.png" alt=""></p>

        <% elseif currentdate < "2020-04-08" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_2.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-09" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_3.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-10" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_4.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-11" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_5.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-12" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_6.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-13" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_6.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-14" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_7.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-15" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_8.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-16" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_9.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-17" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_10.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-18" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_11.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-19" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_12.png?v=2" alt=""></p>

        <% elseif currentdate < "2020-04-20" then %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_13.png?v=2" alt=""></p>

        <% Else %>
        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2020/101687/img_map_14.png?v=2" alt=""></p>
        <% End If %>
            
    </div>
</div>
<!--// 101687 -->
</body>
</html>