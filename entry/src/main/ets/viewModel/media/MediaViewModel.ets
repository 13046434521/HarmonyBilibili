import { MediaFtBean } from '../../bean/mediaFt/MediaFtBean'
import Constants from '../../common/Constants'
import ApiMediaFt from '../../net/ApiMediaFt'

export class MediaViewModel{

  /**
   * @name 获取视频基本信息
   * @param seasonId
   * @param qn 清晰度
   */
  getMediaInfo(seasonId:number,qn:number=Constants.QN){
    return ApiMediaFt.getMediaFtAidCidEpid(seasonId,qn)
  }

  /**
   * @name 获取当前视频URL以及播放进度等信息
   * @param avid
   * @param cid
   * @param epId
   * @param qn 清晰度
   */
  getMediaUrl(avid:number,cid:number,epId:number,qn:number=Constants.QN){
    return ApiMediaFt.getMediaFtUrl(avid,cid,epId,qn)
  }
}