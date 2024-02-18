// instagram
Vue.component('insta-feed',{
	template : `
        <div class="section instagram inner-cont" v-if="isInstaFeedData">
            <div class="head">
                <h2><img src="//fiximage.10x10.co.kr/web2022/insta/insta_logo.png" alt=""><a href="https://instagram.com/your10x10" @click="moveInstagramFollow()" class="follow" target="_blank">+ Follow</a></h2>
                <p>지금 텐바이텐 인스타그램 계정을 팔로우하고 통통 튀는 상품들과 재미난 이벤트 소식을 받아보세요!</p>
            </div>		
            <div class="insta_cont">
                <div :class="['main_feed', 'insta_main' , {play : firstInstaFeedData.media_type === 'VIDEO'}]" @mouseenter="doMouseEnter" @mouseleave="doMouseLeave">
                    <div class="thumbnail">
                        <img :src="firstInstaFeedData.media_type === 'VIDEO'? firstInstaFeedData.thumbnail_url : firstInstaFeedData.media_url" alt="">
                    </div>
                    <p class="play" v-if="firstInstaFeedData.media_type === 'VIDEO'"><img src="//fiximage.10x10.co.kr/web2022/insta/btn_play.png" alt=""></p>
                    <div class="desc_wrap">
                        <p class="new">NEW</p>
                        <p class="desc"><span>{{firstInstaFeedData.caption}}</span></p>
                    </div>
                    <a :href="firstInstaFeedData.permalink" @click="moveToUrl(1)" class="btn_go" v-show="false" target="_blank"><img src="//fiximage.10x10.co.kr/web2022/insta/btn_go.png" alt=""></a>
                </div>
                <div class="sub_list">
                    <div :class="['insta_item', {play : feed.media_type === 'VIDEO'}]"  v-for="(feed, index) in getInstaFeedData" @mouseenter="doMouseEnter" @mouseleave="doMouseLeave">
                        <div class="thumbnail insta_sub"><img :src="feed.media_type === 'VIDEO'? feed.thumbnail_url : feed.media_url" ></div>
                        <p class="play" v-if="feed.media_type === 'VIDEO'"><img src="//fiximage.10x10.co.kr/web2022/insta/btn_play.png" alt=""></p>
                        <a :href="feed.permalink" @click="moveToUrl(index+2)" class="btn_go" v-show="false" target="_blank"><img src="//fiximage.10x10.co.kr/web2022/insta/btn_go.png" alt=""></a>
                    </div>
                </div>
            </div>		
            <a href="https://instagram.com/your10x10" @click="moveInstagramMore()" class="go_insta" target="_blank">텐바이텐 인스타그램 구경하기</a>
        </div>
	`,
	data() {
		return {
			instaFeedData: []
		}
	},
	mounted() {
		const _this = this;
		this.$nextTick(function() {
			_this.createInstaFeed();
		})
	} ,
	computed : {
		getInstaFeedData() {
            const _this = this;
			let tempInstaFeedData = [];
            tempInstaFeedData = Object.assign([], _this.instaFeedData);
            if (tempInstaFeedData.length > 0) {
                tempInstaFeedData.splice(0, 1);
            }
			return tempInstaFeedData;
		},
		isInstaFeedData() {
			return this.instaFeedData.length > 0;
		},
		firstInstaFeedData() {
			const _this = this;
			if (_this.instaFeedData.length > 0) {
				return _this.instaFeedData[0];
			} else {
				return null;
			}
		}
	},
	methods : {
		createInstaFeed() {
			const _this = this;
			call_apiV2('GET', '/today/instaFeed', '',
				data => {
					_this.instaFeedData = data.slice(0,5);
            });
		}
		, moveToUrl(index) {
			fnAmplitudeEventMultiPropertiesAction("click_instagram_feed", "number",	index + "");
		}
        , doMouseEnter(event) {
            $(event.target).children(".btn_go").show();
        }
        , doMouseLeave(event) {
            $(event.target).children(".btn_go").hide();
        }
		, moveInstagramFollow() {
			fnAmplitudeEventAction("click_instagram_follow", " ", " ");
		}
		, moveInstagramMore() {
			fnAmplitudeEventAction("click_instagram_more", " ", " ");
		}
	}
})

// instaFeed
new Vue({
	el: "#instaFeed",
	template : `
		<div id="insta_feed">
			<insta-feed></insta-feed>
		</div>
	`
})