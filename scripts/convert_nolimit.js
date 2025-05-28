import * as gamesDataFull from './nolimit'

const s1 = '\\[ \\{ \\} \\] , / \\? : @ & = \\+ \\$ # " \\\\'.split(' ') // '[{}],/\?:@&=\+$#"\ '
const s2 = '%5B%7B%7D%5D%2C%2F%3F%3A%40%26%3D%2B%24%23%22%5C%20'.match(/.{3}/g) // encodeURIComponent('[{,/\?:@&=\+$#"\\ ')
const s3 = '[{}],/\?:@&=\+$#"\\ '.split('')
const key =
  '38a5236d026377c0951d73c729940649791eb61ee800c2300012c7722935b32d91009cb0270ab9ebfcee6f9925f02bc6d5415766a33da37e9f349ba71c5ff4a25cfb9b0b005586971bc1392c4d7ae4cdb8cbc059c27fe0cde1ee0ac714693dbd6b8abae24fd1ba3490645308da6c06ce5e790b6688a1bc6807c07134fcb7abd21623e304e1d5f08aeb80cd066bf230d8c8a04220f599d313ce9f9545a0866dee4c026c8c43bcaeb3b757397f5ad2e30fb3e5400111f265c45605ffa0c11e18480dc4840ce59d6cab8f5fe87ff0fd5de7a98030c0b39afbe9fc24bf1dd21d8744da37821cf4f95d2f141e0daed192cd48e9ed20d9ebb05396f0a0f275b8bd7a388f45a30a4ffa46f3a1a5c9286ead07dfeb0c323eba6d6cbb36c377d10a8705fb8e5a4998429e9ea8cf486f7950868ba932d7f35d25d89e997e0b3cf873d8edd8e329e4507f805f12394867e360a64efac03c52e54338997a0dc0dd6c0cac623aadf11ced8401aa27e4ca111d6d'
s1.push(' ')

function hexDigit(code) {
  if (code >= '0'.charCodeAt(0) && code <= '9'.charCodeAt(0)) {
    return code - '0'.charCodeAt(0)
  } else if (code >= 'A'.charCodeAt(0) && code <= 'F'.charCodeAt(0)) {
    return code + (10 - 'A'.charCodeAt(0))
  } else if (code >= 'a'.charCodeAt(0) && code <= 'f'.charCodeAt(0)) {
    return code + (10 - 'a'.charCodeAt(0))
  } else {
    throw new URIError()
  }
}

function decodeURIComponent(string) {
  const input = String(string)
  let result = ''
  let k = 0
  while (k < input.length) {
    const code = input.charCodeAt(k)
    if (code !== '%'.charCodeAt(0)) {
      result += String.fromCharCode(code)
      k += 1
    } else {
      let octets = []
      while (input.charCodeAt(k) === '%'.charCodeAt(0)) {
        if (k + 3 > input.length) {
          throw new URIError()
        }
        let octet = hexDigit(input.charCodeAt(k + 1)) * 16 + hexDigit(input.charCodeAt(k + 2))
        octets.push(octet)
        k += 3
      }
      const textDecoder = new TextDecoder(undefined, { fatal: true, ignoreBOM: true })
      try {
        result += textDecoder.decode(Uint8Array.from(octets))
      } catch (error) {
        throw new URIError(error)
      }
    }
  }
  return result
}
const HEX_CHARACTERS = '0123456789abcdef'
function toHex(byteArray) {
  const hex = []
  byteArray.forEach((b) => {
    hex.push(HEX_CHARACTERS.charAt((b >> 4) & 0xf))
    hex.push(HEX_CHARACTERS.charAt(b & 0xf))
  })
  return hex.join('')
}
function fromHex(str) {
  if (typeof str !== 'string') return []
  const byteArray = []
  for (let i = 0; i < str.length; i += 2) {
    byteArray.push(parseInt(str.substring(i, i + 2), 16))
  }
  return byteArray
}
function rc4Logic(keyByteArray, inputByteArray) {
  const s = [],
    outputByteArray = []
  let i, j, x
  for (i = 0; i < 256; i++) s[i] = i
  for (i = 0, j = 0; i < 256; i++) {
    j = (j + s[i] + keyByteArray[i % keyByteArray.length]) % 256
    x = s[i]
    s[i] = s[j]
    s[j] = x
  }
  for (let y = 0, i = 0, j = 0; y < inputByteArray.length; y++) {
    i = (i + 1) % 256
    j = (j + s[i]) % 256
    x = s[i]
    s[i] = s[j]
    s[j] = x
    outputByteArray.push(inputByteArray[y] ^ s[(s[i] + s[j]) % 256])
  }
  return outputByteArray
}
function stringToByteArray(str) {
  const encoded = encodeURIComponent(str)
  const byteArray = []
  for (let i = 0; i < encoded.length; i++) {
    if (encoded[i] === '%') {
      byteArray.push(parseInt(encoded.substring(i + 1, i + 3), 16))
      i += 2
    } else {
      byteArray.push(encoded.charCodeAt(i))
    }
  }
  return byteArray
}
function byteArrayToString(byteArray) {
  let encoded = ''
  for (let i = 0; i < byteArray.length; i++) {
    encoded += '%' + ('0' + byteArray[i].toString(16)).slice(-2)
  }
  try {
    console.log(encoded)
    return decodeURIComponent(encoded)
  } catch (e) {
    console.error('Error decoding URI component in byteArrayToString', e)
    // Fallback or re-throw, depending on how you want to handle malformed sequences
    return 'DECODING_ERROR'
  }
}
const rc4Api = {
  encrypt: (key, str) => toHex(rc4Logic(stringToByteArray(key), stringToByteArray(str))),
  decrypt: (key, hexStr) => byteArrayToString(rc4Logic(stringToByteArray(key), fromHex(hexStr))),
}

// LZW Decoding function
function lzwDecode(input) {
  if (!input.startsWith('lzw:')) return input
  input = input.substring('lzw:'.length)
  const dict = {}
  let currChar = input[0]
  let oldPhrase = currChar
  let code = 256
  const output = [currChar]
  for (let i = 1; i < input.length; i++) {
    const currentCode = input.charCodeAt(i)
    let phrase
    if (currentCode < 256) phrase = input[i]
    else if (dict[currentCode]) phrase = dict[currentCode]
    else phrase = oldPhrase + currChar
    output.push(phrase)
    currChar = phrase[0]
    dict[code] = oldPhrase + currChar
    oldPhrase = phrase
  }
  return output.join('')
}

// Read the file
const fs = require('fs')
// const lines = fs.readFileSync('./scripts/nolimit.json', 'utf-8')
import { lines } from './nolimit' //assert { type: 'json' }
// Parse and convert to JSON
console.log(lines.length)
const jsonData = []
// console.log(lines)
let decryptedMessage
let decrypted
console.log(lines[0])
lines.forEach((line) => {
  //   if (!line.startsWith('lzw:')) key = line.trim()
  //   if (!line.startsWith('lzw:')) return line

  //   const match = line.match(/([0-9a-f]+)\s+(\d+)\s+(lzw:.*)/)
  //   console.log(match)
  //   if (match) {
  //   const match = line.split(' ')
  //   console.log(match)
  //   const clientId = match[1]
  //   const spinNumber = parseInt(match[2])
  //   const encryptedMessage = match[3]
  // //   console.log(key)
  //   console.log(line)
  decrypted = rc4Api.decrypt(key, line.data)
  console.log(decrypted)
  if (line.type === 'receive') decryptedMessage = lzwDecode(line.data)
  console.log(decryptedMessage)
  jsonData.push({
    // client_id: clientId,
    // spin_number: spinNumber,
    message: decryptedMessage,
  })
  //   }
})

// Save to JSON file
fs.writeFileSync('./scripts/nolimit.json', JSON.stringify(jsonData, null, 4))
