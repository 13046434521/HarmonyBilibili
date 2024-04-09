import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { LoadingData } from './LoadingData'
import { SearchBiliUserBean } from '../bean/search/SearchBiliUserBean'
import { Utils } from '../Utils/Utils'
import { BiliUserItem } from './item/BiliUserItem'
import { BiliUserData } from '../datasource/BiliUserData'
import Constants from '../common/Constants'

@Component
export struct SearchBiliUserDetails {
  @State message: string = '用户'
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string = ""
  @State page: number = 1
  @State biliUserData:BiliUserData = new BiliUserData()
  searchType: SearchType = SearchType.BILI_USER

  aboutToAppear() {
    this.initPage()
  }

  initPage() {
    this.page = 1
    Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page).then(response => {
      this.biliUserData.pushDataAll(response.result)
      if (response.result!=null&& this.biliUserData.totalCount()!=0) {
        this.loadingStatus = LoadingStatus.LoadingSuccess
      }else{
        this.loadingStatus = LoadingStatus.LoadingOther
      }
    }).catch(err => {
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    LoadingData({ loadingStatus: this.loadingStatus, page: this.biliUserPage.bind(this)})
      .width('100%')
      .height('100%')
  }

  @Builder
  biliUserPage() {
      List() {
        LazyForEach(this.biliUserData, (item: SearchBiliUserBean,index?: number) => {
          ListItem(){
            BiliUserItem({item:item})
          }
        },(item:SearchBiliUserBean)=>JSON.stringify(item))
      }.layoutWeight(1)
      .cachedCount(Constants.CACHE_COUNT)
      .onReachEnd(() => {
        Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page + 1).then(response => {
          if (response.result!=undefined) {
            this.page++
            this.biliUserData.pushDataAll(response.result)
          }
        }).catch(err => {
          Utils.Toast(err)
        })
      }).divider({ strokeWidth: 1, color: $r('app.color.bilibili_divider'), startMargin: 8, endMargin: 8 })
      .width('100%')
      .backgroundColor(Color.White)
  }
}