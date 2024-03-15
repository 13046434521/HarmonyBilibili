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
        Button("loading")
          .onClick(()=>{
            this.loadingStatus = LoadingStatus.Loading
          })
        Button("loadingFailure")
          .onClick(()=>{
            this.loadingStatus = LoadingStatus.LoadingFailure
          })
        Button("loadingSuccess")
          .onClick(()=>{
            this.loadingStatus = LoadingStatus.LoadingSuccess
          })
        LoadingData({loadingStatus:this.loadingStatus,page:this.loading})
          .layoutWeight(1)
      }
      .width('100%')
    }
    .height('100%')
  }

  @Builder loading(){
    Image($r('app.media.test')).height(100).width(100)
  }
}