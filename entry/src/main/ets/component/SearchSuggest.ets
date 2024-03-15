import { SearchSuggestResultBean, SearchSuggestTagBean } from '../bean/SearchSuggestBean'
import Api from '../net/Api'
import { Utils } from '../Utils/Utils'

@Component
export struct SearchSuggest {
  @Prop @Watch("init") keywords: string
  @State suggestTags: SearchSuggestTagBean[] = []
  @State isInit: boolean = false

  aboutToAppear() {
    this.init()
  }

  init() {
    Api.getSearchSuggest(this.keywords).then((response: SearchSuggestResultBean) => {
      this.suggestTags = []
      this.suggestTags = this.suggestTags.concat(response.tag)
      Utils.Toast(this.keywords + " --- " + this.suggestTags[0].value)
    }).catch(err => {
      Utils.Toast(err)
    })
  }

  build() {
    Row() {
      List() {
        ForEach(this.suggestTags, (item: SearchSuggestTagBean) => {
          ListItem() {
            Text(Utils.upRichTextClear(item.value))
              .fontSize(14)
              .margin({ left:8,right:8 })
              .width('100%')
              .aspectRatio(8/1)
          }
        })
      }.divider({ strokeWidth: 1, color: Color.Grey, startMargin: 8, endMargin: 8 })
      .width('100%')
      .backgroundColor(Color.White)

    }.width('100%')
    .height('100%')
    .alignItems(VerticalAlign.Top)
    .backgroundColor(Color.Grey)

  }
}