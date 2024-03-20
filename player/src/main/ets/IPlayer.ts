import { DisplayInfo } from './common/DisplayInfo'
import { Orientation } from './common/Orientation'

export interface IPlayer{
  init(context?:object)

  play()

  pause()

  moveProgress(progress:number)

  adjustVolume(volume:number)

  adjustBrightness(brightness:number)

  stop()

  destroy()

  reset()

  getOrientation():Orientation

  setOrientation(orientation:Orientation)

  setDisplayInfo(display:DisplayInfo)

  getDisplayInfo():DisplayInfo
}