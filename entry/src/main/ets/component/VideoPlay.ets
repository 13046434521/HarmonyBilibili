import { PlayStatus } from '../common/PlayStatus'
import VideoModel from '../viewModel/VideoModel'
import { VideoViewModel } from '../viewModel/VideoViewModel'
import { Loading } from './Loading'
import router from '@ohos.router'
import Constants from '../common/Constants'
import { Utils } from '../Utils/Utils'
import hilog from '@ohos.hilog'
import window from '@ohos.window'
import { VolumeBrightness, VolumeBrightStatus } from './VolumeBrightness'

@Component
export struct VideoPlay {
  @Link videoViewModel: VideoViewModel
  @Prop @Watch('initPlay') url: string
  @State @Watch('initPlay') context: object = undefined

  aboutToAppear() {
    this.videoViewModel.getVolume().then(volume=>{
      this.videoViewModel.videoModel.volume = volume
      return this.videoViewModel.getBright()
    }).then(bright=>{
      this.videoViewModel.videoModel.brightness = bright
      Utils.Toast("亮度："+ bright +"  声音："+this.videoViewModel.videoModel.volume)
      console.log('app_log:VideoPlay:创建了：亮度：'+ bright +"  声音："+this.videoViewModel.videoModel.volume)
    })
}

  aboutToDisappear() {
    console.log('app_log:VideoPlay:销毁了')
    this.videoViewModel.release('页面销毁')
  }

  // 等到有url和context完毕时开始初始化
  initPlay() {
    console.log('app_log:initPlay:' + this.url + this.context)
    if (this.videoViewModel.getPlayState() === PlayStatus.INIT && this.url !== '' && this.context !== undefined) {
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
  @State videoAspectRatio: number = Constants.DEFAULT_ASPECT_RATIO
  @Link videoViewModel: VideoViewModel
  @ObjectLink videoModel: VideoModel
  mOnPlayerCompleteListener: (context: object) => void
  @State isShow: boolean = true

  @State isVolumeBrightShow: boolean = false
  @State volumeBrightStatus: VolumeBrightStatus = VolumeBrightStatus.VOLUME
  @State volumeBrightValue: number = 0
  @State isFullScreen:number = Constants.DEFAULT_ASPECT_RATIO
  aboutToAppear() {
  }
  lastPosition = 0
  build() {
    Stack() {
      Column() {
        this.XComponentPlayer()
      }.alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')

      Column() {
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
          .linearGradient({
            colors: [["#aa000000", 0.0], ["#00000000", 1.0]]
          })
        }

        Row() {
          Blank("亮度")
            .layoutWeight(1)
            .gesture(GestureGroup(GestureMode.Exclusive,
              PanGesture({direction:PanDirection.Vertical})
                .onActionStart((event?:GestureEvent)=>{
                  // 向上为负，向下为正，以当前点为起始点
                  this.volumeBrightStatus = VolumeBrightStatus.BRIGHTNESS
                  this.volumeBrightValue = this.videoModel.brightness * 100
                  this.isVolumeBrightShow = true
                  console.log('Gesture:onActionStart:'+ event.offsetY)
                })
                .onActionUpdate((event?:GestureEvent)=>{
                  // 向上为负，向下为正，以onActionUpdate的值为起始点，返回的都是当前点和起始点的差值
                  let temp = this.videoViewModel.videoModel.brightness - event.offsetY / 100
                  this.videoViewModel.adjustBrightness(temp)
                  this.volumeBrightValue = temp * 100
                  console.log('Gesture:onActionUpdate:'+ event.offsetY)
                }).onActionEnd((event?:GestureEvent)=>{

                this.videoViewModel.getBright().then(brightness=>{
                  this.videoModel.brightness = brightness
                  this.videoModel.volume = brightness
                  this.isVolumeBrightShow = false
                })

                console.log('Gesture:onActionEnd:'+ event.offsetY)
              })
            ))
          Stack({alignContent:Alignment.Center}) {
            if (this.videoModel.state <= PlayStatus.LOADING) {
              Loading()
            }
            if (this.isVolumeBrightShow){
              VolumeBrightness({value:this.volumeBrightValue,volumeBrightStatus:this.volumeBrightStatus})
                .height(60)
                .width(60)
            }
          }.layoutWeight(1)
          .width('100%')


          Blank('声音')
            .layoutWeight(1)

            .gesture(GestureGroup(GestureMode.Exclusive,
              PanGesture({direction:PanDirection.Vertical})
                .onActionStart((event?:GestureEvent)=>{
                  // 向上为负，向下为正，以当前点为起始点
                  // 向上为负，向下为正，以当前点为起始点
                  this.volumeBrightStatus = VolumeBrightStatus.VOLUME
                  this.volumeBrightValue = this.videoModel.volume / 15 * 100
                  this.isVolumeBrightShow = true
                  console.log('Gesture:onActionStart:'+ event.offsetY)
                })
                .onActionUpdate((event?:GestureEvent)=>{
                  // 向上为负，向下为正，以onActionUpdate的值为起始点，返回的都是当前点和起始点的差值
                  let temp = this.videoViewModel.videoModel.volume - event.offsetY * 15 /100
                  this.videoViewModel.adjustVolume(temp)
                  this.volumeBrightValue = temp * 100 /15
                  console.log('Gesture:onActionUpdate:'+ event.offsetY)
                }).onActionEnd((event?:GestureEvent)=>{
                this.videoViewModel.getVolume().then(volume=>{
                  this.videoModel.volume = volume
                  this.isVolumeBrightShow = false
                })
                console.log('Gesture:onActionEnd:'+ event.offsetY)
              })
            ))
        }.height('100%')
        .layoutWeight(1)

        if (this.isShow) {
          Row() {
            this.VideoSlider()
          }
          .width('100%')
          .aspectRatio(16)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .linearGradient({
            colors: [["#00000000", 0.0], ["#aa000000", 1.0]]
          })
        }else{
          Row(){
            Row()
              .width(`${this.videoModel.sliderStep}%`)
              .backgroundColor($r('app.color.bilibili_theme'))
              .height('100%')
          }.justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Bottom)
            .width('100%')
            .height('0.5%')
            .backgroundColor($r('app.color.bilibili_text_grey_light'))
/*          Slider({
            value: this.videoModel.sliderStep,
            style: SliderStyle.OutSet,
            direction: Axis.Horizontal
          })
            .blockColor($r('app.color.bilibili_theme'))
            .trackColor($r('app.color.bilibili_text_grey_light'))
            .selectedColor($r('app.color.bilibili_theme'))
            .showTips(false)
            .width('100%')
            .height('2%')*/
        }
      }.width('100%')
      .height('100%')
    }
    .alignContent(Alignment.BottomStart)
    .width('100%')
    .height('100%')
    .aspectRatio(undefined)
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
        .blockColor($r('app.color.bilibili_theme'))
        .trackColor($r('app.color.bilibili_text_grey_light'))
        .selectedColor($r('app.color.bilibili_theme'))
        .showTips(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          // value/100 是百分比  getDuration获取的是总时长
          // 移动结束时，设置moveProgress
          if (mode == SliderChangeMode.Moving) {
            this.videoViewModel.pause()
            this.videoModel.state = PlayStatus.LOADING
          }
          else if (mode == SliderChangeMode.End) {
            this.videoModel.sliderStep = value
            this.videoViewModel.moveProgress(value)
          }
        })
        .layoutWeight(1)
        .opacity(1)

      Text(this.videoModel.currentTime + "/" + this.videoModel.timeTotal)
        .fontSize(12)
        .maxLines(1)
        .margin(4)
        .fontColor(Color.White)

      Image($r('app.media.ic_full_screen'))
        .onClick(() => {
          this.videoViewModel.changeOrientation()
          if (this.videoModel.orientation===window.Orientation.LANDSCAPE) {
            this.isFullScreen = undefined
          }else{
            this.isFullScreen = this.videoModel.defaultAspectRatio
          }
        })
        .objectFit(ImageFit.Cover)
        .height('100%')
        .aspectRatio(1)
        .margin(8)
    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
  }

  @Builder
  XComponentPlayer() {
    XComponent({
      id: "xcomponentId",
      type: 'surface',
      libraryname: "ijkplayer_napi",
    })
      .onLoad((context) => {
        this.mOnPlayerCompleteListener(context)
      })
      .onDestroy(() => {
        this.videoViewModel.release('XComponent:onDestroy')
      })
      .width(this.videoModel.xComponentWidth)
      .height(this.videoModel.xComponentHeight)
      .aspectRatio(this.videoModel.videoAspectRatio)
  }

  @Styles
  gestureBrightness(){
    .gesture(GestureGroup(GestureMode.Exclusive,
      PanGesture({direction:PanDirection.Vertical})
        .onActionStart((event?:GestureEvent)=>{
          // 向上为负，向下为正，以当前点为起始点
          event.offsetY
          console.log('Gesture:onActionStart:'+ event.offsetY)
        })
        .onActionUpdate((event?:GestureEvent)=>{
          // 向上为负，向下为正，以onActionUpdate的值为起始点，返回的都是当前点和起始点的差值
          let temp = this.videoViewModel.videoModel.volume -event.offsetY/15
          this.videoViewModel.adjustVolume(temp)
          console.log('Gesture:onActionUpdate:'+ event.offsetY)
        }).onActionEnd((event?:GestureEvent)=>{
        this.videoViewModel.getVolume().then(volume=>{
          this.videoModel.volume = volume
        })
        console.log('Gesture:onActionEnd:'+ event.offsetY)
      })
    ))
  }
}