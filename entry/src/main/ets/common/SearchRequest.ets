@Observed
export class SearchRequest{
  public request :()=>void

  constructor(request:()=>void) {
    this.request = request
  }
}