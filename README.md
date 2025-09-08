# Task Manager

A Rails 7 task management app with PostgreSQL, Turbo, and Stimulus, fully containerized with Docker Compose.

---

## Development Setup

Everything is handled by Docker Compose and the entrypoint script. To get started:

* **Clone the repository:**  
  `git clone https://github.com/AminaYH/tasks_manager.git && cd tasks_manager`

* **Build and start containers:**  
  `docker-compose build && docker-compose up -d`

* **Access the app:**  
  Open your browser at [http://localhost:3000](http://localhost:3000)

* **Stop containers when done:**  
  `docker-compose down`

---

## Notes

* **Rails Server:** Runs on port `3000`  
* **Database:** PostgreSQL runs in the `db` container on port `5432`  
* **Live Updates:** Task completion toggles instantly using Turbo Frames and Stimulus controllers
