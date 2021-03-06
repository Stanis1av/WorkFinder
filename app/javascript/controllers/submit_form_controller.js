import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

  submit() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this._submit();
    }, 500);
  }

  _submit() {
    this.formTarget.requestSubmit();
  }
}
