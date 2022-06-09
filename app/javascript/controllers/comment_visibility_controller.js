import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = [ "hideableComment" ]

  toggleTargets() {
    this.hideableCommentTargets.forEach((element) => {
      element.hidden = !element.hidden
    });
  }
}