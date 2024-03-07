import { Api } from '../net/Api'

@Component
export struct HomePage {
  @State message: string = 'Home'

  aboutToAppear(){
    Api.get()
  }

  aboutToDisappear(){

  }
test:Array<string>=["1","2","1","2","1","2","1","2","1","2","1","2",]
  build() {
    Row() {
      Column() {
        List(){
          ForEach(this.test,(item:string)=>{
            ListItem(){
              this.HomeItem()
            }
          })
        }.lanes(2)

      }
      .width('100%')
    }
    .height('100%')
  }

  @Builder HomeItem(){
    Column(){
      Stack(){
        Image($r('app.media.test'))
          .width('100%')
        Row(){
          Image($r('app.media.ic_video_play_dack'))
            .width(20)
            .height(20)
          Text('7.2w')
            .fontSize(12)
          Image($r('app.media.ic_danmu_repeat_square_line_28'))
            .width(20)
            .height(20)
          Text('6500')
            .fontSize(12)
          Text('10:25')
            .fontSize(12)
            .align(Alignment.End)
        }.width('100%')
        .height(200)
        .align(Alignment.Bottom)
      }
      Text('不是哥们，你这挑')
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow:TextOverflow.Clip})
        .maxLines(2)
        .fontSize(25)
        .height(50)
        .width('100%')
        .lineHeight(20)
        .padding({left:10})

      Row(){
        Image($r('app.media.icon_playlist_upper'))
          .width('10%')
          .margin(10)
        Text("可乐加冰儿")
          .width('10%')
          .layoutWeight(1)
          .margin(10)
          .fontColor(Color.Gray)
        Image($r('app.media.ic_player_setting'))
          .width('10%')
          .align(Alignment.End)
          .visibility(Visibility.Hidden)
      }.width('100%')
    }
  }
}