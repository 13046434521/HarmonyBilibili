import router from '@ohos.router'
import { LiveBean, LiveUrlBean } from '../../bean/Live/LiveBean'
import Constants from '../../common/Constants'
import { LIVE_ID, RouterConstants } from '../../common/PageManager'
import { VideoPlay } from '../../component/play/VideoPlay'
import  ApiLiving  from '../../net/ApiLiving'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import window from '@ohos.window'
import { LivePlay } from '../../component/play/LivePlay'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct LivePage {
  roomId?:number
  @State liveUrl:LiveUrlBean = new LiveUrlBean()
  videoController:VideoController = new VideoController()
  @State url :string=''
  @StorageProp('background_color') backgroundColors :string = Constants.BACKGROUND_DAY
  aboutToAppear(){
    if (router.getParams()!=undefined) {
      let params = router.getParams() as LIVE_ID
      this.roomId = params.liveId
    }
    this.videoController.isShowAttachments = false

    ApiLiving.getLive(this.roomId).then((item:LiveBean)=>{
      this.liveUrl = item.durl[0]
      this.url = this.liveUrl.url
    })
  }

  build() {
    Column() {
      LivePlay({videoController:this.videoController,url:this.url})
        .layoutWeight(1)
    }.backgroundColor(this.backgroundColors)
    .width('100%')
  }

  onBackPress(): void | boolean{
    if (this.videoController.videoModel.orientation === window.Orientation.LANDSCAPE){
      let context = getContext(this) as common.UIAbilityContext;
      this.videoController.changeOrientation(context)
      return true
    }
  }
}