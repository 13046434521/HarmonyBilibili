import { UserVideoBean, UserVideoItem } from '../../bean/biliUser/UserVideoBean'
import { Utils } from '../../Utils/Utils'
import { BiliUserViewModel } from '../../viewModel/biliUser/BiliUserViewModel'
import { PageManager } from '../../common/PageManager'
import { UserVideoData } from '../../datasource/UserVideoData'
import Constants from '../../common/Constants'

@Component
export struct BiliUserVideo{
  mid:number = 0
  @State state:string = ''
  @Prop userVideoBean: UserVideoBean
  biliUserViewModel:BiliUserViewModel
  userVideoData:UserVideoData = new UserVideoData()
  order:'pubdate' | 'click' | 'stow' = 'pubdate'
  page = 1
  aboutToAppear(){
    if (Utils.isNonNull(this.userVideoBean)&&Utils.isNonNull(this.userVideoBean.list)) {
      this.userVideoData.addDataAll(this.userVideoBean.list.vlist)
    }
  }

  build(){
    this.VideoView()
  }
  /*------------------------------------------- 视频 --------------------------------------------*/
  @Builder
  VideoView() {
    List(){
      LazyForEach(this.userVideoData,(video: UserVideoItem)=>{
        this.VideoItem(video)
      },(item,index)=>JSON.stringify(item)+index)
    }.lanes(1)
    .cachedCount(Constants.CACHE_COUNT)
    .onReachEnd(()=>{
      this.biliUserViewModel.getUserVideoData(this.mid,this.order,this.page+1).then(item=>{
        this.page++
        this.userVideoData.pushDataAll(item.list.vlist)
      })
    }).width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bilibili_background_grey'))
    .scrollBar(BarState.Off)
  }

  @Builder VideoItem(video:UserVideoItem){
    Column() {
      Row() {
        Stack() {
          Image(video.pic)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(5)
            .alt($r('app.media.ic_placeholder'))
            .interpolation(ImageInterpolation.High)

          Text(video.length)
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
          Text(video.title)
            .maxLines(2)
            .fontColor($r("app.color.bilibili_text_black_light"))
            .fontSize(16)
            .letterSpacing(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)

          Text(Utils.timestampToDate(video.created))
            .textStyle().margin({bottom:'1%'})

          Row() {
            Image($r('app.media.ic_detail_play'))
              .imageStyle()
            Text(Utils.Views(video.play))
              .textStyle()
            Image($r("app.media.ic_danmakus_dark"))
              .imageStyle()
              .margin({ left: '2%' })
            Text(Utils.Views(video.video_review))
              .textStyle()
            Blank()
              .layoutWeight(1)
            Image($r('app.media.ic_more_vertical'))
              .imageStyle()
              .onClick(() => {
                AlertDialog.show(
                  {
                    message: video.description,
                    autoCancel: true,
                    alignment: DialogAlignment.Bottom,
                    gridCount: 50,
                    offset: { dx: 0, dy: -5 },
                  }
                )
              })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding('1%')
        .layoutWeight(1)

      }.justifyContent(FlexAlign.Start)
      .width('100%')
      .height('12%')

      Divider().color($r('app.color.bilibili_divider'))
        .margin({ left: '1%', right: '1%' })
        .strokeWidth(1)
    }
    .onClick(event=>{
      PageManager.routerVideoDetail(video.bvid)
    })
  }
}

@Extend(Image)
function imageStyle() {
  .height('15%')
  .aspectRatio(1)
  .objectFit(ImageFit.Cover)
  .interpolation(ImageInterpolation.High)
}

@Extend(Text)
function textStyle() {
  .fontSize(14)
  .fontColor(Color.Grey)
  .maxLines(1)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .margin({ left: '1%' })
}
