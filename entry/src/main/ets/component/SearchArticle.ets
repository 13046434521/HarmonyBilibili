import HomeBean from '../bean/HomeBean'
import { SearchArticleBean } from '../bean/SearchArticleBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { LoadingData } from './LoadingData'

@Component
export struct SearchArticleDetails {
  @State message: string = '图文'
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @Prop search:string = "kobe"
  @State page:number=1
  @State searchArticleBeans: SearchArticleBean[] = []

  searchType:SearchType = SearchType.BILI_USER

  aboutToAppear(){
    this.initPage
  }

  initPage(){
    this.page = 1
    Api.getSearchType<SearchArticleBean>(this.searchType,this.search,this.page).then(response=>{
      this.searchArticleBeans = response.result
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }).catch(err=>{
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    Row() {
      LoadingData({loadingStatus :this.loadingStatus,page:this.biliUserPage})
    }
    .height('100%')
  }

  @Builder biliUserPage(){
    Column().layoutWeight(1)
  }
}