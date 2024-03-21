import { PlayStatus } from '../common/PlayStatus'
import { Utils } from '../Utils/Utils'
import VideoModel from '../viewModel/VideoModel'
import { VideoViewModel } from '../viewModel/VideoViewModel'
import { Loading } from './LoadingComponent'
import router from '@ohos.router'


@Component
export struct VideoPlay {
  xComponentController: XComponentController = new XComponentController()
  @ObjectLink videoModel: VideoModel
  @Link videoViewModel: VideoViewModel
  @State defaultAspectRatio: number = 16 / 9
  @State videoAspectRatio: number = 16 / 9
  @Link @Watch('initPlay') url: string
  @State @Watch('initPlay') context: object = undefined
  @State isShow :boolean = true
  aboutToAppear() {
    // = this.videoViewModel.viewModel
  }
  sliderShowTime :number = 0
  sliderShowHide(){
    if (this.isShow){
      this.videoModel
      this.sliderShowTime = setTimeout(()=>{
        this.isShow = false
      },3000)
    }else{
      this.isShow = false
      clearTimeout(this.sliderShowTime)
    }
  }



  // 等到有url和context完毕时开始初始化
  initPlay() {
    if (this.url !== '') {
      this.videoViewModel.setUrl(this.url)
      //this.videoViewModel.setHeader(this.header)
      this.videoViewModel.init(this.context)
    }
  }

  build() {
    Column() {
      this.VideoPlayer()
      this.VideoSlider()

      Button('reset').onClick(() => {
        this.videoViewModel.reset()
      })
      Button('start').onClick(() => {
        this.videoViewModel.play()
      })
      Button('pause').onClick(() => {
        this.videoViewModel.pause()
      })
      Button('stop').onClick(() => {
        this.videoViewModel.stop()
      })
      Button('release').onClick(() => {
        this.videoViewModel.release()
      })

      Button('state').onClick(() => {
        Utils.Toast("当前状态：" + this.videoModel.state)
       this.videoViewModel.changeOrientation();
      })
    }.width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder VideoPlayer(){
    Stack() {
      Stack({alignContent:Alignment.TopStart}){
        Stack({ alignContent: Alignment.Bottom }){
          Row() {
            XComponent({
              id: "xcomponentId",
              type: 'surface',
              libraryname: "ijkplayer_napi",
              controller: this.xComponentController
            })
              .onLoad((context) => {
                this.context = context

              })
              .onDestroy(() => {
                this.videoViewModel.release()
              })
              .width('100%')
              .height('100%')
              .aspectRatio(this.videoModel.videoAspectRatio)
          }.justifyContent(FlexAlign.Center)
          if (this.isShow){
            Row(){
              this.VideoSlider()
              Image($r('app.media.ic_full_screen'))
                .onClick(()=>{
                  this.videoViewModel.changeOrientation()
                })  .objectFit(ImageFit.Contain)
                .height('100%')
                .aspectRatio(1)
                .margin(8)
            }.width('100%')
            .aspectRatio(16)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .linearGradient({
              colors: [["#00000000", 0.0], ["#aa000000", 1.0]]
            })
          }
        }.width('100%')
        if (this.isShow){
          Row(){
            Image($r('app.media.ic_common_back_white')).onClick(()=>{
              router.back()
            }).btnImageStyle()

            Image($r('app.media.biliplayer_ic_topbar_back')).onClick(()=>{
              router.replaceUrl({
                url: 'pages/Index' // 目标url
              }, router.RouterMode.Single)
            }).btnImageStyle()

          }.width('100%')
          .aspectRatio(16)
          .linearGradient({
            colors: [["#aa000000", 0.0],["#00000000", 1.0]]
          })
          .height('100%')
        }

      }
      .width('100%')
      .height('100%')

      if (this.videoModel.state<=PlayStatus.LOADING){
        Loading()
      }
    }.alignContent(Alignment.Center)
    .width('100%')
    .aspectRatio(this.defaultAspectRatio)
    .backgroundColor(Color.Black)
    .onClick(()=>{
      this.isShow =!this.isShow
    })
  }

  @Builder
  VideoSlider() {
    Row() {
      Image(this.videoModel.state === PlayStatus.PLAY ? $r('app.media.ic_detail_video_pause') : $r('app.media.ic_detail_video_play'))
        .height('50%')
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          if (this.videoModel.state < PlayStatus.PAUSE) {
            this.videoViewModel.pause()
          } else if (this.videoModel.state < PlayStatus.STOP) {
            this.videoViewModel.play()
          }
        })
        .margin(4)
        Slider({
          value: this.videoModel.sliderStep,
          style: SliderStyle.OutSet,
          direction: Axis.Horizontal
        })
          .blockColor('#ED6A96')
          .trackColor('#80000000')
           .selectedColor("#ED6A96")
        .showTips(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          // value/100 是百分比  getDuration获取的是总时长
          this.videoViewModel.moveProgress(value)
        })
        .width('70%')
        .opacity(1)

      Text(this.videoModel.currentTime + "/" + this.videoModel.timeTotal)
        .fontSize(12)
        .maxLines(1)
        .margin(4)
        .fontColor(Color.White)
    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
  }
}

@Extend(Image)
function btnImageStyle(){
  .objectFit(ImageFit.Contain)
  .height('50%')
  .aspectRatio(1)
  .margin(16)
}

