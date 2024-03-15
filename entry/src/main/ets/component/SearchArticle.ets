import HomeBean from '../bean/HomeBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { LoadingData } from './LoadingData'

@Component
export struct SearchArticleDetails {
  @State message: string = '图文'

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