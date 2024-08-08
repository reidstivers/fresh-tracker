import { Controller } from "@hotwired/stimulus"
import Quagga from "@ericblade/quagga2"

// Connects to data-controller="barcode"
export default class extends Controller {
  connect() {
    console.log("barcode controller connected")

    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        target: document.querySelector('#cats')    // Or '#yourElement' (optional)
      },
      decoder : {
        readers : ["code_128_reader"]
      }
    }, function(err) {
        if (err) {
            console.log(err);
            return
        }
        console.log("Initialization finished. Ready to start");
        Quagga.start();
    });
    Quagga.onDetected((data) => {
      console.log(data);
    });
  };

}
