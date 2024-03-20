import { IjkPlayer } from '../common/IjkPlayer'
import { VideoViewModel } from '../VideoViewModel'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

@Component
export struct VideoPlay {
  xComponentController:XComponentController = new XComponentController()
  videoViewModel: VideoViewModel = new VideoViewModel()
  @Link @Watch('upDate') url:string
  @Link @Watch('upDate') header:Map<string,string>
  @State context:object =null
  @State title:string=''

  aboutToAppear(){
    this.upDate()
  }


  upDate(){
    this.title = this.url
    this.videoViewModel.setUrl(this.url)
    this.videoViewModel.setHeader(this.header)
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
          this.context = context
          this.title = "ok了"
          promptAction.showToast({message:this.url.toString()})
        }).onDestroy(() => {

        }).width('100%')
          .height('100%')

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

      Button( this.title).onClick(() => {
        // 初始化
        this.videoViewModel.initListener()
        this.videoViewModel.init(this.context)
        // IjkPlayer.getInstance().prepareAsync()
      })
      Button('start').onClick(() => {

        promptAction.showToast({message:'---------'+this.videoViewModel.viewModel.url})

        IjkPlayer.getInstance().start()
      })
      Button('pause').onClick(() => {

        promptAction.showToast({message:'---------'+this.videoViewModel.getUrl()})

        IjkPlayer.getInstance().pause()
      })
      Button('height,width').onClick(() => {
        promptAction.showToast({message:'---------'+this.url})
        this.videoViewModel.setUrl(this.url)
      })

      Button('release').onClick(() => {
        IjkPlayer.getInstance().release()
      })
    }.width('100%')
    .height('100%')
  }
}
