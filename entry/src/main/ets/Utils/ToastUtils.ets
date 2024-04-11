import promptAction from '@ohos.promptAction'

export function toast(message:string){
  promptAction.showToast({message:message})
}