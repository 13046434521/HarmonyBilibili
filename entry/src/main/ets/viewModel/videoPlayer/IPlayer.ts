import window from '@ohos.window'

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

  getOrientation():window.Orientation

  setOrientation(orientation:window.Orientation)
}