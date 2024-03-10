import Api from '../net/Api'
import { Loading } from './LoadingComponent'
import router from '@ohos.router'
import { SearchDetailsBean, SearchDetailsItemBean } from '../bean/SearchDetailsBean'

@Component
export struct SearchDetails {
  @State isLoading: boolean = false // 为false时正在加载，true时加载失败或者加载成功
  @Link search: string
  @State page:number=1
  @State searchDetailsItemBean:SearchDetailsItemBean[] =null
  aboutToAppear(){
    Api.getSearchDetails('video',this.search,this.page).then((searchDetailsBean)=>{
      this.isLoading = true
      this.searchDetailsItemBean = searchDetailsBean.result
    })
  }
  build() {
    Column(){
      if (!this.isLoading) {
        Loading().layoutWeight(1)
      }else{
        List(){
          ForEach( this.searchDetailsItemBean,(item)=>{
            ListItem(){
              Text(item.title)
            }
          })
        }.width('100%')
        .layoutWeight(1)
        .lanes(2)
      }
    }.width('100%')
    .height('100%')
  }
}