import { UserBangumi, UserBangumiItem } from '../../bean/biliUser/UserBangumi'
import { UserBookmark, UserBookmarkItem } from '../../bean/biliUser/UserBookmark'
import { UserCoinVideo } from '../../bean/biliUser/UserCoinVideo'
import { UserUpvote, UserUpvoteItem } from '../../bean/biliUser/UserUpvote'
import { UserVideoBean, UserVideoItem } from '../../bean/biliUser/UserVideoBean'
import { Utils } from '../../Utils/Utils'
import { BiliUserViewModel } from '../../viewModel/biliUser/BiliUserViewModel'
import { PageManager } from '../../common/PageManager'

@Component
export struct BiliUserHome {
  mid: number = 0
  @State state: string = ''
  userVideoBean: UserVideoBean = undefined
  userBookmark: UserBookmark = undefined
  userBangumi: UserBangumi = undefined
  userCoinVideos: UserCoinVideo[] = undefined
  userUpvote: UserUpvote = undefined
  biliUserViewModel: BiliUserViewModel = undefined
  @State userVideoItems: UserVideoItem[] = []
  @State userBookmarkItems: UserBookmarkItem[] = []
  @State userBangumiItems: UserBangumiItem[] = []
  @State userUpvoteItems: UserUpvoteItem[] = []
  @State userCoinItems: UserCoinVideo[] = []
  biliData: BiliData[] = []

  aboutToAppear() {
    console.error('BiliUser  Home:video:' + this.userVideoBean + '  Bangumi:' + this.userBangumi + '  CoinVideos:' + this.userCoinVideos + '  Upvote:' + this.userUpvote + '  Bookmark:' + this.userBookmark)
    if (Utils.isNonNull(this.userVideoBean)) {
      // 视频最多4个
      let videoCount = this.userVideoBean.list.vlist.length > 4 ? 4 : this.userVideoBean.list.vlist.length
      for (let index = 0; index < videoCount; index++) {
        const element = this.userVideoBean.list.vlist[index];
        this.userVideoItems.push(element)
      }
      this.biliData.push(new BiliData(this.userVideoItems, 'video'))
    }
    if (Utils.isNonNull(this.userBangumi)) {
      // 追番最多3个
      let bangumikCount = this.userBangumi.list.length > 3 ? 3 : this.userBangumi.list.length
      for (let index = 0; index < bangumikCount; index++) {
        const element = this.userBangumi.list[index];
        this.userBangumiItems.push(element)
      }
      this.biliData.push(new BiliData(this.userBangumiItems, 'bangumi'))
    }
    if (Utils.isNonNull(this.userCoinVideos)) {
      //投币视频最多2个
      let coinCount = this.userCoinVideos.length > 2 ? 2 : this.userCoinVideos.length
      for (let index = 0; index < coinCount; index++) {
        const element = this.userCoinVideos[index];
        this.userCoinItems.push(element)
      }
      this.biliData.push(new BiliData(this.userCoinItems, 'coin'))
    }
    if (Utils.isNonNull(this.userUpvote)) {
      //点赞视频最多2个
      let upvoteCount = this.userUpvote.list.length > 2 ? 2 : this.userUpvote.list.length
      for (let index = 0; index < upvoteCount; index++) {
        const element = this.userUpvote.list[index];
        this.userUpvoteItems.push(element)
      }
      this.biliData.push(new BiliData(this.userUpvoteItems, 'upvote'))
    }
    if (Utils.isNonNull(this.userBookmark)) {
      // 收藏最多2个
      let bookmarkCount = this.userBookmark.list.length > 2 ? 2 : this.userBookmark.list.length
      for (let index = 0; index < bookmarkCount; index++) {
        const element = this.userBookmark.list[index];
        this.userBookmarkItems.push(element)
      }
      this.biliData.push(new BiliData(this.userBookmarkItems, 'bookmark'))
    }
  }

  build() {
    /*    Scroll(){
          Column(){
            this.UserPage()
          }.width('100%')
          .justifyContent(FlexAlign.Start)
          .backgroundColor($r('app.color.bilibili_background_grey'))
          .padding('2%')
        }.width('100%').layoutWeight(1)
        .backgroundColor($r('app.color.bilibili_background_grey'))
        .scrollBar(BarState.Off)*/
    Column() {
      List() {
        ForEach(this.biliData, (item: BiliData) => {
          ListItem() {
            if (item.type === 'video') {
              this.VideoView()
            } else if (item.type === 'bookmark') {
              this.BookmarkView()
            } else if (item.type === 'bangumi') {
              this.BangumiView()
            }
            else if (item.type === 'coin') {
              this.CoinVideoView()
            }
            else if (item.type === 'upvote') {
              this.UpvoteVideoView()
            }
          }
        })
      }.lanes(1)
      .width('100%')
      .height('100%')
    }.width('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.bilibili_background_grey'))
    .padding('2%')

  }

  /*------------------------------------------- 视频 --------------------------------------------*/
  @Builder
  VideoView() {
    Column() {
      Row() {
        Text('视频  ' + this.userVideoBean.list.vlist.length)
          .titleStyle()
        Text('查看更多 >').onClick(() => {
          this.biliUserViewModel.changePage(2)
        }).fontColor($r('app.color.bilibili_text_grey_light'))
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height('5%')

      GridRow({
        columns: 2,
        gutter: { x: 15, y: 15 },
        // breakpoints: { value: ["400vp", "600vp", "800vp"],
        //   reference: BreakpointsReference.WindowSize },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.userVideoItems, (video: UserVideoItem) => {
          // GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {
          GridCol() {
            this.VideoItem(video.pic, video.title, video.length, video.play, video.video_review, video.bvid)
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
    }
  }

  @Builder
  VideoItem(pic: string, title: string, time: string, play: number, danmu: number, bvid: string, cid: number = 0) {
    Column() {
      Stack() {
        Image(pic)
          .width('100%')
          .objectFit(ImageFit.Cover)
          .interpolation(ImageInterpolation.Low)
          .borderRadius({ topLeft: 5, topRight: 5 })
          .aspectRatio(4 / 3)
          .alt($r('app.media.ic_placeholder'))
        // 透明背景
        // Row()
        //   .width('100%')
        //   .height('5%')
        //   .margin({bottom:'2%'})
        //   .opacity(0.5)
        //   .linearGradient({
        //     colors: [[0xffffff, 0.0],[0x17181A, 1.0]]})
        Row() {
          Image($r("app.media.ic_play"))
            .aspectRatio(1)
            .height('30%')
            .margin({ left: '1%' })
            .objectFit(ImageFit.Cover)

          Text(Utils.Views(play))
            .height('30%')
            .textSizeStyle()
            .margin({ left: '1%' })
          Image($r("app.media.ic_danmukus"))
            .aspectRatio(1)
            .height('30%')
            .objectFit(ImageFit.Cover)
            .margin({ left: '2%' })

          Text(danmu + '')
            .height('30%')
            .textSizeStyle()
            .margin({ left: '1%' })

          Blank().layoutWeight(1)

          Text(time)
            .height('30%')
            .align(Alignment.End)
            .margin({ right: '2%' })
            .textSizeStyle()
        }.width('100%')
        .height('10%')
        .alignItems(VerticalAlign.Bottom)
        .margin({ bottom: '2%' })

      }
      .alignContent(Alignment.Bottom)


      Text(title)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontSize(16)
        .letterSpacing(1)
        .width('100%')
        .fontColor($r('app.color.bilibili_text_black'))
        .alignSelf(ItemAlign.Start)
        .height('8%')
        .margin({ top: '1%', bottom: '1%', left: '2%' })
    }
    .borderRadius(5)
    .backgroundColor($r('app.color.bilibili_background_white'))
    .onClick(event => {
      PageManager.routerVideoDetail(bvid, cid)
    })
  }

  /*------------------------------------------- 收藏 --------------------------------------------*/
  @Builder
  BookmarkView() {
    Column() {
      Row() {
        Text('收藏  ' + this.userBookmark.count)
          .titleStyle()
        Text('查看更多 >').onClick(() => {
          this.biliUserViewModel.changePage(3)
        }).fontColor($r('app.color.bilibili_text_grey_light'))
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height('5%')

      GridRow({
        columns: 2,
        gutter: { x: 15, y: 15 },
        // breakpoints: { value: ["400vp", "600vp", "800vp"],
        //   reference: BreakpointsReference.WindowSize },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.userBookmarkItems, (bookmark: UserBookmarkItem) => {
          // GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {
          GridCol() {
            this.BookmarkItem(bookmark)
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
    }
  }

  @Builder
  BookmarkItem(bookmark: UserBookmarkItem) {
    Column() {
      Stack() {
        Image(bookmark.cover)
          .width('100%')
          .objectFit(ImageFit.Cover)
          .interpolation(ImageInterpolation.Low)
          .borderRadius({ topLeft: 5, topRight: 5 })
          .aspectRatio(4 / 3)
          .alt($r('app.media.ic_placeholder'))
      }
      .alignContent(Alignment.Bottom)

      Text(bookmark.title)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontSize(16)
        .letterSpacing(1)
        .width('100%')
        .fontColor($r('app.color.bilibili_text_black'))
        .alignSelf(ItemAlign.Start)
        .height('4%')
        .margin({ top: '1%', bottom: '1%', left: '2%' })

      Text(bookmark.media_count + '个内容')
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontSize(14)
        .letterSpacing(1)
        .width('100%')
        .fontColor($r('app.color.bilibili_text_grey_light'))
        .alignSelf(ItemAlign.Start)
        .height('4%')
        .margin({ top: '1%', bottom: '1%', left: '2%' })
    }
    .borderRadius(5)
    .backgroundColor($r('app.color.bilibili_background_white'))
    .onClick(event => {

    })
  }

  /*------------------------------------------- 追番 --------------------------------------------*/
  @Builder
  BangumiView() {
    Column() {
      Row() {
        Text('追番  ' + this.userBangumi.total)
          .titleStyle()
        Text('查看更多 >').onClick(() => {
          this.biliUserViewModel.changePage(4)
        }).fontColor($r('app.color.bilibili_text_grey_light'))
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height('5%')

      GridRow({
        columns: 3,
        gutter: { x: 15, y: 15 },
        // breakpoints: { value: ["400vp", "600vp", "800vp"],
        //   reference: BreakpointsReference.WindowSize },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.userBangumiItems, (bangumi: UserBangumiItem) => {
          // GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {
          GridCol() {
            this.BangumiItem(bangumi)
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
    }
  }

  @Builder
  BangumiItem(bangumi: UserBangumiItem) {
    Stack() {
      Image(bangumi.cover)
        .width('100%')
        .objectFit(ImageFit.Cover)
        .interpolation(ImageInterpolation.Low)
        .borderRadius({ topLeft: 5, topRight: 5 })
        .aspectRatio(3 / 4)
        .alt($r('app.media.ic_placeholder'))

      Column() {
        Text(bangumi.title)
          .fontColor(Color.White)
          .fontSize(16)
          .margin({ left: '2%', bottom: '2%' })


        Text(bangumi.new_ep.index_show)
          .fontColor(Color.White)
          .fontSize(14)
          .margin({ left: '2%', bottom: '2%' })

      }.width('100%')
      .height('25%')

      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.Start)
    }.alignContent(Alignment.BottomStart)
    .borderRadius({ topLeft: '1%', topRight: '1%', bottomLeft: '1%', bottomRight: '1%' })
    .backgroundColor($r('app.color.bilibili_background_white'))
    .onClick(event => {
      PageManager.routerMediaFt(bangumi.season_id)
    })
  }

  /*------------------------------------------- 最近投币的视频 --------------------------------------------*/
  @Builder
  CoinVideoView() {
    Column() {
      Row() {
        Text('最近投币的视频')
          .titleStyle()
        Text('查看更多 >').onClick(() => {
          this.biliUserViewModel.changePage(2)
        }).fontColor($r('app.color.bilibili_text_grey_light'))
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height('5%')

      GridRow({
        columns: 2,
        gutter: { x: 15, y: 15 },
        // breakpoints: { value: ["400vp", "600vp", "800vp"],
        //   reference: BreakpointsReference.WindowSize },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.userCoinItems, (coin: UserCoinVideo) => {
          // GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {
          GridCol() {
            this.VideoItem(coin.pic, coin.title, Utils.Duration(coin.duration), coin.stat.view, coin.stat.danmaku, coin.bvid, coin.cid)
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
    }
  }

  /*------------------------------------------- 最近点赞的视频 --------------------------------------------*/
  @Builder
  UpvoteVideoView() {
    Column() {
      Row() {
        Text('最近点赞的视频')
          .titleStyle()
        Text('查看更多 >').onClick(() => {
          this.biliUserViewModel.changePage(2)
        }).fontColor($r('app.color.bilibili_text_grey_light'))
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height('5%')

      GridRow({
        columns: 2,
        gutter: { x: 15, y: 15 },
        // breakpoints: { value: ["400vp", "600vp", "800vp"],
        //   reference: BreakpointsReference.WindowSize },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.userUpvoteItems, (upvote: UserUpvoteItem) => {
          // GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {
          GridCol() {
            this.VideoItem(upvote.pic, upvote.title, Utils.Duration(upvote.duration), upvote.stat.view, upvote.stat.danmaku, upvote.bvid, upvote.cid
            )
          }
        }, (item, index) => JSON.stringify(item) + index)
      }
    }
  }
}

@Extend(Text)
function textSizeStyle() {
  .fontSize(14)
  .fontColor(Color.White)
}

@Extend(Text)
function titleStyle() {
  .fontColor($r('app.color.bilibili_text_grey_light'))
}

class BiliData {
  data: UserVideoItem[] | UserBookmarkItem[] | UserBangumiItem[] | UserUpvoteItem[] | UserCoinVideo[]
  type: 'video' | 'bookmark' | 'bangumi' | 'upvote' | 'coin'

  constructor(data: UserVideoItem[] | UserBookmarkItem[] | UserBangumiItem[] | UserUpvoteItem[] | UserCoinVideo[],
              type: 'video' | 'bookmark' | 'bangumi' | 'upvote' | 'coin') {
    this.data = data
    this.type = type
  }
}