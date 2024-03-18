import Api from '../net/Api'
import { Loading } from './LoadingComponent'
import { SearchVideoBean } from '../bean/SearchVideoBean'
import { Utils } from '../Utils/Utils'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { LoadingData } from './LoadingData'
import { VideoItem } from './item/VideoItem'
import { VideoData } from '../datasource/VideoData'

@Component
export struct SearchVideoDetails {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string =""
  @State page: number = 1
  @State isRefreshing: boolean = false
  @State errMessage:string = ''
  @State videoData:VideoData = new VideoData()
  aboutToAppear() {
    this.initPage()
  }

  initPage() {
    this.page = 1
    Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page).then((response) => {
      this.videoData.pushDataAll(response.result)

      if (response.result!=null&&this.videoData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }

    }).catch((err => {
      this.loadingStatus =LoadingStatus.LoadingFailure
      Utils.Toast(err+"")
      this.errMessage = err
    }))
  }

  build() {
    LoadingData({loadingStatus :this.loadingStatus,page:this.biliVideo.bind(this)})
      .width('100%')
      .height('100%')
  }


  @Builder
  biliVideo() {
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      List() {
        LazyForEach(this.videoData, (item: SearchVideoBean) => {
          ListItem() {
            VideoItem({ item:item }).onClick(()=>{
              router.pushUrl({url:'pages/VideoDetailPage',params:{'bvid':item.bvid,'cid':0}})
            })
          }
        }, (item: SearchVideoBean) =>item.id+item.title)
      }
      .onReachEnd(() => {
        Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page+1)
          .then((response) => {
          if (response.result!=undefined) {
            this.page++
            this.videoData.pushDataAll(response.result)
          }
        }).catch((err => {
          Utils.Toast("视频页面："+err)
        }))
      })
    }.onRefreshing(() => {
      this.page = 1
      Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page).then((response) => {
        this.videoData.pushDataAll(response.result)

        if (response.result!=null&&this.videoData.totalCount()!=0) {
          this.loadingStatus = LoadingStatus.LoadingSuccess
        }else{
          this.loadingStatus = LoadingStatus.LoadingOther
        }
        this.isRefreshing = false
      }).catch((err => {
        this.isRefreshing = false
      }))
    })
    .width('100%')
    .layoutWeight(1)
  }
}