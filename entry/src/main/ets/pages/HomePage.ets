import { HomeBeanItem } from '../bean/HomeBean';
import Api from '../net/Api'
import router from '@ohos.router';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { SearchView } from '../component/HomeSearch';
import { Utils } from '../Utils/Utils';

@Component
export struct HomePage {
  @State message: string = 'Home'
  @State homeBeanData:Array<HomeBeanItem>=[]
  @State homeSearchBeanData:HomeSearchBean=new HomeSearchBean()
  @State homePage: number = 0
  @State isRefreshing: boolean = false
  aboutToAppear(){
    Api.getHomePages().then(homebean=>{
      this.homeBeanData = homebean.item
    })

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
    .backgroundColor($r('app.color.bilibili_background_grey'))
  }

  @Builder HomeItem(homeBeanItem:HomeBeanItem){
    Column(){
      Stack(){
        Image(homeBeanItem.pic)
          .width('100%')
          .objectFit(ImageFit.Auto)
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
        .aspectRatio(3/1)
        .padding(8)
        .fontColor($r('app.color.bilibili_text_black'))
        .lineHeight(20)
        .alignSelf(ItemAlign.Start)

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
      Image($r('app.media.test'))
        .objectFit(ImageFit.Auto)
        .width(24)
        .height(24)
        .margin({left:10})
      Row(){
        SearchView({title:this.homeSearchBeanData.show_name})
          .height(30)
      }.onClick(event=>{
          router.pushUrl({url:'pages/SearchHotPage',params:{
            title:this.homeSearchBeanData.show_name
          }})
      }).layoutWeight(1)

      .margin({left:10,right:10})
      Image($r('app.media.ic_home_game_center'))
        .objectFit(ImageFit.Auto)
        .interpolation(ImageInterpolation.High)
        .height(24)
        .aspectRatio(1)
        .margin({left:10,right:10})
      Image($r('app.media.ic_home_message'))
        .objectFit(ImageFit.Auto)
        .interpolation(ImageInterpolation.High)
        .height(24)
        .aspectRatio(1)
        .margin({left:10,right:10})
    }.width("100%")
    .height('8%')
    .backgroundColor($r('app.color.bilibili_background_white'))
    .margin({top:0,bottom:0})
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder Refresh(){
    Refresh({refreshing :$$this.isRefreshing,offset:10,friction:50}){
      List(){
        ForEach(this.homeBeanData,(item:HomeBeanItem)=>{
          ListItem(){
            this.HomeItem(item)

          }.margin(3)
        })
      }.lanes(2)
      .onReachEnd(()=>{
        Api.getHomePages(this.homePage+1).then(homebean=>{
          this.homePage++
          this.homeBeanData = this.homeBeanData.concat( homebean.item)
        }).catch(err=>{
          Utils.Toast(err)
        })
      })

    }.onStateChange(state=>{
      console.log('onStateChange $' + state)
    }).onRefreshing(()=>{
      Api.getHomePages().then(homebean=>{
        this.homeBeanData = homebean.item
        this.isRefreshing = false
      }).catch(err=>{
        this.isRefreshing = false
      }).finally(()=>{
        this.homePage = 0
      })
      console.log('onRefreshing $' )
    }).layoutWeight(1)
  }
}

@Extend(Text) function textSizeStyle(){
  .height(20)
  .fontSize(11)
  .fontColor(Color.White)
}