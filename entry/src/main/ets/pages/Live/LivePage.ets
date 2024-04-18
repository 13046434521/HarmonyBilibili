import router from '@ohos.router'
import { LiveBean, LiveUrlBean } from '../../bean/Live/LiveBean'
import Constants from '../../common/Constants'
import { RouterConstants } from '../../common/PageManager'
import { VideoPlay } from '../../component/VideoPlay'
import  ApiLiving  from '../../net/ApiLiving'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import window from '@ohos.window'

@Entry
@Component
struct LivePage {
  roomId:number
  @State liveUrl:LiveUrlBean = new LiveUrlBean()
  videoController:VideoController = new VideoController()
  @State url :string=''
  @StorageProp('background_color') backgroundColors :string = Constants.BACKGROUND_DAY
  aboutToAppear(){
    if (router.getParams()!=undefined) {
      this.roomId = router.getParams()[RouterConstants.LIVE_ID]
    }

    ApiLiving.getLive(this.roomId).then((item:LiveBean)=>{
      this.liveUrl = item.durl[0]
      this.url = this.liveUrl.url
    })
  }
  build() {
    Column() {
      VideoPlay({videoController:this.videoController,url:this.url})
        .layoutWeight(1)
    }.backgroundColor(this.backgroundColors)
    .width('100%')
  }

  onBackPress(){
    if (this.videoController.videoModel.orientation === window.Orientation.LANDSCAPE){
      this.videoController.changeOrientation()
      return true
    }
  }
}