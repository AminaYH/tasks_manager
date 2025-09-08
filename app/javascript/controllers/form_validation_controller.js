import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.inputTargets.forEach(input => {
      input.addEventListener("blur", () => this.validateField(input))
    })
  }

  validateField(input) {
    if (!input.checkValidity()) {
      input.classList.add("is-invalid")
      input.classList.remove("is-valid")
    } else {
      input.classList.remove("is-invalid")
      input.classList.add("is-valid")
    }
  }

  validateForm(event) {
    if (!this.element.checkValidity()) {
      event.preventDefault()
      event.stopPropagation()
      this.inputTargets.forEach(input => this.validateField(input))
    }
    this.element.classList.add("was-validated")
  }
}
