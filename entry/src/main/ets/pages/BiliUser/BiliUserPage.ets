import router from '@ohos.router'
import { PageManager, RouterConstants } from '../../common/PageManager'
import ApiBiliUser from '../../net/ApiBiliUser'
import { Utils } from '../../Utils/Utils'
import radio from '@ohos.telephony.radio'
import { AccInfo } from '../../bean/biliUser/AccInfo'
import { UserInfoBean } from '../../bean/biliUser/UserInfoBean'

@Entry
@Component
struct BiliUserPage {
  @State message: string = 'BiliUserPage'
  @State mid: number = 0
  @State scrollStatus: ScrollStatus = ScrollStatus.SCROLL_MOVE; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  @State msg: string = ''
  private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
  private scrollerForScroll: Scroller = new Scroller()
  private scrollerForList: Scroller = new Scroller()
  @State accInfo:AccInfo = new AccInfo()
  @State userInfo:UserInfoBean = new UserInfoBean()
  aboutToAppear() {
    if (router.getParams()!==undefined) {
      this.mid = router.getParams()[RouterConstants.MID]
    // this.mid = 68406011
  /*    Promise.all(  [ApiBiliUser.getUserAccInfo(this.mid),ApiBiliUser.loginUserInfo(this.mid)])
        .then((value)=>{
          value[0].mid
          value[1].card.mid
          this.accInfo = value[0]
          this.userInfo =  value[1]
          console.error('Promise.all:', value[0].mid + '---'+   value[1].card.mid)
        })*/
    ApiBiliUser.getUserAccInfo(this.mid)
      .then(accInfo=>{
        this.accInfo = accInfo
        return ApiBiliUser.loginUserInfo(this.mid)
      }).then(userInfo=>{
        this.userInfo =userInfo

      Utils.Toast(this.userInfo.card.fans.toString())
    })
    }
  }

  build() {
    Scroll(this.scrollerForScroll) {
      Column() {
        this.title()

        List({ space: 20, scroller: this.scrollerForList }) {
          ForEach(this.arr, (item) => {
            ListItem() {
              Text(this.msg + "  item:" + item)
                .width("100%")
                .height("100%")
                .borderRadius(15)
                .fontSize(16)
                .textAlign(TextAlign.Center)
                .backgroundColor(Color.White)
            }.width("100%").height(100)
          }, item => item)
        }
        .width("100%")
        .height('100%')
        .edgeEffect(EdgeEffect.Fade)
        .onReachStart(()=>{
          this.scrollStatus = ScrollStatus.SCROLL_MOVE
        })
        .onScrollFrameBegin((offset: number, state: ScrollState) => {
          // offset 向上为正数。向下为负数
          if ((this.scrollStatus === ScrollStatus.SCROLL_MOVE)) {
            // 这里是外层Scroll滚动的逻辑
            this.scrollerForScroll.scrollBy(0, offset)
            return { offsetRemain: 0 }
          }

          this.scrollStatus = ScrollStatus.LIST_MOVE
          return { offsetRemain: offset };
        })
      }
    }
    .width("100%").height("100%")
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  title() {
    Column() {
      Image(this.accInfo.top_photo)
        .height('45%')
        .width('100%')
        .objectFit(ImageFit.Cover)

      Image(this.accInfo.face)
        .position({y:'42.5%',x:'5%'})
        .height('15%')
        .aspectRatio(1)
        .alt($r('app.media.ic_default_avatar'))
        .borderColor(Color.White)
        .borderWidth(1)
        .borderRadius(100)

      Row(){
        this.contentTitleItem(this.userInfo.card.fans.toString(),'粉丝')
        Text(this.userInfo.card.fans.toString()+'1粉丝')
        Divider()
          .height('20%')
          .vertical(true)
          .width("2%")
          .color($r('app.color.bilibili_divider'))
        this.contentTitleItem(this.userInfo.follower.toString(),'关注')
        Divider()
          .height('20%')
          .vertical(true)
          .width("2%")
          .color($r('app.color.bilibili_divider'))
        this.contentTitleItem(this.userInfo.like_num.toString(),'获赞')
      }.position({x:'25%',y:'45%'})
      .width('75%')
      .height('12.5%')
      .borderColor(Color.Orange)
      .borderWidth(1)
    Column(){
      Column(){
        Row(){
          Text(this.accInfo.name)
          // 等级
          Image('')
          // 大会员
          Image('')
          //牌子
          Image('')
        }
        Text(this.accInfo.sign)
        Row(){
          // 学校
          Image('')
          Text("this.accInfo.school.name")

          // ip属地
          Image('')
          Text('ip属地')

          // up
          Image($r('app.media.ic_playlist_up_label'))
            .width('2%')
            .aspectRatio(1)
          Text('up')
        }
      }
      .width('100%')
      .height('65%')
      .borderWidth(2)
      .borderColor(Color.Yellow)
      Tabs({}) {
        TabContent()
          .tabBar('主页')
        TabContent()
          .tabBar('动态')
        TabContent()
          .tabBar('投稿')
        TabContent()
          .tabBar('收藏')
        TabContent()
          .tabBar('追番')
      }
      .width('100%')
      .height('35%')
    }.position({x:'0%',y:'60%'})
      .width('100%')
    .height('40%')

    .borderWidth(2)
    .borderColor(Color.Gray)
      .alignItems(HorizontalAlign.Start)

    }
    .height('40%')
    .width("100%")
    .onVisibleAreaChange([0.0, 1.0], (isVisible: boolean, currentRatio: number) => {
      console.error('currentRatio:'+currentRatio+'  isVisible:'+isVisible)
      if (currentRatio === 0) {
        this.scrollStatus = ScrollStatus.LIST_MOVE
      } else {
        this.scrollStatus = ScrollStatus.SCROLL_MOVE
      }
      this.msg = "onVisibleAreaChange:" + isVisible + "  " + currentRatio
    })
    .borderWidth(2)
    .borderColor(Color.Orange)
  }
  @Builder
  contentTitleItem(title:string,content:string){
    Column(){
      Text(title)
      Text(content)
    }.layoutWeight(1)
    .justifyContent(FlexAlign.Center).height('100%')
  }
}

// 主页，动态，投稿，收藏，追番，
enum ScrollStatus {
  SCROLL_MOVE,
  LIST_MOVE
}