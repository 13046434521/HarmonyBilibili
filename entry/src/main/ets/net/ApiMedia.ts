import axios from '@ohos/axios'
import { MediaBean } from '../bean/media/MediaBean'
import { MediaUrlBean } from '../bean/media/MediaUrlBean'
import { PlayVideoBean } from '../bean/PlayVideoBean'
import Constants from '../common/Constants'
import { ApiBase } from './ApiBase'

export class ApiMediaFt extends ApiBase{

  // https://api.bilibili.com/pgc/review/user?media_id=20328386
  // 剧集基本信息（mdid方式）返回信息与getMediaFt大致相同，因此不需要

  // seasonId是SearchMediaFtBean中的"season_id或者pgc_season_id": 45735,
  // 年会不能停 ： https://api.bilibili.com/pgc/view/web/season?season_id=45735
  // 获取剧集明细（web端）（ssid/epid方式）
  // result
  getMediaFtAidCidEpid(seasonId:number,qn:number):Promise<MediaBean>{
    let url = `https://api.bilibili.com/pgc/view/web/season?season_id=${seasonId}&qn=${qn}`
    return this.request(url,this.instanceAxios)
  }

  //  https://api.bilibili.com/pgc/player/web/playurl?avid=1900434537&cid=1432159459&ep_id=814315&qn=116
  // 获取番剧视频流URL
  // result 此接口和getMediaFt 都能获取URL，选用一个即可
  getMediaFtUrl(avid: number, cid: number,ep_id:number,qn:number=116):Promise<MediaUrlBean>{
    let url = `https://api.bilibili.com/pgc/player/web/playurl?avid=${avid}&cid=${cid}&ep_id=${ep_id}&qn=${qn}`
    return this.request(url,this.instanceAxios)
  }

  // 'https://api.bilibili.com/x/player/wbi/playurl?avid=1900434537&cid=1432159459&qn=116'
  // 需要Referer
  // 此接口和getMediaFtUrl 都能获取URL，选用一个即可
  getMediaFtPlayUrl(avid: number, cid: number,qn:number=116): Promise<PlayVideoBean> {
    let url = `/player/playurl?avid=${avid}&cid=${cid}&qn=${qn}`
    return this.request(url,this.instanceAxios)
  }


  // https://api.bilibili.com/pgc/review/user
  // 获取剧集基本信息
  getMediaBasicInfo(){
    let url = 'https://api.bilibili.com/pgc/review/user'
  }
  // https://api.bilibili.com/pgc/view/web/season
  // 获取剧集详细信息
  getMediaDetailInfo<T>(season_id:number,ep_id:string ='',qn:number=Constants.QN){
    let url = `https://api.bilibili.com/pgc/view/web/season?season_id=${season_id}&ep_id=${ep_id}&qn=${qn}`
    return this.request<T>(url,this.instanceAxios)
  }

  // https://api.bilibili.com/pgc/web/season/section?season_id=42290
  // 获取剧集分集信息

  /**
   * @name 番剧影视推荐推荐
   * @url https://api.bilibili.com/pgc/season/web/related/recommend?season_id=39431
   * @param season_id 番号/视频 ID
   */
  getMediaRelation<T>(season_id:number){
    let url = `https://api.bilibili.com/pgc/season/web/related/recommend?season_id=${season_id}`
    return this.request<T>(url,this.instanceAxios)
  }
}

const apiMediaFt: ApiMediaFt = new ApiMediaFt()

export default apiMediaFt as ApiMediaFt