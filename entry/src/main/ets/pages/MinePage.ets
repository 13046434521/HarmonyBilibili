import { LoginNavBean } from '../bean/login/LoginNavBean';
import { QrcodeGenerateBean } from '../bean/login/QrcodeGenerateBean';
import Constants from '../common/Constants';
import StorageManager from '../common/StorageManager';
import ApiLogin from '../net/ApiLogin';
import { Utils } from '../Utils/Utils';
import ApiBiliUser from '../net/ApiBiliUser';
import { PageManager } from '../common/PageManager';
import { MineItem, MineViewModel } from '../viewModel/MineViewModel';
import { SwipeRefreshLayout } from '../../../../../Loading/src/main/ets/pages/SwipeRefreshLayout';

@Preview
@Component
  // 主界面中的我的页面
export struct MinePage {
  @StorageLink('isLogin') isLogin :boolean = false
  @StorageLink('background_color') backgroundColors :string = Constants.BACKGROUND_DAY
  mineViewModel :MineViewModel = new MineViewModel()
  aboutToAppear() {
  }

  build() {
    if (this.isLogin) {
      MineInfoPage({mineViewModel:this.mineViewModel})
        .backgroundColor(this.backgroundColors)
    } else {
      LoginPage()
        .backgroundColor(this.backgroundColors)
    }
  }
}

@Component
struct MineInfoPage {
  @State loginNavData:LoginNavBean = new LoginNavBean()
  @StorageLink('isLogin') isLogin :boolean = false
  @StorageLink('login_img_url') loginIcon :string = ''
  @StorageLink('background_color') backgroundColors :string = Constants.BACKGROUND_DAY
  @StorageLink('day_night') daynight: 'day'|'night' = 'day'
  @State vipImageUrl :string = ''
  @State vipBageUrl: string = undefined
  @State dynamic_count: string = "-"
  @State fans: string = "-"
  @State following: string = "-"
  @State bcoin: number = 0
  @State userName: string = "bilibili_user"
  mid: number = 0
  mineViewModel :MineViewModel = new MineViewModel()

/*
  [RecommendItem{'name':'直播中心','img':$r('app.media.ic_mine_live_center')},{'name':'免流量服务','img':$r('app.media.ic_mine_freedata')},
{'name':'会员购物中心','img':$r('app.media.ic_mine_mall')},{'name':'我的钱包','img':$r('app.media.ic_mine_wallet')}]
*/

aboutToAppear() {
    // 是否登录相关数据
    // 第一次登录时，loginNavData中只有isLogin这一个数据，其他为null，因此需要重新获取

     ApiLogin.loginNav().then(response=>{
      this.loginNavData = response
      this.vipImageUrl = response.vip.label.img_label_uri_hans_static
      this.bcoin = response.wallet.bcoin_balance
      this.loginIcon = this.loginNavData.face
      this.userName = this.loginNavData.uname
       this.mid = response.mid
      return  ApiBiliUser.getUserState()
    }).then(response=>{
       this.dynamic_count = response.dynamic_count.toString()
       this.fans = response.follower.toString()
       this.following = response.following.toString()
      return ApiBiliUser.loginUserInfo(this.mid)
    }).then(response=>{
        this.vipBageUrl = response.card.vip.avatar_icon.icon_resource.url
     }).catch((err)=>{
      Utils.Toast(err+"---Mine页面")
    })
  }

  build() {
    Column() {
      Row() {
        Image(this.daynight==='day'?$r('app.media.ic_mine_daynight_night'):$r('app.media.ic_mine_daynight_day'))
          .height('50%')
          .aspectRatio(1)
          .objectFit(ImageFit.Cover)
          .interpolation(ImageInterpolation.High)
          .margin('2%')
          .onClick(()=>{
            this.daynight = this.daynight ==='day'?'night':'day'
            this.backgroundColors = this.daynight?Constants.BACKGROUND_DAY:Constants.BACKGROUND_NIGHT
          })
      }.rowItemStyle()
      .justifyContent(FlexAlign.End)
      .height('6%')

      Row() {
        Column(){
          Image(this.loginIcon)
            .height('100%')
            .aspectRatio(1)
            .alt($r('app.media.ic_default_avatar'))
            .borderRadius(100)
          if (this.vipBageUrl!==undefined){
            Image(this.vipBageUrl)
              .height('30%')
              .position({x:'75%',y:'75%'})
              .aspectRatio(1)
              .alt($r('app.media.ic_default_avatar'))
              .borderRadius(100)
              .interpolation(ImageInterpolation.High)
              .objectFit(ImageFit.Cover)
              .borderWidth(2)
              .borderColor(Color.White)
          }
        }.height('100%')
        .aspectRatio(1)
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
        ItemContent({state:this.dynamic_count,content:"动态",mid:this.mid})

        Divider()
          .dividerStyle()
        ItemContent({state:this.following,content:"关注",mid:this.mid})

        Divider()
          .dividerStyle()
        ItemContent({state:this.fans,content:"粉丝",mid:this.mid})

      }.rowItemStyle()
      Row(){
        this.ImageItemComponent($r('app.media.ic_mine_offline'),"离线缓存")
        this.ImageItemComponent($r('app.media.ic_mine_history'),"历史纪录")
        this.ImageItemComponent($r('app.media.ic_mine_favorite'),"我的收藏")
        this.ImageItemComponent($r('app.media.ic_mine_watchlater'),"稍后再看")
      }.rowItemStyle()

      SwipeRefreshLayout({refresh:()=>{
        ApiLogin.loginNav().then(data=>{
          Utils.Toast(data.mid+'  '+data.uname)
        })
      }}) {
        this.otherFeatures()
      }
    }.width('100%') 
    .height('100%')
    .backgroundColor(this.backgroundColors)
  }

  @Builder
  otherFeatures(){
    Text('创作服务')
      .fontWeight(FontWeight.Bold)
      .fontSize(16)
      .width('100%')
      .margin({left:"4%",bottom:'1%',top:'1.5%'})
      .textAlign(TextAlign.Start)

    GridRow({columns:4}){
      ForEach(this.mineViewModel.getCreateCenter(),(item:MineItem,index)=>{
        GridCol() {
          this.MineChildItem(item)
        }.height('6%')
      },item=>item)
    }.direction(Direction.Ltr)

    Text('推荐服务')
      .fontWeight(FontWeight.Bold)
      .fontSize(16)
      .width('100%')
      .margin({left:"4%",bottom:'1%',top:'1.5%'})
      .textAlign(TextAlign.Start)
    // Grid(){
    //   ForEach(this.mineViewModel.recommendData,(item:RecommendItem,index)=>{
    //     GridItem() {
    //       this.RecommendItemComponent(item.img,item.name)
    //     }.borderColor(Color.Orange).borderWidth(2).height('6%').width('25%')
    //   },item=>item)
    // }

    GridRow({columns:4}){
      ForEach(this.mineViewModel.getRecommendData(),(item:MineItem,index)=>{
        GridCol() {
          this.MineChildItem(item)
        }.height('6%')
      },item=>item)
    }.direction(Direction.Ltr)
  }
  @Builder
  // 离线缓存+历史记录+我的收藏+稍后再看
  ImageItemComponent(res:Resource,content:string){
    Column(){
      Blank().layoutWeight(2)
      Image(res)
        .objectFit(ImageFit.Cover)
        .interpolation(ImageInterpolation.High)
        .height("40%")
        .aspectRatio(1)
      Blank().layoutWeight(1)
      Text(content)
        .fontColor($r('app.color.bilibili_text_black_light'))
        .fontSize(14)
        .height('50%')
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

  @Builder
  // 创作中心，推荐服务 中的子元素
  MineChildItem(item:MineItem){
    Column(){
      Blank().layoutWeight(2)
      Image(item.img)
        .objectFit(ImageFit.Cover)
        .interpolation(ImageInterpolation.High)
        .height("50%")
        .aspectRatio(1)
        .fillColor($r('app.color.bilibili_theme'))
      Blank().layoutWeight(1)
      Text(item.name)
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
      if (item.url !== undefined) {
        PageManager.routerMineWeb(item.url)
      }else{
        Utils.Toast(item.name+"功能暂不进行开发")
      }
    })
  }
}
@Component
  // 动态+关注+粉丝
struct ItemContent{
  @Prop state:string
  @Prop content:string
  @Prop mid:number
  build(){
    Column(){
      Blank().layoutWeight(2)
      Text(this.state)
        .fontColor($r('app.color.bilibili_text_black_middle'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .maxLines(1)
        .height('50%')
        .textAlign(TextAlign.Center)

      Text(this.content)
        .fontColor($r('app.color.bilibili_text_grey_light'))
        .fontSize(14)
        .maxLines(1)
        .height('30%')
      Blank().layoutWeight(2)
    }.alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .columnStyle().onClick(()=>{
      if (this.content==='关注') {
        PageManager.routerFollowWeb(this.mid,'follow')
      }else if (this.content==='粉丝') {
        PageManager.routerFollowWeb(this.mid, 'fans')
      }else{
        PageManager.routerBiliUser(this.mid)
      }
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
  .height('6%')
  .width('100%')
  .margin({top:'0.5%'})
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