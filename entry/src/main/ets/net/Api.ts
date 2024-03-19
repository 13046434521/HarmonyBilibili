import axios, {InternalAxiosRequestConfig} from '@ohos/axios'
import {HomeBean} from '../bean/HomeBean';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { PlayVideoBean } from '../bean/PlayVideoBean';
import { SearchHotBean } from '../bean/SearchHotBean';
import { PageListBean } from '../bean/PageListBean';
import { SearchBaseBean } from '../bean/SearchBaseBean';
import { SearchType } from '../common/SearchType';
import { SearchSuggestResultBean } from '../bean/SearchSuggestBean';
import { SearchDefaultBean } from '../bean/SearchDefaultBean';
import { ApiBase } from './ApiBase';

export class Api extends ApiBase{
  constructor() {
    super();
    this.instance.interceptors.request.use((value: InternalAxiosRequestConfig)=>{
      console.log(`拦截器：发送URL：${value.baseURL}${value.url} Header：${value.headers}`)
      // for (const element of value.headers) {
      //    console.log(`拦截器：header:${element.toString()}`)
      // }
      return value
    })

    this.instanceCookie.interceptors.request.use((value: InternalAxiosRequestConfig)=>{
      console.log(`拦截器:cookie的：发送URL：${value.baseURL}${value.url} Header：${value.headers}`)
      return value
    })
  }

  getHomePages(page: number = 0): Promise<HomeBean> {
    let url = `/web-interface/index/top/feed/rcmd?ps=12&fresh_idx=${page}&feed_version=undefined`
    return this.request(url)
  }

  getHomeSearch(): Promise<HomeSearchBean> {
    let url = "/web-interface/search/default"
    return this.request(url)
  }

  // 'https://api.bilibili.com/x/player/playurl?bvid=BV1dS421c777&cid=1461669931&qn=116'
  // 需要Referer
  // 视频Video
  getPlayVideo(bvid: string, cid: number): Promise<PlayVideoBean> {
    let url = `/player/playurl?bvid=${bvid}&cid=${cid}&qn=116`
    return this.request(url)
  }

  // 'https://api.bilibili.com/x/player/wbi/playurl?avid=1000489113&cid=1432195172&qn=116'
  // 需要Referer
  // 影视
  getPlayVideoAid(avid: number, cid: number): Promise<PlayVideoBean> {
    let url = `/player/playurl?avid=${avid}&cid=${cid}&qn=116`
    return this.request(url)
  }
  // 'https://api.bilibili.com/pgc/player/web/playurl?ep_id=232533'
  // 需要Referer
  // 番剧
  getPlayVideoEpId(ep_id: number): Promise<PlayVideoBean> {
    let url = `/player/playurl?ep_id=${ep_id}&qn=116`
    return this.request(url)
  }

  // https://api.bilibili.com/x/player/pagelist?bvid=BV1Hj421Z7Lw
  // {"code":0,"message":"0","ttl":1,"data":[{"cid":1469197725,"page":1,"from":"vupload","part":"美国即将封禁tiktok！","duration":222,"vid":"","weblink":"","dimension":{"width":1920,"height":1080,"rotate":0},"first_frame":"http://i0.hdslb.com/bfs/storyff/n240314sa2e909peujo7pbkqeqe4zik5_firsti.jpg"}]}
  // Video页面，没有cid时，需要额外获取一遍
  getPageList(bvid: string):Promise<PageListBean[]>{
    let url = `/player/pagelist?bvid=${bvid}`
    return this.request(url)
  }

  //https://s.search.bilibili.com/main/suggest?term=kobe&main_ver=v1&highlight=""
  getSearchSuggest(suggest:string): Promise<SearchSuggestResultBean>{
    let keyword = suggest.replace(/ /g,`%20`)
    let url = `https://s.search.bilibili.com/main/suggest?term=${keyword}&main_ver=v1&highlight=""`
    return this.request<SearchSuggestResultBean>(url,axios)
  }
  // getSearchHot(): Promise<BaseResponse<SearchHotBean>> {
  // 20个热搜
  getSearchHot(): Promise<SearchHotBean> {
    let url = '/v2/search/trending/ranking'
    return this.request<SearchHotBean>(url)
  }

  //  综合搜索：https://api.bilibili.com/x/web-interface/wbi/search/all/v2?keyword=洛天依&page=1
  //  需要cookie
  getSearchDefault(keyword:string,page:number=1): Promise<SearchBaseBean<SearchDefaultBean>> {
    let key = keyword.replace(/ /g,`%20`)
    let url = `/web-interface/wbi/search/all/v2?keyword=${key}&page=${page}`
    return this.request(url,this.instanceCookie)
  }
/*  视频：video
  番剧：media_bangumi
  影视：media_ft
  直播间及主播：live
  直播间：live_room
  主播：live_user
  专栏：article
  话题：topic
  用户：bili_user
  相簿：photo*/
  // "video" |"media_bangumi" |"media_ft" |"live" |"live_room" |"live_user" |"article" |"topic" |"bili_user" |"photo"
  // 详细搜索，type:只能是上列的值
  // 需要cookie
  getSearchType<T>(search_type:SearchType, keyword?: string, page?: number): Promise<SearchBaseBean<T>> {
    let key = keyword.replace(/ /g,`%20`)
    let url = `/web-interface/search/type?search_type=${search_type}&keyword=${key}&page=${page}`
    return this.request(url,this.instanceCookie)
  }
  // https://api.bilibili.com/x/article/viewinfo?id=2265901
  // article的详细内容链接,id为SearchArticle中的id

  // https://passport.bilibili.com/x/passport-login/web/qrcode/generate
}

//https://api.live.bilibili.com/room/v1/Room/playUrl?qn=1000&platform=web&cid=23982773
// 直播间，可以获取直播流：cid为roomid，可用ijkplayer播放

// https://api.bilibili.com/x/web-interface/search/type?search_type=live&keyword=dota2&page=1
// 搜索直播间

const api: Api = new Api()

export default api as Api