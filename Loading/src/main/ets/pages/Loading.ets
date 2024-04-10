import workScheduler from '@ohos.resourceschedule.workScheduler'
import taskpool from '@ohos.taskpool'
import util from '@ohos.util'

@Component
export struct Loading{
  @State test:string="测试"
  @State x:number=0
  @State y:number=0
  @State angle:number=0
   imgHeight :number = 40
  @State imgCurrentHeight :number = this.imgHeight
  maxOffsetY = 100
  lastY = 0
  @BuilderParam content:()=>{}
  scroll:Scroller
  build(){
    Stack(){
      Scroll(this.scroll){
        this.content()
      }.onScroll((x,y)=>{
        console.error('loading','onScroll:'+x+"   "+y)
      }).onScrollStart(()=>{
        console.error('loading','onScrollStart')
      }).onScrollStop(()=>{
        console.error('loading','onScrollStop')
      }).onScrollFrameBegin((offset,state)=>{
        console.error('loading','onScrollFrameBegin:'+offset+"  "+state.toString())
        return {offsetRemain:offset}
      }).width('100%')
      .height('100%')

      Image($r('app.media.ic_succeed_refresh'))
        .width('5%')
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .position({y:this.y,x:'47.5%'})
        .rotate({angle:this.angle*5})

      // .offset({y:-40})
      Text(this.test)
    }.gesture(PanGesture({fingers:1,direction:PanDirection.Vertical})
      .onActionStart(event=>{
        this.lastY = this.y
        console.warn("loading",'onActionStart:'+event.offsetX+"  "+event.offsetY)
      })
      .onActionUpdate(event=>{
        console.warn("loading",'onActionUpdate:'+event.offsetX+"  "+event.offsetY)
        if (event.offsetY<this.maxOffsetY) {
          this.y=event.offsetY+this.lastY
        }
        this.angle = event.offsetY*10
        this.test = "拉动中："+this.angle
      })

      .onActionEnd(event=>{
        console.warn("loading",'onActionEnd:'+event.offsetX+"  "+event.offsetY)
        new Promise<number>(resolve=>{

          var intervalID = setInterval(function() {
            console.log('do very 1s.');
            this.angle-=100
            this.test = "旋转中："+this.angle
            if (this.angle<=-5000) {
                clearInterval(intervalID)
                resolve(0)
            }
          }.bind(this), 30);
        }).then(()=>{
          this.y=0
          this.lastY = this.y
          this.angle=0
          this.test = "结束了："+this.angle
        }).finally(()=>{

        })
      })
      .onActionCancel(()=>{
        console.warn("loading",'onActionCancel')
      }))
    .onTouch((event)=>{
      let  target:TouchObject = event.touches[0]
      let num:number = this.scroll.currentOffset()+1
      console.warn("loading",'onTouch:scroll:'+num)
      if (num<100) {
        console.warn("loading",'onTouch:'+target.screenX+"  "+target.screenY)
        console.warn("loading",'onTouch:scroll:'+this.scroll.currentOffset())
        return
      }

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
      console.warn("loading",'onTouch:'+target.screenX+"  "+target.screenY)
      this.test =target.type.toString()+"     "+ this.lastY + '    '+this.imgCurrentHeight+"     " +this.x
    })
    .onDragStart((event,params)=>{
      console.warn("loading",'onDragStart:'+event.getX()+"  "+event.getY()+"   "+params)
    })    .onDragEnter((event,params)=>{
      console.warn("loading",'onDragEnter:'+event.getX()+"  "+event.getY()+"   "+params)
    })    .onDragMove((event,params)=>{
      console.warn("loading",'onDragMove:'+event.getX()+"  "+event.getY()+"   "+params)
    })
    .onDragLeave((event,params)=>{
      console.warn("loading",'onDragLeave:'+event.getX()+"  "+event.getY()+"   "+params)
    }).width('100%')
    .height('100%')
    .borderWidth(2)
    .borderColor(Color.Orange)
  }
}
