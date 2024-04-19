import { PlayStatus } from '../../common/PlayStatus'
import VideoModel from '../../viewModel/videoPlayer/VideoModel'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import { Loading } from '../Loading'
import router from '@ohos.router'
import Constants from '../../common/Constants'
import { Utils } from '../../Utils/Utils'
import window from '@ohos.window'
import { VolumeBrightnessProgress, VolumeBrightStatus } from './VolumeBrightnessProgress'
import { PageManager } from '../../common/PageManager'
import { toast } from '../../Utils/ToastUtils'
import { showDialog } from '../../Utils/DialogUtil'

@Component
export struct LivePlay {
  videoController: VideoController
  @Prop @Watch('initPlay') url: string
  @State @Watch('initPlay') context: object = undefined

  aboutToAppear() {
    this.videoController.getVolume().then(volume=>{
      this.videoController.videoModel.volume = volume
      return this.videoController.getBright()
    }).then(bright=>{
      this.videoController.videoModel.brightness = bright
      Utils.Toast("亮度："+ bright +"  声音："+this.videoController.videoModel.volume)
      console.log('app_log:VideoPlay:创建了：亮度：'+ bright +"  声音："+this.videoController.videoModel.volume)
    })
  }

  aboutToDisappear() {
    console.log('app_log:VideoPlay:销毁了')
    this.videoController.release('页面销毁')
  }

  // 等到有url和context完毕时开始初始化
  initPlay() {
    console.log('app_log:initPlay:' + this.url + this.context)
    if (this.videoController.getPlayState() === PlayStatus.INIT && this.url !== '' && this.context !== undefined) {
      this.videoController.setUrl(this.url)
      this.videoController.init(this.context)
    }
  }

  build() {
    VideoPlayer({
      videoModel: this.videoController.videoModel,
      videoController: this.videoController,
      mOnPlayerCompleteListener: (context: object) => {
        this.context = context
      }
    }).width('100%')
  }
}

@Component
struct VideoPlayer {
  @State videoAspectRatio: number = Constants.DEFAULT_ASPECT_RATIO
  @State isShow: boolean = true
  @State isVolumeBrightShow: boolean = false
  @State volumeBrightStatus: VolumeBrightStatus = VolumeBrightStatus.VOLUME
  @State volumeBrightValue: number = 0
  @ObjectLink videoModel: VideoModel
  videoController: VideoController
  mOnPlayerCompleteListener: (context: object) => void

  build() {
    Stack() {
      // 视频数据显示界面
      Column() {
        this.XComponentPlayer()
      }.alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')

      // 配件界面（各种ui以及进度条等....）
      if (this.videoController.isShowAttachments){
        Column() {
          Row() {
            Image($r('app.media.ic_common_back_white')).onClick(() => {
              if (this.videoModel.orientation === window.Orientation.LANDSCAPE){
                this.videoController.changeOrientation()

              }else{
                router.back()
              }
            }).btnImageStyle()

            Image($r('app.media.ic_tab_bar_home')).onClick(() => {
              this.changePortrait()
              PageManager.routerIndex()
            }).btnImageStyle()
              .fillColor($r('app.color.bilibili_background_white'))

            Image($r('app.media.icon_replay')).onClick(() => {
              this.videoController.reset()
            }).btnImageStyle()

          }.width('100%')
          .aspectRatio(16)
          .linearGradient({
            colors: [["#aa000000", 0.0], ["#00000000", 1.0]]
          })
          .visibility(this.isShow ? Visibility.Visible : Visibility.None)

          // 音量，亮度控制界面
          Row() {
            Blank("亮度")
              .layoutWeight(1)
              .gesture(GestureGroup(GestureMode.Exclusive,
                PanGesture({ direction: PanDirection.Vertical })
                  .onActionStart((event?: GestureEvent) => {
                    // 向上为负，向下为正，以当前点为起始点
                    this.volumeBrightStatus = VolumeBrightStatus.BRIGHTNESS
                    this.volumeBrightValue = this.videoModel.brightness * 100
                    this.isVolumeBrightShow = true
                    console.log('Gesture:onActionStart:' + event.offsetY)
                  })
                  .onActionUpdate((event?: GestureEvent) => {
                    // 向上为负，向下为正，以onActionUpdate的值为起始点，返回的都是当前点和起始点的差值
                    let temp = this.videoController.videoModel.brightness - event.offsetY / 100
                    this.videoController.adjustBrightness(temp)
                    this.volumeBrightValue = temp * 100
                    console.log('Gesture:onActionUpdate:' + event.offsetY)
                  }).onActionEnd((event?: GestureEvent) => {

                  this.videoController.getBright().then(brightness => {
                    this.videoModel.brightness = brightness
                    this.videoModel.volume = brightness
                    this.isVolumeBrightShow = false
                  })

                  console.log('Gesture:onActionEnd:' + event.offsetY)
                })
              ))
            Stack({ alignContent: Alignment.Center }) {
              if (this.videoModel.state <= PlayStatus.LOADING) {
                Loading()
              }
              if (this.isVolumeBrightShow) {
                VolumeBrightnessProgress({
                  value: this.volumeBrightValue,
                  volumeBrightStatus: this.volumeBrightStatus
                })
                  .height(60)
                  .width(60)
              }
            }.layoutWeight(1)
            .width('100%')


            Blank('声音')
              .layoutWeight(1)
              .gesture(GestureGroup(GestureMode.Exclusive,
                PanGesture({ direction: PanDirection.Vertical })
                  .onActionStart((event?: GestureEvent) => {
                    // 向上为负，向下为正，以当前点为起始点
                    // 向上为负，向下为正，以当前点为起始点
                    this.volumeBrightStatus = VolumeBrightStatus.VOLUME
                    this.volumeBrightValue = this.videoModel.volume / 15 * 100
                    this.isVolumeBrightShow = true
                    console.log('Gesture:onActionStart:' + event.offsetY)
                  })
                  .onActionUpdate((event?: GestureEvent) => {
                    // 向上为负，向下为正，以onActionUpdate的值为起始点，返回的都是当前点和起始点的差值
                    let temp = this.videoController.videoModel.volume - event.offsetY * 15 / 100
                    this.videoController.adjustVolume(temp)
                    this.volumeBrightValue = temp * 100 / 15
                    console.log('Gesture:onActionUpdate:' + event.offsetY)
                  }).onActionEnd((event?: GestureEvent) => {
                  this.videoController.getVolume().then(volume => {
                    this.videoModel.volume = volume
                    this.isVolumeBrightShow = false
                  })
                  console.log('Gesture:onActionEnd:' + event.offsetY)
                })
              ))
          }.height('100%')
          .layoutWeight(1)

          Row() {
            this.VideoSlider()

            Image($r('app.media.ic_full_screen'))
              .objectFit(ImageFit.Cover)
              .height('100%')
              .aspectRatio(1)
              .margin({right:4})
              .onClick(() => {
                this.videoController.changeOrientation()
              })
          }
          .width('100%')
          .aspectRatio(16)
          .justifyContent(FlexAlign.End)
          .alignItems(VerticalAlign.Center)
          .linearGradient({
            colors: [["#00000000", 0.0], ["#aa000000", 1.0]]
          })
          .visibility(this.isShow ? Visibility.Visible : Visibility.None)
          .height('10%')


          Row() {
            Row()
              .width(`${this.videoModel.sliderStep}%`)
              .backgroundColor($r('app.color.bilibili_theme'))
              .height('100%')
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Bottom)
          .width('100%')
          .height('0.5%')
          .backgroundColor($r('app.color.bilibili_text_grey_light'))
          .visibility(!this.isShow ? Visibility.Visible : Visibility.None)

        }.width('100%')
        .height('100%')
      }
    }
    .alignContent(Alignment.BottomStart)
    .size({width:'100%',height:'100%'})
    .backgroundColor(Color.Black)
    .onClick(() => {
      this.isShow = !this.isShow
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
            this.videoController.pause()
          } else if (this.videoModel.state < PlayStatus.STOP) {
            this.videoController.play()
          } else if (this.videoModel.state === PlayStatus.STOP) {
            this.videoController.reset()
          }
        })
        .margin(4)
      Slider({
        value: this.videoModel.sliderStep,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal
      })
        .blockColor($r('app.color.bilibili_theme'))
        .trackColor($r('app.color.bilibili_text_grey_light'))
        .selectedColor($r('app.color.bilibili_theme'))
        .showTips(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          // value/100 是百分比  getDuration获取的是总时长
          // 移动结束时，设置moveProgress
          if (mode == SliderChangeMode.Moving) {
            this.videoController.pause()
            this.videoModel.state = PlayStatus.LOADING
          }
          else if (mode == SliderChangeMode.End) {
            this.videoModel.sliderStep = value
            this.videoController.moveProgress(value)
          }
        })
        .layoutWeight(1)
        .opacity(1)

      Text(this.videoModel.currentTime + "/" + this.videoModel.timeTotal)
        .fontSize(12)
        .maxLines(1)
        .margin(4)
        .fontColor(Color.White)
    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
    .layoutWeight(1)
  }

  @Builder
  XComponentPlayer() {
    XComponent({
      id: this.videoController.getXComponentId(),
      type: 'surface',
      libraryname: "ijkplayer_napi",
    }).onLoad((context) => {
      this.mOnPlayerCompleteListener(context)
    })
      .onDestroy(() => {
        this.videoController.release('XComponent:onDestroy')
      })
      .width(this.videoModel.xComponentWidth)
        //该组建用来显示视频只用保持视频的宽高比就行了
      .aspectRatio(this.videoModel.videoAspectRatio)
  }

  changePortrait(){
    if (this.videoModel.orientation === window.Orientation.LANDSCAPE){
      this.videoController.changeOrientation()
    }
  }
}

@Extend(Image)
function btnImageStyle() {
  .objectFit(ImageFit.Contain)
  .height('50%')
  .aspectRatio(1)
  .margin(16)
}
