import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["count", "icon"];
  static values = { isLiked: Boolean, id: Number };

  connect() {
    this.checkIfPostIsLiked();
    this.updateIcon();
  }

  increment(event) {
    event.preventDefault();
    this.isLikedValue = !this.isLikedValue;

    fetch(`/blog_posts/${this.idValue}/like`, {
      method: "POST",
      headers: {
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").getAttribute('content'),
        'Content-Type': 'application/json'
      },
    })
      .then(response => response.json())
      .then(data => {
        this.countTarget.innerText = data.likes;
        this.updateLikedPostsInLocalStorage();
        this.updateIcon();
      });
  }

  updateIcon() {
    if (this.isLikedValue) {
      this.iconTarget.classList.remove('fa-regular');
      this.iconTarget.classList.add('fa-solid');
    } else {
      this.iconTarget.classList.remove('fa-solid');
      this.iconTarget.classList.add('fa-regular');
    }
  }

  checkIfPostIsLiked() {
    const likedPosts = this.getLikedPostsFromLocalStorage();
    this.isLikedValue = likedPosts.includes(this.idValue.toString());
  }

  getLikedPostsFromLocalStorage() {
    const likedPosts = localStorage.getItem('liked_posts');
    return likedPosts ? JSON.parse(likedPosts) : [];
  }

  updateLikedPostsInLocalStorage() {
    const likedPosts = this.getLikedPostsFromLocalStorage();
    const index = likedPosts.indexOf(this.idValue.toString());
    if (index > -1) {
      likedPosts.splice(index, 1);
    } else {
      likedPosts.push(this.idValue.toString());
    }
    localStorage.setItem('liked_posts', JSON.stringify(likedPosts));
  }
}
