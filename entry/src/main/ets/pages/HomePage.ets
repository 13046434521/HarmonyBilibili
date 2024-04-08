import { HomeBeanItem } from '../bean/HomeBean';
import Api from '../net/Api'
import router from '@ohos.router';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { SearchView } from '../component/HomeSearch';
import { Utils } from '../Utils/Utils';
import { HomeData } from '../datasource/HomeData';
import Constants from '../common/Constants';
import { SwipeRefreshList } from '../../../../../Loading/src/main/ets/pages/SwipeRefreshList';

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
  @State homeBeanItem:HomeBeanItem[] =[]
  aboutToAppear(){
    if (router.getParams()!==undefined){
      // 主页数据
      let homeData_splash = router.getParams()['homeData']
      this.homeBeanItem = homeData_splash
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
        // this.RefreshList()
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
            .aspectRatio(1)
            .height('60%')
            .margin({left:'1%'})
            .objectFit(ImageFit.Cover)

          Text(Utils.Views(homeBeanItem.stat.view))
            .height('50%')
            .textSizeStyle()
            .margin({left:'1%'})
          Image($r("app.media.ic_danmukus"))
            .aspectRatio(1)
            .height('50%')
            .objectFit(ImageFit.Cover)
            .margin({left:'2%'})

          Text(homeBeanItem.stat.danmaku.toString())
            .height('50%')
            .textSizeStyle()
            .margin({left:'1%'})

          Blank().layoutWeight(1)

          Text(Utils.Duration(homeBeanItem.duration))
            .height('50%')
            .align(Alignment.End)
            .margin({right:'2%'})
            .textSizeStyle()
        }.width('100%')
        .height(32)
      }
      .alignContent(Alignment.Bottom)

      Text(homeBeanItem.title)
        .textOverflow({ overflow:TextOverflow.Ellipsis})
        .maxLines(2)
        .fontSize(16)
        .letterSpacing(1)
        .width('100%')
        .fontColor($r('app.color.bilibili_text_black'))
        .alignSelf(ItemAlign.Start)
        .height('8%')
        .margin({top:'1%',bottom:'1%'})

      Row(){
        // Image($r('app.media.icon_playlist_upper'))
        //   .height('70%')
        //   .margin({left:'1%'})
        //   .objectFit(ImageFit.Cover)
        Image(homeBeanItem.owner.face)
          .height('70%')
          .margin({left:'1%'})
          .borderRadius(100)
          .alt($r('app.media.icon_playlist_upper'))
          .objectFit(ImageFit.Cover)
        Text(homeBeanItem.owner.name)
          .height('70%')
          .fontSize(14)
          .layoutWeight(1)
          .margin({left:'2%'})
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
  @Builder RefreshList(){
    SwipeRefreshList({data:this.homeBeanItem,refresh:()=>{
      Api.getHomePages(this.homePage+1).then(response=>{
        if (response.item!=undefined) {
          this.homePage++
          this.homeBeanItem =  this.homeBeanItem.concat(response.item)
        }
      }).catch(err=>{
        Utils.Toast("主页面"+err)
      })
    },itemChildLayout:this.HomeItem.bind(this)})
      .width('100%')
      .layoutWeight(1)
  }
  @Builder Refresh(){
    Refresh({refreshing :$$this.isRefreshing,offset:10,friction:50}){
      List(){
        LazyForEach(this.homeData,(item:HomeBeanItem)=>{
          ListItem(){
            this.HomeItem(item)
          }.margin(3)
        },(item:HomeBeanItem,index)=>JSON.stringify(item)+index)}.lanes(2)
      .edgeEffect(EdgeEffect.Fade)
      .cachedCount(Constants.CACHE_COUNT)
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
          this.homeData.addDataAll(response.item)
          this.homePage++
        }
      }).finally(()=>{
        this.isRefreshing = false
      })
    }).layoutWeight(1)
    .backgroundColor($r('app.color.bilibili_background_grey'))
  }
}

@Extend(Text) function textSizeStyle(){
  .height(20)
  .fontSize(12)
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