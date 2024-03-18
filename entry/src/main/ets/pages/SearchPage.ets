import router from '@ohos.router'
import Api from '../net/Api'
import { SearchHeader } from '../component/SearchHeader'
import { LoadingStatus } from '../common/LoadingStatus'
import { SearchSuggest } from '../component/SearchSuggest'
import { SearchTabsAll } from '../component/SearchTabsAll'
import { topTlistBean } from '../bean/SearchBaseBean'
import { Utils } from '../Utils/Utils'
import { LoadingData } from '../component/LoadingData'

let controllerLocalStrorage = new LocalStorage({'tabsController':new TabsController()})
@Entry(controllerLocalStrorage)
@Component
struct SearchPage {
  @State search: string = '搜索视频、番剧或up主'
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading
  @State isNeedSuggest: boolean = false
  @State topList: topTlistBean = new topTlistBean()
  errMessage: string = ''
  placeholder:string = ''
  @State isTitleVisible:boolean = false;
  controllerLocalStrorage = new TabsController()
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
        this.search = value
        this.isNeedSuggest = true

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
    if (this.isNeedSuggest && this.search != "") {
      SearchSuggest({ keywords: this.search, click: (value: string) => {
        this.search = value
        this.isTitleVisible = true
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
