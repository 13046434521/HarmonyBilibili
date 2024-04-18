import { SearchDefaultDataBean } from '../bean/search/SearchDefaultBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import { AllData } from '../datasource/AllData'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'
import { ArticleItem } from './item/ArticleItem'
import { BiliUserItem } from './item/BiliUserItem'
import { LiveRoomItem } from './item/LiveRoomItem'
import { MediaBangumiItem } from './item/MediaBangumiItem'
import { MediaFtItem } from './item/MediaFtItem'
import { VideoItem } from './item/VideoItem'
import { LoadingData } from './LoadingData'
import router from '@ohos.router'
import { PageManager } from '../common/PageManager'
import { SearchVideoBean } from '../bean/search/SearchVideoBean'
import { VideoData } from '../datasource/VideoData'
import Constants from '../common/Constants'
import { LoadingType } from './Loading'
import { RefreshList, RefreshListController } from '../common/RefreshList'

@Component
export struct SearchDefaultDetails {
  @Prop search: string
  @State page: number = 1
  @Consume('defaultPageData') allData: AllData
  @State loadingStatus: LoadingStatus = LoadingStatus.LoadingSuccess
  @State videoData:VideoData = new VideoData()
  // 综合排序：totalrank
  // 最多点击：click
  // 最新发布：pubdate
  // 最多弹幕：dm
  @State orderType:'totalrank'|'click'|'pubdate'|'dm' = 'totalrank';
  @State refreshController:RefreshListController = new RefreshListController()
  @State videoRefreshController:RefreshListController = new RefreshListController()
  aboutToAppear(){
    this.refreshController
      .setLoadMoreListener(this.loadMore.bind(this))
      .setRefreshListener(this.refresh.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)
    this.videoRefreshController
      .setLoadMoreListener(this.videoLoadMore.bind(this))
      .setRefreshListener(this.videoRefresh.bind(this))
      .setCacheCount(Constants.CACHE_COUNT)
  }

  build() {
    Column(){
      this.OrderTitle()
      LoadingData({ loadingStatus: this.loadingStatus, page: this.defaultPage.bind(this),type:LoadingType.PAGE})
        .width('100%')
        .layoutWeight(1)
    }.justifyContent(FlexAlign.Start)
  }

  @Builder
  OrderTitle(){
    Column(){
      Row(){
        Text("默认排序")
          .orderTitleStyle(this.orderType==='totalrank')
          .onClick(()=>{
            this.orderRequest(this.search,'totalrank')
          })
        Text("新发布")
          .orderTitleStyle(this.orderType==='pubdate')
          .onClick(()=>{
            this.orderRequest(this.search,'pubdate')
          })
        Text("播放多")
          .orderTitleStyle(this.orderType==='click')
          .onClick(()=>{
            this.orderRequest(this.search,'click')
          })
        Text("弹幕多")
          .orderTitleStyle(this.orderType==='dm')
          .onClick(()=>{
            this.orderRequest(this.search,'dm')
          })
        Blank().layoutWeight(1)
      }.height('5%')
      .width('100%')
      .margin({left:"1%"})
      Divider().strokeWidth(1).color($r('app.color.bilibili_divider'))
    }
  }

  @Builder
  defaultPage() {
    RefreshList({refreshController:this.orderType==='totalrank'?this.refreshController:this.videoRefreshController,
      listItem:this.orderType==='totalrank'?this.listItem.bind(this):this.videoListItem.bind(this)})
      .width('100%')
      .layoutWeight(1)
  }

  @Builder
  listItem(){
    LazyForEach(this.allData, (item:SearchDefaultDataBean) => {
      Column(){
        this.defaultItem(item)
      }
    }, (item: SearchDefaultDataBean,index) => JSON.stringify(item)+index)
  }

  refresh(){
    this.page = 1
    Api.getSearchDefault(this.search, this.page+1).then((response) => {
      // 需要特殊处理
      let temp = this.allData.dealData(response.result)
      this.allData.reloadData(temp)
      this.page++
    }).catch((err) => {
      Utils.Toast('综合页面:'+err)
    })
  }

  loadMore(){
    Api.getSearchDefault(this.search, this.page+1).then((response) => {
      // 需要特殊处理
      let temp = this.allData.dealData(response.result)
      this.allData.pushDataAll(temp)
      this.page++
    }).catch((err) => {
      Utils.Toast('综合页面:'+err)
    })
  }


  @Builder
  videoListItem(){
    LazyForEach(this.videoData, (item: SearchVideoBean) => {
      Column() {
        VideoItem({ item:item }).onClick(()=>{
          PageManager.routerVideoDetail(item.bvid,item.aid)
        })
      }
    }, (item: SearchVideoBean,index) =>JSON.stringify(item)+index)
  }
  videoRefresh(){
    this.page = 1
    Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page,this.orderType).then((response) => {
      this.videoData.reloadData(response.result)
      if (response.result!=null&&this.videoData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch((err => {
      this.loadingStatus = LoadingStatus.LoadingFailure
    }))
  }
  videoLoadMore(){
    Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, this.search, this.page+1,this.orderType)
      .then((response) => {
        if (response.result!=undefined) {
          this.page++
          this.videoData.pushDataAll(response.result)
        }
      }).catch((err => {
      Utils.Toast("视频页面："+err)
    }))
  }

  @Builder
  defaultItem(item: SearchDefaultDataBean) {
    if (item.result_type === SearchType.MEDIA_BANGUMI.toString()) {
      MediaBangumiItem({ item: item })// media_id season_id
    } else if (item.result_type === SearchType.VIDEO.toString()) {
      VideoItem({ item: item }).onClick(()=>{
        PageManager.routerVideoDetail(item.bvid,item.aid)
      })
    } else if (item.result_type === SearchType.LIVE_ROOM.toString()) {
      LiveRoomItem({ item: item })//roomid
    } else if (item.result_type === SearchType.ARTICLE.toString()) {
      ArticleItem({ item: item })//mid pub_time
    } else if (item.result_type === SearchType.MEDIA_FT.toString()) {
      MediaFtItem({ item: item })// media_id
    } else if (item.result_type === SearchType.BILI_USER.toString()) {
      BiliUserItem({ item: item })  //mid,uname
    }
  }

  orderRequest(keyword:string,order:'totalrank'|'click'|'pubdate'|'dm'){
    if (this.orderType === order||this.loadingStatus===LoadingStatus.Loading) {
      return
    }
    this.loadingStatus = LoadingStatus.Loading
    this.orderType=order
    this.page=1
    if (order==='totalrank'){
      Api.getSearchDefault(keyword,this.page,'totalrank')
        .then((response) => {
          if (response.result!=undefined) {
            // 需要特殊处理
            let temp = this.allData.dealData(response.result)
            this.allData.reloadData(temp)
            this.page++
            this.loadingStatus = LoadingStatus.LoadingSuccess
          }
        }).catch((err => {
        Utils.Toast("视频页面："+err)
        this.loadingStatus = LoadingStatus.LoadingFailure
      }))
    }else{
      Api.getSearchType<SearchVideoBean>(SearchType.VIDEO, keyword, this.page,order)
        .then((response) => {
          if (response.result!=undefined) {
            this.page++
            this.videoData.reloadData(response.result)
            this.loadingStatus = LoadingStatus.LoadingSuccess
          }
        }).catch((err => {
        Utils.Toast("视频页面："+err)
        this.loadingStatus = LoadingStatus.LoadingFailure
      }))
    }
  }
}

@Extend(Text)
function orderTitleStyle(select:boolean){
  .height('100%')
  .textAlign(TextAlign.Center)
  .padding({left:"2%",right:'2%'})
  .fontSize(14)
  .fontColor(select?$r('app.color.bilibili_theme'):$r('app.color.bilibili_text_grey_bold'))
}