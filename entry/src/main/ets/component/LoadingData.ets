import { LoadingStatus } from '../common/LoadingStatus'
import { Failure } from './Failure'
import { Loading } from './LoadingComponent'
import { NoData } from './NoData'

@Component
export struct LoadingData{
  @BuilderParam page:()=>void
  @Link loadingStatus :LoadingStatus
  @Prop extraFailure:string =''
  extraSuccess:string =''

  build(){
    Column(){
      if (this.loadingStatus === LoadingStatus.Loading){
        Loading({extra:this.extraSuccess})
          .width('50%').aspectRatio(1)
      }else if (this.loadingStatus === LoadingStatus.LoadingSuccess){
        this.page()
      }else if (this.loadingStatus === LoadingStatus.LoadingFailure){
        Failure({extra:this.extraFailure})
          .width('50%').aspectRatio(1)
      }else{
        NoData()
          .width('50%').aspectRatio(1)
      }
    }.justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
    // .borderWidth(2)
    // .borderColor(Color.Orange)
  }
}