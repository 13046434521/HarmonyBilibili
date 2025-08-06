import window from '@ohos.window'
import { common } from '@kit.AbilityKit'

export interface IPlayer{
  init(context:object)

  play()

  pause()

  moveProgress(progress:number)

  adjustVolume(volume:number)

  adjustBrightness(brightness:number)

  stop()

  release()

  reset()

  getOrientation(context:common.UIAbilityContext):window.Orientation

  setOrientation(context:common.UIAbilityContext,orientation:window.Orientation)
}