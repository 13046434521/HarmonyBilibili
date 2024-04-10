import VideoInfo from '../bean/video/VideoInfo'
import { ApiBase } from './ApiBase'

export class ApiVideo extends ApiBase{
  // 实时在线人数
  //'https://api.bilibili.com/x/player/online/total' \
  // --data-urlencode 'aid=759949922' \
  // --data-urlencode 'cid=392402545'

  /**
   * @name 视频详细信息
   * @url https://api.bilibili.com/x/web-interface/view?bvid=BV117411r7R1
   * @param bvid 视频号
   * @returns VideoInfo 返回视频详情
   */
  getVideoInfo<T>(bvid:string){
    let url = `https://api.bilibili.com/x/web-interface/view?bvid=${bvid}`

    return this.request<T>(url,this.instanceAxios)
  }
  //https://api.bilibili.com/x/tag/archive/tags?bvid=BV117411r7R1
  // 视频tag信息
  getVideoTag(bvid:string){
    let url = `https://api.bilibili.com/x/tag/archive/tags?bvid=${bvid}`

    return this.request(url,this.instanceAxios)
  }

  //https://api.bilibili.com/x/v2/reply/wbi/main?oid=85440373&type=1&mode=3&pagination_str=%7B%22offset%22:%22%22%7D&plat=1&seek_rpid=&web_location=1315875&w_rid=67b75f44868bd2e361fee6877f926ec5&wts=1712649241
  // 评论


  // https://api.bilibili.com/x/web-interface/archive/related?bvid=BV1QQ4y1M7Va
  // 视频详情页的视频推荐列表

  getVideoRecommend<T>(bvid:string){
    let url = `https://api.bilibili.com/x/web-interface/archive/related?bvid=${bvid}`
    return this.request<T>(url,this.instanceAxios)
  }


}
const apiVideo:ApiVideo = new ApiVideo()
export default apiVideo as ApiVideo
