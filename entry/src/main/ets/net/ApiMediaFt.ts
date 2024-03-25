import axios from '@ohos/axios'
import { MediaFtBean } from '../bean/mediaFt/MediaFtBean'
import { MediaFtUrlBean } from '../bean/mediaFt/MediaFtUrlBean'
import { PlayVideoBean } from '../bean/PlayVideoBean'
import { ApiBase } from './ApiBase'

export class ApiMediaFt extends ApiBase{

  // https://api.bilibili.com/pgc/review/user?media_id=20328386
  // 剧集基本信息（mdid方式）返回信息与getMediaFt大致相同，因此不需要

  // seasonId是SearchMediaFtBean中的"season_id或者pgc_season_id": 45735,
  // 年会不能停 ： https://api.bilibili.com/pgc/view/web/season?season_id=45735
  // 获取剧集明细（web端）（ssid/epid方式）
  // result
  getMediaFtAidCidEpid(seasonId:number):Promise<MediaFtBean>{
    let url = `https://api.bilibili.com/pgc/view/web/season?season_id=${seasonId}`
    return this.request(url,this.instanceAxios)
  }

  //  https://api.bilibili.com/pgc/player/web/playurl?avid=1900434537&cid=1432159459&ep_id=814315&qn=116
  // 获取番剧视频流URL
  // result 此接口和getMediaFt 都能获取URL，选用一个即可
  getMediaFtUrl(avid: number, cid: number,ep_id:number,qn:number=116):Promise<MediaFtUrlBean>{
    let url = `https://api.bilibili.com/pgc/player/web/playurl?avid=${avid}&cid=${cid}&ep_id=${ep_id}&qn=${qn}`
    return this.request(url,this.instanceAxios)
  }

  // 'https://api.bilibili.com/x/player/wbi/playurl?avid=1900434537&cid=1432159459&qn=116'
  // 需要Referer
  // 此接口和getMediaFtUrl 都能获取URL，选用一个即可
  getMediaFtPlayUrl(avid: number, cid: number,qn:number=116): Promise<PlayVideoBean> {
    let url = `/player/playurl?avid=${avid}&cid=${cid}&qn=${qn}`
    return this.request(url)
  }
}

const apiMediaFt: ApiMediaFt = new ApiMediaFt()

export default apiMediaFt as ApiMediaFt