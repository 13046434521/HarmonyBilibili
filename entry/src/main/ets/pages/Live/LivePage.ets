import router from '@ohos.router'
import { LiveBean, LiveUrlBean } from '../../bean/Live/LiveBean'
import { VideoPlay } from '../../component/VideoPlay'
import  ApiLiving  from '../../net/ApiLiving'
import VideoModel from '../../viewModel/VideoModel'
import { VideoViewModel } from '../../viewModel/VideoViewModel'

@Entry
@Component
struct LivePage {
  roomId:number
  @State liveUrl:LiveUrlBean = new LiveUrlBean()
  @State videoViewModel:VideoViewModel = new VideoViewModel()
  @State url :string=''
  aboutToAppear(){
    this.roomId = router.getParams()['roomId']

    ApiLiving.getLive(this.roomId).then((item:LiveBean)=>{
      this.liveUrl = item.durl[0]
      this.url = this.liveUrl.url
    })
  }
  build() {
    Column() {
      VideoPlay({videoViewModel:this.videoViewModel,videoModel:this.videoViewModel.videoModel,url:this.url})
        .layoutWeight(1)
    }
    .width('100%')
  }
}