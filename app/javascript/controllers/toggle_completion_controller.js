import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static values = { taskId: Number, completed: Boolean }

  toggle() {
    const newCompleted = !this.completedValue

    fetch(`/tasks/${this.taskIdValue}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ task: { completed: newCompleted } })
    })
      .then(response => response.text())
      .then(turboStream => {
        Turbo.renderStreamMessage(turboStream) // <-- this is required to apply Turbo Stream
      })
  }
}
