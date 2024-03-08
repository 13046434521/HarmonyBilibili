import { HomeBeanItem } from '../bean/HomeBean';
import Api from '../net/Api'
import router from '@ohos.router';
import { HomeSearchBean } from '../bean/HomeSearchBean';
import { SearchView } from '../component/HomeSearch';

@Component
export struct HomePage {
  @State message: string = 'Home'
  @State homeBeanData:Array<HomeBeanItem>=[]
  @State homeSearchBeanData:HomeSearchBean=new HomeSearchBean()
  aboutToAppear(){
    Api.getHomePages().then(homebean=>{
      this.homeBeanData = homebean.item
    })

    Api.getHomeSearch().then(homesearchbean=>{
      this.homeSearchBeanData = homesearchbean
    })
  }

  aboutToDisappear(){

  }

  build() {
    Row() {
      Column() {
        this.HomeHeader()
        List(){
          ForEach(this.homeBeanData,(item:HomeBeanItem)=>{
            ListItem(){
              this.HomeItem(item)
            }.margin(3)
          })
        }.lanes(2)

      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor("#F8F8FF")
  }

  @Builder HomeItem(homeBeanItem:HomeBeanItem){
    Column(){
      Stack(){
        Image(homeBeanItem.pic)
          .width('100%')
          .objectFit(ImageFit.Fill)
          .borderRadius({topLeft:5,topRight:5})
          .height(120)
        Row(){
          Image($r('app.media.ic_video_play_dack'))
            .width(20)
            .height('100%')
            .objectFit(ImageFit.Auto)

          Text(views(homeBeanItem.stat.view))
            .height('100%')
            .textSizeStyle()

          Image($r('app.media.ic_danmu_repeat_square_line_28'))
            .width(20)
            .height(20)
            .height('100%')
            .objectFit(ImageFit.Auto)
            .margin({left:5})

          Text(homeBeanItem.stat.danmaku.toString())
            .height('100%')
            .textSizeStyle()

          Blank().layoutWeight(1)

          Text(duration(homeBeanItem.duration))
            .height('100%')
            .align(Alignment.End)
            .margin({right:5})
            .textSizeStyle()
        }.width('100%')
        .height(32)
      }
      .alignContent(Alignment.Bottom)
      Text(homeBeanItem.title)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow:TextOverflow.Clip})
        .maxLines(2)
        .fontSize(12)
        .letterSpacing(1)
        .width('100%')
        .margin({top:8,bottom:8})
        .padding({left:4,right:4})
        .height(32)
        .lineHeight(16)

      Row(){
        Image($r('app.media.icon_playlist_upper'))
          .height(16)
          .margin({left:5})
          .objectFit(ImageFit.Auto)
        Text(homeBeanItem.owner.name)
          .height(20)
          .fontSize(11)
          .layoutWeight(1)
          .margin({left:5})
          .fontColor(Color.Gray)
        Image(homeBeanItem.owner.face)
          .width(20)
          .align(Alignment.End)
          .visibility(Visibility.None)
      }.width('100%')
      .height(20)
    }
    .borderRadius({topLeft:5,topRight:5,bottomLeft:5,bottomRight:5 })
    .backgroundColor(Color.White)
  }

  @Builder HomeHeader(){
    Row(){
      Image($r('app.media.test'))
        .objectFit(ImageFit.Auto)
        .width(24)
        .height(24)
      Row(){
/*        Search({ placeholder: this.homeSearchBeanData.show_name})
          .height(40)
          .width(200)
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .focusable(true)*/
        SearchView({title:this.homeSearchBeanData.show_name})
          .height(40)
          .width(240)

      }.onClick(event=>{
          router.pushUrl({url:'pages/SearchPage'})
      })

      Image($r('app.media.test'))
        .objectFit(ImageFit.Auto)
        .width(24)
        .height(24)
      Image($r('app.media.test'))
        .objectFit(ImageFit.Auto)
        .width(24)
        .height(24)
    }.width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Styles function  testColor(){
  .backgroundColor('#36d')
}

@Extend(Text) function  textSizeStyle(){
  .height(20)
  .fontSize(11)
  .fontColor(Color.White)
}

// 观看量数据转换处理
function views(views:number):string{
  console.log("views:"+views+"---"+(views/10000).toFixed(2)+"w")

  if (views>10000) {
    return (views/10000).toFixed(2)+"w"
  }

  return views.toString()
}

// 视频时常，转换处理
function duration(duration:number):string{
  let second:number|string = duration % 60
  let minute:number|string = Math.floor(duration / 60)
  if (second<10) {
    second = '0'+second
  }
  
  console.log("duration:"+duration+"---"+minute+'---'+second)
  return duration>3600?Math.floor(duration / 3600)+":"+minute+":"+second:minute+":"+second
}