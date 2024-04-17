import CommentsViewModel from '../viewModel/CommentsViewModel'
import router from '@ohos.router'
import { RouterConstants } from '../common/PageManager'
import { Utils } from '../Utils/Utils'
import { showDialog } from '../Utils/DialogUtil'
import CommentsInfo, { CommentsReply } from '../bean/CommentsInfo'
import { LoadingStatus } from '../common/LoadingStatus'
import { Loading, LoadingType } from '../component/Loading'
import { LoadingData } from '../component/LoadingData'
import { CommentsData } from '../datasource/CommentsData'
import { VideoData } from '../datasource/VideoData'
import { CommentsItem } from '../component/item/CommentsItem'
import Constants from '../common/Constants'

@Component
export struct BiliComments {
  @Prop aid: number = 0
  commentViewModel: CommentsViewModel = new CommentsViewModel()
  commentType: 2 | 3 = 3
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @State err: string = ''
  // @State commentsData: VideoData = new VideoData()
  @State commentsData:CommentsData = new CommentsData()
  aboutToAppear(){
    this.getCommentsInfo()
  }

  build() {
    LoadingData({ loadingStatus: this.loadingStatus, page: this.Comments.bind(this), type: LoadingType.PAGE, extraFailure: this.err, reload: this.getCommentsInfo.bind(this) })
  }

  @Builder
  Comments() {
    List() {
      ListItemGroup({ header: this.title()}) {
        LazyForEach(this.commentsData, (reply) => {
          ListItem() {
            CommentsItem({commentsReply:reply})
          }
        },(reply,index)=>JSON.stringify(reply)+index)
      }
    }.height('100%')
    .width('100%')
    .cachedCount(Constants.CACHE_COUNT)
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

  getCommentsInfo() {
    this.commentViewModel.commentsInfo(this.aid, this.commentType)
      .then((commentInfo) => {
/*        if (Utils.isNonNull(commentInfo.top.upper)) {
          this.commentsData.pushData(commentInfo.top.upper)
        }*/
        if (Utils.isNonNull(commentInfo.top_replies)) {
          this.commentsData.pushDataAll(commentInfo.top_replies)
        }
        if (Utils.isNonNull(commentInfo.replies)) {
          this.commentsData.pushDataAll(commentInfo.replies)
        }

        this.loadingStatus = LoadingStatus.LoadingSuccess
      }).catch(err => {
      this.err = err
      this.loadingStatus = LoadingStatus.LoadingOther
    })
  }
}