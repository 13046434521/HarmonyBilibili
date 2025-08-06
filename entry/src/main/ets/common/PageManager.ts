import router from '@ohos.router'
import { HomeBean, HomeBeanItem } from '../bean/HomeBean'
import WebConstants from './WebConstants'
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

  static AID = 'aid' // 评论页面

  /*------------------------------------------- Mine页面相关 --------------------------------------------*/
  static MINE_WEB_URL = 'mine_web_url' //  Mine的web页面
}

export interface HOME_DATA {// Splash页面预加载的主页面数据，传递到主页面
  homeData: Array<HomeBeanItem>;
}
export interface ARTICLE_ID {// 图文页面
  articleId: number;
}
export interface SEASON_EP_ID {// 影视|番剧页面
  seasonId: number;
  epid: number;// 视频详情页面
}
export interface LIVE_ID {// 番剧页面
  liveId: number;
}
export interface ROOM_ID {// 直播间
  roomId: number;
}
export interface BVID_CID_AID { // 视频详情页面
  bvid: string;
  cid: number;
  aid: number;
}
export interface CID {// 视频详情页面
  cid: number;
}
export interface EPID {// 视频详情页面
  epid: number;
}
export interface MID {// 用户页面
  mid: number;
}
export interface AID {// 评论页面
  aid: number;
}

/*------------------------------------------- Mine页面相关 --------------------------------------------*/
export interface MINE_WEB_URL {// Mine的web页面
  webUrl: string;
}

export interface SEARCH_PARAMS{
  keyword?:string
  title?:string
}
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
    let params:SEARCH_PARAMS = {title: title}
    router.pushUrl({ url: 'pages/Search/SearchHotPage', params: {params}})
  }

  static routerSearchPage(keyword: string) {
    let params:SEARCH_PARAMS = {keyword: keyword}
    router.pushUrl({ url: "pages/Search/SearchPage", params: params})
  }

  static routerSearchWeb() {
    router.pushUrl({ url: "pages/Search/SearchWebPage" })
  }

  // 视频详情页面
  static routerHomePage(homeData: Array<HomeBeanItem>) {
    let params:HOME_DATA = {homeData: homeData}
    router.replaceUrl({
      url: 'pages/Index',
      params: params
    }, router.RouterMode.Single)
  }

  // 视频详情页面
  static routerVideoDetail(bvid: string,aid:number = 0, cid: number = 0, type: PageType = PageType.PUSH) {
    let url = 'pages/Video/VideoDetailPage'
    let params:BVID_CID_AID = { bvid: bvid, cid: cid ,aid:aid}

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
    let params:ROOM_ID = { 'roomId': roomId }

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
    let params:SEASON_EP_ID = { seasonId: season_id,
                    epid:epid}

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
    let params:ARTICLE_ID = { articleId: article_id }

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
    let params:MID = { mid: mid }

    if (type === PageType.PUSH) {
      router.pushUrl({ url: url, params: params }
        , router.RouterMode.Standard)
    } else {
      router.replaceUrl({ url: url, params: params })
    }
  }

  static routerFollowWeb(mid: number, type: 'fans' | 'follow') {
    let param:MINE_WEB_URL = {
      webUrl: WebConstants.getFollow(mid, type)
    }
    router.pushUrl({
      url: 'pages/Mine/MineWebPage',
      params: param
    })
  }

  static routerMineWeb(url: string) {
    let param:MINE_WEB_URL = {
      webUrl: url
    }
    router.pushUrl({ url: 'pages/Mine/MineWebPage', params: param})
  }
}

export enum PageType {
  PUSH = 'push',
  REPLACE = 'replace'
}