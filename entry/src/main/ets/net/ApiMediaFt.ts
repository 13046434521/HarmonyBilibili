import { PlayVideoBean } from '../bean/PlayVideoBean'
import { ApiBase } from './ApiBase'

export class ApiMediaFt extends ApiBase{
  // 'https://api.bilibili.com/x/player/wbi/playurl?avid=1000489113&cid=1432195172&qn=116'
  // 需要Referer
  // 影视
  getMediaFt(avid: number, cid: number,qn:number=116): Promise<PlayVideoBean> {
    let url = `/player/playurl?avid=${avid}&cid=${cid}&qn=${qn}`
    return this.request(url)
  }
}

const apiMediaFt: ApiMediaFt = new ApiMediaFt()

export default apiMediaFt as ApiMediaFt