@Component
export struct SwipeRefreshLayout{
  TAG:string = 'SwipeRefreshLayout'
  @BuilderParam childLayout:()=>{}
  @State progressY:number = 0
  progressX = '47.5%'
  progressWidth = '5%'
  maxHeight = 150
  loadingHeight = 100
  loadingState = 0//0默认状态,1正在加载,2可以加载
  refresh:()=>void = undefined
  lastProgressY = 0
  @State angle:number = 0

  build(){
    Stack(){
      Column(){
        this.childLayout()
      }.width('100%')
      .height('100%')

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
        if (this.loadingState!==0){
          return
        }
        if (event.offsetY>=this.maxHeight) {
          this.progressY =  this.lastProgressY + this.maxHeight
          this.loadingState = 2
          return
        }
        this.progressY =  this.lastProgressY + event.offsetY
        this.progressY = this.progressY<0?0:this.progressY
        if (this.progressY>0) {
          this.angle += event.offsetY * 5
        }
      })

      .onActionEnd(event=>{
        console.warn(this.TAG,'onActionEnd:'+event.offsetX+"  "+event.offsetY)

        if (this.loadingState<2){
          animateTo({duration:1000,curve:Curve.EaseOut},()=>{
            this.progressY = 0
            this.lastProgressY = this.progressY
            this.angle = 0
            this.loadingState = 0
          })
          return
        }
        let time = setInterval(()=>{
          this.angle += 25
        },16)

        if (this.refresh!==undefined) {
          this.loadingState = 1
          this.refresh()
          console.warn(this.TAG,'刷新完毕:'+event.offsetX+"  "+event.offsetY)
        }

        clearInterval(time)

        animateTo({duration:1500,curve:Curve.EaseOut},()=>{
          this.progressY = 0
          this.lastProgressY = this.progressY
          this.angle = 0
          this.loadingState = 0
        })
      })
      .onActionCancel(()=>{
        console.warn(this.TAG,'onActionCancel')
      })).width('100%')
    .height('100%')
    .borderWidth(2)
    .borderColor(Color.Orange)
  }
}

class SwipeRefreshController {
  onRefresh:()=>void
  onLoading:()=>void
}

class SwipeRefreshAttribute extends  SwipeRefreshController{

}


