import router from '@ohos.router'
import { RouterConstants } from '../../common/PageManager'
import { Utils } from '../../Utils/Utils'
import { AccInfo } from '../../bean/biliUser/AccInfo'
import { UserInfoBean } from '../../bean/biliUser/UserInfoBean'
import { BiliUserHome } from './BiliUserHome'
import { UserVideoBean } from '../../bean/biliUser/UserVideoBean'
import { UserBangumi } from '../../bean/biliUser/UserBangumi'
import { UserBookmark } from '../../bean/biliUser/UserBookmark'
import { UserCollection } from '../../bean/biliUser/UserCollection'
import { UserCoinVideo } from '../../bean/biliUser/UserCoinVideo'
import { UserUpvote } from '../../bean/biliUser/UserUpvote'
import { UserDynamic } from '../../bean/biliUser/UserDynamic'
import { BiliUserViewModel } from '../../viewModel/biliUser/BiliUserViewModel'
import { LoadingType } from '../../component/Loading'
import { LoadingData } from '../../component/LoadingData'
import { LoadingStatus } from '../../common/LoadingStatus'
import { BiliUserBangumi } from './BiliUserBangumi'
import { BiliUserVideo } from './BiliUserVideo'
import { BiliUserBookmark } from './BiliUserBookmark'

@Entry
@Component
struct BiliUserPage {
  @State message: string = 'BiliUserPage'
  @State mid: number = 0
  @State scrollStatus: ScrollStatus = ScrollStatus.SCROLL_MOVE; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  private scrollerForScroll: Scroller = new Scroller()
  private tabController:TabsController = new TabsController()

  biliUserViewModel : BiliUserViewModel = new BiliUserViewModel(this.tabController)
  @State accInfo: AccInfo = undefined
  @State userInfo: UserInfoBean =undefined
  @State userVideoBean: UserVideoBean = undefined
  @State userBookmark: UserBookmark = undefined
  @State userBangumi: UserBangumi = undefined
  @State userCoinVideos: UserCoinVideo[] = new Array<UserCoinVideo>()
  @State userUpvote: UserUpvote =undefined
  @State userDynamic: UserDynamic = undefined
  @State userCollection: UserCollection = undefined

  @State loadingStatus :LoadingStatus = LoadingStatus.Loading
  @State err:string = ''

  @State @Watch('showPage')currentIndex:number = 0
  @State isShowPage :boolean[] = [true,false,false,false,false]

  aboutToAppear() {
    if (router.getParams() !== undefined) {
      this.mid = router.getParams()[RouterConstants.MID]
      this.biliUserViewModel.getUserAllData(this.mid)
        .then((value) => {
          this.accInfo = value[0]
          this.userInfo = value[1]
          if (!Utils.isNonNull(this.accInfo)||!Utils.isNonNull(this.userInfo)) {
            Utils.Toast('当前用户个人信息：accInfo:'+this.accInfo+"  userInfo:"+ this.userInfo)
            this.loadingStatus = LoadingStatus.LoadingFailure
            return
          }
          this.userVideoBean = value[2]
          this.userBookmark = value[3]
          this.userBangumi = value[4]
          this.userCoinVideos = value[5]
          this.userUpvote = value[6]
          this.userDynamic = value[7]
          this.userCollection = value[8]
          console.error('BiliUser Page:处理过后的数据:'+"  video:"+this.userVideoBean+"  bookMark:"+this.userBookmark+"   bangumi:"+this.userBangumi)+
            "  coin:"+this.userCoinVideos+"  upvote:"+this.userUpvote+"  dynamic:"+this.userDynamic+"  collection:"+this.userCollection
          this.loadingStatus = LoadingStatus.LoadingSuccess
        }).catch(err=>{
          this.err = err
          this.loadingStatus = LoadingStatus.LoadingFailure
          console.error('BiliUser Page:err:'+ err)

      })
    }
  }

  showPage(){
   this.isShowPage[this.currentIndex] = true
  }

  build() {
    Column(){
      LoadingData({loadingStatus:this.loadingStatus,type:LoadingType.PAGE,page:this.userPage.bind(this),extraFailure:this.err})
    }
  }

  @Builder
  userPage(){
    Scroll(this.scrollerForScroll) {
      Column() {
        this.title()
        Tabs({controller:this.tabController}) {
          // 所有用户都会显示主页数据
          TabContent() {
            if (this.isShowPage[0]){
              BiliUserHome({
                mid: this.mid,
                biliUserViewModel: this.biliUserViewModel,
                userVideoBean: this.userVideoBean,
                userBookmark: this.userBookmark,
                userBangumi: this.userBangumi,
                userCoinVideos: this.userCoinVideos,
                userUpvote: this.userUpvote
              })
            }
          }.tabBar(this.TabBuilders(0,'主页'))
          .onClick(() => {
            this.biliUserViewModel.getUserHomeData(this.mid)
          })

          TabContent() {
            if (this.isShowPage[1]){
              // BiliUser({mid:this.mid})
            }
          }.tabBar(this.TabBuilders(1,'动态'))
          .onClick(()=>{
            this.biliUserViewModel.getUserHomeData(this.mid)
          })
          // 有的用户会隐藏该数据，因此要判空

            TabContent() {
              if (this.isShowPage[2]){
                BiliUserVideo({mid:this.mid,userVideoBean:this.userVideoBean,biliUserViewModel:this.biliUserViewModel})
              }
            }
            .tabBar(this.TabBuilders(2,'投稿'))
            .onClick(()=>{
              this.biliUserViewModel.getUserVideoData(this.mid)
            })

          // 有的用户会隐藏该数据，因此要判空
          TabContent() {
            if (this.isShowPage[3]){
              BiliUserBookmark({mid:this.mid,userBookmark:this.userBookmark,biliUserViewModel:this.biliUserViewModel})
            }
          }
          .tabBar(this.TabBuilders(3,'收藏'))
          .onClick(()=>{
            this.biliUserViewModel.getUserBookmarksData(this.mid)
          })
          // 有的用户会隐藏该数据，因此要判空
          TabContent() {
            if (this.isShowPage[4]){
              BiliUserBangumi({mid:this.mid,userBangumi:this.userBangumi,biliUserViewModel:this.biliUserViewModel})
            }
          }
          .tabBar(this.TabBuilders(4,'追番'))
          .onClick(()=>{
            this.currentIndex = 4
            this.tabController.changeIndex(this.currentIndex)
            this.biliUserViewModel.getUserBangumiData(this.mid)
          })

        }.width('100%')
        .height('100%')
        .onChange((index)=>{
          this.tabController.changeIndex(index)
          this.currentIndex = index
        })
      }
    }
    .width("100%")
    .height("100%")
    .edgeEffect(EdgeEffect.Spring)
}

  @Builder
  title() {
    Column() {
      // top背景
      Image(this.accInfo.top_photo)
        .height('60%')
        .width('100%')
        .objectFit(ImageFit.Cover)
        .interpolation(ImageInterpolation.High)

      // 头像vip，
      Stack() {
        // 头像
        Stack() {
          Image(this.accInfo.face)
            .objectFit(ImageFit.Contain)
            .alt($r('app.media.ic_default_avatar'))
            .borderColor(Color.White)
            .borderWidth(1)
            .borderRadius(100)
            .width('100%')
            .height('100%')
        }.width('65%')
        .height('65%')

        // 头像收藏框
        if (Utils.isNonNull(this.accInfo.pendant)) {
          Image(this.accInfo.pendant.image)
            .objectFit(ImageFit.Contain)
            .aspectRatio(1)
            .borderRadius(100)
            .width('100%')
            .height('100%')
        }

        // 右下角的vip年会员图标
        if (Utils.isNonNull(this.accInfo.vip) && this.accInfo.vip.type === 2) {
          Stack() {
            Image(this.accInfo.vip.avatar_subscript_url !== "" ? this.accInfo.vip.avatar_subscript_url : ($r('app.media.ic_mine_vip_section_v2_logo')))
              .position({
                y: `${50 + 50 / Math.sqrt(2) - 12.5}%`,
                x: `${50 + 50 / Math.sqrt(2) - 12.5}%`
              })
              .width('25%')
              .height('25%')
              .alt($r('app.media.ic_default_avatar'))
              .borderColor(Color.White)
              .borderWidth(1)
              .borderRadius(100)
          }.width('65%')
          .height('65%')

        }
      }.position({ y: '50%', x: '5%' })
      .height('30%')
      .aspectRatio(1)

      // 粉丝关注获赞等
      Row() {
        ContentTitle({ title: this.userInfo.card.fans, content: '粉丝' })

        Divider()
          .height('20%')
          .vertical(true)
          .width("2%")
          .color($r('app.color.bilibili_divider'))
        ContentTitle({ title: this.userInfo.card.friend, content: '关注' })
        Divider()
          .height('20%')
          .vertical(true)
          .width("2%")
          .color($r('app.color.bilibili_divider'))
        ContentTitle({ title: this.userInfo.like_num, content: '获赞' })
      }.position({ x: '25%', y: '60%' })
      .width('75%')
      .height('20%')

      // 名字，等级 年度大会员，荣誉勋章，签名，学校，性别，生日，uip
      Column() {
        // 名字，等级 年度大会员，荣誉勋章
        Row() {
          Text(this.accInfo.name)
            .margin({ left: '2%' })
            .fontSize(24)
            .fontColor(this.accInfo.vip != undefined ? this.accInfo.vip.nickname_color : $r('app.color.bilibili_text_black_middle'))
          // 等级
          Image(userLevel(this.accInfo.level))
            .height('20%')
            .objectFit(ImageFit.Cover)
            .margin({ left: '2%' })

          // 大会员
          if (Utils.isNonNull(this.accInfo.vip) && Utils.isNonNull(this.accInfo.vip.type)) {
            Image(this.accInfo.vip.label.img_label_uri_hans_static)
              .height('40%')
              .objectFit(ImageFit.Cover)
              .margin({ left: '2%' })
          }

          if (Utils.isNonNull(this.accInfo.nameplate)) {
            Image(this.accInfo.nameplate.image)
              .height('40%')
              .objectFit(ImageFit.Cover)
              .margin({ left: '2%' })
          }

        }.justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .layoutWeight(2)

        // 签名 sign
        if (Utils.isNonNull(this.accInfo.sign)) {
          Text(this.accInfo.sign)
            .fontSize(14)
            .margin({ left: '2%' })
            .fontColor($r('app.color.bilibili_text_grey_light'))
            .layoutWeight(1)
        }

        Row() {
          // ip属地
          /*          Image('')
                      .margin({left:'2%'})
                    Text('ip属地:')
                      .margin({left:'1%'})*/

          // uip
          Image($r('app.media.ic_playlist_up_label'))
            .width('2%')
            .aspectRatio(1)
            .aspectRatio(1)
          Text(this.accInfo.mid + '')
            .margin({ left: '1%' })
            .fontSize(12)
            .fontColor($r('app.color.bilibili_text_grey_light'))

          // 学校
          if (Utils.isNonNull(this.accInfo.school) && Utils.isNonNull(this.accInfo.school.name)) {
            Image($r('app.media.ic_vc_school'))
              .width('2%')
              .aspectRatio(1)
              .margin({ left: '2%' })

            Text(this.accInfo.school.name)
              .margin({ left: '1%' })
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.bilibili_text_grey_light'))
          }

          //男女
          Text("性别：" + this.accInfo.sex)
            .margin({ left: '1%' })
            .fontColor($r('app.color.bilibili_text_grey_light'))
            .fontSize(12)

          // 生日
          if (Utils.isNonNull(this.accInfo.birthday)) {
            Text("生日：" + this.accInfo.birthday)
              .margin({ left: '2%' })
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(12)
          }
        }
        .layoutWeight(1)
        .margin({ left: '2%' })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)

        // 签名 为空时，放一个Blank来称布局
        if (!Utils.isNonNull(this.accInfo.sign)) {
          Blank().layoutWeight(1)
        }
      }.position({ x: '0%', y: '80%' })
      .width('100%')
      .height('20%')
      .alignItems(HorizontalAlign.Start)
    }
    .height('40%')
    .width("100%")
    .onVisibleAreaChange([0.0, 1.0], (isVisible: boolean, currentRatio: number) => {
      // console.error('currentRatio:' + currentRatio + '  isVisible:' + isVisible)
      if (currentRatio === 0) {
        this.scrollStatus = ScrollStatus.LIST_MOVE
      } else {
        this.scrollStatus = ScrollStatus.SCROLL_MOVE
      }
    })
  }

  @Builder TabBuilders(index: number, name: string) {
  Column() {
    Text(name)
      .fontColor(this.currentIndex === index ? $r('app.color.bilibili_theme') : $r('app.color.bilibili_text_grey_bold'))
      .fontSize(16)
      .maxLines(1)
      .textAlign(TextAlign.Center)
      .margin({bottom:'4%'})
      .width('40%')
    Divider()
      .strokeWidth(2)
      .color($r('app.color.bilibili_theme'))
      .opacity(this.currentIndex === index  ? 1 : 0)
      .width('30%')
  }.width('100%')
  .height('100%')
  .stateStyles({pressed:pressedStyles,normal:normalStyles})
  .borderRadius(5)
  .justifyContent(FlexAlign.Center)
  .onClick(() => {
    this.currentIndex = index
    this.tabController.changeIndex(this.currentIndex)
  })
}
}

@Component
struct ContentTitle {
  @Prop title: number = 0
  @Prop content: string = ''

  build() {
    Column() {
      Text(userFans(this.title))
        .fontColor($r('app.color.bilibili_text_black_light'))
        .fontSize(20)
        .margin({ bottom: '2%' })

      Text(this.content)
        .fontColor($r('app.color.bilibili_text_grey_light'))
        .fontSize(14)
    }.layoutWeight(1)
    .justifyContent(FlexAlign.Center).height('100%')
  }
}

// 主页，动态，投稿，收藏，追番，
enum ScrollStatus {
  SCROLL_MOVE,
  LIST_MOVE
}


function userFans(fans: number): string {
  let fansRes = fans.toString()
  if (fans >= 10000) {
    fansRes = Math.floor(fans / 10000).toFixed(1) + "万"
  }

  return fansRes
}

function userLevel(level: number): Resource {
  let icon = $r('app.media.ic_im_user_level_0')
  switch (level) {
    case 1: {
      icon = $r('app.media.ic_im_user_level_1')
      break
    }
    case 2: {
      icon = $r('app.media.ic_im_user_level_2')
      break
    }
    case 3: {
      icon = $r('app.media.ic_im_user_level_3')
      break
    }
    case 4: {
      icon = $r('app.media.ic_im_user_level_4')
      break
    }
    case 5: {
      icon = $r('app.media.ic_im_user_level_5')
      break
    }
    case 6: {
      icon = $r('app.media.ic_im_user_level_6')
      break
    }
    default: {
      icon = $r('app.media.ic_im_user_level_0')
      break
    }
  }

  return icon
}

@Styles function  pressedStyles() {
  .backgroundColor($r('app.color.bilibili_background_grey'))
}

@Styles function  normalStyles() {
  .backgroundColor($r('app.color.bilibili_background_white'))
}