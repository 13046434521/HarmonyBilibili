import { Utils } from '../Utils/Utils'
import { VideoViewModel } from '../viewModel/VideoViewModel'


@Component
export struct VideoPlay {
  xComponentController:XComponentController = new XComponentController()
  videoViewModel: VideoViewModel = new VideoViewModel()
  header:Map<string,string>= new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Referer", "https://www.bilibili.com"]
  ])
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
      var builder = 'Header的值：';
      if (this.header) {
        this.header.forEach((value, key) => {
          var parm = key.trim() + ": ";
          if (value)
            parm += value.trim();
          parm += "\r\n";
          builder += parm;
        });
      }
      Utils.Toast(builder)
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
          this.videoViewModel.release()
        }).width('100%')
          .height('100%')

        this.VideoSlider()

      }
      .width('100%')
      .aspectRatio(this.videoViewModel.getVideoAspectRatio())
      .backgroundColor(Color.Black)
      Button('start').onClick(() => {
        this.videoViewModel.play()
      })
      Button('pause').onClick(() => {
        this.videoViewModel.pause()
      })

      Button('release').onClick(() => {
        this.videoViewModel.release()
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
