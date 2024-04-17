import { UserInfoBean } from '../../bean/biliUser/UserInfoBean'
import { Online } from '../../bean/Online'
import { PageListBean } from '../../bean/PageListBean'
import VideoInfo from '../../bean/video/VideoInfo'
import { VideoRecommend } from '../../bean/video/VideoRecommend'
import Constants from '../../common/Constants'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PageManager, PageType } from '../../common/PageManager'
import ListFooter from '../../component/ListFooter'
import { LoadingType } from '../../component/Loading'
import { LoadingData } from '../../component/LoadingData'
import { VideoPageData } from '../../datasource/VideoPageData'
import { VideoRecommendData } from '../../datasource/VideoRecommendData'
import { toast } from '../../Utils/ToastUtils'
import { Utils } from '../../Utils/Utils'
import VideoViewModel from '../../viewModel/Video/VideoViewModel'

@Component
export default struct VideoIntroduction {
  @State videoInfo:VideoInfo = new VideoInfo()
  @State userInfo:UserInfoBean = new UserInfoBean()
  @State videoRecommends:VideoRecommend[] = new Array<VideoRecommend>()
  @State videoRecommendData:VideoRecommendData = new VideoRecommendData()
  @State online:Online = new Online()
  @State loadStatus:LoadingStatus = LoadingStatus.Loading
  @State err:string = ''
  @State videoLists:VideoPageData = new VideoPageData()
  videoViewModel:VideoViewModel
  @Prop bvid:string
  @Prop cid:number
  @State index :number = 0
  scroll:Scroller = new Scroller()
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
      return this.videoViewModel.getVideoList(this.bvid)
    }).then(lists=>{
      for (let index = 0; index < lists.length; index++) {
        const element = lists[index];
        if (this.cid === element.cid) {
          this.index = index
          continue
        }
      }
      this.videoLists.pushDataAll(lists)
      this.loadStatus = LoadingStatus.LoadingSuccess
    }).catch(err=>{
      this.err = err
      this.loadStatus = LoadingStatus.LoadingFailure
    })
  }
  build(){
    LoadingData({loadingStatus:this.loadStatus,page:this.VideoIntroduction.bind(this),extraFailure:this.err,type:LoadingType.PAGE})
  }

  dialogController: CustomDialogController = new CustomDialogController({
      builder: VideoSelectDialog({
      videoLists:this.videoLists,
      cid:this.cid,
      bvid:this.bvid,
      index:this.index
    }),
    autoCancel: false,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: 0 },
    customStyle: true,
  })


  @Builder
  VideoIntroduction(){
    List({scroller:this.scroll}){
      ListItemGroup({header:this.Header(),footer:ListFooter()}){
        LazyForEach(this.videoRecommendData,videoRecommend=>{
          ListItem(){
            this.VideoItem(videoRecommend)
          }
        },(item,index)=>JSON.stringify(item)+index)
      }
    }
    .lanes(1)
    .cachedCount(Constants.CACHE_COUNT)
    .scrollBar(BarState.Off)
    .width('100%')
    .height("100%")
  }

  @Builder
  Header(){
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
            PageManager.routerBiliUser(this.videoInfo.owner.mid,PageType.REPLACE)
          })

        Column(){
          Text(this.videoInfo.owner.name)
            .textStyle($r('app.color.bilibili_text_theme'),16)
          Row(){
            Text(Utils.Views(this.userInfo.follower,1)+'粉丝')
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
        Icon({res:$r("app.media.icon_video_like"),content:Utils.Views(this.videoInfo.stat.like)})
        // Icon({res:$r("app.media.icon_video_dislike"),content:'不喜欢'})
        Icon({res:$r("app.media.icon_video_coin"),content:Utils.Views(this.videoInfo.stat.coin)})
        Icon({res:$r("app.media.icon_video_favorite"),content:Utils.Views(this.videoInfo.stat.favorite)})
        Icon({res:$r("app.media.icon_video_share"),content:Utils.Views(this.videoInfo.stat.share)})
      }.justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .height('8%')
      .margin({left:"2%",top:'1%',bottom:'1&'})

      // 多集选项
      if (this.videoLists.totalCount()>=2){
        Stack(){
          List({initialIndex:this.index,space:'2%'}){
            LazyForEach(this.videoLists,video=>{
              ListItem(){
                Text(video.part)
                  .height('100%')
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .maxLines(2)
                  .fontSize(14)
                  .padding('4%')
                  .fontColor(video.cid===this.cid?$r('app.color.bilibili_text_theme'):$r('app.color.bilibili_text_black_middle'))
                  .textOverflow({overflow:TextOverflow.Ellipsis})
              }.margin({ left:'1%',right:'1%' })
              .align(Alignment.Center)
              .backgroundColor($r('app.color.bilibili_background_grey'))
              .borderRadius(5)
              .height('80%')
              .aspectRatio(2.5)
              .onClick(()=>{
                PageManager.routerVideoDetail(this.bvid,0,video.cid,PageType.REPLACE)
              })
            },(item,index)=>JSON.stringify(item)+index)

          }.listDirection(Axis.Horizontal)
          .height('100%')
          .tabIndex(this.index)
          .alignListItem(ListItemAlign.Center)
          Image($r("app.media.icon_video_more"))
            .objectFit(ImageFit.Contain)
            .height('70%')
            .aspectRatio(0.5)
            .opacity(0.8)
            .backgroundColor(Color.White)
            .onClick(()=>{
              this.dialogController.open()
            })
        }.align(Alignment.End)
        .height('10%')
      }

      Divider()
        .vertical(false)
        .strokeWidth(1)
        .margin({top:"1%",bottom:"1%"})
        .color($r('app.color.bilibili_divider'))
    }.justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
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
      PageManager.routerVideoDetail(videoRecommend.bvid,videoRecommend.aid,videoRecommend.cid,PageType.REPLACE)
    })
  }

  // 在自定义组件即将析构销毁时将dialogControlle置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
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

@CustomDialog
struct VideoSelectDialog {
  @Link videoLists: VideoPageData
  @Link cid: number
  @Link bvid: string
  @Link index: number
  customDialogController :CustomDialogController
  build() {
    Column(){
      Row(){
        Text("分集("+this.videoLists.totalCount()+")")
          .margin({left:"1%"})
          .height('100%')
          .fontColor($r('app.color.bilibili_text_black_middle'))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Blank().layoutWeight(1)
        Image($r('app.media.icon_close'))
          .objectFit(ImageFit.Contain)
          .height('30%')
          .aspectRatio(1)
          .onClick(()=>{
            this.customDialogController.close()
          }).margin('1%')
      }.height("8%")
      .alignItems(VerticalAlign.Center)
      Divider().strokeWidth(0.5).margin({bottom:"2%"})
        .backgroundColor($r("app.color.bilibili_divider"))

      List({initialIndex:this.index,space:'1%'}){
        LazyForEach(this.videoLists,video=>{
          ListItem(){
            Text(video.part)
              .layoutWeight(1)
              .textAlign(TextAlign.Start)
              .maxLines(1)
              .fontSize(14)
              .padding('4%')
              .fontColor(video.cid===this.cid?$r('app.color.bilibili_text_theme'):$r('app.color.bilibili_text_black_middle'))
              .textOverflow({overflow:TextOverflow.Ellipsis})
          }
          .backgroundColor($r('app.color.bilibili_background_grey'))
          .borderRadius(5)
          .height('8%')
          .width('98%')
          .selectable(true)
          .onClick(()=>{
            PageManager.routerVideoDetail(this.bvid,0,video.cid,PageType.REPLACE)
          })
        },(item,index)=>JSON.stringify(item)+index)
      }.listDirection(Axis.Vertical)
      .cachedCount(Constants.CACHE_COUNT)
      .alignListItem(ListItemAlign.Center)


      .lanes(2)
      .layoutWeight(1)
    }.height('60%')
    .width('100%')
     .backgroundColor($r('app.color.bilibili_background_white'))

  }
}

