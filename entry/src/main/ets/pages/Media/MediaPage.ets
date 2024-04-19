import router from '@ohos.router'
import { MediaBean } from '../../bean/media/MediaBean'
import { MediaUrlBean } from '../../bean/media/MediaUrlBean'
import { RouterConstants } from '../../common/PageManager'
import { VideoPlay } from '../../component/play/VideoPlay'
import ApiMediaFt from '../../net/ApiMedia'
import { showDialog } from '../../Utils/DialogUtil'
import { MediaViewModel } from '../../viewModel/media/MediaViewModel'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import { MediaIntroduction } from './MeidaIntroduction'
import window from '@ohos.window'
import { BiliComments } from '../BiliComments'

@Entry
@Component
struct MediaFtPage {
  @State url :string=''
  @State mediaInfo:MediaBean = new MediaBean()
  @State mediaUrl:MediaUrlBean = new MediaUrlBean()
  @State isShowPage :boolean[] = [true,false]
  @State @Watch('showPage')currentIndex:number = 0
  videoController:VideoController = new VideoController()
  mediaViewModel:MediaViewModel = new MediaViewModel()
  tabController:TabsController = new TabsController()
  seasonId:number
  @State epid:number = 0
  @State index :number = 0
  @State aid:number = 0
  showPage(){
    this.isShowPage[this.currentIndex] = true
  }
  aboutToAppear(){
    // if (router.getParams()!=null) {
      this.seasonId = router.getParams()[RouterConstants.SEASON_ID]
      this.epid = router.getParams()[RouterConstants.EPID]
      // this.seasonId =  25622
      this.mediaViewModel.getMediaInfo(this.seasonId).then(mediaInfo=>{
        this.mediaInfo = mediaInfo

        if (this.epid!==0) {
          for (let index = 0; index < this.mediaInfo.episodes.length; index++) {
            const element = this.mediaInfo.episodes[index];
            if (this.epid === element.ep_id) {
              this.index = index
              continue
            }
          }
        }

        let avid = mediaInfo.episodes[this.index].aid
        let epId = mediaInfo.episodes[this.index].ep_id
        let cid = mediaInfo.episodes[this.index].cid
        this.epid = epId
        this.aid = avid
        return ApiMediaFt.getMediaFtUrl(avid,cid,epId)
      }).then(mediaFtUrl=>{
        this.mediaUrl = mediaFtUrl
        this.url = mediaFtUrl.durl[0].url
      }).catch(err=>{
        showDialog('MediaPage(播放页面)',err)
      })
  }

  onPageHide(){
    this.videoController.pause()
  }

  onPageShow(){
    this.videoController.play()
  }

  build() {
    Column() {
      VideoPlay({videoController:this.videoController,url:this.url})

      Tabs({barPosition:BarPosition.Start,controller:this.tabController}){
        TabContent(){
          if (this.isShowPage[0]){
            MediaIntroduction({mediaViewModel:this.mediaViewModel,seasonId:this.seasonId,epid:this.epid,index:this.index})
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
    }
    .width('100%')
    .layoutWeight(1)
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