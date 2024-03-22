import router from '@ohos.router'

export class PageManager{
  static routerVideoDetail(bvid:string){
    router.pushUrl({url:'pages/VideoDetailPage',params:{'bvid':bvid,'cid':0}})
  }
}