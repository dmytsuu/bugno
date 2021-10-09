import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  navigate() {
    const trace = this.element.querySelector("input[type='checkbox']:checked + .container-content")
    if (trace) trace.scrollIntoView({ behavior: 'smooth' })
  }

  top() {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  copyTraceFilename(e) {
    navigator.clipboard.writeText(e.target.dataset.filename)
  }

  copy(e) {
    console.log('E', e)
    navigator.clipboard.writeText(e.target.innerText)
  }
}
