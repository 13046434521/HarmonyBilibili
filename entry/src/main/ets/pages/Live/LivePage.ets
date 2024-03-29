import router from '@ohos.router'
import { LiveBean, LiveUrlBean } from '../../bean/Live/LiveBean'
import Constants from '../../common/Constants'
import { VideoPlay } from '../../component/VideoPlay'
import  ApiLiving  from '../../net/ApiLiving'
import { VideoViewModel } from '../../viewModel/VideoViewModel'

@Entry
@Component
struct LivePage {
  roomId:number
  @State liveUrl:LiveUrlBean = new LiveUrlBean()
  @State videoViewModel:VideoViewModel = new VideoViewModel()
  @State url :string=''
  @StorageProp('background_color') backgroundColors :string = Constants.BACKGROUND_DAY
  aboutToAppear(){
    this.roomId = router.getParams()['roomId']

    ApiLiving.getLive(this.roomId).then((item:LiveBean)=>{
      this.liveUrl = item.durl[0]
      this.url = this.liveUrl.url
    })
  }
  build() {
    Column() {
      VideoPlay({videoViewModel:this.videoViewModel,url:this.url})
        .layoutWeight(1)
    }.backgroundColor(this.backgroundColors)
    .width('100%')
  }
}