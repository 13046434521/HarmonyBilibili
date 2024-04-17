//https://api.bilibili.com/x/v2/reply/wbi/main?mode=2&oid=450096728&type=1&wts=1713326925&w_rid=7cb32375f87e393568d8b969ac8d700f
// 获取评论 oid为aid

export default class CommentsInfo{
  "cursor": {
    "is_begin": true,
    "prev": 8097,
    "next": 8067,
    "is_end": false,
    "mode": 2,
    "mode_text": "",
    "all_count": 8163,
    "support_mode": [2, 3],
    "name": "最新评论",
    "pagination_reply": {
      "next_offset": "{\"type\":3,\"direction\":1,\"Data\":{\"cursor\":8067}}"
    },
    "session_id": ""
  }
  "replies":CommentsReply[]
}

export class CommentsReply{

}