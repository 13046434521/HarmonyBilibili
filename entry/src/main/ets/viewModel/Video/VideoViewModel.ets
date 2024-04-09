import VideoInfo from '../../bean/video/VideoInfo'
import Api from '../../net/Api'
import ApiBiliUser from '../../net/ApiBiliUser'
import ApiVideo from '../../net/ApiVideo'


export default  class VideoViewModel{

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
}