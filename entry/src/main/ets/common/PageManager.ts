import router from '@ohos.router'
import { HomeBean, HomeBeanItem } from '../bean/HomeBean'
import WebConstants from './WebConstants'

export class PageManager {
  static routerIndex(homeData?: Array<HomeBeanItem>) {
    router.replaceUrl({
      url: 'pages/Index',
      params: {
        'homeData': homeData,
      }
    }, router.RouterMode.Single)
  }

  static routerSearchHot(title: string) {
    router.pushUrl({ url: 'pages/Search/SearchHotPage', params: {
      title: title
    } })
  }

  static routerSearchPage(keyword: string) {
    router.pushUrl({ url: "pages/Search/SearchPage", params: { keyword: keyword } })
  }

  static routerSearchWeb() {
    router.pushUrl({ url: "pages/Search/SearchWebPage" })
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
  static routerVideoDetail(bvid: string, cid: number = 0, type: PageType = PageType.PUSH) {
    let url = 'pages/Video/VideoDetailPage'
    let params = { 'bvid': bvid, 'cid': cid }

    if (type === PageType.PUSH) {
      router.pushUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    } else {
      router.replaceUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    }
  }

  // 直播间页面
  static routerLiving(roomId: number, type: PageType = PageType.PUSH) {
    let url = 'pages/Live/LivePage'
    let params = { 'roomId': roomId }

    if (type === PageType.PUSH) {
      router.pushUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    } else {
      router.replaceUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    }
  }


  // 影视|番剧页面
  static routerMedia(season_id: number, epid: number = 0,type: PageType = PageType.PUSH) {
    let url = 'pages/Media/MediaPage'
    let params = { 'seasonId': season_id,
                    'epid':epid}

    if (type === PageType.PUSH) {
      router.pushUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    } else {
      router.replaceUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    }
  }

  // 图文页面
  static routerArticle(article_id: number, type: PageType = PageType.PUSH) {
    let url = 'pages/Article/ArticlePage'
    let params = { 'articleId': article_id }

    if (type === PageType.PUSH) {
      router.pushUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    } else {
      router.replaceUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    }
  }

  static routerBiliUser(mid: number, type: PageType = PageType.PUSH) {
    let url = 'pages/BiliUser/BiliUserPage'
    let params = { 'mid': mid }

    if (type === PageType.PUSH) {
      router.pushUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    } else {
      router.replaceUrl({ url: url, params: params })
    }
  }

  static routerFollowWeb(mid: number, type: 'fans' | 'follow') {
    router.pushUrl({
      url: 'pages/Mine/MineWebPage',
      params: { 'mine_web_url': WebConstants.getFollow(mid, type) }
    })
  }

  static routerMineWeb(url: string) {
    router.pushUrl({ url: 'pages/Mine/MineWebPage', params: { 'mine_web_url': url } })
  }
}

export enum PageType {
  PUSH = 'push',
  REPLACE = 'replace'
}

export class RouterConstants {
  static HOME_DATA = 'homeData' // Splash页面预加载的主页面数据，传递到主页面

  static ARTICLE_ID = 'articleId' // 图文页面
  static SEASON_ID = 'seasonId' // 影视页面
  static LIVE_ID = 'roomId' // 番剧页面
  static ROOM_ID = 'roomId' // 直播间
  static BVID = 'bvid' // 视频详情页面
  static CID = 'cid' // 视频详情页面
  static EPID = 'epid' // 视频详情页面
  static MID = 'mid' // 用户页面
  /*------------------------------------------- Mine页面相关 --------------------------------------------*/
  static MINE_WEB_URL = 'mine_web_url' //  Mine的web页面
}