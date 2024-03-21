import { Utils } from '../Utils/Utils'
@Preview
@Component
export struct NewPage {
  @State isShow :boolean = true

  headers = new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Referer", "https://www.bilibili.com"]
  ])

  @State tttt:string=''
  build(){

    Column(){
      Button("test")
        .onClick(()=>{
          this.setDataSource("url: string", this.headers)
        })
        .width('20%')
        .width(50)
      Text(this.tttt)
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    // Video({src:'https://d1--ov-gotcha07.bilivideo.com/live-bvc/665206/live_1388514638_9387369_4000.flv?expires=1710737906&len=0&oi=922436117&pt=web&qn=1000&trid=100014386918d4d7495eae95fb9445ef297e&sigparams=cdn,expires,len,oi,pt,qn,trid&cdn=ov-gotcha07&sign=e83deee76033c3fed0401133cbe9ae24&sk=df739001013e4655328c9a3da73fc4ac&p2p_type=0&sl=10&free_type=0&mid=0&pp=rtmp&source=one&trace=0&site=1032247946f1df79785af88cfb9c5383&order=1'})
    //   .autoPlay(true)
    //   .width('100%')
    //   .aspectRatio(4/3)
    // Text(Utils.timestampToDate(1547619147)).height('20%').width('100%').visibility(this.isShow?Visibility.Visible:Visibility.Hidden)
  }


  setDataSource(url: string, headers?:Map<string,string>) {
    var builder = 'builder:';
    if (headers) {
      headers.forEach((value, key) => {
        var parm = key.trim() + ": ";
        if (value)
          parm += value.trim();
        parm += "\r\n";
        builder += parm;
      });
    }
    this.tttt = builder
  }
}
