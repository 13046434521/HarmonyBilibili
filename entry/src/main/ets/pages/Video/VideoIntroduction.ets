import { UserInfoBean } from '../../bean/biliUser/UserInfoBean'
import { Online } from '../../bean/Online'
import VideoInfo from '../../bean/video/VideoInfo'
import { VideoRecommend } from '../../bean/video/VideoRecommend'
import Constants from '../../common/Constants'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PageManager } from '../../common/PageManager'
import { LoadingType } from '../../component/Loading'
import { LoadingData } from '../../component/LoadingData'
import { VideoRecommendData } from '../../datasource/VideoRecommendData'
import { Utils } from '../../Utils/Utils'
import VideoViewModel from '../../viewModel/Video/VideoViewModel'

@Component
export default struct VideoIntroduction {
  @State videoInfo:VideoInfo = new VideoInfo()
  @State userInfo:UserInfoBean = new UserInfoBean()
  @State videoRecommends:VideoRecommend[] = new Array<VideoRecommend>()
  @State videoRecommendData:VideoRecommendData = new VideoRecommendData()
  @State online:Online = new Online()
  @State err:string = ''
  videoViewModel:VideoViewModel
  bvid:string
  @State loadStatus:LoadingStatus = LoadingStatus.Loading
  aboutToAppear(){
    this.videoViewModel.loadVideoInfo(this.bvid).then(videoInfo=>{
      this.videoInfo = videoInfo
      return this.videoViewModel.upInfo(videoInfo.owner.mid)
    }).then(userInfo=>{
        this.userInfo = userInfo
      return this.videoViewModel.videoRecommend(this.bvid)
    }).then(recommend=>{
      this.videoRecommendData.addDataAll(recommend)

      return this.videoViewModel.videoOnline(this.bvid,this.videoInfo.cid)
    }).then(online=>{
      this.online = online
      this.loadStatus = LoadingStatus.LoadingSuccess
    }).catch(err=>{
      this.err = err
      this.loadStatus = LoadingStatus.LoadingFailure
    })
  }
  build(){
    LoadingData({loadingStatus:this.loadStatus,page:this.VideoIntroduction.bind(this),extraFailure:this.err,type:LoadingType.PAGE})
  }

  @Builder
  VideoIntroduction(){
    Scroll(){
      Column(){
        // 头像
        // 标题
        // 详情
        // tag
        // 点赞,不喜欢,投币,收藏,分享
        // 其他视频
        Row(){
          Image(this.videoInfo.owner.face)
            .height('100%')
            .aspectRatio(1)
            .borderRadius(100)
            .margin({right:'1%'})
            .alt($r('app.media.default_avater'))
            .onClick(()=>{
              PageManager.routerBiliUser(this.videoInfo.owner.mid)
            })

          Column(){
            Text(this.videoInfo.owner.name)
              .textStyle($r('app.color.bilibili_text_theme'),16)
            Row(){
              Text(Utils.userFans(this.userInfo.follower)+'粉丝')
                .textStyle()
              Text('视频:'+this.videoInfo.dimension.width +"*"+this.videoInfo.dimension.height)
                .textStyle()
                .margin({left:"2%"})
            }.margin({top:'1%'})
          }.width('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Start)

        }.height('8%')
        .margin({left:"2%"})
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Text(this.videoInfo.title)
          .textStyle($r('app.color.bilibili_text_black_middle'),20)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .maxLines(2)
          .margin({left:"2%",top:'2%'})

        Row() {
          Image($r('app.media.ic_play'))
            .imageDescriptionStyle()
          Text(Utils.Views(this.videoInfo.stat.view))
            .textStyle()
            .margin({ left: '1%' })
          Image($r("app.media.ic_danmu"))
            .imageDescriptionStyle()
            .margin({ left: '2%' })
          Text(Utils.Views(this.videoInfo.stat.danmaku))
            .textStyle()
            .margin({ left: '1%' })
          Text(Utils.timestampToDate(this.videoInfo.pubdate))
            .textStyle()
            .margin({ left: '2%' })
/*          Image($r("app.media.icon_video_bilibili"))
            .imageDescriptionStyle()
            .margin({ left: '2%' })*/
          Text(this.online.total+"人正在看")
            .textStyle()
            .margin({ left: '2%' })
          Blank()
            .layoutWeight(1)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .height('6%')
        .margin({left:"2%",top:'1%'})

        Row(){
          Icon({res:$r("app.media.icon_video_like"),content:Utils.userFans(this.videoInfo.stat.like)})
          // Icon({res:$r("app.media.icon_video_dislike"),content:'不喜欢'})
          Icon({res:$r("app.media.icon_video_coin"),content:Utils.userFans(this.videoInfo.stat.coin)})
          Icon({res:$r("app.media.icon_video_favorite"),content:Utils.userFans(this.videoInfo.stat.favorite)})
          Icon({res:$r("app.media.icon_video_share"),content:Utils.userFans(this.videoInfo.stat.share)})
        }.justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .height('8%')
        .margin({left:"2%",top:'1%'})
        Divider()
          .vertical(false)
          .strokeWidth(1)
          .margin({top:"1%",bottom:"1%"})
          .color($r('app.color.bilibili_divider'))
        List(){
          LazyForEach(this.videoRecommendData,videoRecommend=>{
            ListItem(){
              this.VideoItem(videoRecommend)
            }
          },(item,index)=>JSON.stringify(item)+index)
        }
        .lanes(1)
        .cachedCount(Constants.CACHE_COUNT)
        .scrollBar(BarState.Off)
      }.justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
  }

  @Builder VideoItem(videoRecommend:VideoRecommend){
    Column() {
      Row() {
        Stack() {
          Image(videoRecommend.pic)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(5)
            .alt($r('app.media.ic_placeholder'))
            .interpolation(ImageInterpolation.High)

          Text(Utils.Duration(videoRecommend.duration))
            .maxLines(1)
            .margin({ bottom: '1%', right:  '2%' })
            .fontSize(12)
            .backgroundColor(Color.Grey)
            .fontColor(Color.White)
            .borderRadius(5)
            .padding('1%')
            .opacity(0.8)

        }.height('100%')
        .aspectRatio(Constants.DEFAULT_ASPECT_RATIO)
        .padding('1%')
        .align(Alignment.BottomEnd)
        .onClick(()=>{
          PageManager.routerBiliUser(videoRecommend.owner.mid)
        })

        Column() {
          Text(videoRecommend.title)
            .maxLines(2)
            .fontColor($r("app.color.bilibili_text_black_light"))
            .fontSize(16)
            .letterSpacing(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)

          Row(){
            Image($r('app.media.icon_playlist_upper'))
              .imageStyle()
            Text(videoRecommend.owner.name)
              .textStyle($r('app.color.bilibili_text_grey_light'),16)
              .margin({left: '1%' ,right:'2%'})
            Text(Utils.timestampToDate(videoRecommend.pubdate))
              .textStyle()

          }.justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .margin({bottom:'1%'})

          Row() {
            Image($r('app.media.ic_play'))
              .imageStyle()
            Text(Utils.Views(videoRecommend.stat.view))
              .textStyle()
            Image($r("app.media.ic_danmu"))
              .imageStyle()
              .margin({ left: '1%' })
            Text(Utils.Views(videoRecommend.stat.danmaku))
              .textStyle()
              .margin({ left: '1%' })
            Text(videoRecommend.pub_location==undefined?'未知':videoRecommend.pub_location)
              .textStyle()
              .margin({ left: '2%' })
            Blank()
              .layoutWeight(1)
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding('1%')
        .layoutWeight(1)

        Image($r("app.media.ic_more"))
          .onClick(() => {
            AlertDialog.show(
              {
                message: "播放："+videoRecommend.stat.view+"\n" +
                  "喜欢："+videoRecommend.stat.like+"\n" +
                  "硬币："+videoRecommend.stat.coin+"\n" +
                  "收藏："+videoRecommend.stat.favorite+"\n" +
                  "弹幕："+videoRecommend.stat.danmaku+"\n" +
                  "评论："+videoRecommend.stat.reply+"\n" +
                  "不喜欢："+videoRecommend.stat.dislike+"\n",
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                gridCount: 50,
              }
            )
          }).width('5%')
          .height('35%')
          .fillColor($r('app.color.bilibili_text_grey_light'))
          .objectFit(ImageFit.Contain)
      }.justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .height('15%')

      Divider().color($r('app.color.bilibili_divider'))
        .margin({ left: '1%', right: '1%' })
        .strokeWidth(1)
    }
    .onClick(event=>{
      PageManager.routerVideoDetail(videoRecommend.bvid,videoRecommend.cid)
    })
  }
}
@Component
struct Icon{
  @Prop res:Resource
  @Prop content:string
  build(){
    Column(){
      Image(this.res)
        .objectFit(ImageFit.Contain)
        .layoutWeight(1)
        .margin({bottom:'2%'})
        .fillColor($r('app.color.bilibili_background_black_light'))
      Text(this.content)
        .textStyle()
        .height('30%')
    }
    .layoutWeight(1)
  }
}

@Extend(Text)
function textStyle(color:Resource=$r('app.color.bilibili_text_grey_light'),size:number=14 ){
  .fontColor(color)
  .fontSize(size)
}

@Extend(Image)
function imageStyle() {
  .height('20%')
  .aspectRatio(1)
  .margin({right:"1%"})
  .fillColor($r('app.color.bilibili_text_grey_light'))
  .objectFit(ImageFit.Cover)
  .interpolation(ImageInterpolation.Low)
}

@Extend(Image)
function imageDescriptionStyle() {
  .height('60%')
  .aspectRatio(1)
  .fillColor($r('app.color.bilibili_text_grey_light'))
  .objectFit(ImageFit.Cover)
  .interpolation(ImageInterpolation.Low)
}