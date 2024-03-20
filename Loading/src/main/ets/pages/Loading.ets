
@Component
export struct  Loading{
  @State test:string="测试"
  @State x:number=-10
  @State y:number=-10
   imgHeight :number = 40
  @State imgCurrentHeight :number = this.imgHeight
  lastY = 0
  build(){
    Column(){
      Row(){
        Image($r('app.media.ic_succeed_refresh'))
          .width(40)
          .aspectRatio(1)
      }.width('100%')
      .height(this.imgCurrentHeight)
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.Center)
      .borderWidth(2)
      .borderColor(Color.Blue)
      // .position({y:-40})
      .offset({y:-40})
      Text(this.test)
    }.onTouch((event)=>{
      let  target:TouchObject = event.touches[0]
      this.x = target.screenX
      this.y = target.screenY

      if (target.type==0){
        this.lastY = target.screenY
      }
      if (target.type == 2) {
        this.imgCurrentHeight = (target.screenY - this.lastY)*0.2 +this.imgCurrentHeight
      }
      if (target.type==1) {
        this.imgCurrentHeight = this.imgHeight
        this.lastY = 0
      }
      this.test =target.type.toString()+"     "+ this.lastY + '    '+this.imgCurrentHeight+"     " +this.x
    }).width('100%')
    .height('100%')
    .borderWidth(2)
    .borderColor(Color.Orange)
  }
}