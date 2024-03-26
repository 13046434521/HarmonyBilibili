import router from '@ohos.router'
import Api from '../net/Api'
import { PageListDimensionBean } from '../bean/PageListBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { PlayVideoBean } from '../bean/PlayVideoBean'
import { VideoPlay } from '../component/VideoPlay'
import { VideoViewModel } from '../viewModel/VideoViewModel'

@Entry
@Component
struct DetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State loadingPage:LoadingStatus = LoadingStatus.Loading;
  @State dimension :PageListDimensionBean = null
  @State url :string=''
  @State videoViewModel: VideoViewModel = new VideoViewModel()
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

  onPageHide(){
    this.videoViewModel.pause()
  }

  onPageShow(){
    this.videoViewModel.play()
  }

  aboutToDisappear(){
    this.videoViewModel.release()
  }

  build() {
    Column() {
      VideoPlay({url:this.url,videoViewModel:this.videoViewModel})
    }.width('100%')
    .justifyContent(FlexAlign.Start)
  }
}
