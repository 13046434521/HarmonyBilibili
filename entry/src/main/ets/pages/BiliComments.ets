import CommentsViewModel from '../viewModel/CommentsViewModel'
import router from '@ohos.router'
import { RouterConstants } from '../common/PageManager'
import { Utils } from '../Utils/Utils'
import { showDialog } from '../Utils/DialogUtil'

@Component
export struct BiliComments{
  commentViewModel :CommentsViewModel = new CommentsViewModel()
  commentType :2|3 = 2
  @Prop aid:number = 0

  aboutToAppear(){
    // this.aid = router.getParams()[RouterConstants.AID]
    // this.aid = 450096728

    this.commentViewModel.commentsInfo(this.aid,this.commentType)
      .then(()=>{
        
      })
  }

  build(){

  }
}