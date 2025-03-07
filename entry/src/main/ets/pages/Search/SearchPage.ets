import router from '@ohos.router'
import Api from '../../net/Api'
import { SearchHeader } from '../../component/SearchHeader'
import { LoadingStatus } from '../../common/LoadingStatus'
import { SearchSuggest } from '../../component/SearchSuggest'
import { SearchTabsAll } from '../../component/SearchTabsAll'
import { topTlistBean } from '../../bean/search/SearchBaseBean'
import { Utils } from '../../Utils/Utils'
import { LoadingData } from '../../component/LoadingData'
import { AllData } from '../../datasource/AllData'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct SearchPage {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @State topList: topTlistBean = new topTlistBean()
  errMessage: string = ''
  controllerLocalStrorage = new TabsController()
  @Provide('defaultPageData') allData: AllData = new AllData()

  placeholder:string = '' // search为空时，显示的数据
  @State search: string = '搜索视频、番剧或up主' // 搜索内容
  @State isTitleVisible:boolean = false; // searchHeader中的textInput，显示search还是显示placeholder
  @State isNeedSuggest: boolean = false // 是否弹出建议页面

  aboutToAppear() {
    this.search = router.getParams()['keyword']
    this.placeholder= this.search
    this.searchPage(this.search)
  }

  searchPage(keywords:string) {
    // 搜索页面时，不需要SearchSuggest
    this.isNeedSuggest = false
    this.loadingStatus = LoadingStatus.Loading

    Api.getSearchDefault(keywords).then(response => {
      // 需要特殊处理，将数据传递到searchDefault页面
      this.allData.specialData(response.result)

      this.topList = response.top_tlist
      this.loadingStatus = LoadingStatus.LoadingSuccess
    }).catch(err => {
      this.errMessage = err
      this.loadingStatus = LoadingStatus.LoadingFailure
    })
  }

  build() {
    Column() {
      // 搜索Header
      SearchHeader({ title: this.search,isTitleVisible:this.isTitleVisible,placeholder:this.placeholder, change: (value: string) => {
        if (this.search!==value) {
          this.isNeedSuggest = true
        }
        this.search = value
        this.isTitleVisible = true
      }, clickEvent: (title,placeholder) => {
        if (this.search === "") {
          this.search =placeholder
        }
        this.isTitleVisible = true
        this.searchPage(this.search)
      } })
      // Tabs页面
      this.SearchTabs()
    }.width('100%')
    .height('100%')
  }

  @Builder
  SearchTabs(){
    if (this.isNeedSuggest && this.search !== "") {
      SearchSuggest({ keywords: this.search, click: (value: string) => {
        this.search = value
        this.searchPage(this.search)
      } })
    } else {
      LoadingData({loadingStatus:this.loadingStatus,page:this.searchTabsAll.bind(this)})
        .layoutWeight(1)
    }
  }

  @Builder
  searchTabsAll(){
    SearchTabsAll({topList:this.topList,search:this.search===""?this.placeholder:this.search})
  }
}
