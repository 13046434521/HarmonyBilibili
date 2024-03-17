import { SearchBiliUserBean } from '../bean/SearchBiliUserBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { LoadingData } from './LoadingData'

@Component
export struct SearchMediaBangumiDetails {
  @State message: string = '番剧'
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @Prop search:string = "kobe"
  @State page:number=1
  @State searchBiliUserBeans: SearchBiliUserBean[] = []

  searchType:SearchType = SearchType.BILI_USER
  aboutToAppear() {
    console.log("番剧 页面刷新了")
    this.initPage()
  }
  aboutToDisappear(){
    console.log("番剧 页面销毁了")
  }
  initPage(){
    this.page = 1
    // Api.getSearchType<SearchBiliUserBean>(this.searchType,this.search,this.page).then(response=>{
    //   this.searchBiliUserBeans = response.result
    //   this.loadingStatus = LoadingStatus.LoadingSuccess
    // }).catch(err=>{
    //   this.loadingStatus = LoadingStatus.LoadingFailure
    // })
  }

  build() {
    Row() {
      LoadingData({loadingStatus :this.loadingStatus,page:this.biliUserPage,extraFailure:"Search番剧",extraSuccess:'Search番剧'})
    }
    .height('100%')
  }

  @Builder biliUserPage(){
    Column().layoutWeight(1)
  }
}