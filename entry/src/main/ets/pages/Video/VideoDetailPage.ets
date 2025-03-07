import router from '@ohos.router'
import Api from '../../net/Api'
import { PageListDimensionBean } from '../../bean/PageListBean'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PlayVideoBean } from '../../bean/PlayVideoBean'
import { VideoPlay } from '../../component/play/VideoPlay'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import window from '@ohos.window'
import { RouterConstants } from '../../common/PageManager'
import VideoViewModel from '../../viewModel/Video/VideoViewModel'
import VideoInfo from '../../bean/video/VideoInfo'
import VideoIntroduction from './VideoIntroduction'
import VideoComments from './VideoComments'
import { toast } from '../../Utils/ToastUtils'
import { BiliComments } from '../BiliComments'

@Entry
@Component
struct VideoDetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State aid: number = 0
  @State loadingPage:LoadingStatus = LoadingStatus.Loading;
  @State url :string=''
  @State @Watch('showPage')currentIndex:number = 0
  @State isShowPage :boolean[] = [true,false]
  videoViewModel:VideoViewModel = new VideoViewModel()
  videoController: VideoController = new VideoController()
  tabController:TabsController = new TabsController()

  showPage(){
    this.isShowPage[this.currentIndex] = true
  }

  aboutToAppear() {
    if (router.getParams()!=null) {
      this.bvid = router.getParams()[RouterConstants.BVID]
      this.cid = router.getParams()[RouterConstants.CID]
      this.aid = router.getParams()[RouterConstants.AID]
      new Promise<PlayVideoBean>((resolve,reject)=>{
        if (this.cid === 0) {
          resolve( Api.getPageList(this.bvid).then((item)=>{
            this.cid = item[0].cid

            return Api.getPlayVideo(this.bvid,this.cid)
          }))
        }else{
          resolve( Api.getPlayVideo(this.bvid,this.cid))
        }
      }).then(playVideo=>{
        this.url = playVideo.durl[0].url

        return new Promise<number>((resolve,reject)=>{
          if (this.aid===0) {
            this.videoViewModel.loadVideoInfo(this.bvid).then(videoInfo=>{
              resolve(videoInfo.aid)
            })
          }else{
            resolve(this.aid)
          }
        })
      }).then((aid)=>{
        this.aid = aid
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

  build() {
    Column() {
      VideoPlay({url:this.url,videoController:this.videoController})

      Tabs({barPosition:BarPosition.Start,controller:this.tabController}){
        TabContent(){
          if (this.isShowPage[0]){
            VideoIntroduction({videoViewModel:this.videoViewModel,bvid:this.bvid,cid:this.cid})
          }
        }.tabBar(this.TabBuilders(0,'简介'))
        TabContent(){
          if (this.isShowPage[1]){
            BiliComments ({ aid: this.aid })
          }
        }.tabBar(this.TabBuilders(1,'评论'))
      } .barMode(BarMode.Fixed)
      .scrollable(true)
      .layoutWeight(1)
      .width('100%')
      .onChange((index)=>{
        this.tabController.changeIndex(index)
        this.currentIndex = index
      })
      .visibility(this.videoController.videoModel.orientation ===window.Orientation.LANDSCAPE?Visibility.None:Visibility.Visible)
    }.width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder TabBuilders(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
        .fontSize(16)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .margin({bottom:'4%'})
        .width('40%')
      Divider()
        .strokeWidth(2)
        .color($r('app.color.bilibili_theme'))
        .opacity(this.currentIndex === index  ? 1 : 0)
        .width('30%')
    }.width('100%')
    .height('100%')
    .stateStyles({pressed:pressedStyles,normal:normalStyles})
    .borderRadius(5)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = index
      this.tabController.changeIndex(this.currentIndex)
    })
  }

  onBackPress(){
    if (this.videoController.videoModel.orientation === window.Orientation.LANDSCAPE){
      this.videoController.changeOrientation()
      return true
    }
  }
}

@Styles function  pressedStyles() {
  .backgroundColor($r('app.color.bilibili_background_grey'))
}

@Styles function  normalStyles() {
  .backgroundColor($r('app.color.bilibili_background_white'))
}