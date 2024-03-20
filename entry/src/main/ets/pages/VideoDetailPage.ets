import router from '@ohos.router'
import Api from '../net/Api'
import { PageListDimensionBean } from '../bean/PageListBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { Utils } from '../Utils/Utils'
import { PlayVideoBean } from '../bean/PlayVideoBean'
import {VideoPlay} from '../../../../../player/src/main/ets/component/VideoPlay'

@Entry
@Component
struct DetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State loadingPage:LoadingStatus = LoadingStatus.Loading;
  @State dimension :PageListDimensionBean = null
  @State url :string=''
  @State header:Map<string,string>= new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Referer", "https://www.bilibili.com"]
  ])
  aboutToAppear() {
    this.bvid = router.getParams()['bvid']
    this.cid = router.getParams()['cid']
    // cid 为0时，需要单独获取cid
    if (this.cid === 0) {
      Api.getPageList(this.bvid).then((item)=>{
        this.cid = item[0].cid
        this.dimension = item[0].dimension

        Utils.Toast("测试一下:"+item[0].dimension.width+" --- "+item[0].dimension.height)
        // this.loadingPage = LoadingStatus.LoadingSuccess
      }).catch(err=>{
        this.loadingPage = LoadingStatus.LoadingFailure
      })
    }
    Api.getPlayVideo(this.bvid,this.cid)
      .then((item:PlayVideoBean)=>{
        this.loadingPage = LoadingStatus.LoadingSuccess
        this.url = item.durl[0].url
      }).catch(err=>{
      this.loadingPage = LoadingStatus.LoadingFailure
    })
  }

  build() {
    Row() {
      if (this.loadingPage === LoadingStatus.LoadingSuccess){
        Column() {
          Text(`bvid:${this.bvid},cid:${this.cid}\n`)
            .width('100%')
          VideoPlay({url:this.url,header:this.header})
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
