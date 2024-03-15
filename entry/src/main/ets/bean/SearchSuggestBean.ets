export class SearchSuggestBean {
  exp_str: string
  code: number
  result: SearchSuggestResultBean
  stoken: number
}

export class SearchSuggestResultBean {
  tag: SearchSuggestTagBean[]
}
@Observed
export class SearchSuggestTagBean {
  value: string
  term: string
  ref: number
  name: string
  spid: number
  type: string
}