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
          src: $r('app.media.phone_common_pull_loading_1')
        }, {
          src: $r('app.media.phone_common_pull_loading_2')
        }, {
          src: $r('app.media.phone_common_pull_loading_3')
        }, {
          src: $r('app.media.phone_common_pull_loading_4')
        },
        ]).iterations(-1)
          .duration(2000)
          .width('25%')
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