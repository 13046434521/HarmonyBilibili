import { AccInfo } from '../../bean/biliUser/AccInfo';
import { UserInfoBean } from '../../bean/biliUser/UserInfoBean';
import Constants from '../../common/Constants';
import { Utils } from '../../Utils/Utils'
import { BiliUserViewModel } from '../../viewModel/biliUser/BiliUserViewModel';
import { UserBangumi } from '../../bean/biliUser/UserBangumi'
import { UserBookmark } from '../../bean/biliUser/UserBookmark'
import { UserCoinVideo } from '../../bean/biliUser/UserCoinVideo'
import { UserCollection } from '../../bean/biliUser/UserCollection'
import { UserDynamic } from '../../bean/biliUser/UserDynamic'
import { UserUpvote } from '../../bean/biliUser/UserUpvote'
import { UserVideoBean } from '../../bean/biliUser/UserVideoBean'

@Preview
@Component
export struct NewPage {
  biliUserViewModel : BiliUserViewModel = new BiliUserViewModel()
  @State accInfo: AccInfo = new AccInfo()
  @State userInfo: UserInfoBean = new UserInfoBean()
  @State userVideoBean: UserVideoBean = new UserVideoBean()
  @State userBookmark: UserBookmark = new UserBookmark()
  @State userBangumi: UserBangumi = new UserBangumi()
  @State userCoinVideos: UserCoinVideo[] = []
  @State userUpvote: UserUpvote = new UserUpvote()
  @State userDynamic: UserDynamic = new UserDynamic()
  @State userCollection: UserCollection = new UserCollection()
  aboutToAppear() {
      let mid = 11474631
  }

  build() {
    Column() {
      Image($r("app.media.ic_video_coin"))
        .objectFit(ImageFit.Contain)
        .layoutWeight(1)
        .margin({bottom:'2%'})
        .fillColor(Color.Orange)
      Text('测试')
        .fontSize(25)
        .onClick(()=>{
         let isHasData =(false||true)
          Utils.Toast("false||true:"+isHasData)
        })
      Text('测试')
        .fontSize('25fp')
        .onClick(()=>{
          let isHasData =(false||false)
          Utils.Toast("false||false:"+isHasData)
        })
      Text('测试')
        .fontSize('25vp')
        .onClick(()=>{
          let isHasData =(true||true)
          Utils.Toast("true||true:"+isHasData)
        })
      Text('测试')
        .fontSize('25lpx')

      Text('测试')
        .fontSize('25px')

      Text('测试')
        .fontSize('25pp')
    }
  }
}