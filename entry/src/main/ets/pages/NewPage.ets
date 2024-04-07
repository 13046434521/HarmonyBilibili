import Constants from '../common/Constants';
import { Utils } from '../Utils/Utils'
@Preview
@Component
export struct NewPage {

  build() {
    Column() {
      Text('测试')
        .fontSize(25)
      Text('测试')
        .fontSize('25fp')

      Text('测试')
        .fontSize('25vp')

      Text('测试')
        .fontSize('25lpx')

      Text('测试')
        .fontSize('25px')

      Text('测试')
        .fontSize('25pp')
    }
  }
}