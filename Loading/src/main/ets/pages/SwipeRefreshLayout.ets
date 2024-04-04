@Component
export struct SwipeRefreshLayout{
  @BuilderParam childLayout:()=>{}
  TAG:string = 'SwipeRefreshLayout'
  controller:SwipeRefreshController= new SwipeRefreshController()
  progressX = '47.5%'
  @State progressY:number  = 0
  progressWidth = '5%'
  maxImage = 100
  refresh:()=>void = undefined
  lastProgressY = 0
  @State angle:number = 0
  onMeasure(){

  }

  build(){
    Stack(){
      this.childLayout()
      Image($r('app.media.ic_succeed_refresh'))
        .width(this.progressWidth)
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .position({x:this.progressX,y:this.progressY})
        .rotate({angle:this.angle})
        .borderWidth(2)
        .borderColor(Color.Orange)
    }.gesture(PanGesture({fingers:1,direction:PanDirection.Vertical})
      .onActionStart(event=>{
      })
      .onActionUpdate(event=>{
        console.warn(this.TAG,'onActionUpdate:'+event.offsetX+"  "+event.offsetY)
        if (event.offsetY>this.maxImage) {
          this.progressY =  this.lastProgressY + this.maxImage

          return
        }
        this.angle += event.offsetY * 5
        this.progressY =  this.lastProgressY + event.offsetY
      })

      .onActionEnd(event=>{
        console.warn(this.TAG,'onActionEnd:'+event.offsetX+"  "+event.offsetY)

        let time = setInterval(()=>{
          this.angle += 25
        },16)

        if (this.refresh!==undefined) {
          this.refresh()
          console.warn(this.TAG,'刷新完毕:'+event.offsetX+"  "+event.offsetY)
        }

        clearInterval(time)
        this.progressY = 0
        this.lastProgressY = this.progressY
        this.angle = 0
      })
      .onActionCancel(()=>{
        console.warn(this.TAG,'onActionCancel')
      })).width('100%')
    .height('100%')
  }
}

class SwipeRefreshController {
  onRefresh:()=>void
  onLoading:()=>void
}

class SwipeRefreshAttribute extends  SwipeRefreshController{

}


