import router from '@ohos.router'
import { MediaFtBean } from '../../bean/mediaFt/MediaFtBean'
import { MediaFtUrlBean } from '../../bean/mediaFt/MediaFtUrlBean'
import { RouterConstants } from '../../common/PageManager'
import { VideoPlay } from '../../component/VideoPlay'
import ApiMediaFt from '../../net/ApiMediaFt'
import { showDialog } from '../../Utils/DialogUtil'
import { MediaViewModel } from '../../viewModel/media/MediaViewModel'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'

@Entry
@Component
struct MediaFtPage {
  @State url :string=''
  @State mediaInfo:MediaFtBean = new MediaFtBean()
  @State mediaUrl:MediaFtUrlBean = new MediaFtUrlBean()
  seasonId:number
  videoController:VideoController = new VideoController()
  mediaViewModel:MediaViewModel = new MediaViewModel()
  @State @Watch('showPage')currentIndex:number = 0
  @State isShowPage :boolean[] = [true,false]
  tabController:TabsController = new TabsController()
  showPage(){
    this.isShowPage[this.currentIndex] = true
  }
  aboutToAppear(){
    if (router.getParams()!=null) {
      this.seasonId = router.getParams()[RouterConstants.SEASON_ID]
      this.mediaViewModel.getMediaInfo(this.seasonId).then(medeiaInfo=>{
        this.mediaInfo = medeiaInfo
        let avid = medeiaInfo.episodes[0].aid
        let cid = medeiaInfo.episodes[0].cid
        let epId = medeiaInfo.episodes[0].ep_id
        return ApiMediaFt.getMediaFtUrl(avid,cid,epId)
      }).then(mediaFtUrl=>{
        this.mediaUrl = mediaFtUrl
        this.url = mediaFtUrl.durl[0].url
      }).catch(err=>{
        showDialog('MediaFtPage(影视播放页面)',err)
      })
    }
  }

  build() {
    Column() {
      VideoPlay({videoController:this.videoController,url:this.url})


      Tabs({barPosition:BarPosition.Start,controller:this.tabController}){
        TabContent(){
          if (this.isShowPage){
            // VideoIntroduction({videoViewModel:this.videoViewModel,bvid:this.bvid})
          }
        }.tabBar(this.TabBuilders(0,'简介'))
        TabContent(){
          if (this.isShowPage) {
            // VideoComments({ videoViewModel: this.videoViewModel, bvid: this.bvid })
          }
        }.tabBar(this.TabBuilders(1,'评论'))
      } .barMode(BarMode.Fixed)
    }
    .width('100%')
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
}

@Styles function  pressedStyles() {
  .backgroundColor($r('app.color.bilibili_background_grey'))
}

@Styles function  normalStyles() {
  .backgroundColor($r('app.color.bilibili_background_white'))
}