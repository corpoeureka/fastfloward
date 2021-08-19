// Crearemos una imagen en donde se encenderan
// y se apagaran pixeles para representar una 
// imagen en un rectangulo. Los "." representan
// pixeles apagados mientras que los "*" son 
// aquellos que estan encendidos
// *...*
// .*.*.
// ..*..
// .*.*.
// *...* 

pub struct Canvas {
    
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
        self.width = width
        self.height = height
        // La cadena de pixels estara formada
        // de forma serializada
        // del 1 al 9
        // se representa
        // 123
        // 456
        // 789
        // pero en la cadena se vera
        // 123456789
        self.pixels = pixels
    }

}



pub fun serializeStringArray(_ lines: [String]): String {
    var buffer = ""
    for line in lines {
        buffer = buffer.concat(line)
    }
    return buffer
}

// displays a canvas in a frame.

pub fun display(canvas: Canvas) {
  let len = canvas.pixels.length;
  var i = 0;
  var header_arr: [String] = ["+", "+"];
  while i < Int(canvas.width) {
    header_arr.insert(at: 1, "-");
    i = i + 1;
  }
  let header: String = serializeStringArray(header_arr);

  log(header);
  i = 0;
  while i < len {
    log(
      "|"
      .concat(canvas.pixels.slice(from: i, upTo: i + Int(canvas.width)))
      .concat("|")
    )
    i = i + Int(canvas.height);
  }
  log(header)
}


pub resource Picture {
    pub let canvas: Canvas

    init(canvas: Canvas){
        self.canvas = canvas
    }  
}


pub resource Printer {
  priv var pics: {String: Bool};

  init() {
    self.pics = {};
  }

  pub fun print(canvas: Canvas): @Picture? {
    if (!self.pics.containsKey(canvas.pixels)) {
      self.pics[canvas.pixels] = true;
      display(canvas: canvas);
      let pic <- create Picture(canvas: canvas);
      return <- pic;
    } else {
      log("Duplicated picture, printer ignored...");
      return nil;
    }
  }
}


pub fun main() {
    let pixelsX1 = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *" 
    ]
    let canvasX1 = Canvas(
        width: 5,
        height: 5,
        pixels:serializeStringArray(pixelsX1)
    )

    let pixelsX2 = [
        "  *  ",
        "  *  ",
        "*****",
        "  *  ",
        "  *  "
    ]
    let canvasX2 = Canvas(
        width: 5,
        height: 5,
        pixels:serializeStringArray(pixelsX2)
    )
    let pixelsX3 = [
        "    *",
        "    *",
        "    *",
        "*   *",
        "*****"
    ]
    let canvasX3 = Canvas(
        width: 5,
        height: 5,
        pixels:serializeStringArray(pixelsX3)
    )

    

//    let letterX <- create Picture(canvas: canvasX)
//    log(letterX.canvas)
//    destroy letterX


let printer <- create Printer();
  let pic1 <- printer.print(canvas: canvasX1);
  let pic2 <- printer.print(canvas: canvasX2);
  let pic3 <- printer.print(canvas: canvasX3);

  destroy pic1;
  destroy pic2;
  destroy pic3;
  destroy(printer);

}
