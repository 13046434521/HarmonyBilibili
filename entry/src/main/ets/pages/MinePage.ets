import axios from '@ohos/axios';
import { LoginNavBean } from '../bean/login/LoginNavBean';
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean';
import Constants from '../common/Constants';
import StorageManager from '../common/StorageManager';
import ApiLogin from '../net/ApiLogin';
import { Utils } from '../Utils/Utils';
import router from '@ohos.router';
import { LoginUserCardBean } from '../bean/login/LoginUserInfoBean';
import { UserStateBean } from '../bean/login/UserStateBean';

@Preview
@Component
  // 主界面中的我的页面

export struct MinePage {
  @StorageLink('isLogin') isLogin :boolean = false
  aboutToAppear() {
  }

  build() {
    if (this.isLogin) {
      MineInfoPage()
    } else {
      LoginPage()
    }
  }
}

@Component
struct MineInfoPage {
  @State loginNavData:LoginNavBean = new LoginNavBean()
  @StorageLink('isLogin') isLogin :boolean = false
  @StorageLink('login_img_url') vipImageUrl :string = ''
  @State loginIcon: string = undefined
  @State dynamic_count: string = "-"
  @State fans: string = "-"
  @State following: string = "-"
  @State bcoin: number = 0
  @State userName: string = "bilibili_user"

  async  aboutToAppear() {
    // 是否登录相关数据
    // 第一次登录时，loginNavData中只有isLogin这一个数据，其他为null，因此需要重新获取
    if (!this.isLogin){
      await ApiLogin.loginNav().then(response=>{
        this.loginNavData = response
        this.vipImageUrl = response.vip.label.img_label_uri_hans_static
        this.bcoin = response.wallet.bcoin_balance
        this.loginIcon = this.loginNavData.face
      })
    }

    await ApiLogin.getUserState().then(response=>{
      Utils.Toast(response+"")
      if (response!==undefined) {
        this.dynamic_count = response.dynamic_count.toString()
        this.fans = response.follower.toString()
        this.following = response.following.toString()
      }

      // return ApiLogin.loginUserInfo(430281002)
    }).catch((err)=>{
      Utils.Toast(err+"---Mine页面")
    })

    this.userName = this.loginNavData.uname
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_mine_daynight_night'))
          .height('50%')
          .aspectRatio(1)
          .margin('2%')
      }.rowItemStyle()
      .justifyContent(FlexAlign.End)
      .height('6%')

      Row() {
        Image(this.loginIcon)
          .height('100%')
          .aspectRatio(1)
          .alt($r('app.media.ic_default_avatar'))
          .borderRadius(100)
          .margin("2%")

        Column(){
          Row(){
            Text(this.userName)
              .fontSize(18)
              .fontColor(this.loginNavData.vip_nickname_color)
              .height('100%')
          }.height('40%')
          Image(this.vipImageUrl)
            .height('30%')
          Row(){
            Text(`B币：${this.bcoin}`)
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(14)
              .maxLines(1)
              .margin({right:'2%'})
              .textAlign(TextAlign.Start)
            Text(`硬币：${this.loginNavData.money}`)
              .fontColor($r('app.color.bilibili_text_grey_light'))
              .fontSize(14)
              .maxLines(1)
              .margin({left:'2%'})
              .textAlign(TextAlign.Start)
          }.height('40%')
        }.alignItems(HorizontalAlign.Start)
      }
      .rowItemStyle()


      Row(){
        ItemContent({state:this.dynamic_count,content:"动态"})
        Divider()
          .dividerStyle()
        ItemContent({state:this.following,content:"关注"})
        Divider()
          .dividerStyle()
        ItemContent({state:this.fans,content:"粉丝"})
      }.rowItemStyle()
      Row(){
        this.ImageItemComponent($r('app.media.ic_mine_offline'),"离线缓存")
        this.ImageItemComponent($r('app.media.ic_mine_history'),"历史纪录")
        this.ImageItemComponent($r('app.media.ic_mine_favorite'),"我的收藏")
        this.ImageItemComponent($r('app.media.ic_mine_watchlater'),"稍后再看")
      }.rowItemStyle()
    }.width('100%') 
    .height('100%')
  }

  @Builder
  ImageItemComponent(res:Resource,content:string){
    Column(){
      Blank().layoutWeight(2)
      Image(res)
        .objectFit(ImageFit.Cover)
        .interpolation(ImageInterpolation.High)
        .height("40%")
        .aspectRatio(1)
      Text(content)
        .fontColor($r('app.color.bilibili_text_black_light'))
        .fontSize(14)
        .height('40%')
        .maxLines(1)
        .textAlign(TextAlign.Center)
      Blank().layoutWeight(2)
    }.alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .columnStyle()
    .onClick(()=>{
      Utils.Toast(content+"功能未完成")
    })
  }
}

@Extend(Divider)
function dividerStyle(){
  .strokeWidth(2)
    .vertical(true)
    .height("30%")
    .color($r('app.color.bilibili_divider'))
}

@Extend(Column)
function columnStyle(){
  .height('100%')
  .layoutWeight(1)
}
@Extend(Row)
function rowItemStyle(){
  .alignItems(VerticalAlign.Center)
  .height('8%')
  .width('100%')
  .margin({top:'1%'})
}

@Component
struct ItemContent{
  @Prop state:string
  @Prop content:string
  build(){
    Column(){
      Blank().layoutWeight(2)
      Text(this.state)
        .fontColor($r('app.color.bilibili_text_black_middle'))
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .maxLines(1)
        .height('40%')
      Text(this.content)
        .fontColor($r('app.color.bilibili_text_grey_light'))
        .fontSize(14)
        .maxLines(1)
        .height('30%')
      Blank().layoutWeight(2)
    }.alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .columnStyle()
  }
}


@Component
struct LoginPage {
  @State url: string = undefined
  @State qrcode_key: string = ''
  @State responseUrl: string = ''
  @State loginStatus: number = -1
  @State message: string = '登录即可体验完整功能'
  @StorageLink('isLogin') isLogin:boolean = false
  build() {
    Column() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.End)
      }.height('40%')
      .justifyContent(FlexAlign.End)

      Column() {
        Button('二维码登录')
          .width('60%')
          .backgroundColor($r('app.color.bilibili_theme'))
          .onClick(() => {
            this.generateQrcode()
          })
      }.height('10%')
      .justifyContent(FlexAlign.End)

      Column() {
        Button('获取当前cookie')
          .width('60%')
          .backgroundColor($r('app.color.bilibili_theme'))
          .onClick(() => {
            this.message = StorageManager.getCookie()
          })
      }.height('10%')
      .justifyContent(FlexAlign.End)

      if (this.url != undefined) {
        Column() {
          QRCode(this.url)
            .height('100%')
            .aspectRatio(1)
        }.height('10%')
        .margin('10%')
        .justifyContent(FlexAlign.Center)
      }
      Blank().layoutWeight(1)
    }.width('100%')
    .height('100%')
    .margin({ top: 5 })
    .justifyContent(FlexAlign.Start)
  }

  generateQrcode() {
    ApiLogin.generateQrcode().then((item: QrcodeGenerateBean) => {
      this.url = item.url
      return this.qrcode_key = item.qrcode_key
    }).then((qrcode: string) => {
      this.login(qrcode)
    }).catch((err) => {
      Utils.Toast("二维码登录：生成二维码" + err)
    })
  }

  login(qrcode_key: string) {
    let interval: number
    interval = setInterval(() => {
      if (this.loginStatus == -1) {
        ApiLogin.loginQrcode(qrcode_key).then((item) => {
          this.responseUrl = item.url
          this.message = '请扫描二维码登录:' + item.message
          console.log("二维码登录：url  " + item.url)
          console.log("二维码登录：refresh_token   " + item.refresh_token)
          console.log("二维码登录：code  " + item.code)
          console.log("二维码登录：timestamp  " + item.timestamp)
          console.log("二维码登录：message  " + item.message)
          if (item.code === 0) {
            this.loginStatus = 1
            let temp = Utils.CookieDeal(item.url) //不能删，这行需要稍微处理一下，才能用
            StorageManager.loginCookie(temp)
            this.isLogin = true

            clearInterval(interval)
            Utils.Toast('二维码登录：登录二维码成功')
            console.log("二维码登录成功:" + StorageManager.getCookie())
          }
        }).catch((err) => {
          console.log("二维码登录：登录二维码" + err)
          this.loginStatus = -1
        })
      }
    }, 1000)
  }
}