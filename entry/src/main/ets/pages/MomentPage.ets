import { Loading } from '../component/LoadingComponent'

@Component
export struct MomentPage {
  @State message: string = '动态'
@State isloading:boolean = false
  build() {
    Row() {
      Column() {
        if (!this.isloading){
          Loading().layoutWeight(1).height(200).width(200)
        }
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            this.isloading= !this.isloading
          })
          .height(100)

      }
      .width('100%')
    }
    .height('100%')
  }
}