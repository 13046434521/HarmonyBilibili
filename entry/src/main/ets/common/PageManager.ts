import router from '@ohos.router'
import { HomeBean, HomeBeanItem } from '../bean/HomeBean'
import WebConstants from './WebConstants'

export class PageManager {
  static routerIndex(homeData?: Array<HomeBeanItem>){
    router.replaceUrl({
      url: 'pages/Index',
      params: {
        'homeData': homeData,
      }
    }, router.RouterMode.Single)
  }
  static routerSearchHot(title: string) {
    router.pushUrl({url:'pages/Search/SearchHotPage',params:{
      title:title
    }})
  }
  static routerSearchPage(keyword:string) {
    router.pushUrl({url:"pages/Search/SearchPage",params:{keyword:keyword}})
  }
  static routerSearchWeb() {
    router.pushUrl({url:"pages/Search/SearchWebPage"})
  }
  // 视频详情页面
  static routerHomePage(homeData: Array<HomeBeanItem>) {
    router.replaceUrl({
      url: 'pages/Index',
      params: {
        'homeData': homeData,
      }
    }, router.RouterMode.Single)
  }

  // 视频详情页面
  static routerVideoDetail(bvid: string,cid:number=0) {
    router.pushUrl({ url: 'pages/VideoDetailPage', params: { 'bvid': bvid, 'cid': cid } })
  }

  // 直播间页面
  static routerLiving(roomId: number) {
    router.pushUrl({ url: 'pages/Live/LivePage', params: { 'roomId': roomId } })
  }

  // 番剧页面
  static routerMediaBangumi(roomId: number) {
    router.pushUrl({ url: 'pages/MediaBangumi/MediaBangumiPage', params: { 'roomId': roomId } })
  }

  // 影视页面
  static routerMediaFt(season_id: number) {
    router.pushUrl({ url: 'pages/MediaFt/MediaFtPage', params: { 'seasonId': season_id } })
  }

  // 图文页面
  static routerArticle(article_id: number) {
    router.pushUrl({ url: 'pages/Article/ArticlePage', params: { 'articleId': article_id } })
  }

  static routerBiliUser(mid: number) {
    router.pushUrl({ url: 'pages/BiliUser/BiliUserPage', params: { 'mid': mid } })
  }

  static routerFollowWeb(mid: number,type:'fans'|'follow') {
    router.pushUrl({ url: 'pages/Mine/MineWebPage', params: { 'mine_web_url': WebConstants.getFollow(mid,type)} })
  }

  static routerMineWeb(url:string) {
    router.pushUrl({ url: 'pages/Mine/MineWebPage', params: { 'mine_web_url':url} })
  }
}

export class RouterConstants {
  static HOME_DATA = 'homeData' // Splash页面预加载的主页面数据，传递到主页面

  static ARTICLE_ID = 'articleId' // 图文页面
  static SEASON_ID = 'seasonId' // 影视页面
  static LIVE_ID = 'roomId' // 番剧页面
  static ROOM_ID = 'roomId' // 直播间
  static BVID = 'bvid' // 视频详情页面
  static CID = 'cid' // 视频详情页面
  static MID = 'mid' // 用户页面
  /*------------------------------------------- Mine页面相关 --------------------------------------------*/
  static MINE_WEB_URL = 'mine_web_url' //  Mine的web页面
}