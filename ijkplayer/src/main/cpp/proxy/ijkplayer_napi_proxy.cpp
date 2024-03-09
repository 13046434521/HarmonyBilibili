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

#include "ijkplayer_napi_proxy.h"
static IjkMediaPlayer *GLOBAL_IJKMP = nullptr;
static void (*post_event)(void *weak_this, int what, int arg1, int arg2, char *obj);

void IJKPlayerNapiProxy::message_loop_callback(void (*pe)(void *weak_this, int what, int arg1, int arg2, char *obj)) {
    post_event = pe;
}

static void message_loop_n(IjkMediaPlayer *mp) {
    LOGI("napi_proxy-->message_loop_n");
    void *weak_thiz = ijkmp_get_weak_thiz(mp);

    while (1) {
        AVMessage msg;
        LOGI("napi_proxy-->message_loop_n-->go");
        int retval = ijkmp_get_msg(mp, &msg, 1);
        if (retval < 0)
            break;

        // block-get should never return 0
        assert(retval > 0);

        switch (msg.what) {
            LOGI("napi_proxy-->message_loop_n-->go-->msg:%d", msg.what);
        case FFP_MSG_FLUSH:
            MPTRACE("FFP_MSG_FLUSH:\n");
            post_event(weak_thiz, MEDIA_NOP, 0, 0, NULL);
            break;
        case FFP_MSG_ERROR:
            MPTRACE("FFP_MSG_ERROR: %d\n", msg.arg1);
            post_event(weak_thiz, MEDIA_ERROR, MEDIA_ERROR_IJK_PLAYER, msg.arg1, NULL);
            break;
        case FFP_MSG_PREPARED:
            MPTRACE("FFP_MSG_PREPARED:\n");
            post_event(weak_thiz, MEDIA_PREPARED, 0, 0, NULL);
            break;
        case FFP_MSG_COMPLETED:
            MPTRACE("FFP_MSG_COMPLETED:\n");
            post_event(weak_thiz, MEDIA_PLAYBACK_COMPLETE, 0, 0, NULL);
            break;
        case FFP_MSG_VIDEO_SIZE_CHANGED:
            MPTRACE("FFP_MSG_VIDEO_SIZE_CHANGED: %d, %d\n", msg.arg1, msg.arg2);
            post_event(weak_thiz, MEDIA_SET_VIDEO_SIZE, msg.arg1, msg.arg2, NULL);
            break;
        case FFP_MSG_SAR_CHANGED:
            MPTRACE("FFP_MSG_SAR_CHANGED: %d, %d\n", msg.arg1, msg.arg2);
            post_event(weak_thiz, MEDIA_SET_VIDEO_SAR, msg.arg1, msg.arg2, NULL);
            break;
        case FFP_MSG_VIDEO_RENDERING_START:
            MPTRACE("FFP_MSG_VIDEO_RENDERING_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_VIDEO_RENDERING_START, 0, NULL);
            break;
        case FFP_MSG_AUDIO_RENDERING_START:
            MPTRACE("FFP_MSG_AUDIO_RENDERING_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_AUDIO_RENDERING_START, 0, NULL);
            break;
        case FFP_MSG_VIDEO_ROTATION_CHANGED:
            MPTRACE("FFP_MSG_VIDEO_ROTATION_CHANGED: %d\n", msg.arg1);
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_VIDEO_ROTATION_CHANGED, msg.arg1, NULL);
            break;
        case FFP_MSG_AUDIO_DECODED_START:
            MPTRACE("FFP_MSG_AUDIO_DECODED_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_AUDIO_DECODED_START, 0, NULL);
            break;
        case FFP_MSG_VIDEO_DECODED_START:
            MPTRACE("FFP_MSG_VIDEO_DECODED_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_VIDEO_DECODED_START, 0, NULL);
            break;
        case FFP_MSG_OPEN_INPUT:
            MPTRACE("FFP_MSG_OPEN_INPUT:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_OPEN_INPUT, 0, NULL);
            break;
        case FFP_MSG_FIND_STREAM_INFO:
            MPTRACE("FFP_MSG_FIND_STREAM_INFO:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_FIND_STREAM_INFO, 0, NULL);
            break;
        case FFP_MSG_COMPONENT_OPEN:
            MPTRACE("FFP_MSG_COMPONENT_OPEN:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_COMPONENT_OPEN, 0, NULL);
            break;
        case FFP_MSG_BUFFERING_START:
            MPTRACE("FFP_MSG_BUFFERING_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_BUFFERING_START, msg.arg1, NULL);
            break;
        case FFP_MSG_BUFFERING_END:
            MPTRACE("FFP_MSG_BUFFERING_END:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_BUFFERING_END, msg.arg1, NULL);
            break;
        case FFP_MSG_BUFFERING_UPDATE:
            // MPTRACE("FFP_MSG_BUFFERING_UPDATE: %d, %d", msg.arg1, msg.arg2);
            post_event(weak_thiz, MEDIA_BUFFERING_UPDATE, msg.arg1, msg.arg2, NULL);
            break;
        case FFP_MSG_BUFFERING_BYTES_UPDATE:
            break;
        case FFP_MSG_BUFFERING_TIME_UPDATE:
            break;
        case FFP_MSG_SEEK_COMPLETE:
            MPTRACE("FFP_MSG_SEEK_COMPLETE:\n");
            post_event(weak_thiz, MEDIA_SEEK_COMPLETE, 0, 0, NULL);
            break;
        case FFP_MSG_ACCURATE_SEEK_COMPLETE:
            MPTRACE("FFP_MSG_ACCURATE_SEEK_COMPLETE:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_MEDIA_ACCURATE_SEEK_COMPLETE, msg.arg1, NULL);
            break;
        case FFP_MSG_PLAYBACK_STATE_CHANGED:
            break;
        case FFP_MSG_TIMED_TEXT:
            if (msg.obj) {
                post_event(weak_thiz, MEDIA_TIMED_TEXT, 0, 0, (char *)msg.obj);
            } else {
                post_event(weak_thiz, MEDIA_TIMED_TEXT, 0, 0, NULL);
            }
            break;
        case FFP_MSG_GET_IMG_STATE:
            if (msg.obj) {
                post_event(weak_thiz, MEDIA_GET_IMG_STATE, msg.arg1, msg.arg2, (char *)msg.obj);
            } else {
                post_event(weak_thiz, MEDIA_GET_IMG_STATE, msg.arg1, msg.arg2, NULL);
            }
            break;
        case FFP_MSG_VIDEO_SEEK_RENDERING_START:
            MPTRACE("FFP_MSG_VIDEO_SEEK_RENDERING_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_VIDEO_SEEK_RENDERING_START, msg.arg1, NULL);
            break;
        case FFP_MSG_AUDIO_SEEK_RENDERING_START:
            MPTRACE("FFP_MSG_AUDIO_SEEK_RENDERING_START:\n");
            post_event(weak_thiz, MEDIA_INFO, MEDIA_INFO_AUDIO_SEEK_RENDERING_START, msg.arg1, NULL);
            break;
        default:
            ALOGE("unknown FFP_MSG_xxx(%d)\n", msg.what);
            break;
        }
        msg_free_res(&msg);
    }

}

static int message_loop(void *arg);

static int message_loop(void *arg) {
    LOGI("napi_proxy-->message_loop");
    IjkMediaPlayer *mp = (IjkMediaPlayer *)arg;
    message_loop_n(mp);
    return 0;
}

IjkMediaPlayer *IJKPlayerNapiProxy::IJKPlayerNapiProxy::get_media_player() {
    LOGI("napi_proxy-->get_media_player");
    IjkMediaPlayer *mp = GLOBAL_IJKMP;
    if (mp) {
        ijkmp_inc_ref(mp);
    }
    return mp;
}

IjkMediaPlayer *IJKPlayerNapiProxy::set_media_player(IjkMediaPlayer *mp) {
    LOGI("napi_proxy-->set_media_player");
    if (mp) {
        ijkmp_inc_ref(mp);
    }
    GLOBAL_IJKMP = mp;
    return mp;
}

void IJKPlayerNapiProxy::IjkMediaPlayer_native_setup(void *weak_this, void *native_window) {
    LOGI("napi_proxy-->IjkMediaPlayer_native_setup");
    if (!IJKMP_GLOABL_INIT) {
        ijkmp_global_init();
    }
    IJKMP_GLOABL_INIT = true;
    GLOBAL_NATIVE_WINDOW = native_window;
    IjkMediaPlayer *mp = ijkmp_android_create(message_loop);
    IJKPlayerNapiProxy::set_media_player(mp);
    ijkmp_android_set_surface(mp, native_window);
    ijkmp_set_weak_thiz(mp, weak_this);
    ijkmp_set_inject_opaque(mp, ijkmp_get_weak_thiz(mp));
    ijkmp_set_ijkio_inject_opaque(mp, ijkmp_get_weak_thiz(mp));
}

void IJKPlayerNapiProxy::IjkMediaPlayer_setDataSource(char *url) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_set_data_source(mp, url);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_setOption(int category, char *name, char *value) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_set_option(mp, category, name, value);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_setOptionLong(int category, char *name, int64_t value) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_set_option_int(mp, category, name, value);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_prepareAsync() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_prepare_async(mp);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_start() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_start(mp);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_pause() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_pause(mp);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_seekTo(int64_t msec) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_seek_to(mp, msec);
}

bool IJKPlayerNapiProxy::IjkMediaPlayer_isPlaying() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    return ijkmp_is_playing(mp) ? true : false;
}

int IJKPlayerNapiProxy::IjkMediaPlayer_getCurrentPosition() {
    int retval = 0;
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    retval = ijkmp_get_current_position(mp);
    return retval;
}

int IJKPlayerNapiProxy::IjkMediaPlayer_getDuration() {
    int retval = 0;
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    retval = ijkmp_get_duration(mp);
    return retval;
}

void IJKPlayerNapiProxy::IjkMediaPlayer_stop() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_stop(mp);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_release() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    if (!mp)
        return;
    ijkmp_shutdown(mp);
    ijkmp_dec_ref_p(&mp);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_reset() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    if (!mp)
        return;
    ijkmp_android_set_surface(mp, NULL);
    void *weak_thiz = ijkmp_set_weak_thiz(mp, NULL);
    IjkMediaPlayer_release();
    LOGI("napi_proxy-->IjkMediaPlayer_reset");
    ijkmp_dec_ref_p(&mp);
}

void IJKPlayerNapiProxy::IjkMediaPlayer_setVolume(float leftVolume, float rightVolume) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_android_set_volume(mp, leftVolume, rightVolume);
}

void IJKPlayerNapiProxy::ijkMediaPlayer_setPropertyFloat(int id, float value) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_set_property_float(mp, id, value);
}

float IJKPlayerNapiProxy::ijkMediaPlayer_getPropertyFloat(int id, float default_value) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    return ijkmp_get_property_float(mp, id, default_value);
}

void IJKPlayerNapiProxy::ijkMediaPlayer_setPropertyLong(int id, long value) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_set_property_int64(mp, id, value);
}

long IJKPlayerNapiProxy::ijkMediaPlayer_getPropertyLong(int id, long default_value) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    return ijkmp_get_property_int64(mp, id, default_value);
}

int IJKPlayerNapiProxy::IjkMediaPlayer_getAudioSessionId() {
    int audio_session_id = 0;
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    audio_session_id = ijkmp_android_get_audio_session_id(mp);
    return audio_session_id;
}

void IJKPlayerNapiProxy::IjkMediaPlayer_setLoopCount(int loop_count) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_set_loop(mp, loop_count);
}

int IJKPlayerNapiProxy::IjkMediaPlayer_getLoopCount() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    int loop_count = ijkmp_get_loop(mp);
    return loop_count;
}

char *IJKPlayerNapiProxy::IjkMediaPlayer_getVideoCodecInfo() {
    char *codec_info = NULL;
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_get_video_codec_info(mp, &codec_info);
    return codec_info;
}

char *IJKPlayerNapiProxy::IjkMediaPlayer_getAudioCodecInfo() {
    MPTRACE("%s\n", __func__);
    char *codec_info = NULL;
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    ijkmp_get_audio_codec_info(mp, &codec_info);
    return codec_info;
}

void IJKPlayerNapiProxy::ijkMediaPlayer_setStreamSelected(int stream, bool selected) {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    int ret = 0;
    ret = ijkmp_set_stream_selected(mp, stream, selected);
    if (ret < 0) {
        LOGI("failed to %s %d", selected ? "select" : "deselect", stream);
        ijkmp_dec_ref_p(&mp);
    }
}

const char *getFromMediaMetaByKey(IjkMediaMeta *meta, char *key) {
    const char *value = ijkmeta_get_string_l(meta, key);
    return value;
}

HashMap IJKPlayerNapiProxy::IjkMediaPlayer_getMediaMeta() {
    IjkMediaPlayer *mp = IJKPlayerNapiProxy::get_media_player();
    IjkMediaMeta *meta = ijkmp_get_meta_l(mp);
    size_t count = ijkmeta_get_children_count_l(meta);
    HashMap map = hashmap_create();
    for (size_t i = 0; i < count; ++i) {
        IjkMediaMeta *streamRawMeta = ijkmeta_get_child_l(meta, i);
        if (streamRawMeta) {
            map->put(map, (void *)IJKM_KEY_TYPE, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_TYPE));
            map->put(map, (void *)IJKM_KEY_TYPE, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_TYPE));
            map->put(map, (void *)IJKM_KEY_LANGUAGE, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_LANGUAGE));
            const char *type = ijkmeta_get_string_l(streamRawMeta, IJKM_KEY_TYPE);
            if (type) {
                map->put(map, (void *)IJKM_KEY_CODEC_NAME, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CODEC_NAME));
                map->put(map, (void *)IJKM_KEY_CODEC_PROFILE, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CODEC_PROFILE));
                map->put(map, (void *)IJKM_KEY_CODEC_LEVEL, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CODEC_LEVEL));
                map->put(map, (void *)IJKM_KEY_CODEC_LONG_NAME, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CODEC_LONG_NAME));
                map->put(map, (void *)IJKM_KEY_CODEC_PIXEL_FORMAT, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CODEC_PIXEL_FORMAT));
                map->put(map, (void *)IJKM_KEY_BITRATE, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_BITRATE));
                map->put(map, (void *)IJKM_KEY_CODEC_PROFILE_ID, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CODEC_PROFILE_ID));
                if (0 == strcmp(type, IJKM_VAL_TYPE__VIDEO)) {
                    map->put(map, (void *)IJKM_KEY_WIDTH, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_WIDTH));
                    map->put(map, (void *)IJKM_KEY_HEIGHT, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_HEIGHT));
                    map->put(map, (void *)IJKM_KEY_FPS_NUM, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_FPS_NUM));
                    map->put(map, (void *)IJKM_KEY_TBR_NUM, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_TBR_NUM));
                    map->put(map, (void *)IJKM_KEY_TBR_DEN, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_TBR_DEN));
                    map->put(map, (void *)IJKM_KEY_SAR_NUM, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_SAR_NUM));
                    map->put(map, (void *)IJKM_KEY_SAR_DEN, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_SAR_DEN));
                } else if (0 == strcmp(type, IJKM_VAL_TYPE__AUDIO)) {
                    map->put(map, (void *)IJKM_KEY_SAMPLE_RATE, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_SAMPLE_RATE));
                    map->put(map, (void *)IJKM_KEY_CHANNEL_LAYOUT, (void *)getFromMediaMetaByKey(streamRawMeta, IJKM_KEY_CHANNEL_LAYOUT));
                }
            }
        }
    }
    return map;
}

void IJKPlayerNapiProxy::IjkMediaPlayer_native_openlog() {
    OHOS_LOG_ON = true;
    open_custom_ffmpeg_log_print();
}
