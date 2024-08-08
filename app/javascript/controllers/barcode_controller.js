import { Controller } from "@hotwired/stimulus"
import Quagga from "@ericblade/quagga2"

// The two versions might not play nice with eachother so you might need to remove one to get the other to work live is commented out

// https://github.com/serratus/quaggaJS?tab=readme-ov-file#gettingstarted The documentation

// Connects to data-controller="barcode"
export default class extends Controller {
  connect() {
    console.log("barcode controller connected")
// this is the live version (needs to be in the connect)
    // Quagga.init({
    //   inputStream : {
    //     name : "Live",
    //     type : "LiveStream",
    //     target: data-barcode-target ='#yourElement'    // this needs to be fixed up and targeted at what you need
    //   },
    //   decoder : {
    //     readers : [
    //         "ean_reader",
    //         "upc_reader",
    //         "ean_8_reader",
    //         "code_128_reader"
    //     ] // these can be changed based on the region (the current readers are for japanese barcodes)
    //   }
    // }, function(err) {
    //     if (err) {
    //         console.log(err);
    //         return
    //     }
    //     console.log("Initialization finished. Ready to start");
    //     Quagga.start();
    // });
    // Quagga.onDetected((data) => {
    //   console.log(data);  //this is the barcode console log
    //   Quagga.stop() //stops the camera after it finds a barcode
    // });

  };

  // This is the uploaded file version of the code

  onUpload(event) {
   const file = event.currentTarget.files[0]
   const url = URL.createObjectURL(file)
    console.log("File uploaded");
    Quagga.decodeSingle({
      decoder: {
        readers: [
          "ean_reader",
          "upc_reader",
          "ean_8_reader",
          "code_128_reader"
      ] // List of active readers
      },
      locate: true, // try to locate the barcode in the image
      src: url
    }, function(result){
      if(result.codeResult) {
        console.log("result", result.codeResult.code); //this is the barcode console log
      } else {
        console.log("not detected");
      }
    });
  }

}
