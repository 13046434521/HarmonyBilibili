import router from '@ohos.router'
import { SearchHotBeanItem } from '../bean/SearchHotBean'
import { SearchHeader} from '../component/SearchHeader'
import { HotSearchData } from '../datasource/HotSearchData'

import Api from '../net/Api'

@Entry
@Component
struct SearchHotPage {
  @State title: string = '搜索视频、番剧或up主'
  @State search: string = '搜索视频、番剧或up主'
  @State hotSearchData: HotSearchData = new HotSearchData()

  aboutToAppear() {
    // 传搜索栏的值
    let param = router.getParams()['title']
    if (param) {
      this.title = param
      this.search = this.title
    }
    // 获取当前热搜数据
    Api.getSearchHot().then((searchHotBean => {
      let data = searchHotBean.list.slice(0, 10)
      this.hotSearchData.pushDataAll(data)
    }))
  }

  build() {
    Column() {
     SearchHeader({title:this.title,placeholder:this.search,change:(value:string)=>{
       if (value!='') {
         this.search = value
       }
     },clickEvent:()=>{
        router.pushUrl({url:"pages/SearchPage",params:{keyword:this.search}})
     }})

      this.SearchHot((content) => {
        router.pushUrl({url:"pages/SearchWebPage"})
      })


      List() {
        LazyForEach(this.hotSearchData, (item: SearchHotBeanItem) => {
          ListItem(){
            this.SearchHotItem(item.show_name, item.icon)
          }
        })
      }.lanes(2)
    }
    .width('100%')
    .height('100%')
  }

  // 热搜
  @Builder
  SearchHot(clickEvent:(content:string)=>void) {
    Row() {
      Text('bilibili热搜')
        .fontWeight(FontWeight.Bold)
        .margin({ left: 10 })
      Blank()
        .layoutWeight(1)
      Row() {
        Text('完整榜单')
          .fontSize(12)
          .fontColor($r('app.color.bilibili_text_grey_bold'))
        Image($r('app.media.ic_search_complete'))
          .objectFit(ImageFit.Auto)
          .interpolation(ImageInterpolation.High)
          .height('60%')
          .aspectRatio(1)
      }.onClick(()=>{
        clickEvent("完整榜单")
      })
      .height('100%')
      .margin({ right: 5 })
    }
    .height(30)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  SearchHotItem(content: string, image: string) {
    Row() {
      Text(content)
        .maxLines(1)
        .fontSize(14)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
      if (image) {
        Image(image)
          .width(15)
          .aspectRatio(1)
      }
    }.justifyContent(FlexAlign.SpaceBetween)
    .margin({ left: 10, right: 10, top: 10, bottom: 10 })
    .onClick(()=>{
      router.pushUrl({url:"pages/SearchPage",params:{keyword:content}})
    })
  }
}
