Vue.component('event-list',{
    template :'\
                <div class="slide-item" v-bind:style="backgroundImage">\
					<a @click="eventUrl(index)">\
						<div class="copy">\
							<p v-bind:style="fontColor" v-if="titlename != \'\'">{{titlename}}</p>\
							<p v-bind:style="fontColor" v-if="subtitlename != \'\'">{{subtitlename}}</p>\
						</div>\
						<div class="bg">\
							<div class="left" v-bind:style="leftBackgroundColor"></div>\
							<div class="right" v-bind:style="rightBackgroundColor"></div>\
						</div>\
					</a>\
				</div>\
                '
    ,
    props: {
        index : {
            type : Number,
            default : 0
        },
        titlename : {
            type : String,
            default : ""
        },
        subtitlename : {
            type : String,
            default : ""
        },
        imageurl : {
            type : String,
            default : ""
        },
        eventid : {
            type : Number,
            default : 0
        },
        leftBgColor : {
            type : String,
            default : ""
        },
        rightBgColor : {
            type : String,
            default : ""
        },
        amplitudeActionName : {
            type : String,
            default : ""
        },
        fontColorText : {
            type : String,
            default : ""
        },
        linkUrl : {
            type : String,
            default : ""
        }
    },
    computed : {
        fontColor : function() {
            return {
                'color' : '#'+this.fontColorText
            }
        },
        backgroundImage : function() {
            return {
                'background-image' : 'url('+ this.imageurl +')'
            }
        },
        leftBackgroundColor : function() {
            return {
                'background-color' : '#'+this.leftBgColor
            }
        },
        rightBackgroundColor : function() {
            return {
                'background-color' : '#'+this.rightBgColor
            }
        }
    },
    methods : {        
        eventUrl : function(index) {
            if (this.eventid > 0) {
                fnAmplitudeEventMultiPropertiesAction(this.amplitudeActionName + 'event','idx|eventcode',index +'|'+ this.eventid);
                window.location.href = "/event/eventmain.asp?eventid="+ this.eventid;
            } else {
                window.location.href = this.linkUrl;
            }
        },
    },
    mounted : function() {
        this.$nextTick(function() {
			setTimeout(function() {
                $('.main-slider').not('.slick-initialized').slick({
                    autoplay:false,
                    autoplaySpeed:4000,
                    arrows:true,
                    speed:900,
                    fade:true,
                    pauseOnHover:false,
                    dots: true,
                    customPaging: function(slick,index) {
                        pagI=index+1
                        return '<b>' + pagI + '</b> / ' + slick.slideCount ;
                    }
                });
			},50);
		});
    }
})