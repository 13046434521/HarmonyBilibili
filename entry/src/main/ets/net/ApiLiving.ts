import { LiveBean } from '../bean/Live/LiveBean'
import { ApiBase } from './ApiBase'
//https://api.live.bilibili.com/room/v1/Room/playUrl?qn=1000&platform=web&cid=23982773
// 直播间，可以获取直播流：cid为roomid，可用ijkplayer播放

// https://api.bilibili.com/x/web-interface/search/type?search_type=live&keyword=dota2&page=1
// 搜索直播间

// 直播相关
export class ApiLiving extends ApiBase{
  //https://api.live.bilibili.com/room/v1/Room/playUrl?qn=1000&platform=web&cid=23982773
  // 直播间，可以获取直播流：cid为roomid，可用ijkplayer播放

  getLive(roomId:number,qn:number=1000):Promise<LiveBean>{
    let url = `https://api.live.bilibili.com/room/v1/Room/playUrl?qn=${qn}&platform=web&cid=${roomId}`
    return this.request<LiveBean>(url,this.instanceCookie)
  }
}

const apiLive: ApiLiving = new ApiLiving()

export default apiLive as ApiLiving