import { showDialog } from '../../Utils/DialogUtil';

@Preview
@Component
export struct NewPage {
  @State isVisible: Visibility = Visibility.Visible;
  @State isShow: boolean = true;


  build() {
    Column() {
      Button("显隐切换")
        .onClick(() => {
          if (this.isVisible == Visibility.Visible) {
            this.isVisible = Visibility.None
          } else {
            this.isVisible = Visibility.Visible
          }
        })
      TestCompoment().visibility(this.isVisible)

      Button("if语句显隐切换")
        .onClick(() => {
          this.isShow = !this.isShow
        })
      if (this.isShow) {
        TestCompoment()
      }
    }
  }
}

@Component
struct TestCompoment{
  aboutToAppear(){
    showDialog('TestCompoment','aboutToAppear:创建组件')
  }
  aboutToDisappear(){
    showDialog('TestCompoment','aboutToDisappear:销毁组件')
  }


  build(){
    Row()
      .width(300).height(300).backgroundColor(Color.Pink)
  }
}