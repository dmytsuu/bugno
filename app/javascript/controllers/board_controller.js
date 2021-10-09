import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['list']

  connect() {
    this.listTargets.forEach((item, i) => {
      item.addEventListener('dragover', (e) => e.preventDefault())
      item.addEventListener('drop', this.drop)
    });

  }

  drop(e) {
    e.preventDefault();
    const id = e.dataTransfer.getData("id");
    const status = e.dataTransfer.getData("status");
    const newStatus = this.dataset.status
    if (status !== newStatus) {
      const selector = `#${id} .${newStatus}-status-form input[type='submit']`
      const form = document.querySelector(selector)
      form.click()
    }
  }

  drag(e) {
    e.dataTransfer.setData("id", e.target.parentElement.id);
    e.dataTransfer.setData("status", e.target.parentElement.dataset.status);
  }
}
