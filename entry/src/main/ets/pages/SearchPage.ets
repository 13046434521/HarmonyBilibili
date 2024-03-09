import { SearchView } from '../component/HomeSearch'
import router from '@ohos.router'
import image from '@ohos.multimedia.image'
import Api from '../net/Api'
import { SearchHotBean, SearchHotBeanItem } from '../bean/SearchHotBean'

@Entry
@Component
struct SearchPage {
  @State title: string = '搜索视频、番剧或up主'
  @State search: string = '搜索视频、番剧或up主'
  @State searchHotBean: SearchHotBeanItem[] = []

  aboutToAppear() {
    // 传搜索栏的值
    let param = router.getParams()['title']
    if (param) {
      this.title = param
      this.search = this.title
    }
    // 获取当前热搜数据
    Api.getSearchHot().then((searchHotBean => {
      this.searchHotBean = searchHotBean.list.slice(0, 10)
    }))
  }

  build() {
    Column() {
      this.SearchHeader()
      this.SearchHot()
      List() {
        ForEach(this.searchHotBean, (item: SearchHotBeanItem) => {
          this.SearchHotItem(item.show_name, item.icon)
        })
      }.lanes(2)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SearchHeader() {
    Row() {
      Image($r('app.media.ic_common_back_gray'))
        .objectFit(ImageFit.Auto)
        .renderMode(ImageRenderMode.Original)
        .width(24)
        .height('100%')
        .margin(10)
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      Search({ placeholder: this.title })
        .height('100%')
        .layoutWeight(1)
        .onChange((value: string) => {
          // this.search = value
        })

      Text('搜索')
        .fontColor(Color.Pink)
        .fontSize(16)
        .margin(15)
        .height('100%')
        .width(40)
        .onClick(() => {
          console.log("进行测试：" + this.search)
        })
    }.width('100%')
    .height('5%')
    .margin(15)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // 热搜
  @Builder
  SearchHot() {
    Row() {
      Text('bilibili热搜')
        .fontWeight(FontWeight.Bold)
        .margin({ left: 10 })
      Blank()
        .layoutWeight(1)
      Row() {
        Text('完整榜单')
          .fontSize(12)
          .fontColor(Color.Grey)
        Image($r('app.media.ic_search_complete'))
          .objectFit(ImageFit.Auto)
          .interpolation(ImageInterpolation.High)
          .height('60%')
          .aspectRatio(1)
      }
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
  }
}