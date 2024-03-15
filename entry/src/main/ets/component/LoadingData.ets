import { LoadingStatus } from '../common/LoadingStatus'
import { Failure } from './Failure'
import { Loading } from './LoadingComponent'

@Component
export struct LoadingData{
  @BuilderParam page:()=>void
  @Prop loadingStatus :LoadingStatus
  build(){
    Column(){
      if (this.loadingStatus === LoadingStatus.Loading){
        Loading()
      }else if (this.loadingStatus === LoadingStatus.LoadingSuccess){
        this.page()
      }else{
        Failure()
      }
    }
  }
}