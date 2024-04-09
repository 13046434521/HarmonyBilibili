export interface SearchSuggestBean {
  exp_str: string
  code: number
  result: SearchSuggestResultBean
  stoken: number
}

export interface SearchSuggestResultBean {
  tag: SearchSuggestTagBean[]
}

export interface SearchSuggestTagBean {
  value: string
  term: string
  ref: number
  name: string
  spid: number
  type: string
}