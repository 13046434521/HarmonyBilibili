import { LoadingStatus } from '../common/LoadingStatus'
import { Failure } from './Failure'
import { Loading } from './LoadingComponent'

@Component
export struct LoadingData{
  @BuilderParam page:()=>void
  @Link loadingStatus :LoadingStatus
  @Prop extraFailure:string =''
  extraSuccess:string =''
  build(){
    Column(){
      if (this.loadingStatus === LoadingStatus.Loading){
        Loading({extra:this.extraSuccess}).layoutWeight(1)
      }else if (this.loadingStatus === LoadingStatus.LoadingSuccess){
        this.page()
      }else{
        Failure({extra:this.extraFailure}).layoutWeight(1)
      }

      // Loading({extra:this.extraSuccess}).visibility(this.loadingStatus === LoadingStatus.Loading?Visibility.Visible:Visibility.Hidden)
      // Failure({extra:this.extraFailure}).visibility(this.loadingStatus === LoadingStatus.LoadingFailure?Visibility.Visible:Visibility.Hidden)
      // if (this.loadingStatus === LoadingStatus.LoadingSuccess){
      //   this.page()
      // }
    }
  }
}