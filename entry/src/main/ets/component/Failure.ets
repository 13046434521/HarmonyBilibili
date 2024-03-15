
@Component
export struct Failure{
  @Prop msg:string = "加载失败....."
  @Prop extra:string = ''
  build(){
    Text(this.msg+'\n'+this.extra)
      .width('100%')
      .height('100%')
      .align(Alignment.Center)
  }
}