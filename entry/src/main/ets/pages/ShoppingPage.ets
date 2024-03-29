import Constants from '../common/Constants'
import StorageManager from '../common/StorageManager'

@Component
export struct ShoppingPage {
  @State msg:string = "123"
  @StorageLink('isLogin') isLogin:boolean = false
  num = 1
  build() {
    Column() {

      Button("测试啊").onClick(()=>{
        this.isLogin=!this.isLogin
      })

      Text(this.isLogin ?"true":"false")

      Text(this.msg)
      Button('getCookie').onClick(()=>{
        this.msg = StorageManager.getCookie()
      })

      Button('setCookie').onClick(()=>{
        StorageManager.loginCookie(""+this.num++)
      })
      Button('isLogin').onClick(()=>{
        // this.msg ="AppStorage:isLogin:"+ StorageManager.isLogin()
      })
      Button('setLogin').onClick(()=>{
        // StorageManager.setLogin(true)
      })
    }
  }
}