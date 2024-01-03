import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      group: 'shared',
      animation: 150,
      onEnd: this.end.bind(this)
    });
  }

  end(event) {
    const contianerDiv = document.getElementById('container_form');
    const childDivs = contianerDiv.querySelectorAll('li.dashboard-form-fields');
    let position = 0;
    for (let i = 0; i < childDivs.length; i++) {
        if (childDivs[i].getAttribute('data-id') == event.item.dataset.id) {
            position = i + 1;
            break;
        }
    }

    const id = event.item.dataset.id;
    let data = new FormData();
    data.append('ordering', position);

    const url = `/storefronts/1/update_ordering?reason_id=${id}`;

    Rails.ajax({
        url: url,
        type: 'PATCH',
        data: data,
    });
  }

}
