import CommentsViewModel from '../viewModel/CommentsViewModel'
import { Utils } from '../Utils/Utils'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading, LoadingType } from '../component/Loading'
import { LoadingData } from '../component/LoadingData'
import { CommentsData } from '../datasource/CommentsData'
import { CommentsItem } from '../component/item/CommentsItem'
import Constants from '../common/Constants'
import { RefreshList, RefreshListController } from '../common/RefreshList'
import { CommentsReply } from '../bean/CommentsInfo'

@Component
export struct BiliComments {
  @Prop aid: number = 0
  commentViewModel: CommentsViewModel = new CommentsViewModel()
  commentType: 2 | 3 = 3
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @State err: string = ''
  @State page:number = 1
  @State commentsData:CommentsData = new CommentsData()
  @State refreshController:RefreshListController = new RefreshListController()
  aboutToAppear(){
    this.refreshController
      .setCacheCount(Constants.CACHE_COUNT)
      .setRefreshListener(this.refresh.bind(this))
      .setLoadMoreListener(this.load.bind(this))

    this.refresh()
  }

  build() {
    LoadingData({ loadingStatus: this.loadingStatus, page: this.Comments.bind(this), type: LoadingType.PAGE, extraFailure: this.err, reload: this.refresh.bind(this) })
  }

  @Builder
  Comments() {
    RefreshList({refreshController:this.refreshController,title:this.title.bind(this),listItem:this.listItem.bind(this)})
      .layoutWeight(1)
    .width('100%')
  }

  @Builder
  title() {
    Row() {
      Text(this.commentType === 3 ? "热门评论" : "最新评论")
        .fontSize(16)
        .fontColor($r('app.color.bilibili_text_black_middle'))
      Text(this.commentType === 3 ? "按热度" : "按时间")
        .fontSize(14)
        .fontColor($r('app.color.bilibili_text_grey_light'))
    }.alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({left:'2%',right:'2%'})
    .margin({bottom:'2%'})
  }

  @Builder
  listItem(){
    LazyForEach(this.commentsData, (reply:CommentsReply) => {
      Column() {
        CommentsItem({commentsReply:reply})
      }
    },(reply:string,index)=>JSON.stringify(reply)+index)
  }

  refresh(){
    this.page = 1
    this.commentViewModel.commentsInfo(this.aid, this.commentType,this.page)
      .then((commentInfo) => {
        // 刷新成功，清空已有数据
        if (Utils.isNonNull(commentInfo.top_replies)||Utils.isNonNull(commentInfo.replies)) {
          this.commentsData.cleanData()
        }else{
          // 没有数据，隐藏loadmore
          this.refreshController.isLoadMore = false
        }

        if (Utils.isNonNull(commentInfo.top_replies)) {
          this.commentsData.pushDataAll(commentInfo.top_replies)
        }
        if (Utils.isNonNull(commentInfo.replies)) {
          this.commentsData.pushDataAll(commentInfo.replies)
        }

        this.loadingStatus = LoadingStatus.LoadingSuccess
      }).catch((err:Error) => {
      this.err = err.message
      this.loadingStatus = LoadingStatus.LoadingOther
    })
  }

  load(){
    this.page = 1
    this.commentViewModel.commentsInfo(this.aid, this.commentType,this.page)
      .then((commentInfo) => {

        if (!Utils.isNonNull(commentInfo.top_replies) && !Utils.isNonNull(commentInfo.replies)) {
          // 两个都为null时，没有数据，隐藏loadmore
          this.refreshController.isLoadMore = false
        }else{
          // 两个有一个有数据，加载数据
          if (Utils.isNonNull(commentInfo.top_replies)) {
            this.commentsData.pushDataAll(commentInfo.top_replies)
          }
          if (Utils.isNonNull(commentInfo.replies)) {
            this.commentsData.pushDataAll(commentInfo.replies)
          }
        }
      }).catch((err:Error)=>{
      this.err = err.message
    })
  }
}