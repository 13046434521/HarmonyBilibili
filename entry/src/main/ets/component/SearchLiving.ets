import { LoadingStatus } from '../common/LoadingStatus'
import { LoadingData } from './LoadingData'

@Component
export struct SearchLiving {
  @State message: string = '影视'
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  build() {
    Row() {
      LoadingData({loadingStatus :this.loadingStatus,page:this.biliUserPage})
    }
    .height('100%')
  }

  @Builder biliUserPage(){
    Column().layoutWeight(1)
  }
}