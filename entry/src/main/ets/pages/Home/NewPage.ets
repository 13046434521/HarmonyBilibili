import { showDialog } from '../../Utils/DialogUtil';

@Preview
@Component
export struct NewPage {
  @State isVisible: Visibility = Visibility.Visible;
  @State isShow: boolean = true;


  build() {
    Column() {
      Image($r('app.media.icon_media_like'))
        .fillColor(Color.Orange)
        .width('10%')
        .aspectRatio(1)
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