import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "photoInput", "photoPreview" ]

  photo_input() {
    const input = this.photoInputTarget

    if (input) {
      // add a listener to know when a new picture is uploaded
      input.addEventListener('change', () => {
        // call the displayPreview function, which retrieves the image url and displays it)
        displayPreview(input);
      })
    }

    const displayPreview = (input) => {
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (event) => {
          this.photoPreviewTarget.src = event.currentTarget.result
        }
        reader.readAsDataURL(input.files[0])
        this.photoPreviewTarget.classList.remove('hidden')
      }
    }
  }

}
