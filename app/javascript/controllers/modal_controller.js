import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    'modal'
  ]

  show(e) {
    e.preventDefault();

    this.modalTarget.open = true
    this.modalTarget.querySelectorAll('x-transition').forEach((transition) => {
      transition.open = true
    })
  }

  hide(e) {
    e.preventDefault()

    this.modalTarget.querySelectorAll('x-transition').forEach((transition) => {
      transition.open = false
    })
    this.modalTarget.open = false

    this.dispatch('closed')
  }
}
