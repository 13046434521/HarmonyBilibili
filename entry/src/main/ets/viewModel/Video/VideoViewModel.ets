import { Online } from '../../bean/Online'
import VideoInfo from '../../bean/video/VideoInfo'
import { VideoRecommend } from '../../bean/video/VideoRecommend'
import Api from '../../net/Api'
import ApiBiliUser from '../../net/ApiBiliUser'
import ApiVideo from '../../net/ApiVideo'
import { BaseViewModel } from '../BaseViewModel'


export default  class VideoViewModel extends BaseViewModel{

  // 加载视频信息
  loadVideoData(bvid:string,cid:number=0){
    // cid为0时要单独再获取一次
    if (cid === 0) {
      return Api.getPageList(bvid).then((item)=>{
        cid = item[0].cid
        return Api.getPlayVideo(bvid,cid)
      })
    }else{
      return Api.getPlayVideo(bvid,cid)
    }
  }

  /**
   * @name 视频详细信息
   * @url https://api.bilibili.com/x/web-interface/view?bvid=BV117411r7R1
   * @param bvid 视频号
   * @returns VideoInfo 返回视频详情
   */
  loadVideoInfo(bvid:string){
    return ApiVideo.getVideoInfo<VideoInfo>(bvid)
  }


  upInfo(mid:number){
    return ApiBiliUser.loginUserInfo(mid)
  }
  /**
   * @name 视频详情页的推荐视频信息
   * @url https://api.bilibili.com/x/web-interface/archive/related?bvid=BV1QQ4y1M7Va
   * @param bvid 视频bvid号
   * @returns 推荐视频信息 VideoRecommend[]
   */
  videoRecommend(bvid:string){
    return ApiVideo.getVideoRecommend<VideoRecommend[]>(bvid)
  }
}