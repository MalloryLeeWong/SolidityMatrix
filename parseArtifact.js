const fs = require('fs')

const data = fs.readFileSync("./truffle/build/contracts/Grue.json")
const { abi } = JSON.parse (data.toString())

const solidityVersion = process.argv[2]
const keys = ["name", "constant", "payable", "stateMutability", "type"]

for (let entry of abi) {
  if (entry.type !== 'function') continue
  const row = [solidityVersion]
    .concat(keys.map(k => entry[k] || 'undefined'))
  console.log(row.join(', '))
}
