import { Utils } from '../Utils/Utils'

@Component
export struct NewPage {
  @State isShow :boolean = true
  build(){
    Column(){
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
    Text(Utils.timestampToDate(1547619147)).height('20%').width('100%').visibility(this.isShow?Visibility.Visible:Visibility.Hidden)
  }
}
