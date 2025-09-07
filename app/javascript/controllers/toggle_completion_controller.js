import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { taskId: Number }

  toggle() {
    fetch(`/tasks/${this.taskIdValue}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ task: { completed: !this.element.dataset.toggleCompletionCompletedValue } })
    })
  }
}
