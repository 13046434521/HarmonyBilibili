import router from '@ohos.router'
import Api from '../net/Api'
import { PageListDimensionBean } from '../bean/PageListBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { Utils } from '../Utils/Utils'
import { PlayVideoBean } from '../bean/PlayVideoBean'
import { VideoPlay } from '../component/VideoPlay'

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

  async aboutToAppear() {
    this.bvid = router.getParams()['bvid']
    this.cid = router.getParams()['cid']
    // cid 为0时，需要单独获取cid
    if (this.cid === 0) {
      await Api.getPageList(this.bvid).then((item)=>{
        this.cid = item[0].cid
        this.dimension = item[0].dimension
        this.loadingPage = LoadingStatus.LoadingSuccess
      }).catch(err=>{
        this.loadingPage = LoadingStatus.LoadingFailure
      })
    }

    await Api.getPlayVideo(this.bvid,this.cid)
      .then((item:PlayVideoBean)=>{
        this.url = item.durl[0].url
        this.loadingPage = LoadingStatus.LoadingSuccess
      }).catch(err=>{
      this.loadingPage = LoadingStatus.LoadingFailure
    })
  }

  build() {
    Row() {
      VideoPlay({url:this.url,header:this.header}).layoutWeight(1)
    }.width('100%')
    .height('100%')
  }
}
