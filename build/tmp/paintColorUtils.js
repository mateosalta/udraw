var hexChars = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];

function pointToHl(xRatio,yRatio) {
    var hue = 0.5 + Math.atan2(yRatio,xRatio) / (Math.PI*2)
    var light = 1 - (Math.sqrt((Math.pow(xRatio,2)+0.0001)+(Math.pow(yRatio,2)+0.0001)) / (colorChart.height/2));
    return { pointHue: hue, pointLight: light }
}

function hltoPoint(h,l) {
    var yRatio = (1-l)*Math.sin(h*Math.PI*-2);
    var xRatio = (1-l)*Math.cos(h*Math.PI*-2);
    return { hlX: xRatio, hlY: yRatio }
}

function hexToColor(hexcolor,isThree) {
    hexcolor = String(hexcolor);
    var strLen = isThree ? 1 : 2;

    console.log(strLen,"g:"+hexcolor.substr(strLen,strLen),">",parseInt(hexcolor.substr(strLen,strLen),16))
    var r = parseInt(hexcolor.substr(0,strLen),16) * (isThree?17:1);
    var g = parseInt(hexcolor.substr(strLen,strLen),16) * (isThree?17:1);
    var b = parseInt(hexcolor.substr((strLen*2),strLen),16) * (isThree?17:1);
    return { hexR: r, hexG: g, hexB: b }
}

function valToHex(x) {
    firstChar = hexChars[Math.floor(x/16)];
    secondChar = hexChars[x%16];
    return (firstChar + secondChar)
}

function rgbToHex(r,g,b) {
    var hexR = valToHex(r);
    var hexG = valToHex(g);
    var hexB = valToHex(b);
    return (hexR+hexG+hexB);
}

function rgbToHsl(r, g, b){
    r = r/255;
    g = g/255;
    b = b/255;
    var max = Math.max(r, g, b);
    var min = Math.min(r, g, b);
    var h, s = max;

    var d = max - min;
    s = max == 0 ? 0 : d / max;

    if(max == min){
        h = 0;
    }else{
        switch(max){
            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
            case g: h = (b - r) / d + 2; break;
            case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
    }

    var l = (max + min)/2;
    console.log(h,s,l);

    return { rgbHue: h, rgbSat: s, rgbLight: l };
}

function hslToRgb(h, s, l){
    var r, g, b;

    var i = Math.floor(h * 6);
    var f = h * 6 - i;
    var p = v * (1 - s);
    var q = v * (1 - f * s);
    var t = v * (1 - (1 - f) * s);

    switch(i % 6){
        case 0: r = v; g = t; b = p; break;
        case 1: r = q; g = v; b = p; break;
        case 2: r = p; g = v; b = t; break;
        case 3: r = p; g = q; b = v; break;
        case 4: r = t; g = p; b = v; break;
        case 5: r = v; g = p; b = q; break;
    }

    return { hslR: r*255, hslG: g*255, hslB: b*255 };
}
