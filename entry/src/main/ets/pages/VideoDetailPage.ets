import router from '@ohos.router'
import display from '@ohos.display'
import Api from '../net/Api'
import { VideoPlay } from '../component/VideoPlay'
import promptAction from '@ohos.promptAction'
import { PageListDimensionBean } from '../bean/PageListBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { Utils } from '../Utils/Utils'

@Entry
@Component
struct DetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State loadingPage:LoadingStatus = LoadingStatus.Loading;
  @State dimension :PageListDimensionBean = null
  aboutToAppear() {
    this.bvid = router.getParams()['bvid']
    this.cid = router.getParams()['cid']
    // cid 为0时，需要单独获取cid
    if (this.cid === 0) {
      Api.getPageList(this.bvid).then((item)=>{
        this.cid = item[0].cid
        this.dimension = item[0].dimension

        Utils.Toast("测试一下:"+item[0].dimension.width+" --- "+item[0].dimension.height)
        this.loadingPage = LoadingStatus.LoadingSuccess
      }).catch(err=>{
        this.loadingPage = LoadingStatus.LoadingFailure
      })
    }else{
      this.loadingPage = LoadingStatus.LoadingSuccess
    }
  }

  build() {
    Row() {
      if (this.loadingPage === LoadingStatus.LoadingSuccess){
        Column() {
          VideoPlay({bvid:this.bvid,cid:this.cid})
            .width('100%')
        }.layoutWeight(1)
      }else if (this.loadingPage === LoadingStatus.Loading){
        Loading().width('100%')
          .layoutWeight(1)
      }else {
        Text("加载失败")
        .layoutWeight(1).width('100%')
      }

    }.width('100%')
    .height('100%')
  }
}
