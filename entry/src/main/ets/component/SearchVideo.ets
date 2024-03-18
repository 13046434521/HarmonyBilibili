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

@Component
export struct SearchVideoDetails {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string =""
  @State page: number = 1
  @State searchDetailsItemBean: Array<SearchVideoBean> = []
  @State isRefreshing: boolean = false
  @State errMessage:string = ''
  aboutToAppear() {
    console.log("视频 页面刷新了")
    this.initPage()
  }
  aboutToDisappear(){
    console.log("视频 页面销毁了")
  }
  initPage() {
    this.page = 1
    Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page).then((searchDetailsBean) => {
      this.searchDetailsItemBean = searchDetailsBean.result
      if (this.searchDetailsItemBean!=null&&this.searchDetailsItemBean.length!=0) {
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
        ForEach(this.searchDetailsItemBean, (item: SearchVideoBean) => {
          ListItem() {
            VideoItem({ item:item }).onClick(()=>{
              router.pushUrl({url:'pages/VideoDetailPage',params:{'bvid':item.bvid,'cid':0}})
            })
          }
        })
      }
      .onReachEnd(() => {
        Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page+1)
          .then((response) => {
          if (response.result!=undefined) {
            this.page++
            this.searchDetailsItemBean = this.searchDetailsItemBean.concat(response.result)
          }
        }).catch((err => {
          Utils.Toast("视频页面："+err)
        }))
      }).width('100%')
      .layoutWeight(1)
    }.onRefreshing(() => {
      this.page = 1
      Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page).then((searchDetailsBean) => {
        this.searchDetailsItemBean = searchDetailsBean.result
        if (this.searchDetailsItemBean!=null&&this.searchDetailsItemBean.length!=0) {
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