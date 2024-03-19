import { Utils } from '../Utils/Utils'

@Component
export struct NewPage {
  @State isShow :boolean = true
  build(){
    Column(){
      Canvas()
      Button("切换一下："+this.isShow).onClick(()=>{
        this.isShow=!this.isShow
      }).width(100).height(40)
      testCom({isShow:this.isShow})
    }
  }
}

@Component
struct  testCom{
  @Prop isShow:boolean

  aboutToAppear(){
    console.log("测试一下页面出现")
  }
  aboutToDisappear(){
    console.log("测试一下页面消失")
  }
  build(){
    // Video({src:'https://d1--ov-gotcha07.bilivideo.com/live-bvc/665206/live_1388514638_9387369_4000.flv?expires=1710737906&len=0&oi=922436117&pt=web&qn=1000&trid=100014386918d4d7495eae95fb9445ef297e&sigparams=cdn,expires,len,oi,pt,qn,trid&cdn=ov-gotcha07&sign=e83deee76033c3fed0401133cbe9ae24&sk=df739001013e4655328c9a3da73fc4ac&p2p_type=0&sl=10&free_type=0&mid=0&pp=rtmp&source=one&trace=0&site=1032247946f1df79785af88cfb9c5383&order=1'})
    //   .autoPlay(true)
    //   .width('100%')
    //   .aspectRatio(4/3)
    // Text(Utils.timestampToDate(1547619147)).height('20%').width('100%').visibility(this.isShow?Visibility.Visible:Visibility.Hidden)
  }
}
