import Api from '../net/Api'
import { Loading } from './LoadingComponent'
import { SearchVideoItemBean } from '../bean/SearchVideoBean'
import { Utils } from '../Utils/Utils'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { LoadingData } from './LoadingData'

@Component
export struct SearchVideoDetails {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string =""
  @State page: number = 1
  @State searchDetailsItemBean: Array<SearchVideoItemBean> = []
  @State isRefreshing: boolean = false
  @State errMessage:string = ''
  aboutToAppear() {
    console.log("视频 页面刷新了")
    this.initPage()
  }
  aboutToDisappear(){
    console.log("视频 页面销毁了")
  }
  initPage() {
    this.page = 1
    Api.getSearchType<SearchVideoItemBean>(SearchType.VIDEO, this.search, this.page).then((searchDetailsBean) => {
      this.searchDetailsItemBean = searchDetailsBean.result
      if (this.searchDetailsItemBean!=null&&this.searchDetailsItemBean.length!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }

    }).catch((err => {
      this.loadingStatus =LoadingStatus.LoadingFailure
      Utils.Toast(err+"")
      this.errMessage = err
    }))
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.biliVideo.bind(this),extraFailure:"Search视频",extraSuccess:'Search视频'})
  }

  @Builder
  VideoItem(item: SearchVideoItemBean) {
    Column() {
      Divider().color($r('app.color.bilibili_divider'))
        .margin({ left: 5, right: 5 })
      Row() {
        Stack() {
          Image(`https:${item.pic}`)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Auto)
            .borderRadius(5)
            .alt($r('app.media.ic_placeholder'))
          Text(Utils.TimeDeal(item.duration))
            .maxLines(1)
            .margin({ bottom: 4, right: 8 })
            .fontSize(12)
            .backgroundColor(Color.Grey)
            .fontColor(Color.White)
            .borderRadius(4)
            .padding(4)
            .opacity(0.8)

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
    }.onClick(()=>{
      router.pushUrl({url:'pages/VideoDetailPage',params:{'bvid':item.bvid,'cid':0}})
    })
  }

  @Builder
  biliVideo() {
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      List() {
        ForEach(this.searchDetailsItemBean, (item: SearchVideoItemBean) => {
          ListItem() {
            this.VideoItem(item)
          }
        })
      }
      .onReachEnd(() => {
        Api.getSearchType<SearchVideoItemBean>(SearchType.VIDEO, this.search, this.page+1)
          .then((response) => {
          if (response.result!=undefined) {
            this.page++
            this.searchDetailsItemBean = this.searchDetailsItemBean.concat(response.result)
          }
        }).catch((err => {
          Utils.Toast("视频页面："+err)
        }))
      }).width('100%')
      .layoutWeight(1)
    }.onRefreshing(() => {
      this.page = 1
      Api.getSearchType<SearchVideoItemBean>(SearchType.VIDEO, this.search, this.page).then((searchDetailsBean) => {
        this.searchDetailsItemBean = searchDetailsBean.result
        if (this.searchDetailsItemBean!=null&&this.searchDetailsItemBean.length!=0) {
          this.loadingStatus = LoadingStatus.LoadingSuccess
        }else{
          this.loadingStatus = LoadingStatus.LoadingOther
        }
        this.isRefreshing = false
      }).catch((err => {
        this.isRefreshing = false
      }))
    })
    .width('100%')
    .layoutWeight(1)
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