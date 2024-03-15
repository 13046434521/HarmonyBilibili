import { SearchBiliUserBean } from '../bean/SearchBiliUserBean'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchType } from '../common/SearchType'
import Api from '../net/Api'
import { LoadingData } from './LoadingData'

@Component
export struct SearchLiving {
  @State message: string = '影视'
  @State loadingStatus:LoadingStatus = LoadingStatus.Loading
  @Prop search:string = "kobe"
  @State page:number=1
  @State searchBiliUserBeans: SearchBiliUserBean[] = []

  searchType:SearchType = SearchType.BILI_USER
  @Prop @Watch('initPage') searchRequest: string
  aboutToAppear(){
    this.initPage
  }

  initPage(){
    this.page = 1
    Api.getSearchType<SearchBiliUserBean>(this.searchType,this.search,this.page).then(response=>{
      this.searchBiliUserBeans = response.result
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