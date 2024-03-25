import router from '@ohos.router'

export class PageManager{
  // 视频详情页面
  static routerVideoDetail(bvid:string){
    router.pushUrl({url:'pages/VideoDetailPage',params:{'bvid':bvid,'cid':0}})
  }

  // 直播间页面
  static routerLiving(roomId:number){
    router.pushUrl({url:'pages/Live/LivePage',params:{'roomId':roomId}})
  }

  // 番剧页面
  static routerMediaBanggumi(roomId:number){
    router.pushUrl({url:'pages/Live/LivePage',params:{'roomId':roomId}})
  }

  // 影视页面
  static routerMediaFt(season_id:number){
    router.pushUrl({url:'pages/MediaFt/MediaFtPage',params:{'seasonId':season_id}})
  }
}