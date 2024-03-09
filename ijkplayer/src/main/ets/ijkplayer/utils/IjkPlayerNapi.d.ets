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
export declare class IjkPlayerNapi {
  _nativeOpenlog(): void;
  _setDataSource(url:string): void;
  _setOption(category:string,key:string,value:string): void;
  _setOptionLong(category:string,key:string,value:string): void;
  _prepareAsync(): void;
  _start(): void;
  _stop(): void;
  _pause(): void;
  _reset(): void;
  _release(): void;
  _seekTo(msec:string): void;
  _isPlaying(): boolean;
  _getDuration(): number;
  _setMessageListener(messageCallBack:Function): void;
  _getCurrentPosition(): number;
  _getAudioSessionId(): number;
  _setPropertyFloat(property: string, value: string): void;
  _getPropertyFloat(property: string, value: string): number;
  _setPropertyLong(property: string, value: string): void;
  _getPropertyLong(property: string, value: string): number;
  _setVolume(leftVolume: string, rightVolume: string): void;
  _setLoopCount(loopCount: string): void;
  _getLoopCount(): number;
  _setStreamSelected(stream: string, select: string): void;
  _getVideoCodecInfo(): string;
  _getAudioCodecInfo(): string;
  _getMediaMeta(): string;
  _native_setup(): void;
}