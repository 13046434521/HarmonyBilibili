@Preview
@Component
export struct Loading {
  @State state :AnimationStatus = AnimationStatus.Initial
  extra:string =''
  aboutToAppear(){
    this.state = AnimationStatus.Running
    console.log("加载ing页面刷新   "+this.extra)
  }


  aboutToDisappear(){
    this.state = AnimationStatus.Stopped
    console.log("加载ing页面销毁   "+this.extra)
  }
  build() {
    Column(){
      Column(){
        ImageAnimator().images([{
          src: $r('app.media.mall_asyn_loading_anim_img01')
        }, {
          src: $r('app.media.mall_asyn_loading_anim_img02')
        }, {
          src: $r('app.media.mall_asyn_loading_anim_img03')
        }, {
          src: $r('app.media.mall_asyn_loading_anim_img04')
        },
        ]).iterations(-1)
          .duration(1000)
          .width('15%')
          .aspectRatio(1)
          .state(this.state)
        Text('加载中...')
          .fontSize(16)
      }
    }.width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}