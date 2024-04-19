@Component
@Preview
export struct VolumeBrightness {
  @Link value: number
  @Prop volumeBrightStatus: VolumeBrightStatus

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Progress({ value: this.value, type: ProgressType.Ring }).width('90%').height('90%')
        .color($r('app.color.bilibili_theme'))
        .style({ strokeWidth: 2})


      Image(this.volumeBrightStatus === VolumeBrightStatus.VOLUME
        ? $r('app.media.ic_video_play_volume')
        : $r('app.media.ic_video_play_brightness_normal'))
        .width('60%')
        .height('60%')
        .objectFit(ImageFit.Cover)

    }.width('100%')
    .height('100%')
    .linearGradient({
      colors: [["#aa000000", 0.0], ["#aa000000", 1.0]]
    })
  }
}

export enum VolumeBrightStatus {
  VOLUME = 1,
  BRIGHTNESS
}