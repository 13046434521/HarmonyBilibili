
@Component
// 主界面中的我的页面
export struct MinePage {
  @State data: string = '<h1 style="text-align: center;">h1标题</h1>' +
    '<h1 style="text-align: center;"><i>h1斜体</i></h1>' +
    '<h1 style="text-align: center;"><u>h1下划线</u></h1>' +
    '<h2 style="text-align: center;">h2标题</h2>' +
    '<h3 style="text-align: center;">h3标题</h3>' +
    '<p style="text-align: center;">p常规</p><hr/>' +
    '<div style="width: 500px;height: 500px;border: 1px solid;margin: 0auto;">' +
    '<p style="font-size: 35px;text-align: center;font-weight: bold; color: rgb(24,78,228)">字体大小35px,行高45px</p>' +
    '<p style="background-color: #e5e5e5;line-height: 45px;font-size: 35px;text-indent: 2em;">' +
    '<p>这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字</p>';

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Center }) {
      RichText(this.data)
        .onStart(() => {
          console.info('RichText onStart');
        })
        .onComplete(() => {
          console.info('RichText onComplete');
        })
        .width(500)
        .height(400)
        .backgroundColor(0XBDDB69)
      RichText('layoutWeight(1)')
        .onStart(() => {
          console.info('RichText onStart');
        })
        .onComplete(() => {
          console.info('RichText onComplete');
        })
        .size({ width: '100%', height: 110 })
        .backgroundColor(0X92D6CC)
        .layoutWeight(1)
      RichText('layoutWeight(2)')
        .onStart(() => {
          console.info('RichText onStart');
        })
        .onComplete(() => {
          console.info('RichText onComplete');
        })
        .size({ width: '100%', height: 110 })
        .backgroundColor(0X92C48D)
        .layoutWeight(2)
    }
  }
}