import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input', 'toggle']

  copy() {
    navigator.clipboard.writeText(this.inputTarget.value)
  }

  toggle() {
    const type = this.inputTarget.type
    let newType, newText
    if (type === 'password') {
      newType = 'text'
      newText = 'Hide'
    } else {
      newType = 'password'
      newText = 'Show'
    }
    this.inputTarget.setAttribute('type', newType)
    this.toggleTarget.textContent = newText
  }
}
