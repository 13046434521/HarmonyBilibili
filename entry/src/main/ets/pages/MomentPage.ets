import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { LoadingData } from '../component/LoadingData'

@Component
// 动态页面
export struct MomentPage {
  @State message: string = '动态'
@State loadingStatus:LoadingStatus = LoadingStatus.Loading
  build() {
    Row() {
      Column() {
        LoadingData({loadingStatus:this.loadingStatus,page:this.loading})
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            // this.isloading= !this.isloading
          })
          .height(100)

      }
      .width('100%')
    }
    .height('100%')
  }

  @Builder loading(){
    Loading().layoutWeight(1).height(200).width(200)
  }
}