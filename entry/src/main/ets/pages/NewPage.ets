
@Component
export struct NewPage {
  @State message: string = `黄渤X<em class="keyword">木鱼水心</em>】
  独家深度专访！时代在改变，我们要做好一切准备迎接变化`
mes='<p style="font-size: 35px;text-align: center;font-weight: bold; color: rgb(24,78,228)">字体大小35px,行高45px</p>'
  build() {
    Row() {
      Column() {

        Text(upDateTitle(this.message))
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Grey)
          .borderColor(Color.Black)
          .fontColor(Color.White)
          .borderStyle(BorderStyle.Solid)
          .borderRadius(15)
          .padding(16)
      }
      .width('100%')
    }
    .height('100%')
  }
}

function upDateTitle(title:string){
  return title.replace(`em class="keyword`,`<p style="font-size: 35px;text-align: center;font-weight: bold; color: rgb(24,78,228)`).replace(`em`,`p`)
}