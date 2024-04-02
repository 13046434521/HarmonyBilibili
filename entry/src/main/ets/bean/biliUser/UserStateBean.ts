/*
{
    "code": 0,
    "message": "0",
    "ttl": 1,
    "data": {
        "following": 275,
        "follower": 14,
        "dynamic_count": 42
    }
}
*/

// https://api.bilibili.com/x/web-interface/nav/stat
// 登录用户状态数（双端）

export interface UserStateBean{
  following: number,
  follower: number,
  dynamic_count: number
}