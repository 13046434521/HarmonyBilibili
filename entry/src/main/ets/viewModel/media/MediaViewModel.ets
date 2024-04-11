import { MediaFtBean } from '../../bean/media/MediaFtBean'
import { MediaRelation } from '../../bean/media/MediaRelation'
import Constants from '../../common/Constants'
import ApiMedia from '../../net/ApiMedia'
import { BaseViewModel } from '../BaseViewModel'

export class MediaViewModel extends BaseViewModel{

  /**
   * @name 获取视频基本信息
   * @param seasonId
   * @param qn 清晰度
   */
  getMediaInfo(seasonId:number,ep_id:string ='',qn:number=Constants.QN){
    return ApiMedia.getMediaDetailInfo<MediaFtBean>(seasonId,ep_id,qn)
  }

  /**
   * @name 获取当前视频URL以及播放进度等信息
   * @param avid
   * @param cid
   * @param epId
   * @param qn 清晰度
   */
  getMediaUrl(avid:number,cid:number,epId:number,qn:number=Constants.QN){
    return ApiMedia.getMediaFtUrl(avid,cid,epId,qn)
  }
  /**
   * @name 番剧影视推荐推荐
   * @url https://api.bilibili.com/pgc/season/web/related/recommend?season_id=39431
   * @param season_id 番号/视频 ID
   */
  getMediaRelation(season_id:number){
    return ApiMedia.getMediaRelation<MediaRelation>(season_id)
  }
}