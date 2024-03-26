import router from '@ohos.router'
import { MediaFtBean } from '../../bean/mediaFt/MediaFtBean'
import { MediaFtUrlBean } from '../../bean/mediaFt/MediaFtUrlBean'
import Constants from '../../common/Constants'
import { VideoPlay } from '../../component/VideoPlay'
import ApiMediaFt from '../../net/ApiMediaFt'
import { Utils } from '../../Utils/Utils'
import { VideoViewModel } from '../../viewModel/VideoViewModel'

@Entry
@Component
struct MediaFtPage {
  seasonId:number
  qn:number = Constants.QN
  @State videoViewModel:VideoViewModel = new VideoViewModel()
  @State url :string=''
  aboutToAppear(){
    this.seasonId = router.getParams()['seasonId']
    this.getData(this.seasonId,this.qn)
  }

  getData(seasonId:number,qn:number){
    ApiMediaFt.getMediaFtAidCidEpid(seasonId).then((response:MediaFtBean)=>{
      let avid = response.episodes[0].aid
      let cid = response.episodes[0].cid
      let epId = response.episodes[0].ep_id
      return ApiMediaFt.getMediaFtUrl(avid,cid,epId,qn)
    }).then((response:MediaFtUrlBean)=>{
      this.url = response.durl[0].url
    }).catch(err=>{
      Utils.Toast('MediaFtPage(番剧播放页面):'+err)
    })
  }

  build() {
    Column() {
      VideoPlay({videoViewModel:this.videoViewModel,url:this.url})
        .layoutWeight(1)
    }
    .width('100%')
  }
}