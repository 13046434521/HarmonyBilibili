
@Component
export struct Failure{
  @Prop msg:string = "加载失败....."
  @Prop extra:string =''

  aboutToAppear(){
    console.log("加载失败页面刷新  "+this.extra)
  }

  aboutToDisappear(){
    console.log("加载失败页面销毁  "+this.extra)
  }
  build(){
    Text(this.msg+'\n'+this.extra)
      .width('100%')
      .height('100%')
      .align(Alignment.Center)
  }
}