import { PlayStatus } from '../common/PlayStatus'
import VideoModel from '../viewModel/VideoModel'
import { VideoViewModel } from '../viewModel/VideoViewModel'
import { Loading } from './LoadingComponent'
import router from '@ohos.router'
import Constants from '../common/Constants'

@Component
export struct VideoPlay {
  @Link videoViewModel: VideoViewModel
  @Link @Watch('initPlay') url: string
  @State @Watch('initPlay') context: object = undefined

  aboutToDisappear() {
    this.videoViewModel.release()
  }

  // 等到有url和context完毕时开始初始化
  initPlay() {
    if (this.url !== '' && this.context!==undefined) {
      this.videoViewModel.setUrl(this.url)
      this.videoViewModel.init(this.context)
    }
  }

  build() {
    VideoPlayer({
      videoModel: this.videoViewModel.videoModel,
      videoViewModel: this.videoViewModel,
      mOnPlayerCompleteListener: (context: object) => {
        this.context = context
      }
    }).width('100%')
  }
}

@Extend(Image)
function btnImageStyle() {
  .objectFit(ImageFit.Contain)
  .height('50%')
  .aspectRatio(1)
  .margin(16)
}

@Component
struct VideoPlayer {
  @State defaultAspectRatio: number = Constants.DEFAULT_ASPECT_RATIO
  @State videoAspectRatio: number = Constants.DEFAULT_ASPECT_RATIO
  @State isShow: boolean = true
  @Link videoViewModel: VideoViewModel
  @ObjectLink videoModel: VideoModel
  mOnPlayerCompleteListener: (context: object) => void

  aboutToAppear() {
    //设置buffer缓冲回调监听
    this.videoModel.mOnBufferingUpdateListener = {
      onBufferingUpdate: (percent: number) => {
        console.log('app_log mOnBufferingUpdateListener:percent:' + percent)
      }
    }

    //	设置快进后退回调监听
    this.videoModel.mOnSeekCompleteListener = {
      onSeekComplete: () => {
        // this.videoModel.state = PlayStatus.PLAY
        this.videoViewModel.play()
        console.log('app_log onSeekComplete:percent')
      }
    }
  }

  build() {
    Stack() {
      Column() {
        this.XComponentPlayer()
      }.alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')

      if (this.isShow) {
        Row() {
          this.VideoSlider()
          Image($r('app.media.ic_full_screen'))
            .onClick(() => {
              this.videoViewModel.changeOrientation()
            })
            .objectFit(ImageFit.Contain)
            .height('100%')
            .aspectRatio(1)
            .margin(8)
        }
        .width('100%')
        .aspectRatio(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .linearGradient({
          colors: [["#00000000", 0.0], ["#aa000000", 1.0]]
        })
      }

      if (this.videoModel.state <= PlayStatus.LOADING) {
        Loading()
      }

      if (this.isShow) {
        Row() {
          Image($r('app.media.ic_common_back_white')).onClick(() => {
            router.back()
          }).btnImageStyle()

          Image($r('app.media.biliplayer_ic_topbar_back')).onClick(() => {
            router.replaceUrl({
              url: 'pages/Index' // 目标url
            }, router.RouterMode.Single)
          }).btnImageStyle()

        }.width('100%')
        .aspectRatio(16)
        .position({ x: 0, y: 0 })
        .linearGradient({
          colors: [["#aa000000", 0.0], ["#00000000", 1.0]]
        })
      }
    }
    .alignContent(Alignment.BottomStart)
    .width('100%')
    .aspectRatio(this.defaultAspectRatio)
    .backgroundColor(Color.Black)
    .onClick(() => {
      this.isShow = !this.isShow
    }).width('100%')
    .height('100%')
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
          } else if (this.videoModel.state === PlayStatus.STOP) {
            this.videoViewModel.reset()
          }
        })
        .margin(4)
      Slider({
        value: this.videoModel.sliderStep,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal
      })
        .blockColor('#ED6A96')
        .trackColor(Color.Grey)
        .selectedColor("#ED6A96")
        .showTips(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          // value/100 是百分比  getDuration获取的是总时长
          // 移动结束时，设置moveProgress
          if (mode == SliderChangeMode.End) {
            this.videoViewModel.pause()
            this.videoViewModel.moveProgress(value)
          }
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

  @Builder
  XComponentPlayer() {
    if (this.videoModel.videoAspectRatio > 0) {
      XComponent({
        id: "xcomponentId",
        type: 'surface',
        libraryname: "ijkplayer_napi",
      })
        .onLoad((context) => {
          this.mOnPlayerCompleteListener(context)
        })
        .onDestroy(() => {
          this.videoViewModel.release()
        }).width('100%')
        .aspectRatio(this.videoModel.videoAspectRatio)
    } else {
      XComponent({
        id: "xcomponentId",
        type: 'surface',
        libraryname: "ijkplayer_napi",
      })
        .onLoad((context) => {
          this.mOnPlayerCompleteListener(context)
        })
        .onDestroy(() => {
          this.videoViewModel.release()
        }).height('100%')
        .aspectRatio(this.videoModel.videoAspectRatio)
    }
  }
}


