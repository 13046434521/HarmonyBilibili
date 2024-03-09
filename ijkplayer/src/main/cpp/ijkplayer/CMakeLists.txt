# the minimum version of CMake.
cmake_minimum_required(VERSION 3.4.1)

project("ijkplayer")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-int-conversion")

add_definitions(-DOHOS_PLATFORM)

add_library(ijkplayer  SHARED
                               ff_cmdutils.c
                               ff_ffplay.c
                               ff_ffpipeline.c
                               ff_ffpipenode.c
                               ijkmeta.c
                               ijkplayer.c
                               ijkplayer_android.c
                               pipeline/ffpipenode_ffplay_vdec.c
                               pipeline/ffpipeline_android.c
                               ijkavformat/allformats.c
                               ijkavformat/ijklivehook.c
                               ijkavformat/ijkio.c
                               ijkavformat/ijkiomanager.c
                               ijkavformat/ijkiocache.c
                               ijkavformat/ijkioffio.c
                                ijkavformat/ijkioprotocol.c
                                ijkavformat/ijkioapplication.c
                                ijkavformat/ijkiourlhook.c
                                ijkavformat/ijkasync.c
                                ijkavformat/ijkurlhook.c
                                ijkavformat/ijklongurl.c
                                ijkavformat/ijksegment.c
                                ijkavutil/ijkdict.c
                                ijkavutil/ijkutils.c
                                ijkavutil/ijkthreadpool.c
                                 ijkavutil/ijktree.c
                                 ijkavutil/ijkfifo.c
                                 ijkavutil/ijkstl.cpp
                                  )


add_library(soundtouch STATIC IMPORTED)
set_target_properties(soundtouch PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/../third_party/soundtouch/${OHOS_ARCH}/libsoundtouch.a)

add_library(ijkffmpeg SHARED IMPORTED)
set_target_properties(ijkffmpeg PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/../../../../libs/${OHOS_ARCH}/libijkffmpeg.z.so)

add_library(ijksdl_so SHARED IMPORTED)
set_target_properties(ijksdl_so PROPERTIES IMPORTED_LOCATION ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/libijksdl.so)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../third_party/ffmpeg/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../third_party/yuv/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../third_party/soundtouch/include)



target_link_libraries(ijkplayer ijkffmpeg)
target_link_libraries(ijkplayer ijksdl_so)
target_link_libraries(ijkplayer EGL)
target_link_libraries(ijkplayer GLESv3)
target_link_libraries(ijkplayer hilog_ndk.z)
target_link_libraries(ijkplayer soundtouch)