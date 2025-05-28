function queryToJson(queryString) {
  const params = new URLSearchParams(queryString)
  const result = {}

  for (const [key, value] of params) {
    // Remove commas from numeric strings
    const cleanValue = value.replace(/,/g, '')
    const num = parseFloat(cleanValue)

    if (['sa', 'sb', 's'].includes(key)) {
      result[key] = value.split(',').map(Number)
    } else if (!isNaN(num)) {
      result[key] = num
    } else {
      result[key] = value
    }
  }

  return result
}

// Example usage with the provided input
const input =
  'tw=0.00&balance=99,996.00&index=3&balance_cash=99,996.00&reel_set=0&balance_bonus=0.00&na=s&stime=1748425229149&sa=7,9,9,9,6,6&sb=8,6,3,8,3,7&sh=6&st=rect&c=0.10&sw=6&sver=5&counter=6&ntp=-4.00&l=20&s=6,10,9,5,5,10,7,7,6,9,10,10,10,6,4,7,8,6,9,7,5,8,7,7,5,8,1,9,6,8,8,7,8,5,8,10&w=0.00'
const jsonOutput = queryToJson(input)
console.log(JSON.stringify(jsonOutput, null, 2))
