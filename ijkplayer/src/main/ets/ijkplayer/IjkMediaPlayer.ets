/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { OnPreparedListener } from "../ijkplayer/callback/OnPreparedListener";
import { OnCompletionListener } from "../ijkplayer/callback/OnCompletionListener";
import { OnVideoSizeChangedListener } from "../ijkplayer/callback/OnVideoSizeChangedListener";
import { OnBufferingUpdateListener } from "../ijkplayer/callback/OnBufferingUpdateListener";
import { OnErrorListener } from "../ijkplayer/callback/OnErrorListener";
import { OnInfoListener } from "../ijkplayer/callback/OnInfoListener";
import { OnSeekCompleteListener } from "../ijkplayer/callback/OnSeekCompleteListener";
import { OnTimedTextListener } from "../ijkplayer/callback/OnTimedTextListener";
import { MessageType } from '../ijkplayer/common/MessageType';
import { PropertiesType } from '../ijkplayer/common/PropertiesType';
import { LogUtils } from "../ijkplayer/utils/LogUtils";
import window from '@ohos.window';
import { IjkPlayerNapi } from "./utils/IjkPlayerNapi";
import util from '@ohos.util';
import promptAction from '@ohos.promptAction';


export class IjkMediaPlayer {
  private static instance: IjkMediaPlayer;

  constructor() {
  };

  public static getInstance(): IjkMediaPlayer {
    if (!IjkMediaPlayer.instance) {
      IjkMediaPlayer.instance = new IjkMediaPlayer();
    }
    return IjkMediaPlayer.instance;
  }

  public static OPT_CATEGORY_FORMAT: string = "1";
  public static OPT_CATEGORY_CODEC: string = "2";
  public static OPT_CATEGORY_SWS: string = "3";
  public static OPT_CATEGORY_PLAYER: string = "4";
  private mVideoWidth: number = 0;
  private mVideoHeight: number = 0;
  private mVideoSarNum: number = 0;
  private mVideoSarDen: number = 0;
  private mOnVideoSizeChangedListener: OnVideoSizeChangedListener | null = null;
  private mOnPreparedListener: OnPreparedListener | null = null;
  private mOnCompletionListener: OnCompletionListener | null = null;
  private mOnBufferingUpdateListener: OnBufferingUpdateListener | null = null;
  private mOnErrorListener: OnErrorListener | null = null;
  private mOnInfoListener: OnInfoListener | null = null;
  private mOnSeekCompleteListener: OnSeekCompleteListener | null = null;
  private mOnTimedTextListener: OnTimedTextListener | null = null;
  private ijkplayer_napi: IjkPlayerNapi | null = null;

  setContext(context: object): void {
    this.ijkplayer_napi = context as IjkPlayerNapi;
  }

  setDebug(open: boolean): void {
    LogUtils.getInstance().setLogSwitch(open);
    if (open && !!this.ijkplayer_napi) {
      this.ijkplayer_napi._nativeOpenlog();
    }
  }

  // setDataSource(url: string): void {
  //   if (!!this.ijkplayer_napi)
  //     this.ijkplayer_napi._setDataSource(url);
  // }
  setDataSource(url: string, header:Map<string,string>) {

    var builder = '';
    let headers = new Map<string,string>([
    ["User-Agent", 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'],
    ["Referer", "https://www.bilibili.com"]
  ])
    promptAction.showToast({message:"headers类型：可以执行的"+headers+"  传递过来的"+header+"  是否一致: "+(headers == header)})
    if (headers) {
      headers.forEach((value, key) => {
        var parm = key.trim() + ": ";
        if (value)
          parm += value.trim();
        parm += "\r\n";
        builder += parm;
      });
      this.ijkplayer_napi._setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "headers", builder);
      this.ijkplayer_napi._setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "protocol_whitelist", "async,cache,crypto,file,http,https,ijkhttphook,ijkinject,ijklivehook,ijklongurl,ijksegment,ijktcphook,pipe,rtp,tcp,tls,udp,ijkurlhook,data");
    }
    this.ijkplayer_napi._setDataSource(url);
  }

  setDataSourceHeader(headers: Map<string, string>): void {
    if (headers) {
      let builder: string = '';
      headers.forEach((value, key) => {
        let param = key.trim() + ":";
        if (value)
          param += value.trim();
        param += "\r\n";
        builder += param;
      });
      console.log("拦截器后：setDataSourceHeader:"+`${builder}`)
      if (!!this.ijkplayer_napi) {
        this.ijkplayer_napi._setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "headers", builder);
        this.ijkplayer_napi._setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "protocol_whitelist", "async,cache,crypto,file,http,https,ijkhttphook,ijkinject,ijklivehook,ijklongurl,ijksegment,ijktcphook,pipe,rtp,tcp,tls,udp,ijkurlhook,data");
      }
    }
  }

  setOption(category: string, key: string, value: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setOption(category, key, value);
  }

  setOptionLong(category: string, key: string, value: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setOptionLong(category, key, value);
  }

  prepareAsync(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._prepareAsync();
  }

  start(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._start();
  }

  stop(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._stop();
  }

  pause(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._pause();
  }

  reset(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._reset();
  }

  release(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._release();
  }

  seekTo(msec: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._seekTo(msec);
  }

  setScreenOnWhilePlaying(on: boolean): void {
    window.getLastWindow(getContext(this), (err: object, data: window.Window) => {
      data.setWindowKeepScreenOn(on);
    });
  }

  setSpeed(speed: string): void {
    this._setPropertyFloat(PropertiesType.FFP_PROP_FLOAT_PLAYBACK_RATE, speed);
  }

  getSpeed(): number {
    return this._getPropertyFloat(PropertiesType.FFP_PROP_FLOAT_PLAYBACK_RATE, "0");
  }

  isPlaying(): boolean {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._isPlaying();
    else {
      return false
    }
  }

  setOnVideoSizeChangedListener(listener: OnVideoSizeChangedListener): void {
    this.mOnVideoSizeChangedListener = listener;
  }

  setOnPreparedListener(listener: OnPreparedListener): void {
    this.mOnPreparedListener = listener;
  }

  setOnCompletionListener(listener: OnCompletionListener): void {
    this.mOnCompletionListener = listener;
  }

  setOnInfoListener(listener: OnInfoListener): void {
    this.mOnInfoListener = listener;
  }

  setOnErrorListener(listener: OnErrorListener): void {
    this.mOnErrorListener = listener;
  }

  setOnBufferingUpdateListener(listener: OnBufferingUpdateListener): void {
    this.mOnBufferingUpdateListener = listener;
  }

  setOnSeekCompleteListener(listener: OnSeekCompleteListener): void {
    this.mOnSeekCompleteListener = listener;
  }

  setOnTimedTextListener(listener: OnTimedTextListener): void {
    this.mOnTimedTextListener = listener;
  }

  setMessageListener(): void {
    LogUtils.getInstance().LOGI("setMessageListener start");
    let that = this;
    let onVideoSizeChangedListener = this.mOnVideoSizeChangedListener;
    let onPreparedListener = this.mOnPreparedListener;
    let onCompletionListener = this.mOnCompletionListener;
    let onBufferingUpdateListener = this.mOnBufferingUpdateListener;
    let onErrorListener = this.mOnErrorListener;
    let onInfoListener = this.mOnInfoListener;
    let onSeekCompleteListener = this.mOnSeekCompleteListener;
    let onTimedTextListener = this.mOnTimedTextListener;
    let messageCallBack = (what: number, arg1: number, arg2: number, obj: string) => {
      LogUtils.getInstance()
        .LOGI("setMessageListener callback what:" + what + ", arg1:" + arg1 + ",arg2:" + arg2 + ",obj:" + obj);
      if (what == MessageType.MEDIA_PREPARED) {
        if (onPreparedListener !== null)
          onPreparedListener.onPrepared();
      }
      if (what == MessageType.MEDIA_SET_VIDEO_SAR) {
        if (arg1 != undefined && arg2 != undefined) {
          that.mVideoSarNum = arg1;
          that.mVideoSarDen = arg2;
        }
      }
      if (what == MessageType.MEDIA_SET_VIDEO_SIZE && onVideoSizeChangedListener != null) {
        onVideoSizeChangedListener.onVideoSizeChanged(arg1, arg2, that.mVideoSarNum, that.mVideoSarDen);
        if (arg1 != 0 && arg2 != 0) {
          that.mVideoWidth = arg1;
          that.mVideoHeight = arg2;
        }
      }

      if (what == MessageType.MEDIA_PLAYBACK_COMPLETE && onCompletionListener != null) {
        onCompletionListener.onCompletion();
      }

      if (!!that.ijkplayer_napi && what == MessageType.MEDIA_BUFFERING_UPDATE && onBufferingUpdateListener != null) {
        let bufferPosition = arg1;
        if (bufferPosition < 0) {
          bufferPosition = 0;
        }
        let percent = 0;
        let duration: number = that.ijkplayer_napi._getDuration();
        if (duration > 0) {
          percent = bufferPosition * 100 / duration;
        }
        if (percent >= 100) {
          percent = 100;
        }
        onBufferingUpdateListener.onBufferingUpdate(percent);
      }

      if (what == MessageType.MEDIA_ERROR && onErrorListener != null) {
        onErrorListener.onError(arg1, arg2);
      }
      if (what == MessageType.MEDIA_INFO && onInfoListener != null) {
        onInfoListener.onInfo(arg1, arg2);
      }
      if (what == MessageType.MEDIA_SEEK_COMPLETE && onSeekCompleteListener != null) {
        onSeekCompleteListener.onSeekComplete();
      }
      if (what == MessageType.MEDIA_TIMED_TEXT && onTimedTextListener != null) {
        onTimedTextListener.onTimedText(obj);
      }
    };
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setMessageListener(messageCallBack);
  }

  getVideoWidth(): number {
    return this.mVideoWidth;
  }

  getVideoHeight(): number {
    return this.mVideoHeight;
  }

  getVideoSarNum(): number {
    return this.mVideoSarNum;
  }

  getVideoSarDen(): number {
    return this.mVideoSarDen;
  }

  getDuration(): number {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getDuration();
    else {
      return 0
    }
  }

  getCurrentPosition(): number {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getCurrentPosition();
    else {
      return 0
    }
  }

  getAudioSessionId(): number {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getAudioSessionId();
    else {
      return 0
    }
  }

  private _setPropertyFloat(property: string, value: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setPropertyFloat(property, value);
  }

  private _getPropertyFloat(property: string, value: string): number {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getPropertyFloat(property, value);
    else {
      return 0
    }
  }

  private _setPropertyLong(property: string, value: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setPropertyLong(property, value);
  }

  private _getPropertyLong(property: string, value: string): number {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getPropertyLong(property, value);
    else {
      return 0
    }
  }

  setVolume(leftVolume: string, rightVolume: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setVolume(leftVolume, rightVolume);
  }

  setLoopCount(looping: boolean): void {
    let loopCount = looping ? "0" : "1";
    this.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "loop", loopCount);
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setLoopCount(loopCount);
  }

  isLooping(): boolean {
    let loopCount: number = 0
    if (!!this.ijkplayer_napi)
      loopCount = this.ijkplayer_napi._getLoopCount();
    return loopCount != 1;
  }

  selectTrack(track: string): void {
    if (!!this.ijkplayer_napi)
      this._setStreamSelected(track, "true");
  }

  deselectTrack(track: string): void {
    this._setStreamSelected(track, "false");
  }

  private _setStreamSelected(stream: string, select: string): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._setStreamSelected(stream, select);
  }

  getVideoDecoder(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_VIDEO_DECODER, PropertiesType.FFP_PROPV_DECODER_UNKNOWN);
  }

  getVideoOutputFramesPerSecond(): number {
    return this._getPropertyFloat(PropertiesType.PROP_FLOAT_VIDEO_OUTPUT_FRAMES_PER_SECOND, "0");
  }

  getVideoDecodeFramesPerSecond(): number {
    return this._getPropertyFloat(PropertiesType.PROP_FLOAT_VIDEO_DECODE_FRAMES_PER_SECOND, "0");
  }

  getVideoCachedDuration(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_VIDEO_CACHED_DURATION, "0");
  }

  getAudioCachedDuration(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_AUDIO_CACHED_DURATION, "0");
  }

  getVideoCachedBytes(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_VIDEO_CACHED_BYTES, "0");
  }

  getAudioCachedBytes(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_AUDIO_CACHED_BYTES, "0");
  }

  getVideoCachedPackets(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_VIDEO_CACHED_PACKETS, "0");
  }

  getAudioCachedPackets(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_AUDIO_CACHED_PACKETS, "0");
  }

  getAsyncStatisticBufBackwards(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_ASYNC_STATISTIC_BUF_BACKWARDS, "0");
  }

  getAsyncStatisticBufForwards(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_ASYNC_STATISTIC_BUF_FORWARDS, "0");
  }

  getAsyncStatisticBufCapacity(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_ASYNC_STATISTIC_BUF_CAPACITY, "0");
  }

  getTrafficStatisticByteCount(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_TRAFFIC_STATISTIC_BYTE_COUNT, "0");
  }

  getCacheStatisticPhysicalPos(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_CACHE_STATISTIC_PHYSICAL_POS, "0");
  }

  getCacheStatisticFileForwards(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_CACHE_STATISTIC_FILE_FORWARDS, "0");
  }

  getCacheStatisticFilePos(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_CACHE_STATISTIC_FILE_POS, "0");
  }

  getCacheStatisticCountBytes(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_CACHE_STATISTIC_COUNT_BYTES, "0");
  }

  getFileSize(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_LOGICAL_FILE_SIZE, "0");
  }

  getBitRate(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_BIT_RATE, "0");
  }

  getTcpSpeed(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_TCP_SPEED, "0");
  }

  getSeekLoadDuration(): number {
    return this._getPropertyLong(PropertiesType.FFP_PROP_INT64_LATEST_SEEK_LOAD_DURATION, "0");
  }

  getDropFrameRate(): number {
    return this._getPropertyFloat(PropertiesType.FFP_PROP_FLOAT_DROP_FRAME_RATE, "0");
  }

  setCacheShare(share: string) {
    this._setPropertyLong(PropertiesType.FFP_PROP_INT64_SHARE_CACHE_DATA, share);
  }

  private _getVideoCodecInfo(): string {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getVideoCodecInfo();
    else {
      return ''
    }
  }

  private _getAudioCodecInfo(): string {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getAudioCodecInfo();
    else {
      return ''
    }
  }

  private _getMediaMeta(): string {
    if (!!this.ijkplayer_napi)
      return this.ijkplayer_napi._getMediaMeta();
    else {
      return ''
    }
  }

  getMediaInfo(): object {
    interface mediaInfoType {
      audioDecoder: string
      videoDecoder: string
      meta: string
    }

    let mAudioDecoder = this._getAudioCodecInfo();
    let mVideoDecoder = this._getVideoCodecInfo();
    let mMeta = this._getMediaMeta();
    let mediaInfo: mediaInfoType = { audioDecoder: mAudioDecoder, videoDecoder: mVideoDecoder, meta: mMeta };
    return mediaInfo;
  }

  native_setup(): void {
    if (!!this.ijkplayer_napi)
      this.ijkplayer_napi._native_setup();
  }
}

