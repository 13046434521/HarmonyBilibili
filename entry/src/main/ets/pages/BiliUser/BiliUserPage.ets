import router from '@ohos.router'
import { PageManager, RouterConstants } from '../../common/PageManager'
import ApiBiliUser from '../../net/ApiBiliUser'

@Entry
@Component
struct BiliUserPage {
  @State message: string = 'BiliUserPage'

  @State mid :number =0
  aboutToAppear(){
    this.mid = router.getParams()[RouterConstants.MID]
    ApiBiliUser.getUserDetail(this.mid)
  }
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}