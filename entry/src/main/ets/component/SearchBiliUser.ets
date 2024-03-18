import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { LoadingData } from './LoadingData'
import router from '@ohos.router'
import { SearchBiliUserBean } from '../bean/SearchBiliUserBean'
import { Utils } from '../Utils/Utils'
import { BiliUserItem } from './item/BiliUserItem'

@Component
export struct SearchBiliUserDetails {
  @State message: string = '用户'
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @Prop search: string = ""
  @State page: number = 1
  @State searchBiliUserBeans: Array<SearchBiliUserBean> = null
  searchType: SearchType = SearchType.BILI_USER

  aboutToAppear() {
    this.initPage()
    console.log("用户 页面刷新了")
  }
  aboutToDisappear(){
    console.log("用户 页面销毁了")
  }

  initPage() {
    this.page = 1
    Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page).then(response => {
      this.searchBiliUserBeans = response.result
      if (this.searchBiliUserBeans!=null&&this.searchBiliUserBeans.length!=0) {
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
        ForEach(this.searchBiliUserBeans, (item: SearchBiliUserBean,index?: number) => {
          ListItem(){
            BiliUserItem({item:item})
          }
        })
      }.layoutWeight(1)
      .cachedCount(3)
      .onReachEnd(() => {
        Api.getSearchType<SearchBiliUserBean>(this.searchType, this.search, this.page + 1).then(response => {
          if (response.result!=undefined) {
            this.page++
            this.searchBiliUserBeans = this.searchBiliUserBeans.concat(response.result)
          }
        }).catch(err => {
          Utils.Toast(err)
        })
      }).divider({ strokeWidth: 1, color: $r('app.color.bilibili_divider'), startMargin: 8, endMargin: 8 })
      .width('100%')
      .backgroundColor(Color.White)
  }
}