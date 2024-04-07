@Preview
@Component
export struct Loading {
  @State state :AnimationStatus = AnimationStatus.Initial
  extra:string =''
  type:LoadingType = LoadingType.DATA
  loadingOption :LoadingOption


  aboutToAppear(){
    this.loadingOption = this.type===LoadingType.DATA?new DataLoadingOption():new PageLoadingOption()
    this.state = AnimationStatus.Running
    console.log("加载ing页面刷新   "+this.extra)
  }


  aboutToDisappear(){
    this.state = AnimationStatus.Stopped
    console.log("加载ing页面销毁   "+this.extra)
  }
  build() {
    Column(){
      ImageAnimator().images(this.loadingOption.value).iterations(-1)
        .duration(1000)
        .width('50%')
        .aspectRatio(1)
        .state(this.state)
      Text(this.loadingOption.content)
        .width('100%')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.bilibili_text_grey_light'))
    }.width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

export class LoadingOption{
  value: ImageFrameInfo[]
  content:string

  constructor(value: ImageFrameInfo[],content:string) {
    this.content =content
    this.value = value
  }
}

export class DataLoadingOption extends LoadingOption{
  constructor() {
    super([{
      src: $r('app.media.mall_asyn_loading_anim_img01')
    }, {
      src: $r('app.media.mall_asyn_loading_anim_img02')
    }, {
      src: $r('app.media.mall_asyn_loading_anim_img03')
    }, {
      src: $r('app.media.mall_asyn_loading_anim_img04')
    },
    ],'正在加载数据...')
  }
}

export class PageLoadingOption extends LoadingOption{
  constructor() {
    super([{
      src: $r('app.media.ic_laoding_anim_01')
    }, {
      src: $r('app.media.ic_laoding_anim_02')
    }, {
      src: $r('app.media.ic_laoding_anim_03')
    }],'拼命加载中...')
  }
}

export enum LoadingType{
  DATA,
  PAGE
}