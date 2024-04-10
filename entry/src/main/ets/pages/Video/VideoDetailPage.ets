import router from '@ohos.router'
import Api from '../../net/Api'
import { PageListDimensionBean } from '../../bean/PageListBean'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PlayVideoBean } from '../../bean/PlayVideoBean'
import { VideoPlay } from '../../component/VideoPlay'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import window from '@ohos.window'
import { RouterConstants } from '../../common/PageManager'
import VideoViewModel from '../../viewModel/Video/VideoViewModel'
import VideoInfo from '../../bean/video/VideoInfo'
import VideoIntroduction from './VideoIntroduction'
import VideoComments from './VideoComments'

@Entry
@Component
struct VideoDetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State loadingPage:LoadingStatus = LoadingStatus.Loading;
  @State url :string=''
  videoController: VideoController = new VideoController()
  videoViewModel:VideoViewModel = new VideoViewModel()
  aboutToAppear() {
    if (router.getParams()!=null) {
      this.bvid = router.getParams()[RouterConstants.BVID]
      this.cid = router.getParams()[RouterConstants.CID]

      this.videoViewModel.loadVideoData(this.bvid,this.cid).then(playVideo=>{
        this.url = playVideo.durl[0].url
        this.loadingPage = LoadingStatus.LoadingSuccess
      }).catch(err=>{
        this.loadingPage = LoadingStatus.LoadingFailure
      })
    }
  }

  onPageHide(){
    this.videoController.pause()
  }

  onPageShow(){
    this.videoController.play()
  }

  aboutToDisappear(){
    this.videoController.release('VideoDetailPage')
  }
@State volume:number = 0
  build() {
    Column() {
      VideoPlay({url:this.url,videoController:this.videoController})

      Tabs({barPosition:BarPosition.Start}){
        TabContent(){
          VideoIntroduction({videoViewModel:this.videoViewModel,bvid:this.bvid})
        }.tabBar('简介')
        TabContent(){
          VideoComments({videoViewModel:this.videoViewModel,bvid:this.bvid})
        }.tabBar('评论')
      } .barMode(BarMode.Fixed)
      .scrollable(true)
      .layoutWeight(1)
      .width('100%')
    }.width('100%')
    .justifyContent(FlexAlign.Start)
  }
}
