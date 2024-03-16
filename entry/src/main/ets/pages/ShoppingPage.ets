import { Utils } from '../Utils/Utils'

class ButtonState{
  state:number

  constructor(state:number) {
    this.state = state;
  }
}
@Preview
@Component
// 主界面中的购物页面，很可能被去掉
export struct ShoppingPage {
  @State message: string = '购物'
  @State test :ButtonState =new ButtonState(1)
  num:number
  build() {
    Row() {
      Column() {
        Button("主组件的状态值:"+this.test.state+"  "+this.num)
          .onClick(()=>{
            this.test.state++
            // this.test ++
          })

        son({test:$test})
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct son{
  @Link test :ButtonState
  build(){
    Column(){
      Button("子组件的值:"+this.test.state)
        .onClick(()=>{
          this.test.state ++
        })

      grandson({test:$test})
    }

  }
}
@Component
struct grandson{
  @Link test :ButtonState
  build(){
    Column() {
      Button("孙子组件的值:" + this.test.state)
        .onClick(() => {
          this.test.state++
        })
    }
  }
}