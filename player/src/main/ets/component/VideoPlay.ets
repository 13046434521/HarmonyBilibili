import { IjkPlayer } from '../common/IjkPlayer'
import { VideoViewModel } from '../VideoViewModel'
import router from '@ohos.router'

@Component
export struct VideoPlay {
  xComponentController:XComponentController = new XComponentController()
  videoViewModel: VideoViewModel = new VideoViewModel()

  aboutToAppear() {
    let url = router.getParams()['url']
    this.videoViewModel.setUrl(url)
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        XComponent({
          id: "ijkplayer",
          type:'surface',
          libraryname: "ijkplayer_napi",
          controller: this.xComponentController
        }).onLoad((context) => {
          // 初始化
          this.videoViewModel.init(context)
          this.videoViewModel.initListener.bind(this)()

        }).onDestroy(() => {

        }).width('100%')


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
      .width('100%')
      .aspectRatio(this.videoViewModel.getVideoAspectRatio())


      Button('async').onClick(() => {
        IjkPlayer.getInstance().prepareAsync()

      })
      Button('start').onClick(() => {
        IjkPlayer.getInstance().start()
      })
      Button('pause').onClick(() => {
        IjkPlayer.getInstance().pause()
      })
      Button('height,width').onClick(() => {

      })

      Button('release').onClick(() => {
        IjkPlayer.getInstance().release()
      })
    }.width('100%')
    .height('100%')
  }
}
