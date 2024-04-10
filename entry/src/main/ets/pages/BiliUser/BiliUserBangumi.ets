import { UserBangumi, UserBangumiItem } from '../../bean/biliUser/UserBangumi'
import { BiliUserViewModel } from '../../viewModel/biliUser/BiliUserViewModel'
import { PageManager } from '../../common/PageManager'
import { UserBangumiData } from '../../datasource/UserBangumiData'
import Constants from '../../common/Constants'

@Component
export struct BiliUserBangumi{
  mid:number = 0
  @Prop userBangumi: UserBangumi = new UserBangumi()
  biliUserViewModel:BiliUserViewModel
  userBangumiData :UserBangumiData = new UserBangumiData()
  page:number=1
  aboutToAppear(){
    this.userBangumiData.addDataAll(this.userBangumi.list)
  }


  build(){
    this.BangumiView()
  }

  /*------------------------------------------- 追番 --------------------------------------------*/
  @Builder
  BangumiView() {
    List(){
      LazyForEach(this.userBangumiData,(bangumi: UserBangumiItem)=>{
        this.BangumiItem(bangumi)
      },(item,index)=>JSON.stringify(item)+index)
    }.lanes(3)
    .cachedCount(Constants.CACHE_COUNT)
    .onReachEnd(()=>{
      this.biliUserViewModel.getUserBangumiData(this.mid,this.page+1).then(item=>{
        this.page++
        this.userBangumiData.pushDataAll(item.list)
      })
    }).width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bilibili_background_grey'))
    .scrollBar(BarState.Off)
  }

  @Builder BangumiItem(bangumi:UserBangumiItem){
    Stack(){
      Image(bangumi.cover)
        .width('100%')
        .objectFit(ImageFit.Contain)
        .interpolation(ImageInterpolation.Low)
        .borderRadius({topLeft:5,topRight:5})
        .aspectRatio(3/4)
        .alt($r('app.media.ic_placeholder'))

      Column(){
        Text(bangumi.title)
          .fontColor(Color.White)
          .fontSize(16)
          .margin({left:'2%',bottom:'2%'})


        Text(bangumi.new_ep.index_show)
          .fontColor(Color.White)
          .fontSize(14)
          .margin({left:'2%',bottom:'2%'})

      }.width('100%')
      .height('25%')

      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.Start)
    }.alignContent(Alignment.BottomStart)
    .borderRadius({topLeft:5,topRight:5,bottomLeft:5,bottomRight:5})
    .backgroundColor($r('app.color.bilibili_background_white'))
    .margin('2%')
    .onClick(event=>{
      PageManager.routerMediaFt(bangumi.season_id)
    })
  }
}


@Extend(Text) function titleStyle(){
  .fontColor($r('app.color.bilibili_text_grey_light'))
}
