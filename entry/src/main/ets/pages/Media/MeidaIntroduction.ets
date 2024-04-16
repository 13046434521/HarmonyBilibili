import { MediaBean, MediaEpisodesBean } from '../../bean/media/MediaBean'
import { MediaSeason } from '../../bean/media/MediaRelation'
import { Online } from '../../bean/Online'
import Constants from '../../common/Constants'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PageManager, PageType } from '../../common/PageManager'
import { LoadingType } from '../../component/Loading'
import { LoadingData } from '../../component/LoadingData'
import { MediaEpsData } from '../../datasource/MediaEpsData'
import { MediaSeasonData } from '../../datasource/MediaSeasonData'
import { Utils } from '../../Utils/Utils'
import { MediaViewModel } from '../../viewModel/media/MediaViewModel'

@Component
export struct MediaIntroduction {
  @State online: Online = new Online()
  @State err: string = ''
  @Prop seasonId: number
  @State mediaInfo: MediaBean = new MediaBean()
  @State episodes: MediaEpisodesBean = new MediaEpisodesBean()
  @State loadStatus: LoadingStatus = LoadingStatus.Loading
  @State mediaSeasonData: MediaSeasonData = new MediaSeasonData()
  @State mediaEpsData:MediaEpsData = new MediaEpsData()
  @Prop index:number
  @Prop epid:number
  mediaViewModel: MediaViewModel = new MediaViewModel()
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MediaSelectDialog({
      mediaData:this.mediaEpsData,
      epid:this.epid,
      seasonId:this.seasonId,
      index:this.index
    }),
    autoCancel: false,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: 0 },
    customStyle: true,
  })
  aboutToAppear() {
    this.mediaViewModel.getMediaInfo(this.seasonId)
      .then(mediaInfo => {
        this.mediaInfo = mediaInfo
        this.episodes = this.mediaInfo.episodes[this.index]

        this.mediaEpsData.addDataAll(mediaInfo.episodes)
        console.warn('Media',JSON.stringify(this.mediaInfo.stat))
        return this.mediaViewModel.videoOnline(this.episodes.bvid,this.episodes.cid)
      }).then(online=>{
      this.online =online
      return this.mediaViewModel.getMediaRelation(this.mediaInfo.season_id)
      })
      .then(relation => {
        this.mediaSeasonData.addDataAll(relation.season)
        for (const element of relation.season) {
          console.warn('Media',element.title+"  "+JSON.stringify(element.rating))
        }

        this.loadStatus = this.mediaSeasonData.totalCount() === 0 ? LoadingStatus.LoadingOther : LoadingStatus.LoadingSuccess

      })
      .catch(err => {
        this.loadStatus = LoadingStatus.LoadingFailure
        this.err = err
      })
  }

  aboutToDisappear(){
    this.dialogController = null
  }

  build() {
    LoadingData({
      loadingStatus: this.loadStatus,
      page: this.MediaIntroduction.bind(this),
      extraFailure: this.err,
      type: LoadingType.PAGE
    })
  }

  @Builder
  MediaIntroduction() {
    List() {
      ListItemGroup({header:this.Header()}){
        LazyForEach(this.mediaSeasonData, mediaSeason => {
          ListItem() {
            this.MediaItem(mediaSeason)
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
    }.scrollBar(BarState.Off)
    .lanes(1)
    .width('100%')
    .layoutWeight(1)
    .cachedCount(Constants.CACHE_COUNT)
    .scrollBar(BarState.Off)
  }

  @Builder
  Header(){
    Column() {
    // 标题
    // 播放，收藏，正在观看，分数，详情
    // 点赞,不喜欢,投币,收藏,分享
    // 其他视频
    Row() {
      Text(this.mediaInfo.title)
        .textStyle($r('app.color.bilibili_text_black_middle'), 20)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
      if (Utils.isNonNull(this.mediaInfo.rating)){
        Text(this.mediaInfo.rating.score + "分")
          .textStyle()
          .fontColor($r('app.color.color_orange'))
          .margin({ left: '2%' })
      }
    } .margin({ left: "2%", top: '2%' })

    Row() {
      Image($r('app.media.ic_play'))
        .imageDescriptionStyle()
      Text(Utils.Views(this.mediaInfo.stat.views))
        .textStyle()
        .margin({ left: '1%' })
      Image($r("app.media.icon_media_like"))
        .imageDescriptionStyle()
        .padding(2)
        .margin({ left: '2%' })
      Text(Utils.Views(this.mediaInfo.stat.favorites))
        .textStyle()
        .margin({ left: '1%' })
      Text(Utils.timestampToDate(this.episodes.pub_time))
        .textStyle()
        .margin({ left: '2%' })
      /*          Image($r("app.media.icon_video_bilibili"))
                  .imageDescriptionStyle()
                  .margin({ left: '2%' })*/
      Text(this.online.total + "人正在看")
        .textStyle()
        .margin({ left: '2%' })

      Blank()
        .layoutWeight(1)
    }

    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .height('4%')
    .margin({ left: "2%", top: '1%' })

    Row() {
      Icon({
        res: $r("app.media.icon_video_like"),
        content: Utils.Views(this.mediaInfo.stat.likes)
      })
      Icon({
        res: $r("app.media.icon_video_coin"),
        content: Utils.Views(this.mediaInfo.stat.coins)
      })
      Icon({
        res: $r("app.media.icon_video_favorite"),
        content: Utils.Views(this.mediaInfo.stat.favorite)
      })
      Icon({
        res: $r("app.media.icon_video_share"),
        content: Utils.Views(this.mediaInfo.stat.share)
      })
    }.justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .height('8%')
    .margin({ left: "2%", top: '1%' })
      // 多P情况下显示该页面
      if (this.mediaEpsData.totalCount()>=2){
        Stack(){
          List({initialIndex:this.index,space:'2%'}){
            LazyForEach(this.mediaEpsData,(eps: MediaEpisodesBean)=>{
              ListItem(){
                Stack({alignContent:Alignment.TopEnd}){
                  Text(eps.title+"\n"+eps.long_title)
                    .width('100%')
                    .height('100%')
                    .textAlign(TextAlign.Start)
                    .maxLines(2)
                    .fontSize(14)
                    .padding('8%')
                    .fontColor(eps.ep_id===this.epid?$r('app.color.bilibili_text_theme'):$r('app.color.bilibili_text_black_middle'))
                    .textOverflow({overflow:TextOverflow.Ellipsis})

                  if (Utils.isNonNull(eps.badge_info)&&Utils.isNonNull(eps.badge_info.text)) {
                    Text(eps.badge_info.text)
                      .width('20%')
                      .height('25%')
                      .textAlign(TextAlign.Center)
                      .maxLines(1)
                      .fontSize(12)
                      .fontColor($r('app.color.bilibili_text_white'))
                      .backgroundColor(eps.badge_info.bg_color)
                      .textOverflow({overflow:TextOverflow.Ellipsis})
                      .borderRadius({bottomLeft:5})
                  }
                }.width('100%')
                .height('100%')
              }.margin({ left:'1%',right:'1%' })
              .align(Alignment.Center)
              .backgroundColor($r('app.color.bilibili_background_grey'))
              .borderRadius(5)
              .height('80%')
              .aspectRatio(2.5)
              .onClick(()=>{
                PageManager.routerMedia(this.seasonId,eps.ep_id,PageType.REPLACE)
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
      .margin({ top: "1%", bottom: "1%" })
      .color($r('app.color.bilibili_divider'))
    }.justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  MediaItem(season: MediaSeason) {
    Column() {
      Row() {
        Stack() {
          Image(season.new_ep.cover)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(5)
            .alt($r('app.media.ic_placeholder'))
            .interpolation(ImageInterpolation.High)

          Text(season.badge_info.text)
            .maxLines(1)
            .margin({ top: '2%', right: '2%' })
            .fontSize(14)
            .backgroundColor(season.badge_info.bg_color)
            .fontColor($r('app.color.bilibili_text_white'))
            .borderRadius(5)
            .padding('2%')
            .opacity(0.8)
            .textAlign(TextAlign.Center)

        }.height('100%')
        .aspectRatio(Constants.DEFAULT_ASPECT_RATIO)
        .padding('1%')
        .align(Alignment.TopEnd)

        Column() {
          Text(season.title)
            .maxLines(2)
            .fontColor($r("app.color.bilibili_text_black_light"))
            .fontSize(16)
            .letterSpacing(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)

          Row() {
            Text(season.new_ep.index_show)
              .textStyle($r('app.color.bilibili_text_grey_light'), 16)
              .margin({ right: '2%' })


          }.justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: '1%' })


          Row() {
            Image($r('app.media.ic_play'))
              .imageStyle()
            Text(Utils.Views(season.stat.view))
              .textStyle()
            Image($r("app.media.icon_media_like"))
              .imageStyle()
              .padding(2)
              .margin({ left: '1%' })
            Text(Utils.Views(season.stat.follow))
              .textStyle()
              .margin({ left: '1%' })

            Blank()
              .layoutWeight(1)
          }
          .height('15%')
        }
        .alignItems(HorizontalAlign.Start)
        .padding('1%')
        .layoutWeight(1)


        Column() {
          if (Utils.isNonNull(season.rating)){
            Text(season.rating.score+'分')
              .fontColor(Color.Orange)
              .fontSize(14)
              .height('20%')
              .margin({right:"4%"})
            Text(season.rating===undefined?"undefined":Utils.Views(season.rating.count)+'人评分')
              .fontSize(12)
              .margin({right:"4%"})
          }
          Image($r("app.media.ic_more"))
            .onClick(() => {
              AlertDialog.show(
                {
                  message: "播放：" + season.stat.view + "\n" +
                    "收藏：" + season.stat.follow + "\n" +
                    "弹幕：" + season.stat.danmaku + "\n",
                  autoCancel: true,
                  alignment: DialogAlignment.Bottom,
                  gridCount: 50,
                }
              )
            }).height('25%')
            .aspectRatio(1)
            .position({x:"70%",y:'70%'})
            .fillColor($r('app.color.bilibili_text_grey_light'))
            .objectFit(ImageFit.Contain)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.End)
        .height('100%')
        .width('20%')

      }.justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .height('14%')

      Divider().color($r('app.color.bilibili_divider'))
        .margin({ left: '1%', right: '1%' })
        .strokeWidth(1)
    }
    .onClick(event => {
      PageManager.routerMedia(season.season_id,this.episodes.ep_id,PageType.REPLACE)
    })
  }
}

@Component
struct Icon {
  @Prop res: Resource
  @Prop content: string

  build() {
    Column() {
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
function textStyle(color: Resource = $r('app.color.bilibili_text_grey_light'), size: number = 14) {
  .fontColor(color)
  .fontSize(size)
}

@Extend(Image)
function imageStyle() {
  .height('100%')
  .aspectRatio(1)
  .margin({ right: "1%" })
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
struct MediaSelectDialog {
  @Link mediaData: MediaEpsData
  @Link epid: number
  @Link seasonId: number
  @Link index: number
  customDialogController :CustomDialogController
  build() {
    Column(){
      Row(){
        Text("分集("+this.mediaData.totalCount()+")")
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
        LazyForEach(this.mediaData,eps=>{
          ListItem(){
            Stack({alignContent:Alignment.TopEnd}){
              Text(eps.title+"\n"+eps.long_title)
                .width('100%')
                .height('100%')
                .textAlign(TextAlign.Center)
                .maxLines(2)
                .fontSize(14)
                .fontColor(eps.ep_id===this.epid?$r('app.color.bilibili_text_theme'):$r('app.color.bilibili_text_black_middle'))
                .textOverflow({overflow:TextOverflow.Ellipsis})

              if (Utils.isNonNull(eps.badge_info)&&Utils.isNonNull(eps.badge_info.text)) {
                Text(eps.badge_info.text)
                  .width('10%')
                  .height('30%')
                  .textAlign(TextAlign.Center)
                  .maxLines(1)
                  .fontSize(12)
                  .fontColor($r('app.color.bilibili_text_white'))
                  .backgroundColor(eps.badge_info.bg_color)
                  .textOverflow({overflow:TextOverflow.Ellipsis})
                  .borderRadius({bottomLeft:5})
              }
            }.width('100%')
            .height('100%')

          }.margin({ left:'1%',right:'1%' })
          .align(Alignment.Center)
          .backgroundColor($r('app.color.bilibili_background_grey'))
          .borderRadius(5)
          .height('10%')
          .width('98%')
          .selectable(true)
          .onClick(()=>{
            PageManager.routerMedia(this.seasonId,eps.ep_id,PageType.REPLACE)
          })
        })
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