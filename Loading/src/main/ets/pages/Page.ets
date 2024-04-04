import prompt from '@ohos.prompt'
import promptAction from '@ohos.promptAction';
import { Loading } from './Loading';
import { SwipeRefreshLayout } from './SwipeRefreshLayout';


PersistentStorage.PersistProp('aProp', 47);
  @Entry
  @Component
  struct Page {
  @State listPosition: number = 0; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  private scrollerForScroll: Scroller = new Scroller()
  private scrollerForList: Scroller = new Scroller()

  build() {
    Column(){
      SwipeRefreshLayout({refresh:()=>{
        promptAction.showToast({message:'刷新了'})
      }}){
        Text("ceshi")
          .borderWidth(2)
          .borderColor(Color.Orange)
      }
    }
  }
}