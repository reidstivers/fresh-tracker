import { Controller } from "@hotwired/stimulus"
import { BrowserQRCodeReader } from '@zxing/browser';

// Connects to data-controller="barcode"
export default class extends Controller {
 async connect() {
    console.log("testing zebras")
    const codeReader = new BrowserQRCodeReader();

const source = 'https://cdn.britannica.com/57/43857-050-9250A718/bar-code.jpg';
const resultImage = await codeReader.decodeFromImageUrl(source);
// or use decodeFromVideoUrl for videos
  };
}
