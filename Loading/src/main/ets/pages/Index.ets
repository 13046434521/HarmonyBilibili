import { Loading } from './Loading'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private offContext: OffscreenCanvasRenderingContext2D = new OffscreenCanvasRenderingContext2D(600, 600, this.settings)

  build() {
    Row() {
      Column() {
        Loading()
      }
    }
  }

  @Builder test(){
    Canvas(this.context)
      .backgroundColor('#ffff00')
      .onReady(() =>{
        this.offContext.arc(100, 75, 50, 0, 6.28)
        // this.offContext.setLineDash([10,20])
        this.offContext.lineDashOffset = 10.0
        this.offContext.stroke()
        var image = this.offContext.transferToImageBitmap()
        this.context.transferFromImageBitmap(image)
      }).borderRadius(10000)
      .width('100%')
      .aspectRatio(1)
  }
}