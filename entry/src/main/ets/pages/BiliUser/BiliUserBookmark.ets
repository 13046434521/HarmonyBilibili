import { UserBangumi, UserBangumiItem } from '../../bean/biliUser/UserBangumi'
import { UserBookmark, UserBookmarkItem } from '../../bean/biliUser/UserBookmark'
import { UserCoinVideo } from '../../bean/biliUser/UserCoinVideo'
import { UserUpvote, UserUpvoteItem } from '../../bean/biliUser/UserUpvote'
import { UserVideoBean, UserVideoItem } from '../../bean/biliUser/UserVideoBean'
import { Utils } from '../../Utils/Utils'
import { BiliUserViewModel } from '../../viewModel/biliUser/BiliUserViewModel'
import router from '@ohos.router'
import { PageManager } from '../../common/PageManager'
import { UserBookmarkData } from '../../datasource/UserBookmarkData'
import Constants from '../../common/Constants'
import FaultLogger from '@ohos.faultLogger'
import { LoadingData } from '../../component/LoadingData'
import { LoadingStatus } from '../../common/LoadingStatus'

@Component
export struct BiliUserBookmark{
  mid:number = 0
  @Prop userBookmark: UserBookmark
  biliUserViewModel:BiliUserViewModel
  userBookmarkData:UserBookmarkData = new UserBookmarkData()
  page:number = 1
  @State loadingStatus :LoadingStatus = LoadingStatus.LoadingOther
  aboutToAppear(){
    if (Utils.isNonNull(this.userBookmark)&&Utils.isNonNull(this.userBookmark.list)) {
      this.userBookmarkData.addDataAll(this.userBookmark.list)
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }else{
      this.loadingStatus = LoadingStatus.LoadingOther
    }
  }

  build() {
    LoadingData({loadingStatus:this.loadingStatus,page:this.BookmarkView.bind(this),reload:()=>{
      this.loadingStatus = LoadingStatus.Loading
      this.page= 1
      this.biliUserViewModel.getUserBookmarksData(this.mid).then(item=>{
        if (Utils.isNonNull(item)) {
          this.page++
          this.userBookmarkData.reloadData(item.list)
          this.loadingStatus = LoadingStatus.LoadingSuccess
        }else{
          this.loadingStatus = LoadingStatus.LoadingOther
        }

      }).catch(err=>{
        this.loadingStatus = LoadingStatus.LoadingFailure
      })
    }})
  }
  /*------------------------------------------- 收藏 --------------------------------------------*/
  @Builder
  BookmarkView() {
    List(){
      LazyForEach(this.userBookmarkData,(bookmark: UserBookmarkItem)=>{
        this.BookmarkItem(bookmark)
      },(item,index)=>JSON.stringify(item)+index)
    }.lanes(1)
    .cachedCount(12)
    .onReachEnd(()=>{
      this.biliUserViewModel.getUserBookmarksData(this.mid,this.page+1,20).then(item=>{
        this.page++
        this.userBookmarkData.pushDataAll(item.list)
      })
    }).width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bilibili_background_grey'))
    .scrollBar(BarState.Off)
  }

  @Builder BookmarkItem(bookmark:UserBookmarkItem){
    Column() {
      Row() {
        Image(bookmark.cover)
          .objectFit(ImageFit.Cover)
          .borderRadius(5)
          .alt($r('app.media.ic_placeholder'))
          .interpolation(ImageInterpolation.High)
          .height('100%')
          .aspectRatio(Constants.DEFAULT_ASPECT_RATIO)
          .margin('1%')

        Column() {
          Text(bookmark.title)
            .maxLines(2)
            .fontColor($r("app.color.bilibili_text_black_light"))
            .fontSize(16)
            .letterSpacing(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('90%')
            .fontWeight(FontWeight.Bold)

          Blank().layoutWeight(1)

          Text(bookmark.media_count+'个内容')
            .maxLines(1)
            .fontColor($r("app.color.bilibili_text_grey_light"))
            .fontSize(14)
            .letterSpacing(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({bottom:'1%'})
        }
        .alignItems(HorizontalAlign.Start)
        .padding('1%')
        .layoutWeight(1)

      }.justifyContent(FlexAlign.Start)
      .height('90%')
      .width('100%')

      Divider().color($r('app.color.bilibili_divider'))
        .vertical(false)
        .margin({ left: '1%', right: '1%' })
        .strokeWidth(1)
        .layoutWeight(1)
    }.width('100%')
    .height('20%')
    .onClick(event=>{
      Utils.Toast("收藏夹："+bookmark.title +'  id:'+bookmark.id+ '  fid'+bookmark.fid)
    }).margin({top:'1%',bottom:'1%'})
  }


}

@Extend(Text) function textSizeStyle(){
  .fontSize(14)
  .fontColor(Color.White)
}

@Extend(Text) function titleStyle(){
  .fontColor($r('app.color.bilibili_text_grey_light'))
}
