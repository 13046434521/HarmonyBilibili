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

      Promise.all(  [ApiBiliUser.getUserAccInfo(this.mid),ApiBiliUser.loginUserInfo(this.mid)])
        .then((value)=>{
          value[0].mid
          value[1].card.mid
          this.accInfo = value[0]
          this.userInfo =  value[1]
        })
/*    ApiBiliUser.getUserAccInfo(this.mid)
      .then(accInfo=>{
        this.accInfo = accInfo
        return ApiBiliUser.loginUserInfo(this.mid)
      }).then(userInfo=>{
        this.userInfo =userInfo


    })*/

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
        .interpolation(ImageInterpolation.High)


      Stack(){
        // 头像
        Stack(){
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
        if (Utils.isNonNull(this.accInfo.pendant)){
          Image(this.accInfo.pendant.image)
            .objectFit(ImageFit.Contain)
            .aspectRatio(1)
            .borderRadius(100)
            .width('100%')
            .height('100%')
        }

        // 右下角的vip年会员图标
        if (Utils.isNonNull(this.accInfo.vip) && this.accInfo.vip.type === 2){
          Stack(){
            Image(this.accInfo.vip.avatar_subscript_url!==""?this.accInfo.vip.avatar_subscript_url:($r('app.media.ic_mine_vip_section_v2_logo')))
              .position({y:`${50+50/Math.sqrt(2)-12.5}%`,x:`${50+50/Math.sqrt(2)-12.5}%`})
              .width('25%')
              .height('25%')
              .alt($r('app.media.ic_default_avatar'))
              .borderColor(Color.White)
              .borderWidth(1)
              .borderRadius(100)
          }.width('65%')
          .height('65%')


        }
      }.position({y:'30%',x:'5%'})
      .height('32.5%')
      .aspectRatio(1)

      Row(){
        ContentTitle({title: this.userInfo.card.fans,content:'粉丝'})
        Divider()
          .height('20%')
          .vertical(true)
          .width("2%")
          .color($r('app.color.bilibili_divider'))
        ContentTitle({title:this.userInfo.card.friend,content:'关注'})
        Divider()
          .height('20%')
          .vertical(true)
          .width("2%")
          .color($r('app.color.bilibili_divider'))
        ContentTitle({title:this.userInfo.like_num,content:'获赞'})
      }.position({x:'25%',y:'45%'})
      .width('75%')
      .height('17.5%')

    Column(){
      Column(){
        Row(){
          Text(this.accInfo.name)
            .margin({left:'2%'})
            .fontSize(24)
            .fontColor(this.accInfo.vip!=undefined?this.accInfo.vip.nickname_color:$r('app.color.bilibili_text_black_middle'))
          // 等级
          Image(userLevel(this.accInfo.level))
            .height('20%')
            .objectFit(ImageFit.Cover)
            .margin({left:'2%'})

          // 大会员
          if (Utils.isNonNull(this.accInfo.vip)&&Utils.isNonNull(this.accInfo.vip.type)){
            Image(this.accInfo.vip.label.img_label_uri_hans_static)
              .height('40%')
              .objectFit(ImageFit.Cover)
              .margin({left:'2%'})
          }

          if (Utils.isNonNull(this.accInfo.nameplate)){
            Image(this.accInfo.nameplate.image)
              .height('40%')
              .objectFit(ImageFit.Cover)
              .margin({left:'2%'})
          }

        }.justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .layoutWeight(2)

        // 签名 sign
        if (Utils.isNonNull(this.accInfo.sign)){
          Text(this.accInfo.sign)
            .fontSize(14)
            .margin({left:'2%'})
            .fontColor($r('app.color.bilibili_text_grey_light'))
            .layoutWeight(1)
        }

        Row(){
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
          Text(this.accInfo.mid+'')
            .margin({left:'1%'})
            .fontSize(12)
            .fontColor($r('app.color.bilibili_text_grey_light'))

          // 学校
          if (Utils.isNonNull(this.accInfo.school) && Utils.isNonNull(this.accInfo.school.name)){
            Image($r('app.media.ic_vc_school'))
              .width('2%')
              .aspectRatio(1)
              .margin({left:'2%'})

            Text(this.accInfo.school.name)
              .margin({left:'1%'})
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.bilibili_text_grey_light'))
          }

          //男女
          Text("性别："+this.accInfo.sex)
            .margin({left:'1%'})
            .fontColor($r('app.color.bilibili_text_grey_light'))
            .fontSize(12)

          // 生日
          if (Utils.isNonNull(this.accInfo.birthday)){
            Text("生日："+this.accInfo.birthday)
              .margin({left:'2%'})
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(12)
          }
        }
        .layoutWeight(1)
        .margin({left:'2%'})
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        // 签名 为空时，放一个Blank来称布局
        if (!Utils.isNonNull(this.accInfo.sign)){
          Blank().layoutWeight(1)
        }
      }
      .width('100%')
      .height('65%')
      .alignItems(HorizontalAlign.Start)

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
    }.position({x:'0%',y:'65%'})
      .width('100%')
    .height('35%')
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
  }
}

@Component
struct ContentTitle{
  @Prop title:number = -1
  @Prop content:string = ''
  build(){
    Column(){
      Text(userFans(this.title))
        .fontColor($r('app.color.bilibili_text_black_light'))
        .fontSize(20)
        .margin({bottom:'2%'})

      Text(this.content)
        .fontColor($r('app.color.bilibili_text_grey_light'))
        .fontSize(14)
    }.layoutWeight(1)
    .justifyContent(FlexAlign.Center).height('100%')
  }

  @Styles
  testBorder(){
  /*  .borderColor(Color.Orange)
    .borderWidth(1)*/
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
