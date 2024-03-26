import prompt from '@ohos.prompt'


  PersistentStorage.PersistProp('aProp', 47);

  @Entry
  @Component
  struct Page {
  @State message: string = 'Hello World'
  @StorageLink('aProp') aProp: number = 48

  build() {
    Row() {
      Column() {
        Text(this.message)
        // 应用退出时会保存当前结果。重新启动后，会显示上一次的保存结果
        Text(`${this.aProp}`)
          .onClick(() => {
            this.aProp += 1;
          }).width(200).width(200)
      }.height('100%').width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }.width('100%')
  }
}