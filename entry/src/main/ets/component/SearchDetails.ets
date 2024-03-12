import Api from '../net/Api'
import { Loading } from './LoadingComponent'
import { SearchDetailsItemBean } from '../bean/SearchDetailsBean'
import { Utils } from '../Utils/Utils'
import { SearchRequest } from '../common/SearchRequest'

@Component
export struct SearchVideoDetails {
  @State isLoading: number = 0 // 为0时正在加载，1时加载成功,-1加载失败
  @Link search: string
  @State page: number = 1
  @State searchDetailsItemBean: Array<SearchDetailsItemBean> = []
  @State isRefreshing: boolean = false

  @Prop @Watch('initPage') searchRequest: string

  aboutToAppear() {
    this.initPage()
  }

  initPage() {
    this.page = 1
    Api.getSearchDetails('video', this.search, this.page).then((searchDetailsBean) => {
      this.isLoading = 1
      this.searchDetailsItemBean = searchDetailsBean.result
    }).catch((err => {
      this.isLoading = -1
    }))
  }

  build() {
    Column() {
      if (this.isLoading === 0) {
        Loading().layoutWeight(1)
      } else if (this.isLoading === 1) {
        this.Refresh()
      } else {
        Text("加载出错")
          .width('100%')
          .height('100%')
      }
    }.width('100%')
    .height('100%')
  }

  @Builder
  VideoItem(item: SearchDetailsItemBean) {
    Column() {
      Divider().color(Color.Grey)
        .margin({ left: 5, right: 5 })
      Row() {
        Stack() {
          Image(`https:${item.pic}`)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Auto)
            .borderRadius(5)
          Text(item.duration)
            .maxLines(1)
            .margin({ bottom: 4, right: 8 })
            .fontSize(12)
            .backgroundColor(Color.Grey)
            .fontColor(Color.White)
            .borderRadius(8)
            .padding(8)

        }.width('50%')
        .padding(12)
        .align(Alignment.BottomEnd)


        Column() {
          Text(Utils.upRichTextClear(item.title))
            .maxLines(2)
            .fontColor(Color.Black)
            .fontSize(14)
            .letterSpacing(1)
            .maxFontSize(16)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .margin({ left: 8 })
            .align(Alignment.TopStart)
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)
            .margin(15)
          Row() {
            Image($r('app.media.icon_playlist_upper'))
              .imageStyle()
            Text(item.author)
              .textStyle()
          }.margin({ left: 8, bottom: 4 })

          Row() {
            Image($r('app.media.ic_detail_play'))
              .imageStyle()

            Text(Utils.Views(item.play))
              .textStyle()

            Image($r("app.media.ic_danmakus_dark"))
              .imageStyle()
              .margin({ left: 8, right: 8 })
            Text(Utils.Views(item.danmaku))
              .textStyle()
            Blank()
              .layoutWeight(1)
            Image($r('app.media.ic_more_vertical'))
              .imageStyle()
              .onClick(() => {
                AlertDialog.show(
                  {
                    message: item.description,
                    autoCancel: true,
                    alignment: DialogAlignment.Bottom,
                    gridCount: 50,
                    offset: { dx: 0, dy: -5 },
                  }
                )
              })

          }.margin({ left: 8, bottom: 8, top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 12, bottom: 4 })
        .layoutWeight(1)

      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .aspectRatio(16 / 5)
    }
  }

  @Builder
  Refresh() {
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      List() {
        ForEach(this.searchDetailsItemBean, (item: SearchDetailsItemBean) => {
          ListItem() {
            this.VideoItem(item)
          }
        })
      }
      .onReachEnd(() => {
        console.log('onReachEnd 前:getSearchDetails' + this.searchDetailsItemBean[0].title)
        Api.getSearchDetails('video', this.search, ++this.page).then((searchDetailsBean) => {
          this.searchDetailsItemBean = this.searchDetailsItemBean.concat(searchDetailsBean.result)
        }).catch((err => {
          // 错误代码
          console.log('onReachEnd :' + err)
        }))
      }).width('100%')
      .layoutWeight(1)
    }.onRefreshing(() => {
      this.page = 1
      Api.getSearchDetails('video', this.search, this.page).then((searchDetailsBean) => {
        this.searchDetailsItemBean = searchDetailsBean.result
        this.isRefreshing = false
      }).catch((err => {
        this.isRefreshing = false
      }))
    })
    .width('100%')
    .layoutWeight(1)
  }

  request(request1: () => void) {
    request1 = () => {
      Api.getSearchDetails('video', this.search, this.page).then((searchDetailsBean) => {
        this.isLoading = 1
        this.searchDetailsItemBean = searchDetailsBean.result
      }).catch((err => {
        this.isLoading = -1
      }))
    }
  }
}


@Extend(Image)
function imageStyle() {
  .height(14)
  .width(14)
  .margin({ right: 8 })
  .objectFit(ImageFit.Auto)
}

@Extend(Text)
function textStyle() {
  .fontSize(12)
  .fontColor(Color.Grey)
  .maxLines(1)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
}