import { HomeBeanItem } from '../bean/HomeBean';
import Api from '../net/Api'
import router from '@ohos.router';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { SearchView } from '../component/HomeSearch';
import { Utils } from '../Utils/Utils';
import { HomeData } from '../datasource/HomeData';
import Constants from '../common/Constants';

@Component
export struct HomePage {
  @State message: string = 'Home'
  @State homeData:HomeData = new HomeData()
  @State homeSearchBeanData:HomeSearchBean = new HomeSearchBean()
  @State homePage: number = 0
  @State isRefreshing: boolean = false

  @State loginIcon:string = ''
  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') vipImageUrl :string = ''
  @StorageProp('background_color') backgroundColors :string = Constants.BACKGROUND_HOME_COLOR
  onLoginClick:()=>void
  aboutToAppear(){
    if (router.getParams()!==undefined){
      // 主页数据
      let homeData_splash = router.getParams()['homeData']
      this.homeData.pushDataAll(homeData_splash)
    }

    Api.getHomeSearch().then(homesearchbean=>{
      this.homeSearchBeanData = homesearchbean
    })
  }

  build() {
    Row() {
      Column() {
        this.HomeHeader()
        this.Refresh()
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(this.backgroundColors)
  }

  @Builder HomeItem(homeBeanItem:HomeBeanItem){
    Column(){
      Stack(){
        Image(homeBeanItem.pic)
          .width('100%')
          .objectFit(ImageFit.Cover)
          .borderRadius({topLeft:5,topRight:5})
          .aspectRatio(4/3)
          .alt($r('app.media.ic_placeholder'))
        Row(){
          Image($r('app.media.ic_video_play'))
            .width(20)
            .height('100%')
            .objectFit(ImageFit.Auto)

          Text(Utils.Views(homeBeanItem.stat.view))
            .height('100%')
            .textSizeStyle()

          Image($r("app.media.ic_danmukus"))
            .width(20)
            .height(20)
            .height('100%')
            .objectFit(ImageFit.Auto)
            .margin({left:5})

          Text(homeBeanItem.stat.danmaku.toString())
            .height('100%')
            .textSizeStyle()

          Blank().layoutWeight(1)

          Text(Utils.Duration(homeBeanItem.duration))
            .height('100%')
            .align(Alignment.End)
            .margin({right:5})
            .textSizeStyle()
        }.width('100%')
        .height(32)
      }
      .alignContent(Alignment.Bottom)

      Text(homeBeanItem.title)
        .baselineOffset(40)
        .textOverflow({ overflow:TextOverflow.Ellipsis})
        .maxLines(2)
        .fontSize(14)
        .letterSpacing(1)
        .width('100%')
        .padding(8)
        .fontColor($r('app.color.bilibili_text_black'))
        .lineHeight(20)
        .alignSelf(ItemAlign.Start)
        .height(48)
        .margin({top:2,bottom:2})

      Row(){
        Image($r('app.media.icon_playlist_upper'))
          .height(16)
          .margin({left:5})
          .objectFit(ImageFit.Auto)
        Text(homeBeanItem.owner.name)
          .height(20)
          .fontSize(11)
          .layoutWeight(1)
          .margin({left:5})
          .fontColor($r('app.color.bilibili_text_grey_bold'))
        Image(homeBeanItem.owner.face)
          .width(20)
          .align(Alignment.End)
          .visibility(Visibility.None)
      }.width('100%')
      .height(24)
    }
    .borderRadius({topLeft:5,topRight:5,bottomLeft:5,bottomRight:5 })
    .backgroundColor($r('app.color.bilibili_background_white'))
    .onClick(event=>{
      router.pushUrl({url:"pages/VideoDetailPage",params:{
        bvid:homeBeanItem.bvid,
        cid:homeBeanItem.cid
      }})
    })
  }

  @Builder HomeHeader(){
    Row(){
      Image(this.isLogin?this.vipImageUrl:$r('app.media.bili_nologin_avatar'))
        .imageBtnStyle()
        .borderRadius(100)
        .onClick(()=>{
          if (!this.isLogin) {
            Utils.Toast('账号未登录，请登录')
          }
          this.onLoginClick()
        })
      SearchView({title:this.homeSearchBeanData.show_name})
        .height('50%').onClick(event=>{
        router.pushUrl({url:'pages/SearchHotPage',params:{
          title:this.homeSearchBeanData.show_name
        }})
      }).layoutWeight(1)
      .margin({left:'2%',right:'4%'})
      Image($r('app.media.ic_home_game_center'))
        .imageBtnStyle()
        .padding('1%')
        .height('40%')
      Image($r('app.media.ic_home_message'))
        .imageBtnStyle()
        .height('40%')
        .padding('1%')
    }.width("100%")
    .height('8%')
    .backgroundColor($r('app.color.bilibili_background_white'))
    .margin({top:0,bottom:0})
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder Refresh(){
    Refresh({refreshing :$$this.isRefreshing,offset:10,friction:50}){
      List(){
        LazyForEach(this.homeData,(item:HomeBeanItem)=>{
          ListItem(){
            this.HomeItem(item)
          }.margin(3)
        },(item:HomeBeanItem,index)=>JSON.stringify(item)+index)
      }.lanes(2)
      .edgeEffect(EdgeEffect.Fade)
      .onReachEnd(()=>{
        Api.getHomePages(this.homePage+1).then(response=>{
          if (response.item!=undefined) {
            this.homePage++
            this.homeData.pushDataAll(response.item)
          }
        }).catch(err=>{
          Utils.Toast("主页面"+err)
        })
      })
    }.onRefreshing(()=>{
      Api.getHomePages(this.homePage+1).then(response=>{
        if (response.item!=undefined) {
          this.homeData.cleanData()
          this.homeData.addDataAll(response.item)
          this.homePage++
        }
      }).finally(()=>{
        this.isRefreshing = false
      })
    }).layoutWeight(1)
  }
}

@Extend(Text) function textSizeStyle(){
  .height(20)
  .fontSize(11)
  .fontColor(Color.White)
}

@Extend(Image)
function imageBtnStyle() {
  .interpolation(ImageInterpolation.High)
  .objectFit(ImageFit.Contain)
  .height('50%')
  .aspectRatio(1)
  .margin({left:'2%',right:'2%'})
}