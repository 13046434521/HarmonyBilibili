import prompt from '@ohos.prompt'

@Entry
@Component
struct Page {
  @State idList: string[] = ['A_A', 'btn_search', 'C', 'D_D', 'E', 'F', 'LastPageId']
  @State selectId: string = 'LastPageId'

  build() {
    Column({ space:20 }){
      TextInput()
      Row({space: 5}) {
        Button("id: " + this.idList[0] + " focusable(false)")
          .width(200).height(70).fontColor(Color.White)
          .key(this.idList[0])
          .focusable(false)
          .onClick(()=>{
            var res = focusControl.requestFocus('btn_search')      // 使选中的this.selectId的组件获焦
            if (res) {
              prompt.showToast({message: 'Request success'})
            } else {
              prompt.showToast({message: 'Request failed'})
            }
          })
        Button("id: " + 'btn_search')
          .width(200).height(70).fontColor(Color.White)
          .key('btn_search')
      }
      Row({space: 5}) {
        Button("id: " + this.idList[2])
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[2])
        Button("id: " + this.idList[3])
          .width(200).height(70).fontColor(Color.White)
          .key(this.idList[3])
      }
      Row({space: 5}) {
        Button("id: " + this.idList[4])
          .width(200).height(70).fontColor(Color.White)
          .key(this.idList[4])
        Button("id: " + this.idList[5])
          .width(200).height(70).fontColor(Color.White)
          .key(this.idList[5])
      }
      Row({space: 5}) {
        Select([{value: this.idList[0]},
          {value: this.idList[1]},
          {value: this.idList[2]},
          {value: this.idList[3]},
          {value: this.idList[4]},
          {value: this.idList[5]},
          {value: this.idList[6]}])
          .value(this.selectId)
          .onSelect((index: number) => {
            this.selectId = this.idList[index]
          })
        Button("RequestFocus")
          .width(200).height(70).fontColor(Color.White)
          .onClick(() => {
            var res = focusControl.requestFocus(this.selectId)      // 使选中的this.selectId的组件获焦
            if (res) {
              prompt.showToast({message: 'Request success'})
            } else {
              prompt.showToast({message: 'Request failed'})
            }
          })
      }
    }.width('100%').margin({ top:20 })
  }
}