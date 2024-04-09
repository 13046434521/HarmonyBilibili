import router from '@ohos.router'
import Api from '../../net/Api'
import { PageListDimensionBean } from '../../bean/PageListBean'
import { LoadingStatus } from '../../common/LoadingStatus'
import { PlayVideoBean } from '../../bean/PlayVideoBean'
import { VideoPlay } from '../../component/VideoPlay'
import { VideoController } from '../../viewModel/videoPlayer/VideoController'
import window from '@ohos.window'
import { RouterConstants } from '../../common/PageManager'

@Entry
@Component
struct DetailPage {
  @State bvid: string = ""
  @State cid: number = 0
  @State loadingPage:LoadingStatus = LoadingStatus.Loading;
  @State dimension :PageListDimensionBean = null
  @State url :string=''
  videoController: VideoController = new VideoController()

  aboutToAppear() {
    if (router.getParams()!=null) {
      this.bvid = router.getParams()[RouterConstants.BVID]
      this.cid = router.getParams()[RouterConstants.CID]
    }
/*    videoController.loadVideoData(this.bvid){

    }*/
    // cid 为0时，需要单独获取cid
    if (this.cid === 0) {
      Api.getPageList(this.bvid).then((item)=>{
        this.cid = item[0].cid
        this.dimension = item[0].dimension

        return Api.getPlayVideo(this.bvid,this.cid)
      }).then((item:PlayVideoBean)=>{
        this.url = item.durl[0].url
        this.loadingPage = LoadingStatus.LoadingSuccess
      }).catch(err=>{
        this.loadingPage = LoadingStatus.LoadingFailure
      })
    }else{
      Api.getPlayVideo(this.bvid,this.cid)
        .then((item:PlayVideoBean)=>{
          this.url = item.durl[0].url
          this.loadingPage = LoadingStatus.LoadingSuccess
        }).catch(err=>{
          this.loadingPage = LoadingStatus.LoadingFailure
        })
    }
  }

  onPageHide(){
    this.videoController.pause()
  }

  onPageShow(){
    this.videoController.play()
  }

  aboutToDisappear(){
    this.videoController.release('VideoDetailPage')
  }
@State volume:number = 0
  build() {
    Column() {
      VideoPlay({url:this.url,videoController:this.videoController})

      Button('亮度255').onClick(()=>{
        window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
          data.setWindowBrightness(1)
        });

      })

      Button("亮度0").onClick(()=>{
        window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
          data.setWindowBrightness(0)
        });
      })

      Button("亮度:"+ this.volume).onClick(()=>{
        window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
          this.volume = data.getWindowProperties().brightness
        });
      })

      Button('声音15').onClick(()=>{
        this.videoController.adjustVolume(15)
      })

      Button("声音0").onClick(()=>{
        this.videoController.adjustVolume(0)
      })

      Button("声音:"+ this.volume).onClick(()=>{
        this.videoController.getVolume().then((num)=>{
          this.volume = num
        })
      })

    }.width('100%')
    .justifyContent(FlexAlign.Start)
  }
}
