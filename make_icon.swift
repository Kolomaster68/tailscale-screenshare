import AppKit

let size: CGFloat = 1024
let img = NSImage(size: NSSize(width: size, height: size))
img.lockFocus()

// macOS-style squircle with standard margins
let inset: CGFloat = 88
let rect = NSRect(x: inset, y: inset, width: size - 2 * inset, height: size - 2 * inset)
let squircle = NSBezierPath(roundedRect: rect, xRadius: 190, yRadius: 190)
NSGradient(colors: [
    NSColor(calibratedRed: 0.09, green: 0.16, blue: 0.32, alpha: 1),
    NSColor(calibratedRed: 0.16, green: 0.36, blue: 0.75, alpha: 1),
])!.draw(in: squircle, angle: 90)

// white display symbol
let cfg = NSImage.SymbolConfiguration(pointSize: 440, weight: .medium)
if let sym = NSImage(systemSymbolName: "display", accessibilityDescription: nil)?
    .withSymbolConfiguration(cfg) {
    let tinted = NSImage(size: sym.size)
    tinted.lockFocus()
    NSColor.white.set()
    let r = NSRect(origin: .zero, size: sym.size)
    sym.draw(in: r)
    r.fill(using: .sourceAtop)
    tinted.unlockFocus()
    let s = tinted.size
    let scale: CGFloat = 560 / max(s.width, s.height)
    let w = s.width * scale, h = s.height * scale
    tinted.draw(in: NSRect(x: (size - w) / 2, y: (size - h) / 2 + 20, width: w, height: h))
}

// three tailscale-ish dots on the screen face
NSColor.white.withAlphaComponent(0.9).set()
let dotR: CGFloat = 34
let y: CGFloat = 560
for i in -1...1 {
    let x = size / 2 + CGFloat(i) * 110 - dotR
    NSBezierPath(ovalIn: NSRect(x: x, y: y, width: dotR * 2, height: dotR * 2)).fill()
}

img.unlockFocus()

let tiff = img.tiffRepresentation!
let png = NSBitmapImageRep(data: tiff)!.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
