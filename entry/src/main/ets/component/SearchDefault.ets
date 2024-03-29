/**
 MediaCodec class can be used to access low-level media codecs, i.e. encoder/decoder components.
 It is part of the Android low-level multimedia support infrastructure (normally used together
 with {@link MediaExtractor}, {@link MediaSync}, {@link MediaMuxer}, {@link MediaCrypto},
 {@link MediaDrm}, {@link Image}, {@link Surface}, and {@link AudioTrack}.)
 <p>
 <center>
 <img src="https://upload-images.jianshu.io/upload_images/5872452-51f25da88cc1a5c8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp" style="width: 540px; height: 205px"
 alt="MediaCodec buffer flow diagram">
 </center>
 <p>
 */
import { SearchDefaultDataBean } from '../bean/SearchDefaultBean'
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

@Component
export struct SearchDefaultDetails {
  @Prop search: string
  @State page: number = 1
  @Consume('defaultPageData') allData: AllData

  aboutToAppear() {

  }


  build() {
    this.defaultPage()
  }

  @Builder
  defaultPage() {
    List() {
      LazyForEach(this.allData, (item:SearchDefaultDataBean) => {
        ListItem(){
          this.defaultItem(item)
        }
      }, (item: SearchDefaultDataBean,index) => JSON.stringify(item)+index)
    }.width('100%')
    .layoutWeight(1)
    .onReachEnd(()=>{
      Api.getSearchDefault(this.search, this.page+1).then((response) => {
        // 需要特殊处理
        let temp = this.allData.dealData(response.result)
        this.allData.pushDataAll(temp)
        this.page++
      }).catch(() => {
        Utils.Toast('综合页面没有数据了')
      })
    })
  }

  @Builder
  defaultItem(item: SearchDefaultDataBean) {
    if (item.result_type === SearchType.MEDIA_BANGUMI.toString()) {
      MediaBangumiItem({ item: item })// media_id season_id
    } else if (item.result_type === SearchType.VIDEO.toString()) {
      VideoItem({ item: item }).onClick(()=>{
        PageManager.routerVideoDetail(item.bvid)
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
}