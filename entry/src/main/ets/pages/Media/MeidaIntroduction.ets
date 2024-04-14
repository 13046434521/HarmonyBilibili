import { MediaFtBean, MediaFtEpisodesBean } from '../../bean/media/MediaFtBean'
import { MediaSeason } from '../../bean/media/MediaRelation'
import { Online } from '../../bean/Online'
import Constants from '../../common/Constants'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PageManager, PageType } from '../../common/PageManager'
import { LoadingType } from '../../component/Loading'
import { LoadingData } from '../../component/LoadingData'
import { MediaSeasonData } from '../../datasource/MediaSeasonData'
import { Utils } from '../../Utils/Utils'
import { MediaViewModel } from '../../viewModel/media/MediaViewModel'

@Component
export struct MediaIntroduction {
  @State online: Online = new Online()
  @State err: string = ''
  @Prop seasonId: number
  @State mediaInfo: MediaFtBean = new MediaFtBean()
  @State episodes: MediaFtEpisodesBean = new MediaFtEpisodesBean()
  @State loadStatus: LoadingStatus = LoadingStatus.Loading
  @State mediaSeasonData: MediaSeasonData = new MediaSeasonData()
  mediaViewModel: MediaViewModel = new MediaViewModel()

  aboutToAppear() {
    this.mediaViewModel.getMediaInfo(this.seasonId)
      .then(mediaInfo => {
        this.mediaInfo = mediaInfo
        this.episodes = this.mediaInfo.episodes[0]
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
      PageManager.routerMedia(season.season_id,PageType.REPLACE)
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