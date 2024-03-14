export class  BaseResponse<T> {
  data: T
  message?: string
  code: number
  ttl: number
}
