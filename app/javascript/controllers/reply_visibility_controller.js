import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = [ "hideableReply" ]

  toggleTargets() {
    this.hideableReplyTargets.forEach((element) => {
      element.hidden = !element.hidden
    });
  }
}