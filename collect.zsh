#! /usr/bin/env zsh

solcVersions=(
  '0.6.3'
  '0.6.2'
  '0.6.1'
  '0.5.16'
  '0.5.15'
  '0.5.14'
  '0.5.13'
  '0.5.12'
  '0.5.11'
  '0.5.10'
  '0.5.9'
  '0.5.8'
  '0.5.7'
  '0.5.6'
  '0.5.5'
  '0.5.4'
  '0.5.3'
  '0.5.2'
  '0.5.1'
)

function writeTruffleConfig() {
  cat << EOF > truffle/truffle-config.js
module.exports = {
  compilers: {
    solc: {
      version: "$version"
    }
  }
}
EOF
}

# create output file
csvOutput="SolidityVersionAnalysis.csv"
echo "Solidity Version", "name", "constant", "payable", "stateMutability", "type" > $csvOutput
echo "" >> $csvOutput

for version in $solcVersions; do
  writeTruffleConfig $version
  echo $(cd truffle; truffle compile --all)
  node parseArtifact $version >> $csvOutput
done
