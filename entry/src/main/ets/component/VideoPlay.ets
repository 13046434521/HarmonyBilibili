import { IjkPlayer } from '../common/IjkPlayer'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { VideoViewModel } from '../viewModel/VideoViewModel'
import { Utils } from '../Utils/Utils'
import util from '@ohos.util'

@Component
export struct VideoPlay {
  xComponentController:XComponentController = new XComponentController()
  videoViewModel: VideoViewModel = new VideoViewModel()
  @Link header:Map<string,string>
  @State title:string=''

  @Link @Watch('initPlay') url:string
  @State @Watch('initPlay') context:object = undefined

  aboutToAppear(){
    this.videoViewModel.setUrl(this.url)
    this.videoViewModel.setHeader(this.header)
  }

  // 等到有url和context完毕时开始初始化
  initPlay(){
    if (this.url!=='') {
      this.videoViewModel.setUrl(this.url)
      this.videoViewModel.setHeader(this.header)
      this.videoViewModel.init(this.context)
    }
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        XComponent({
          id: "xcomponentId",
          type:'surface',
          libraryname: "ijkplayer_napi",
          controller: this.xComponentController
        }).onLoad((context) => {
          this.context = context

        }).onDestroy(() => {
          this.videoViewModel.destroy()
        }).width('100%')
          .height('100%')

        this.VideoSlider()

      }
      .width('100%')
      .aspectRatio(this.videoViewModel.getVideoAspectRatio())

      Button('start').onClick(() => {
        IjkPlayer.getInstance().start()
      })
      Button('pause').onClick(() => {
        IjkPlayer.getInstance().pause()
      })

      Button('release').onClick(() => {
        IjkPlayer.getInstance().release()
      })
    }.width('100%')
    .height('100%')
  }

  @Builder
  VideoSlider(){
    Row() {
      Image(this.videoViewModel.getPlayStateImg())
        .width('8%')
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          this.videoViewModel.play()
        })
        .margin(12)
      Slider({
        value: 40,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal
      })
        .blockColor(Color.White)
        .trackColor(Color.Grey)
        .selectedColor(Color.Pink)
        .showTips(true)
        .onChange((value: number, mode: SliderChangeMode) => {
          // value/100 是百分比  getDuration获取的是总时长
          this.videoViewModel.moveProgress(value)
        })
        .width('50%')
        .opacity(0.5)
      Text(this.videoViewModel.getTimeContent())
        .fontSize(8)
        .maxLines(1)
        .margin(8)
        .fontColor(Color.White)
    }.justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor("#4F4F4F")
    .height('32')
  }
}
