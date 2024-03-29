import { LoadingStatus } from '../common/LoadingStatus'
import { Loading } from '../component/LoadingComponent'
import { VolumeBrightness } from '../component/VolumeBrightness'
import { Utils } from '../Utils/Utils'

@Component
// 动态页面
@Preview
export struct MomentPage {
  @State message: string = '动态'
  @StorageLink('isLogin') isLogin:boolean = false
  build(){
    Column(){
      Button().onClick(()=>{
        this.isLogin=true
      })

      Text(this.isLogin ?"true":"false")
    }
  }
}