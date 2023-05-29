import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["count", "icon"];
  static values = { isLiked: Boolean };

  connect() {
    this.isLikedValue = false;
  }

  increment(event) {
    event.preventDefault();
    this.isLikedValue = !this.isLikedValue;

    // Replace `/blog_posts/${this.data.get("id")}/like` with your route
    fetch(`/blog_posts/${this.data.get("id")}/like`, {
      method: "POST",
      headers: {
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").getAttribute('content'),
        'Content-Type': 'application/json'
      },
    })
      .then(response => response.json())
      .then(data => {
        this.countTarget.innerText = data.likes;
      });
  }

  isLikedValueChanged() {
    if (this.isLikedValue) {
      this.iconTarget.classList.remove('fa-regular');
      this.iconTarget.classList.add('fa-solid');
    } else {
      this.iconTarget.classList.remove('fa-solid');
      this.iconTarget.classList.add('fa-regular');
    }
  }
}
