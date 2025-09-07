import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.querySelectorAll("[data-field]").forEach(el => {
      el.addEventListener("click", this.edit.bind(this))
    })
  }

  edit(event) {
    const el = event.target
    const field = el.dataset.field
    const value = el.innerText

    const input = document.createElement("input")
    input.type = "text"
    input.value = value
    input.className = "form-control"

    input.addEventListener("blur", () => this.save(el, input, field))
    input.addEventListener("keydown", e => {
      if (e.key === "Enter") input.blur()
    })

    el.replaceWith(input)
    input.focus()
  }

  save(originalEl, inputEl, field) {
    const taskId = this.element.dataset.taskId
    const value = inputEl.value

    const token = document.querySelector('meta[name="csrf-token"]').content

    fetch(`/tasks/${taskId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({ task: { [field]: value } })
    })
      .then(response => {
        if (response.ok) {
          originalEl.innerText = value
        } else {
          console.error("Update failed", response)
        }
        inputEl.replaceWith(originalEl)
      })
      .catch(err => {
        console.error("Error updating task:", err)
        inputEl.replaceWith(originalEl)
      })
  }
}
