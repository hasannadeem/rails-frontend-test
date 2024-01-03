import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "activeField"];

  toggle() {
    if (this.iconTarget.classList.contains("toggle-off")) {
      this.iconTarget.querySelector("img").src = "/assets/icons/eye-open.svg";
    } else {
      this.iconTarget.querySelector("img").src = "/assets/icons/eye-off.svg";
    }

    this.iconTarget.classList.toggle('toggle-off')
    this.iconTarget.classList.toggle('toggle-on')

    this.updateActiveField();
  }

  updateActiveField() {
    const isActive = this.iconTarget.classList.contains('toggle-off');
    this.activeFieldTarget.value = isActive ? 'false' : 'true';
  }
}
